+++
title = "Markdown 常用拓展语法参考"
date = 2021-07-25
[taxonomies]
tags = ["markdown"]
categories = ["常用技术速查"]
+++

# Markdown 常用拓展语法参考

## 常用链接

- 基本语法
  1. GitHub Flavored Markdown Spec  [gfm](https://github.github.com/gfm/)
  2. 比较细致的 markdown 参考资料 [www.markdownguide.org](https://www.markdownguide.org/)
  3. github 上的 markdown 语法速查 [markdown-cheatsheet](https://github.com/tchapi/markdown-cheatsheet),[Markdown](https://github.com/younghz/Markdown)
  4. [typora](http://typora.io/)中提供的[帮助](https://support.typora.io/Markdown-Reference/)
- 数学公式$\TeX$：通常 markdown 使用以下两种工具渲染公示
  1. [mathjax](http://docs.mathjax.org/en/latest/input/tex/macros/index.html)：typora、知乎等
  2. [katex](https://katex.org/docs/supported.html)：hugo 等
- emoji 参考:v:
  1. [emoji 表](emoji.md)来自[caiyongji/emoji-list](https://github.com/caiyongji/emoji-list)
  2. [emoji-cheat-sheet](http://emoji-cheat-sheet.com/)
- Mermaid 图表:一般都是使用的 mermaid.js 来渲染的，注意版本
  1. mermaid.js 官方文档：[mermaid](https://mermaid-js.github.io/mermaid/#)
  2. typora 的相关帮助文档：[Draw Diagrams With Markdown (typora.io)](https://support.typora.io/Draw-Diagrams-With-Markdown/)
- Badge 徽章：![star](https://img.shields.io/github/stars/xsro?style=flat-square)
  1. <https://shields.io/>
  2. <https://forthebadge.com/>
  3. 在 gitee 中使用徽标：在 git 仓库主页一次点击`管理`、`仓库挂件`即可看到

## 常用 html 代码

### 行内 html

| Raw Markdown Source                                                  | Output in Live Preview                                             |
| -------------------------------------------------------------------- | ------------------------------------------------------------------ |
| `<span style='color:red'>This is red</span>`                         | <span style='color:red'>This is red</span>                         |
| `<ruby> 漢 <rt> ㄏㄢˋ </rt> </ruby>`                                 | <ruby> 漢 <rt> ㄏㄢ ˋ </rt> </ruby>                                |
| `<kbd>Ctrl</kbd>+<kbd>F9</kbd>`                                      | <kbd>Ctrl</kbd>+<kbd>F9</kbd>                                      |
| `<span style="font-size:2rem; background:yellow;">**Bigger**</span>` | <span style="font-size:2rem; background:yellow;">**Bigger**</span> |
| `HTML entities like &reg; &#182;`                                    | HTML entities like &reg; &#182;                                    |

### 文本注释、隐藏与折叠

#### 注释内容

```html
<!--这是注释-->
```

#### 隐藏段落

```html
<p hidden>这是需要隐藏的段落 不可以有空行</p>
```

#### 折叠

```html
<details>
  <summary>
    I have keys but no locks. I have space but no room. You can enter but can't
    leave. What am I?
  </summary>
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
<audio src="xxx.mp3"></audio> <video src="xxx.mp4"></video>
```

#### 加载哔哩哔哩视频

```html
<iframe
  src="//player.bilibili.com/player.html?aid=66583807&bvid=BV1n441127jG&cid=116735636&page=1"
  scrolling="no"
  border="0"
  frameborder="no"
  framespacing="0"
  allowfullscreen="true"
>
</iframe>
```

效果：

<iframe src="//player.bilibili.com/player.html?aid=66583807&bvid=BV1n441127jG&cid=116735636&page=1" scrolling="no" border="0" frameborder="no" framespacing="0" allowfullscreen="true"> </iframe>

## 常见符号

|                             |                         |                         |                             |
| --------------------------- | ----------------------- | ----------------------- | --------------------------- |
| $\Alpha$ `\Alpha`           | $\Beta$ `\Beta`         | $\Gamma$ `\Gamma`       | $\Delta$ `\Delta`           |
| $\Epsilon$ `\Epsilon`       | $\Zeta$ `\Zeta`         | $\Eta$ `\Eta`           | $\Theta$ `\Theta`           |
| $\Iota$ `\Iota`             | $\Kappa$ `\Kappa`       | $\Lambda$ `\Lambda`     | $\Mu$ `\Mu`                 |
| $\Nu$ `\Nu`                 | $\Xi$ `\Xi`             | $\Omicron$ `\Omicron`   | $\Pi$ `\Pi`                 |
| $\Rho$ `\Rho`               | $\Sigma$ `\Sigma`       | $\Tau$ `\Tau`           | $\Upsilon$ `\Upsilon`       |
| $\Phi$ `\Phi`               | $\Chi$ `\Chi`           | $\Psi$ `\Psi`           | $\Omega$ `\Omega`           |
| $\varGamma$ `\varGamma`     | $\varDelta$ `\varDelta` | $\varTheta$ `\varTheta` | $\varLambda$ `\varLambda`   |
| $\varXi$ `\varXi`           | $\varPi$ `\varPi`       | $\varSigma$ `\varSigma` | $\varUpsilon$ `\varUpsilon` |
| $\varPhi$ `\varPhi`         | $\varPsi$ `\varPsi`     | $\varOmega$ `\varOmega` |                             |
| $\alpha$ `\alpha`           | $\beta$ `\beta`         | $\gamma$ `\gamma`       | $\delta$ `\delta`           |
| $\epsilon$ `\epsilon`       | $\zeta$ `\zeta`         | $\eta$ `\eta`           | $\theta$ `\theta`           |
| $\iota$ `\iota`             | $\kappa$ `\kappa`       | $\lambda$ `\lambda`     | $\mu$ `\mu`                 |
| $\nu$ `\nu`                 | $\xi$ `\xi`             | $\omicron$ `\omicron`   | $\pi$ `\pi`                 |
| $\rho$ `\rho`               | $\sigma$ `\sigma`       | $\tau$ `\tau`           | $\upsilon$ `\upsilon`       |
| $\phi$ `\phi`               | $\chi$ `\chi`           | $\psi$ `\psi`           | $\omega$ `\omega`           |
| $\varepsilon$ `\varepsilon` | $\varkappa$ `\varkappa` | $\vartheta$ `\vartheta` | $\thetasym$ `\thetasym`     |
| $\varpi$ `\varpi`           | $\varrho$ `\varrho`     | $\varsigma$ `\varsigma` | $\varphi$ `\varphi`         |
| $\digamma $ `\digamma`      |                         |                         |                             |
