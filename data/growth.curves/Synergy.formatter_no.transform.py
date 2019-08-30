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

def synergy(thedir="",infile="",outfile="",dim=48,freq=15,trunc=-9):
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
    inlist2=copy.deepcopy(inlist);inlist2=inlist2[0:-1];inlist3=[];inlist4=[]
    for row in inlist2:
        inlist3+=[row[3:]]
    for index,row in enumerate(inlist3):
        inlist4.append([])
        #print(inlist4)
        for cell in row:
            try:
                tempcell=float(cell)
                inlist4[index].append(tempcell)
            except ValueError:
                pass
    #print(inlist2[:2])
    nodf=pd.DataFrame(inlist4[1:])
    #nodfc=nodf.iloc[:,3:]
    #pp.pprint(nodf)
    lndf = pd.DataFrame(np.zeros((len(nodf),len(nodf.columns))))
    
    #for index,col in nodf.iteritems():
    for indexr,row in enumerate(nodf.itertuples()):
        #print(indexr)
        for index,cell in enumerate(row[1:]):
            if indexr<5:
                pass#print(str(cell)+'__'+str(nodf.iloc[0,index])+"__"+str(index))
            try:
                lndf.iloc[indexr,index]=(cell)
            except ValueError:
                lndf.iloc[indexr,index]=0
    #pp.pprint(lndf[1,:])   
    
    if outfile=="":
        outfile2 = str(infile[:-4])+"_clean_rawOD.csv"
    else:
        outfile2=outfile
    with open (outfile2, 'w') as OUT:
        if dim==48:
            OUT.write("Time,A1,A2,A3,A4,A5,A6,A7,A8,B1,B2,B3,B4,B5,B6,B7,B8,C1,C2,C3,C4,C5,C6,C7,C8,D1,D2,D3,D4,D5,D6,D7,D8,E1,E2,E3,E4,E5,E6,E7,E8,F1,F2,F3,F4,F5,F6,F7,F8\n")
        elif dim==24:
            pass
        else:
            pass
        
        if trunc==-9:
            ender=(len(lndf)-1)*freq#i.e. = 2880 or wevv
        else:
            ender=trunc
        for indexr,row in enumerate(lndf.itertuples()):
                if indexr>ender/freq:
                    break
                OUT.write(str(indexr*freq)+',')
                for index,cell in enumerate(row[1:]):
                    #print(len(row))
                    if index!=(len(row)-1-1):
                        OUT.write(str(cell)+',')
                    else:
                        #pp.pprint(indexr);pp.pprint((ender/freq))
                        if indexr<(ender/freq):
                            OUT.write(str(cell)+'\n')
                        elif indexr==(ender/freq):
                            OUT.write(str(cell))
                        else:
                            break
                            
            #OUT.write(str((indexr)*freq)+','+re.sub(r"[\[\]'\(\)]",r"",str(row[3:]))+'\n')
        '''for index, row in enumerate(inlist2):
            if index>0:#and index <= 97:
                #print(re.sub(r"[\[\]']",r"",str(row[2:])))
                OUT.write(str((index-1)*freq)+','+re.sub(r"[\[\]']",r"",str(row[3:]))+'\n')'''
                   
    #pp.pprint(inlist)
    return nodf,lndf
#%%

mydf,myd=synergy(infile=r"C:\Users\rmoge\Box Sync\JTL_Lab\Lab.Notebook\20180627_Vn\Experiments\Media.trials\20190814_LBv2_M9.for.Vn\20190814_LBv2_M9.csv",outfile="",trunc=1440)

'''if __name__ == '__main__':
    processCLI(sys.argv)'''