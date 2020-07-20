#
# @lc app=leetcode.cn id=192 lang=bash
#
# [192] 统计词频
#

# @lc code=start
# Read from the file words.txt and output the word frequency list to stdout.
cat words.txt | tr -cs [:alnum:] '[\n*]'|sort|uniq -c|sort -nrk1|awk '{print $2,$1}'

# @lc code=end

