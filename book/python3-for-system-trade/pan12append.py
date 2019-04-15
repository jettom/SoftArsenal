#!/usr/bin/env python
# coding: utf-8

# In[3]:


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
def read_pan_tick(path,yy,mm,dd):#テキストファイルの読み込み
    with open(path,'r',encoding='UTF-8') as f:
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
            da0=datetime(yy,mm0,dd0,int(hms[0]),int(hms[1]),int(hms[2]))
            da.append(da0)
            price.append([])
            price[i].append(int(e[1]))
            price[i].append(int(e[2]))
            i+=1
            line=f.readline()#テキストファイルの行の読み込み
    ts=pd.DataFrame(price,index=da,columns=["price","volume"])#daをインデックスに設定。
    ts.index.name='date'#インデックスに名前を付与する。
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

def file_conv_tick_2session(fname,ts):#ティックデータを４本値に変換、csvファイルとして保存
    nss_flg=False #夜間立会のフラグ
    dss_flg=False #日中立会のフラグ
    dat=[]
    trade=[]
    yy=mm=dd=0
    o=h=l=p=int(ts.iloc[0].price)
    j=0
    v_s=tv_s=0
    #関数内の関数の定義--------------------------------------------------
    def max_min_volume_value(i,h,l,v_s,tv_s):#高値、安値、取引高、売買代金
        p=int(ts.iloc[i].price)
        v=int(ts.iloc[i].volume)
        h=max(h,p)
        l=min(l,p)
        v_s+=v
        tv_s+=v*p
        return p,h,l,v_s,tv_s
    def dat_trade_append(j,da0,o,h,l,c,v_s,tv_s):#情報の追加
        dat.append(da0)
        trade.append([])
        trade[j].append(o)
        trade[j].append(h)
        trade[j].append(l)
        trade[j].append(c)
        trade[j].append(v_s)
        trade[j].append(tv_s)
        v_s=0
        tv_s=0
        j+=1
        return dat,trade,v_s,tv_s,j
    def init_trade(i,da):#データの初期化
        o=int(ts.iloc[i].price)
        h=o
        l=o
        yy=da.year[0]
        mm=da.month[0]
        dd=da.day[0]
        return o,h,l,yy,mm,dd
    #メインループ---------------------------------------------------------
    for i in range(len(ts)):
        da=ts[i:i+1].index
        t=ts[i:i+1].index.time
        if t==time(16,30) and dss_flg:#日中立会のデータの更新
            dss_flg=False
            da0=datetime(yy,mm,dd,9,0)
            sat,trade,v_s,tv_s,j=dat_trade_append(j,da0,o,h,l,c,v_s,tv_s)
        if t==time(16,30) and not nss_flg:#夜間立会開始
            dss_flg=False
            o,h,l,yy,mm,dd=init_trade(i,da)
            nss_flg=True
        if t>=time(16,30) and t<=time(23,59,59) and nss_flg:#夜間立会、当日ザラバ取引
            p,h,l,v_s,tv_s=max_min_volume_value(i,h,l,v_s,tv_s)
        if t>=time(0,0) and t<=time(2,55) and nss_flg:#夜間立会、翌日ザラバ取引
            p,h,l,v_s,tv_s=max_min_volume_value(i,h,l,v_s,tv_s)
        if t==time(3,0) and nss_flg:#夜間立会、翌日板寄せ取引
            c,h,l,v_s,tv_s=max_min_volume_value(i,h,l,v_s,tv_s)
        if t<=time(9,0,2) and t>=time(9,0) and nss_flg:#夜間立会のデータの更新
            nss_flg=False
            da0=datetime(yy,mm,dd,16,30)
            sat,trade,v_s,tv_s,j=dat_trade_append(j,da0,o,h,l,c,v_s,tv_s)
            #print(da[0],t,da0)
        if t<=time(9,0,2) and t>=time(9,0,0) and not dss_flg:#日中立会の開始
            o,h,l,yy,mm,dd=init_trade(i,da)
            dss_flg=True
        if t>=time(9,0) and t<=time(15,10) and dss_flg:#日中立会のザラバと寄り板寄せ取引
            p,h,l,v_s,tv_s=max_min_volume_value(i,h,l,v_s,tv_s)
        if t==time(15,15) and dss_flg:#日中取引の引け板寄せ取引
            c,h,l,v_s,tv_s=max_min_volume_value(i,h,l,v_s,tv_s)
    if t==time(15,15) and dss_flg:#日中取引のデータの更新
        da0=datetime(yy,mm,dd,9,0)
        sat,trade,v_s,tv_s,j=dat_trade_append(j,da0,o,h,l,c,v_s,tv_s)
        #print(da[0],t,da0)
  
    tsnew=pd.DataFrame(trade,index=dat,columns=['Open','High','Low','Close','Volume','Value'])
    tsneｗ.index.name='Date'
    tsnew.to_csv(fname)
    return tsnew
            


# In[4]:


if __name__ == "__main__":
    t1=datetime.now()
    path = "c:\\users\\moriya\\documents\\database\\pan\\n225\\TICK\\1001\\1509\\"
    path2 = "c:\\users\\moriya\\documents\\database\\pan\\n225\\TICK\\1001\\"
    fname= "n225m1509.csv"
    entry=150612
    exit=150910
    pan=file_concat_pan_tick(path,exit,entry)
    fname=path2+fname
    pan2=file_conv_tick_2session(fname,pan)
    print(len(pan))
t2=datetime.now()
print(t2-t1)


# In[5]:


from datetime import datetime, date,timedelta
from datetime import time
if __name__ == "__main__":
    t1=datetime.now()
    path = "c:\\users\\moriya\\documents\\database\\pan\\n225\\TICK\\1001\\1506\\"
    path2 = "c:\\users\\moriya\\documents\\database\\pan\\n225\\TICK\\1001\\"
    fname= "n225m1506.csv"
    entry=150313
    exit=150612
    pan=file_concat_pan_tick(path,exit,entry)
    fname=path2+fname
    pan2=file_conv_tick_2session(fname,pan)

    print(len(pan))
t2=datetime.now()
print(t2-t1)


# In[6]:


if __name__ == "__main__":
    t1=datetime.now()
    path = "c:\\users\\moriya\\documents\\database\\pan\\n225\\TICK\\1001\\1503\\"
    path2 = "c:\\users\\moriya\\documents\\database\\pan\\n225\\TICK\\1001\\"
    fname= "n225m1503.csv"
    entry=141212
    exit=150312
    pan=file_concat_pan_tick(path,exit,entry)
    fname=path2+fname
    pan2=file_conv_tick_2session(fname,pan)

    print(len(pan))
t2=datetime.now()
print(t2-t1)


# In[7]:


if __name__ == "__main__":
    t1=datetime.now()
    path = "c:\\users\\moriya\\documents\\database\\pan\\n225\\TICK\\1001\\1512\\"
    path2 = "c:\\users\\moriya\\documents\\database\\pan\\n225\\TICK\\1001\\"
    fname= "n225m1512.csv"
    entry=150911
    exit=151210
    pan=file_concat_pan_tick(path,exit,entry)
    fname=path2+fname
    pan2=file_conv_tick_2session(fname,pan)

    print(len(pan))
t2=datetime.now()
print(t2-t1)


# In[8]:


if __name__ == "__main__":
    t1=datetime.now()
    path = "c:\\users\\moriya\\documents\\database\\pan\\n225\\TICK\\1001\\1603\\"
    path2 = "c:\\users\\moriya\\documents\\database\\pan\\n225\\TICK\\1001\\"
    fname= "n225m1603.csv"
    entry=151211
    exit=160104
    pan=file_concat_pan_tick(path,exit,entry)
    fname=path2+fname
    pan2=file_conv_tick_2session(fname,pan)

    print(len(pan))
t2=datetime.now()
print(t2-t1)


# In[9]:


if __name__ == "__main__":
    t1=datetime.now()
    path2 = "c:\\users\\moriya\\documents\\database\\pan\\n225\\TICK\\1001\\"
    fname=["n225m1503.csv","n225m1506.csv","n225m1509.csv","n225m1512.csv","n225m1603.csv"]
    ts=pd.read_csv(path2+fname[0],index_col=0,parse_dates=True)
    for i in range(1,len(fname)):
        pathfname=path2+fname[i]
        ts0=pd.read_csv(pathfname,index_col=0,parse_dates=True)
        ts=pd.concat([ts,ts0])
    pathfname=path2+'nikkei225fm_2_2015.csv'#書籍のファイル名と違いますが、こちらでプログラムが動きます。
    ts.to_csv(pathfname)
    #print(ts)
t2=datetime.now()
print(t2-t1)


# In[10]:


from datetime import datetime, date
def datetime_parser(str_date):
    try:
        return datetime.strptime(str_date,'%Y-%m-%d')
    except(Exception):    
        return 0 


# In[11]:


#!/usr/bin/env python
# -*- coding: utf-8 -*-
import urllib.request
import codecs
import pandas as pd 


# In[12]:


def xxx_retrieve_2session(url,path):
    urllib.request.urlretrieve(url, path)
    fut=codecs.open(path,'r','shift_jis')
    f=[]
    da=[]
    i=0
    for line in fut:            
        a=line.split(',')
        b=a[0]
        if datetime_parser(b):
            y=int(b[:4])
            m=int(b[5:7])
            d=int(b[8:])
            x=a[1]
            if x==(u'日中'):
                d=datetime(y,m,d,9,0)
            else:
                if x==(u'夜間'):
                    d=datetime(y,m,d,16,30)
            da.append(d)
            f.append([])
            for j in range(2,7):
                f[i].append(a[j])
            f[i].append(a[7][:-2])
            i+=1
    f1=pd.DataFrame(f,columns=['Open','High','Low','Close','Volume','Value'],index=da)
    f1.index.name='Date'
    f1=f1.sort_index()
    f1.to_csv(path)
    return f1


# In[13]:


rl = "http://xxx.com/futures/F102-0001/1d/2015?download=csv"
path = "c:/users/xxx/documents/ipython notebooks/temp.csv"
n225fm=xxx_retrieve_2session(url,path).dropna()
#print(n225fm)


# In[ ]:




