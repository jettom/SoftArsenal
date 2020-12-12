//@version=4
study("3MA3BB",overlay = true)

//MA
ma_src = input(close, title="MA Source")//MAのソース

EmaOrSma1 = input(title="MA1 Type", defval="EMA", options=["EMA", "SMA"])//EMA,SMAの選択
ma_len1 = input(50, minval=1, title="MA1 Period")//MAの長さ
ma1 = EmaOrSma1 == "EMA" ? ema(ma_src, ma_len1) : sma(ma_src, ma_len1)//MAの計算
plot(ma1, color=color.blue, transp=0, linewidth=4, title="MA1")//MAのプロット

EmaOrSma2 = input(title="MA2 Type", defval="EMA", options=["EMA", "SMA"])//EMA,SMAの選択
ma_len2 = input(100, minval=1, title="MA2 Period")//MAの長さ
ma2 = EmaOrSma2 == "EMA" ? ema(ma_src, ma_len2) : sma(ma_src, ma_len2)//MAの計算
plot(ma2, color=color.yellow, transp=0, linewidth=4, title="MA2")//MAのプロット

EmaOrSma3 = input(title="MA3 Type", defval="EMA", options=["EMA", "SMA"])//EMA,SMAの選択
ma_len3 = input(200, minval=1, title="MA3 Period")//MAの長さ
ma3 = EmaOrSma3 == "EMA" ? ema(ma_src, ma_len3) : sma(ma_src, ma_len3)//MAの計算
plot(ma3, color=color.red, transp=0, linewidth=4, title="MA3")//MAのプロット

//BB
bb_src = input(close ,title="BB Source")//BBのソース
bb_len = input(20 ,minval=1,title="BB Period")//BBの期間
sma = sma (bb_src ,bb_len)//SMAの計算
dev = stdev(bb_src ,bb_len)//σの計算
plot(sma+dev*3, title="BB +3σ")//BBのプロット
plot(sma+dev*2, title="BB +2σ")//BBのプロット
plot(sma+dev, title="BB *1σ")//BBのプロット
plot(sma, title="BB basis")//SMAのプロット
plot(sma-dev, title="BB -1σ")//BBのプロット
plot(sma-dev*2, title="BB -2σ")//BBのプロット
plot(sma-dev*3, title="BB -3σ")//BBのプロット


//MA(移動平均線)のコード(4～21行目まで)
//移動平均線を3本描画しています。2,3本目は繰り返しなので1本目について説明します。
//
//
//5行目：ma_src = input(close, title=“MA Source”)
//MAの計算に使用するソースを指定しています。
//input関数を使用する事でユーザーが設定可能になります。第1引数は初期値で、close(終値)を指定しています。第2引数は設定画面の名称です。
//
//7行目：EmaOrSma1 = input(title=“MA1 Type”, defval=“EMA”, options=[“EMA”, “SMA”])
//EMAとSMAを選択できるようにしています。
//第1引数のtitleは設定画面の名称を、第2引数のdefvalは初期値を、第3引数のoptionsは選択肢を設定しています。
//
//8行目：ma_len1 = input(50, minval=1, title=“MA1 Period”)
//MAの期間を設定しています。
//第1引数で初期値を、第2引数のminvalで最小入力値を、第3引数で設定画面の名称を設定しています。
//
//9行目：ma1 = EmaOrSma1 == “EMA” ? ema(ma_src, ma_len1) : sma(ma_src, ma_len1)
//EMAとSMAの選択と計算をしています。
//ma1=条件式 ? 式1 : 式2 という
//“?”と”:”を使った書式になっており、条件式がtrueなら式1が、falseなら式2が実行されます。
//ema関数、sma関数は、第1引数にソースを、第2引数に期間を与えて移動平均を計算します。
//
//10行目：plot(ma1, color=color.blue, transp=0, linewidth=4, title=“MA1”)
//計算結果をプロットしています。
//plot関数は第1引数でプロットする対象を、第2引数のcolorで色を、第3引数で透明度を、第4引数で線の太さを、第5引数で設定画面の名称を設定しています。
//
//BB(ボリンジャーバンド)のコード(22～33行目まで)
//センターラインと±1～3σまでを描画しています。
//
//23行目：bb_src = input(close ,title=“BB Source”)//BBのソース
//BBのソースを指定しています。
// 
//24行目：bb_len = input(20 ,minval=1,title=“BB Period”)//BBの期間
//BBの期間を指定しています。
// 
//25行目：sma = sma (bb_src ,bb_len)
//センターラインのSMAを計算しています。
// 
//26行目：dev = stdev(bb_src ,bb_len)
//σ(標準偏差)を計算しています。
// 
//27～33行目まで：plot(sma+dev*3, title=“BB +3σ”)
//各のラインを計算してプロットしています。

//invest-7.com

