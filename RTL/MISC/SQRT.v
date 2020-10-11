// SQRT.v
//  SQRT()
//
// SQRT calcurator pipline
//
//KAAs  : chg rom stile to case statement
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
//    `r[7:0] CORR_ROMss [0:511] ;
//    `init $readmemh("SQRT_CORR.hex" , CORR_ROMss) ;
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
            CORR_DATs <= 0 ;
        else
            case( CORR_ADRs )
                //SQRT_ROM.hex
                // adr /23>>14
                // 2020-10-11 21:37:38.696023
                9'h000:CORR_DATs<=8'h00;
                9'h001:CORR_DATs<=8'h01;
                9'h002:CORR_DATs<=8'h01;
                9'h003:CORR_DATs<=8'h01;
                9'h004:CORR_DATs<=8'h02;
                9'h005:CORR_DATs<=8'h02;
                9'h006:CORR_DATs<=8'h02;
                9'h007:CORR_DATs<=8'h02;
                9'h008:CORR_DATs<=8'h02;
                9'h009:CORR_DATs<=8'h03;
                9'h00A:CORR_DATs<=8'h03;
                9'h00B:CORR_DATs<=8'h03;
                9'h00C:CORR_DATs<=8'h03;
                9'h00D:CORR_DATs<=8'h03;
                9'h00E:CORR_DATs<=8'h03;
                9'h00F:CORR_DATs<=8'h03;
                9'h010:CORR_DATs<=8'h04;
                9'h011:CORR_DATs<=8'h04;
                9'h012:CORR_DATs<=8'h04;
                9'h013:CORR_DATs<=8'h04;
                9'h014:CORR_DATs<=8'h04;
                9'h015:CORR_DATs<=8'h04;
                9'h016:CORR_DATs<=8'h04;
                9'h017:CORR_DATs<=8'h04;
                9'h018:CORR_DATs<=8'h04;
                9'h019:CORR_DATs<=8'h05;
                9'h01A:CORR_DATs<=8'h05;
                9'h01B:CORR_DATs<=8'h05;
                9'h01C:CORR_DATs<=8'h05;
                9'h01D:CORR_DATs<=8'h05;
                9'h01E:CORR_DATs<=8'h05;
                9'h01F:CORR_DATs<=8'h05;
                9'h020:CORR_DATs<=8'h05;
                9'h021:CORR_DATs<=8'h05;
                9'h022:CORR_DATs<=8'h05;
                9'h023:CORR_DATs<=8'h05;
                9'h024:CORR_DATs<=8'h06;
                9'h025:CORR_DATs<=8'h06;
                9'h026:CORR_DATs<=8'h06;
                9'h027:CORR_DATs<=8'h06;
                9'h028:CORR_DATs<=8'h06;
                9'h029:CORR_DATs<=8'h06;
                9'h02A:CORR_DATs<=8'h06;
                9'h02B:CORR_DATs<=8'h06;
                9'h02C:CORR_DATs<=8'h06;
                9'h02D:CORR_DATs<=8'h06;
                9'h02E:CORR_DATs<=8'h06;
                9'h02F:CORR_DATs<=8'h06;
                9'h030:CORR_DATs<=8'h06;
                9'h031:CORR_DATs<=8'h07;
                9'h032:CORR_DATs<=8'h07;
                9'h033:CORR_DATs<=8'h07;
                9'h034:CORR_DATs<=8'h07;
                9'h035:CORR_DATs<=8'h07;
                9'h036:CORR_DATs<=8'h07;
                9'h037:CORR_DATs<=8'h07;
                9'h038:CORR_DATs<=8'h07;
                9'h039:CORR_DATs<=8'h07;
                9'h03A:CORR_DATs<=8'h07;
                9'h03B:CORR_DATs<=8'h07;
                9'h03C:CORR_DATs<=8'h07;
                9'h03D:CORR_DATs<=8'h07;
                9'h03E:CORR_DATs<=8'h07;
                9'h03F:CORR_DATs<=8'h07;
                9'h040:CORR_DATs<=8'h08;
                9'h041:CORR_DATs<=8'h08;
                9'h042:CORR_DATs<=8'h08;
                9'h043:CORR_DATs<=8'h08;
                9'h044:CORR_DATs<=8'h08;
                9'h045:CORR_DATs<=8'h08;
                9'h046:CORR_DATs<=8'h08;
                9'h047:CORR_DATs<=8'h08;
                9'h048:CORR_DATs<=8'h08;
                9'h049:CORR_DATs<=8'h08;
                9'h04A:CORR_DATs<=8'h08;
                9'h04B:CORR_DATs<=8'h08;
                9'h04C:CORR_DATs<=8'h08;
                9'h04D:CORR_DATs<=8'h08;
                9'h04E:CORR_DATs<=8'h08;
                9'h04F:CORR_DATs<=8'h08;
                9'h050:CORR_DATs<=8'h08;
                9'h051:CORR_DATs<=8'h09;
                9'h052:CORR_DATs<=8'h09;
                9'h053:CORR_DATs<=8'h09;
                9'h054:CORR_DATs<=8'h09;
                9'h055:CORR_DATs<=8'h09;
                9'h056:CORR_DATs<=8'h09;
                9'h057:CORR_DATs<=8'h09;
                9'h058:CORR_DATs<=8'h09;
                9'h059:CORR_DATs<=8'h09;
                9'h05A:CORR_DATs<=8'h09;
                9'h05B:CORR_DATs<=8'h09;
                9'h05C:CORR_DATs<=8'h09;
                9'h05D:CORR_DATs<=8'h09;
                9'h05E:CORR_DATs<=8'h09;
                9'h05F:CORR_DATs<=8'h09;
                9'h060:CORR_DATs<=8'h09;
                9'h061:CORR_DATs<=8'h09;
                9'h062:CORR_DATs<=8'h09;
                9'h063:CORR_DATs<=8'h09;
                9'h064:CORR_DATs<=8'h0A;
                9'h065:CORR_DATs<=8'h0A;
                9'h066:CORR_DATs<=8'h0A;
                9'h067:CORR_DATs<=8'h0A;
                9'h068:CORR_DATs<=8'h0A;
                9'h069:CORR_DATs<=8'h0A;
                9'h06A:CORR_DATs<=8'h0A;
                9'h06B:CORR_DATs<=8'h0A;
                9'h06C:CORR_DATs<=8'h0A;
                9'h06D:CORR_DATs<=8'h0A;
                9'h06E:CORR_DATs<=8'h0A;
                9'h06F:CORR_DATs<=8'h0A;
                9'h070:CORR_DATs<=8'h0A;
                9'h071:CORR_DATs<=8'h0A;
                9'h072:CORR_DATs<=8'h0A;
                9'h073:CORR_DATs<=8'h0A;
                9'h074:CORR_DATs<=8'h0A;
                9'h075:CORR_DATs<=8'h0A;
                9'h076:CORR_DATs<=8'h0A;
                9'h077:CORR_DATs<=8'h0A;
                9'h078:CORR_DATs<=8'h0A;
                9'h079:CORR_DATs<=8'h0B;
                9'h07A:CORR_DATs<=8'h0B;
                9'h07B:CORR_DATs<=8'h0B;
                9'h07C:CORR_DATs<=8'h0B;
                9'h07D:CORR_DATs<=8'h0B;
                9'h07E:CORR_DATs<=8'h0B;
                9'h07F:CORR_DATs<=8'h0B;
                9'h080:CORR_DATs<=8'h58;//-87.845312
                9'h081:CORR_DATs<=8'h57;//-86.199463
                9'h082:CORR_DATs<=8'h55;//-84.575456
                9'h083:CORR_DATs<=8'h53;//-82.973038
                9'h084:CORR_DATs<=8'h52;//-81.391962
                9'h085:CORR_DATs<=8'h50;//-79.831988
                9'h086:CORR_DATs<=8'h4F;//-78.292876
                9'h087:CORR_DATs<=8'h4D;//-76.774395
                9'h088:CORR_DATs<=8'h4C;//-75.276315
                9'h089:CORR_DATs<=8'h4A;//-73.798411
                9'h08A:CORR_DATs<=8'h49;//-72.340464
                9'h08B:CORR_DATs<=8'h47;//-70.902256
                9'h08C:CORR_DATs<=8'h46;//-69.483576
                9'h08D:CORR_DATs<=8'h45;//-68.084213
                9'h08E:CORR_DATs<=8'h43;//-66.703963
                9'h08F:CORR_DATs<=8'h42;//-65.342625
                9'h090:CORR_DATs<=8'h40;//-64.000000
                9'h091:CORR_DATs<=8'h3F;//-62.675894
                9'h092:CORR_DATs<=8'h3E;//-61.370115
                9'h093:CORR_DATs<=8'h3D;//-60.082476
                9'h094:CORR_DATs<=8'h3B;//-58.812792
                9'h095:CORR_DATs<=8'h3A;//-57.560881
                9'h096:CORR_DATs<=8'h39;//-56.326565
                9'h097:CORR_DATs<=8'h38;//-55.109667
                9'h098:CORR_DATs<=8'h36;//-53.910015
                9'h099:CORR_DATs<=8'h35;//-52.727440
                9'h09A:CORR_DATs<=8'h34;//-51.561773
                9'h09B:CORR_DATs<=8'h33;//-50.412851
                9'h09C:CORR_DATs<=8'h32;//-49.280512
                9'h09D:CORR_DATs<=8'h31;//-48.164597
                9'h09E:CORR_DATs<=8'h30;//-47.064948
                9'h09F:CORR_DATs<=8'h2E;//-45.981413
                9'h0A0:CORR_DATs<=8'h2D;//-44.913838
                9'h0A1:CORR_DATs<=8'h2C;//-43.862075
                9'h0A2:CORR_DATs<=8'h2B;//-42.825976
                9'h0A3:CORR_DATs<=8'h2A;//-41.805397
                9'h0A4:CORR_DATs<=8'h29;//-40.800195
                9'h0A5:CORR_DATs<=8'h28;//-39.810230
                9'h0A6:CORR_DATs<=8'h27;//-38.835363
                9'h0A7:CORR_DATs<=8'h26;//-37.875458
                9'h0A8:CORR_DATs<=8'h25;//-36.930381
                9'h0A9:CORR_DATs<=8'h24;//-36.000000
                9'h0AA:CORR_DATs<=8'h24;//-35.084184
                9'h0AB:CORR_DATs<=8'h23;//-34.182806
                9'h0AC:CORR_DATs<=8'h22;//-33.295738
                9'h0AD:CORR_DATs<=8'h21;//-32.422856
                9'h0AE:CORR_DATs<=8'h20;//-31.564037
                9'h0AF:CORR_DATs<=8'h1F;//-30.719161
                9'h0B0:CORR_DATs<=8'h1E;//-29.888107
                9'h0B1:CORR_DATs<=8'h1E;//-29.070759
                9'h0B2:CORR_DATs<=8'h1D;//-28.267000
                9'h0B3:CORR_DATs<=8'h1C;//-27.476715
                9'h0B4:CORR_DATs<=8'h1B;//-26.699793
                9'h0B5:CORR_DATs<=8'h1A;//-25.936122
                9'h0B6:CORR_DATs<=8'h1A;//-25.185592
                9'h0B7:CORR_DATs<=8'h19;//-24.448095
                9'h0B8:CORR_DATs<=8'h18;//-23.723524
                9'h0B9:CORR_DATs<=8'h18;//-23.011775
                9'h0BA:CORR_DATs<=8'h17;//-22.312743
                9'h0BB:CORR_DATs<=8'h16;//-21.626326
                9'h0BC:CORR_DATs<=8'h15;//-20.952422
                9'h0BD:CORR_DATs<=8'h15;//-20.290933
                9'h0BE:CORR_DATs<=8'h14;//-19.641760
                9'h0BF:CORR_DATs<=8'h14;//-19.004805
                9'h0C0:CORR_DATs<=8'h13;//-18.379973
                9'h0C1:CORR_DATs<=8'h12;//-17.767169
                9'h0C2:CORR_DATs<=8'h12;//-17.166301
                9'h0C3:CORR_DATs<=8'h11;//-16.577274
                9'h0C4:CORR_DATs<=8'h10;//-16.000000
                9'h0C5:CORR_DATs<=8'h10;//-15.434388
                9'h0C6:CORR_DATs<=8'h0F;//-14.880348
                9'h0C7:CORR_DATs<=8'h0F;//-14.337795
                9'h0C8:CORR_DATs<=8'h0E;//-13.806640
                9'h0C9:CORR_DATs<=8'h0E;//-13.286800
                9'h0CA:CORR_DATs<=8'h0D;//-12.778188
                9'h0CB:CORR_DATs<=8'h0D;//-12.280723
                9'h0CC:CORR_DATs<=8'h0C;//-11.794322
                9'h0CD:CORR_DATs<=8'h0C;//-11.318904
                9'h0CE:CORR_DATs<=8'h0B;//-10.854388
                9'h0CF:CORR_DATs<=8'h0B;//-10.400695
                9'h0D0:CORR_DATs<=8'h0A;//-9.957747
                9'h0D1:CORR_DATs<=8'h0A;//-9.525466
                9'h0D2:CORR_DATs<=8'h0A;//-9.103776
                9'h0D3:CORR_DATs<=8'h09;//-8.692602
                9'h0D4:CORR_DATs<=8'h09;//-8.291868
                9'h0D5:CORR_DATs<=8'h08;//-7.901502
                9'h0D6:CORR_DATs<=8'h08;//-7.521429
                9'h0D7:CORR_DATs<=8'h08;//-7.151578
                9'h0D8:CORR_DATs<=8'h07;//-6.791878
                9'h0D9:CORR_DATs<=8'h07;//-6.442258
                9'h0DA:CORR_DATs<=8'h07;//-6.102648
                9'h0DB:CORR_DATs<=8'h06;//-5.772981
                9'h0DC:CORR_DATs<=8'h06;//-5.453187
                9'h0DD:CORR_DATs<=8'h06;//-5.143200
                9'h0DE:CORR_DATs<=8'h05;//-4.842954
                9'h0DF:CORR_DATs<=8'h05;//-4.552381
                9'h0E0:CORR_DATs<=8'h05;//-4.271418
                9'h0E1:CORR_DATs<=8'h04;//-4.000000
                9'h0E2:CORR_DATs<=8'h04;//-3.738064
                9'h0E3:CORR_DATs<=8'h04;//-3.485546
                9'h0E4:CORR_DATs<=8'h04;//-3.242385
                9'h0E5:CORR_DATs<=8'h04;//-3.008518
                9'h0E6:CORR_DATs<=8'h03;//-2.783886
                9'h0E7:CORR_DATs<=8'h03;//-2.568428
                9'h0E8:CORR_DATs<=8'h03;//-2.362085
                9'h0E9:CORR_DATs<=8'h03;//-2.164797
                9'h0EA:CORR_DATs<=8'h02;//-1.976507
                9'h0EB:CORR_DATs<=8'h02;//-1.797156
                9'h0EC:CORR_DATs<=8'h02;//-1.626689
                9'h0ED:CORR_DATs<=8'h02;//-1.465047
                9'h0EE:CORR_DATs<=8'h02;//-1.312177
                9'h0EF:CORR_DATs<=8'h02;//-1.168021
                9'h0F0:CORR_DATs<=8'h02;//-1.032527
                9'h0F1:CORR_DATs<=8'h01;//-0.905639
                9'h0F2:CORR_DATs<=8'h01;//-0.787304
                9'h0F3:CORR_DATs<=8'h01;//-0.677470
                9'h0F4:CORR_DATs<=8'h01;//-0.576083
                9'h0F5:CORR_DATs<=8'h01;//-0.483092
                9'h0F6:CORR_DATs<=8'h01;//-0.398446
                9'h0F7:CORR_DATs<=8'h01;//-0.322093
                9'h0F8:CORR_DATs<=8'h01;//-0.253984
                9'h0F9:CORR_DATs<=8'h01;//-0.194069
                9'h0FA:CORR_DATs<=8'h01;//-0.142297
                9'h0FB:CORR_DATs<=8'h01;//-0.098622
                9'h0FC:CORR_DATs<=8'h01;//-0.062993
                9'h0FD:CORR_DATs<=8'h01;//-0.035364
                9'h0FE:CORR_DATs<=8'h01;//-0.015686
                9'h0FF:CORR_DATs<=8'h01;//-0.003914
                9'h100:CORR_DATs<=8'h00;//0.000000
                9'h101:CORR_DATs<=8'h01;//-0.003899
                9'h102:CORR_DATs<=8'h01;//-0.015564
                9'h103:CORR_DATs<=8'h01;//-0.034952
                9'h104:CORR_DATs<=8'h01;//-0.062016
                9'h105:CORR_DATs<=8'h01;//-0.096714
                9'h106:CORR_DATs<=8'h01;//-0.139001
                9'h107:CORR_DATs<=8'h01;//-0.188833
                9'h108:CORR_DATs<=8'h01;//-0.246168
                9'h109:CORR_DATs<=8'h01;//-0.310964
                9'h10A:CORR_DATs<=8'h01;//-0.383177
                9'h10B:CORR_DATs<=8'h01;//-0.462766
                9'h10C:CORR_DATs<=8'h01;//-0.549690
                9'h10D:CORR_DATs<=8'h01;//-0.643908
                9'h10E:CORR_DATs<=8'h01;//-0.745379
                9'h10F:CORR_DATs<=8'h01;//-0.854063
                9'h110:CORR_DATs<=8'h01;//-0.969920
                9'h111:CORR_DATs<=8'h02;//-1.092910
                9'h112:CORR_DATs<=8'h02;//-1.222994
                9'h113:CORR_DATs<=8'h02;//-1.360134
                9'h114:CORR_DATs<=8'h02;//-1.504291
                9'h115:CORR_DATs<=8'h02;//-1.655427
                9'h116:CORR_DATs<=8'h02;//-1.813504
                9'h117:CORR_DATs<=8'h02;//-1.978485
                9'h118:CORR_DATs<=8'h03;//-2.150332
                9'h119:CORR_DATs<=8'h03;//-2.329009
                9'h11A:CORR_DATs<=8'h03;//-2.514480
                9'h11B:CORR_DATs<=8'h03;//-2.706708
                9'h11C:CORR_DATs<=8'h03;//-2.905658
                9'h11D:CORR_DATs<=8'h04;//-3.111294
                9'h11E:CORR_DATs<=8'h04;//-3.323581
                9'h11F:CORR_DATs<=8'h04;//-3.542484
                9'h120:CORR_DATs<=8'h04;//-3.767968
                9'h121:CORR_DATs<=8'h04;//-4.000000
                9'h122:CORR_DATs<=8'h05;//-4.238545
                9'h123:CORR_DATs<=8'h05;//-4.483570
                9'h124:CORR_DATs<=8'h05;//-4.735041
                9'h125:CORR_DATs<=8'h05;//-4.992926
                9'h126:CORR_DATs<=8'h06;//-5.257190
                9'h127:CORR_DATs<=8'h06;//-5.527803
                9'h128:CORR_DATs<=8'h06;//-5.804732
                9'h129:CORR_DATs<=8'h07;//-6.087944
                9'h12A:CORR_DATs<=8'h07;//-6.377408
                9'h12B:CORR_DATs<=8'h07;//-6.673092
                9'h12C:CORR_DATs<=8'h07;//-6.974966
                9'h12D:CORR_DATs<=8'h08;//-7.282999
                9'h12E:CORR_DATs<=8'h08;//-7.597159
                9'h12F:CORR_DATs<=8'h08;//-7.917416
                9'h130:CORR_DATs<=8'h09;//-8.243741
                9'h131:CORR_DATs<=8'h09;//-8.576103
                9'h132:CORR_DATs<=8'h09;//-8.914472
                9'h133:CORR_DATs<=8'h0A;//-9.258820
                9'h134:CORR_DATs<=8'h0A;//-9.609117
                9'h135:CORR_DATs<=8'h0A;//-9.965334
                9'h136:CORR_DATs<=8'h0B;//-10.327442
                9'h137:CORR_DATs<=8'h0B;//-10.695413
                9'h138:CORR_DATs<=8'h0C;//-11.069218
                9'h139:CORR_DATs<=8'h0C;//-11.448830
                9'h13A:CORR_DATs<=8'h0C;//-11.834221
                9'h13B:CORR_DATs<=8'h0D;//-12.225363
                9'h13C:CORR_DATs<=8'h0D;//-12.622229
                9'h13D:CORR_DATs<=8'h0E;//-13.024792
                9'h13E:CORR_DATs<=8'h0E;//-13.433024
                9'h13F:CORR_DATs<=8'h0E;//-13.846899
                9'h140:CORR_DATs<=8'h0F;//-14.266391
                9'h141:CORR_DATs<=8'h0F;//-14.691473
                9'h142:CORR_DATs<=8'h10;//-15.122119
                9'h143:CORR_DATs<=8'h10;//-15.558303
                9'h144:CORR_DATs<=8'h10;//-16.000000
                9'h145:CORR_DATs<=8'h11;//-16.447184
                9'h146:CORR_DATs<=8'h11;//-16.899829
                9'h147:CORR_DATs<=8'h12;//-17.357911
                9'h148:CORR_DATs<=8'h12;//-17.821405
                9'h149:CORR_DATs<=8'h13;//-18.290285
                9'h14A:CORR_DATs<=8'h13;//-18.764528
                9'h14B:CORR_DATs<=8'h14;//-19.244109
                9'h14C:CORR_DATs<=8'h14;//-19.729004
                9'h14D:CORR_DATs<=8'h15;//-20.219188
                9'h14E:CORR_DATs<=8'h15;//-20.714639
                9'h14F:CORR_DATs<=8'h16;//-21.215332
                9'h150:CORR_DATs<=8'h16;//-21.721244
                9'h151:CORR_DATs<=8'h17;//-22.232352
                9'h152:CORR_DATs<=8'h17;//-22.748632
                9'h153:CORR_DATs<=8'h18;//-23.270062
                9'h154:CORR_DATs<=8'h18;//-23.796619
                9'h155:CORR_DATs<=8'h19;//-24.328280
                9'h156:CORR_DATs<=8'h19;//-24.865023
                9'h157:CORR_DATs<=8'h1A;//-25.406825
                9'h158:CORR_DATs<=8'h1A;//-25.953665
                9'h159:CORR_DATs<=8'h1B;//-26.505521
                9'h15A:CORR_DATs<=8'h1C;//-27.062370
                9'h15B:CORR_DATs<=8'h1C;//-27.624191
                9'h15C:CORR_DATs<=8'h1D;//-28.190962
                9'h15D:CORR_DATs<=8'h1D;//-28.762663
                9'h15E:CORR_DATs<=8'h1E;//-29.339272
                9'h15F:CORR_DATs<=8'h1E;//-29.920769
                9'h160:CORR_DATs<=8'h1F;//-30.507131
                9'h161:CORR_DATs<=8'h20;//-31.098339
                9'h162:CORR_DATs<=8'h20;//-31.694372
                9'h163:CORR_DATs<=8'h21;//-32.295209
                9'h164:CORR_DATs<=8'h21;//-32.900830
                9'h165:CORR_DATs<=8'h22;//-33.511216
                9'h166:CORR_DATs<=8'h23;//-34.126345
                9'h167:CORR_DATs<=8'h23;//-34.746199
                9'h168:CORR_DATs<=8'h24;//-35.370757
                9'h169:CORR_DATs<=8'h24;//-36.000000
                9'h16A:CORR_DATs<=8'h25;//-36.633908
                9'h16B:CORR_DATs<=8'h26;//-37.272463
                9'h16C:CORR_DATs<=8'h26;//-37.915644
                9'h16D:CORR_DATs<=8'h27;//-38.563434
                9'h16E:CORR_DATs<=8'h28;//-39.215812
                9'h16F:CORR_DATs<=8'h28;//-39.872760
                9'h170:CORR_DATs<=8'h29;//-40.534260
                9'h171:CORR_DATs<=8'h2A;//-41.200293
                9'h172:CORR_DATs<=8'h2A;//-41.870840
                9'h173:CORR_DATs<=8'h2B;//-42.545884
                9'h174:CORR_DATs<=8'h2C;//-43.225405
                9'h175:CORR_DATs<=8'h2C;//-43.909387
                9'h176:CORR_DATs<=8'h2D;//-44.597810
                9'h177:CORR_DATs<=8'h2E;//-45.290658
                9'h178:CORR_DATs<=8'h2E;//-45.987913
                9'h179:CORR_DATs<=8'h2F;//-46.689557
                9'h17A:CORR_DATs<=8'h30;//-47.395572
                9'h17B:CORR_DATs<=8'h31;//-48.105941
                9'h17C:CORR_DATs<=8'h31;//-48.820648
                9'h17D:CORR_DATs<=8'h32;//-49.539674
                9'h17E:CORR_DATs<=8'h33;//-50.263003
                9'h17F:CORR_DATs<=8'h33;//-50.990619
                9'h180:CORR_DATs<=8'h34;//-51.722503
                9'h181:CORR_DATs<=8'h35;//-52.458641
                9'h182:CORR_DATs<=8'h36;//-53.199014
                9'h183:CORR_DATs<=8'h36;//-53.943607
                9'h184:CORR_DATs<=8'h37;//-54.692403
                9'h185:CORR_DATs<=8'h38;//-55.445386
                9'h186:CORR_DATs<=8'h39;//-56.202540
                9'h187:CORR_DATs<=8'h39;//-56.963849
                9'h188:CORR_DATs<=8'h3A;//-57.729296
                9'h189:CORR_DATs<=8'h3B;//-58.498867
                9'h18A:CORR_DATs<=8'h3C;//-59.272545
                9'h18B:CORR_DATs<=8'h3D;//-60.050315
                9'h18C:CORR_DATs<=8'h3D;//-60.832161
                9'h18D:CORR_DATs<=8'h3E;//-61.618068
                9'h18E:CORR_DATs<=8'h3F;//-62.408020
                9'h18F:CORR_DATs<=8'h40;//-63.202003
                9'h190:CORR_DATs<=8'h40;//-64.000000
                9'h191:CORR_DATs<=8'h41;//-64.801998
                9'h192:CORR_DATs<=8'h42;//-65.607980
                9'h193:CORR_DATs<=8'h43;//-66.417933
                9'h194:CORR_DATs<=8'h44;//-67.231841
                9'h195:CORR_DATs<=8'h45;//-68.049690
                9'h196:CORR_DATs<=8'h45;//-68.871465
                9'h197:CORR_DATs<=8'h46;//-69.697152
                9'h198:CORR_DATs<=8'h47;//-70.526736
                9'h199:CORR_DATs<=8'h48;//-71.360203
                9'h19A:CORR_DATs<=8'h49;//-72.197538
                9'h19B:CORR_DATs<=8'h4A;//-73.038729
                9'h19C:CORR_DATs<=8'h4A;//-73.883759
                9'h19D:CORR_DATs<=8'h4B;//-74.732617
                9'h19E:CORR_DATs<=8'h4C;//-75.585286
                9'h19F:CORR_DATs<=8'h4D;//-76.441755
                9'h1A0:CORR_DATs<=8'h4E;//-77.302009
                9'h1A1:CORR_DATs<=8'h4F;//-78.166034
                9'h1A2:CORR_DATs<=8'h50;//-79.033818
                9'h1A3:CORR_DATs<=8'h50;//-79.905345
                9'h1A4:CORR_DATs<=8'h51;//-80.780604
                9'h1A5:CORR_DATs<=8'h52;//-81.659580
                9'h1A6:CORR_DATs<=8'h53;//-82.542261
                9'h1A7:CORR_DATs<=8'h54;//-83.428633
                9'h1A8:CORR_DATs<=8'h55;//-84.318684
                9'h1A9:CORR_DATs<=8'h56;//-85.212400
                9'h1AA:CORR_DATs<=8'h57;//-86.109768
                9'h1AB:CORR_DATs<=8'h58;//-87.010775
                9'h1AC:CORR_DATs<=8'h58;//-87.915409
                9'h1AD:CORR_DATs<=8'h59;//-88.823657
                9'h1AE:CORR_DATs<=8'h5A;//-89.735507
                9'h1AF:CORR_DATs<=8'h5B;//-90.650945
                9'h1B0:CORR_DATs<=8'h5C;//-91.569960
                9'h1B1:CORR_DATs<=8'h5D;//-92.492538
                9'h1B2:CORR_DATs<=8'h5E;//-93.418668
                9'h1B3:CORR_DATs<=8'h5F;//-94.348337
                9'h1B4:CORR_DATs<=8'h60;//-95.281534
                9'h1B5:CORR_DATs<=8'h61;//-96.218245
                9'h1B6:CORR_DATs<=8'h62;//-97.158459
                9'h1B7:CORR_DATs<=8'h63;//-98.102165
                9'h1B8:CORR_DATs<=8'h64;//-99.049349
                9'h1B9:CORR_DATs<=8'h64;//-100.000000
                9'h1BA:CORR_DATs<=8'h65;//-100.954107
                9'h1BB:CORR_DATs<=8'h66;//-101.911657
                9'h1BC:CORR_DATs<=8'h67;//-102.872639
                9'h1BD:CORR_DATs<=8'h68;//-103.837042
                9'h1BE:CORR_DATs<=8'h69;//-104.804854
                9'h1BF:CORR_DATs<=8'h6A;//-105.776062
                9'h1C0:CORR_DATs<=8'h6B;//-106.750657
                9'h1C1:CORR_DATs<=8'h6C;//-107.728627
                9'h1C2:CORR_DATs<=8'h6D;//-108.709960
                9'h1C3:CORR_DATs<=8'h6E;//-109.694646
                9'h1C4:CORR_DATs<=8'h6F;//-110.682672
                9'h1C5:CORR_DATs<=8'h70;//-111.674028
                9'h1C6:CORR_DATs<=8'h71;//-112.668704
                9'h1C7:CORR_DATs<=8'h72;//-113.666687
                9'h1C8:CORR_DATs<=8'h73;//-114.667967
                9'h1C9:CORR_DATs<=8'h74;//-115.672534
                9'h1CA:CORR_DATs<=8'h75;//-116.680376
                9'h1CB:CORR_DATs<=8'h76;//-117.691483
                9'h1CC:CORR_DATs<=8'h77;//-118.705845
                9'h1CD:CORR_DATs<=8'h78;//-119.723449
                9'h1CE:CORR_DATs<=8'h79;//-120.744287
                9'h1CF:CORR_DATs<=8'h7A;//-121.768347
                9'h1D0:CORR_DATs<=8'h7B;//-122.795619
                9'h1D1:CORR_DATs<=8'h7C;//-123.826092
                9'h1D2:CORR_DATs<=8'h7D;//-124.859757
                9'h1D3:CORR_DATs<=8'h7E;//-125.896604
                9'h1D4:CORR_DATs<=8'h7F;//-126.936620
                9'h1D5:CORR_DATs<=8'h80;//-127.979798
                9'h1D6:CORR_DATs<=8'h82;//-129.026126
                9'h1D7:CORR_DATs<=8'h83;//-130.075595
                9'h1D8:CORR_DATs<=8'h84;//-131.128194
                9'h1D9:CORR_DATs<=8'h85;//-132.183914
                9'h1DA:CORR_DATs<=8'h86;//-133.242745
                9'h1DB:CORR_DATs<=8'h87;//-134.304676
                9'h1DC:CORR_DATs<=8'h88;//-135.369699
                9'h1DD:CORR_DATs<=8'h89;//-136.437803
                9'h1DE:CORR_DATs<=8'h8A;//-137.508978
                9'h1DF:CORR_DATs<=8'h8B;//-138.583216
                9'h1E0:CORR_DATs<=8'h8C;//-139.660506
                9'h1E1:CORR_DATs<=8'h8D;//-140.740838
                9'h1E2:CORR_DATs<=8'h8E;//-141.824205
                9'h1E3:CORR_DATs<=8'h8F;//-142.910595
                9'h1E4:CORR_DATs<=8'h90;//-144.000000
                9'h1E5:CORR_DATs<=8'h92;//-145.092410
                9'h1E6:CORR_DATs<=8'h93;//-146.187816
                9'h1E7:CORR_DATs<=8'h94;//-147.286209
                9'h1E8:CORR_DATs<=8'h95;//-148.387580
                9'h1E9:CORR_DATs<=8'h96;//-149.491918
                9'h1EA:CORR_DATs<=8'h97;//-150.599216
                9'h1EB:CORR_DATs<=8'h98;//-151.709465
                9'h1EC:CORR_DATs<=8'h99;//-152.822654
                9'h1ED:CORR_DATs<=8'h9A;//-153.938776
                9'h1EE:CORR_DATs<=8'h9C;//-155.057821
                9'h1EF:CORR_DATs<=8'h9D;//-156.179781
                9'h1F0:CORR_DATs<=8'h9E;//-157.304646
                9'h1F1:CORR_DATs<=8'h9F;//-158.432408
                9'h1F2:CORR_DATs<=8'hA0;//-159.563059
                9'h1F3:CORR_DATs<=8'hA1;//-160.696588
                9'h1F4:CORR_DATs<=8'hA2;//-161.832989
                9'h1F5:CORR_DATs<=8'hA3;//-162.972251
                9'h1F6:CORR_DATs<=8'hA5;//-164.114368
                9'h1F7:CORR_DATs<=8'hA6;//-165.259329
                9'h1F8:CORR_DATs<=8'hA7;//-166.407127
                9'h1F9:CORR_DATs<=8'hA8;//-167.557753
                9'h1FA:CORR_DATs<=8'hA9;//-168.711199
                9'h1FB:CORR_DATs<=8'hAA;//-169.867456
                9'h1FC:CORR_DATs<=8'hAC;//-171.026517
                9'h1FD:CORR_DATs<=8'hAD;//-172.188372
                9'h1FE:CORR_DATs<=8'hAE;//-173.353014
                9'h1FF:CORR_DATs<=8'hAF;//-174.520434

            endcase
    `ack
        `xar
        `b
            DATs_D       <= 0 ;
            CORR_SFTs_D  <= 0 ;
            CORR_ADRs    <= 0 ;
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
//            CORR_DATs <= CORR_ROMss[ CORR_ADRs ] ;
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
