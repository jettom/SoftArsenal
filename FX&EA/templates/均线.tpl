<chart>
id=132251373875493261
symbol=AUDUSDm
period=60
leftpos=1751
digits=5
scale=4
graph=1
fore=1
grid=0
volume=0
scroll=1
shift=0
ohlc=1
one_click=0
one_click_btn=1
askline=0
days=1
descriptions=0
shift_size=20
fixed_pos=0
window_left=0
window_top=0
window_right=1072
window_bottom=420
window_type=3
background_color=0
foreground_color=16777215
barup_color=65280
bardown_color=65280
bullcandle_color=0
bearcandle_color=16777215
chartline_color=65280
volumes_color=3329330
grid_color=10061943
askline_color=255
stops_color=255

<window>
height=173
fixed_height=0
<indicator>
name=main
</indicator>
<indicator>
name=Bollinger Bands
period=20
shift=0
deviations=2.000000
apply=0
color=255
style=0
weight=1
period_flags=0
show_data=1
</indicator>
<indicator>
name=Moving Average
period=144
shift=0
method=1
apply=0
color=32768
style=0
weight=2
period_flags=0
show_data=1
</indicator>
<indicator>
name=Moving Average
period=169
shift=0
method=1
apply=0
color=8421376
style=0
weight=2
period_flags=0
show_data=1
</indicator>
<indicator>
name=Moving Average
period=33
shift=0
method=2
apply=0
color=65535
style=0
weight=2
period_flags=0
show_data=1
</indicator>
</window>

<window>
height=41
fixed_height=0
<indicator>
name=MACD
fast_ema=12
slow_ema=26
macd_sma=9
apply=0
color=12632256
style=0
weight=1
signal_color=255
signal_style=2
signal_weight=1
period_flags=0
show_data=1
</indicator>
</window>

<window>
height=50
fixed_height=0
<indicator>
name=Custom Indicator
<expert>
name=Stochastic
flags=275
window_num=2
<inputs>
InpKPeriod=5
InpDPeriod=3
InpSlowing=3
</inputs>
</expert>
shift_0=0
draw_0=0
color_0=11186720
style_0=0
weight_0=0
shift_1=0
draw_1=0
color_1=255
style_1=0
weight_1=0
min=0.00000000
max=100.00000000
levels_color=12632256
levels_style=2
levels_weight=-1
level_0=20.00000000
level_1=80.00000000
period_flags=0
show_data=1
</indicator>
</window>
</chart>

