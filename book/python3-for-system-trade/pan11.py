#!/usr/bin/env python
# coding: utf-8

# # 第11章　季節性とマクロ変数を加える?
# ## 11.3 季節性の具体例

# In[1]:


from scipy.stats import t
import pandas as pd
import pandas_datareader.data as web
import numpy as np
end='2017/12/30'
n225 = web.DataReader("NIKKEI225", 'fred',"1949/5/16",end).dropna()
develop=n225.loc[:'1989/12/31']
reform=n225.loc['1989/12/31':]
year=n225.loc['1989']
years=[x+1950 for x in range(66)]
m=lambda x:x.month
count=[0]*12
alpha=0.1
for i in range(len(years)):
    year=n225.loc[str(years[i])]
    r=year.pct_change().groupby([m])
    tv=r.mean()/r.std()*np.sqrt(r.count())
    t0=t.ppf(1-alpha,len(r)-1)
    for j in range(12):
        if float(tv.iloc[j])>t0:# and years[i]>=1990:
            count[j]+=1
print(count)


# In[2]:


from scipy.stats import t
import pandas as pd
import pandas_datareader.data as pdr
import numpy as np
m=lambda x:x.month
count=[0]*12
alpha=0.1
for i in range(len(years)):
    year=n225.ix[str(years[i])]
    r=year.pct_change().groupby([m])
    tv=r.mean()/r.std()*np.sqrt(r.count())
    t0=t.ppf(1-alpha,len(r)-1)
    for j in range(12):
        if float(tv.iloc[j])>t0 and years[i]>=1990:
            count[j]+=1
print(count)
print(t0)


# In[3]:


from scipy.stats import t
import pandas as pd
import pandas_datareader.data as pdr
import numpy as np
m=lambda x:x.month
count=[0]*12
for i in range(len(years)):
    year=n225.ix[str(years[i])]
    r=year.pct_change().groupby([m])
    tv=r.mean()/r.std()*np.sqrt(r.count())
    t0=t.ppf(1-alpha,len(r)-1)
    for j in range(12):
        if float(tv.iloc[j])>t0:# and years[i]>=1990:
            count[j]+=1
print(count)


# In[4]:


from scipy.stats import t
import pandas as pd
import pandas_datareader.data as pdr
import numpy as np
m=lambda x:x.month
count=[0]*12
for i in range(len(years)):
    year=n225.ix[str(years[i])]
    r=year.pct_change().groupby([m])
    tv=r.mean()/r.std()*np.sqrt(r.count())
    t0=-t.ppf(1-alpha,len(r)-1)
    for j in range(12):
        if float(tv.iloc[j])<t0:# and years[i]>=1990:
            count[j]+=1
print(count)


# In[5]:


from scipy.stats import t
import pandas as pd
import pandas_datareader.data as pdr
import numpy as np
m=lambda x:x.month
count=[0]*12
for i in range(len(years)):
    year=n225.ix[str(years[i])]
    r=year.pct_change().groupby([m])
    tv=r.mean()/r.std()*np.sqrt(r.count())
    t0=-t.ppf(1-alpha,len(r)-1)
    for j in range(12):
        if float(tv.iloc[j])<t0 and years[i]>=1990:
            count[j]+=1
print(count)


# In[6]:


w=lambda x:x.week
count=[0]*5
for i in range(len(years)):
    year=n225.ix[str(years[i])]
    r=year.pct_change().groupby([w])
    tv=r.mean()/r.std()*np.sqrt(r.count())
    t0=t.ppf(1-alpha,len(r)-1)
    for j in range(5):
        if float(tv.iloc[j])>t0:
            count[j]+=1
print(count)


# In[7]:


w=lambda x:x.week
count=[0]*5
for i in range(len(years)):
    year=n225.ix[str(years[i])]
    r=year.pct_change().groupby([w])
    tv=r.mean()/r.std()*np.sqrt(r.count())
    t0=t.ppf(1-alpha,len(r)-1)
    for j in range(5):
        if float(tv.iloc[j])>t0 and years[j]>1990:
            count[j]+=1
print(count)


# In[8]:


w=lambda x:x.week
count=[0]*5
for i in range(len(years)):
    year=n225.ix[str(years[i])]
    r=year.pct_change().groupby([w])
    tv=r.mean()/r.std()*np.sqrt(r.count())
    t0=-t.ppf(1-alpha,len(r)-1)
    for j in range(5):
        if float(tv.iloc[j])<t0:
            count[j]+=1
print(count)


# In[9]:


from scipy.stats import t
import pandas as pd
import pandas_datareader.data as pdr
import numpy as np
w=lambda x:x.week
count=[0]*5
for i in range(len(years)):
    year=n225.ix[str(years[i])]
    r=year.pct_change().groupby([w])
    tv=r.mean()/r.std()*np.sqrt(r.count())
    t0=-t.ppf(1-alpha,len(r)-1)
    for j in range(5):
        if float(tv.iloc[j])<t0 and years[j]>1990:
            count[j]+=1
print(count)


# ## 11.4 マクロ変数との関係(単回帰と多変量解析)

# In[10]:


import pandas_datareader.data as pdr
import numpy as np
start='1971/12/1'
end='2017/12/30'
workpop = web.DataReader('LFWA64TTJPM647S',"fred",start,end).dropna()
gdp = web.DataReader('MKTGDPJPA646NWDB',"fred",start,end).dropna()
gdp=gdp.resample('A',loffset='-1d').last().dropna()
fx = web.DataReader('DEXJPUS',"fred",start,end).dropna()
fx=fx.resample('A',loffset='-1d').last().dropna()
workpop=workpop['1972':].resample('A',loffset='-1d').last().dropna()
gdpjpy=gdp.MKTGDPJPA646NWDB*fx.DEXJPUS
gdpjpy=np.log(gdpjpy).dropna()
workpop=np.log(workpop).dropna()


# In[11]:


import statsmodels.api as sm
x=sm.add_constant(gdpjpy)
model=sm.OLS(gdpjpy,x)
results=model.fit()
print(results.summary())


# In[12]:


get_ipython().run_line_magic('matplotlib', 'inline')
import matplotlib.pyplot as plt
f,ax = plt.subplots()#２軸のグラフの準備
ax.plot(gdpjpy,label='gdp',linestyle="--")
ax2=ax.twinx()#２軸目をax2として設定
ax2.plot((workpop),label='workpop')#２軸目にプロット
results.fittedvalues.plot(label='fitted',style=':',ax=ax)
ax.set_ylabel('log GDP')#1軸目にラベルを設定
ax2.set_ylabel('workshop')#2軸目にラベルを設定
ax.legend(loc='lower right')
ax2.legend(loc='upper left')


# In[13]:


import matplotlib.pyplot as plt
results.resid.hist(label='residual',color='seagreen')
plt.xlabel('residual:gdp vs work population')
plt.ylabel('frequency')
plt.legend(loc='upper right')


# In[14]:


import pandas as pd
lnn225 = np.log(pdr.DataReader("NIKKEI225", 'fred',start,end).dropna())
lnn225=lnn225.resample('A',loffset='-1d').last().dropna()
port=pd.concat([lnn225,x,gdpjpy],axis=1).dropna()
port.columns=["n225","const","workpop","gdpjpy"]
model=sm.OLS(port.n225,port.iloc[:,1:])
results=model.fit()
print(results.summary())


# In[15]:


#多変量解析：折れ線グラフ
f,ax = plt.subplots()#２軸のグラフの準備
(port.gdpjpy-24).plot(label='gdp',linestyle="--",ax=ax)
port.n225.plot(label='n225',ax=ax)
ax2=ax.twinx()#２軸目をax2として設定
(port.workpop).plot(label='workpop',ax=ax2,style='o')
results.fittedvalues.plot(label='fitted',style=':',ax=ax)
plt.legend(loc='upper left')
ax.set_ylabel('log Nikkei225 index')#1軸目にラベルを設定
ax2.set_ylabel('workshop')#2軸目にラベルを設定
ax.legend(loc='lower right')
ax2.legend(loc='upper left')


# In[16]:


#多変量解析：ヒストグラム
results.resid.hist(label='residual',color='mistyrose')
plt.xlabel('residual:gdp vs work population')
plt.ylabel('frequency')
plt.legend(loc='upper right')


# In[17]:


#バブル崩壊前
port_b=port[:'1990/1/1']
model_b=sm.OLS(port_b.n225,port_b.iloc[0:,1:])
results_b=model_b.fit()
print(results_b.summary())


# In[18]:


#バブル崩壊前のグラフ
f,ax = plt.subplots()#２軸のグラフの準備
(port[:'1990/1/1'].gdpjpy-24).plot(label='gdp',linestyle="--",ax=ax)
port[:'1990/1/1'].n225.plot(label='n225',ax=ax)
ax2=ax.twinx()#２軸目をax2として設定
(port[:'1990/1/1'].workpop).plot(label='workpop',style='o',ax=ax2)
#書籍のグラフはworkpopから8.5引いてしまっているので、こちらが正しいグラフです。
results_b.fittedvalues.plot(label='fitted',style=':',ax=ax)
ax.set_ylabel('log Nikkei225 index')#1軸目にラベルを設定
ax2.set_ylabel('workshop')#2軸目にラベルを設定
ax.legend(loc='lower right')
ax2.legend(loc='upper left')


# In[19]:


#バブル崩壊前：ヒストグラム
results_b.resid.hist(label='residual',color='yellow')
plt.xlabel('residual:gdp vs work population')
plt.ylabel('frequency')
plt.legend(loc='upper right')


# In[20]:


#バブル崩壊後
port_a=port['1990/1/1':]
results_a=(sm.OLS(port_a.n225,port_a.iloc[0:,1:])).fit()
print(results_a.summary())


# In[21]:


import pandas as pd
lnn225 = np.log(pdr.DataReader("NIKKEI225", 'fred',start,end).dropna())
lnn225=lnn225.resample('A',loffset='-1d').last().dropna()
lnfx=np.log(fx)
port1=pd.concat([lnn225,x,gdpjpy,lnfx],axis=1).dropna()
port1.columns=["n225","const","workpop","gdpjpy","fx"]
model1=sm.OLS(port1.n225,port1.iloc[0:,1:])
results1=model1.fit()
print(results1.summary())


# In[22]:


#バブル崩壊後：要素にドル円の為替レートを追加
port1_a=port1['1990/1/1':]
results1_a=(sm.OLS(port1_a.n225,port1_a.iloc[0:,1:])).fit()
print(results1_a.summary())


# In[23]:


##バブル崩壊後のグラフ：ドル円の為替レート
(port1['1990/1/1':].fx+5).plot(label='fx',linestyle="--")
port1['1990/1/1':].n225.plot(label='n225')
results1_a.fittedvalues.plot(label='fitted',style=':')
plt.ylabel('log Nikkei225 Index')
plt.legend(loc='lower left')


# In[24]:


#バブル崩壊後：細分化
def report(port):
    results1_a=(sm.OLS(port1_a.n225,port1_a.iloc[0:,1:]))    .fit()
    print("R-squared: ",results1_a.rsquared," F-pvalue: ",results1_a.f_pvalue," AIC: "          ,results1_a.aic," BIC: ",results1_a.bic)
    print("pvalues: ")
    print(results1_a.pvalues)
    from statsmodels.compat import lzip
    import statsmodels.stats.api as sms
    test=sms.jarque_bera(results1_a.resid)
    print("jbpv: ",test[1])
port1_a=port1['1990/1/1':'2000/1/1']
report(port1_a)


# In[25]:


#バブル崩壊後：細分化2
port1_a=port1.loc['2000/1/1':'2008/1/1']
report(port1_a)


# In[26]:


#バブル崩壊後：細分化3
port1_a=port1.loc['2008/1/1':]
report(port1_a)


# In[ ]:




