#!/usr/bin/env python
# -*- coding:utf-8 -*-

import os
import sys


def print_enc(str1):
    try:
        print(str1)
    except:
        print(str1.encode("utf-8"))


def tree(path=".", d=0, depth=2, tab=""):
    # 深さの指定で再帰中断
    if d == depth:
        return
    else:
        # 指定path下(未指定でカレントディレクトリ)のフォルダとファイルを取得
        file_list = []
        dir_list = []
        for p in os.listdir(path):
            if os.path.isfile(path + "/" + p):
                file_list.append(p)
            if os.path.isdir(path + "/" + p):
                dir_list.append(p)

        # ルートを表示
        if d == 0:
            print("/%s" % os.getcwd().split("\\")[-1])

        # ファイルの表示
        for i in range(len(file_list)):
            if i != len(file_list) - 1:
                print(tab + "┣━", end=' ')
                print_enc(file_list[i])
            else:
                if len(dir_list) == 0:
                    print(tab + "┗━", end=' ')
                    print_enc(file_list[i])
                else:
                    print(tab + "┣━", end=' ')
                    print_enc(file_list[i])

        # ディレクトリの表示
        for i in range(len(dir_list)):
            if i != len(dir_list) - 1:
                print(tab + "┣━", end=' ')
                print_enc(dir_list[i])
                tree(path=path + "/" + dir_list[i], d=d + 1, depth=depth, tab=tab + "┃\t")
            else:
                print(tab + "┗━", end=' ')
                print_enc(dir_list[i])
                tree(path=path + "/" + dir_list[i], d=d + 1, depth=depth, tab=tab + "  \t")

        return


if __name__ == "__main__":
    if len(sys.argv) == 2 and sys.argv[1]:
        tree(depth=int(sys.argv[1]))
    else:
        # usage:python tree.py 2 c:\temp
        if len(sys.argv) == 3 and sys.argv[1]:
            tree(path=sys.argv[2],depth=int(sys.argv[1]))
        else:
            tree()
