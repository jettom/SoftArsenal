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

## 5

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

## 7
