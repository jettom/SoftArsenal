# book

## 1 基本コマンドとファイルの操作

### コマンドライン操作

```bash
/usr/share/man
.bash_history
bash
echo
env
export
pwd
set
unset
man
history
```

### 基本的なファイル操作

```bash
cp
find
mkdir
mv
ls
rm
rmdir
touch
tar
cpio
dd
file
gzip
gunzip
bzip2
bunzip2
xz
unxz
bzcat
xzcat
zcat
```

### ストリーム、パイプ、リダイレクション

```bash
tee
xargs
標準入力
標準出力
標準エラー出力
リダイレクト    < >
パイプ          |
```

### ファルダによる処理

```bash
cat
less
nl
head
tail
tr
sed
cut
wc
od
split
sort
uniq
join
paste
sha512sum
md5sum
sha256sum
```

## 2 正規表現とVI

### 正規表現

```bash
grep
egrep
fgrep
```

(¥,)

### VI

```bash
vi
```

h j k l
ctrl+f
ctrl+b
ZZ
wq!
:q!
:e!
i a o I A O
x dd
yy p
/ ?

## 3プロセス管理

### プロセスの生成、監視、終了

```bash
ps
top
free
```

### 実行優先度の管理

```bash
nice
renice
```

### シェルのジョブ管理

```bash
jobs
nohup
bg
fg
uptime
watch
tmux
screen
```

### シグナル送信による制御

```bash
kill
killall
pgrep
pkill
```

## 4ファイルシステムの管理

### ファイルシステムの階層標準

FHS
デバイスファイル

### パーティショニング

基本パーティション
拡張パーティション
論理パーティション、ℹ︎ノード
スワップ領域

```bash
fdisk
gdisk
parted
gparted
mkswap
swapon
swapoff
```

### ファイルシステムの作成

```bash
mkfs
mke2fs
```

ファイルシステムの種類（ext2,ext3,ext4,reiserfs,xfs,jfs,vfat,exfat）、ジャーナル

### ファイルシステムの整合性検査

```bash
df
du
fsck
e2fsck
tune2fs
dumpe2fs
debugfs
fstrim
xfs_repair
xfs_fsr
xfs_db
```

### マウントとアンマウント

```bash
/etc/fstab
mount
umount
blkid
lsblk
```

## 5ファイルの管理

### ファイルのパーミッション

```bash
id
groups
chmod
umask
chown
chgrp
```

### ハードリンクとシンポリックリンク

```bash
ln
```

### コマンドとファイルの検索

```bash
/etc/updatedb.conf
find
locat
updatedb
which
whereis
type
```

## 6 software management

### 共有ライブラリの管理

```bash
/etc/ld.so.conf
/etc/ld.so.cache

ldconfig
ldd
```

### RPM/yum パッケージ管理

```bash
/etc/yum.conf
/etc/yum.repod.d

rpm
rpm2cpio
yum
yumdownloader
zypper
```

### Debian/deb パッケージ管理

```bash
/etc/apt/sources.list

dpkg
dpkg-reconfigure
apt-get
apt-cache
```

### 仮想化ゲストとしてのLinux

## 7システムアーキテクチャ

### ハードウェアの構成と管理

```bash
/proc/cpuinfo
/proc/interrupts
/proc/ioports
lspci
modprobe
lsusb
lsmod
```

### システムのブートシーケンス

```bash
/proc/cmdline
/var/log/dmesg
dmesg
journalctl
initプロセス
BIOS
UEFI
MBR
カーネル
ブートローダ
initramfs
SysV init
systemd
```

### ブートローダの設定

```bash
menu
lst
grub.cfg
grub.conf
grub-mkconfig
grub-install
GRUB
GRUB2
```

### ランレベル/ブートターゲットの変更とシステムのシャットダウンまたはリブート

```bash
/etc/inittab
/usr/lib/systemd
/etc/systemd
telinit
init
systemctl
runlevel
shutdown
wall
```
sample
```bash 
systemctl
    multi-user.target
    graphical.target
    poweroff.targer
    rescue.target
    reboot.target 
systemctl get-default
systemctl set-default multi-user.target
systemctl set-default graphical.target
systemctl isolate poweroff.targer
systemctl status
systemctl is-active
systemctl disable
systemctl enable
systemctl start
systemctl stop
```

ランレベル
シングルユーザ
マルチユーザ
停止
再起動

# URL
## 範囲
https://linuc.org/linuc1/range/
https://www.lpi.org/our-certifications/lpic-1-overview
https://wiki.lpi.org/wiki/LPIC-1_Objectives_V5.0
## 未経験がLPIC Level1に28日で合格！勉強方法や難易度を解説
https://infra-note.net/lpic-level1/
# 試験申込
https://www.pearsonvue.co.jp/lpi
https://www.lpi.org/our-certifications/lpic-1-overview/
https://jp.lpimarketplace.com/shop/lpic-1
https://jp.lpimarketplace.com/lpi-level-1-exam-101-voucher/p/LPI-101        <-★★★
https://www.lpi.org/exam-pricing/
essentials/pro
