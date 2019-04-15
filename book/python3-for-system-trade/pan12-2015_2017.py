#!/usr/bin/env python
# coding: utf-8

# # 第12章　取引戦略の第一歩 特別エディション
# ここで使われているデータを読者の方はお持ちでないので、実際のプログラムを動かすことはできません。
# データは「Python3ではじめるシステムトレード」執筆時から現在まで延長されています。
# 
# ## 12.2 一定の方式を確立する

# In[109]:


#csvファイルからのデータの読み込み
import pandas as pd 
path = "c:/users/moriya/documents/Database/n225/session/"
fname="nikkei225fm_2_2015_2017.csv"
pathfname=path+fname
n225fm=pd.read_csv(pathfname,index_col=0,parse_dates=True)
#n225fm.tail()


# In[110]:


#on,s1,s12,s2,onのデータベースの構築
from datetime import date, time,datetime
c0=int(n225fm.iloc[0].Close)
da0=n225fm[0:1].index.date
r=[];da=[];j=0;on=0;s1=0

cost=2
for i in range(1,len(n225fm)):
    d=n225fm[i:i+1].index
    t=n225fm[i:i+1].index.time
    o=int(n225fm.iloc[i].Open)
    c=n225fm.iloc[i].Close
    if t==time(9,0):
        s1=c-o
        on=o-c0
    if t==time(16,30):
        s2=c-o
        s12=o-c0
        da0=datetime(d.year[0],d.month[0],d.day[0])
        if da0==datetime(2016,7,15):
            s12=0
            s2=0
            c=c0
        da.append(da0)
        r.append([])
        r[j].append(on)
        r[j].append(s1)
        r[j].append(s12)
        r[j].append(s2)
        j+=1
    c0=c
session=pd.DataFrame(r,index=da)
session.columns=['on','s1','s12','s2']


# In[111]:


#それぞれのセッション、セッション間の記述統計
print(session.s1.describe())
print(session.s12.describe())
print(session.s2.describe())
print(session.on.describe())


# - オーバーナイトのリターン　：2016年中は緩やかに上昇し、2017年になりもみ合う。
# - 日中立会のリターン　　　　：2016年中は下落を続け、2017年は最初は持ち合いその後上昇する。
# - 日中夜間立会の間のリターン：2016年、2017年と穏やかな下落が続く
# - 夜間立会のリターン　　　　：2016年、2017年と上昇を続ける

# In[112]:


#累積損益のグラフ表示
get_ipython().run_line_magic('matplotlib', 'inline')
import matplotlib.pyplot as plt
session.on.cumsum().plot(label='$on$',linestyle=':')
session.s1.cumsum().plot(label='$s1$',style='.')
session.s12.cumsum().plot(label='$s12$',linestyle='-')
session.s2.cumsum().plot(label='$s2$',linestyle='--')
plt.legend(loc='upper left')
plt.ylabel('P&L')
#linestyleは線のタイプをしていする、4つのタイプがある。
#線(-）,点線（：）,破線（--）,破断線（-.）
#styleは線のスタイルを設定します。


# In[113]:


#s,s12のヒストグラム
session.s1.hist(label='$s1$',histtype='step',linewidth=3,color="darkblue")
session.s12.hist(label='$s12$',color="lightgreen",rwidth=0.5)
plt.legend()


# In[114]:


#s2,onのヒストグラム
session.s2.hist(label='$s2$',rwidth=0.5,color='lightblue')
session.on.hist(label='$on$',histtype='step',linewidth=3,color='darkgreen')
plt.legend()


# ADF検定の結果、日中立会の間のは終値－始値の動きは、ドリフト無し、ドリフト付き、ドリフト＋確定的トレンド付きモデルでランダムウォークであるという帰無仮説を棄却しています。また、日中立会と夜間立会の間、夜間立会の間、夜間立会から日中立会の間でも一緒です。

# In[115]:


#各種統計量の算出、比較
import statsmodels.api as sm
import numpy as np
from statsmodels.compat import lzip
import statsmodels.stats.api as sms
print('adf nc',sm.tsa.adfuller(session.s1,regression='nc')[1]) #[1]はp値の検定結果
print('adf  c',sm.tsa.adfuller(session.s1,regression='c')[1]) #[1]はp値の検定結果
print('adf ct',sm.tsa.adfuller(session.s1,regression='ct')[1]) #[1]はp値の検定結果
print(session.s1.mean()/session.s1.std()*np.sqrt(session.s1.count()))
estimator = ['JB', 'Chi-squared p-value', 'Skew', 'Kurtosis']
test = sms.jarque_bera(session.s1)
print('s1: ',lzip(estimator, test))


# In[116]:


print(sm.tsa.adfuller(session.s12,regression='nc')[1]) #[1]はp値の検定結果
print(sm.tsa.adfuller(session.s12,regression='c')[1]) #[1]はp値の検定結果
print(sm.tsa.adfuller(session.s12,regression='ct')[1]) #[1]はp値の検定結果
print(session.s1.mean()/session.s12.std()*np.sqrt(session.s1.count()))
estimator = ['JB', 'Chi-squared p-value', 'Skew', 'Kurtosis']
test = sms.jarque_bera(session.s12)
print('s12: ',lzip(estimator, test))


# In[117]:


print(sm.tsa.adfuller(session.s2,regression='nc')[1]) #[1]はp値の検定結果
print(sm.tsa.adfuller(session.s2,regression='c')[1]) #[1]はp値の検定結果
print(sm.tsa.adfuller(session.s2,regression='ct')[1]) #[1]はp値の検定結果
print(session.s2.mean()/session.s2.std()*np.sqrt(session.s2.count()))
estimator = ['JB', 'Chi-squared p-value', 'Skew', 'Kurtosis']
test = sms.jarque_bera(session.s2)
print('s2: ',lzip(estimator, test))


# In[118]:


print(sm.tsa.adfuller(session.on,regression='nc')[1]) #[1]はp値の検定結果
print(sm.tsa.adfuller(session.on,regression='c')[1]) #[1]はp値の検定結果
print(sm.tsa.adfuller(session.on,regression='ct')[1]) #[1]はp値の検定結果
print(session.on.mean()/session.on.std()*np.sqrt(session.on.count()))
estimator = ['JB', 'Chi-squared p-value', 'Skew', 'Kurtosis']
test = sms.jarque_bera(session.on)
print('on: ',lzip(estimator, test))


# # ４つの日中リターンの収益性とリスク
# 
# ## 日中立会

# In[119]:


#s12におけるロングオンリー戦略のリターンの期間構造
plt.figure(figsize=(5,2.8))
high=[0]*120
low=[0]*120
ave=[0]*120
for i in range(120):
    high[i]=float(pd.Series.rolling(session.s1,i).sum().max())-2*i
    ave[i]=float(pd.Series.rolling(session.s1,i).sum().mean())-2*i
    low[i]=float(pd.Series.rolling(session.s1,i).sum().min())-2*i
plt.plot(high,label="high",linestyle=':')
plt.plot(ave,label='ave',color='darkred')
plt.plot(low,label='low',linestyle='--')
plt.legend(loc='upper left')
plt.xlabel('$t$')
plt.ylabel('PL')


# In[120]:


plt.figure(figsize=(6,4))
pd.Series.rolling(session.s1,5).std().plot(color='darkblue')
plt.ylabel('std')


# ## 日中立会が閉じてから夜間立会が開くまで

# In[121]:


#s12におけるロングオンリー戦略のリターンの期間構造
plt.figure(figsize=(5,2.8))
high=[0]*120
low=[0]*120
ave=[0]*120
for i in range(120):
    high[i]=float(pd.Series.rolling(session.s12,i).sum().max())-2*i
    ave[i]=float(pd.Series.rolling(session.s12,i).sum().mean())-2*i
    low[i]=float(pd.Series.rolling(session.s12,i).sum().min())-2*i
plt.plot(high,label="high",linestyle=':')
plt.plot(ave,label='ave',color='darkred')
plt.plot(low,label='low',linestyle='--')
plt.legend(loc='upper left')
plt.xlabel('$t$')
plt.ylabel('PL')


# In[122]:


plt.figure(figsize=(6,4))
pd.Series.rolling(session.s12,5).std().plot(color='darkblue')
plt.ylabel('std')


# ## 夜間立会

# In[123]:


#s12におけるロングオンリー戦略のリターンの期間構造
plt.figure(figsize=(5,2.8))
high=[0]*120
low=[0]*120
ave=[0]*120
for i in range(120):
    high[i]=float(pd.Series.rolling(session.s2,i).sum().max())-2*i
    ave[i]=float(pd.Series.rolling(session.s2,i).sum().mean())-2*i
    low[i]=float(pd.Series.rolling(session.s2,i).sum().min())-2*i
plt.plot(high,label="high",linestyle=':')
plt.plot(ave,label='ave',color='darkred')
plt.plot(low,label='low',linestyle='--')
plt.legend(loc='upper left')
plt.xlabel('$t$')
plt.ylabel('PL')


# In[124]:


plt.figure(figsize=(6,4))
pd.Series.rolling(session.s2,5).std().plot(color='darkblue')
plt.ylabel('std')


# ## オーバーナイト

# In[125]:


#s12におけるロングオンリー戦略のリターンの期間構造
plt.figure(figsize=(5,2.8))
high=[0]*120
low=[0]*120
ave=[0]*120
for i in range(120):
    high[i]=float(pd.Series.rolling(session.on,i).sum().max())-2*i
    ave[i]=float(pd.Series.rolling(session.on,i).sum().mean())-2*i
    low[i]=float(pd.Series.rolling(session.on,i).sum().min())-2*i
plt.plot(high,label="high",linestyle=':')
plt.plot(ave,label='ave',color='darkred')
plt.plot(low,label='low',linestyle='--')
plt.legend(loc='upper left')
plt.xlabel('$t$')
plt.ylabel('PL')


# In[126]:


plt.figure(figsize=(6,4))
pd.Series.rolling(session.on,5).std().plot(color='darkblue')
plt.ylabel('std')


# # 取引費用を含めた４つの日中リターンの収益性とリスク
# 
# ## ｔ値、取引費用を含めたリターン、単純リターン

# In[127]:


#t統計量と累積損益
plt.figure(figsize=(6,4))
n=5#移動ｔ値の計算に使うデータの個数
#移動t統計量の推定値の算出
ax=(pd.Series.rolling(session.s1,n).mean()/pd.Series.rolling(session.s1,n).std()    *np.sqrt(n)).plot(label='$t$',color='darkblue')
plt.ylabel('$t$ estimator')
plt.legend(loc='lower right')
ax2 = ax.twinx()#２番目の目盛りの設定
session['s1c']=session.s1-2
ax2=session.s1c.cumsum().plot( style="r--",label='cum PL' )
ax2=session.s1.cumsum().plot( style="r:",label='cum no cost' )
plt.ylabel('PL')
plt.legend(loc='upper left')


# In[128]:


#t統計量と累積損益
plt.figure(figsize=(6,4))
n=5#移動ｔ値の計算に使うデータの個数
#移動t統計量の推定値の算出
ax=(pd.Series.rolling(session.s12,n).mean()/pd.Series.rolling(session.s12,n).std()    *np.sqrt(n)).plot(label='$t$',color='darkblue')
plt.ylabel('$t$ estimator')
plt.legend(loc='lower right')
ax2 = ax.twinx()#２番目の目盛りの設定
session['s12c']=session.s12-2
ax2=session.s12c.cumsum().plot( style="r--",label='cum PL' )
ax2=session.s12.cumsum().plot( style="r:",label='cum no cost' )
plt.ylabel('PL')
plt.legend(loc='upper left')


# In[129]:


#t統計量と累積損益
plt.figure(figsize=(6,4))
n=5#移動ｔ値の計算に使うデータの個数
#移動t統計量の推定値の算出
ax=(pd.Series.rolling(session.s2,n).mean()/pd.Series.rolling(session.s2,n).std()    *np.sqrt(n)).plot(label='$t$',color='darkblue')
plt.ylabel('$t$ estimator')
plt.legend(loc='lower right')
ax2 = ax.twinx()#２番目の目盛りの設定
session['s2c']=session.s2-2
ax2=session.s2c.cumsum().plot( style="r--",label='cum PL' )
ax2=session.s2.cumsum().plot( style="r:",label='cum no cost' )
plt.ylabel('PL')
plt.legend(loc='upper left')


# In[130]:


#t統計量と累積損益
plt.figure(figsize=(6,4))
n=5#移動ｔ値の計算に使うデータの個数
#移動t統計量の推定値の算出
ax=(pd.Series.rolling(session.on,n).mean()/pd.Series.rolling(session.on,n).std()    *np.sqrt(n)).plot(label='$t$',color='darkblue')
plt.ylabel('$t$ estimator')
plt.legend(loc='lower right')
ax2 = ax.twinx()#２番目の目盛りの設定
session['onc']=session.on-2
ax2=session.onc.cumsum().plot( style="r--",label='cum PL' )
ax2=session.on.cumsum().plot( style="r:",label='cum no cost' )
plt.ylabel('PL')
plt.legend(loc='upper left')


# 取引費用が大きく影響を与え、リターンを押し下げている。
# 
# そこで、取引の回数を減らすために統計量を利用した、売買するタイミングを選ぶ戦略を考えてみよう。
# 
# # 統計量を利用した戦略
# 
# ## t 統計量
# リターンに制限を掛ける。

# In[131]:


#t統計量を利用した戦略
from scipy.stats import t
plt.figure(figsize=(6,4))
n=5#移動ｔ値の計算に使うデータの個数
#移動t値の算出
tt=(pd.Series.rolling(session.s1,n).mean()/pd.Series.rolling(session.s1,n).std()    *np.sqrt(n)).shift(1).dropna()
#shift(1)を用いて1単位時間前にずらしていることに注意。
#この操作をしないと将来の情報を今使っていることになる。
port=pd.concat([session.s1c,tt],axis=1).dropna()
port.columns=['s1c','t']
t0=t.ppf(0.1,n-1)#t.ppf(x,n)=累積分布関数の逆関数
#n=採択域、nは標本数
port.s1c[port.apply(lambda x:x['t']>t0,axis=1)].cumsum().plot(label='$s1 t$',                                                               linestyle='--')
session.s1c.cumsum().plot(label='$ror$',color='darkgreen')
plt.ylabel('PL')
plt.legend(loc='upper left')


# In[132]:


#t統計量を利用した戦略
from scipy.stats import t
plt.figure(figsize=(6,4))
n=5#移動ｔ値の計算に使うデータの個数
#移動t値の算出
tt=(pd.Series.rolling(session.s12,n).mean()/pd.Series.rolling(session.s12,n).std()    *np.sqrt(n)).shift(1).dropna()
#shift(1)を用いて1単位時間前にずらしていることに注意。
#この操作をしないと将来の情報を今使っていることになる。
port=pd.concat([session.s12c,tt],axis=1).dropna()
port.columns=['s12c','t']
t0=t.ppf(0.1,n-1)#t.ppf(x,n)=累積分布関数の逆関数
#n=採択域、nは標本数
port.s12c[port.apply(lambda x:x['t']>t0,axis=1)].cumsum().plot(label='$s12 t$',                                                               linestyle='--')
session.s12c.cumsum().plot(label='$ror$',color='darkgreen')
plt.ylabel('PL')
plt.legend(loc='upper left')


# In[133]:


#t統計量を利用した戦略
from scipy.stats import t
plt.figure(figsize=(6,4))
n=5#移動ｔ値の計算に使うデータの個数
#移動t値の算出
tt=(pd.Series.rolling(session.s2,n).mean()/pd.Series.rolling(session.s2,n).std()    *np.sqrt(n)).shift(1).dropna()
#shift(1)を用いて1単位時間前にずらしていることに注意。
#この操作をしないと将来の情報を今使っていることになる。
port=pd.concat([session.s2c,tt],axis=1).dropna()
port.columns=['s2c','t']
t0=t.ppf(0.1,n-1)#t.ppf(x,n)=累積分布関数の逆関数
#n=採択域、nは標本数
port.s2c[port.apply(lambda x:x['t']>t0,axis=1)].cumsum().plot(label='$s2 t$',                                                               linestyle='--')
session.s2c.cumsum().plot(label='$ror$',color='darkgreen')
plt.ylabel('PL')
plt.legend(loc='upper left')


# In[134]:


#t統計量を利用した戦略
from scipy.stats import t
plt.figure(figsize=(6,4))
n=5#移動ｔ値の計算に使うデータの個数
#移動t値の算出
tt=(pd.Series.rolling(session.on,n).mean()/pd.Series.rolling(session.on,n).std()    *np.sqrt(n)).shift(1).dropna()
#shift(1)を用いて1単位時間前にずらしていることに注意。
#この操作をしないと将来の情報を今使っていることになる。
port=pd.concat([session.onc,tt],axis=1).dropna()
port.columns=['onc','t']
t0=t.ppf(0.1,n-1)#t.ppf(x,n)=累積分布関数の逆関数
#n=採択域、nは標本数
port.onc[port.apply(lambda x:x['t']>t0,axis=1)].cumsum().plot(label='$on t$',                                                               linestyle='--')
session.onc.cumsum().plot(label='$ror$',color='darkgreen')
plt.ylabel('PL')
plt.legend(loc='upper left')


# ## χ二乗統計量
# 
# ボラティリティにより、売買を制限。カイ二乗統計量の利用。

# In[135]:


#カイ二乗統計量を利用した戦略
from scipy.stats import chi2
plt.figure(figsize=(6,4))
n=5
#１日前の移動標準偏差の算出
ss=pd.Series.rolling(session.s1,n).std().shift(1).dropna()
port=pd.concat([session.s1c,ss],axis=1).dropna()
port.columns=['s1c','s']#列に名前を付ける
s0=chi2.ppf(0.8,n-1)*140/(n-1)#140は真の値の推定値
#採択域は0.8
port.s1c[port.apply(lambda x:(x['s']<s0),axis=1)>0].cumsum().plot(label='$s1 vol$',                                                                   linestyle='--')
plt.ylabel('PL')
session.s12c.cumsum().plot(label='$ror$',color='darkgreen')
plt.legend(loc='upper left')


# In[136]:


#カイ二乗統計量を利用した戦略
from scipy.stats import chi2
plt.figure(figsize=(6,4))
n=5
#１日前の移動標準偏差の算出
ss=pd.Series.rolling(session.s12,n).std().shift(1).dropna()
port=pd.concat([session.s12c,ss],axis=1).dropna()
port.columns=['s12c','s']#列に名前を付ける
s0=chi2.ppf(0.8,n-1)*35/(n-1)#35は真の値の推定値
#採択域は0.8
port.s12c[port.apply(lambda x:(x['s']<s0),axis=1)>0].cumsum().plot(label='$s12 vol$',                                                                   linestyle='--')
plt.ylabel('PL')
session.s12c.cumsum().plot(label='$ror$',color='darkgreen')
plt.legend(loc='upper left')


# In[137]:


#カイ二乗統計量を利用した戦略
from scipy.stats import chi2
plt.figure(figsize=(6,4))
n=5
#１日前の移動標準偏差の算出
ss=pd.Series.rolling(session.s2,n).std().shift(1).dropna()
port=pd.concat([session.s2c,ss],axis=1).dropna()
port.columns=['s2c','s']#列に名前を付ける
s0=chi2.ppf(0.8,n-1)*96/(n-1)#35は真の値の推定値
#採択域は0.8
port.s2c[port.apply(lambda x:(x['s']<s0),axis=1)>0].cumsum().plot(label='$s2 vol$',                                                                   linestyle='--')
plt.ylabel('PL')
session.s2c.cumsum().plot(label='$ror$',color='darkgreen')
plt.legend(loc='upper left')


# In[138]:


#カイ二乗統計量を利用した戦略
from scipy.stats import chi2
plt.figure(figsize=(6,4))
n=5
#１日前の移動標準偏差の算出
ss=pd.Series.rolling(session.on,n).std().shift(1).dropna()
port=pd.concat([session.onc,ss],axis=1).dropna()
port.columns=['onc','s']#列に名前を付ける
s0=chi2.ppf(0.8,n-1)*70/(n-1)#35は真の値の推定値
#採択域は0.8
port.onc[port.apply(lambda x:(x['s']<s0),axis=1)>0].cumsum().plot(label='$on vol$',                                                                   linestyle='--')
plt.ylabel('PL')
session.onc.cumsum().plot(label='$ror$',color='darkgreen')
plt.legend(loc='upper left')


# ## t検定とカイ二乗検定の利用
# 

# In[139]:


#トレンドの発生とボラティリティの安定性の判定
def long_stat(s,s0,t,t1):#統計的検定による買いポジションの判定
    stat=False
    if s<s0:#ボラティリティの安定性の判定
        if t>t1:#トレンドの有無の判定
            stat=True
    return stat

def create_port(session,session2,n):
    tt=(pd.Series.rolling(session,n).mean()/pd.Series.rolling(session,n).std()        *np.sqrt(n)).shift(1).dropna()
    ss=pd.Series.rolling(session,n).std().shift(1).dropna()
    #費用込みの損益、t値と標準偏差のデータベースの作成
    port=pd.concat([session2,ss,tt],axis=1).dropna()
    port.columns=['ror','s','t']
    return port


# In[140]:


session['s1c']=session.s1-2
port=create_port(session.s1,session.s1c,n)
plt.figure(figsize=(6,4))
n=5
t0=t.ppf(0.1,n-1)
s0=chi2.ppf(0.7,n-1)*140/(n-1)
port.ror[port.apply(lambda x:long_stat(x['s'],s0,x['t'],t0),axis=1)].cumsum().plot(label='$s1$',linestyle='--')
session.s1c.cumsum().plot(label='$ror$',color='darkgreen')
plt.ylabel('PL')
plt.legend(loc='upper left')
print(s0,t0)


# In[141]:


port=create_port(session.s12,session.s12c,n)
plt.figure(figsize=(6,4))
n=5
t0=t.ppf(0.1,n-1)#t統計量の算出
s0=chi2.ppf(0.7,n-1)*38/(n-1)#標準偏差の統計量の算出、35は真の値の推定値
port.ror[port.apply(lambda x:long_stat(x['s'],s0,x['t'],t0),axis=1)].cumsum().plot(label='$s12$',linestyle='--')
session.s12c.cumsum().plot(label='$ror$',color='darkgreen')
plt.ylabel('PL')
plt.legend(loc='upper left')


# In[142]:


session['s2c']=session.s2-2
port=create_port(session.s2,session.s2c,n)
plt.figure(figsize=(6,4))
n=5
t0=t.ppf(0.1,n-1)
s0=chi2.ppf(0.7,n-1)*106/(n-1)
port.ror[port.apply(lambda x:long_stat(x['s'],s0,x['t'],t0),axis=1)].cumsum().plot(label='$s2$',linestyle='--')
session.s2c.cumsum().plot(label='$ror$',color='darkgreen')
plt.ylabel('PL')
plt.legend(loc='upper left')
print(s0,t0)


# In[143]:


session['onc']=session.on-2
port=create_port(session.on,session.onc,n)
plt.figure(figsize=(6,4))
n=5
t0=t.ppf(0.1,n-1)
s0=chi2.ppf(0.7,n-1)*75/(n-1)
port.ror[port.apply(lambda x:long_stat(x['s'],s0,x['t'],t0),axis=1)].cumsum().plot(label='$on$',linestyle='--')
session.onc.cumsum().plot(label='$ror$',color='darkgreen')
plt.ylabel('PL')
plt.legend(loc='upper left')
print(s0,t0)


# トレンドの発生とボラティリティの安定の判定は効果があるとは言えない。

# ## 12.3 視点を変える
# 
# ブレイクアウト戦略は2016年、2017年と両方の年で夜間立会ではうまく機能している。

# In[144]:


#ブレイクアウト戦略の関数
def upperbreakout(price,cost):
    j=0;s1=0;s1ch0=0#初期値設定
    r=[]#初期値設定
    da=[]#初期値設定
    for i in range(len(price)):
        d=price[i:i+1].index
        hm=price[i:i+1].index.time
        o=price.iloc[i].Open
        h=price.iloc[i].High
        c=price.iloc[i].Close
        if i>0:
            if hm==time(9,0):#日中立会
                s1=c-o#立会の間の値動き
                if h>h0 and h0>o:
                    s1ch0=c-h0-cost#ブレイク時の損益
                else:
                    s1ch0=0
            if hm==time(16,30):#夜間立会
                s2=c-o#立会の間の値動き
                if h>h0 and h0>o:
                    s2ch0=c-h0-cost#ブレイク時の損益
                else:
                    s2ch0=0
                da.append(datetime(d.year[0],d.month[0],d.day[0]))
                r.append([])
                r[j].append(s1)
                r[j].append(s1ch0)
                r[j].append(s2)
                r[j].append(s2ch0)
                j+=1
        h0=h
    result=pd.DataFrame(r,index=da)
    result.columns=['s1','s1ch0','s2','s2ch0']
    return result


# In[145]:


#ブレイクアウト戦略のグラフ表示
plt.figure(figsize=(6,4))
cost=5+2
results=upperbreakout(n225fm,cost)
results.s1ch0.cumsum().plot(label='breakout',linestyle='--')
session.s1c.cumsum().plot(label='$ror$',color='darkgreen')
plt.legend(loc='upper left')
print(results.s1ch0.std())


# In[146]:


#120日間におけるドローダウン、リスク分析
plt.figure(figsize=(6,4))
high=[0]*120
low=[0]*120
ave=[0]*120
for i in range(120):
    high[i]=float(pd.Series.rolling(results.s1ch0,i).sum().max())
    ave[i]=float(pd.Series.rolling(results.s1ch0,i).sum().mean())
    low[i]=float(pd.Series.rolling(results.s1ch0,i).sum().min())
plt.plot(high,label="high",linestyle='--')
plt.plot(ave,label='ave',color='darkred')
plt.plot(low,label='low',linestyle=':')
plt.legend(loc='upper left')
plt.xlabel('$t$')
plt.ylabel('PL')


# In[147]:


#ブレイクアウト戦略のグラフ表示
plt.figure(figsize=(6,4))
cost=5+2
results=upperbreakout(n225fm,cost)
results.s2ch0.cumsum().plot(label='breakout',linestyle='--')
session.s2c.cumsum().plot(label='$ror$',color='darkgreen')
plt.legend(loc='upper left')


# In[148]:


#120日間におけるドローダウン、リスク分析
plt.figure(figsize=(6,4))
high=[0]*120
low=[0]*120
ave=[0]*120
for i in range(120):
    high[i]=float(pd.Series.rolling(results.s2ch0,i).sum().max())
    ave[i]=float(pd.Series.rolling(results.s2ch0,i).sum().mean())
    low[i]=float(pd.Series.rolling(results.s2ch0,i).sum().min())
plt.plot(high,label="high",linestyle='--')
plt.plot(ave,label='ave',color='darkred')
plt.plot(low,label='low',linestyle=':')
plt.legend(loc='upper left')
plt.xlabel('$t$')
plt.ylabel('PL')


# In[149]:


#統計的検定を用いたブレイクアウト戦略
plt.figure(figsize=(6,4))
results.s1ch0.cumsum().plot(label='breakout',linestyle=':')
session.s1c.cumsum().plot(label='$ror$',color="darkgreen")
n=5
t0=t.ppf(0.1,n-1)
s0=chi2.ppf(0.7,n-1)*140/(n-1)
tt=(pd.Series.rolling(results.s1,n).mean()/pd.Series.rolling(results.s1,n).std()    *np.sqrt(n)).shift(1).dropna()
ss=pd.Series.rolling(results.s1,n).std().shift(1).dropna()
results['t']=tt
results['s']=ss
results.s1ch0[results.apply(lambda x:long_stat(x['s'],s0,x['t'],t0),axis=1)].cumsum().plot(label='quants',linestyle='--')
plt.legend(loc='upper left')


# In[150]:


plt.figure(figsize=(6,4))
results.s2ch0.cumsum().plot(label='breakout',linestyle=':')
session.s2c.cumsum().plot(label='$ror$',color='darkgreen')
n=5
t0=t.ppf(0.1,n-1)
s0=chi2.ppf(0.7,n-1)*106/(n-1)
tt=(pd.Series.rolling(results.s2,n).mean()/pd.Series.rolling(results.s2,n).std()    *np.sqrt(n)).shift(1).dropna()
ss=pd.Series.rolling(results.s2,n).std().shift(1).dropna()
results['t']=tt
results['s']=ss
results.s2ch0[results.apply(lambda x:long_stat(x['s'],s0,x['t'],t0),axis=1)].cumsum().plot(label='quants',linestyle='--')
plt.legend(loc='upper left')


# In[ ]:




