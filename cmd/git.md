# 基本的な使い方
git --version

git --help

$ git config --globaluser.name "Taro Yamada"
$ git config --globaluser.email Taro.Yamada@xxx.yyyy.com


git config --list
$ git config user.name
$ git config user.email

# 
git init

git status

git add [ファイル名]
git add .
git add [folder]/*
git add -f [folder]/*
git status

git commit
git commit -m "projectX version 1.0"
git status

git log


git reset HEAD
git reset

git rm --cached [ファイル名]

$git reset --soft HEAD^

$ git reset --hard HEAD^


git branch
git log --oneline --decorate --graph --all

# branch
git branch

## push to remote
git remote add origin ssh://git@github.com:UserName/ProjectName
git push -u origin master

## ssh: Could not resolve hostname UserName: nodename nor servname provided, or not known
git remote rm origin
git remote add origin git@github.com:UserName/ProjectName
git push -u origin master

## fatal: remote origin already exists.
git remote rm origin
git remote add origin git@github.com:UserName/ProjectName
git push -u origin master

## ssh-keygen
```
ssh-add -K ~/.ssh/id_ed25519
$ eval $(ssh-agent -s)
$ ssh-add ~/.ssh/id_ed25519
```

# local ssh key
$cd ~/.ssh
$ssh-keygen -t rsa

$ pbcopy < ~/.ssh/id_rsa.pub (Mac)
$ clip < ~/.ssh/id_rsa.pub (Windows)
## set rsa key in github.com

$ ssh -T git@github.com

git remote set-url origin git@github.com:XXXX/XXXXX.git

