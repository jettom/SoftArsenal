//@version=4
study(title="Moving Average", shorttitle="MA", overlay=true, resolution="")
len = input(9, minval=1, title="Length")
src = input(close, title="Source")
offset = input(title="Offset", type=input.integer, defval=0, minval=-500, maxval=500)
out = sma(src, len)
plot(out, color=color.blue, title="MA", offset=offset)
