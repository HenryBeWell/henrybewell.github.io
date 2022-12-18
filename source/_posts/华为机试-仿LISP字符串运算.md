---
title: 华为机试-仿LISP字符串运算
date: 2021-06-05 08:58:48
tags:
- 递归
categories:
- 算法
---

> 题目描述：
>
> LISP语言唯一的语法就是括号要配对。 
> 形如 (OP P1 P2 …)，括号内元素由单个空格分割。 
> 其中第一个元素OP为操作符，后续元素均为其参数，参数个数取决于操作符类型 
> 注意：参数 P1, P2 也有可能是另外一个嵌套的 (OP P1 P2 …) 
> 当前OP类型为add/sub/mul/div(全小写)，分别代表整数的加减乘除法。简单起见，所以OP参数个数为2
<!-- more -->
> 举例
> -输入：(mul 3 -7)输出：-21
> 输入：(add 1 2) 输出：3
> 输入：(sub (mul 2 4) (div 9 3)) 输出 ：5
> 输入：(div 1 0) 输出：error

代码如下：

```python
"""
@author: Henry
@site: 
@software: PyCharm
@file: test3.py
@time: 2021/5/30 17:08
"""
import re

def grammer(op, num1, num2):
    num1 = int(num1)
    num2 = int(num2)
    if op == 'mul':
        return num1 * num2
    elif op == 'add':
        return num1 + num2
    elif op == 'sub':
        return num1 - num2
    else:
        if num2 == 0:
            return 'error'
        return num1 // num2

def lisp(string):
    res = re.findall(r'\(\w+ -*\d+ -*\d+\)', string)
    if res:
        cols = res[0][1:-1].split()
        pat = grammer(*cols)
        if pat != 'error':
            new_str = string.replace(res[0], str(pat))
            return lisp(new_str)
        else:
            return pat
    else:
        return string
    
if __name__ == '__main__':
    string = '(add 12 (sub 45 45))'
    string2 = '(add 1 (div -7 3))'
    print(lisp(string))
    print(lisp(string2))

```

