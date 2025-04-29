+++
title = "常用代理与镜像设置方法"
date = 2022-10-04
[taxonomies]
tags = ["proxy"]
categories = ["常用技术速查"]
+++

## GIT

```
# 设置http:
git config --global http.proxy http://127.0.0.1:1080
# 设置https:
git config --global https.proxy http://127.0.0.1:1080
# 设置socks:
git config --global http.proxy 'socks5://127.0.0.1:1080'
git config --global https.proxy 'socks5://127.0.0.1:1080'
## 取消
git config --global --unset http.proxy
git config --global --unset https.proxy
```

或者通过`git config --global -e`编辑配置文件

```ini
[https "https://github.com"]
	proxy = socks5://127.0.0.1:7891
```
