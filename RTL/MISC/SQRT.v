// SQRT.v
//  SQRT()
//
// SQRT calcurator pipline
//
//KAAs  : done
//      : 1st

`define ack always@(posedge CK_i or negedge XARST_i)
`define xar if(~XARST_i)
`define b begin
`define e end
`define a assign
`define r reg
`define w wire
`define s signed
`define Ds $signed
`define in input
`define out output
`define func function
`define efunc endfunction
`define int integer
`define init initial
`define p parameter
`define lp localparam
`define gen generate
`define egen endgenerate
`define pe posedge
`define ne negedge
`define elif else if

`default_nettype none
module SQRT
(
      `in tri0          CK_i
    , `in tri1          XARST_i
    , `in tri0[22:0]    DATs_i
    , `in tri0[ 7:0]    B_IN_DAT_DLYs_i
    , `out`w[11:0]      QQs_o
    , `out`w[ 7:0]      B_OUT_DAT_DLYs_o
) ;
    localparam C_DAT_DLYs = 4 ; //ck
    `r[7:0] CORR_ROMss [0:511] ;
    `init $readmemh("SQRT_CORR.hex" , CORR_ROMss) ;
    `func [4:0]f_corrsft_s ;
        `in [32:0] DATs_i ;
        `int ii ;
    `b
        f_corrsft_s = 0 ;
        for(ii=0;ii<32;ii=ii+1)
            if( DATs_i[ii] )
                f_corrsft_s = ii ;
    `e`efunc
    `w[ 4:0]corr_sft_s = f_corrsft_s( DATs_i ) ;
    `r[ 4:0]CORR_SFTs_D     ;    //max 11
    `r[ 9:0]DATs_D          ; // /10
    `r[ 8:0]CORR_ADRs       ;
    `r[ 7:0]CORR_DATs       ;
    `r[11:0]DATs_DD         ;  // /12
    `r[ 4:0]CORR_SFTs_DD    ;
    `r[ 7:0]CORR_DATs_D     ;
    `r[11:0]DATs_DDD        ;
    `r      STR             ;
    `r[11:0]QQs             ; // /12.
    `ack
        `xar
        `b
            DATs_D       <= 0 ;
            CORR_SFTs_D  <= 0 ;
            CORR_ADRs    <= 0 ;
            CORR_DATs    <= 0 ;
            DATs_DD      <= 0 ;
            CORR_SFTs_DD <= 0 ;
            CORR_DATs_D  <= 0 ;
            DATs_DDD     <= 0 ;
            STR          <= 1'b0 ;
            QQs          <= 0 ;
        `e else
        `b
            // /23-> MS9 ,/22->MS9
            case( corr_sft_s )
                22,21:  CORR_ADRs[8:0] <=  DATs_i[22-:9] ;
                20,19:  CORR_ADRs[8:0] <=  DATs_i[20-:9] ;
                18,17:  CORR_ADRs[8:0] <=  DATs_i[18-:9] ;
                16,15:  CORR_ADRs[8:0] <=  DATs_i[16-:9] ;
                14,13:  CORR_ADRs[8:0] <=  DATs_i[14-:9] ;
                12,11:  CORR_ADRs[8:0] <=  DATs_i[12-:9] ;
                10, 9:  CORR_ADRs[8:0] <=  DATs_i[10-:9] ;
                 8, 7:  CORR_ADRs[8:0] <=  DATs_i[ 8-:9] ;
                default:  CORR_ADRs[8:0] <= DATs_i ;
            endcase
            // 2**22 -> 
            case( corr_sft_s )
                22,21: DATs_D <= DATs_i>>12 ;//12
                20,19: DATs_D <= DATs_i>>11 ;
                18,17: DATs_D <= DATs_i>>10 ;
                16,15: DATs_D <= DATs_i>>9 ;
                14,13: DATs_D <= DATs_i>>8 ;
                12,11: DATs_D <= DATs_i>>7 ;
                10, 9: DATs_D <= DATs_i>>6 ;
                 8, 7: DATs_D <= DATs_i>>5 ;
                 default DATs_D <= 0 ;
            endcase
            CORR_SFTs_D <= corr_sft_s ;
            CORR_DATs <= CORR_ROMss[ CORR_ADRs ] ;
            // 2**9+2**10
            case( CORR_SFTs_D )
                22,21:DATs_DD <= (1<<10) + DATs_D ; // <<10
                20,19:DATs_DD <= (1<<9) + DATs_D ;
                18,17:DATs_DD <= (1<<8) + DATs_D ;
                16,15:DATs_DD <= (1<<7) + DATs_D ;
                14,13:DATs_DD <= (1<<6) + DATs_D ;
                12,11:DATs_DD <= (1<<5) + DATs_D ;
                10, 9:DATs_DD <= (1<<4) + DATs_D ;
                 8, 7:DATs_DD <= (1<<3) + DATs_D ;
                default:
                    DATs_DD <= DATs_D;
            endcase
            CORR_SFTs_DD <= CORR_SFTs_D ;
            case( CORR_SFTs_DD )
                22,21:CORR_DATs_D <= CORR_DATs    ;
                20,19:CORR_DATs_D <= CORR_DATs>>1 ;
                18,17:CORR_DATs_D <= CORR_DATs>>2 ;
                16,15:CORR_DATs_D <= CORR_DATs>>3 ;
                14,13:CORR_DATs_D <= CORR_DATs>>4 ;
                12,11:CORR_DATs_D <= CORR_DATs>>5 ;
                10, 9:CORR_DATs_D <= CORR_DATs>>6 ;
                 8, 7:CORR_DATs_D <= CORR_DATs>>7 ;
                default:
                    CORR_DATs_D <=  CORR_DATs ;
            endcase
                STR <= (CORR_SFTs_DD < 7) ;
                DATs_DDD <= DATs_DD ;
                QQs <= 
                    (STR)
                    ?   CORR_DATs_D
                    :   `Ds({1'b0,DATs_DDD}) - `Ds({1'b0,CORR_DATs_D} ) 
                ;
        `e
    `a QQs_o = QQs ;
    
    `a B_OUT_DAT_DLYs_o = B_IN_DAT_DLYs_i + C_DAT_DLYs ;
endmodule
//SQRT()


`timescale 1ns/1ns
module TB_SQRT
#(
      parameter C_C = 10.0
)(
);
    `r CK ;
    `r CK_i ;
    `init
    `b
        CK <= 1'b1 ;
        force CK_i = CK ;
        forever #(C_C/2) CK <= ~CK ;
    `e
    `r XARST ;
    `r XARST_i ;
    `init
    `b
        XARST <= 1'b0 ;
        force XARST_i = XARST ;
        #(10.1 * C_C)  XARST <= 1'b1 ;
    `e
    `r[22:0] DATs ;
    `w[11:0] QQs_o ;
    SQRT
        SQRT
        (
              .CK_i     ( CK_i      )
            , .XARST_i  ( XARST_i   )
            , .DATs_i   ( DATs      )
            , .QQs_o    ( QQs_o     )
        ) 
    ;
    `int 
          hh
        , vv
        , zz 
    ;
    `init
    `b
        DATs <= 0 ;
        wait(XARST_i) ;
        repeat(100)@(`pe CK_i) ;
        for(zz=0;zz<1;zz=zz+1)
        `b
            for(vv=0;vv<1;vv=vv+1)
            `b
                DATs <= 0 ;
                for(hh=0;hh<2**23;hh=hh+1)
                `b
                    DATs <= DATs + 1 ;
                    @(`pe CK_i) ;
                `e
            `e
        `e
        repeat(100)@(`pe CK_i) ;
        $stop ;
        $finish ;
    `e
endmodule
