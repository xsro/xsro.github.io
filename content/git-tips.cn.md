+++
title = "Git常用拓展知识"
date = 2021-07-25
[taxonomies]
categories = ["常用技术速查"]
tags = ["git"]
+++

# Some Tips for git

## links

- git commit 提交规范
  - [Conventional Commits 约定式提交](https://www.conventionalcommits.org/)
  - [gitmoji 使用表情来规范 commit 消息](https://gitmoji.dev/): [one fork](https://gitmoji.js.org/)
- [LGTM : code review 行话](https://www.jianshu.com/p/238a1e1f4037)

## Tip1 = Commit 规范中常用 commit 类型解释

- `feat`: 新功能、新特性
- `fix`: 修改 bug
- `perf`: 更改代码，以提高性能（在不影响代码内部行为的前提下，对程序性能进行优化）
- `refactor`: 代码重构（重构，在不影响代码内部行为、功能下的代码修改）
- `docs`: 文档修改
- `style`: 代码格式修改, 注意不是 css 修改（例如分号修改）
- `test`: 测试用例新增、修改
- `build`: 影响项目构建或依赖项修改
- `revert`: 恢复上一次提交
- `ci`: 持续集成相关文件修改
- `chore`: 其他修改（不在上述类型中的修改）
- `release`: 发布新版本
- `workflow`: 工作流相关文件修改
- `typo`：拼写错误等小错误

## Tip2：code Review 行话

- `PR`: Pull Request. 拉取请求，给其他项目提交代码
- `LGTM`: Looks Good To Me. 朕知道了 代码已经过 review，可以合并
- `SGTM`: Sounds Good To Me. 和上面那句意思差不多，也是已经通过了 review 的意思
- `WIP`: Work In Progress. 传说中提 PR 的最佳实践是，如果你有个改动很大的 PR，可以在写了一部分的情况下先提交，但是在标题里写- `上 WIP，以告诉项目维护者这个功能还未完成，方便维护者提前 review 部分提交的代码。
- `PTAL`: Please Take A Look. 你来瞅瞅？用来提示别人来看一下
- `TBR`: To Be Reviewed. 提示维护者进行 review
- `TL`;DR = Too Long; Didn’t Read. 太长懒得看。也有很多文档在做简略描述之前会写这么一句
- `TBD`: To Be Done(or Defined/Discussed/Decided/Determined).根据语境不同意义有所区别，但一般都是还没搞定的意思

## Tips3 = 一些个人感悟

1. 变量名直观一点，不要害怕太长
   1. 人类创造编程语言，就是为了方便人类编写与理解，大部分语言编译器都会做相关的优化的
   2. git 仓库也真的不在乎多那么几个字节，github 大小也没有限制，浅克隆问题也不大
2. 主分支不用，其他分支少用`git push -f`，提交历史没有必要太好看
   1. 同上 2，多几个 commit 没什么大不了的
3. 个人项目单分支模型就可以了，用太多分支往往徒增烦恼（这条不绝对，要看具体情况）
