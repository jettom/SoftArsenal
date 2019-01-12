#【手把手教你】玩转Python金融量化利器之Pandas (ever)
import pandas as pd
import numpy as np

np.random.seed(1)     #使用随机种子，这样每次运行random结果一致，
A=np.random.randn(5)
print("A is an array:\n",A)
S = pd.Series(A)
print("S is a Series:\n",S)
print("index: ", S.index)  #默认创建索引，注意是从0开始
print("values: ", S.values)

np.random.seed(2)
s=Series(np.random.randn(5),index=['a','b','c','d','e'])
print (s)
s.index

#通过字典（dict）来创建Series。
stocks={'中国平安':'601318','格力电器':'000651','招商银行':'600036',
        '中信证券':'600030','贵州茅台':'600519'}
Series_stocks = Series(stocks)
print (s)

#使用字典创建Series时指定index的情形（index长度不必和字典相同）。
Series(stocks, index=['中国平安', '格力电器', '招商银行', '中信证券',
                       '工业富联'])
#注意，在原来的stocks（dict）里没有‘工业富联’，因此值为‘NaN’

#给数据序列和index命名：
Series_stocks.name='股票代码'        #注意python是使用.号来连接和调用
Series_stocks.index.name='股票名称'
print(Series_stocks)

#1.2 Series数据的访问
#Series对象的下标运算同时支持位置和标签两种方式
np.random.seed(3)
data=np.random.randn(5)
s = Series(data,index=['a', 'b', 'c', 'd', 'e'])
s

s[:2]   #取出第0、1行数据

s[[2,0,4]]  #取出第2、0、4行数据

s[['e', 'a']] #取出‘e’、‘a’对应数据

#1.3 Series排序函数
np.random.seed(3)
data=np.random.randn(10)
s = Series(data,index=['j','a', 'c','b', 'd', 'e','h','f','g','i'])
s

#排序
s.sort_index(ascending=True) #按index从小到大，False从大到小

s.sort_values(ascending=True)

s.rank(method='average',ascending=True,axis=0) #每个数的平均排名

#返回含有最大值的索引位置：
print(s.idxmax())
#返回含有最小值的索引位置：
print(s.idxmin())

#2.1 DataFrame数据表的创建
#DataFrame是多个Series的集合体。
#先创建一个值是Series的字典，并转换为DataFrame。
#通过字典创建DataFrame
d={'one':pd.Series([1.,2.,3.],index=['a','b','c']),
   'two':pd.Series([1.,2.,3.,4.,],index=['a','b','c','d']),
   'three':range(4),
   'four':1.,
   'five':'f'}
df=pd.DataFrame(d)
print (df)

#可以使用dataframe.index和dataframe.columns来查看DataFrame的行和列，
#dataframe.values则以数组的形式返回DataFrame的元素
print ("DataFrame index:\n",df.index)
print ("DataFrame columns:\n",df.columns)
print ("DataFrame values:\n",df.values)

#DataFrame也可以从值是数组的字典创建，但是各个数组的长度需要相同：
d = {'one': [1., 2., 3., 4.], 'two': [4., 3., 2., 1.]}
df = DataFrame(d, index=['a', 'b', 'c', 'd'])
print df

#值非数组时，没有这一限制，并且缺失值补成NaN
d= [{'a': 1.6, 'b': 2}, {'a': 3, 'b': 6, 'c': 9}]
df = DataFrame(d)
print df

#在实际处理数据时，有时需要创建一个空的DataFrame，可以这么做
df = DataFrame()
print (df)

#另一种创建DataFrame的方法十分有用，那就是使用concat函数基于Series
#或者DataFrame创建一个DataFrame
a = Series(range(5))   #range(5)产生0到4
b = Series(np.linspace(4, 20, 5)) #linspace(a,b,c)
df = pd.concat([a, b], axis=1)
print (df)

#其中的axis=1表示按列进行合并，axis=0表示按行合并，
#并且，Series都处理成一列，所以这里如果选axis=0的话，
#将得到一个10×1的DataFrame。下面这个例子展示了如何按行合并
#DataFrame成一个大的DataFrame：

df = DataFrame()
index = ['alpha', 'beta', 'gamma', 'delta', 'eta']
for i in range(5):
    a = DataFrame([np.linspace(i, 5*i, 5)], index=[index[i]])
    df = pd.concat([df, a], axis=0)
print (df)

#2.2 DataFrame数据的访问
#DataFrame是以列作为操作的基础的，全部操作都想象成先从DataFrame里取一列，
#再从这个Series取元素即可。
#可以用datafrae.column_name选取列，也可以使用dataframe[]操作选取列
df = DataFrame()
index = ['alpha', 'beta', 'gamma', 'delta', 'eta']
for i in range(5):
    a = DataFrame([np.linspace(i, 5*i, 5)], index=[index[i]])
    df = pd.concat([df, a], axis=0)
print('df: \n',df)
print ("df[1]:\n",df[1])
df.columns = ['a', 'b', 'c', 'd', 'e']
print('df: \n',df)
print ("df[b]:\n",df['b'])
print ("df.b:\n",df.b)
print ("df[['a','b']]:\n",df[['a', 'd']])

#访问特定的元素可以如Series一样使用下标或者是索引:
print (df['b'][2])       #第b列，第3行（从0开始算）
print (df['b']['gamma']) #第b列，gamma对应行

##### df.loc['列或行名']，df.iloc[n]第n行，df.iloc[:,n]第n列
#若需要选取行，可以使用dataframe.iloc按下标选取，
#或者使用dataframe.loc按索引选取
print (df.iloc[1])    #选取第一行元素
print (df.loc['beta'])#选取beta对应行元素

#选取行还可以使用切片的方式或者是布尔类型的向量：
print ("切片取数:\n",df[1:3])
bool_vec = [True, False, True, True, False]
print ("根据布尔类型取值:\n",df[bool_vec]) #相当于选取第0、2、3行

#行列组合起来选取数据：
print (df[['b', 'd']].iloc[[1, 3]])
print (df.iloc[[1, 3]][['b', 'd']])
print (df[['b', 'd']].loc[['beta', 'delta']])
print (df.loc[['beta', 'delta']][['b', 'd']])

#如果不是需要访问特定行列，而只是某个特殊位置的元素的话，
#dataframe.at和dataframe.iat
#是最快的方式，它们分别用于使用索引和下标进行访问
print(df)
print (df.iat[2, 3])  #相当于第3行第4列
print (df.at['gamma', 'd'])

2.3创建时间序列
#pandas.date_range(start=None, end=None, periods=None, freq='D',
#   tz=None, normalize=False, name=None, closed=None, **kwargs)

dates=pd.date_range('20180101',periods=12,freq='m')
print (dates)

np.random.seed(5)
df=pd.DataFrame(np.random.randn(12,4),index=dates,
                 columns=list('ABCD'))
df

#查看数据头n行 ,默认n=5
df.head()

#查看数据最后3行
df.tail(3)

#查看数据的index(索引）,columns （列名）和数据
print(df.index)

print(df.columns)

print(df.values)

#数据转置
# df.T

#根据索引排序数据排序：（按行axis=0或列axis=1）
df.sort_index(axis=1,ascending=False)

#按某列的值排序
df.sort_values('A')  #按A列的值从小到大排序

#数据选取loc和iloc
df.loc[dates[0]]

df.loc['20180131':'20180430',['A','C']]  #根据标签取数

df.iloc[1:3,1:4]  #根据所在位置取数，注意从0开始数

df.iloc[[1,3,5],[0,3]]  #根据特定行和列取数

df[df.A>0] #相当于取出A列大于0时的数据列表

df[df>0]  #显示值大于0的数，其余使用NaN代替

#数据筛选isin()
df2=df.copy() #复制df数据
df2['E']=np.arange(12)
df2

df2[df2['E'].isin([0,2,4])]

#缺失值用NaN显示

date3=pd.date_range('20181001',periods=5)
np.random.seed(6)
data=np.random.randn(5,4)
df3=pd.DataFrame(data,index=date3,columns=list('ABCD'))
df3

df3.iat[3,3]=np.NaN  #令第3行第3列的数为缺失值（0.129151）
df3.iat[1,2]=np.NaN  #令第1行第2列的数为缺失值（1.127064）
df3

#丢弃存在缺失值的行
#设定how=all只会删除那些全是NaN的行：
df3.dropna(how='any')

#删除列也一样，设置axis=1
df3.dropna(how='any',axis=1)

#thresh参数,如thresh=4,一行中至少有4个非NaN值，否则删除
df3.iloc[2,2]=np.NaN
df3.dropna(thresh=4)

#填充缺失值
#fillna 还可以使用 method 参数
#method 可以使用下面的方法
#1 . pad/ffill：用前一个非缺失值去填充该缺失值
#2 . backfill/bfill：用下一个非缺失值填充该缺失值
df3.fillna(method='ffill')

df3.fillna(method='bfill')

df3

#使在改变DataFrame 和 Series 的操作时，会返回一个新的对象，
#原对象不变，如果要改变原对象，可以添加参数 inplace = True用列均值填充
#使用该列的均值填充
df3['C'].fillna(df3['C'].mean(),inplace=True)
df3

#4、统计
date4=pd.date_range('20181001',periods=5)
np.random.seed(7)
data4=np.random.randn(5,4)
df4=pd.DataFrame(data4,index=date3,columns=list('ABCD'))
df4

df4.describe()

df4.mean() #均值，默认按列axis=0

df4.mean(axis=1)  #按行

#对数据使用函数df.apply()
df4.apply(np.cumsum) #np.cumsum()累加函数

df4.apply(lambda x:x.max()-x.min()) #lambda自定义函数
#相当于计算每列里最大值-最小值

df4['E']=['a','a','a','b','b']
df4

#计算某个值出现评率
df4['E'].value_counts()

#5、数据合并
#Concat（）
d1=pd.Series(range(5))
print(d1)
d2=pd.Series(range(5,10))
print(d2)

pd.concat([d1,d2],axis=1) #默认是纵向合并即axis=0

#pd.merge(left_on=None, right_on=None, left_index=False,
#right_index=False)
d1=pd.DataFrame(np.random.randn(3,3),columns=list('ABC'))
print(d1)
d2=pd.DataFrame(np.random.randn(3,3),columns=list('DEF'))
print(d2)
pd.merge(d1,d2,left_index=True, right_index=True)

#增加1行数据：Append()
df = pd.DataFrame(np.random.randn(3, 3), columns=['A','B','C'])
df

s=pd.Series([1.,1,1],index=list('ABC'))
df.append(s,ignore_index=True)

#聚类分析 groupby
df = pd.DataFrame({'A' : ['true', 'false', 'true', 'false',
                           'true', 'false', 'true', 'false'],
                    'B' : ['one', 'one', 'two', 'three',
                          'two', 'two', 'one', 'three'],
                    'C' : np.random.randn(8),
                    'D' : np.random.randn(8)})
df

df.groupby(['A']).sum()  #以A列特征分类并加总

df.groupby(['A','B']).sum()

#数据透视表
df = pd.DataFrame({'A' : ['one', 'one', 'two', 'three'] * 3,
                   'B' : ['A', 'B', 'C'] * 4,
                   'C' : ['foo', 'foo', 'foo', 'bar', 'bar',
                          'bar'] * 2,
                   'D' : np.random.randn(12),
                   'E' : np.random.randn(12)})
df

pd.pivot_table(df, values='D', index=['A', 'B'], columns=['C'])

#6、数据可视化（画图）
import matplotlib.pyplot as plt
from pylab import mpl
mpl.rcParams['font.sans-serif'] = ['SimHei'] # 用来正常显示中文标签
mpl.rcParams['axes.unicode_minus']=False  # 用来正常显示负号
%matplotlib inline
ts = pd.Series(np.random.randn(1000), index=pd.date_range('1/1/2000',
                periods=1000))
ts = ts.cumsum()
ts.plot(figsize=(12,8))

#利用tushare包抓取股票数据并画图
#得到的是DataFrame的数据结构
import tushare as ts
df=ts.get_k_data('sh',start='1990-01-01')
import pandas as pd
df.index=pd.to_datetime(df['date'])
df['close'].plot(figsize=(12,8))
plt.title("上证指数走势")
