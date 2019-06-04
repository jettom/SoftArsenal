■leetcode java docker soulmachine/texlive
https://github.com/soulmachine/leetcode/tree/master/Java

docker pull soulmachine/texlive

docker run -it --rm -v $(pwd):/data -w /data soulmachine/texlive xelatex -synctex=1 -interaction=nonstopmode leetcode-java.tex

■
