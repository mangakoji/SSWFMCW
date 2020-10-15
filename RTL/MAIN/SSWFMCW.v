// SSWFMCW.v
//  SSWFMCW()
//
//
//J6Ts  :start wt RTL

`include "../MISC/define.vh"
`ifndef FPGA_COMPILE
    `include "../MISC/SQRT.v"
    `include "../MISC/sin_tbl_s11_s11.v"
`endif
`default_nettype none
module SSWFMCW
(
      `in tri0      CK_i          //48MHz
    , `in tri1      XARST_i
    , `in tri1      CK_EE_i
    , `out`w       TXSP_o
    , `out`w       MIC_CK_o
    , `in tri0[1:0] MICs_DAT_i
    , `out`w[1:0] HEAD_PHONEs_o 
) ;
    `func `int log2 ;
        `in `int value ;
    `b
        value = value-1;
        for (log2=0; value>0; log2=log2+1)
            value = value>>1;
    `e `efunc
    // charp sweep
    `lp C_ADD_MAX = 14331 ;
    `lp C_ADD_MIN = 13631 ;
    `r[13+12:0] ADD_Ds ;
    `r       DN_XUP ;
    `ack
        `xar
        `b
            ADD_Ds <= C_ADD_MIN<<12 ;
            DN_XUP <= 1'b0 ;
        `e else
        `b  if(~DN_XUP)
            `b  if(ADD_Ds >= {C_ADD_MAX,12'h0})
                `b  DN_XUP <= 1'b1 ;
                    ADD_Ds <= ADD_Ds -1 ;
                `e else
                    ADD_Ds <= ADD_Ds + 1 ;
            `e else
            `b  if(ADD_Ds <= {C_ADD_MIN,12'h0})
                `b  DN_XUP <= 1'b0 ;
                    ADD_Ds <= ADD_Ds + 1 ;
                `e else
                    ADD_Ds <= ADD_Ds - 1 ;
            `e
        `e
    // wave gen
    `r[23:0] WAVE_CTRs ;
    `ack
        `xar
            WAVE_CTRs <= 0 ;
        else
            WAVE_CTRs <= WAVE_CTRs + ADD_Ds[25:12] ; //ADD_D14bit
    // sin wave gen
    `w`s[11:0] COS_WAVEs ;
    `w`s[11:0] SIN_WAVEs ;
    `w`s[11:0] cos_ctr_s = 
                    { 
                          ~( ^ WAVE_CTRs[23:22])
                        , ~    WAVE_CTRs[22]
                        ,      WAVE_CTRs[21:12]
                    }
    ;
    SIN_TBL_s11_s11 
        COS_TBL
        (
              .CK_i         ( CK_i              )
            , .XARST_i      ( XARST_i           )
            , .DAT_i        ( cos_ctr_s         )//2's -h800 0 +7FFF
            , .SIN_o        ( COS_WAVEs         )//2's -h800 0 +h800
        )
    ;
    SIN_TBL_s11_s11 
        SIN_TBL
        (
              .CK_i         ( CK_i              )
            , .XARST_i      ( XARST_i           )
            , .DAT_i        ( WAVE_CTRs[23:12]  )//2's -h800 0 +7FFF
            , .SIN_o        ( SIN_WAVEs         )//2's -h800 0 +h800
        )
    ;
    // TX SP DS ;
    `r[12:0]  TXSP_DSs; // /13
    `ack
        `xar
            TXSP_DSs <= 13'b1_1000_0000_0000 ;
        else
            TXSP_DSs <= 
                  {1'b0 ,TXSP_DSs[11:0]} 
                + {~COS_WAVEs[11],COS_WAVEs[10:0]} 
            ;
    `a TXSP_o = TXSP_DSs[12] ;
    
    // MIC_CLOCK
    `r[2:0]MIC_CTRs ;
    `r MIC_CK ;         //4.0MHz
    `r MIC_EE ;
    `ack
        `xar
        `b  MIC_CTRs <= 0 ;
            MIC_CK <= 1'b0 ;
            MIC_EE <= 1'b0 ;
        `e else
        `b  if(&(MIC_CTRs|~(3'd5)))
            `b  MIC_CTRs <= 0;
                MIC_CK <= ~ MIC_CK ;
                MIC_EE <= MIC_CK ;
            `e else
            `b  MIC_CTRs <= MIC_CTRs + 1 ;
                MIC_EE <= 1'b0 ;
            `e
        `e
    `a MIC_CK_o = MIC_CK ;
    // HeadPhone DS
    `gen
        genvar gi ;
        for(gi=0;gi<2;gi=gi+1)
        `b :g_PHONE
            // MIC IF
            `r[1:0] MIC_Ds ;
            `ack
                `xar
                    MIC_Ds <= 0 ;
                else
                    if(MIC_EE)
                        MIC_Ds <= {MIC_Ds,MICs_DAT_i[gi]} ;
            `r`s[24:0]IIRs_COS ;
            `r`s[24:0]IIRs_SIN ;
            // MIC_IIR // for test
            `w`s[25:0] COS_diff_s =
                    (MIC_Ds[1])
                    ?   (`Ds(IIRs_COS[24:13]) + `Ds(COS_WAVEs))
                    :   (`Ds(IIRs_COS[24:13]) - `Ds(COS_WAVEs)) 
            ;
            `w`s[25:0] SIN_diff_s =
                    (MIC_Ds[1])
                    ?   (`Ds(IIRs_SIN[24:13]) + `Ds(SIN_WAVEs))
                    :   (`Ds(IIRs_SIN[24:13]) - `Ds(SIN_WAVEs)) 
            ;
            `r`s[12:0] COS_DIFFs ;
            `r`s[12:0] SIN_DIFFs ;
            // fc=983Hz = 48MHz/((2**13)*2*pi)
            `ack
                `xar
                `b  COS_DIFFs <= 0 ;
                    SIN_DIFFs <= 0 ;
                    IIRs_COS <= 0 ;
                    IIRs_SIN <= 0 ;
                `e else
                `b  COS_DIFFs <= COS_diff_s[25:13] ;
                    SIN_DIFFs <= SIN_diff_s[25:13] ;
                    IIRs_COS <= `Ds(IIRs_COS) + `Ds(COS_DIFFs) ;
                    IIRs_SIN <= `Ds(IIRs_SIN) + `Ds(SIN_DIFFs) ;
                `e
            `w[21:0] COS_squ_s = `Ds(IIRs_COS[24:13]) * `Ds(IIRs_COS[24:13]) ;
            `r[21:0] COS_SQUs ;
            `w[21:0] SIN_squ_s = `Ds(IIRs_SIN[24:13]) * `Ds(IIRs_SIN[24:13]) ;
            `r[21:0] SIN_SQUs ;
            `r[22:0] SQUs ;
            `ack
                `xar
                `b  COS_SQUs <= 0 ;
                    SIN_SQUs <= 0 ;
                    SQUs    <= 0 ;
                `e else
                `b  COS_SQUs <= COS_squ_s[21:0] ;             // /22
                    SIN_SQUs <= SIN_squ_s[21:0] ;             // /22
                    SQUs <= {1'b0,SIN_SQUs} + {1'b0,COS_SQUs} ;// /23
                `e
            `w[11:0] RMSs ;
            SQRT
                SQRT
                (     .CK_i     ( CK_i      )
                    , .XARST_i  ( XARST_i   )
                    , .DATs_i   ( SQUs      )
                    , .QQs_o    ( RMSs      ) //12
                ) 
            ;
            `r[12:0] EP_DSs ;
            `ack
                `xar
                    EP_DSs <= 13'b1_1000_0000_0000 ;
                else
                    EP_DSs <= {1'b0 ,EP_DSs[11:0]} + {RMSs[10:0]} ;
            `a HEAD_PHONEs_o[gi] = EP_DSs[10] ;
        `e
    `egen
endmodule


`timescale 1ns/1ns
module TB_SSWFMCW
#(
    parameter C_C=10.0
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

    integer hh,vv,ff ;
    initial
    `b
        MICs_DAT <= 2'b11 ;
        repeat(100) @(`pe CK_i) ;
        for(ff=0;ff<=1;ff=ff+1)
        `b  for(vv=0;vv<=2**10;vv=vv+1)
            `b  for(hh=0;hh<=2**10;hh=hh+1)
                `b  @(posedge CK_i) ;
                `e
            `e
        `e
        repeat(100) @(posedge CK_i) ;
        $stop ;
        $finish ;
    `e
endmodule
