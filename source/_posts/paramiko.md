---
title: paramiko
date: 2019-11-03 20:15:03
tags:
- python
- package
categories:
- python
- package
---
paramiko的使用
<!-- more -->

```python
# encoding: utf-8

"""
@author: Henry
@site: 
@software: PyCharm
@file: transfer.py
@time: 2019/11/3 20:00
"""

import os
import paramiko
from paramiko.ssh_exception import NoValidConnectionsError, AuthenticationException, SSHException

class SshRemoteHost(object):
    def __init__(self, hostname, port, user, passwd):
        self.hostname = hostname
        self.port = port
        self.user = user
        self.passwd = passwd

    def do_cmd(self, cmd):
        client = paramiko.SSHClient()
    
        client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    
        try:
    
            client.connect(hostname=self.hostname,
                           port=self.port,
                           username=self.user,
                           password=self.passwd)
    
            print("正在连接%s......." % (self.hostname))
        except NoValidConnectionsError as e:
            print("连接失败:", e)
        except AuthenticationException as e:
            print("密码错误")
        else:
            # 4. 执行操作
            stdin, stdout, stderr = client.exec_command(cmd)
    
            # 5.获取命令执行的结果
            result = stdout.read().decode('utf-8')
            print(result)
        finally:
            # 6.关闭连接
            client.close()
    
    def do_put(self, localdir=None, remotedir=None):
        """
        上传文件
        :return:
        """
        if not localdir:
            localdir = os.getcwd()
        print('正在上传...')
        # 获取Transport实例
        tran = paramiko.Transport(self.hostname, int(self.port))
        try:
            # 连接SSH服务端
            tran.connect(username=self.user, password=self.passwd)
        except SSHException as e:
            print('连接失败:', e)
        else:
            # 获取SFTP实例
            sftp = paramiko.SFTPClient.from_transport(tran)
            files = os.listdir(localdir)
            print(files)
            files = ['t1.txt', 't2.txt']
            print(files)
            for f in files:
                print('####################################################')
                print('Begin to upload file  to %s ' % self.hostname)
                print('Uploading ', os.path.join(localdir, f))
                sftp.put(os.path.join(localdir, f), os.path.join(remotedir, f))
                print('Upload Success  ', os.path.join(localdir, f))
            else:
                print('上传文件信息错误')
        finally:
            tran.close()
    
    def do_get(self, remotedir, localdir=None):
        if not localdir:
            localdir = os.getcwd()
        print('正在下载...')
        # 获取Transport实例
        tran = paramiko.Transport(self.hostname, int(self.port))
        try:
            # 连接SSH服务端
            tran.connect(username=self.user, password=self.passwd)
        except SSHException as e:
            print('连接失败: ', e)
        else:
            # 获取SFTP实例
            sftp = paramiko.SFTPClient.from_transport(tran)
            try:
    
                remote_files = sftp.listdir(remotedir)
                for f in remote_files:  # 遍历读取远程目录里的所有文件
                    sftp.get(os.path.join(remotedir, f), os.path.join(localdir, f))
            except IOError:  # 如果目录不存在则抛出异常
                return ("remote_path or local_path is not exist")
        finally:
            tran.close()

if __name__ == '__main__':
    """
    1.上传文件到服务器
    2.复制服务器文件到指定目录
    3.运行python脚本
    4.下载文件到本地
    """
    hostname = '****'
    port = '22'
    user = '**'
    passwd = '****'
    cmd = 'cd /home/student/test;pwd;cp test.py ../test_2'
    localdir = ''
    remotedir1 = '~/student/test'
    remotedir2 = '~/student/test_2'
    client = SshRemoteHost(hostname, port, user, passwd)

# client.do_put(localdir, remotedir1)

    client.do_cmd(cmd)
    client.do_get(remotedir2, localdir)

```

