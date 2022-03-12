# screenshot
## 关闭「预览」程序里的「复原修改」功能
defaults write com.apple.Preview NSQuitAlwaysKeepsWindows -bool FALSE

## 改变截图文件后缀格式
defaults write com.apple.screencapture type [type] && killall SystemUIServer

将 type 替换成你要的图片格式即可，注意：格式只能用三位字母代表，比如 png、jpg 等。

## 改变截图保存位置
defaults write com.apple.screencapture location [path] && killall SystemUIServer
defaults write com.apple.screencapture location ~/Pictures/screens/
killall SystemUIServer

使用此命令可修改截图默认的保存目录（默认是桌面），比如将 path 修改为：/Users/dann/Documents/Screenshots，这样截图就能自动保存到文稿目录下的 Screenshots 文件夹内，如果你的网络云盘同步速度不错，也可以将自动保存目录设定为 Dropbox 的同步目录。

如果你懒得输入长长的目录路径，也可以将打开 Finder 里的目录窗口直接拖入「终端」，即可自动生成目录路径。

## 去除窗口截图四周的阴影
这是许多朋友都在问我的问题，使用以下命令可以立即去除：

defaults write com.apple.screencapture disable-shadow -bool true && killall SystemUIServer

## 还原成带阴影的窗口截图执行以下命令：
defaults write com.apple.screencapture disable-shadow -bool false && killall SystemUIServer

## 改变截图默认文件名命名规则
defaults write com.apple.screencapture name [file name] && killall SystemUIServer
defaults write com.apple.screencapture name JtPics && killall SystemUIServer

如果你不喜欢「屏幕快照 + 时间」的截图命名方式，你可以自行定义文件名，将 file name 替换即可。

# mac tools
https://www.youtube.com/watch?v=DhuSAHICALI
1:59 必装神器 Alfred
5:01 实时状态监控 iStat Menus
8:35 窗口吸附 Magnet
9:41 容器软件 Dropover
12:04 MacOS深度定制 TinkerTool
14:15 截屏神器 Monosnap
17:18 目录自动备份Sync folders Pro
