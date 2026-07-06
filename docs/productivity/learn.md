Quickstart:

```bash
npx skills add mattpocock/skills --skill=learn
```

```bash
npx skills update learn
```

[Source](https://github.com/mattpocock/skills/tree/main/skills/productivity/learn)

## What it does

Learn 让你以 10 倍速度掌握任何技能或概念。它把六种经过验证的学习工具串联成一个端到端流水线——在当前目录下构建一个自包含的教学工作空间，生成课程 HTML、参考资料、学习记录和一页速查表。

Learn 不是聊天式教学，而是结构化的认知加速器。你可以随时中断、重连、继续——所有进度和状态都持久化在工作空间文件中。

## When to reach for it

- **调用方式**：输入 `/learn <你想学什么>` —— agent 不会自行触发它，需要你主动调用。
- **何时使用**：想快速入门一个新主题、系统提升已入门领域的水平、从零到能做项目级输出。Learn 帮你从"不知道从哪下手"一步拉到"能用+能讲+能查"。如果你需要的是带带节奏、多 session 的陪伴式教学，用 [teach](https://aihero.dev/skills-teach) 替代；你需要的是自己教别人，用 [teach](https://aihero.dev/skills-teach)。

## The six tools

Learn 的核心流水线由六个工具组成，按顺序执行：

1. **学习阶梯** — 画出领域全景 5 级地图，定位你当前在哪、想到哪，路径一目了然。新手支线先看全景再定位，有基础支线先定位再定制，项目驱动支线以终为始。

2. **信号筛选** — 从海量材料中捞取真正值得看的那几份，每一份都告诉你"别看哪里"。同时给出按天编排的学习路径。

3. **20 小时学习法** — 提炼核心 20% 内容（能撬动 80% 效果），拆成精确到每次的学习 session。每次 session 的四个要素（学什么、练什么、用什么资源、复盘什么）都是你从多个选项中选择确认的。

4. **费曼检验** — 每节 lesson 学完后，用自己的话讲给"12 岁小孩"听。AI 诊断你讲对了什么、漏了什么、混淆了什么、用了但没懂的词，只重新解释你没真懂的部分。

5. **AI 考官** — 一个阶段结束后，渐进式压力测试——从记忆到理解到应用再到批判，一次一题，每题实时评分+诊断，最后给出综合评估和精准复习路径。

6. **一页速查表** — 全部学完后，把整个主题压缩到一张可打印的 HTML 页面，按你的使用场景（面试、考试、演讲、日常查阅、教别人、项目实战）定制内容结构。

## The workspace

Learn 在当前目录下构建一个完整的教学工作空间：

- `MISSION.md` — 你的学习目标和阶梯表
- `RESOURCES.md` — 筛选后的高价值资源
- `NOTES.md` — 偏好、计划、临时笔记
- `./lessons/*.html` — 自包含的交互式课程文件
- `./reference/*.html` — 语法速查、术语表、速查表
- `./learning-records/*.md` — 费曼诊断和考试成绩记录
- `./assets/*` — 跨课程复用的样式表、测验组件等

一切可复用组件都抽到 `assets/` 下，课程永远引用共享资产而非内联重复代码。每节课都绑定使命、处于最近发展区、短小但给用户可感知的收获。

## Where it fits

Learn 是一个**独立的启动入口**——随时可以打 `/learn <主题>` 开始，不依赖其他 skill。它与 [teach](https://aihero.dev/skills-teach) 互补：teach 是教（你教别人），learn 是学（你学自己）。如需了解整套 skill 体系的完整地图，参考 [ask-matt](https://aihero.dev/skills-ask-matt)。
