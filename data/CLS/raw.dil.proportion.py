# -*- coding: utf-8 -*-
"""
Created 2018/05/16

@author: RZM
"""
#%%
from __future__ import division
import re, os,sys, math, operator,random, copy,collections; import numpy as np; import pandas as pd
from itertools import groupby; import pprint as pp
import matplotlib.pyplot as plt
#%%
def processCLI(args):
    #synergy(args)
    return
    

def survivorship(thedir="",in1="",in2="",outfile="",nrows=0):
    raws = pd.read_csv(in1);dils=pd.read_csv(in2)
    #permL=pd.DataFrame(np.zeros((len(raws),len(raws.columns))));permL.iloc[:,0]=raws.iloc[:,0]
    permL=pd.DataFrame.copy(raws,deep=True);proportions=pd.DataFrame.copy(raws,deep=True)
    for indexr,row in enumerate(permL.itertuples()):
        for index,cell in enumerate(row[2:]):#we are using 2: here to i) avoid hitting the row number ii) avoid hitting the T column
            permL.iloc[indexr,index+1]=(raws.iloc[indexr,index+1] / dils.iloc[indexr,index+1])#we are adding index+1 here to avoid using the T column
    for indexr,row in enumerate(permL.itertuples()):
        for index,cell in enumerate(row[2:]):#we are using 2: here to i) avoid hitting the row number ii) avoid hitting the T column
            proportions.iloc[indexr,index+1]=(permL.iloc[indexr,index+1] / permL.iloc[0,index+1])#we are adding index+1 here to avoid using the T column    
              
    if outfile=="":
        outfile2 = str(in1[:-7])+"_survivorship.csv"
    else:
        outfile2=outfile
    pd.DataFrame.to_csv(proportions,path_or_buf=outfile2,columns=None,index=False)
    #with open (outfile2, 'w') as OUT:
        
    return raws,dils,permL,proportions

def combine_technical_replicates(indf):#this function combines technical replicates when they are represented in the .csv and df by different columns with similar headers
    tec=pd.DataFrame();reps=[];doneL=[]
    tec["T"]=indf["T"]
    for index,h in enumerate(indf.columns[1:]):#use [1:] to avoid the T column
        tempS=set()
        if h not in doneL:
            for index2,i in enumerate(indf.columns[1:]):
                if str(h[0:3])==str(i[0:3]):#this takes the first 3 characters if set to h[0:3]; combine based on the labels in YOUR sample
                    tempS.add(i)
        for j in tempS:
            doneL.append(j)
        #print(tempS)
        if len(tempS)>0:
            reps.append(tuple(tempS))
    #pp.pprint(reps)
    
    metaD={}
    for indext, tup in enumerate(reps):
        #pp.pprint(tup)
        tec[tup[0][0:3]]=indf["T"].astype('float64');metaD[tup[0][0:3]]=[]#this takes the first 3 characters if set to h[0:3]; combine based on the labels in YOUR sample
        #pp.pprint(tec)
        for indexr,row in enumerate(indf.itertuples()):
            repvals=[]
            for index,cell in enumerate(row[1:]):
                if indf.columns[index][0:3]==tup[0][0:3]:#set the values of indf.columns[index][0:6] and [tup[0][0:x] to be what you chose in line 57
                    repvals.append(indf.iloc[indexr,index])
            #pp.pprint(np.mean(repvals))
            tec[tup[0][0:3]][indexr]=float(np.mean(repvals))#set the values of tec[tup[0][0:x] to be what you chose in line 57
            metaD[tup[0][0:3]].append((np.std(repvals)/np.mean(repvals)*100))#set the values of [tup[0][0:x] to be what you chose in line 57

                    
                    
                #permL.iloc[indexr,index+1]=(raws.iloc[indexr,index+1] / dils.iloc[indexr,index+1])
        
        #pp.pprint(doneL)
    #pp.pprint(reps)    
    return tec,metaD

#%%
#m = split_two_factor(masterin="C:\\Users\\RZM\\Box Sync\\JTL_Lab\\Lab.Notebook\\20170903_DR_Evolution\\data\\growth.curves\\Day.150\\master.csv",factor1="Media",factor2="Metric")


r,d,m,p=survivorship(in1=r"C:\Users\rmoge\Box Sync\JTL_Lab\Lab.Notebook\20170903_DR_Evolution\data\CLS\Day.275_DR\20180724_DR_raw.csv",in2=r"C:\Users\rmoge\Box Sync\JTL_Lab\Lab.Notebook\20170903_DR_Evolution\data\CLS\Day.275_DR\20180724_DR_dil.csv",)
t,M=combine_technical_replicates(p)
pd.DataFrame.to_csv(t,path_or_buf=r"C:\Users\rmoge\Box Sync\JTL_Lab\Lab.Notebook\20170903_DR_Evolution\data\CLS\Day.275_YPD\combined_DR.275.csv",columns=None,index=False)


#%%
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
                lndf.iloc[indexr,index]=((cell / nodf.iloc[0,index])-1)
            except ValueError:
                lndf.iloc[indexr,index]=0
    #pp.pprint(lndf[1,:])   
    
    if outfile=="":
        outfile2 = str(infile[:-4])+"_clean_n.no-1.csv"
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

mydf,myd=synergy(infile="C:\\Users\\RZM\\Box Sync\\JTL_Lab\\Lab.Notebook\\20180515_lifespan.mutants\\data\\growth.curves\\Day.150\\raw\\20180306_RSV_20W2-5s2_DMB_00s.csv",outfile="",trunc=1440)

'''if __name__ == '__main__':
    processCLI(sys.argv)'''
    #%%
'''def split_two_factor(masterin,factor1="",factor2=""):
    master=pd.read_csv(masterin)
    names1=set([i for i in master[factor1]]);names2=set([i for i in master[factor2]])
    for i in names1:
        for j in names2:
            #pp.pprint(i+"_"+j)
            #tempdf=pd.DataFrame().reindex_like(master)#reindex_like is badass!
            tempdf=pd.DataFrame(data=np.zeros(shape=(1,len(master.columns)-2)),columns=master.columns[2:])#setting the shape of np.zeros here is hard-coded with the assumption of 2 factors. this could certainly be modified if there were more factors
            for index,col_series_pair in enumerate(master.iteritems()):
                if index>=2:
                    repvals=[]
                    for indexr,row in enumerate(col_series_pair[1]):#only want to iterate through each series in each pair
                        if master[factor1][indexr]==i and master[factor2][indexr]==j:
                            repvals.append(master.iloc[indexr,index])
                    pp.pprint(repvals)            
                    tempdf.iloc[0,index-2]=float(np.nanmean(repvals))#nanmean takes the mean of all the values in the List that are **not** NaN
            filename=i+"_"+j+".csv"        
            pd.DataFrame.to_csv(tempdf,path_or_buf=filename,columns=None,index=False)
                
                
    return master

def two_peaks_flow(infile,cutoff1,cutoff2,metric):
    tfp=pd.read_csv(infile);negv=0;posv=0
    for row in tfp.iterrows():
        if row[1][metric]<cutoff1:
            negv+=1
        elif row[1][metric]>cutoff2:
            posv+=1
    return tfp,negv,posv

t,n,p=two_peaks_flow(infile="C:\\Users\\RZM\\Box Sync\\JTL_Lab\\Lab.Notebook\\flow\\20180605\\T24_100000.FSC_TFP1-GFP.csv",cutoff1=10000,cutoff2=10000,metric="GFP-H")'''