#!/usr/bin/env python
# coding: utf-8

# # 第8章　さらにグラフィカルに調べよう
# ## 8.2 自己相関と偏自己相関

# In[1]:


get_ipython().run_line_magic('matplotlib', 'inline')
import pandas as pd
import pandas_datareader.data as web
import numpy as np
import matplotlib.pyplot as plt
import statsmodels.api as sm
n225 = web.DataReader("NIKKEI225", 'fred',"1949/5/16").dropna()
lnn225=np.log(n225)
fig = plt.figure(figsize=(8,2))
ax1 = fig.add_subplot(1,2,1)
fig = sm.graphics.tsa.plot_acf(lnn225.squeeze(), lags=5000, color='lightgray',ax=ax1)
ax2 = fig.add_subplot(1,2,2)
fig = sm.graphics.tsa.plot_pacf(lnn225.squeeze(), lags=40,color='lightgray', ax=ax2)


# In[2]:


arma_mod = sm.tsa.ARMA(lnn225,order=(1,0))
arma_res = arma_mod.fit(trend='c', disp=-1)
print(arma_res.summary())


# In[3]:


arma_res.resid.iloc[1:].plot(figsize=(6,4),color='seagreen')
plt.ylabel('$\hat{z_t}$')


# In[4]:


from statsmodels.tsa import stattools
acf,q,pvalue = stattools.acf(arma_res.resid,nlags=5,qstat=True)
pacf,confint = stattools.pacf(arma_res.resid,nlags=5,alpha=0.05)
print("自己相関係数：",acf)
print("p値:",pvalue)
print("偏自己相関:",pacf)
print("95%信頼区間:",confint)


# In[5]:


p=sm.tsa.adfuller(arma_res.resid,regression='nc')[1] #[1]はp値の検定結果
p1=sm.tsa.adfuller(arma_res.resid,regression='c')[1] #[1]はp値の検定結果
print("ドリフト無しランダムウォーク p値:",p)
print("ドリフト付きランダムウォーク p値:",p1)


# In[6]:


from scipy.stats import t
resid=arma_res.resid.iloc[1:]
m=resid.mean()
v=resid.std()
resid_max=pd.Series.rolling(arma_res.resid,window=250).mean().max()
resid_min=pd.Series.rolling(arma_res.resid,window=250).mean().min()
print("平均:              %2.5f"%m,"標準偏差：          %2.4f"%v)
print("250日平均の最大値: %2.5f"%resid_max,"250日平均の最小値: %2.5f"%resid_min)
print("250日平均の95%の信頼区間: ",(t.interval(alpha=0.95, df=250, loc=0, scale=v)))


# In[7]:


pd.Series.rolling(arma_res.resid.iloc[1:],250).mean().plot(figsize=(6,4),color='hotpink')
plt.ylabel('$\hat{z_t}$')


# In[8]:


from scipy.stats import chi2
resid=arma_res.resid.iloc[1:]
m=resid.mean()
v=resid.std()
resid_max=pd.Series.rolling(arma_res.resid,window=250).std().max()
resid_min=pd.Series.rolling(arma_res.resid,window=250).std().min()
print("平均:                 %2.5f"%m,"        標準偏差：    %2.5f"%v)
print("250日標準偏差の最大値:%2.5f"%resid_max,"250日標準偏差の最小値:%2.5f"%resid_min)

cint1,cint2=chi2.interval(alpha=(0.95), df=249)

print("250日標準偏差の95pctの信頼区間:%2.4f"%(np.sqrt(cint1/249)*v),)
print("<= \sigma <=%2.4f"%(np.sqrt(cint2/249)*v))


# In[9]:


pd.Series.rolling(arma_res.resid.iloc[1:],250).std().plot(figsize=(6,4),color='darkgray')
plt.ylabel('$std$')


# In[10]:


bcs=["1949/5/16","1954/12/1","1972/1/1","1986/12/1","1986/12/1",
     "1993/11/1","1999/2/1","2002/2/1","2009/4/1"]
bce=["1954/11/30","1971/12/31","1986/11/30","1989/12/31","1993/10/30",
     "1999/1/31","2002/1/31","2009/3/31","2012/11/30"]
for i in range(len(bcs)):
    y=lnn225.loc[bcs[i]:bce[i]].dropna()
    fig = plt.figure(figsize=(8,2))
    ax1 = fig.add_subplot(1,2,1)
    fig = sm.graphics.tsa.plot_acf(y.squeeze(), lags=120, ax=ax1,color='darkgray')
    plt.title(bcs[i]+' - acf')
    ax2 = fig.add_subplot(1,2,2)
    fig = sm.graphics.tsa.plot_pacf(y.squeeze(), lags=20, ax=ax2,color='seagreen')
    plt.title(bcs[i]+' - pacf')


# In[11]:


for i in range(len(bcs)):
    y=lnn225.loc[bcs[i]:bce[i]].dropna()
    arma_mod = sm.tsa.ARMA(y,order=(1,0))
    arma_res = arma_mod.fit(trend='c', disp=-1)
    print(bcs[i],arma_res.arparams,arma_res.resid.std())


# In[ ]:




