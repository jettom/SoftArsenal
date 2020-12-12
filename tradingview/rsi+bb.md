//@version=4
study(title="RSI with BB", shorttitle="RSI with BB", format=format.price, precision=2)
 
//Relative Strength Indexより
src = close, len = input(14, minval=1, title="RSI Period")
up = rma(max(change(src), 0), len)
down = rma(-min(change(src), 0), len)
rsi = down == 0 ? 100 : up == 0 ? 0 : 100 - (100 / (1 + up / down))
plot(rsi, color=color.purple)
 
//RSIにBBを適用する
bb_len = input(20 ,minval=1,title="BB Period")//BBの期間
sma = sma (rsi ,bb_len)//SMAの計算
dev = stdev(rsi ,bb_len)//σの計算
plot(sma+dev*2, color=color.blue, title="BB +2σ")//BBのプロット
plot(sma, color=color.red, title="BB basis")//SMAのプロット
plot(sma-dev*2, color=color.blue, title="BB -2σ")//BBのプロット


//;BBの計算部分(12～17行目)
//12行目：BBの期間を設定しています。

//13,14行目：BBのセンターラインとσの計算をしています。通常と異なり、第1引数にソースとして8行目で計算されたrsiを渡しています。

//15,16,17行目：BBのセンターラインと±2σをプロットしています。