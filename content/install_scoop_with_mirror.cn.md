+++
title = "windows 系统安装 Scoop 包管理工具"
date = 2022-01-25
[taxonomies]
categories = ["常用技术速查"]
tags = ["SCOOP", "windows"]
+++

**该内容似乎已经过时**，因为目前[似乎](https://zhuanlan.zhihu.com/p/360677731)github.com.cnpmjs.org 和 hub.fastgit.org 镜像均无法使用

# windows 系统安装 Scoop 包管理工具

<https://scoop.sh/>是一款 windows 系统下的包管理工具，根据官网只需要以下命令即可安装。

```powershell
iwr -useb get.scoop.sh | iex
#Note = if you get an error you might need to change the execution policy (i.e. enable Powershell) with
Set-ExecutionPolicy RemoteSigned -scope CurrentUser
```

实际使用中，通常需要镜像加速以及修改安装位置，所以结合文章[Windows 下 Scoop 安装、配置与使用](https://blog.csdn.net/luoyooi/article/details/102990113)，在此，我记录一下我的安装过程。

## 安装 SCOOP

由于我的 C 盘空间有限，[可以修改安装位置](https://github.com/ScoopInstaller/Scoop#installation)我将目标目录修改为

```powershell
#将Scoop安装到自定义目录(命令行方式),默认为C:\Users<user>\scoop
$env:SCOOP='D:\Applications\Scoop'
[Environment]::SetEnvironmentVariable('SCOOP', $env:SCOOP, 'User')
#将Scoop配置为将全局程序安装到自定义目录 SCOOP_GLOBAL(命令行方式),默认为C:\ProgramData\scoop
$env:SCOOP_GLOBAL='D:\Applications\GlobalScoopApps'
[Environment]::SetEnvironmentVariable('SCOOP_GLOBAL', $env:SCOOP_GLOBAL, 'Machine')
```

我的网络质量不佳，无法直接使用`iwr -useb get.scoop.sh | iex`安装，可以借助镜像，来实现安装，下面的脚本会自动替换掉安装脚本中的 github 的链接。

```powershell
#可能需要通过下面的命令设置权限之后再安装
Set-ExecutionPolicy RemoteSigned -scope CurrentUser
#iwr -useb get.scoop.sh | iex
#网络慢可以使用下面替换为cnpm和fastgit的链接
iwr -useb https://raw.fastgit.org/ScoopInstaller/Scoop/master/bin/install.ps1 | %{$_.Content.replace("github.com","github.com.cnpmjs.org").replace("raw.githubusercontent.com","raw.fastgit.org") | iex
```

上面这个命令**应该**可以正常安装 scoop 程序，但是当需要使用 scoop 安装其他程序时可能会出现问题，
可以手动将文件`$env:SCOOP\apps\scoop\current\lib\manifest.ps1`中读取 json 文件的命令(如下 👇🏻 第一条命令)
替换为下面的第二条命令，从而实现自动替换掉 github 链接。

也可在 powershell 中运行下面的第三条命令修改 scoop 源码，使得 scoop 安装其他程序时自动替换掉 github 链接。

```powershell
#1原命令
Get-Content $path -raw -Encoding UTF8 | convertfrom-json -ea stop
#2替换为
$(Get-Content $path -raw -Encoding UTF8).replace("github.com","github.com.cnpmjs.org").replace("raw.githubusercontent.com","raw.fastgit.org") | convertfrom-json -ea stop

#3可以使用下面的命令自动完成替换操作
$(Get-Content $env:SCOOP\apps\scoop\current\lib\manifest.ps1 -raw).replace('Get-Content $path -raw -Encoding UTF8 | convertfrom-json -ea stop','$(Get-Content $path -raw -Encoding UTF8).replace("github.com","github.com.cnpmjs.org").replace("raw.githubusercontent.com","raw.fastgit.org") | convertfrom-json -ea stop') | Out-File -FilePath $env:SCOOP\apps\scoop\current\lib\manifest.ps1
```

安装完成之后通过如下命令中的一条修改配置，更新的时候就可以方便许多。

```powershell
# https://gitcode.net
scoop config SCOOP_REPO https://gitcode.net/mirrors/ScoopInstaller/Scoop.git
#cnpmjs
 scoop config SCOOP_REPO https://github.com.cnpmjs.org/ScoopInstaller/Scoop/
#fastgit
 scoop config SCOOP_REPO https://hub.fastgit.org/ScoopInstaller/Scoop/
#gitee
 scoop config SCOOP_REPO https://gitee.com/squallliu/scoop
```

## 安装 Git

scoop 使用 git 来管理软件源列表，所以需要安装 git。在上一步安装 scoop 的时候[安装脚本](https://github.com/ScoopInstaller/Scoop/blob/master/bin/install.ps1#L58-L64) 会自动下载 main bucket 的压缩包，这个压缩包里面定义了 git 的安装方法，但是其依赖 7zip 使用了 github 的链接，无法访问，会导致安装失败，可以手动修改掉这个链接。

## 添加软件源 Bucket

scoop 通过 bucket 管理软件源，列表见[github](https://github.com/ScoopInstaller/Scoop#known-application-buckets)

- [main](https://github.com/ScoopInstaller/Main) - Default bucket for the most common (mostly CLI) apps
- [extras](https://github.com/ScoopInstaller/Extras) - Apps that don't fit the main bucket's [criteria](https://github.com/ScoopInstaller/Scoop/wiki/Criteria-for-including-apps-in-the-main-bucket)
- [games](https://github.com/Calinou/scoop-games) - Open source/freeware games and game-related tools
- [nerd-fonts](https://github.com/matthewjberger/scoop-nerd-fonts) - Nerd Fonts
- [nirsoft](https://github.com/kodybrown/scoop-nirsoft) - Almost all of the [250+](https://rasa.github.io/scoop-directory/by-apps#kodybrown_scoop-nirsoft) apps from [Nirsoft](https://nirsoft.net)
- [java](https://github.com/ScoopInstaller/Java) - A collection of Java development kits (JDKs), Java runtime engines (JREs), Java's virtual machine debugging tools and Java based runtime engines.
- [nonportable](https://github.com/TheRandomLabs/scoop-nonportable) - Non-portable apps (may require UAC)
- [php](https://github.com/ScoopInstaller/PHP) - Installers for most versions of PHP
- [versions](https://github.com/ScoopInstaller/Versions) - Alternative versions of apps found in other buckets

此外还可以在[这个网站](https://rasa.github.io/scoop-directory/by-score.html)中查找一些社区维护的 bucket：如

- [dorado](https://github.com/chawyehsu/dorado):🐟 Yet Another bucket for lovely Scoop

### 常用 bucket

```powershell
#scoop bucket remove main
scoop bucket add main 'https://github.com/ScoopInstaller/Main'
scoop bucket add extras 'https://github.com/ScoopInstaller/scoop-extras'
scoop bucket add versions 'https://github.com/ScoopInstaller/Versions'
scoop bucket add jetbrains 'https://github.com/Ash258/Scoop-JetBrains'
scoop bucket add java 'https://github.com/ScoopInstaller/Java'
scoop bucket add dorado https://github.com/chawyehsu/dorado
scoop bucket add scoopet https://github.com/ivaquero/scoopet
```

### scoop-apps

scoop-apps([github](https://github.com/kkzzhizhou/scoop-apps),[gitee](https://gitee.com/kkzzhizhou/scoop-apps))合并了目前的大多数软件源bucket，其未对仓库软件来源进行安全检验，请自行甄别恶意软件，或者使用杀毒软件

```powershell
scoop bucket add apps https://github.com/kkzzhizhou/scoop-apps
# 国内网络
scoop bucket add apps https://gitee.com/kkzzhizhou/scoop-apps
```

### 常用 bucket 的 gitcode 镜像

```powershell
#scoop bucket remove main
scoop bucket add main 'https://gitcode.net/mirrors/ScoopInstaller/Main'
scoop bucket add extras 'https://gitcode.net/mirrors/ScoopInstaller/scoop-extras'
scoop bucket add versions 'https://gitcode.net/mirrors/ScoopInstaller/Versions'
scoop bucket add java 'https://gitcode.net/mirrors/ScoopInstaller/Java'
```

### 常用 bucket 的 cnpmjs 镜像

```powershell
#scoop bucket remove main
scoop bucket add main 'https://github.com.cnpmjs.org/ScoopInstaller/Main'
scoop bucket add extras 'https://github.com.cnpmjs.org/ScoopInstaller/scoop-extras'
scoop bucket add versions 'https://github.com.cnpmjs.org/ScoopInstaller/Versions'
scoop bucket add jetbrains 'https://github.com.cnpmjs.org/Ash258/Scoop-JetBrains'
scoop bucket add java 'https://github.com.cnpmjs.org/ScoopInstaller/Java'
scoop bucket add dorado 'https://github.com.cnpmjs.org/chawyehsu/dorado'
scoop bucket add scoopet 'https://github.com.cnpmjs.org/ivaquero/scoopet'
```

### 常用 bucket 的 fastgit 镜像

```powershell
#scoop bucket remove main
scoop bucket add main 'https://hub.fastgit.org/ScoopInstaller/Main'
scoop bucket add extras 'https://hub.fastgit.org/ScoopInstaller/scoop-extras'
scoop bucket add versions 'https://hub.fastgit.org/ScoopInstaller/Versions'
scoop bucket add jetbrains 'https://hub.fastgit.org/Ash258/Scoop-JetBrains'
scoop bucket add java 'https://hub.fastgit.org/ScoopInstaller/Java'
scoop bucket add dorado 'https://hub.fastgit.org/chawyehsu/dorado'
scoop bucket add scoopet 'https://hub.fastgit.org/ivaquero/scoopet'
```

在软件安装过程中通常会自动添加`main` bucket，可以通过`scoop bucket rm main`删除之后重新添加。之后修改链接可以使用如下内容：

```powershell
 cd $env:SCOOP\buckets\Main
 git remote set-url origin https://hub.fastgit.org/ScoopInstaller/Main
```

## 搜索 APP

可以在网站<https://scoopsearch.github.io/#/apps>中搜索软件是否有 bucket 搜录。

## 安装推荐的软件

运行` scoop checkup`安装提示修改注册表，和安装推荐的软件。通常要求安装以下软件

```
scoop install 7zip  innounp  wixtoolset
```

注：在修改注册表来支持长路径时需要在管理员模式运行 powershell

## 参考链接

- [使用 scoop 安装管理 windows 软件（2）：github 加速](<https://shenbo.github.io/2021/03/23/apps/%E4%BD%BF%E7%94%A8scoop%E5%AE%89%E8%A3%85%E7%AE%A1%E7%90%86windows%E8%BD%AF%E4%BB%B6(2)-github%E5%8A%A0%E9%80%9F/>)
- 这篇博客同时发布在[CSDN](https://blog.csdn.net/weixin_44225025/article/details/117401094)。
