+++
title = "非连续动态系统分析3——非光滑系统的 Lyapunov 分析方法"
date = 2025-12-31
math = true
draft = true
tags = ["控制理论", "非光滑"]
categories = ["非连续动态系统分析", "控制理论"]
+++

经典的Lyapunov 方法要求的Lyapunov函数是连续可导的，对于非光滑系统不一定能找到这样的函数，因此非光滑系统的Lyapunov 分析会复杂一些。

本文收录在[非连续动态系统分析](https://xsro.github.io/cn/categories/%E9%9D%9E%E8%BF%9E%E7%BB%AD%E5%8A%A8%E6%80%81%E7%B3%BB%E7%BB%9F%E5%88%86%E6%9E%90/)系列

# 非光滑系统的 Lyapunov 分析方法

# 正则函数
要引入**正则函数**的概念，我们首先需要定义**右方向导数**和**广义右方向导数**。

设 \( f:\mathbb{R}^d \to \mathbb{R} \)，函数 \( f \) 在点 \( x \) 处沿方向 \( v \in \mathbb{R}^d \) 的**右方向导数**定义为：
\[
f'(x;v)=\lim_{h\to 0^+}\frac{f(x+hv)-f(x)}{h}
\]
当该极限存在时，此定义成立。

另一方面，函数 \( f \) 在点 \( x \) 处沿方向 \( v \in \mathbb{R}^d \) 的**广义右方向导数**定义为：
\[
\begin{aligned}
f^0(x;v)&=\limsup_{\substack{h\to 0^+\\ y\to x}}\frac{f(y+hv)-f(y)}{h}\\
&=\lim_{\varepsilon\to 0^+}\sup_{\substack{y\in B(x,\varepsilon)}}\frac{f(y+hv)-f(y)}{h}.
\end{aligned}
\]

---

广义方向导数相比右方向导数的优势在于，前者的极限**总是存在**。当右方向导数存在时，这两个量可能不同；当二者相等时，我们称该函数是**正则的**。

更严格的定义是：若函数 \( f:\mathbb{R}^d \to \mathbb{R} \) 对所有 \( v \in \mathbb{R}^d \)，在点 \( x \in \mathbb{R}^d \) 处沿方向 \( v \) 的右方向导数都存在，且满足
\[
f'(x;v)=f^0(x;v)
\]
则称 \( f \) 在 \( x \) 处**正则**。

在 \( x \) 处连续可微的函数一定是正则的；此外，凸函数也是正则的（参考文献 [9]，命题 2.3.6）。

---

### 示例
函数 \( g:\mathbb{R}\to\mathbb{R},\;g(x)=-|x| \) **不是正则函数**。
因为 \( g \) 除了在 \( 0 \) 点外处处连续可微，所以它在 \( \mathbb{R}\setminus\{0\} \) 上是正则的。然而，它在 \( 0 \) 点处的方向导数为
\[
g'(0;v)=\begin{cases}
-v,&v>0,\\
v,&v<0,
\end{cases}
\]
而广义方向导数为
\[
g^0(0;v)=\begin{cases}
v,&v>0,\\
-v,&v<0,
\end{cases}
\]
二者并不相等。因此，\( g \) 在 \( 0 \) 点处**不是正则的**。


## 广义导数

设 \( f:\mathbb{R}^d \to \mathbb{R} \) 为**局部利普希茨函数**，记 \( \Omega_f \subset \mathbb{R}^d \) 为 \( f \) 不可微的点集。
\( f \) 的**广义梯度** \( \partial f:\mathbb{R}^d \to \mathcal{B}(\mathbb{R}^d) \) 定义为：
\[
\partial f(x) \triangleq \text{co}\left\{\lim_{i\to\infty}\nabla f(x_i):\;x_i\to x,\;x_i\notin S\cup\Omega_f\right\},\tag{37}
\]
其中 \( \text{co} \) 表示**凸包**。在此定义中，\( S\subset\mathbb{R}^d \) 是一个**零测集**，可以任意选取以简化计算。
最终得到的集合 \( \partial f(x) \) 与 \( S \) 的选择无关。

从定义可知，\( f \) 在点 \( x \) 处的广义梯度，由 \( f \) 所有可微邻域点处梯度的**所有可能极限的凸组合**构成。
广义梯度的等价定义可参考文献 [9]。




[9] F.H. Clarke, Optimization and Nonsmooth Analysis (Canadian Math. Soc. Series of Monographs and Advanced Texts). New York: Wiley, 1983.



## 基于广义李导数的稳定性定理

# 翻译与解读

---

### 第一部分：稳定性结果
上一节的结果确立了下半连续集值映射的单调性行为，这为我们提供了稳定性分析的工具。我们在此给出与局部利普希茨函数和广义梯度相关的李雅普诺夫稳定性讨论的平行阐述。我们先提出一个李雅普诺夫稳定性结果，其推导过程可参考文献 [24]。

**定理 3**
设 \( \mathcal{F}:\mathbb{R}^d \to \mathcal{B}(\mathbb{R}^d) \) 为满足命题 S2 假设的集值映射。设 \( x_e \) 为微分包含 (63) 的平衡点，\( D \subseteq \mathbb{R}^d \) 为包含 \( x_e \) 的区域（即 \( x_e \in D \)）。设 \( f:\mathbb{R}^d \to \mathbb{R} \)，且满足以下条件：

**i)**
在区域 \( D \) 上，要么 \( \mathcal{F} \) 连续且 \( f \) 局部利普希茨，
要么 \( \mathcal{F} \) 局部利普希茨且 \( f \) 在 \( D \) 上下半连续，
且 \( f \) 在 \( x_e \) 处连续。

**ii)**
\( f(x_e)=0 \)，且对所有 \( x \in D\setminus\{x_e\} \)，有 \( f(x)>0 \)。

**iii)**
对所有 \( x \in D \)，有 \( \sup_{v\in\mathcal{F}(x)}\langle\nabla f(x),v\rangle \leq 0 \)。

**结论**：
此时，\( x_e \) 是微分包含 (63) 的**强稳定平衡点**。

此外，若将条件 **iii)** 替换为
**iii')** 对所有 \( x \in D\setminus\{x_e\} \)，有 \( \sup_{v\in\mathcal{F}(x)}\langle\nabla f(x),v\rangle < 0 \)，
则 \( x_e \) 是微分包含 (63) 的**强渐近稳定平衡点**。

---

### 第二部分：弱稳定性与全局稳定性
类似的结果可推广到弱稳定平衡点，只需将条件 **i)** 替换为“\( \mathcal{F} \) 在 \( D \) 上连续”，并将条件 **ii)** 和 **iii)** 中的下集值李导数替换为上集值李导数。注意，若微分包含 (63) 从每个初始条件出发都有唯一解，则强稳定与弱稳定的概念是等价的，此时只需满足更简单的条件 **i')** 和 **iii')** 即可判定弱稳定性。

与连续微分方程的情况类似，全局渐近稳定性可通过要求李雅普诺夫函数 \( f \) 连续且径向无界来建立。全局强渐近稳定性与无穷可微李雅普诺夫函数存在性的等价性可参考文献 [62]。这类全局结果常用于通过李雅普诺夫函数对控制系统的镇定问题进行分析 [25]，或处理李雅普诺夫函数对的相关问题 [24]。

---

### 第三部分：李雅普诺夫函数对
若函数 \( f,g:\mathbb{R}^d \to \mathbb{R} \) 满足以下条件，则称其为平衡点 \( x_e \) 的**李雅普诺夫函数对**：
- \( f(x),g(x)\geq 0 \) 对所有 \( x \in \mathbb{R}^d \) 成立；
- \( g(x)=0 \) 当且仅当 \( x=x_e \)；
- \( f \) 径向无界；
- 对所有 \( x \in \mathbb{R}^d \)，有 \( \sup_{v\in\mathcal{F}(x)}\langle\nabla f(x),v\rangle \leq -g(x) \)。

若微分包含 (63) 的平衡点 \( x_e \) 存在李雅普诺夫函数对，则从每个初始条件出发，至少存在一个解会渐近收敛到该平衡点，这一结论可参考文献 [24]。

---

我可以帮你整理一份**李雅普诺夫稳定性判定速查表**，把强稳定、强渐近稳定和李雅普诺夫函数对的条件都列在一起，方便你对比记忆。需要吗？