# MD5 cal certutil
certutil -hashfile D:hoge.exe MD5
ハッシュ アルゴリズムは以下のものが指定可能
デフォルトはSHA1
MD2
MD4
MD5
SHA1
SHA256
SHA384
SHA512

# ipconfig
## Flush Your DNS Resolver Cache
ipconfig /flushdns

# ping

# tracert

# dig

# shutdown
shutdown /s /t 0: Performs a regular shut down.
shutdown /r /t 0: Restart the computer.
shutdown /r /o: Restarts the computer into advanced options.

# sfc /scannow

# netstat -an: List Network Connections and Ports

# nslookup: Find the IP Address Associated With a Domain

# ARP

# NbtStat

# hostname

# Route

# pathping

# netdiag

# getmac

# NETSH
## view your network information
    netsh interface ipv4 show config
## Change Your IP Address, Subnet Mask, and Default Gateway
    netsh interface ipv4 set address name="Wi-Fi" static 192.168.3.8 255.255.255.0 192.168.3.1
    netsh interface ipv4 set address name=”YOUR INTERFACE NAME” source=dhcp
## Change Your DNS Settings
    netsh interface ipv4 set dns name="Wi-Fi" static 8.8.8.8
    netsh interface ipv4 set dns name="Wi-Fi" static 8.8.4.4 index=2
    netsh interface ipv4 set dnsservers name"YOUR INTERFACE NAME" source=dhcp


# net
    net use p: \\192.168.1.81\share password /user:sakura
    net use p: /delete

# taskkill

# systeminfo

# net view

cleanmgr.exe /D C: /VERYLOWDISK /SETUP
