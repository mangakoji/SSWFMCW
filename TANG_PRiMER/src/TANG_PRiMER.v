// TANG_PRiMER.v
// AnLogic FPGA IDE Tang Dynasty
// KAJm : mod for SSWFMCW
// K3Fu :1st

`default_nettype none
`include "../../RTL/MISC/define.vh"
module TANG_PRiMER
(
      `in `w CK24M_i
    , `in `w zUSR_KEY_i
    , `out `w zLED_R_o
    , `out `w zLED_G_o
    , `out `w zLED_B_o
    , `io `w J2_01 //B5_P
    , `io `w J2_02 //     B24_N
    , `io `w J2_03 //B5_N
    , `io `w J2_04 //     B24_P
    , `io `w J2_05 //B19_P
    , `io `w J2_06 //     B31_P
    , `io `w J2_07 //B19_N
    , `io `w J2_08 //     B21_N
    , `io `w J2_09 //B20_P
    , `io `w J2_10 //     B10_N
    , `io `w J2_11 //B20_N
    , `io `w J2_12 //     B10_P
    , `io `w J2_13 //B18_P
//    , `io `w J2_14 //    B11_N   GND//
    , `io `w J2_15 //B18_N
    , `io `w J2_16 //     B11_P
    , `io `w J2_17 //B16_N
    , `io `w J2_18 //      B14_P
    , `io `w J2_19 //B16_P
    , `io `w J2_20 //     B14_N
    , `io `w J2_21 //B17_N
    , `io `w J2_22 //     B15_P
    , `io `w J2_23 //B17_P
    , `io `w J2_24 //      B15_N
    , `io `w J2_25 //B8_N
    , `io `w J2_26 //     B13_p
    , `io `w J2_27 //B8_P
    , `io `w J2_28 //      B13_N
    , `io `w J2_29 //B7_P
    , `io `w J2_30 //     B1_P
    , `io `w J2_31 //B7_N
//    , `io `w J2_32 //      B1_N   GND//
    , `io `w J2_33 //L9_P zUART1_TX
//    , `io `w J2_34 //     JTAG_TMS
    , `io `w J2_35 //L9_N zUART2_TX
//    , `io `w J2_36 //     JTAG_TCK
    , `io `w J2_37 //L4_N zSPI2_MOSI SWCLK
//    , `in `w J2_38 //     JTAG_TDO    //force Z
    , `io `w J2_39 //L2_P zSPI2_MISO SWDAT
//    , `io `w J2_40 //     JTAG_TDI
                    
    , `io `w J3_01 //R22_N
    , `io `w J3_02 //     R19_N   zTP_SCL
    , `io `w J3_03 //R22_P
    , `io `w J3_04 //     R19_P   zTP_SDA
    , `io `w J3_05 //R23_P
    , `io `w J3_06 //     T3_P
    , `io `w J3_07 //R23_N
    , `io `w J3_08 //     T3_N
    , `io `w J3_09 //T2_P
    , `io `w J3_10 //     T11_N
    , `io `w J3_11 //T2_N
    , `io `w J3_12 //     T11_P
    , `io `w J3_13 //T6_P
//    , `io `w J3_14 //     T12_N     GND
    , `io `w J3_15 //T6_N
    , `io `w J3_16 //     T12_P
    , `io `w J3_17 //T8_P
    , `io `w J3_18 //     T17_P zADC1
    , `io `w J3_19 //T8_N
    , `io `w J3_20 //     T17_N zADC3
    , `io `w J3_21 //T13_N
    , `io `w J3_22 //           zADC2
    , `io `w J3_23 //T13_P
    , `io `w J3_24 //           zADC0
    , `io `w J3_25 //T16_N
    , `io `w J3_26 //     T18_N zADC6   M1
    , `io `w J3_27 //T16_P
    , `io `w J3_28 //     T18_P zADC5
    , `io `w J3_29 //T15_N
    , `io `w J3_30 //     T19_N zADC7
    , `io `w J3_31 //T15_P
//    , `io `w J3_32 //}     T19_P zADC4     GND
    , `io `w J3_33 //L5_P  zUART2_TX
//    , `io `w J3_34 //                  VB0
    , `io `w J3_35 //L5_N  zUART2_RX
//    , `io `w J3_36 //                  3V3
    , `io `w J3_37 //T10_P zSPI_SCK
//    , `io `w J3_38 //                  5V
    , `io `w J3_39 //L4_P  zSPI2_NSS
//    , `io `w J3_40 //                  GND

    // TF_CARD J6
    // FLASH NOR U3
    // FLASH NAND U4
    // touch sensor U8

    // DVP_CSI port

    , `io `w[7:0] zCSI_D
    , `io `w    zCSI_PCLK
    , `io `w    zCSI_XCLK
    , `io `w    zCSI_HREF
    , `io `w    zCSI_VSYNC
    , `io `w    zCSI_PWDN
    , `io `w    zCSI_RST
    , `io `w    zCSI_SOIC
    , `io `w    zCSI_SOID

    //MiPi LCD
    , `io `w[7:0] zLCD_R
    , `io `w[7:0] zLCD_G
    , `io `w[7:0] zLCD_B
    , `io `w    zLCD_CLK   
    , `io `w    zLCD_HSYNC 
    , `io `w    zLCD_VSYNC 
    , `io `w    zLCD_DEN   
    , `io `w    zLCD_PWM
) ;
    `define a assign
    `define b begin
    `define e end
    `define al always
    `define pe posedge 
    `define ne negedge
    `define a assign

    `w CK48M    ;
    `w CK135M   ;
    `w PLL_LOCKED ;
    PLL
        PLL
        (
              .refclk       ( CK24M_i)
//            , .reset        ()
            , .clk0_out     ( CK135M     )
            , .clk1_out     ( CK48M     ) //
            , .extlock      ( PLL_LOCKED )
        )
    ;
    `lp C_F_CK = 48_000_000 ;

    `r[2:0]XRST_48M_Ds ;
    `al@(`pe CK48M or `ne PLL_LOCKED)
        if( ~ PLL_LOCKED)
            XRST_48M_Ds <= 0 ;
        else
            XRST_48M_Ds <= {XRST_48M_Ds,1'b1} ;
    `w XARST_48M = XRST_48M_Ds[2] ;

    `w          T_TXSP_o        ;
    `w[11:0]    TX_COS_WAVEs_o  ;//ofs
    `w          MIC_CK_o        ;
    `w[1:0]     MICs_DAT_i      ;
    `a MICs_DAT_i = {J2_02 , J2_04} ;
    `w[1:0]     HEAD_PHONEs_o  ;
    SSWFMCW
        SSWFMCW
        (
              .CK_i             ( CK48M             )//48MHz
            , .XARST_i          ( XARST_48M         )
            , .TXSP_o           ( T_TXSP_o          )
            , .TX_COS_WAVEs_o   ( TX_COS_WAVEs_o    )//ofs
            , .MIC_CK_o         ( MIC_CK_o          )
            , .MICs_DAT_i       ( MICs_DAT_i        )
            , .HEAD_PHONEs_o    ( HEAD_PHONEs_o     )
        ) 
    ;
    `w TX_SP_o = TX_COS_WAVEs_o[11] ;
    `a J3_02 = TX_SP_o ;
    `a J2_06 = T_TXSP_o ;
    `a {J2_08 , J2_10} = HEAD_PHONEs_o ;

//    assign zLED_R_o = ~ tempo_led ;
//    assign zLED_G_o = ~ test_score_led[0]   ;
//    assign zLED_B_o = ~ timing_1ms ;

    `include "MISC/TIMESTAMP.v"
    `w[8*128-1:0] BJO_REGss ;
    `w[8*128-1:0] BJ_REGss ;
    `a BJO_REGss[8*(128-4) +: 32] =  C_TIMESTAMP ;
    `r[25:0] BLINK_CTRs ;
    `a BJO_REGss[17:0]          = BLINK_CTRs[25:20] ;
//    `a BJO_REGss = ~0 ;
    JTAG_REGS
        JTAG_REGS
        (
              .CK_i     ( CK48M         )
            , .XARST_i  ( XARST_48M     )
            , .CK_EE_i  ( 1'b1          )
            , .DATss_i  ( BJO_REGss     )
            , .REGss_o  ( BJ_REGss      )
        ) 
    ;
    `r [6:0] REG_CTRs ;
    `al@(`pe CK48M or `ne XARST_48M)
        if( ~ XARST_48M)
            REG_CTRs <= 0 ;
        else
            REG_CTRs <= REG_CTRs + 1 ;
    `r[7:0] REG_SGMs ;
    `al@(`pe CK48M or `ne XARST_48M)
        if( ~ XARST_48M)
            REG_SGMs <= 0 ;
        else
            REG_SGMs <= REG_SGMs + (BJ_REGss >> (REG_CTRs*8)) ;
    `a J2_12 = ^ REG_SGMs ;
    `al@(`pe CK48M or `ne XARST_48M)
        if( ~ XARST_48M )   BLINK_CTRs <= 0 ;
        else                BLINK_CTRs <= BLINK_CTRs + 1 ;
    `a zLED_R_o = BLINK_CTRs[25] ;
    `a zLED_G_o = BJ_REGss[0] ;
endmodule
//TANG_PRiMER ()
