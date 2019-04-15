#!/usr/bin/env python
# coding: utf-8

# # 第7章 確率的トレンドとは何か？
# ## 7.4 ランダムウォークの判定

# In[1]:


get_ipython().run_line_magic('matplotlib', 'inline')
import matplotlib.pyplot as plt
import statsmodels.api as sm
import pandas_datareader.data as web
import numpy as np
end='2017/12/30'
lnn225 = np.log(web.DataReader("NIKKEI225", 'fred',"1949/5/16",end)).dropna()


# In[2]:


print(sm.tsa.adfuller(lnn225.NIKKEI225,regression='nc')[0])#検定統計量
print(sm.tsa.adfuller(lnn225.NIKKEI225,regression='nc')[1])#p-値
print(sm.tsa.adfuller(lnn225.NIKKEI225,regression='nc')[2])#ラグの数
print(sm.tsa.adfuller(lnn225.NIKKEI225,regression='nc')[3])#データの数
print(sm.tsa.adfuller(lnn225.NIKKEI225,regression='nc')[4])#臨界値


# In[3]:


print(sm.tsa.adfuller(lnn225.NIKKEI225,regression='ct')[1])


# In[4]:


print(sm.tsa.adfuller(lnn225.NIKKEI225,regression='c')[1])


# In[5]:


print(sm.tsa.adfuller(lnn225.NIKKEI225,regression='c')[3])


# In[6]:


print(sm.tsa.adfuller(lnn225.NIKKEI225,regression='c')[4])


# In[7]:


print(sm.tsa.adfuller(lnn225.NIKKEI225,regression='c')[:2])


# In[8]:


print(sm.tsa.adfuller(lnn225.NIKKEI225,regression='nc')[1])


# In[9]:


print(sm.tsa.adfuller(lnn225.NIKKEI225.loc[:'1954/11/30'],regression='ct')[1])


# In[10]:


print(sm.tsa.adfuller(lnn225.NIKKEI225.loc[:'1954/11/30'],regression='c')[1])


# In[11]:


print(sm.tsa.adfuller(lnn225.NIKKEI225.loc[:'1954/11/30'],regression='nc')[1])


# In[12]:


print(sm.tsa.adfuller(lnn225.NIKKEI225.loc['1954/12/1':'1971/12/31'],regression='ct')[1])


# In[13]:


print(sm.tsa.adfuller(lnn225.NIKKEI225.loc['1954/12/1':'1971/12/31'],regression='c')[1])


# In[14]:


print(sm.tsa.adfuller(lnn225.NIKKEI225.loc['1954/12/1':'1971/12/31'],regression='nc')[1])


# In[15]:


print(sm.tsa.adfuller(lnn225.NIKKEI225.loc['1972/1/1':'1986/11/30'],regression='ct')[1])


# In[16]:


print(sm.tsa.adfuller(lnn225.NIKKEI225.loc['1972/1/1':'1986/11/30'],regression='c')[1])


# In[17]:


print(sm.tsa.adfuller(lnn225.NIKKEI225.loc['1972/1/1':'1986/11/30'],regression='nc')[1])


# In[18]:


print(sm.tsa.adfuller(lnn225.NIKKEI225.loc['1986/12/1':'1989/12/31'],regression='ct')[1])


# In[19]:


print(sm.tsa.adfuller(lnn225.NIKKEI225.loc['1986/12/1':'1989/12/31'],regression='c')[1])


# In[20]:


print(sm.tsa.adfuller(lnn225.NIKKEI225.loc['1986/12/1':'1989/12/31'],regression='nc')[1])


# In[21]:


print(sm.tsa.adfuller(lnn225.NIKKEI225.loc['1986/12/1':'1993/10/30'],regression='ct')[1])


# In[22]:


print(sm.tsa.adfuller(lnn225.NIKKEI225.loc['1986/12/1':'1993/10/30'],regression='c')[1])


# In[23]:


print(sm.tsa.adfuller(lnn225.NIKKEI225.loc['1986/12/1':'1993/10/30'],regression='nc')[1])


# In[24]:


print(sm.tsa.adfuller(lnn225.NIKKEI225.loc[:'1993/10/30'],regression='ct')[1])


# In[25]:


print(sm.tsa.adfuller(lnn225.NIKKEI225.loc[:'1993/10/30'],regression='c')[1])


# In[26]:


print(sm.tsa.adfuller(lnn225.NIKKEI225.loc[:'1993/10/30'],regression='nc')[1])


# In[27]:


print(sm.tsa.adfuller(lnn225.NIKKEI225.loc['1993/10/30':],regression='ct')[1])


# In[28]:


print(sm.tsa.adfuller(lnn225.NIKKEI225.loc['1993/10/30':],regression='c')[1])


# In[29]:


print(sm.tsa.adfuller(lnn225.NIKKEI225.loc['1993/10/30':],regression='nc')[1])


# In[30]:


print(sm.tsa.adfuller(lnn225.NIKKEI225.loc['1990/1/1':'1992/8/31'],regression='nc')[1])


# In[31]:


print(sm.tsa.adfuller(lnn225.NIKKEI225.loc['1990/1/1':'1992/8/31'],regression='c')[1])


# In[32]:


print(sm.tsa.adfuller(lnn225.NIKKEI225.loc['1990/1/1':'1992/8/31'],regression='ct')[1])


# In[33]:


z=lnn225
y=z.diff().dropna()
x=z.shift(1).dropna()
model=sm.OLS(y,x)
results=model.fit()
print("without drift  ",results.params[0])
x=sm.add_constant(x)
model=sm.OLS(y,x)
results=model.fit()
print("with drift  ",results.params[0],results.params[1])
x["t"]=range(len(y))
model=sm.OLS(y,x)
results=model.fit()
print("with drift + time trend  ",results.params[0],results.params[1],results.params[2])


# ##### 結果の解説
# 
# 日経株価平均の1949年以降のデータを用いた単位根検定では結果は0.54である。これは危険域を10%とするとそれよりも高いので、帰無仮説を棄却できない。よってドリフト付きランダムウォークである。
# 
# |景気(states)|期間-始点|終点                  |単純ランダムウォーク|ドリフト付き| ドリフト＋時間トレンド|
# |:---:|:---:|:---:                            |:---:|:---:|:---:|
# |全期間||                                     |0.99|0.09|0.84|
# |戦後復興期(recover)|1949/5/16|1954/11/30     |0.89|0.90|0.50|
# |高度経済成長期(growth)|1954/12/1|1971/12/31  |0.99|0.48|0.62|
# |安定期(stable)|1972/1/1|1986/11/30          |1.00|0.96|0.84|
# |バブル経済期(bubble)|1986/12/1|1993/10/30     |0.71|0.61|0.41|
# |バブルピークまで　　|1986/12/1|1989/12/31     |1.00|0.77|0.31|
# |経済変革期(reform)|1991/3/1|現在             |0.63|0.34|0.76|

# In[34]:


z=lnn225.loc[:"1954/11/30"]
y=z.diff().dropna()
x=z.shift(1).dropna()
model=sm.OLS(y,x)
results=model.fit()
print("nc  ",results.params)
x=sm.add_constant(x)
model=sm.OLS(y,x)
results=model.fit()
print("c  ",results.params[0],results.params[1])
x["t"]=range(len(y))
model=sm.OLS(y,x)
results=model.fit()
print("ct  ",results.params[0],results.params[1],results.params[2])


# In[35]:


z=lnn225.loc["1954/11/30":'1971/12/31']
y=z.diff().dropna()
x=z.shift(1).dropna()
model=sm.OLS(y,x)
results=model.fit()
print("nc  ",results.params)
x=sm.add_constant(x)
model=sm.OLS(y,x)
results=model.fit()
print("c  ",results.params[0],results.params[1])
x["t"]=range(len(y))
model=sm.OLS(y,x)
results=model.fit()
print("ct  ",results.params[0],results.params[1],results.params[2])


# In[36]:


z=lnn225.loc['1971/12/31':'1986/11/30']
y=z.diff().dropna()
x=z.shift(1).dropna()
model=sm.OLS(y,x)
results=model.fit()
print("nc  ",results.params)
x=sm.add_constant(x)
model=sm.OLS(y,x)
results=model.fit()
print("c  ",results.params[0],results.params[1])
x["t"]=range(len(y))
model=sm.OLS(y,x)
results=model.fit()
print("ct  ",results.params[0],results.params[1],results.params[2])


# In[37]:


z=lnn225.loc['1986/11/30':'1993/10/31']
y=z.diff().dropna()
x=z.shift(1).dropna()
model=sm.OLS(y,x)
results=model.fit()
print("nc  ",results.params)
x=sm.add_constant(x)
model=sm.OLS(y,x)
results=model.fit()
print("c  ",results.params[0],results.params[1])
x["t"]=range(len(y))
model=sm.OLS(y,x)
results=model.fit()
print("ct  ",results.params[0],results.params[1],results.params[2])


# In[38]:


z=lnn225.loc['1986/11/30':'1989/12/31']
y=z.diff().dropna()
x=z.shift(1).dropna()
model=sm.OLS(y,x)
results=model.fit()
print("nc  ",results.params)
print("nc  ",results.aic)
print("nc  ",results.bic)
print("nc  ",results.rsquared)
print("nc  ",results.rsquared_adj)
print("nc  ",results.mse_resid)
print("nc  ",results.eigenvals)
x=sm.add_constant(x)
model=sm.OLS(y,x)
results=model.fit()
print("c  ",results.params[0],results.params[1])
print("c  ",results.aic)
print("c  ",results.bic)
print("c  ",results.rsquared)
print("c  ",results.rsquared_adj)
print("c  ",results.mse_resid)
print("c  ",results.eigenvals)
x["t"]=range(len(y))
model=sm.OLS(y,x)
results=model.fit()
print("ct  ",results.params[0],results.params[1],results.params[2])
print("ct  ",results.aic)
print("ct  ",results.bic)
print("ct  ",results.rsquared)
print("ct  ",results.rsquared_adj)
print("ct  ",results.mse_resid)
print("ct  ",results.eigenvals)


# In[39]:


z=lnn225.loc['1993/10/31':]
y=z.diff().dropna()
x=z.shift(1).dropna()
model=sm.OLS(y,x)
results=model.fit()
print("nc  ",results.params)
x=sm.add_constant(x)
model=sm.OLS(y,x)
results=model.fit()
print("c  ",results.params[0],results.params[1])
x["t"]=range(len(y))
model=sm.OLS(y,x)
results=model.fit()
print("ct  ",results.params[0],results.params[1],results.params[2])


# In[40]:


z=lnn225.loc['1990/1/1':'1992/8/31']
y=z.diff().dropna()
x=z.shift(1).dropna()
model=sm.OLS(y,x)
results=model.fit()
print("nc  ",results.params)
x=sm.add_constant(x)
model=sm.OLS(y,x)
results=model.fit()
print("c  ",results.params[0],results.params[1])
x["t"]=range(len(y))
model=sm.OLS(y,x)
results=model.fit()
print("ct  ",results.params[0],results.params[1],results.params[2])


# ## 7.5 確定的トレンドと確率的トレンド

# In[41]:


get_ipython().run_line_magic('matplotlib', 'inline')
import matplotlib.pyplot as plt
import statsmodels.api as sm
import pandas_datareader.data as pdr
import numpy as np
end='2016/9/30'
lnw5000 = np.log(web.DataReader("WILL5000INDFC", 'fred',"1949/5/16",end)).dropna()
lnw5000.columns=['Close']
plt.plot(lnw5000.Close,color='hotpink')
lnw5000["t"]=range(len(lnw5000))
model=sm.OLS(lnw5000.Close,lnw5000.t)
results=model.fit()
results.fittedvalues.plot(label='prediction',style='--')
plt.ylabel('log(n225 index)')


# In[42]:


results.resid.hist(bins=50,color='lightgreen')
plt.ylabel('frequency')
plt.xlabel('residual')


# In[43]:


print(results.summary())

