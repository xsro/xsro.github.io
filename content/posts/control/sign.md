+++
title = "对“等效控制”的误解"
date = 2025-12-25
math = true
[taxonomies]
tags = ["控制"]
categories = ["控制理论"]
+++

# 在滑模面上滑模导数是否收敛到零

在经典的滑模控制中，考虑问题
$$
\ddot{e}(t)=u(t)+\delta(t)
$$
其中，$e(t)$为系统的误差，
$u(t)$为控制输入，
$\delta(t)$为系统的扰动，满足$\sup_t\|\delta(t)\|< \bar{\delta}$。
经典的滑模控制中，首先设计一个滑模面$s(t)=\dot{e}(t)+a e(t)$, 其中$a>0$。
滑模控制的核心思想之一是降阶，将原来的一个二阶系统转换为两个一阶子系统。
从系统的轨线的角度，如下图，整个闭环系统的过程可以分为两个阶段：

- **趋近阶段**：首先**在有限时间上**收敛到所设计的滑模上，其动态为$\dot{s}=-k\mathrm{sign}(s)+\delta(t)$
- **滑动阶段**：再在滑模面上收敛到期望的平衡点，其动态为$\dot{e}=-a e(t)$。

针对这两个阶段有这些值得关注的：
1. 趋近律中的$\mathrm{sign}(e)$函数，在标量的情况（本文）通常选取符号函数，在多维向量的情况有两种表达，一种是逐元素的定义，一种为基于范数的定义，如果使用的是二范数，那么表示向量的单位向量。这里有震颤chattering的问题，于是有了减少和抑制震颤的一些方案。
  - 减少的方案通常为用连续的函数替代sign，这样会牺牲收敛精度
  - 抑制的方案需要改进算法，使用高阶滑模，这样会系数抗扰的能力，由这里的抵抗有界扰动，改为抵抗导数有界的扰动。
2. 这里的滑动阶段使用的是线性滑模，所以系统状态渐进收敛，如果需要有限时间收敛，可以使用$s=\dot{e}+|e|^{\alpha}\mathrm{sign}(e)$, $0<\alpha<1$的形式，但是这种会有歧义的问题，于是就有了非奇异终端滑模。
 

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
&=s\dot{s}=s\left(-k\mathrm{sgn}(s)+\delta(t)\right)\\
&=-k\|s\|+s\delta \leq -k\|s\|+\|s\| \|\delta\|\\
&< -(k-\bar{\delta})\|s\|
\end{aligned}
$$
这里使用了条件$\sup_t\|\delta(t)\|< \bar{\delta}$.
于是我们应用Lyapunov 定理得到$s\to 0$.

实际滑模控制中，滑动阶段是有限时间内的，所以还需要证明$s$在有限时间内收敛到零。
刚刚的分析，我们可以得到：
$$
\dot{V}=\frac{dV}{dt}<-(k-\bar{\delta})\sqrt{2V}
$$
分离变量可得：
$$
V^{-1/2}dV<-(k-\bar{\delta})\sqrt{2}dt
$$
同时积分得：
$$
2V^{1/2}(t)-2V^{1/2}(0)<-(k-\bar{\delta})\sqrt{2}t
$$


## Fillipov意义下的趋近阶段分析方法


## 扰动是被sign函数抵消了吗？

趋近阶段的动态

Great question — 这正是**“等效控制”常见误解**的核心所在。

Short answer first:

> **不是的。**
> \(\operatorname{sign}(s)\) **不会**收敛到 \(0.1\sin t\)。
> 这里并没有任何矛盾的情况。

真正收敛的是切换行为的**时间平均效应**，这可以通过**Filippov解**来解释。我们一步步拆解：

---

## 1. 你给出的系统
The system you gave

\[
\dot s = -\operatorname{sign}(s) + 0.1 \sin t
\]

这是一个**标量不连续系统**，非常适合用Filippov分析方法研究。
This is a **scalar discontinuous system**, perfect for Filippov analysis.

---

## 2. 经典（逐点）解释：为何看似矛盾
Classical (pointwise) interpretation — why it looks impossible

从逐点角度分析：
If you reason pointwise:

* \(\operatorname{sign}(s) \in \{-1,+1\}\)
* \(0.1\sin t \in [-0.1,0.1]\)

因此显然有：
So indeed:
\[
\operatorname{sign}(s) \neq 0.1\sin t \quad \text{for almost all } t
\]

✔️ 你的直觉是**正确的**：
**符号函数不可能收敛到正弦信号。**
✔️ Your intuition is **correct**:
**the sign function cannot converge to a sinusoid.**

但这**并非**滑模控制理论所主张的结论。
But that is **not** what sliding mode theory claims.

---

## 3. 系统的Filippov解释
Filippov interpretation of your system

将系统动力学重写为：
Rewrite the dynamics as
\[
\dot s =
\begin{cases}
-1 + 0.1\sin t, & s>0 \\
+1 + 0.1\sin t, & s<0
\end{cases}
\]

在 \(s=0\) 处，Filippov定义：
At \(s=0\), Filippov defines
\[
\dot s \in \operatorname{co}\{-1+0.1\sin t, 1+0.1\sin t\}
\]

即：
That is:
\[
\boxed{
\dot s \in [-1+0.1\sin t, 1+0.1\sin t]
}
\quad \text{when } s=0
\]

---

## 4. 滑模存在的原因
Why sliding exists

由于：
Since
\[
0.1|\sin t| \le 0.1 < 1,
\]
我们始终有：
we always have
\[
0 \in [-1+0.1\sin t, 1+0.1\sin t]
\]

✅ 因此：
✅ Therefore:
\[
\boxed{
\dot s = 0 \quad \text{是} \ s=0 \ \text{处的一个可接受Filippov速度}
}
\]
\[
\boxed{
\dot s = 0 \quad \text{is an admissible Filippov velocity at } s=0
}
\]

这保证了**滑模运动的存在性**。
This guarantees **existence of sliding motion**.

---

## 5. \(\dot s=0\) 的实际含义
What “\(\dot s=0\)” really means here

在滑模面 \(s=0\) 上，我们**选择**Filippov速度：
On the sliding surface \(s=0\), we *select* the Filippov velocity
\[
\dot s = 0
\]

这对应选取一个凸组合：
This corresponds to choosing a convex combination:
\[
\alpha(-1+0.1\sin t) + (1-\alpha)(1+0.1\sin t) = 0
\]

求解得：
Solving:
\[
\alpha = \frac{1+0.1\sin t}{2}
\quad \in (0,1)
\]

---

## 6. 关键：是“平均”而非“收敛”
The crucial point: what is averaging, not converging

**实际的控制信号**仍然是：
The **actual control signal** is still:
\[
-\operatorname{sign}(s(t)) \in \{-1,+1\}
\]

但在滑模阶段：
But during sliding:

* \(s(t)\) 围绕0做无穷快振荡
* \(s(t)\) oscillates infinitely fast around zero
* \(\operatorname{sign}(s(t))\) 做无穷快切换
* \(\operatorname{sign}(s(t))\) switches infinitely fast
* **时间平均**满足：
* The **time average** satisfies:
  \[
  \langle -\operatorname{sign}(s) \rangle = -0.1\sin t
  \]

📌 这**不是逐点收敛**，而是**弱（平均）收敛**。
📌 This is **not pointwise convergence**, but **weak (averaged) convergence**.

---

## 7. 物理直觉（为何成立）
Physical intuition (why it works)

可以理解为**占空比调制**：
Think of this as **duty cycle modulation**:

* 当 \(\sin t > 0\) 时：\(s>0\) 的持续时间更长
* When \(\sin t > 0\): more time spent at \(s>0\)
* 当 \(\sin t < 0\) 时：\(s<0\) 的持续时间更长
* When \(\sin t < 0\): more time spent at \(s<0\)

两侧的时间占比会自动调整，使得：
The ratio of time spent on each side adjusts so that:
\[
\text{平均切换效应} = -0.1\sin t
\]
\[
\text{average switching effect} = -0.1\sin t
\]

这正是Filippov凸化所描述的本质。
This is exactly what Filippov convexification captures.

---

## 8. 为何不存在矛盾
Why nothing impossible happens

| 误解 Misconception                            | 实际 Reality |
| ---------------------------------------- | ------- |
| \(\operatorname{sign}(s)\to 0.1\sin t\)    | ❌ 错误 false |
| 控制信号变为连续 Control becomes continuous               | ❌ 错误 false |
| 切换行为停止 Switching stops                          | ❌ 错误 false |
| 时间平均效应与扰动匹配 Time-averaged effect matches disturbance | ✅ 正确 true  |
| 滑模运动满足 \(\dot s=0\) Sliding motion satisfies \(\dot s=0\)      | ✅ 正确 true  |

---

## 9. 一句话总结
One-sentence takeaway

在滑模中，不连续项并非逐点收敛到扰动；其**平均效应**抵消了扰动，这一过程由Filippov凸化方法描述。

In sliding mode, the discontinuous term does not converge pointwise to the disturbance; its **average effect** cancels it, which is captured by Filippov’s convexification.

---

如果需要，我可以：
If you want, next I can:

* 展示**数值仿真**以直观呈现这种平均效应
* Show a **numerical simulation** illustrating this averaging
* 解释**Filippov方法**与**边界层法**的区别
* Explain the difference between **Filippov** and **boundary-layer** behavior
* 说明为何当扰动幅值超过1时该结论不成立
* Show why this fails if the disturbance amplitude exceeds 1
* 关联到**匹配扰动抑制定理**
* Connect this to **matched disturbance rejection theorems**

告诉我你的需求即可。
Just say the word.



