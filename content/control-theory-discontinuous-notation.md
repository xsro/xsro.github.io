+++
title = "非连续动态系统分析——绝对连续的Caratheodory解"
date = 2024-01-14
[taxonomies]
tags = ["控制理论","非光滑"]
categories = ["非连续动态系统分析"]
+++

[前文](../control-theory-discontinuous)已经说明了在考虑非连续的向量场的时候，classical解具有非常大的局限性。
为了处理微分方程的不连续部分，
我们首先放宽解必须始终沿着向量场方向的要求。
数学中对应的就是**绝对连续的Caratheodory解**。

Caratheodory解不足以保证解的存在性。
由于向量场的非连续性，
他的值在任意靠近一个点的时候可能表现出显著的振荡。
这种不匹配可能导致无法构造一个Caratheodory解。

Filippov解的思路是不再只考虑向量场上的各个点，
而是考虑向量场上各个点邻域。

<!-- more -->

## Caratheodory解
### 数学定义

考虑微分方程：
$$
\dot{x}(t)=X(x(t)),\quad x(0)=x_0.
\tag{10}
$$
微分方程(10) 的定义在$[0,t_1]\subset \mathbb{R}$的**Caratheodory解**是一个绝对连续映射。
该映射在几乎(almost)所有时间$t\in [0,t_1]$上满足微分方程(10)。
这里说的“几乎”是在Lebesgue测度的意义上的。
也就是说，Caratheodory解只在Lebesgue测度为0的时刻集合上没有沿着向量场的方向。
也可以等价地说，Caratheodory解是满足微分方程(10)的Lebesgue积分形式(16)的绝对连续解。
$$
x(t)=x(t_0)+\int_{t_0}^t X(x(s)) ds,\quad t>t_0
\tag{16}
$$
当然，所有的classical解都是Caratheodory解。

> **Example 9**: 具有Caratheodory解，但是没有classical 解的系统
$$
X(x)=\begin{cases}
1,  & x>0,\\
\frac{1}{2}, & x=0,\\
-1, & x<0\\
\end{cases}
$$
> 该系统由两个从$x(0)=0$出发的Caratheodory解，分别是
> $x_1(t)=t,t\in [0,\infty)$和$x_1(t)=-t,t\in [0,\infty)$。
> 这两个解在$t=0$时，都不满足向量场，也就是
> $\dot{x}_1(0) \neq X(x_1(0))$ 和
> $\dot{x}_2(0) \neq X(x_2(0))$ 。

然而，可以找到很多不接受Caratheodory解的系统，这其中一些可以用Filippov解理解。

### Caratheodory解存在的充分性条件

对于时变的向量场，Caratheodory解存在的条件应用到时不变系统与classical解类似。
所以研究主要集中在时不变的向量场，如directionally continuous 和 Patchy vector fields，
详情参看原文。

## Filippov解