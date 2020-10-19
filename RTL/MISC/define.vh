//
    `define ack always@(posedge CK_i or negedge XARST_i)
    `define xar if(~XARST_i)
    `define cke if(CK_EE_i)
    `define b   begin
    `define e   end
    `define a   assign
    `define func function
    `define efunc endfunction
    `define s   signed
    `define Ds  $signed
    `define in  input
    `define out output
    `define io inout
    `define w   wire
    `define r   reg
    `define int integer
    `define gen generate
    `define egen endgenerate
    `define p   parameter
    `define lp  localparam
    `define pe  posedge
    `define ne  negedge
    `define rep repeat
    `define init initial
    `define al always
    `define elif else if

//    `define elsif else if //alrady used ,who? where
    `define emodule endmodule
    `ifdef TANG_FPGA
        `define tri0 wire
        `define tri1 wire
    `else
        `define tri0 tri0
        `define tri1 tri1
    `endif
