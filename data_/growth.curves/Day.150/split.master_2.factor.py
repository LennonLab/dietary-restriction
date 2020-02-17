# -*- coding: utf-8 -*-
"""
Created on Mon Jun  4 22:09:58 2018

@author: RZM
"""

from __future__ import division
import re, os,sys, math, operator,random, copy,collections; import numpy as np; import pandas as pd
from itertools import groupby; import pprint as pp
#from orderedset import OrderedSet
import matplotlib.pyplot as plt

#%%
def split_two_factor(masterin,factor1="",factor2=""):
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
                    #pp.pprint(repvals)         
                    tempdf.iloc[0,index-2]=float(np.nanmean(repvals))#nanmean takes the mean of all the values in the List that are **not** NaN
                    #can modify this code to remove negative values
                    #if tempdf.iloc[0,index-2]<0:
                    #    tempdf.iloc[0,index-2]=0
            filename=i+"_"+j+".csv"        
            pd.DataFrame.to_csv(tempdf,path_or_buf=filename,columns=None,index=False)
                
                
    return master

#%%
def split_two_factor_combine_biological_replicates(masterin,factor1="",factor2=""):
    master=pd.read_csv(masterin)
    names1=set([i for i in master[factor1]]);names2=set([i for i in master[factor2]]);shortnames=set([i[0:2] for i in master.columns[2:]])
    #in the previous line, I used to have shortnames=OrderedSet([...]) But conda doesn't support orderedset right now. So I think it means you just have to put up with seemingly random order of your columns in the output, with the script as written
    pp.pprint(shortnames)
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
                    #pp.pprint(repvals)            
                    tempdf.iloc[0,index-2]=float(np.nanmean(repvals))#nanmean takes the mean of all the values in the List that are **not** NaN
                    #can modify this code to remove negative values
                    #if tempdf.iloc[0,index-2]<0:
                    #    tempdf.iloc[0,index-2]=0        
            tv=pd.DataFrame(columns=shortnames)#;pp.pprint(tv)
            for treatment in shortnames:
                cells=[]
                for index2,col in enumerate(tempdf.iteritems()):
                    #pp.pprint(treatment)
                    #pp.pprint(col[0][0:2])
                    if col[0][0:2]==treatment:
                        cells.append(tempdf.iloc[0,index2])
                tv[treatment]=pd.Series(cells)
            #tv.apply(lambda col: col.drop_duplicates().reset_index(drop=True))#this makes it so that the NAs are all pushed to the bottom of columns that are shorter than the longest column in the dataframe
            filename=i+"_"+j+"_vertical.csv"        
            pd.DataFrame.to_csv(tv,path_or_buf=filename,columns=None,index=False)
                
                
    return master

mm = split_two_factor_combine_biological_replicates(masterin="C:\\Users\\RZM\\Box Sync\\JTL_Lab\\Lab.Notebook\\20170903_DR_Evolution\\data\\growth.curves\\Day.275\\master.csv",factor1="Media",factor2="Metric")
#%%
m = split_two_factor(masterin="C:\\Users\\RZM\\Box Sync\\JTL_Lab\\Lab.Notebook\\20170903_DR_Evolution\\data\\growth.curves\\Day.150\\master.csv",factor1="Media",factor2="Metric")
#%%
mm = split_two_factor_combine_biological_replicates(masterin="C:\\Users\\RZM\\Box Sync\\JTL_Lab\\Lab.Notebook\\20170903_DR_Evolution\\data\\growth.curves\\Day.150\\master.csv",factor1="Media",factor2="Metric")