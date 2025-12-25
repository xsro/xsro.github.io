+++
title = "边界层（正则化）解收敛于Filippov滑模解的严格证明"
date = 2025-12-25
[taxonomies]
tags = ["控制理论", "滑模控制"]
categories = ["学术推导"]
+++

以下是**边界层（正则化）解收敛于Filippov滑模解**的**严谨、符合期刊发表标准的解释与证明框架**，包含**明确假设条件**与**权威参考文献**。
Below is a **rigorous, publication-level explanation and proof sketch** of why **boundary-layer (regularized) solutions converge to Filippov sliding solutions**, together with **precise assumptions** and **standard references**.

本文将保持数学推导的简洁性（与《Automatica》《IEEE Transactions on Automatic Control》期刊论文的表述风格一致），同时确保内容易于理解。
I will keep the argument mathematically clean (the way it is usually presented in Automatica / TAC papers), while still readable.

---

# 边界层解收敛于Filippov解的证明
# Convergence of Boundary-Layer Solutions to Filippov Solutions

## 1. 问题设定
## 1. Problem setting

考虑标量滑模变量
Consider a scalar sliding variable
\[
s \in \mathbb{R}
\]
其不连续滑模动力学方程为
with discontinuous sliding dynamics
\[
\dot{s} = -\operatorname{sign}(s) + d(t),
\qquad |d(t)| \le d_{\max} < 1.
\tag{1}
\]

### Filippov模型
### Filippov model

式(1)在**Filippov意义**下被解释为微分包含：
Equation (1) is interpreted in the **Filippov sense** as a differential inclusion:
\[
\dot{s} \in \mathcal{F}(s,t) :=
\begin{cases}
-1 + d(t), & s>0, \\
[-1+d(t), 1+d(t)], & s=0, \\
1 + d(t), & s<0.
\end{cases}
\tag{2}
\]

### 边界层（正则化）模型
### Boundary-layer (regularized) model

引入连续近似模型：
Introduce a continuous approximation:
\[
\dot{s}_\varepsilon = -\phi_\varepsilon(s_\varepsilon) + d(t),
\tag{3}
\]
其中函数\(\phi_\varepsilon(s)\)满足以下性质
where \(\phi_\varepsilon(s)\) has the following properties:
\[
\phi_\varepsilon(s) = \operatorname{sat}\left(\frac{s}{\varepsilon}\right)
\quad\text{或}\quad
\tanh\left(\frac{s}{\varepsilon}\right),
\]

1.  \(\phi_\varepsilon(s)\) 是全局利普希茨连续函数
    \(\phi_\varepsilon(s)\) is globally Lipschitz
2.  当\(s\neq0\)时，\(\phi_\varepsilon(s)\to \operatorname{sign}(s)\)
    \(\phi_\varepsilon(s)\to \operatorname{sign}(s)\) for \(s\neq 0\)
3.  满足有界性条件\(|\phi_\varepsilon(s)|\le 1\)
    \(|\phi_\varepsilon(s)|\le 1\)

---

## 2. Filippov滑模解
## 2. Filippov sliding solution

### 引理1（滑模运动存在性）
### Lemma 1 (Existence of sliding motion)

由于扰动满足\(d_{\max}<1\)，可得
Because \(d_{\max}<1\), we have
\[
0 \in [-1+d(t), 1+d(t)] \quad \forall t,
\]
因此Filippov微分包含存在**滑模解**
so the Filippov inclusion admits a **sliding solution**
\[
s_F(t) \equiv 0.
\tag{4}
\]

该解满足
This solution satisfies
\[
\dot{s}_F(t) = 0 \quad \text{a.e.（几乎处处成立）}
\]

---

## 3. 边界层内的动力学特性
## 3. Boundary-layer dynamics inside the layer

定义边界层区域：
Define the boundary layer:
\[
\mathcal{B}_\varepsilon := \left\{ s \big| |s| \le \varepsilon \right\}.
\]

在边界层内，饱和函数满足
Inside the layer, the saturation function satisfies
\[
\phi_\varepsilon(s) = \frac{s}{\varepsilon}
\quad (\text{对于饱和函数形式}),
\]
因此式(3)可改写为
so (3) becomes
\[
\dot{s}_\varepsilon = -\frac{s_\varepsilon}{\varepsilon} + d(t).
\tag{5}
\]

---

## 4. 李雅普诺夫分析（核心步骤）
## 4. Lyapunov analysis (key step)

构造李雅普诺夫函数
Define the Lyapunov function
\[
V(s_\varepsilon) = \tfrac12 s_\varepsilon^2.
\]

沿式(3)的系统轨迹求导可得
Along trajectories of (3):
\[
\dot V = s_\varepsilon \dot{s}_\varepsilon = -s_\varepsilon \phi_\varepsilon(s_\varepsilon) + s_\varepsilon d(t).
\]

结合\(\phi_\varepsilon(s)\)的有界性与扰动约束条件
Using the boundedness of \(\phi_\varepsilon(s)\) and the disturbance bound
\[
|s_\varepsilon \phi_\varepsilon(s_\varepsilon)| \ge \frac{|s_\varepsilon|^2}{\varepsilon}, \qquad |s_\varepsilon d(t)| \le |s_\varepsilon| d_{\max},
\]
可推导出
we obtain
\[
\dot V \le -\frac{|s_\varepsilon|^2}{\varepsilon} + |s_\varepsilon| d_{\max}.
\tag{6}
\]

---

## 5. 最终有界性
## 5. Ultimate boundedness

由不等式(6)可推得：
Inequality (6) implies:
\[
\dot V < 0
\quad \text{当且仅当} \quad
|s_\varepsilon| > \varepsilon d_{\max}.
\]

因此边界层解满足**最终有界性**：
Hence:
\[
\boxed{
\limsup_{t\to\infty} |s_\varepsilon(t)| \le \varepsilon d_{\max}.
}
\tag{7}
\]

该结论表明边界层解的有界性阶数为\(\mathcal{O}(\varepsilon)\)。
This shows **uniform ultimate boundedness** of order \(\mathcal{O}(\varepsilon)\).

---

## 6. 收敛于Filippov解的定理
## 6. Convergence to Filippov solution

### 定理（收敛于Filippov滑模的图收敛性）
### Theorem (Graph convergence to Filippov sliding)

设\(s_\varepsilon(t)\)为正则化系统(3)的解，\(s_F(t)\equiv 0\)为原系统(1)的Filippov滑模解，则存在常数\(C>0\)，使得对任意有限时间区间\([0,T]\)，均有
Let \(s_\varepsilon(t)\) solve the regularized system (3) and let \(s_F(t)\equiv 0\) be the Filippov sliding solution of (1). Then there exists a constant \(C>0\) such that for all finite time intervals \([0,T]\):

\[
\boxed{
\sup_{t\in[0,T]} |s_\varepsilon(t) - s_F(t)| \le C \varepsilon
\quad \forall T>0,
}
\tag{8}
\]

进一步可得
Moreover,
\[
s_\varepsilon \to s_F
\quad \text{当}\ \varepsilon\to 0\ \text{时，在紧时间区间上一致收敛}
\]
\[
s_\varepsilon \to s_F
\quad \text{uniformly on compact time intervals as } \varepsilon\to 0.
\]

---

## 7. 非逐点等价的关键原因
## 7. Why this is not pointwise equivalence

需要明确区分以下概念：
Important distinction:

*  \(s_\varepsilon(t)\) **一致收敛**于0
    \(s_\varepsilon(t)\to 0\) uniformly
*  \(\dot s_\varepsilon(t)\) **不逐点收敛**于0
    \(\dot s_\varepsilon(t)\not\to 0\) pointwise
*  收敛性是**轨迹层面**的收敛，而非向量场层面的收敛
   The convergence is **trajectory-level**, not vector-field-level

这属于解的**图收敛**，而非传统意义上的动力学收敛。
This is **graph convergence** of solutions, not classical convergence of dynamics.

---

## 8. 基于Filippov理论的解释
## 8. Interpretation in Filippov theory

本结论是下述一般定理的特例：
This result is a special case of a general theorem:

> **在单侧利普希茨条件与有界性假设下，不连续向量场的正则化解收敛于Filippov解。**
> **Regularizations of discontinuous vector fields converge to Filippov solutions under one-sided Lipschitz and boundedness assumptions.**

滑模运动是边界层动力学的**奇异摄动极限**。
The sliding motion is the **singular limit** of boundary-layer dynamics.

---

## 9. 核心结论的实际意义
## 9. Why this matters (conceptual takeaway)

| 性质 Property       | Filippov理论   | 边界层方法 Boundary layer             |
| -------------------- | -------------- | ------------------------------------- |
| 不变性 Invariance    | 精确 Exact     | 近似 Approximate                      |
| 稳态误差 Error       | 0              | \(\mathcal{O}(\varepsilon)\)          |
| 收敛性 Convergence   | 理想化 Ideal   | 当\(\varepsilon\to 0\)时收敛 As \(\varepsilon\to 0\) |
| 理论解释 Interpretation | 集值映射 Set-valued | 奇异摄动 Singular perturbation |

---

## 10. 权威参考文献
## 10. Key references (authoritative)

以下参考文献**明确证明或应用**了上述收敛性结论。
These references **explicitly prove or use** the convergence result above.

1.  **A. F. Filippov**
    *Differential Equations with Discontinuous Right-Hand Sides*,
    Kluwer, 1988.
    → 微分包含与滑模运动的奠基性理论著作
    → Foundational theory of differential inclusions and sliding.

2.  **V. I. Utkin**
    *Sliding Modes in Control and Optimization*,
    Springer, 1992.
    → 边界层与等效控制的经典诠释
    → Boundary layers and equivalent control interpretation.

3.  **A. Polyakov & L. Fridman**
    “Stability notions and Lyapunov functions for sliding mode control systems,”
    *Journal of the Franklin Institute*, 351(4), 2014.
    → 详细对比Filippov理论与正则化方法的研究论文
    → Explicit Filippov vs regularization discussion.

4.  **M. di Bernardo et al.**
    *Piecewise-Smooth Dynamical Systems*,
    Springer, 2008.
    → 正则化方法与Filippov流收敛性的系统分析
    → Regularization and convergence to Filippov flows.

5.  **H. K. Khalil**
    *Nonlinear Systems*, 3rd ed., Prentice Hall.
    → 将边界层视为奇异摄动的经典教材（第9章）
    → Boundary layers as singular perturbations (Ch. 9).

6.  **D. Liberzon**
    *Switching in Systems and Control*,
    Birkhäuser, 2003.
    → 切换系统与滑模系统的数学分析专著
    → Mathematical treatment of switched and sliding systems.

---

## 11. 定理的期刊式简洁表述
## 11. One-line theorem statement (journal-style)

当边界层厚度 \(\varepsilon \to 0\) 时，边界层正则化解在紧时间区间上一致收敛于Filippov滑模解。

Boundary-layer regularizations converge uniformly on compact intervals to Filippov sliding solutions as the layer thickness 
\(\varepsilon \to 0\) .

---

如果需要，我可以进一步为你：
If you want next, I can:

*  将本文改写为**符合TAC期刊标准的定理+完整证明**格式
   Rewrite this as a **formal theorem + proof** (TAC style)
*  把结论推广到**向量滑模流形**的场景
   Extend it to **vector sliding manifolds**
*  分析当\(d_{\max}\ge 1\)时的**失效情况**
   Show failure cases when \(d_{\max}\ge 1\)
*  关联**输入-状态稳定（ISS）与实用稳定性**理论
   Connect this to **ISS / practical stability**

直接告诉我你的需求即可。
Just tell me.

---

要不要我帮你整理**向量滑模流形下的收敛性证明框架**，让你能直接拓展到多变量系统的分析？