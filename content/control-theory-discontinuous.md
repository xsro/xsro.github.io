+++
title = "非连续动态系统分析——连续性定义与连续可微的classical解"
date = 2024-01-13
[taxonomies]
tags = ["控制理论","非光滑"]
categories = ["非连续动态系统分析"]
+++

非线性动态系统理论是滑模控制的重要理论基础，也是我学习滑模的最大障碍。
我决定花一些时间从工科本科数学知识出发整理非线性动态系统中的一些概念。
这篇笔记主要回顾连续性的定义，同时介绍传统的连续可微的classical解在应对非连续系统时存在性与唯一性的缺陷。

<!-- more -->

## 前言

最近在看滑模控制的文章，其中对于非连续系统的论述多有不解，比如如下Filippov微分包含到底是什么，
结合一下材料，打算整理一下所学内容

> **定义 2.2**
> A  $\dot{x}\in F(x), x\in R^n$,
> is called a *Filippov differential inclusion* 
> 当一个向量场（vector-set field）$F(x)$具有如下性质的时候，
> 称一个微分包含（differential inclusion）
> 
> 1. noempty 非空, 
> 1. closed+locally bounded=compact 紧集（有界闭集）, 
> 1. convex 图集,
> 
> and the set-value map $F$ is upper-semi-continuous(the maximal distance of the point of $F(x)$ and $F(y)$vanishes when $x\to y$).Solutions are defined as absolutely continuous functions of time satisfying the inclusion almost everywhere.
> 
> Filippov 微分包含的解的所有广为人知的性质(existence,extendability etc)但是不包含唯一性(uniqueness)

1. 知乎讨论：请问filippov解大概是什么意思？是怎么定义的？有什么作用？ <https://www.zhihu.com/question/55951952>
1. 主要是翻译的这个文献：CORTES J. Discontinuous dynamical systems[J/OL]. IEEE Control Systems Magazine, 2008, 28(3): 36-73. DOI:10.1109/MCS.2008.919306.
1. HAN Z, CAI X, HUANG J. Theory of control systems described by differential inclusions[M/OL]. Berlin, Heidelberg: Springer Berlin Heidelberg, 2016[2023-12-17]. http://link.springer.com/10.1007/978-3-662-49245-1. DOI:10.1007/978-3-662-49245-1.


## 回顾：经典非线性系统解的条件

经典非线性系统的解存在性和唯一性需要微分方程右端Lipschitz连续，
一个使用较多的数学表述是khalil的非线性控制的**引理1.3**：

> 设$f(t,x)$关于$t$是**分段连续**的，
> 并且对所有$t\ge t_0$，在关于$x$的区域$D\subset \mathbb{R}^n$上$f(t,x)$是局部**Lipschitz连续**的。
> 设$W$是$D$中的一个紧子集，$x_0\in W$，并进一步设
$$
\dot{x}=f(t,x),x(t_0)=x_0
$$
> 的解$t\ge t_0$时都在$W$内，那么这个解是$t\ge t_0$的唯一解。

## 回顾：连续性

那么什么是Lipschitz连续呢，各种连续的关系又是什么呢，我们讨论的非连续动态微分方程又如何定义呢？
为了简便，这里用的是函数来叙述，如果是多变量函数或者泛函需要使用范数替代绝对值。

### 点连续与间断点

> 设函数$y=f(x)$在点$x_0$的某一邻域内有定义，
> 并且$\lim_{x\to x_0}f(x)=f(x_0)$，
> 那么就称函数$f(x)$在点$x_0$处连续。

借此可以定义函数不连续和间断点的概念：

> 设函数$f(x)$在点$x_0$的某**去心**领域内有定义，
> 在此前提下，如果函数$f(x)$有一下三种情形之一
> 1. 在$x=x_0$处没有定义
> 1. 在$x=x_0$处有定义，但$\lim_{x\to x_0} f(x)$不存在
> 1. 在$x=x_0$处有定义，$\lim_{x\to x_0} f(x)$存在,但$\lim_{x\to x_0}\neq f(x_0)$
> 那么函数$f(x)$在点$x_0$为不连续，$x_0$是函数$f(x)$的**间断点**。

函数的间断点可以分为
1. 第一类间断点：左右极限都存在
    1. 可去间断点：左右极限都存在且相等
    2. 跳跃间断点：左右极限都存在但不等
1. 第二类间断点：左右极限至少有一个不存在
    1. 震荡间断点：$\lim_{x\to\ x_0} f(x)$振荡不存在
    1. 无穷间断点：$\lim_{x\to\ x_0^+} f(x)=\infty$或$\lim_{x\to\ x_0^-} f(x)=\infty$

![https://calcworkshop.com/limits/limits-and-continuity/](/images/4-types-of-discontinuity.png)


### 区间连续与区间一致连续

如果在区间上每一点都连续，就称函数在该区间上连续，如果区间包括端点，那么在右端点连续是指左连续，在左端点连续是指右连续。

> 设函数$f(x)$在区间$I$上有定义. 如果对于任意给定的正数$\epsilon$，总存在正数
> $\delta$，是的对于区间$I$上的任意两点$x_1,x_2$，当$|x_1-x_2|<\delta$时，
> 有
$$
|f(x_1)-f(x_2)|<\epsilon
$$
> 那么称函数$f(x)$在区间$I$上**一致连续**。


### 绝对连续、Lipschitz连续、Hölder连续

绝对连续表示函数的光滑性质，比连续和一致连续条件都要严格，比Lipschitz条件宽松，是一类极为重要的函数。绝对连续函数几乎处处可微，是它的导函数的广义原函数。

> 设$f(x)$是$[a,b]$上的函数，若对任意$\epsilon>0$，存在$\delta>0$使得对于
> $[a,b]$中的任意一组分点：
$$
a_1<b_1\leq a_2 <b_2 \leq \dots \leq a_n < b_n,
$$
> 只要$\sum_{i=1}^n(b_i-a_i)<\delta$，便有
$$
\sum_{i=1}^n|f(b_i)-f(a_i)|<\epsilon
$$
> 则称$f(x)$是$[a,b]$上**绝对连续**函数，或称$f(x)$在$[a,b]$上绝对连续。

等价的，如果存在一个Lebesgue可积函数$\kappa:[a,b]\to \mathbb{R}$
使得下式成立，那么$\gamma$是一个绝对连续函数。
$$
\gamma(t)=\gamma(a)+\int^t_a \kappa(s)d s,\quad t\in [a,b]
$$



> 对于函数$f(x)$，如果存在一个常数L，使得对$f(x)$定义域上（可为实数也可以为复数）的任意两个值满足如下条件：
$$
|f(x_1)-f(x_2)|\leq L|x_1-x_2|
$$
> 那么称函数$f(x)$满足Lipschitz连续条件，并称L为$f(x)$的lipschitz常数。

- 从局部看：我们可以取两个充分接近的点，如果这个时候斜率的极限存在的话，这个斜率的极限就是这个点的导数。也就是说函数可导，又是Lipschitz连续，那么导数有界。反过来，如果可导函数，导数有界，可以推出函数Lipschitz连续。
- 从整体看：Lipschitz连续要求函数在无限的区间上不能有超过线性的增长，所以这些x^{2}和e^{2}函数在无限区间上不是Lipschitz连续的。

> 对于函数$f(x)$，如果存在一个非负常数$C,\alpha$，
> 使得对$f(x)$定义域上（可为实数也可以为复数）的任意两个值满足如下条件：
$$
|f(x_1)-f(x_2)|\leq C|x_1-x_2|^\alpha
$$
> 那么称函数$f(x)$满足Hölder连续条件。
> 当$\alpha=0$时表示有界，当$\alpha=1$时表示满足Lipschitz条件

### 区间上连续性的关系

- 绝对连续一定一致连续，反正不一定。
- 连续可微一定绝对连续，反之不一定
- 局部Lipschitz连续一定绝对连续，反之不一定。

如下$f_1(x)$一致连续但是不绝对连续:
$$
f_1(x)=\begin{cases}
    0, &x=0\\
    x \sin\frac{\pi}{x}, &0 < x\leq 1
    \end{cases}
$$

如下绝对值函数$f_2(x)$绝对连续但是在0处不连续可微
$$
f_2(x)=|x|, x\in [-1,1]
$$

如下根号函数绝对连续但是在0处不是局部Lipschitz连续的
$$
f_3(t)=\sqrt(t),t\in [0,0]
$$


#### 连续函数不一定

### 光滑函数

光滑函数（英语：Smooth function）在数学中特指无穷可导的函数，不存在尖点，也就是说所有的有限阶导数都存在。例如，指数函数就是光滑的，因为指数函数的导数是指数函数本身。

若一函数是连续的，则称其为$C^{0}$函数；
若函数存在导函数，且其导函数连续，则称为连续可导，记为$C^1$函数；
若一函数n阶可导，并且其n阶导函数连续，则为$C^{n}$函数（$n\geq 1$）。
而光滑函数是对所有n都属于$C^{n}$函数，特称其为$C^{\infty }$函数。

## 不一定连续可微的解 
Beyond Continuously Differentiable Solutions 

考虑如下的动态系统
$$
\dot{x}(t)=\mathcal{X}(x(t))\ x(t_0)=x_0
\tag{7}
$$
其中$x\in \mathbb{R}^d$， $d$为一个正整数，
并且$\mathcal{X}:\mathbb{R}^d \to \mathbb{R}^d$ **不需要连续**。
我们称**连续可微的解$t \mapsto x(t)$为经典（classical）解**。
显然，如果$\mathcal{X}$连续，那么方程所有解都是classical的。
不失一般性，我们认为$t_0=0$，并且只考虑$t>0$的情况。

> 连续可微Continuously differentiable，用泛函表示就是函数$f\in C^1$，意味着函数的导数是连续的，当然可微保证其本身也是连续的。

**Caratheodory解**是classical解的一般化。
粗略地说，Caratheodory解是满足微分方程(7)的Lebesgue积分形式(8)的绝对连续曲线
$$
x(t)=x(t_0)+\int_{t_0}^t X(x(s)) ds,\quad t>t_0
\tag{8}
$$
通过使用积分形式(8)，Caratheodory解不再要求方程解必须所有时间都沿着向量场的方向。
也就是说，微分方程(7)need bot be satisfied on a set of measure zero.

**Filippov解**使用微分包含式（differential inclusion）来替换微分方程(7)右侧
$$
\dot{x}(t)\in \mathcal{F} (x(t))
$$
其中$\mathcal{F}:\mathbb{F}^d \to \mathfrak{B}(\mathbb{F}^d)$，
$\mathfrak{B}(\mathbb{R}^d)$为d维实数空间$\mathbb{R}^d$的所有子集的集合。
Filippov解是绝对连续曲线。
对于任意给定的状态$x$，Filippov解不只关注向量场在$x$处的值，
Filippov解的思想是引入由向量场中$x$的领域决定的一组**方向集合**。
文献中常常使用集值映射（set-value map），
也就是说这种映射的值是一个集合，而不像标准的函数（映射）的值只有一个。

> An ordinary differential inclusion says the derivative must lie in a specified set, which may also depend on the function and independent variable. 

Caratheodory解和Filippov解都不能完全解决非连续动态系统的问题，
围绕存在的问题由**Sample-and-hold**解以及其他的一些描述方法。


## 解的存在性和唯一性

对于常微分方程而言，向量场如果只连续不能保证解的唯一性。
我们说解的一个性质弱，表示不是所有解满足这一性质。
我们说解的一个性质强，表示所有解满足这一性质。
所以设计控制器的思路可以是

1. 设计控制器并考虑控制器下的闭环系统
1. 用一个集值映射将每一个状态映射到允许的输入产生的所有向量的集合，并将这个映射与控制系统关联起来，（原文表述如下）

> associate with the control system the set-valued map that assigns each state to the set of all vectors generated by the allowable inputs and consider the resulting differential inclusion.

### classical 解的存在性

考虑微分方程：
$$
\dot{x}(t)=X(x(t)),\quad x(0)=x_0
\tag{10}
$$
其中$X:\mathbb{R}^d \to \mathbb{R}^d$是一个向量场。
如果$0=X(x_e)$，那么点$x_e\in \mathbb{R}^d$是(10)的一个平衡点。
在$[0,t_1]$上一个(10)的classical解是一个连续可微的映射$x:[0,t_1]\to\mathbb{R}^d$。
不失一般性，我们只考虑从时间$t_0=0$开始的解。
如果解$t\mapsto x(t)$ 不能在时间上延申（extend），
也就是说解不是定义域内更大的一个时间区间上的解的截断，
那么称该解为最大解（maximal solution）。
最大解的定义暗示了解的区间只能是$[0,T),T>0$或$[0,\infty)$。

Peano’s theorem 说明了连续的向量场可以保证classical解存在：

> (Proposition 1) 令$X:\mathbb{R}^d\to \mathbb{R}^d$是连续向量场。
> 于是，对于所有$x_0\in\mathbb{R}^d$，
> **存在**一个(10)的classical解，该解满足$x(0)=x_0$

### classical 解的唯一性

> (Proposition 2)  令$x:\mathbb{R}^d\to\mathbb{R}^d$连续，
> 假设对于所有的$x\in\mathbb{R}^d$，
> 存在一个$\epsilon>0$使得$X$是在状态$x$的$\epsilon$领域$B(x,\epsilon)$上单侧Lipschitz连续。
> 然后，对于所有$x_0\in \mathbb{R}^d$，存在一个起始于$x(0)=x_0$的(10)的**唯一的**classical 解

### classical 解存在性和唯一性示例

下面的例子说明如果向量场不连续，那么(10)可能不存在经典解

> 考虑如下向量场：$X:\mathbb{R}\to\mathbb{R}$ 
$$
X(x)=\begin{cases}
    -1, & x>0\\
    1 , & x\leq 0
\end{cases}
$$
> 显然在$x=0$处该函数不连续。
> 假设存在一个连续可微的解满足$\dot{x}(t)=X(x(t))$和$x(0)=0$。
> 然后$\dot{x}(0)=X(x(0))=X(0)=1$，
> 于是，对于所有的充分小的时间$t$，$x(t)>0$ 并且$\dot{x}(t)=X(x(t))=-1$，
> 这与$t\mapsto \dot{x}(t)$连续矛盾。
> 所以，不存在classical 解。

下面的例子说明如果向量场不连续，那么(10)也可能存在经典解。

> 考虑向量场$X:\mathbb{R}\to\mathbb{R}$
$$
X(x)=-\mathrm{sign}(x)=\begin{cases}
-1, & x>0,\\
0,   & x=0,\\
1,   & x<0,
\end{cases}
$$
> 唯一最大解为：
$$
\begin{aligned}
    &x(t)=x(0)-t, 
    t\in [0,x(0)) 
    &\textrm{if}
    \ x(0)>0, \\
    &x(t)=0,  t\in [0,\infty)
    &\textrm{if}\ x(0)=0 
   \\
    &x(t)=x(0)+t,  t\in [0,-x(0))
    &\textrm{if}\ 
    x(0)<0,
\end{aligned}
$$

下面例子说明连续但是不是单侧Lipschitz连续的向量场可能有多个classical解

> 考虑向量场$X:\mathbb{R}\to\mathbb{R}$
$$
X(s)=\sqrt{|x|}
$$
> 这个向量场处处连续，并在$\mathbb{R}/\{0\}$局部Lipschitz连续，
> 但是在零处不局部连续，在零的领域也不单侧Lipschitz连续。
> 从$x(0)=0$开始，该动态系统有许多最大解，具体而言为：
> 对所有$a>0$，$x_a:[0,\infty)\to \mathbb{R}$，表达式为：
$$
x_a(t)=\begin{cases}
0, & 0\leq t \leq a,\\
(t-a)^2/4, & t\geq a
\end{cases}
$$

下面例子说明连续但是不是单侧Lipschitz连续的向量场只有一个classical解
> 考虑向量场$X:\mathbb{R}\to\mathbb{R}$
$$
X(s)=\begin{cases}
-x \mathrm{log} x, & x>0\\
0,                            & x=0,\\
x \mathrm{log}(-x),& x<0,
\end{cases}
$$
> 唯一最大解为：
$$
\begin{aligned}
    &x(t)=-\exp(\log (-x(0)) \exp(t)), 
    &\textrm{if}\ x(0)<0 \\
    &x(t)=0, 
    &\textrm{if}\ x(0)=0 \\
    &x(t)=\exp(\log x(0) \exp(-t)), 
    &\textrm{if}\ x(0)>0
\end{aligned}
$$