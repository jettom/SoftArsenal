#!/usr/bin/env python
# coding: utf-8

# # 第4章 PandasとMatplotlibを使ってみよう
# ## 4.1 データのダウンロード

# In[1]:


import pandas_datareader.data as web
start="1949/5/16"
end="2019/3/30"#適当に入れ替えてください。
N225 = web.DataReader("NIKKEI225", 'fred',start,end)
N225.head(1)


# In[2]:


N225.tail(1)


# In[3]:


get_ipython().run_line_magic('matplotlib', 'inline')
import matplotlib.pyplot as plt
N225.plot(color='darkblue')
plt.ylabel('N225 index')


# In[4]:


N225.to_csv("NIKKEI225.csv")


# In[5]:


get_ipython().run_line_magic('matplotlib', 'inline')
import numpy as np
np.log(N225).plot(color='darkblue')
plt.ylabel('N225 index')


# plt.show()を追加することにより出力の仕方が変わりました。

# ## 4.2 データベースの加工

# In[9]:


price = web.DataReader("^N225",'yahoo',"1984/1/4",end)
price.head(1)
price.tail(1)


# In[10]:


import pandas as pd
fx = web.DataReader('DEXJPUS',"fred",start,end)
port=pd.concat([price.Close,fx],axis=1).dropna()


# In[11]:


n=port.Close.pct_change().dropna()
f=port.DEXJPUS.pct_change().dropna()
f.rolling(window=20).corr(n).plot(color="yellow")
plt.ylabel('correlation')


# In[12]:


import datetime
end=datetime.datetime.now()
start="1980/1/1"
price = web.DataReader("AAPL", 'yahoo',start,end)


# In[13]:


price1=price.loc["1990/1/1":]#ixの停止によりlocに変更
price1.Close.plot(color='green')
price2=price["2015"].iloc[0:2]#ixの停止によりilocに変更
print(price2)
plt.ylabel('apple')


# In[14]:


print(price.resample('M').first().tail())


# In[15]:


print(price.resample('M').last().tail())


# In[16]:


print(price.resample('M',loffset='1d').last().tail())


# In[17]:


price.resample('A').Close.plot(color='magenta')
plt.ylabel('apple')


# ## 4.3 データの加工、分析
# 

# In[18]:


import numpy as np
dp=np.log(price.Close).diff()
vol=dp.std()*np.sqrt(250)
print(vol,len(price))


# In[19]:


import pandas as pd
ma=pd.Series.rolling(price.Close,window=250).mean()
price.Close.plot(label='aapl Close',style='--')
ma.plot(label='250days ma')
plt.ylabel('aapl')
plt.legend()


# In[20]:


(pd.Series.rolling(np.log(price.Close).diff().dropna(),window=25).std()*np.sqrt(250)).plot()
plt.ylabel('standrd deviation 250 days aapl')


# In[ ]:





# In[ ]:




