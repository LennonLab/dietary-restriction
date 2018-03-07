# -*- coding: utf-8 -*-
"""
Created on Tue Mar  6 12:33:05 2018

@author: RZM
"""

from __future__ import division
import re, os,sys, math, operator,random, copy,collections; import numpy as np; import pandas as pd
from itertools import groupby; import pprint as pp
import matplotlib.pyplot as plt

def processCLI(args):
    synergy(args)

def synergy(thedir="",infile="",outfile="",dim=48,freq=15):
    inlist=[]
    with open (infile, 'r') as IN:
        for index, line in enumerate(IN):
            if index >= 54:#this line may need adjusting if hardcoding gives inconsistent results
                #print(line.strip().split(','))
                if line.strip().split(',')[0]=="Results":
                    break
                else:
                    templine=[]
                    templine=line.strip().split(',')
                    #pp.pprint(templine)
                    inlist+=[templine]
                    #pp.pprint(templine[0:10])
            else:
                pass
    inlist2=copy.deepcopy(inlist)
    inlist2=inlist2[0:-1]
    #print(inlist2[-10:])
    if outfile=="":
        outfile2 = str(infile[:-4])+"_clean.csv"
    else:
        outfile2=outfile
    with open (outfile2, 'w') as OUT:
        if dim==48:
            OUT.write("Time,A1,A2,A3,A4,A5,A6,A7,A8,B1,B2,B3,B4,B5,B6,B7,B8,C1,C2,C3,C4,C5,C6,C7,C8,D1,D2,D3,D4,D5,D6,D7,D8,E1,E2,E3,E4,E5,E6,E7,E8,F1,F2,F3,F4,F5,F6,F7,F8\n")
        elif dim==24:
            pass
        else:
            pass
        for index, row in enumerate(inlist2):
            if index>0:#and index <= 97:
                #print(re.sub(r"[\[\]']",r"",str(row[2:])))
                OUT.write(str((index-1)*freq)+','+re.sub(r"[\[\]']",r"",str(row[3:]))+'\n')
                   
    #pp.pprint(inlist)
    return


synergy(infile="C:\\Users\\RZM\\Box Sync\\JTL_Lab\\Lab.Notebook\\20170903_DR_Evolution\\data\\growth.curves\\Day.150\\20180305_RSV_RW1-20s2_DMB.csv",outfile="")
    
'''if __name__ == '__main__':
    processCLI(sys.argv)'''