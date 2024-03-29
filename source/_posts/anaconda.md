---
title: anaconda
date: 2019-09-11 21:10:26
tags:
- envs
- python
categories:
- 环境搭建
---

anconda安装及使用
<!-- more -->
## 安装

1. 可直接在清华源中下载：https://mirrors.tuna.tsinghua.edu.cn/anaconda/archive/

## 更换源

1. 命令行更换：

   ```shell
   conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
   conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge 
   conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/msys2/
   
   # 设置搜索时显示通道地址
   conda config --set show_channel_urls yes
   ```

2. 直接修改文件

​                 一般路径为

```
C:\Users\Admin\.condarc
```

将文件修改为

```shell
channels:
  - https://mirrors.ustc.edu.cn/anaconda/pkgs/main/
  - https://mirrors.ustc.edu.cn/anaconda/cloud/conda-forge/
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
  - defaults
show_channel_urls: true
```

## 常用语法

```shell
conda list
conda info -e    #用于查看拥有的环境
conda remove -n 虚拟环境名称 --all    #删除对应环境
conda create –name 新名 –clone 旧名    #用于克隆，改名也蛮好的
activate 环境名称  # windows用于激活虚拟环境
```

## 在jupyter中应用虚拟环境

```shell
conda activate # 新环境 
 
conda install ipykernel    #经测试每个新环境都要装一次，不然下一句无法运行，但是不用重装jupyter
 
python -m ipykernel install --user --name 环境名称 --display-name "Python (环境名称)"    #添加新环境到jupyter中
 
jupyter notebook    #在对应环境下打开jupyter
```

## 更改jupyter-notebook的起始文件位置

https://www.zhihu.com/question/31600197

## 可能出现的问题

1. conda无法联网下载或更新package

可能的原因：

- 本地使用代理服务器

解决办法：

1. 暂时关掉代理服务器

2. 并将.condarc文件中的https改为http，且删掉-defaults

3. ```shell
   conda config --set ssl_verify no
   ```

## 参考

https://stackoverflow.com/questions/42563757/conda-update-condahttperror-http-none

https://blog.csdn.net/a15182894547/article/details/85634416