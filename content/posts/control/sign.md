+++
title = "经典滑模控制趋近律收敛性的理解"
date = 2025-12-25
math = true
[taxonomies]
tags = ["控制"]
categories = ["控制理论"]
+++

# 在滑模面上滑模导数是否收敛到零

> **本文部分参考AI内容，仅作为个人理解使用，严谨分析请参加相关文献**

在经典的滑模控制中，考虑问题
$$
\ddot{e}(t)=u(t)+\delta(t)
$$
其中，$e(t)$为系统的误差，
$u(t)$为控制输入，
$\delta(t)$为系统的有界扰动，定义$\bar{\delta}=\sup_t\|\delta(t)\|$，这里$\sup$表示上确界，即扰动的范数（此处为标量系统即为绝对值）的最大值。
经典的滑模控制中，首先设计一个滑模面$s(t)=\dot{e}(t)+a e(t)$, 其中$a>0$。
滑模控制的核心思想之一是降阶，将原来的一个二阶系统转换为两个一阶子系统。
从系统的轨线的角度，如下图，整个闭环系统的过程可以分为两个阶段：

- **趋近阶段**：首先**在有限时间上**收敛到所设计的滑模上，其动态为
- **滑动阶段**：再在滑模面上收敛到期望的平衡点，其动态为$\dot{e}=-a e(t)$。

$$
\dot{s}=-k\operatorname{sgn}(s)+\delta(t)
\tag{eq 1}
$$

针对这两个阶段有这些值得关注的：
1. 趋近律中的$\operatorname{sgn}(e)$函数，在标量的情况（本文）通常选取符号函数，在多维向量的情况有两种表达，一种是逐元素的定义，一种为基于范数的定义，如果使用的是二范数，那么表示向量的单位向量。这里有震颤chattering的问题，于是有了减少和抑制震颤的一些方案。
  - 减少的方案通常为用连续的函数替代sign，这样会牺牲收敛精度
  - 抑制的方案需要改进算法，使用高阶滑模，这样会系数抗扰的能力，由这里的抵抗有界扰动，改为抵抗导数有界的扰动。
2. 这里的滑动阶段使用的是线性滑模，所以系统状态渐进收敛，如果需要有限时间收敛，可以使用$s=\dot{e}+|e|^{\alpha}\operatorname{sgn}(e)$, $0<\alpha<1$的形式，但是这种会有歧义的问题，于是就有了非奇异终端滑模。
 

![classical_SMC_trajectory](/images/classical_SMC_trajectory.png)

到达阶段的系统其实就是一个线性系统，不存在扰动了，现代控制理论或者经典控制理论都可以很容易地分析。
即使是使用终端滑模或者非奇异终端滑模也可以使用高等数学中求解微分方程的分离变量法积分得到响应曲线。
但是趋近阶段有sign函数和扰动函数，这是一个时变非连续系统，需要了解一定的知识才能分析。

## 常见的趋近阶段分析方法

一般网上的教程分析趋近阶段都是采用这样一个Lyapunov函数：
$$
V=\frac12 \|s\|^2
$$
对这样的函数求导可得：
$$
\begin{aligned}
\dot{V}
&=s\dot{s}=s\left(-k\operatorname{sgn}(s)+\delta(t)\right)\\
&=-k\|s\|+s\delta \leq -k\|s\|+\|s\| \|\delta\|\\
&\leq -(k-\bar{\delta})\|s\|
\end{aligned}
$$
这里使用了条件$\sup_t\|\delta(t)\|< \bar{\delta}$.
于是我们应用Lyapunov 定理得到$s\to 0$.

实际滑模控制中，滑动阶段是有限时间内的，所以还需要证明$s$在有限时间内收敛到零。
刚刚的分析，我们可以得到：
$$
\dot{V}=\frac{dV}{dt}\leq-(k-\bar{\delta})\sqrt{2V}
$$
分离变量可得：
$$
V^{-1/2}dV\leq-(k-\bar{\delta})\sqrt{2}dt
$$
同时积分得：
$$
2V^{1/2}(t)-2V^{1/2}(0)\leq-(k-\bar{\delta})\sqrt{2}t
$$
从这个式子可以看出，最晚在$t=\frac{2V^{1/2}(0)}{(k-\bar{\delta})\sqrt{2}}$的时候，系统的$V(t)$收敛到零。

> 这里确实有个疑问，当V(t)收敛到零之后，这个系统会怎么演化？ $V\geq 0$但是不等式右侧将小于零，这个不等式无法再成立。
> 
> 试答：这里就涉及到微分方程的经典解无法解决的问题了，当系统收敛到零后系统不在有经典解（classical solution）。

另一方面，即使得到了$s\to 0$ 也很难得到$\dot{s}\to 0$，因为$\dot{s}$不是一直连续的，不满足Barbalat's Lemma 的条件。


## Fillipov意义下的趋近阶段分析方法

基于上面的经典解的分析的困难，在学术论文中通常会说系统需要在 Filippov 意义下理解。
直观来说，原来的经典解是需要找满足(eq 1)这个**微分方程**的$s(t)$。
而Filippov 意义下的解则为需要满足(eq 1)对应的Filippov微分包含的$s(t)$。
该微分包含定义为(eq 2)
$$
\dot{s}\in -k \operatorname{Sgn}(s)+\delta(t)
$$
其中
$$\operatorname{Sgn}(s)=\begin{cases}
\{-k\} & s>0\\
[-k,k] & s=0\\
\{k\}  & s<0
\end{cases}
\tag{eq 2}
$$
对于这样的微分包含系统(eq 2)使用Lyapunov 方法分析，需要使用广义导数，记为$\dot{\tilde{V}}$。
其与原始微分方程系统(eq 1)的关系为：$\dot{V}\in\dot{\tilde{V}}$。
所选取的Lyapunov 函数仍然是上面的$V$，其广义导数为：

$$
\begin{aligned}
\dot{V}=s\dot{s}\in\dot{\tilde{V}}
&=s\left(-k\operatorname{Sgn}(s)+\delta(t)\right)\\
&=-k\|s\|+s\delta \leq -k\|s\|+\|s\| \|\delta\|\\
&\leq -(k-\bar{\delta})\|s\|
\end{aligned}
$$

## 扰动是被sign函数抵消了吗？

通过非光滑理论的相关定理我们可以知道$s$在有限时间收敛到零，具体解释我不太懂。
同时也可以得到$\dot{s}$有限时间收敛到零。
有一种解释是用几何的方法来解释，这样比较直观
这里的系统是否$\dot{s}\to0$可以
$$
\dot s = -k \operatorname{sgn}(s) + \delta(t)
$$

这里就会有一个疑问$\dot{s}$收敛到零，似乎意味着上面的等式右边收敛到零，即$k \operatorname{sgn}(s)$收敛到$\delta(t)$.

在经典解的理解下，从逐点角度（pointwise）分析：

* $\operatorname{sgn}(s) \in \{-1,+1\}$
* $\delta(t) \in [-\bar{\delta},\bar{\delta}]$

因此显然有：
$$
\operatorname{sgn}(s) \neq 0.1\sin t \quad \text{for almost all } t
$$
确实，两者不相等。
但这**并非**滑模控制理论所主张的结论。
But that is **not** what sliding mode theory claims.

在系统的Filippov解意义下，系统的解应该满足微分包含方程
$$
\dot s =
\begin{cases}
-k + \delta(t), & s>0 \\
+k + \delta(t), & s<0
\end{cases}
$$

在 $s=0$ 处，Filippov定义：
$$
\dot s \in \operatorname{co}\{-k+\delta(t), k+\delta(t)\}
$$
即：当$s=0$时，
$\dot s \in [-k+\delta(t), k+\delta(t)]$.
显然，$\dot s = 0$满足这个区间，也就是说$\dot s = 0$是微分包含系统在 $s=0$ 处的一个可接受Filippov速度。
这保证了**滑模运动的存在性**。
This guarantees **existence of sliding motion**.



**实际的控制信号**仍然是：
$$
-k\operatorname{sgn}(s(t)) \in \{-k,+k\}
$$

但在滑模阶段：

* $s(t)$ 围绕0做无穷快振荡
* $\operatorname{sgn}(s(t))$ 做无穷快切换
* **时间平均**满足：
  $$
  \langle -\operatorname{sgn}(s) \rangle = -0.1\sin t
  $$

📌 这**不是逐点收敛**，而是**弱（平均）收敛**。
📌 This is **not pointwise convergence**, but **weak (averaged) convergence**.

从物理直觉上理解，可以理解为**占空比调制**(duty cycle modulation):

* 当 $\delta (t) > 0$ 时：$s>0$ 的持续时间更长
* 当 $\delta (t) < 0$ 时：$s<0$ 的持续时间更长

两侧的时间占比会自动调整，使得：
$$
k\operatorname{Sgn}\text{的平均切换效应} = \delta(t)
$$

这正是Filippov凸化所描述的本质。

总结：

| 误解 Misconception                            | 实际 Reality |
| ---------------------------------------- | ------- |
| $k\operatorname{sgn}(s)\to \delta (t)$    | ❌ 错误 false |
| 控制信号变为连续 Control becomes continuous               | ❌ 错误 false |
| 切换行为停止 Switching stops                          | ❌ 错误 false |
| 时间平均效应与扰动匹配 Time-averaged effect matches disturbance | ✅ 正确 true  |
| 滑模运动满足 $\dot s=0$ Sliding motion satisfies $\dot s=0$      | ✅ 正确 true  |


在滑模中，不连续项并非逐点收敛到扰动；其**平均效应**抵消了扰动，这一过程由Filippov凸化方法描述。



