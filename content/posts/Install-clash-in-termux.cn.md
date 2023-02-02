---
title: "借助Termux在安卓手机上运行Clash代理服务"
date: 2022-02-09T09:33:46+08:00
---

# 在 Termux 中部署 Clash 并实现旁路由

魅族提供了 root 权限，但是开启之后就意味着放弃以后官方维护的可能性了。
经过几天的折腾，我吧我的魅蓝 6（人生第一部手机）作为家庭软路由，满足一些上网需求。

## 相关工具的官网介绍

- [Termux][termux]: an Android terminal emulator and Linux environment app that works directly with no rooting or setup required. A minimal base system is installed automatically - additional packages are available using the APT package manager.
- [Clash][clash]: A rule-based tunnel in Go.
- [Clash Dashboard][clash-dashboard]: Web Dashboard for Clash, now host on ClashX

[termux]: https://termux.com
[clash]: https://github.com/Dreamacro/clash
[clash-dashboard]: https://github.com/Dreamacro/clash-dashboard

## 工具安装

### 安装 Termux

官方推荐从[F-Droid](https://f-droid.org/packages/com.termux/)中安装 Termux，
可以直接在网页中下载 APK 文件进行安装，也可以安装 F-Droid 以方便及时更新。
在完成 termux 安装之后最好先运行`termux-change-repo`来[切换软件源](https://mirrors.tuna.tsinghua.edu.cn/help/termux/)，这样之后的下载工作会方便很多。
为了方便可以在手机上运行 sshd 服务，从而实现在电脑上远程登录。

### 安装 clash

官方提供了 clash 的安装包，你可能需要

```sh
pkg install clash
```

运行 clash 代理需要一个 clash 配置文件，通常是一个 yaml 文件。

```sh
clash -f <配置文件本地地址>
```

终端会打印出相应服务运行所在的端口，包括 RESTful API，HTTP 代理，SOCKS 代理端口，
例如以下信息：

```plainText
INFO[0000] RESTful API listening at: [::]:9090
INFO[0000] HTTP proxy listening at: [::]:7890
INFO[0000] SOCKS proxy listening at: [::]:7891
```

还需要知道自己设备的端口，通常进入手机的 wifi 设置中可以看到自己手机在局域网中的 wifi 地址，
可以在 termux 中输入`ip addr`查看，以下命令可能可以帮助查找：

```sh
ip addr | grep -Eo '192.[0-9]+.[0-9]+.[0-9]+'|head -1
```

比如我的 ip 地址是`192.168.0.102`，可以到路由器中将 ip 设置为固定 ip（似乎也叫静态 ip，或者叫与 mac 绑定）。
也可以在手机中将 IP 设置（通常为 DHCP）改为静态并手动设置 IP。
这个 ip 地址就是我们运行代理服务的代理服务器地址。

### 管理 clash

[clash-dashboard][clash-dashboard]和[yacd](https://github.com/haishanh/yacd)是目前主要的两个 clash 管理程序，都是 vue 程序。
可以直接在网站[clash-dashboard](http://clash.razord.top/)和[yacd](http://yacd.haishan.me/)使用，使用的时候填入运行 clash 时设置的`external-controller`（配置文件中）或者`-ext-ctl`（命令行）地址即可。

另外，clash 提供了`-ext-ui`（命令行）或`external-ui`（配置文件）选项，可以本地部署这两个 app。

```sh
git clone -b gh-pages https://github.com/Dreamacro/clash-dashboard.git
```

克隆完成之后，
可以使用通过 clash 的`-ext-ui`参数来将构建好的 web 应用托管到网络中。

```sh
clash -f <配置文件本地地址> -ext-ui "clash-dashboard"
```

在浏览器中打开`<ip地址>:<RESTful Api端口号>/ui`,就应该可以看到管理面板了，在打开的界面中填入 clash 服务的 ip 地址和 RESTful API 的端口号即可，即可进行控制。

![](/images/clash-dashboard-config.png)

## 通过代理共享

### windows 设置系统代理

（我使用的是 win10）进入`设置`，`网络与Internet`，选择**代理**，在**手动设置代理**中填入代理服务器地址和端口，打开**使用代理服务器**。

### mac 设置 WiFi 代理

打开`设置`，进入`网络`，在 Wi-Fi 中选择高级，进入**代理**选项卡，在网页代理(HTTP)、安全网页代理(HTTPS)、SOCKS 代理中填入相应的代理服务器地址和端口，并应用。**忽略这些主机与域的代理设置**中可以设置如下内容

```plainText
192.168.0.0/16、10.0.0.0/8、172.16.0.0/12、127.0.0.1、localhost、*.local、timestamp.apple.com、*.cn
```

### 安卓设置 WiFi 代理

（我使用的 MIUI12）进入 Wi-Fi，点击连接的 Wifi，下滑在`代理`中选择手动，主机名填入代理服务器地址，端口填写 http 代理服务端口。
如果想代理手机中的所有用户的流量，应该考虑通过 vpn，如使用软件[SocksDroid](https://play.google.com/store/apps/details?id=net.typeblog.socks)

## 旁路由

旁路由需要再 root 权限下运行 clash，我摸索着实现了，这里仅仅简要记录，建议参看相关链接。

### 修改配置文件

将配置文件做如下修改，参考自[Hackl0us/SS-Rule-Snippet](https://github.com/Hackl0us/SS-Rule-Snippet)

```yaml
redir-port: 7895 #透明代理端口
dns:
  enable: true
  listen: 0.0.0.0:8053 #dns运行的端口
  ipv6: true
  default-nameserver:
    - 223.5.5.5
    - 114.114.114.114
  enhanced-mode: fake-ip
  fake-ip-range: 198.18.0.1/16 #fake-ip 范围
  nameserver:
    - https://doh.pub/dns-query
    - https://dns.alidns.com/dns-query
  fallback-filter:
    geoip: false
    ipcidr:
      - 240.0.0.0/4
      - 0.0.0.0/32
```

### 设置 iptables 让手机作为网关

```sh
## 参考自 https://jiajunhuang.com/articles/2022_11_20-router.md.html

dnsport="8053" #dns运行所在端口
redirport="7895" #透明代理端口
fakeip="198.18.0.0" #fake-ip范围
router="192.168.1.6" #旁路由地址，即为手机ip地址

# ENABLE ipv4 forward
sysctl -w net.ipv4.ip_forward=1

# 转发所有 DNS 查询到 8053 端口
# 此操作会导致所有 DNS 请求全部返回虚假 IP(fake ip 198.18.0.1/16)
iptables -t nat -I PREROUTING -p udp --dport 53 -j REDIRECT --to $dnsport

# 这个是fake-ip对应的dns地址，一般不用动
iptables -t nat -A PREROUTING -p tcp --dport $dnsport -d $fakeip/24 -j clash_dns
iptables -t nat -A PREROUTING -p udp --dport $dnsport -d $fakeip/24 -j clash_dns
iptables -t nat -A PREROUTING -p tcp -j clash

# 让当前机器成为一个网关服务器
iptables -t filter -A FORWARD -j ACCEPT
iptables -t nat -A POSTROUTING -s 192.168.0.0/16 -j MASQUERADE

iptables -t nat -N clash
iptables -t nat -N clash_dns

# 这里需要注意的是，下面两行最后的 192.168.1.21 是当前旁路由的 IP 地址，请根据你自己的实际情况修改
# 目的DNS端口是后面clash配置里面的5354
iptables -t nat -A clash_dns -p udp --dport $dnsport -d $fakeip/24 -j DNAT --to-destination $router:$dnsport
iptables -t nat -A clash_dns -p tcp --dport $dnsport -d $fakeip/24 -j DNAT --to-destination $router:$dnsport

# 绕过一些内网地址，（RETURN 表示退出当前Chain，返回到上一级的Chain继续匹配）
iptables -t nat -A clash -d 0.0.0.0/8 -j RETURN
iptables -t nat -A clash -d 10.0.0.0/8 -j RETURN
iptables -t nat -A clash -d 127.0.0.0/8 -j RETURN
iptables -t nat -A clash -d 169.254.0.0/16 -j RETURN
iptables -t nat -A clash -d 172.16.0.0/12 -j RETURN
iptables -t nat -A clash -d 192.168.0.0/16 -j RETURN
iptables -t nat -A clash -d 224.0.0.0/4 -j RETURN
iptables -t nat -A clash -d 240.0.0.0/4 -j RETURN

# 注意, 这边的7892对应后续clash配置里的redir-port
iptables -t nat -A clash -p tcp -j REDIRECT --to-ports $redirport
```
