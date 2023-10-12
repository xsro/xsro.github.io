+++
title = "Test markdown"
date = 2017-09-22
category = "Prog"

[extra]
author = "Jane Doe"

[taxonomies]
tags = ["rust", "ssg", "other"]
+++

# Test Markdown and extensions

### KaTeX math formula support

This theme contains math formula support using [KaTeX](https://katex.org/),
which can be enabled by setting `katex_enable = true` in the `extra` section
of `config.toml`:

```toml
[extra]
katex_enable = true
```

After enabling this extension, the `katex` short code can be used in documents:
* `{{ katex(body="\KaTeX") }}`{{ katex(body="\KaTeX") }} to typeset a math formula inlined into a text,
  similar to `$...$` in LaTeX
* `{% katex(block=true) %}\KaTeX{% end %}`{% katex(block=true) %}\KaTeX{% end %} to typeset a block of math formulas,
  similar to `$$...$$` in LaTeX

#### Automatic rendering without short codes

Optionally, `\\( \KaTeX \\)`\\( \KaTeX \\) inline and `\\[ \KaTeX \\]`\\[ \KaTeX \\] / `$$ \KaTeX $$`$$ \KaTeX $$
block-style automatic rendering is also supported, if enabled in the config:

```toml
[extra]
katex_enable = true
katex_auto_render = true
```