#!/usr/bin/env python
# coding: utf-8

# In[1]:


#【手把手教你】玩转Python量化金融工具之NumPy
import numpy as np


# In[2]:


a=[1,2,3,4,5,6,7,8]             #a是系列(list)
b=np.array(a)           #b是数组
print(a,b)              #打印a和b
print(type(a),type(b))  #查看a和b的类型


# In[3]:


b=b.reshape(2,4)      #改变数组的维度
print(b)              #从原来的1x8变成2x4 （两行四列）
#元素访问
print("取第1行第2列元素：",b[1][2])  #注意是从0行0列开始数！！！


# In[4]:


#变成三维数组：
c=b.reshape(2,2,2)
print(c)


# In[5]:


#特殊的数组有特别定制的命令生成，如零和1矩阵:
d=(3,4)
print(np.zeros(d))          #零矩阵
print(np.ones(d))
#默认生成的类型是浮点型，可以通过指定类型改为整型
print(np.ones(d,dtype=int))


# In[6]:


#使用range产生list
L=[i for i in a]
print(L)


# In[7]:


b=np.arange(10)     #注意包含0，不包含10
c=np.arange(0,10,2) #2表示间隔
d=np.arange(1,10,3) #3表示间隔
print(b,c,d)


# In[8]:


a=np.random.rand(3,4)      #创建指定为3行4列)的数组(范围在0至1之间)
b=np.random.uniform(0,100) #创建指定范围内的一个数
c=np.random.randint(0,100) #创建指定范围内的一个整数
print("创建指定为3行4列)的数组：\n",a)   #\n 表示换行
print("创建指定范围内的一个数：%.2f" %b) #%.2f 表示结果保留2位小数
print("创建指定范围内的一个整数：",c)


# In[9]:


#正态生成3行4列的二维数组
a= np.random.normal(1.5, 3, (3, 4))  #均值为1.5，标准差为3
print(a)
# 截取第1至2行的第2至3列(从第0行、0列算起算起)
b = a[1:3, 2:4]
print("截取第1至2行的第2至3列: \n",b)


# In[10]:


a = np.array([1,2,3,4]) #1行4列
b = np.array(2)         #只有一个元素


# In[11]:


a - b,a+b


# In[12]:


print(a)


# In[13]:


print(b)


# In[14]:


a**2  #二次方，a里元素的平方


# In[15]:


np.sqrt(a)  #开根号


# In[16]:


np.exp(a)  #e 求方


# In[17]:


np.floor(10*np.random.random((2,2))) #向下取整


# In[18]:


a.resize(2,2) #变换结构


# In[19]:


print(a)


# In[20]:


a


# In[21]:


a=np.arange(20).reshape(4,5)
print("原数组a:\n",a)
print("a全部元素和: ", a.sum())
print("a的最大值: ", a.max())
print("a的最小值: ", a.min())
print("a每行的最大值: ", a.max(axis=1))  #axis=1代表行
print("a每列的最大值: ", a.min(axis=0))  #axis=0代表列
print("a每行元素的求和: ", a.sum(axis=1)) 
print("a每行元素的均值：",np.mean(a,axis=1))
print("a每行元素的标准差：",np.std(a,axis=1))


# In[22]:


A = np.array([[0,1], [1,2]])  #数组
B = np.array([[2,5],[3,4]])   #数组
print("对应元素相乘：\n",A*B)
print("矩阵点乘：\n",A.dot(B))
print("矩阵点乘：\n",np.dot(A,B))  #(M行, N列) * (N行, Z列) = (M行, Z列)
print("横向相加：\n",np.hstack((A,B)))
print("纵向相加：\n",np.vstack((A,B)))


# In[23]:


A=np.arange(6).reshape(2,3)
A=np.asmatrix(A)                        #将数组转化成矩阵
print (A)
B=np.matrix('1.0 2.0 3.0;4.0 5.0 6.0')  #直接生成矩阵
print(B)


# In[24]:


A*B.T    #A和B已经是矩阵了，但A的列要与B的行相等才能相乘，对B进行转置（B.T）


# In[25]:


import numpy.linalg as nlg  #线性代数函数
import numpy as np
a=np.random.rand(2,2)
a=np.mat(a)
print(a)
ia=nlg.inv(a)
print("a的逆:\n",ia)


# In[26]:


a=np.array([2,4,3,9,1,4,3,4,2]).reshape(3,3)  
eig_value,eig_vector=nlg.eig(a)
print("特征值:",eig_value)
print("特征向量:",eig_vector)


# In[27]:


stocks = 2000   # 2000支股票
days =  500  # 两年大约500个交易日
# 生成服从正态分布：均值期望＝0，标准差＝1的序列

stock_day = np.random.standard_normal((stocks, days))   
print(stock_day.shape)   #打印数据组结构
# 打印出前五只股票，头五个交易日的涨跌幅情况
print(stock_day[0:5, :5])


# In[28]:


# 保留后250天的随机数据作为策略验证数据
keep_days = 250
# 统计前450, 切片切出0-250day，days = 500
stock_day_train = stock_day[:,0:days - keep_days]
# 打印出前250天跌幅最大的三支，总跌幅通过np.sum计算，np.sort对结果排序
print(np.sort(np.sum(stock_day_train, axis=1))[:3])
# 使用np.argsort针对股票跌幅进行排序，返回序号，即符合买入条件的股票序号
stock_lower = np.argsort(np.sum(stock_day_train, axis=1))[:3]
# 输出符合买入条件的股票序号
stock_lower


# In[29]:


import matplotlib.pyplot as plt  #引入画图库
get_ipython().run_line_magic('matplotlib', 'inline')
#python定义函数使用def 函数名：然后enter
def buy_lower(stock):
    #设置一个一行两列的可视化图表
    _, axs=plt.subplots(nrows=1,ncols=2,figsize=(16,5))

    #绘制前450天的股票走势图，np.cumsum():序列连续求和
    axs[0].plot(np.arange(0,days-keep_days),
               stock_day_train[stock].cumsum())

    #从第250天开始到500天的股票走势
    buy=stock_day[stock][days-keep_days:days].cumsum()
    #绘制从第450天到500天中股票的走势图
    axs[1].plot(np.arange(days-keep_days,days),buy)
    #返回从第450天开始到第500天计算盈亏的盈亏序列的最后一个值
    return buy[-1]
#假设等权重地买入3只股票
profit=0  #盈亏比例
#遍历跌幅最大的3只股票序列序号序列
for stock in stock_lower:
    #profit即三只股票从第250天买入开始计算，直到最后一天的盈亏比例
    profit+=buy_lower(stock)
    print("买入第{}只股票，从第250个交易日开始持有盈亏：{:.2f}%".format(stock,profit))


# In[ ]:




