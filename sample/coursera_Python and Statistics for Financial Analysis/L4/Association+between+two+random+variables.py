
# coding: utf-8

# # Association between two random variables

# In[2]:


import pandas as pd
import matplotlib.pyplot as plt
get_ipython().magic('matplotlib inline')


# In[4]:


# Import the housing information for analysis 

housing = pd.DataFrame.from_csv('../data/housing.csv', index_col=0)
housing.head()


# In[5]:


# Use covariance to calculate the association

housing.cov()


# In[6]:


# Use correlation to calculate the association is more appropriate in this case
housing.corr()


# In[7]:


# scatter matrix plot
from pandas.tools.plotting import scatter_matrix
sm = scatter_matrix(housing, figsize=(10, 10))


# ## Let's do an analysis by yourself!
# 
# ## Observe the association between LSTAT and MEDV:

# In[8]:


# This time we take a closer look at MEDV vs LSTAT。 What is the association between MEDV and LSTAT you observed?
housing.plot(kind='scatter', x='LSTAT', y='MEDV', figsize=(10, 10))

