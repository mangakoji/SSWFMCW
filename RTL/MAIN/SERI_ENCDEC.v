// SSWFMCW.v
//  SSWFMCW()
//
//
//J6Ts  :start wt RTL

`default_nettype none
module SSWFMCW
(
      input tri0        CK_i
    , input tri1        XARST_i
    , input tri1        CK_EE_i
    , input tri1        RXD_i
    , input tri0        BUS_RX_MODE_i
    , output wire[24:0] Xs_o
    , output wire       TXD_o
    , output wire       CMP_o   //match H
) ;
    `define ack always@(posedge CK_i or negedge XARST_i)
    `define xar if(~XARST_i)
    `define cke if(CK_EE_i)
    `define b begin
    `define e end
    `define r reg
    `define w wire
    `define a assign
    `define s signed
    `define Ds $signed
    `define int integer
    `define func function
    `define efunc endfunc
    `define gen generate
    `define egen endgenerate
    `define in input
    `define out output
    function integer log2 ;
        input integer value ;
    begin
        value = value-1;
        for (log2=0; value>0; log2=log2+1)
            value = value>>1;
    end
    endfunction
    // charp sweep
    // wave gen
    // mic DS
    // sin wave gen
    // HeadPhone DS
    `gen
        genvar gi l
        for(gi=0;gi<gi+1;gi=gi+1)
        `b
            `r [14:0] HP_SMCTRs ;
            `ack
        `e
        `a HEAD_PHONEs_o[gi] = PHONEs[14] ;
    `egen
      `out `w[1:0] HEAD_PHONEs_o ;

    //x^25+x^22+1=0
    reg [24:0] Xs ;
    wire    cy ;
    assign  cy = (Xs[24] ^ Xs[21] )|(&(~Xs)) ;
    reg     CMP ;
    reg     TXD ;
    `ack
        `xar
        `b
            TXD <= 1'b0 ;
            CMP <= 1'b1 ;
            Xs <= ~0 ;
        `e
        else `cke
        `b
            TXD <= cy ;
            CMP <= ~(cy ^ RXD_i) ;  //match H
            if( BUS_RX_MODE_i )
                Xs <= {Xs , RXD_i} ;
            else
                Xs <= {Xs , cy} ;
        `e
    assign TXD_o = TXD ;
    assign CMP_o = CMP ;
    assign Xs_o = Xs ;
endmodule


`timescale 1ns/1ns
module TB_SSWFMCW
#(
    parameter C_C=10.0
)(
) ;
    reg CK_i ;
    reg CK_EE_i ;
    initial `b
        CK_i <= 1'b1 ;
        CK_EE_i <= 1'b1 ;
        forever begin
            #(C_C/2.0)
                CK_i <= ~ CK_i ;
        end
    end
    reg XARST_i ;
    initial begin
        XARST_i <= 1'b1 ;
        #(0.1 * C_C)
            XARST_i <= 1'b0 ;
        #(3.1 * C_C)
            XARST_i <= 1'b1 ;
    end

    
    wire    TXD ;
    wire    CMP_o   ;
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
