# https://qiita.com/oppasiri330/items/c9c762a812076f69450a
# TODO

from datetime import datetime as dt
from bokeh.plotting import figure, show, output_file
from pandas_datareader import data as pdr
import fix_yahoo_finance as yf

start = dt(2018,4,1)
end = dt(2018,7,31)

yf.pdr_override()
df=pdr.get_data_yahoo(tickers="FB", start=start, end=end)

def inc_dec(close, open_):
    if close>open_:
        value="Increase"
    elif close<open_:
        value="Decrease"
    else:
        value="Equal"
    return value

#価格が増加日か減少日のコラム
df["Status"]=[inc_dec(c,o) for c,o in zip(df.Close, df.Open)]

#平均値
df["Middle"]=(df.Close+df.Open)/2

#四角形の縦の長さ。始値と終値の差の絶対値。
df["Height"]=abs(df.Open-df.Close)



#グラフ作成
p=figure(x_axis_type="datetime", width=1000, height=300, title="Candlestick Chart", sizing_mode="scale_width")
p.grid.grid_line_alpha=0.3

#中心線レイヤー。:vertival_line:HighとLow
#highのx座標、y、lowのx座標,y座標
p.segment(df.index, df.High, df.index, df.Low, color="black")

#12hour
millisecond_of_12hour=12*60*60*1000

#四角形:rectangle:OpenとClose　: 色分けあり
#四角形の中心のx,y座標。横,縦の長さを渡す。それぞれの渡すリストの長さは同じである必要がある。
p.rect(df.index[df.Status=="Increase"], df.Middle[df.Status=="Increase"], millisecond_of_12hour, df.Height[df.Status=="Increase"],
       fill_color="#CCFFFF", line_color="black")
p.rect(df.index[df.Status=="Decrease"], df.Middle[df.Status=="Decrease"], millisecond_of_12hour, df.Height[df.Status=="Decrease"],
       fill_color="#FF3333", line_color="black")

output_file("Chandlestick Chart.html")
show(p)
