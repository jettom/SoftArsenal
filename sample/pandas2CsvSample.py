#https://qiita.com/oppasiri330/items/c9c762a812076f69450a
#python (ever)
# done
import pandas

url="http://www.geocities.jp/shdqm/syuttyo/kaiseki4.htm"

#htmlのテーブルごとにリストの要素になる。
df = pandas.read_html(url)
print(df[0])
#>>>表が表示

df[0].to_csv
