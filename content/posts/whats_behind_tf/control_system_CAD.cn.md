---
title: "计算机辅助控制系统设计: 简介与回顾"
date: 2022-08-09
tags: ["Control Theory", "转载"]
categories: ["CACSD"]
---

## 原文信息

- Varga, A. (2020). Computer-Aided Control Systems Design: Introduction and Historical Overview. In: Baillieul, J., Samad, T. (eds) Encyclopedia of Systems and Control. Springer, London. https://doi.org/10.1007/978-1-4471-5102-9_138-3
- First Online: 08 November 2019
- Source: [springer](https://link.springer.com/referenceworkentry/10.1007/978-1-4471-5102-9_138-3), [pdf](https://core.ac.uk/download/pdf/31011908.pdf)
- Author: Andreas Varga
- Institution: German Aerospace Center, DLR Oberpfaffenhofen Institute of System Dynamics and Control
- email: Andreas.Varga@dlr.de

## 摘要

计算机辅助控制系统设计（ Computer-aided control system design ，CACSD）包含的领域非常广泛，
其包括用于系统模拟、控制系统合成与整定、动态系统分析与模拟，以及认证与验证等工作的方法，工具与技术。
近些年来，CACSD 所覆盖的领域有了进一步的拓展，
其从应用于控制系统分析与整合的算法程序的简单集合
发展为能够支撑各个应用领域先进控制系统开发部署等各个方面的完整工具集以及用户友好的开发环境。
本文给出了 CACSD 的简要介绍，同时回顾 CACSD 领域关键概念与技术的演化。
其中将重点介绍在开发可依赖数值算法，实现鲁棒数值分析软件以及开发随机交互模型、仿真与设计环境的一些支柱性成就。

**关键词（短语）**：
CACSD,
仿真,
建模,
数值分析,
软件工具

## 简介

为了给一个对象(plant)设计一个控制系统，典型的计算机辅助控制系统设计(CACSD)工作流程包括多个交错的工作。

**模型建立**通常是建立适合准确描述被控对象动态行为的数学模型所必须的第一步
