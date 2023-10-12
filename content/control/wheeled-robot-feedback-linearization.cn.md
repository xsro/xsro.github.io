+++
title = "Wheeled Robot Feedback Linearization"
date = 2023-10-09T21:43:59+08:00
[taxonomies]
tags = ["非完整约束", "反馈线性化", "小车"]
+++

# 通过坐标平移实现非完整约束系统的反馈线性化

> `YAMAMOTO Y, YUN X, 1992. Coordinating locomotion and manipulation of a mobile manipulator[C/OL]//[1992] Proceedings of the 31st IEEE Conference on Decision and Control. 2643-2648 卷3. DOI:10.1109/CDC.1992.371337.`

## 非完整系统

### 系统方程

考虑m个双边约束下具有n个广义坐标q的机械系统，其动力学方程可以通过欧拉拉格朗日方程
$$
M(q)\ddot{q}+V(q,\dot{q})=E(q)\tau-A^T(q)\lambda
\tag{1}
$$
确立，
其中$M(q)$是$n\times n$的惯性矩阵，
$V(q,\dot{q})$是关于位置和速度的阻力向量，
$E(q)$是$n\times r$的输入转换矩阵，
$\tau$是$r$维输入向量，
$A(q)$是$m\times n$的雅克比矩阵，
$\lambda$是约束力向量。
该机械系统的$m$个约束方程可以写成
$$
C(q,\dot{q})=0.
$$
如果其中的一个约束方程可以写成，
或者通过积分可以转化为$C_i(q)=0$的形式，那么该约束是完整约束。
否则，该约束为动力学约束（非几何约束），一般称为非完整(nonholonomic)约束。

**假设**有$k$个完整的以及$m-k$个非完整的独立约束，他们都可以写成
$$
A(q)\dot{q}=0
\tag{3}
$$
的形式。

令$s_q(q),\cdots,s_{n-m}(q)$为$A(q)$的零空间中的光滑并且线性不相关的向量场，i.e.
$$
A(q)s_i(q)=0, \quad i=1,\dots, n-m
$$
令$S(q)$为由这些向量组成的满秩矩阵
$$
S(q)=[s_1(q)\ \cdots\ s_{n-m}(q)]
$$
令$\Delta$为这些向量场张成的分布
$$
\Delta=span \{s_1(q), \cdots, s_{n-m}(q)\}
$$
因此，$\dot{q}\in\Delta$。
我们无法确定$\Delta$是否对合(involutive)。
可以令$\Delta^*$为包含$\Delta$的最小的对合分布。
可知$dim(\Delta)\leq dim(\Delta^*)=k$。

[G. Campion 1991](https://ieeexplore.ieee.org/document/261553)发现共由三种情况

1. $k=m$，所有的约束都是完整的，$\Delta$自身就是对合的
2. $k=0$，所有的约束都是非完整的，$\Delta*$为整个空间
3. $0<k<m$，$k$个约束是可积的，并且广义坐标的$k$个分量可能可以被运动方程消去。这种情况下$dim(\Delta^*)=n-k$


### 状态空间表达

考虑由(1)(3)定义与约束的系统，
由于受约束的速度总是在$A(q)$的零空间中，
可以定义$n-m$个速度$v(t)=[v_1\ v_2\ \cdots \ v_{n-m}]$使得
$$
\dot{q}=S(q)v(t)
\tag{5}
$$
这些速度需要是不可积的。
对(5)微分，并代入(1)中的$\ddot{q}$，同时前乘$S^T$
$$
S^T (MS \dot{v}(t)+M\dot{S}v(t)+V)=S^T E \tau
$$

选取状态量$x=[q^T\ v^T]^T$，可得
$$
\dot{x}=\begin{bmatrix}
Sv \\ f_2
\end{bmatrix}
+\begin{bmatrix}
0 \\ (S^T M S)^{-1} S^T E
\end{bmatrix}\tau
$$
其中，$f_2=(S^T M S)^{-1} (-S^T M \dot{S} v-S^T V)$。
**假设**执行器的输入数量大于或等于机械系统的自由度($t\geq n-m$)
并且$(S^T M S)^{-1} S^T E$的秩为$n-m$，
我们可能可以应用非线性反馈
$$
\tau=\left((S^T M S)^{-1} S^T E\right)^+(u-f_2)
$$
其中上标$+$表示矩阵的广义逆。
于是状态方程可以简化为
$$
\dot{x}=f(x)+g(x)u,f(x)
=\begin{bmatrix}S(q)v\\0\end{bmatrix},
g(x)=\begin{bmatrix}0\\I\end{bmatrix},
$$

### 控制属性

**定理1**: 非完整系统(10)是可控的

**定理2**：非完整系统的平衡点$x=0$，通过一个光滑的状态反馈控制，可以使其拉格朗日稳定，
但是无法使其渐近稳定。

余下的部分，我们考虑公式(3)同时包含完整约束以及非完整约束的情况。

**定理3**：如果系统(10)存在至少一个约束是非完整的，那么它不是可以通过状态反馈可以输入状态可线性化的

**证明**：系统如果输入状态可线性化，需要满足两个条件，可以发现对合条件并不满足。
1. the strong accessibility condition
2. the involutivity condition

定义一组分布
$$
D_j = span \{
    L^i_f g | i=0,1,\dots,j-1\}, j=1,2,\dots
$$
对合性要求$D_1,D_2,\dots,D_{2n-m}$都是对合的。
注意系统的状态数为$2n-m$。
由于$g$是常数，所以$D_1=span\{g\}$是对合的。
下面计算
$$
L_fg=[f,g]=
 \frac{\partial g}{\partial x}f
-\frac{\partial f}{\partial x}g
=-\begin{bmatrix}S(q)\\0\end{bmatrix}
$$
由于由$S(q)$的列张成的分布$\Delta$不是对合的，
分布$D_2=span\{g,L_fg\}$不是对合的。
因此，系统不是输入-状态可线性化的。
$\blacksquare$

尽管带有非完整约束的系统不是输入-状态可线性化的，
如果选取合适的输出方程，他是可以输入-输出线性化的。
考察系统的位置控制，也就是说输入方程只关于位置量$q$。
既然系统的自由度数为$n-m$，我们可能至多有$n-m$个独立的位置输出方程。
$$
y=h(q)=[h_1(q)\ \cdots \ h_{n-m}(q)]
\tag{11}
$$
可以输入输出线性化的充要条件为解耦矩阵满秩 [ref20][20]。
使用(11)的输出方程，系统的解耦矩阵$\Phi(x)$是$(n-m)\times (n-m)$的矩阵
$$
\Phi(q)=J_h(q)S(q)
$$
其中$J_h=\frac{\partial h}{\partial q}$是一个$(n-m)\times n$的Jacobian矩阵。
当$J_h$的行与$A(q)$独立的时候，\Phi(x)$ 是非奇异的

[20]: https://link.springer.com/book/10.1007/978-1-4757-2101-0

为了刻画零动态并且实现输入-输出线性化，引入新的状态变量$z$
$$
z=T(x)=\begin{bmatrix}z_1\\z_2\\z_3\end{bmatrix}
=\begin{bmatrix}h(q)\\L_f h(q)\\\tilde{h}(q)\end{bmatrix}
=\begin{bmatrix}h(q)\\\Phi(q) v\\\tilde{h}(q)\end{bmatrix}
$$
其中$\tilde{h}(q)$是可以使$[J_h^T,J_{\tilde{h}}^T]$满秩的m维函数。
可以验证$T(x)$是微分同胚并且是一个合理的状态变换。
新的状态$z$下的系统为：
$$
\dot{z}_1=\frac{\partial h}{\partial q} \dot{q}=z_2
$$
$$
\dot{z}_2=\dot{\Phi}(q) v + \Phi(q) u
$$
$$
\dot{z}_3=J_{\tilde{h}}S v = J_{\tilde{h}}S(J_h S)^{-1} z_2
$$
使用如下的状态反馈
$$
u=\Phi^{-1}(q)(v-\dot{\Phi}(q)v)
$$
我们实现了输入-输出线性化，同时实现了输入-输出解耦。
系统的可观测部分为
$$
\dot{z}_1=z_2,\quad \dot{z}_2=v \quad y=z_1
$$
系统的不可观测部分为：（代入$z_1=0$和$z_2=0$）
$$
\dot{z}_3=0
$$
这个系统显然是Lagrange稳定的但是不是渐近稳定。

