+++
title = "我的latex工作流"
date = 2023-10-13
[taxonomies]
tags = ["latex","排版工具"]
categories = ["常用技术速查"]
+++

# 我的latex工作流

继WSL/gWSL技术使得”windows成为最好的Linux发行版“之后，
加上overleaf也是运行在linux里面的，
我发现我们的latex工作流完全可以全部迁移到*nix系统之中了。
这样的好处是我可以统一用linux的一些规范，避免一些不同系统带来的问题。

- [LATEX安装教程](https://mirrors.tuna.tsinghua.edu.cn/CTAN/info/install-latex-guide-zh-cn/install-latex-guide-zh-cn.pdf)

## 我遇到过的错误

### 找不到字体STIX TWO MATH

ubuntu里面可以直接用`sudo apt install fonts-stix`安装`stix`，但是它和所需的不一样。

- [stix2字体下载地址](https://github.com/stipub/stixfonts/tree/master/zipfiles): 我用的ttf格式
- [Linux 安装字体](https://linuxstory.org/install-new-fonts/)