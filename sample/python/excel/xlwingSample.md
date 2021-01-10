# 获得一个excel的各个sheet的data
```
import xlwings as xw
app = xw.App(visible = False, add_book = False) 
workbook = app.books.open('e:\\table\\信息表.xlsx')  
worksheet = workbook.sheets
for j in worksheet:  
    contents = j.range('A1').expand('table').value
    print(contents)
```

# 往一个excel追加一个（n个）sheet，并且从A1开始赋值
```
import xlwings as xw

file_path = 'e:\\table\\销售表.xlsx'
app = xw.App(visible = False, add_book = False) 
workbooks = app.books.open(file_path)
# need todo
name="new"
contents=[]
for i in range(1):
    name=name+i
    workbooks.sheets.add(name = name, after = len(workbooks.sheets))  
    workbooks.sheets[name].range('A1').value = contents
workbooks.save()      
app.quit()
```

# 列出一个目录下的所有excel
```
import os

file_path = '分部信息'  
file_list = os.listdir(file_path)  
for i in file_list:  
    if os.path.splitext(i)[1] == '.xlsx':  
        # temp excel
        if i.startswith('~$'):
            continue
        print(file_path + '\\' + i)  
```

# 在多个工作簿的指定工作表中批量追加行数据.py
## 最后的行数的获得。
```
import xlwings as xw
newContent = [['双肩包', '64', '110'], ['腰包', '23', '58']]
app = xw.apps.add()
workbook = app.books.open(file_path + '\\' + i)  
# for
worksheet = workbook.sheets['产品分类表']
values = worksheet.range('A1').expand()
# 目前的行数
number = values.shape[0]  
# 行数加1开始，设置新值
worksheet.range(number + 1, 1).value = newContent  

workbook.save()
workbook.close()

app.quit()
```

# 修正并且保存 TODO

