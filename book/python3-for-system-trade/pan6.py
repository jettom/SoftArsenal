#!/usr/bin/env python
# coding: utf-8

# # 第6章　トレンドをモデル化しよう
# ## 6.4 日経平均株価の確定的トレンド

# In[1]:


import pandas_datareader.data as web
import statsmodels.api as sm
import numpy as np
end='2019/12/30'
n225 = web.DataReader("NIKKEI225", 'fred',"1949/5/16",end).dropna()
lnn225=np.log(n225.dropna())
lnn225.columns=['Close']
y=lnn225
x=range(len(lnn225))
x=sm.add_constant(x)
model=sm.OLS(y,x)
results=model.fit()


# In[2]:


print(results.summary())


# In[3]:


get_ipython().run_line_magic('matplotlib', 'inline')
import matplotlib.pyplot as plt
plt.plot(y,label='Close',color="darkgray")
results.fittedvalues.plot(label='prediction',style='--')
plt.ylabel('log(n225 index)')
plt.legend(loc='upper left')


# In[4]:


results.resid.plot(color="seagreen")
plt.ylabel('residual')


# In[5]:


results.resid.hist(bins=100,color="lightgray")
plt.xlabel('residual')
plt.ylabel('frequency')


# In[6]:


y=lnn225.loc[:'1954/11/30'].dropna()
x=range(len(y))
x=sm.add_constant(x)
model=sm.OLS(y,x)
results=model.fit()
print(results.summary())


# In[7]:


results.resid.std()


# In[8]:


plt.plot(y,label='Close',color='darkgray')
results.fittedvalues.plot(label='prediction',style='--')
plt.legend(loc='upper left')
plt.ylabel('log(n225 index)')


# In[9]:


y=lnn225.loc['1954/12/1':'1971/12/31'].dropna()
x=range(len(y))
x=sm.add_constant(x)
model=sm.OLS(y,x)
results=model.fit()
print(results.summary())


# In[10]:


plt.plot(y,label='Close',color='seagreen')
results.fittedvalues.plot(label='prediction',style='--')
plt.legend(loc='upper left')
plt.ylabel('log(n225 index)')


# In[11]:


y=lnn225.loc['1972/1/1':'1986/11/30'].dropna()
x=range(len(y))
x=sm.add_constant(x)
model=sm.OLS(y,x)
results=model.fit()
print(results.summary())


# In[12]:


plt.plot(y,label='Close',color='hotpink')
results.fittedvalues.plot(label='prediction',style='--')
plt.legend(loc='upper left')
plt.ylabel('log(n225 index)')


# In[13]:


y=lnn225.loc['1986/12/1':'1993/10/31'].dropna()
x=range(len(y))
x=sm.add_constant(x)
model=sm.OLS(y,x)
results=model.fit()
print(results.summary())


# In[14]:


plt.plot(y,label='Close',color='seagreen')
results.fittedvalues.plot(label='prediction',style='--')
plt.legend()
plt.ylabel('log(n225 index)')


# In[15]:


y=lnn225.loc['1986/12/1':'1989/12/31'].dropna()
x=range(len(y))
x=sm.add_constant(x)
model=sm.OLS(y,x)
results=model.fit()
print(results.summary())


# In[16]:


print("return ",np.exp(y.Close).pct_change().mean()*250)
print("volatility ",y.Close.diff().std()*np.sqrt(250))
print("std of residual",results.resid.std())
plt.plot(y,label='Close',color='darkgray')
results.fittedvalues.plot(label='prediction',style='--')
plt.legend(loc='upper left')
plt.ylabel('log(n225 index)')


# In[17]:


results.resid.hist(bins=10,color="yellow")
plt.xlabel('residual')
plt.ylabel('frequency')


# In[18]:


y=lnn225.loc['1990/1/1':'1992/8/31'].dropna()
x=range(len(y))
x=sm.add_constant(x)
model=sm.OLS(y,x)
results=model.fit()
print(results.summary())


# In[19]:


print("return ",np.exp(y.Close).pct_change().mean()*250)
print("volatility ",y.Close.diff().std()*np.sqrt(250))
print("std of residual",results.resid.std())
plt.plot(y,label='Close',color='seagreen')
results.fittedvalues.plot(label='prediction',style='--')
plt.legend()
plt.ylabel('log(n225 index)')


# In[20]:


results.resid.hist(bins=10,color="mistyrose")
plt.xlabel('residual')
plt.ylabel('frequency')


# In[21]:


y=lnn225.loc['1993/11/1':].dropna()
x=range(len(y))
x=sm.add_constant(x)
model=sm.OLS(y,x)
results=model.fit()
print(results.summary())


# In[22]:


print("return ",np.exp(y.Close).pct_change().mean()*250)
print("volatility ",y.Close.diff().std()*np.sqrt(250))
print("std of residual",results.resid.std())
plt.plot(y,label='Close',color='hotpink')
results.fittedvalues.plot(label='prediction',style='--')
plt.legend()
plt.ylabel('log(n225 index)')


# In[23]:


results.resid.hist(color='lightgray')
plt.xlabel('residual')
plt.ylabel('frequency')


# |景気(states)|期間-始点|終点|リターン|ボラティリティ|回帰係数|切片|残差標準偏差|
# |:---:|:---:|:---:|---:|:---:|:---:|:---:|:---:|
# |戦後復興期(recover)|1949/5/16|1954/11/30    |14%|23%|0.0011|4.5236|0.2537|
# |高度経済成長期(growth)|1954/12/1|1971/12/31 |13%|14%|0.0004|6.1675|0.2278|
# |安定期(stable)|1972/1/1|1986/11/30         |11%|13%|0.0004|8.1001|0.1263|
# |バブル経済期(bubble)|1986/12/1|1993/10/31    | 3%|23%|-0.0002|10.2897|0.2025|
# |バブルのピークまで|1986/12/1|1989/12/31     |26%|18%|0.0008|9.9122|0.05441|
# |経済変革期(reform)|1993/10/31|現在            | 1%|24%|-0.0001|9.7276|0.2647|

# In[ ]:




