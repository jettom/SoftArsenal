
# coding: utf-8

# # DataFrame

# In[1]:


#import the packages "Pandas" and "MatPlotLib" into Jupyter Notebook
import pandas as pd
import matplotlib.pyplot as plt
get_ipython().magic('matplotlib inline')


# In[2]:


#import Facebook's stock data
fb = pd.DataFrame.from_csv('../data/facebook.csv')


# In[3]:


print(fb.head())


# In[4]:


#It is your turn to import Microsoft's stock data - "microsoft.csv", which is located in the same folder of facebook.csv
#Replace "None" with your code
ms = pd.DataFrame.from_csv('../data/microsoft.csv')


# In[6]:


# print head of ms, 1 line
print(ms.head())


# ** Expected Output: **

# <tr>
#     <th>Date</th>
#     <th>Open</th>  
#     <th>High</th>
#     <th>Low</th>
#     <th>Close</th>
#     <th>Adj Close</th>
#     <th>Volume</th>
# </tr>
# <tr>
#     <td>2014-12-31</td>
#     <td>46.730000</td>  
#     <td>47.439999</td>
#     <td>46.450001</td>
#     <td>46.450001</td>
#     <td>42.848763</td>
#     <td>21552500</td>
# </tr>
# <tr>
#     <td>2015-01-02</td>
#     <td>46.660000</td>  
#     <td>47.419998</td>
#     <td>46.540001</td>
#     <td>46.759998</td>
#     <td>43.134731</td>
#     <td>27913900</td>
# </tr>
# <tr>
#     <td>2015-01-05</td>
#     <td>46.369999</td>  
#     <td>46.730000</td>
#     <td>46.250000</td>
#     <td>46.330002</td>
#     <td>42.738068</td>
#     <td>39673900</td>
# </tr>
# <tr>
#     <td>2015-01-06</td>
#     <td>46.380001</td>  
#     <td>46.750000</td>
#     <td>45.540001</td>
#     <td>45.650002</td>
#     <td>42.110783</td>
#     <td>36447900</td>
# </tr>
# <tr>
#     <td>2015-01-07</td>
#     <td>45.980000</td>  
#     <td>46.459999</td>
#     <td>45.490002</td>
#     <td>46.230000</td>
#     <td>42.645817</td>
#     <td>29114100</td>
# </tr>
# 

# ## Show the size of a DataFrame using "Shape"

# In[6]:


print(fb.shape)


# In[7]:


# print the shape of ms, 1 line
ms.shape


# ## Show summary statistics of a DataFrame

# In[8]:


# print summary statistics of Facebook
print(fb.describe())


# In[9]:


# print summary statistics of Microsoft
ms. describe()


# ## Locate a particular row of data using "Selection by label"

# In[10]:


# select all the price information of Facebook in 2016.
fb_2015 = fb.loc['2015-01-01':'2015-12-31']


# In[11]:


# print the price of Facebook on '2015-03-16'
print(fb_2015.loc['2015-03-16'])


# In[12]:


# select all the price information of Microsoft in 2016.
ms_2016 = ms.loc['2016-01-01':'2016-12-31']


# In[13]:


# print the price of Microsoft on '2016-03-16'
print(ms_2016.loc['2016-03-16'])


# ** Expected Output: **

# <tr>
#     <td>Open</td>
#     <td>5.345000e+01</td>
# </tr>
# <tr>
#     <td>High</td>
#     <td>5.460000e+01</td>
# </tr>
# <tr>
#     <td>Low</td>
#     <td>5.340000e+01</td>
# </tr>
# <tr>
#     <td>Close</td>
#     <td>5.435000e+01</td>
# </tr>
# <tr>
#     <td>Adj Close</td>
#     <td>5.187095e+01</td>
# </tr>
# <tr>
#     <td>Volume</td>
#     <td>3.169170e+07</td>
# </tr>

# ## Locate a particular row of data using "Selection by position"

# In[14]:


# print the opening price of the first row
print(fb.iloc[0, 0])


# In[15]:


# print the opening price of the last row
print(ms.iloc[779, 0])


# ** Expected Output: ** 90.559998

# ## Plot the stock data using plot() method

# In[16]:


plt.figure(figsize=(10, 8))
fb['Close'].plot()
plt.show()


# In[16]:


plt.figure(figsize=(10, 8))
# plot only the Close price of 2016 of Microsoft, 1 line 
ms_2016['Close'].plot()
plt.show()


# ** Expected Ouput: **

# <img src="MS2016.png">
