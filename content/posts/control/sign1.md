
+++
title = "Filippov滑模行为与边界层（正则化）行为的对比"
date = 2025-12-25
[taxonomies]
tags = ["控制"]
categories = ["控制理论"]
+++

以下是**Filippov滑模行为**与**边界层（正则化）行为**的**清晰对照说明**，聚焦于**解的定义、\(s\)与\(\dot s\)的实际表现，以及二者本质差异**（尽管它们常被混淆）。
Below is a **clear, side-by-side explanation** of the difference between **Filippov sliding behavior** and **boundary-layer (regularized) behavior**, focusing on *what the solution concept is*, *what actually happens to \(s\) and \(\dot s\)*, and *why they are fundamentally different*, even though they are often confused.


---

## 1. 两种概念解决的问题
## 1. What problem each concept is trying to solve

### Filippov滑模
### Filippov sliding
* 解决**不连续系统的数学适定性**
* Addresses **mathematical well-posedness** of *discontinuous* systems
* 回答：*当向量场不连续时，“解”的定义是什么？*
* Answers: *What does a solution mean when the vector field is discontinuous?*
* 使用**微分包含**
* Uses **differential inclusions**
* 理想的、厚度为0的切换面
* Ideal, zero-thickness switching surface


### 边界层（正则化）
### Boundary layer (regularization)
* 解决**物理可实现性**
* Addresses **physical realizability**
* 回答：*当切换不是无穷快时，实际发生了什么？*
* Answers: *What happens when switching is not infinitely fast?*
* 用**连续近似**替代不连续性
* Replaces discontinuity with a **continuous approximation**
* 在\(s=0\)周围引入**有限厚度的层**
* Introduces a **finite thickness layer** around \(s=0\)


➡️ **Filippov是解的定义；
边界层是控制设计/实现的选择。**
➡️ **Filippov is a solution concept.
Boundary layer is a control design / implementation choice.**


---

## 2. 典型示例
## 2. Canonical example

考虑系统
Consider
\[
\dot s = -\operatorname{sign}(s) + d(t),
\qquad |d(t)| < 1
\]


### Filippov版本
### Filippov version
完全使用\(\operatorname{sign}(s)\)。
Uses \(\operatorname{sign}(s)\) exactly.


### 边界层版本
### Boundary-layer version
将其替换为（例如）
Replaces it with, e.g.,
\[
\operatorname{sign}(s) \;\to\; \operatorname{sat}\left(\frac{s}{\varepsilon}\right)
\quad \text{或} \quad \tanh\left(\frac{s}{\varepsilon}\right)
\]


---

## 3. \(s(t)\)的行为
## 3. Behavior of \(s(t)\)

### Filippov滑模
### Filippov sliding
* 一旦进入滑模：
* Once sliding occurs:
  \[
  s(t) \equiv 0
  \]
* 运动被**约束在流形上**
* Motion is **constrained to the manifold**
* 无振荡幅值
* No oscillation amplitude
* 无穷大的切换频率（理想化）
* Infinite switching frequency (idealization)


形式化表述：
Formally:
\[
\dot s = 0 \quad \text{a.e.（几乎处处）}
\]


---

### 边界层行为
### Boundary-layer behavior
* 状态**永远不会精确到达**\(s=0\)
* The state **never reaches exactly** \(s=0\)
* 而是：
* Instead:
  \[
  |s(t)| \le \mathcal{O}(\varepsilon)
  \]
* 存在小但非零的振荡
* Small but nonzero oscillations
* 有限切换频率/平滑控制
* Finite switching / smooth control


形式化表述：
Formally:
\[
\dot s \neq 0 \quad \text{一般情况下}
\]


---

## 4. 扰动抑制能力
## 4. Disturbance rejection capability

这是**最重要的实际差异**。
This is the **most important practical difference**.


### Filippov滑模
### Filippov sliding
* 完全抑制匹配扰动：
* Perfect rejection of matched disturbances:
  \[
  \dot s = -u_{\mathrm{eq}} + d(t) = 0
  \]
* **与扰动变化率无关**
* Holds **independently of disturbance variation rate**
* 通过**时间平均切换**实现
* Achieved via **time-averaged switching**


### 边界层
### Boundary layer
* 仅*近似*抑制扰动：
* Only *approximate* disturbance rejection:
  \[
  \dot s = -\operatorname{sat}(s/\varepsilon) + d(t)
  \]
* 存在残差误差：
* Leaves a residual error:
  \[
  s_{\mathrm{ss}} = \mathcal{O}(\varepsilon)
  \]
* 性能依赖于\(\varepsilon\)
* Performance depends on \(\varepsilon\)


➡️ **精确不变性被破坏。**
➡️ **Exact invariance is lost.**


---

## 5. 几何解释
## 5. Geometric interpretation

### Filippov
* 切换面是**真正的不变流形**
* Switching surface is a **true invariant manifold**
* 向量场被**凸化**
* Vector field is **convexified**
* 选择切向向量：
* Tangential vector selected:
  \[
  \nabla s^\top \dot x = 0
  \]


### 边界层
### Boundary layer
* 切换面变为**管状区域**
* Switching surface becomes a **tube**
* 动力学在管状区域内流动
* Dynamics flow *through* the tube
* 无精确切向条件
* No exact tangency condition


---

## 6. 抖振与平滑
## 6. Chattering vs smoothing

| 维度 Aspect                 | Filippov滑模               | 边界层 Boundary layer |
| ---------------------- | ---------------------- | -------------- |
| 抖振 Chattering             | 无穷大（理论上） Infinite (theoretical) | 消除 Removed        |
| 切换频率 Switching frequency    | 无穷大 Infinite               | 有限 Finite         |
| 数学精确性 Mathematical exactness | 精确 Exact                  | 近似 Approximate    |
| 物理现实性 Physical realism       | 理想化 Idealized              | 实际 Realistic      |


引入边界层的原因，通常是Filippov滑模在物理上无法实现。
Boundary layers are often introduced *because* Filippov sliding is physically unrealizable.


---

## 7. 二者关系（关键洞察）
## 7. Relationship between the two (critical insight)

> **边界层行为≠Filippov滑模。**
> **Boundary-layer behavior does NOT equal Filippov sliding.**


但存在：
However:
\[
\boxed{
\text{当}\ \varepsilon \to 0\ \text{时，边界层解收敛到Filippov解}
}
\]
\[
\boxed{
\text{Boundary-layer solutions converge to Filippov solutions as }
\varepsilon \to 0
}
\]


这是**奇异摄动极限**，而非有限\(\varepsilon\)下的等价。
This is a **singular perturbation limit**, not equivalence at finite \(\varepsilon\).


---

## 8. 常见误解（非常重要）
## 8. Common misconception (very important)

❌ *“使用饱和函数实现了Filippov滑模。”*
❌ *“Using a saturation function implements Filippov sliding.”*
✔️ **错误**
✔️ **False**


* 它只是近似Filippov滑模
* It approximates Filippov sliding
* 破坏了精确不变性
* It destroys exact invariance
* 引入了稳态误差
* It introduces steady-state error


Filippov滑模**仅在不连续极限下存在**。
Filippov sliding exists **only** in the discontinuous limit.


---

## 9. 适用场景
## 9. When to use which

### 适用Filippov理论的场景：
### Use Filippov theory when:
* 证明稳定性或不变性
* Proving stability or invariance
* 理论分析鲁棒性
* Analyzing robustness theoretically
* 撰写期刊论文（如TAC、Automatica）
* Writing proofs for journals (e.g., TAC, Automatica)


### 适用边界层的场景：
### Use boundary layers when:
* 实现控制器
* Implementing controllers
* 避免抖振
* Avoiding chattering
* 应对执行器带宽限制
* Dealing with actuator bandwidth limits


---

## 10. 一句话总结
## 10. One-sentence takeaway


Filippov滑模是\(s=0\) 上理想的、不变的集值运动；
边界层行为是平滑近似，以精确性换取可实现性。

Filippov sliding is an ideal, invariant, set-valued motion on \(s=0\);
 boundary-layer behavior is a smooth approximation that trades exactness for implementability.


---

如果需要，我可以：
If you want, I can next:

* 证明边界层解收敛到Filippov解
* Prove convergence of boundary-layer solutions to Filippov solutions
* 对比呈现Lyapunov不等式
* Show Lyapunov inequalities side-by-side
* 解释**高阶滑模**如何避免边界层
* Explain how **higher-order sliding modes** avoid boundary layers
* 关联到**输入-状态稳定（ISS）与最终有界性**
* Relate this to **ISS and ultimate boundedness**


告诉我你的需求即可。
Just say which direction you want.