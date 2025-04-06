# logs
``` apache
# top 10 ip
cat access.log.1 | cut -f 1 -d ' ' | sort | uniq -c | sort -k 1 -n -r | head -10
# top 10 url
cat access.log.1 | cut -f 7 -d ' ' | sort | uniq -c | sort -k 1 -n -r | head 10

strings /usr/bin/.sshd | grep '[1-9]{1-3}.[1-9]{1,3}.'
```
# sys login
'''
# last user login info
lastlog
# last user login error info
## /var/log/wtmp, /var/log/btmp
lastb
# /var/log/utmp  loging user info
'''