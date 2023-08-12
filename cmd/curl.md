```
curl http://d1ilncjhg2cjw.cloudfront.net/hub/assets/FULL_DROP_JAN_2015/large/SONY_FULL_DROP_05_[00000-10000].jpg -o ".\download\pic#1.jpg"


curl can only read single web pages files, the bunch of lines you got is actually the directory index (which you also see in your browser if you go to that URL). To use curl and some Unix tools magic to get the files you could use something like

for file in $(curl -s http://www.ime.usp.br/~coelho/mac0122-2013/ep2/esqueleto/ |
                  grep href |
                  sed 's/.*href="//' |
                  sed 's/".*//' |
                  grep '^[a-zA-Z].*'); do
    curl -s -O http://www.ime.usp.br/~coelho/mac0122-2013/ep2/esqueleto/$file
done

```

```
# get all pages 
curl 'http://domain.com/id/[1-151468]' -o '#1.html' 

# get all images 
grep -oh 'http://pics.domain.com/pics/original/.*jpg' *.html >urls.txt 

# download all images 
sort -u urls.txt | wget -i-
```

```
wget --mirror --no-parent http://www.cycustom.com/large/
```

```
wget -r -np -k http://www.ime.usp.br/~coelho/mac0122-2013/ep2/esqueleto/
Other useful options:

-nd (no directories): download all files to the current directory
-e robots=off: ignore restrictions in robots.txt file and don't download robots.txt files
-A png,jpg: accept only files with the extensions png or jpg
-m (mirror): -r --timestamping --level inf --no-remove-listing
-nc, --no-clobber: Skip download if files exist
```
