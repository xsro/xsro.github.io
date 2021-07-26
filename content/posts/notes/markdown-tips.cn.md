---
author: xsro
title: Markdown 常用拓展语法参考
date: 2021-07-25
description: Markdown 常用拓展语法参考
tags: ["markdown"]
categories: ["常用技术速查"]
math: true
ShowBreadCrumbs: false
---

# Markdown 常用拓展语法参考

## 常用链接

- 基本语法
  1. GitHub Flavored Markdown Spec: [gfm](https://github.github.com/gfm/)
  2. github上的markdown语法速查表[markdown-cheatsheet](https://github.com/tchapi/markdown-cheatsheet),[Markdown](https://github.com/younghz/Markdown)
  3. [typora](http://support.typora.io/)的帮助
- 数学公式：通常markdown使用mathjax或者katex来渲染公式，katex更快，latex更全
  1. $\latex$  [mathjax](http://docs.mathjax.org/en/latest/input/tex/macros/index.html)，使用者如：typora
  2. $\katex$  [katex](https://katex.org/docs/supported.html)
- emoji参考:v: 
  1. [emoji表](emoji.md)来自[caiyongji/emoji-list](https://github.com/caiyongji/emoji-list)
  2. [emoji-cheat-sheet](http://emoji-cheat-sheet.com/)
- Mermaid图表:一般都是使用的mermaid.js来渲染的，注意版本
  1. mermaid.js 官方文档：[mermaid](https://mermaid-js.github.io/mermaid/#)
  2. typora的相关帮助文档：[Draw Diagrams With Markdown (typora.io)](https://support.typora.io/Draw-Diagrams-With-Markdown/)
- Badge 徽章：![star](https://img.shields.io/github/stars/xsro?style=flat-square)
  1. <https://shields.io/>
  2. 在gitee中使用徽标：在git仓库主页一次点击`管理`、`仓库挂件`即可看到

## 常用html代码

### 行内html

| Raw Markdown Source                                          | Output in Live Preview                                       |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `<span style='color:red'>This is red</span>`                 | <span style='color:red'>This is red</span>                   |
| `<ruby> 漢 <rt> ㄏㄢˋ </rt> </ruby>`                         | <ruby> 漢 <rt> ㄏㄢˋ </rt> </ruby>                           |
| `<kbd>Ctrl</kbd>+<kbd>F9</kbd>`                              | <kbd>Ctrl</kbd>+<kbd>F9</kbd>                                |
| `<span style="font-size:2rem; background:yellow;">**Bigger**</span>` | <span style="font-size:2rem; background:yellow;">**Bigger**</span> |
| `HTML entities like &reg; &#182;`                            | HTML entities like &reg; &#182;                              |

### 文本注释、隐藏与折叠 

#### 注释内容

```html
<!--这是注释-->
```

#### 隐藏段落

```html
<p hidden>
    这是需要隐藏的段落
    不可以有空行
</p>
```

#### 折叠

```html
<details>
    <summary>I have keys but no locks. I have space but no room. You can enter but can't leave. What am I?</summary>
    A keyboard.
</details>
```

效果：

<details>
    <summary>I have keys but no locks. I have space but no room. You can enter but can't leave. What am I?</summary>
    A keyboard.
</details>

### 音视频

```html
<audio src="xxx.mp3"></audio>
<video src="xxx.mp4"></video>
```

#### 加载哔哩哔哩视频

```html
<iframe src="//player.bilibili.com/player.html?aid=66583807&bvid=BV1n441127jG&cid=116735636&page=1" scrolling="no" border="0" frameborder="no" framespacing="0" allowfullscreen="true"> </iframe>
```

效果：

<iframe src="//player.bilibili.com/player.html?aid=66583807&bvid=BV1n441127jG&cid=116735636&page=1" scrolling="no" border="0" frameborder="no" framespacing="0" allowfullscreen="true"> </iframe>



## 常见符号



|||||
|---------------|-------------|-------------|---------------|
| $\Alpha$ `\Alpha` | $\Beta$ `\Beta` | $\Gamma$ `\Gamma`| $\Delta$ `\Delta`
| $\Epsilon$ `\Epsilon` | $\Zeta$ `\Zeta` | $\Eta$ `\Eta` | $\Theta$ `\Theta`
| $\Iota$ `\Iota` | $\Kappa$ `\Kappa` | $\Lambda$ `\Lambda` | $\Mu$ `\Mu`
| $\Nu$ `\Nu` | $\Xi$ `\Xi` | $\Omicron$ `\Omicron` | $\Pi$ `\Pi`
| $\Rho$ `\Rho` | $\Sigma$ `\Sigma` | $\Tau$ `\Tau` | $\Upsilon$ `\Upsilon`
| $\Phi$ `\Phi` | $\Chi$ `\Chi` | $\Psi$ `\Psi` | $\Omega$ `\Omega`
| $\varGamma$ `\varGamma`| $\varDelta$ `\varDelta` | $\varTheta$ `\varTheta` | $\varLambda$ `\varLambda`  |
| $\varXi$ `\varXi`| $\varPi$ `\varPi` | $\varSigma$ `\varSigma` | $\varUpsilon$ `\varUpsilon` |
| $\varPhi$ `\varPhi`  | $\varPsi$ `\varPsi`| $\varOmega$ `\varOmega` ||
| $\alpha$ `\alpha`| $\beta$ `\beta`  | $\gamma$ `\gamma` | $\delta$ `\delta`|
| $\epsilon$ `\epsilon` | $\zeta$ `\zeta`  | $\eta$ `\eta`| $\theta$ `\theta`|
| $\iota$ `\iota` | $\kappa$ `\kappa` | $\lambda$ `\lambda`| $\mu$ `\mu`|
| $\nu$ `\nu`| $\xi$ `\xi` | $\omicron$ `\omicron`  | $\pi$ `\pi`|
| $\rho$ `\rho`  | $\sigma$ `\sigma` | $\tau$ `\tau`| $\upsilon$ `\upsilon` |
| $\phi$ `\phi`  | $\chi$ `\chi`| $\psi$ `\psi`| $\omega$ `\omega`|
| $\varepsilon$ `\varepsilon` | $\varkappa$ `\varkappa` | $\vartheta$ `\vartheta` | $\thetasym$ `\thetasym`
| $\varpi$ `\varpi`| $\varrho$ `\varrho`  | $\varsigma$ `\varsigma` | $\varphi$ `\varphi`
| $\digamma $ `\digamma`
