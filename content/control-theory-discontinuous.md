+++
title = "非连续动态系统分析——Filippov"
date = 2024-01-13
[taxonomies]
tags = ["滑动模态控制"]
categories = ["控制理论"]
+++

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

## 回顾：各种连续性

那么什么是Lipschitz连续呢，各种连续的关系又是什么呢，我们讨论的非连续动态微分方程又如何定义呢？

### 通过极限描述的连续性

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

### 通过$\epsilon-\delta$描述的连续性