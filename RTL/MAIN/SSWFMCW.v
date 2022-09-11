// SSWFMCW.v
//  SSWFMCW()
//
//
//KB1s :chg charp mode triangle -> up+blank
//KAIu :add COS out
//KAHs :may be done
//KABu :start wt RTL


`ifndef SSWFMCW
    `ifndef FPGA_COMPILE
        `include "../MISC/SIN_S11_S11.v"
    `endif
    `include "../MISC/define.vh"
    `default_nettype none
module SSWFMCW
(
      `in`tri1      CK_i          //48MHz
    , `in`tri1      XARST_i
    , `out`w        TXSP_o
    , `out`w[11:0]  TX_COS_WAVEs_o //ofs
    , `out`w        MIC_CK_o
    , `in`tri0[1:0] MICs_DAT_i
    , `out`w[1:0]   HEAD_PHONEs_o 
) ;             
    `func `int log2 ;
        `in `int value ;
        `b  value = value-1;
            for(log2=0; value>0; log2=log2+1)
                value = value>>1;
        `e 
    `efunc
    // charp sweep
    // C_ADD_MAX - C_ADD_MIN = 700
    `lp C_ADD_MIN = 13631 ;
    `lp C_ADD_MAX = 14331 ;
    `lp C_ADD_TOP = 2*C_ADD_MAX - C_ADD_MIN ;
    `r[13+12:0] ADD_Ds ;
    `r       TX_EE ;
    // cycle:TX_EE=fck/(C_ADD_MAX-C_ADD_MIN)/(1<<12)/2 = 8.37Hz
    // target distance : 10.2m 
    `ack`xar
    `b      ADD_Ds <= C_ADD_MIN<<12 ;
            TX_EE <= 1'b1 ;
    `e else
    `b  
        if(ADD_Ds >= {C_ADD_MAX,12'h0})//26'h37F_B000
                                        TX_EE <= 1'b0 ;
        if(ADD_Ds >= {C_ADD_TOP,12'h0})//26'h353_F000
        `b                              TX_EE <= 1'b1 ;
                                        ADD_Ds <= {C_ADD_MIN,12'h0} ;
        `e else
                                        `inc( ADD_Ds ) ;
    `e
    // wave gen
    `r[23:0] WAVE_CTRs ;
    `ack
        `xar
            WAVE_CTRs <= 0 ;
        else
                                        //ADD_D14bit
                                        WAVE_CTRs <= 
                                            WAVE_CTRs + ADD_Ds[25:12] ; 
    // sin wave gen
    // fmax = (fck>>12)*(C_ADD_MAX>>12) = 41.0kHz
    // fmin = (fck>>12)*(C_ADD_MIN>>12) = 39.0kHz
    `w`s[11:0] COS_WAVEs ;
    SIN_S11_S11
        COS_TBL
        (     .CK_i         ( CK_i              )
            , .XARST_i      ( XARST_i           )
            , .DATs_i       ( WAVE_CTRs[23:12]  )//2's -h800 0 +7FFF
            , .SINs_o       ( COS_WAVEs         )//2's -h7FF 0 +h7FF
        )
    ;
    `r`s[11:0] TX_COS_WAVEs ;
    `ack`xar            TX_COS_WAVEs <= 0 ;
        else if(TX_EE)                  TX_COS_WAVEs <= COS_WAVEs ;
        else                            TX_COS_WAVEs <= 0 ;
    // TX SP DS ;
    `r[12:0]  TXSP_DSs; // /13
    `ack`xar    TXSP_DSs <= 13'b1_1000_0000_0000 ;
    else                                TXSP_DSs <= 
                                            {1'b0 , TXSP_DSs[11:0]} 
                                            + 
                                            {
                                                1'b0 
                                                , ~ TX_COS_WAVEs[11] 
                                                , TX_COS_WAVEs[10:0]
                                            } 
                                        ;
    `a TXSP_o = TXSP_DSs[12] ;
    `a TX_COS_WAVEs_o = {TX_COS_WAVEs[11],TX_COS_WAVEs[10:0]} ;
    
    // MIC_CLOCK
    `r[2:0]MIC_CTRs ;
    `r MIC_CK ;         //4.0MHz
    `r MIC_EE ;
    `ack`xar
    `b  MIC_CTRs <= 0 ;
        MIC_CK <= 1'b0 ;
         MIC_EE <= 1'b0 ;
    `e else
    `b  
        if(&(MIC_CTRs|~(3'd5)))
       `b                               MIC_CTRs <= 0;
                                        MIC_CK <= ~ MIC_CK ;
       `e else                          `inc( MIC_CTRs ) ;

                                        MIC_EE <= 
                                            (MIC_CTRs==3'd4) 
                                            & 
                                            ~MIC_CK 
                                        ;
   `e
    `a MIC_CK_o = MIC_CK ;
    // HeadPhone DS
    `gen
        `gv gi ;
        `fori(gi,2)
        `b :g_PHONE
            // MIC IF
            `r[1:0] MIC_Ds ;
            `ack`xar    MIC_Ds <= 0 ;
             else 
                if(MIC_EE)          MIC_Ds <= {MIC_Ds,MICs_DAT_i[gi]} ;
            `r[12:0] EP_DSs ;
            `ack`xar    EP_DSs <= 13'b1_1000_0000_0000 ;
            else
                                    EP_DSs <= 
                (MIC_Ds[1])
                ?
                                    ({1'b0 ,EP_DSs[11:0]} 
                                        + 
                                        {~COS_WAVEs[11],COS_WAVEs[10:0]}
                                        )
                :                   ({1'b0 ,EP_DSs[11:0]} 
                                        + 
                                        {COS_WAVEs[11],~COS_WAVEs[10:0]}
                                    )
                                    ;
            `a HEAD_PHONEs_o[gi] = EP_DSs[12] ;
        `e
    `egen
endmodule
    `define SSWFMCW
`endif

`ifundef FPGA_COMPILE
    `ifndef TB_SSWFMCW
    `include "../MISC/define.vh"
    `timescale 1ns/1ns
module TB_SSWFMCW
#(  parameter C_C=10.0
)(
) ;
    `r CK_i ;
    `r CK_EE_i ;
    initial `b
        CK_i <= 1'b1 ;
        CK_EE_i <= 1'b1 ;
        forever begin
            #(C_C/2.0)
                CK_i <= ~ CK_i ;
        end
    end
    `r XARST_i ;
    initial begin
        XARST_i <= 1'b1 ;
        #(0.1 * C_C)
            XARST_i <= 1'b0 ;
        #(3.1 * C_C)
            XARST_i <= 1'b1 ;
    end

    `w      TXSP_o          ;
    `w      MIC_CK_o        ;
    `r[1:0] MICs_DAT        ;
    `w[1:0] HEAD_PHONEs_o   ;
    SSWFMCW
        SSWFMCW
        (
              .CK_i             ( CK_i          )//48MHz
            , .XARST_i          ( XARST_i       )
            , .TXSP_o           ( TXSP_o        )
            , .MIC_CK_o         ( MIC_CK_o      )
            , .MICs_DAT_i       ( MICs_DAT      )
            , .HEAD_PHONEs_o    ( HEAD_PHONEs_o )
        ) 
    ;
    // 48MHz/2/pi/256=29.841kHz
    `r[21:0] TX_IIRs ;
    `w `s[14:0] TX_diff_s = {1'b0, {14{TXSP_o}}} - {1'b0 ,TX_IIRs[21:8]} ;
    `ack`xar
            TX_IIRs <= 22'h20_0000 ;
        else
            TX_IIRs <= `Ds({1'b0,TX_IIRs}) + `Ds( TX_diff_s ) ;
    `r MIC_CK_D ;
    `ack`xar
            MIC_CK_D <= 1'b0 ;
        else
            MIC_CK_D <= MIC_CK_o ;
    `w MIC_CK_EE = ~MIC_CK_o & MIC_CK_D ;
    `r[14:0]MIC_DSs ;
    `ack`xar
            MIC_DSs <= 0 ;
        else if( MIC_CK_EE )
            MIC_DSs <= {1'b0 , MIC_DSs[13:0]} + {1'b0,TX_IIRs[21:8]} ;

    //1m -> 1/340[m/s]=2.94ms=> 2.94ms*48MHz=144,117ck
    //2m -> 288,286ck
    `r [288_235:0] DLYs ;
    `ack`xar
            DLYs <= 0 ;
        else
            DLYs <= {DLYs,MIC_DSs[14]} ;
    `w CH0 = DLYs[144_116] ;
    `w CH1 = DLYs[288_235] ;

    `w[7:0]PHONEs_LPFED [0:1];
    `gen`b 
        genvar gi;
        for(gi=0;gi<2;gi=gi+1)
        `b :gen_PHONE
            `r[15:0] PHONE_IIRs ;
            `ack`xar    PHONE_IIRs <= 0;
                else    PHONE_IIRs <= 
                            `Ds({1'b0 , PHONE_IIRs}) 
                            + `Ds(
                                {1'b0,{8{HEAD_PHONEs_o[gi]}}}
                                - {1'b0,PHONE_IIRs[15:8]}
                            )
                        ;
            `a PHONEs_LPFED[gi] = PHONE_IIRs[15:8] ;
        `e
    `e`egen 

    integer hh,vv,ff ;
    initial
    `b  force MICs_DAT = {CH1,CH0} ;
        repeat(100) @(`pe CK_i) ;
        for(ff=0;ff<=6;ff=ff+1)
        `b  for(vv=0;vv<=100;vv=vv+1)
            `b  for(hh=0;hh<=10_000;hh=hh+1)
                `b  @(posedge CK_i) ;
                `e
            `e
        `e
        repeat(100) @(posedge CK_i) ;
        $stop ;
        $finish ;
    `e
endmodule
        `define TB_SSWFMCW
    `endif
`endif