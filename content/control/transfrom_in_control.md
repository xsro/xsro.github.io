+++
title = "傅里叶、拉普拉斯、Z变换这一串"
date = 2021-08-30
[taxonomies]
tags = ["数学推导", "变换域分析"]
categories = ["学习笔记", "控制理论"]
+++

# 📶 三大变换的数学推导过程

$\mathscr{F,L,Z}$傅里叶变换、拉普拉斯变换、Z 变换这三大变换讨论广泛[^zhihu]。个人理解，这三个变换都是为了简化一些难以在时间域分析的问题而引入的。

- 拉普拉斯变换是对傅里叶变换的推广，忽略了时域信号时间为负的部分，使得变换也可以适用于$t\rightarrow +\infty$不为零的信号
- Z 变换是拉普拉斯变换针对离散信号的简化，使得表达式更加便于分析

|              | 傅里叶变换                                                        | 拉普拉斯变换                                | $Z$变换                                      |
| ------------ | ----------------------------------------------------------------- | ------------------------------------------- | -------------------------------------------- |
| 表达式       | $F(\omega)=\int_{-\infty}^{\infty}f(t)e^{-j\omega t}\mathrm{d} t$ | $F(s)=\int_0^\infty f(t)e^{-st}\mathrm{d}t$ | $F(z)=\sum\limits_{k=0}^{\infty}f(kT)z^{-k}$ |
| 适用范围     | 狄利克雷条件                                                      | 狄利克雷条件的前两条                        | 前者+（时间）离散                            |
| 变换域       | 频域                                                              | 复(频)域                                    | $Z$域                                        |
| 对应系统模型 | 频率特性                                                          | 传递函数                                    | 脉冲传递函数                                 |

[^zhihu]: https://www.zhihu.com/question/22085329/answer/26047106

## 数学演变过程

### 周期函数的傅里叶级数

周期为 T 的任一周期函数$f(t)$，若满足下列*狄利克雷条件*(Dirichlet conditions[^dirichlet-conditions]）：

1. 在一个周期内只有有限个不连续点
2. 在一个周期内只有有限个极值点(注：函数连续是条件 1、2 的充分非必要条件)
3. 周期内绝对可积：积分$\int^{\frac{T}{2}}_{-\frac{T}{2}} |f(t)| \mathrm{d}t$ 存在

则$f(t)$可展开为如下的傅里叶级数：

$$
f(t)=\frac{1}{2} a_0 + \sum\limits_{n=1}^{\infty} (a_n \cos{n\omega_0 t}+b_n\sin{n \omega_0 t})
$$

[^dirichlet-conditions]: 又叫傅里叶级数收敛条件，[百度百科](https://baike.baidu.com/item/狄利克雷条件/3807787) [wikipedia](https://en.wikipedia.org/wiki/Dirichlet_conditions)

式中，系数$a_n$和$b_n$由*欧拉—傅里叶系数公式*给出，其中$\omega_0=\frac{2\pi}{T}$称为角频率。

$$
a_n=\frac{2}{T}\int_{-\frac{T}{2}}^{\frac{T}{2}} f(t) \cos{n \omega_0 t}\mathrm{d} t,
n=0,1,2,\dots,\infty
$$

$$
b_n=\frac{2}{T}\int_{-\frac{T}{2}}^{\frac{T}{2}} f(t) \sin{n \omega_0 t}\mathrm{d} t,
n=1,2,\dots,\infty
$$

推导[^p222]：分别对$f(x),f(x)\cos kx, f(x)\sin kx$在周期$[-\frac{T}{2},\frac{T}{2}]$上积分。

[^p222]: 赵洪牛.《高等数学》第二版 下册 P222

#### 傅里叶级数的指数形式

周期函数$f(t)$的傅里叶级数还可以写成复数形式（指数形式）：

$$
f(t)=\sum_{n=-\infty}^{\infty} \alpha _n e^{jn\omega_0 t}
$$

$$
\alpha_n=\frac{1}{T} \int_{-\frac{T}{2}}^{\frac{T}{2}}
f(t)e^{-jn\omega_0 t} \mathrm{d} t
$$

推导：运用欧拉公式$e^{i\theta}=\cos\theta + \sin \theta$

#### 非周期函数的傅里叶积分式子

对于非周期函数，可以认为周期$T\rightarrow \infty$，此时$\omega_ 0=\frac{2\pi}{T}\rightarrow 0$，为了方便讨论可以将$n\omega_0$记为$\omega$，$\Delta \omega=(n+1)\omega_0-n\omega_0=\omega_0$，那么傅里叶级数可以写成如下形式：

$$
f(t)=\int_{-\infty}^{\infty} \alpha _n e^{j\omega t}\mathrm{d}\omega,
\alpha_n=\frac{\Delta\omega}{2\pi} \int_{-\frac{T}{2}}^{\frac{T}{2}}
f(t)e^{-j\omega t} \mathrm{d} t
$$

合并为

$$
\begin{aligned}
f(t)=&\sum_{n=-\infty}^{\infty} \frac{\Delta\omega}{2\pi} \left[\int_{-\infty}^{\infty}
f(t)e^{-j\omega t} \mathrm{d} t\right] e^{j\omega t}
\\
=&\frac{1}{2\pi}\sum_{n=-\infty}^{\infty} \left[\int_{-\infty}^{\infty}
f(t)e^{-j\omega t} \mathrm{d} t\right] e^{j\omega t} \Delta \omega
\\
=&\frac{1}{2\pi}\int_{-\infty}^{\infty} \left[\int_{-\infty}^{\infty}
f(t)e^{-j\omega t} \mathrm{d} t\right] e^{j\omega t} \mathrm{d} \omega
\end{aligned}
$$

将中括号中的内容记作$F(\omega)$即为傅里叶变换式。

### 傅里叶变换

对于非周期函数，如果满足狄利克雷条件（第三条相应改为$\int^{\infty}_{-\infty} |f(t)| \mathrm{d}t$），可以进行傅里叶变换：

$$
F(\omega)=\mathscr{F}[f(t)]=\int_{-\infty}^{\infty}f(t)e^{-j\omega t}\mathrm{d} t
$$

$$
f(t)=\mathscr{F}^{-1}[F(\omega)]=\frac{1}{2\pi}\int_{-\infty}^{\infty}F(\omega)e^{j\omega t} \mathrm{d} \omega
$$

### 拉普拉斯变换

狄利克雷条件的第三个可积条件，要求函数在$t\rightarrow \infty$时收敛，而现实中大量信号不满足该条件，为了解决该问题，引入衰减因子$e^{-\sigma t},\sigma>0$，并只考虑$t\ge 0$的部分[^ignore-past]，这样函数$f(t)e^{-\sigma t}$在$t > 0$下便可以满足可积条件。

于是有：

$$
F_\sigma(\omega)
=\mathscr{F}[f(t)e^{-\sigma t}]
=\int_{-\infty}^{\infty}f(t)e^{-\sigma t}e^{-j\omega t}\mathrm{d} t
$$

记$s=\sigma+j\omega$，$F(s)=F\_\sigma(\frac{s-\sigma}{j})=F_\sigma(\omega)$，并认为$t<0$时，函数为零，于是有：

$$
F(s)=\mathscr{L}[f(t)]=\int_0^\infty f(t)e^{-st}\mathrm{d}t
$$

$$
f(t)=\mathscr{L}^{-1}[F(s)]=
\frac{1}{2\pi j}\int_{\sigma-j\infty}^{\sigma + j\infty} f(t) e^{st} \mathrm{d} t
$$

[^ignore-past]: 在控制系统等领域，经常忽略$t<0$的部分，用[J Pan](https://www.zhihu.com/people/galieluo)的话来说，小于零的部分是哲学家考虑的问题

### Z 变换

现实中的信号都可以认为是连续模拟信号，而处理时通常需要将其采样成离散信号。

通常记$f(t)$为连续信号，
$f^\star(t)$为其对应的离散采样信号，
对于理想采样情况，采样信号可以表示为：

$$
f^\star(t)
=f(t)\times \sum\limits_{k=0}^{\infty}\delta(t-kT)
=\sum\limits_{k=0}^{\infty}f(kT)\delta(t-kT)
$$

对采样后的离散信号，进行拉普拉斯变换

$$
\begin{aligned}
F^\star(s)&=\mathscr{L}\left[ f^\star(t)\right]
=\int_0^\infty f^\star(t)e^{-st}\mathrm{d}t\\
&=\sum\limits_{k=0}^{\infty} f(kT) e^{-skT}\\
\end{aligned}
$$

可见 $F^\star(s)$是 s 的超越函数[^transcendental-functions]（指数函数），难以使用分析。
故引入变量$z=e^{sT}$,$s=\frac{1}{T}lnz$

$$
F(z)=F^\star(s)|\_{s=\frac{1}{T}lnz}
=\sum\limits\_{k=0}^{\infty}f(kT)z^{-k}
$$

于是便得到 Z 变换的表达式（是 z 的幂函数）。

[^transcendental-functions]: 超越函数 [百度百科](https://baike.baidu.com/item/%E8%B6%85%E8%B6%8A%E5%87%BD%E6%95%B0/3365811)
