# -*- coding: cp932 -*-
#
# KAAs : 1st

import math
import datetime
import sys
import os

def rom_prn():
    print("//SQRT_ROM.hex")
    print("// adr /23>>14")
    print("//",datetime.datetime.now())
#     print("@0")
    for iii in range(2**9) :
        if(iii < 2**7):
            print(
                "                9'h%03X:CORR_DATs<=8'h%02X;"
                %(iii,int(iii**.5))
            )
            continue
        ii = iii<<14  # /23, 23-9=14
        x = ii **.5
        y = (ii>>(11+1)) + (2**10)
        u = x - y 
#        print( ii,":",x,y,u )
        uu = max(u , -255.0)
        print(
            "                9'h%03X:CORR_DATs<=8'h%02X;//%f"
            %(iii, int(math   .ceil(-uu)) , u)
        )
#        print("%02X//%d,%f"%(int(-uu) , iii,u))


def main():
    with open("SQRT_CORR.txt","w") as fp :
        sys.stdout = fp
        rom_prn()

if __name__ == "__main__" :
    main()
