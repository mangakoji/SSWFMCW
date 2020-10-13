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
    , `out `w       TXSP_o
    , `out `w       MIC_CK_o
    , `in tri0[1:0] MIC_DATs_i
    ,  `out `w[1:0] HEAD_PHONEs_o ;
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
            ADD_Ds <= 0 ;
            DN_XUP <= 1'b0 ;
        `e else
        `b  if(~DN_XUP)
            `b  if(ADD_Ds >= {ADD_MAX,12'h0})
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
    'w `s[11:0] COS_WAVEs ;
    'w `s[11:0] SIN_WAVEs ;
    'w `s[11:0] cos_ctr_s = 
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
            , .SIN_o        ( SIN_WAVEs         )//2's -h800 0 +h800
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
    `a TXSP_o = TX_Dss[12] ;
    
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
        `b  if(&(MIC_CTRs|~(3'd5))
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
        genvar gi l
        for(gi=0;gi<2;gi=gi+1)
        `b
            // MIC IF
            `r[1:0] MIC_Ds
            `ack
                `xar
                    MIC_Ds <= 0 ;
                else
                    if(MIC_EE)
                        MIC_Ds <= {MIC_Ds,MICs_i[gi] ;
            `r`s[24:0]IIRs_COS ;
            `r`s[24:0]IIRs_SIN ;
            // MIC_IIR // for test
                    if
                    (MIC_Ds[1])
            `w`s[25:0] COS_diff_s =
                    (MIC_Ds[1])
                    ?   ($`s(IIRs_COS[24:13]) + $`s(COS_WAVEs))
                    :   ($`s(IIRs_COS[24:13]) - $`s(COS_WAVEs)) 
            ;
            `w`s[25:0] SIN_diff_s =
                    (MIC_Ds[1])
                    ?   ($`s(IIRs_SIN[24:13]) + $`s(SIN_WAVEs))
                    :   ($`s(IIRs_SIN[24:13]) - $`s(SIN_WAVEs)) 
            ;
            // fc=983Hz = 48MHz/((2**13)*2*pi)
            `ack
                `xar
                `b      IIRs_COS <= 1<<24 ;
                        IIRs_SIN <= 1<<24 ;
                `e 
                `b
                        IIRs_COS <= $`s(IIRs_COS) + $`s(COS_diff_s[25:13]) ;
                        IIRs_SIN <= $`s(IIRs_SIN) + $`s(SIN_diff_s[25:13]) ;
                `e
            `w[21:0] COS_squ_s = $`s(IIRs_COS[24:13]) * $`s(IIRs_COS[24:13]) ;
            `w[21:0] SIN_squ_s = $`s(IIRs_SIN[24:13]) * $`s(IIRs_SIN[24:13]) ;
            `ack
                `xar
                `b
                `e else
                `b 
                    COS_SQU <= COS_squ_s[21:0] ;             // /22
                    SIN_SQU <= SIN_squ_s[21:0] ;             // /22
                    SQUs <= {1'b0,SIN_SQU} + {1'b0,COS_SQU} ;// /23
                `e
            SQRT
                SQRT
                (
                      .CK_i     ( CK_i      )
                    , .XARST_i  ( XARST_i   )
                    , .DATs_i   ( SQUs      )
                    , .QQs_o    ( RMSs      ) //12
                ) 
            ;
            `r[12:0] DSs ;
            `ack
                `xar
                    DSs <= 13'b1_1000_0000_0000 ;
                else
                    DSs <= {1'b0 ,DSs[11:0]} + {RMSs[10:0]} ;
            `a HEAD_PHONEs_o[gi] = PHONEs[10] ;
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

    
    `w    TXD ;
    `w    CMP_o   ;
    SSWFMCW
        SSWFMCW_TX
        (
              .CK_i             ( CK_i         )
            , .XARST_i          ( XARST_i      )
            , .CK_EE_i          ( CK_EE_i      )
            , .RXD_i            ()
            , .BUS_RX_MODE_i    ( 1'b0         )
            , .TXD_o            ( TXD           )
            , .CMP_o            ()
        ) 
    ;
    SSWFMCW
        SSWFMCW_RX
        (
              .CK_i             ( CK_i          )
            , .XARST_i          ( XARST_i       )
            , .CK_EE_i          ( CK_EE_i       )
            , .RXD_i            ( TXD           )
            , .BUS_RX_MODE_i    ( 1'b1          )
            , .TXD_o            ()
            , .CMP_o            ( CMP_o         )
        ) 
    ;

    integer ii ;
    initial
    `b
        for(ii=0;ii<=2**9;ii=ii+1)
        `b
            repeat(10) @(posedge CK_i) ;
        `e
        repeat(100) @(posedge CK_i) ;
        $stop ;
        $finish ;
    `e
endmodule
