#!/usr/bin/env python
# coding: utf-8

# # 第5章　トレンドを理解する
# ## 5.2 日本経済と日経平均株価

# In[1]:


states=['recover','growth','stable','bubble','reform','now']
dates=["1949/5/16","1954/12/1",'1972/1/1',"1986/12/1","1993/11/1","2016/9/30"]
print(states)


# In[2]:


print(dates)


# In[3]:


import pandas_datareader.data as web
import numpy as np
end='2018/12/30'
n225 = web.DataReader("NIKKEI225", 'fred',"1949/5/16",end).NIKKEI225
print('rate of change')
for i in range(len(dates)-1):
    ave=n225[dates[i]:dates[i+1]].pct_change().mean()*250
    print(states[i],': %2.2f ％;'%(ave*100))
print 
print('volatility')
for i in range(len(dates)-1):
    vol=np.log(n225[dates[i]:dates[i+1]]).diff().std()*np.sqrt(250)
    print(states[i],': %2.2f ％;'%(vol*100))


# In[4]:


struct_break=[('1949/5/16','recv'),('1954/12/1','  growth'),
              ('1972/1/1','stable'),('1986/12/1','bubble'),('1991/3/1','      reform')]


# In[5]:


get_ipython().run_line_magic('matplotlib', 'inline')
import matplotlib.pyplot as plt
fig=plt.figure()
g=fig.add_subplot(1,1,1)
n225.plot(ax=g,style='y-',linewidth=0.5)
plt.ylabel('N225 Index')
for date, label in struct_break:
    g.annotate(label,xy=(date, n225.asof(date)+1000),
        xytext=(date,n225.asof(date)+10000),
        horizontalalignment='left',verticalalignment='top')
    g.set_xlim(['1947/1/1','2019/4/25'])

plt.title("Nikkei 225 and structural change")


# ## 5.4 日経平均株価の長期トレンドの把握

# In[6]:


import numpy as np
fig=plt.figure()
g=fig.add_subplot(1,1,1)
ln_n225=np.log(n225)               #numpyのlogを利用
ln_n225.plot(ax=g,style='y-',linewidth=0.5)

for date, label in struct_break:
    g.annotate(label,xy=(date, ln_n225.asof(date)),
        xytext=(date,ln_n225.asof(date)-0.75),
        horizontalalignment='left',verticalalignment='top')
    g.set_xlim(['1947/1/1','2019/4/25'])
plt.ylabel('log(N225 index)')
plt.title("Log Nikkei 225 index and structural change")


# In[7]:


import pandas_datareader.data as pdr
import numpy as np
for i in range(len(dates)-1):
    vol=np.log(n225[dates[i]:dates[i+1]]).diff().std()
    print(states[i],': %2.4f ;'%vol,)


# |循環期|景気(states)|期間-始点|終点|リターン|ボラティリティ|標準偏差|
# |:---:|:---:|:---:|:---:|:---:|:---:|:---:|
# |1,2|戦後復興期(recover)|1949/5/16|1954/11/30|14%|23%|0.0145|
# |3,4,5,6|高度経済成長期(growth)|1954/12/1|1971/12/31|13%|14%|0.0091|
# |7,8,9,10|安定期(stable)|1972/11/1|1986/11/30|13%|13%|0.0080|
# |11|バブル経済期(bubble)|1986/12/1|1993/10/31|3%|23%|0.0144|
# |12-15|経済変革期(reform)|1993/11/1|現在|2%|24%|0.0149|
# 

# In[8]:


plt.figure(figsize=(8,4))
import datetime
import pandas as pd
end=datetime.datetime.now()
start=datetime.date(1980,1,1)
price = web.DataReader("IBB", 'yahoo',start,end)#yahooのサービスの停止により変更 iexでは５年分のデータが取得可能
analysis=price
analysis['intraday']=0#None
analysis['overnight']=0#None
c0=analysis.Close.iloc[0]    
for i in range(1,len(analysis)):
    o=analysis.Open.iloc[i]
    c=analysis.Close.iloc[i]
    analysis.iloc[i,6]=c-o#列6　Intraday
    analysis.iloc[i,7]=o-c0#列７ overnight
    c0=c
(analysis.Close-analysis.Close.iloc[0]).plot(label='Close',linewidth=1)
analysis.intraday.cumsum().plot(label="intraday",linestyle=":")
analysis.overnight.cumsum().plot(label="overnight",linestyle='--',linewidth=1)
plt.legend()
plt.ylabel('PL or aapl')
plt.legend(loc='lower left')


# In[9]:


plt.figure(figsize=(8,4))
price = web.DataReader("SPY", 'yahoo',start,end)#yahooのサービスの停止により変更 iexでは５年分のデータが取得可能
analysis=price
analysis['intraday']=0#None
analysis['overnight']=0#None
c0=analysis.Close.iloc[0]    
for i in range(1,len(analysis)):
    o=analysis.Open.iloc[i]
    c=analysis.Close.iloc[i]
    analysis.iloc[i,6]=c-o#列6　Intraday
    analysis.iloc[i,7]=o-c0#列７ overnight
    c0=c
(analysis.Close-analysis.Close.iloc[0]).plot(label='Close',linewidth=1)
analysis.intraday.cumsum().plot(label="intraday",linestyle=":")
analysis.overnight.cumsum().plot(label="overnight",linestyle='--',linewidth=1)
plt.legend()
plt.ylabel('PL or aapl')
plt.legend(loc='lower left')


# In[10]:


plt.figure(figsize=(8,4))
price = web.DataReader("DIA", 'yahoo',start,end)#yahooのサービスの停止により変更 iexでは５年分のデータが取得可能
analysis=price

analysis['intraday']=0#None
analysis['overnight']=0#None
c0=analysis.Close.iloc[0]    
for i in range(1,len(analysis)):
    o=analysis.Open.iloc[i]
    c=analysis.Close.iloc[i]
    analysis.iloc[i,6]=c-o#列6　Intraday
    analysis.iloc[i,7]=o-c0#列７ overnight
    c0=c
(analysis.Close-analysis.Close.iloc[0]).plot(label='Close',linewidth=1)
analysis.intraday.cumsum().plot(label="intraday",linestyle=":")
analysis.overnight.cumsum().plot(label="overnight",linestyle='--',linewidth=1)
plt.legend()
plt.ylabel('PL or aapl')
plt.legend(loc='lower left')


# In[11]:


plt.figure(figsize=(8,4))
price = web.DataReader("QQQ", 'yahoo',start,end)#yahooのサービスの停止により変更 iexでは５年分のデータが取得可能
analysis=price

analysis['intraday']=0#None
analysis['overnight']=0#None
c0=analysis.Close.iloc[0]    
for i in range(1,len(analysis)):
    o=analysis.Open.iloc[i]
    c=analysis.Close.iloc[i]
    analysis.iloc[i,6]=c-o#列6　Intraday
    analysis.iloc[i,7]=o-c0#列７ overnight
    c0=c

(analysis.Close-analysis.Close.iloc[0]).plot(label='Close',linewidth=1)
analysis.intraday.cumsum().plot(label="intraday",linestyle=":")
analysis.overnight.cumsum().plot(label="overnight",linestyle='--',linewidth=1)
plt.legend()
plt.ylabel('PL or aapl')
plt.legend(loc='lower left')


# In[ ]:




