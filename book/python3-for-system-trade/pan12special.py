#!/usr/bin/env python
# coding: utf-8

# In[11]:


#付録12.A: パンローリングのティックデータの呼び込み
from datetime import datetime, date,timedelta
from datetime import time
def yymmdd_split(yymmdd):#日時インデックスから年、月、日に分類する関数
    yy=int(yymmdd[:2])+2000
    mm=int(yymmdd[2:4])
    dd=int(yymmdd[4:6])
    return yy,mm,dd

import os
def dir_file_get(path,date1,date0):#指定されたフォルダーにあるファイル名を取得
    list=os.listdir(path)
    lists=[]
    for i in range(len(list)):
        fname=list[i]
        date=fname[:6]
        if int(date)>=date0 and int(date)<=date1:
            lists.append(fname)
    return lists

import pandas as pd
import csv
import pytz #タイムゾーンの処理
def read_pan_tick(path,yy,mm,dd):#テキストファイルの読み込み
    with open(path,'r',encoding='UTF-8') as f: #this is for version 3.5
    #with open(path,'r') as f:# this is for version 2.7
        line=f.readline()
        da=[]
        price=[]
        i=0
        while line:
            elements=line.rstrip()
            e=elements.split()
            hhmmss=e[0]
            hms=hhmmss.split(':')#hms[0]:hour;hms[1]:minute;hms[2]:second 
            da00=datetime(yy,mm,dd)
            if da00.weekday()==0: #月曜=0          
                da00=datetime(yy,mm,dd)+timedelta(days=-3)
            else:
                da00=datetime(yy,mm,dd)+timedelta(days=-1)
            if int(hms[0])>=16 and int(hms[0])<=23: #16:30 - 23:59:99
                pass
            if int(hms[0])>=0 and int(hms[0])<=3: #00:00 - 3:00
                da00=da00+timedelta(days=1)
            if int(hms[0])>=9 and int(hms[0])<=15: #09:00 - 15:00
                da00=datetime(yy,mm,dd)
            dd0=da00.day
            mm0=da00.month
            da0=datetime(yy,mm0,dd0,int(hms[0]),int(hms[1]))+timedelta(hours=-14)
            dd0=da0.day
            mm0=da0.month
            h=da0.hour
            m=da0.minute
            da0=int(yy*10000+mm0*100+dd0)
            tt0=int(h)*100+int(m)
            da.append(da0)
            price.append([])
            #price[i].append(int(da0))
            price[i].append(int(tt0))
            price[i].append(int(e[1]))
            price[i].append(int(e[1]))
            price[i].append(int(e[1]))
            price[i].append(int(e[2]))
            price[i].append(int(e[2]))
            price[i].append(int(e[2]))
            i+=1
            line=f.readline()#テキストファイルの行の読み込み
    ts=pd.DataFrame(price,index=da,columns=["time","price","bid","offer","volume","vbid","voffer"])#daをインデックスに設定。
    return ts

def file_concat_pan_tick(path,date1,date0):#date1、date2で指定された日時の間のデータをdata2からdeta1まで垂直に結合する。
    dates=dir_file_get(path,date1,date0)
    for i in range(len(dates)):
        date=dates[i]
        fname=path+date
        date0=date[:6]
        yy,mm,dd=yymmdd_split(date0)#ファイルの年、月、日を取得
        if i==0:
            ts=read_pan_tick(fname,yy,mm,dd)
        else:
            ts0=read_pan_tick(fname,yy,mm,dd)
            ts=pd.concat([ts,ts0])
    return ts            


# In[12]:


def readcsv(file_name):
    trades=[]
    with open(file_name,'r') as f:
        series=csv.reader(f)
        n=0
        for line in series:
            trades.append([])
            for elements in line:
                trades[n].append(elements)
            n=n+1
    f.close()
    return trades


# In[13]:


get_ipython().run_line_magic('matplotlib', 'inline')
import matplotlib.pyplot as plt
if __name__ == "__main__":
    t1=datetime.now()
    path = "c:\\users\\moriya\\documents\\database\\pan\\n225\\TICK\\1001\\1509\\"
    path2 = "c:\\users\\moriya\\documents\\database\\n225\\tick\\"
    fname= "n225m201508Sep.csv"
    entry=150801
    exit=150831
    pan=file_concat_pan_tick(path,exit,entry)
    fname=path2+fname
    pan.to_csv(fname,header=False)#列名無し
    path3 = "c:\\users\\moriya\\documents\\database\\n225\\tick\\"
    fname= "n225m201508Sep.csv"
    file_name=path3+fname
    trades=readcsv(file_name)
t2=datetime.now()
print(t2-t1)


# In[14]:


print(trades[:10])


# In[ ]:





# In[ ]:




