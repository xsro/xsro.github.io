+++
title= "t<0是哲学家思考的问题--控制系统分析时一般信号都需要乘上一个阶跃u(t)"
date = 2021-08-28
[taxonomies]
categories = ["控制理论"]
tags = ["线性定常系统", "信号处理"]
+++

# 线性定常系统的重要特性引发的思考

女朋友在阅读胡寿松第六版《自动控制原理》时有一个困惑。为什么书中 P71 页表 3-2 中的阶跃信号`1`，求导之后消失了，而不是作为单位脉冲信号$\delta(t)$处理。难道这里的`1`视为常数，这样就与`零初始条件`矛盾了。

书中的**表 3-2 一阶系统对典型输入信号的输出响应**如下：

| 输入信号    | 输出响应                      |
| ----------- | ----------------------------- |
|$1(t)$     |$1-e^{-t/T}, t \ge 0$        |
|$\delta(t)$|$\frac{1}{T}e^{-t/T}, t\ge 0$|

> 书中由此得出线性定常系统的一个重要特性：系统对输入信号导数的响应，就等于系统对输入信号响应的导数。

也就是说第二行脉冲响应应该是第一行阶跃响应的导数，但是这里为什么`1`对应的导数$\delta(t)$没有了呢？

**答**：因为后面的指数项$e^{-t/T},t \ge 0$，在零初始条件下还需要乘以一个$u(t)$，根据求导的乘法公式求导之后会出现一个$\delta(t)$，从而相互抵消。

将阶跃响应写成如下形式：

$$
1-e^{-t/T}(t \ge 0)=1(t)-e^{-t/T}\times 1(t)
$$

对阶跃响应求导：

$$
\begin{aligned}
\frac{\mathrm{d}}{\mathrm{d}t}
[&1(t)-e^{-t/T}\times 1(t)] \\
=&\delta(t)-
\frac{\mathrm{d}}{\mathrm{d}t}[e^{-t/T}1(t)]
\\
=&\delta(t)-
[\frac{\mathrm{d}}{\mathrm{d}t}e^{-t/T}\times1(t)+e^{-t/T}\times \frac{\mathrm{d}}{\mathrm{d}t} 1(t)]
\\
=&\delta(t)
-[-\frac{1}{T}e^{-t/T}\times 1(t)+e^{-t/T}\times \delta(t)]
\\
=&\delta(t)-
[-\frac{1}{T}e^{-t/T}\times 1(t)+\delta(t)]
\\
=&\frac{1}{T}e^{-t/T}\times1(t)
\end{aligned}
$$

结果即为$\frac{1}{T}e^{-t/T}, t\ge 0$。

## 一般化

已知线性定常系统的零初始条件下的阶跃响应为$h(t), t\ge 0$，求解系统传递函数.

#### 拉式变换法

输入和输出的拉氏变换后的象函数分别为

$$
R(s)=\frac{1}{s},C(s)=H(s)
$$

于是传递函数可以写成：

$$
G(s)=\frac{C(s)}{R(s)}=sH(s)
$$

#### 系统特性法

对输入输出分别进行求导：

$$
r'(t)=\delta(t),c'(t)=\frac{\mathrm{d}}{\mathrm{d}t}[h(t)]=h'(t)
$$

对输出信号拉氏变换即为传递函数：

$$
G(s)=\mathscr{L}[c'(t)]=sH(s)
$$

$$
\begin{matrix}
   a & b \\
   c & d
\end{matrix}
$$ 