# Learn Skill Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build the `learn` skill — a self-contained superset of `teach` with 6串联学习加速工具.

**Architecture:** Single directory `skills/productivity/learn/` containing `SKILL.md` (main skill) + 3 format template files (MISSION-FORMAT.md, RESOURCES-FORMAT.md, LEARNING-RECORD-FORMAT.md) adapted from `teach`. No external references — teach workspace logic and frontend-design standards are inlined into SKILL.md.

**Tech Stack:** Markdown with YAML frontmatter, no code dependencies.

**Design Spec:** `docs/superpowers/specs/2026-07-06-learn-skill-design.md`

---

## File Structure

```
skills/productivity/learn/
├── SKILL.md                     # Main skill file (~400-500 lines)
├── MISSION-FORMAT.md            # Adapted from teach
├── RESOURCES-FORMAT.md          # Adapted from teach
└── LEARNING-RECORD-FORMAT.md    # Adapted from teach
```

Files to modify:
- `.claude-plugin/plugin.json` — add learn entry
- `skills/productivity/README.md` — add learn entry
- `README.md` (top-level) — add learn entry
- `docs/productivity/learn.md` — create docs page (per `.agents/writing-docs.md`)

---

### Task 1: Create directory and copy format files

**Files:**
- Create: `skills/productivity/learn/MISSION-FORMAT.md`
- Create: `skills/productivity/learn/RESOURCES-FORMAT.md`
- Create: `skills/productivity/learn/LEARNING-RECORD-FORMAT.md`

- [ ] **Step 1: Create the learn directory**

```bash
mkdir -p skills/productivity/learn
```

- [ ] **Step 2: Copy MISSION-FORMAT.md from teach and adapt**

Copy `skills/productivity/teach/MISSION-FORMAT.md` to `skills/productivity/learn/MISSION-FORMAT.md`, then add a "Learning Ladder" section:

```markdown
## Learning Ladder

When the learning ladder tool is used, append a ladder table to MISSION.md:

```md
## Learning Ladder

| Level | What to Master | Common Mistakes | Gate to Next Level |
|-------|---------------|-----------------|-------------------|
| L1: ... | ... | ... | ... |
| L2: ... | ... | ... | ... |
| L3: ... | ... | ... | ... |
| L4: ... | ... | ... | ... |
| L5: ... | ... | ... | ... |

**Current level:** L{x}
**Target level:** L{y}
```
```

The adapted file should have the full content from teach's MISSION-FORMAT.md plus the Learning Ladder section appended to the end.

- [ ] **Step 3: Copy RESOURCES-FORMAT.md from teach unchanged**

```bash
cp skills/productivity/teach/RESOURCES-FORMAT.md skills/productivity/learn/RESOURCES-FORMAT.md
```

- [ ] **Step 4: Copy LEARNING-RECORD-FORMAT.md from teach and adapt**

Copy `skills/productivity/teach/LEARNING-RECORD-FORMAT.md` to `skills/productivity/learn/LEARNING-RECORD-FORMAT.md`, then add new record types:

In the "When to write a learning record" section, add two additional triggers after the existing four:

```markdown
5. **A Feynman test was completed** — the user explained a concept to the AI, and gaps were identified. Record the concept, what was solid, and what needed re-explanation. Title: `feynman-<概念>.md`.

6. **An exam checkpoint was passed (or failed)** — the AI examiner completed a test run. Record the score, which areas were strong, and which areas need re-study. Title: `exam-<阶段>.md`. If the user did not pass (average < threshold), also list the specific lesson paths and sections to revisit.
```

- [ ] **Step 5: Commit**

```bash
git add skills/productivity/learn/
git commit -m "feat(learn): create learn skill directory and format files"
```

---

### Task 2: Write SKILL.md — Frontmatter, Overview, and Workspace

**Files:**
- Create: `skills/productivity/learn/SKILL.md`

- [ ] **Step 1: Write the frontmatter and overview section**

Write the following to `skills/productivity/learn/SKILL.md`:

```markdown
---
name: learn
description: 用 Claude Code 以 10 倍速度学习任何技能或概念。6 个串联工具——学习阶梯、信号筛选、20 小时学习法、费曼检验、AI 考官、一页速查表——帮你从零到精通。
argument-hint: "你想学什么？"
disable-model-invocation: true
---

# Learn — 10x 学习加速器

用 6 个串联工具，在当前工作空间中以 10 倍速度学习任何主题。Learn 是一个自包含的教学工作空间——完整包含课程生成、参考资料、学习记录管理能力。

## 工作空间

当前目录即教学空间，包含以下文件：

- `MISSION.md` — 学习目标 + 学习阶梯表。格式见 [MISSION-FORMAT.md](./MISSION-FORMAT.md)。
- `RESOURCES.md` — 筛选后的高价值资源。格式见 [RESOURCES-FORMAT.md](./RESOURCES-FORMAT.md)。
- `NOTES.md` — 用户偏好、学习计划、临时笔记。
- `./lessons/*.html` — 课程文件，命名 `0001-<名称>.html`，编号递增。
- `./reference/*.html` — 参考资料（语法速查、算法流程图、术语表、一页速查表）。
- `./learning-records/*.md` — 学习记录（类似 ADR），命名为 `0001-<名称>.md`。格式见 [LEARNING-RECORD-FORMAT.md](./LEARNING-RECORD-FORMAT.md)。
- `./assets/*` — 跨课程复用的组件（样式表、测验组件、图表工具）。
```

- [ ] **Step 2: Write the philosophy section**

Append to SKILL.md:

```markdown
## 学习哲学

### 知识 vs 技能 vs 智慧

- **知识**：来自高质量、高信任度的资源。难度是敌人——它消耗理解所需的认知资源。知识获取要尽量降低难度。
- **技能**：通过互动式课程习得。难度是工具——有意识地费力回忆才能建立长期记忆。技能练习要刻意制造难度。
- **智慧**：来自真实世界的交互——在社区中测试所学。当用户的问题需要智慧时，优先回答，但最终引导到社区。

对理论型主题，知识比重更大；对实操型主题，技能比重更大。

### 流畅度 vs 存储强度

- **流畅度**：当下的提取能力。给用户"我懂了"的错觉，但容易消退。
- **存储强度**：长期保留能力。这才是真正的目标。

通过以下方式建立存储强度：
- **提取练习**：从记忆中主动回忆（而非重读）
- **间隔**：分散练习时间
- **交错**：混合不同但相关的主题练习（仅限技能练习）

### 最近发展区（ZPD）

每节课应让用户感到"刚好被挑战"。定位 ZPD 的方法：
- 阅读 `learning-records/` 了解用户已掌握什么
- 根据 MISSION 判断下一步该教什么
- 教最相关、刚好超出当前水平的内容
```

- [ ] **Step 3: Write the Mission section**

Append to SKILL.md:

```markdown
## 使命（Mission）

每节课必须绑定使命——用户为什么要学这个。使命是一切教学决策的依据。

如果 `MISSION.md` 为空或用户目标模糊，在开始任何教学前先采访用户：
- "你学这个是为了什么？学了之后能在生活中/工作中做什么现在做不了的事？"
- 拒绝抽象的答案（"想理解 XX"），追问到具体结果（"想用 XX 做什么"）

使命可能随着学习深入而改变。确认后更新 `MISSION.md` 并写入一条 learning record。

确认使命后，立即进入学习阶梯工具。
```

- [ ] **Step 4: Commit**

```bash
git add skills/productivity/learn/SKILL.md
git commit -m "feat(learn): add SKILL.md frontmatter, overview, workspace, and philosophy"
```

---

### Task 3: Write SKILL.md — Tool 1: 学习阶梯（一问一答版）

**Files:**
- Modify: `skills/productivity/learn/SKILL.md`

**Design requirement:** Strict one-question-at-a-time interview mode. Each step is a single question, wait for user response before continuing. Number of levels determined by Claude based on topic size (not fixed at 5, must cover >= core 20% knowledge). For branch A, show ONE level at a time, pause after each level asking "这层有没有想深入了解的？".

- [ ] **Step 1: Append the learning ladder tool section**

```markdown
## 工具 1：学习阶梯

**目的**：在开始学之前画出领域全景地图，确认用户当前位置和目标等级。

**何时运行**：MISSION 确认后。

**核心交互规则：一问一答采访模式。每次只问一个问题，等用户回答后再继续下一个问题。禁止一次性输出多个问题或所有级别阶梯。级数由 Claude 根据主题大小决定，不固定，但不能少于覆盖核心 20% 知识所需的级数。**

### 路由问题

只问这一句，等用户选择 A/B/C 后，进入对应支线：

> "关于 [主题]，你是：A. 完全新手，连名词都不熟 / B. 看过一些，但没正经做过 / C. 做过东西，想系统提升"

### 支线 A（新手）— 先看全景，再定位

**第 1 问** — 只问这一句：
> "你说的 [主题]，具体到什么范围？比如你想学到什么深度、覆盖哪些方面？"

等用户回答。

**第 2 步** — 逐级展示阶梯。这是最关键的一步：

Claude 根据主题大小和目标跨度自行决定级数（不固定为 5 级，但不能少于覆盖核心 20% 知识所需的级数）。每级格式：该级名称 + 掌握什么（3-5 条）+ 常见错误（2-3 条）+ 达标标准。

展示完一级后，停下来问：
> "L{x} 这层有没有想深入了解的点？"

等用户回答。如果有，展开解释；如果没有，继续展示下一级。重复直到全部展示完。

**第 3 问** — 只问这一句：
> "看了这张完整地图，你现在在哪一级？"

等用户回答。

**第 4 问** — 只问这一句：
> "你想冲到哪一级？"

等用户回答。

**第 5 问** — 只问这一句：
> "所以你的路径是从 L{x} 爬到 L{y}。中间最大的挑战可能是 [某级]。确认吗？"

等用户确认。

### 支线 B（有基础）— 先定位，再定制

**第 1 问** — 只问这一句：
> "关于 [主题]，你之前做过什么？具体描述一下——写过什么、踩过什么坑、看过什么资料？"

等用户回答。基于回答判断当前位置。

**第 2 问** — 只问这一句：
> "根据你的描述，我判断你目前在 L{x}：[简述该级特征]。你觉得准确吗？"

等用户确认或调整。

**第 3 问** — 只问这一句：
> "你想学到什么程度？"

等用户回答。

**第 4 步** — 定制展示阶梯。只展示从当前等级到目标等级的范围。逐级展示，一次一级，每级讲完停顿问"这层有没有想深入了解的？"。

**第 5 问** — 只问这一句：
> "回头看你这张定制地图——起点 L{x}，终点 L{y}。中间最大的挑战可能是 [某级]。确认吗？"

等用户确认。

### 支线 C（项目驱动）— 以终为始

**第 1 问** — 只问这一句：
> "学完之后你最想用它干什么？描述一个具体场景。"

等用户回答。

**第 2 问** — 只问这一句：
> "要做到你说的这个场景，大概需要到 L{x}：[简述该级能力]。你觉得够吗？还是想再往上？"

等用户回答。

**第 3 问** — 只问这一句：
> "要做到这个目标，你评估一下自己现在在哪个水平？缺什么？"

等用户回答。基于回答判断当前位置。

**第 4 步** — 定制展示阶梯。只展示从当前等级到目标等级的范围。逐级展示，一次一级，每级讲完停顿问"这层有没有想深入了解的？"。

**第 5 问** — 只问这一句：
> "所以你的路径是从 L{x} 到 L{y}，一共跨 [N] 级。确认吗？"

等用户确认。

### 四条必问（每条支线都必须覆盖）

无论走哪条支线，以下四个问题必须被问到（已嵌入上述各支线步骤中）：
- 当前在哪个层次？
- 每一层应该掌握什么？
- 常见错误是什么？
- 达到什么标准才能进入下一层？

**产出**：阶梯表写入 `MISSION.md` 第二段，作为后续所有工具的目标锚点。格式见 [MISSION-FORMAT.md](./MISSION-FORMAT.md) 中的 Learning Ladder 部分。
```

- [ ] **Step 2: Commit**

```bash
git add skills/productivity/learn/SKILL.md
git commit -m "feat(learn): add Tool 1 - Learning Ladder (one-question-at-a-time mode)"
```

---

### Task 4: Write SKILL.md — Tool 2: 信号筛选（一问一答版）

**Files:**
- Modify: `skills/productivity/learn/SKILL.md`

**Design requirement:** One-question-at-a-time. Ask learning preference → wait → ask language preference → wait → list resources → wait for confirmation → list learning path → wait for confirmation.

- [ ] **Step 1: Append the signal filter tool section**

```markdown
## 工具 2：信号筛选

**目的**：从海量材料中只保留最值得看的，节省时间。

**何时运行**：学习阶梯完成后。

**核心交互规则：一问一答采访模式。每次只问一个问题，等用户回答后再继续。**

### 第 1 问 — 只问这一句：
> "你更喜欢哪种学习方式？视频 / 文档 / 动手做项目 / 书 / 都可以"

等用户回答。

### 第 2 问 — 只问这一句：
> "能接受英文材料吗？还是只要中文？"

等用户回答。

### 第 3 步 — 筛选资源

基于用户偏好和阶梯范围，Claude 自行决定筛出 N 个资源（N 非固定）。一次性列出所有资源，每个资源说明：
- 是什么：名称 + 一句话
- 适合谁：新手 / 有基础 / 进阶
- 难度：轻松 / 适中 / 硬核
- 怎么用：通读还是查漏补缺？一口气还是拆几天？
- **别看哪里**：哪些章节/部分是浪费时间，直接跳

列出后问：
> "这 N 个资源你觉得合适吗？有没有想替换或增减的？"

等用户确认或调整。

### 第 4 步 — 学习路径

基于上述资源 + 目标等级，设计一个 M 天学习路径（M 非固定）。一次性列出，每天：看什么 + 练什么 + 产出什么。

列出后问：
> "这个 M 天路径你觉得合理吗？有没有想调整的？"

等用户确认或调整。

**产出**：N 个资源写入 `RESOURCES.md`（每个标注用途和别看哪里），M 天路径写入 `MISSION.md`。
```

- [ ] **Step 2: Commit**

```bash
git add skills/productivity/learn/SKILL.md
git commit -m "feat(learn): add Tool 2 - Signal Filter (one-question-at-a-time mode)"
```

---

### Task 5: Write SKILL.md — Tool 3: 20 小时学习法（一问一答版）

**Files:**
- Modify: `skills/productivity/learn/SKILL.md`

**Design requirement:** One decision point at a time. For each session's 4 elements, handle one element at a time (not all 4 at once). Each element: Claude gives 2-3 options → suggests one → waits for user confirmation. One session fully confirmed before moving to next session.

- [ ] **Step 1: Append the 20-hour method tool section**

```markdown
## 工具 3：20 小时学习法（80/20 法则）

**目的**：提炼核心 20% 内容，排成精确到每次的实战计划。

**何时运行**：信号筛选完成后。

注："20 小时"是 Josh Kaufman 快速学习理论的参考概念，实际总时长由 Claude 建议、用户确认，非固定值。

**核心交互规则：一问一答采访模式。每个决策点遵循：Claude 给 2-3 个选项 → 建议一个 → 等用户确认或调整。每次只处理一个决策点。**

### 第 1 步 — 时间投入

Claude 根据主题大小和阶梯跨度，列出 2-3 个可选总时长，建议一个。然后只问这一句：
> "我建议 [X 小时]，因为 [理由]。你觉得呢？"

等用户确认或调整。

### 第 2 步 — 80/20 提炼

从阶梯覆盖的全部内容中，提炼最核心的 20%，解释为什么这 20% 能带来 80% 的效果。然后问：
> "这 20% 的提炼你觉得合理吗？有没有要增减的？"

等用户确认或调整。

### 第 3 步 — 拆计划

分成 X 次学习 session，每次 Y 小时（X、Y 非固定）。每次对应一节 lesson。

**对每一次 session，逐个处理其 4 个要素（不要一次处理多个 session）：**

逐个 session 循环，每个 session 依次问 4 个要素，每个要素一问：

**3a. 学什么** — 给出 2-3 种方案，建议一种 → 等确认
**3b. 练习什么** — 给出 2-3 种方案，建议一种 → 等确认
**3c. 用哪些资源** — 给出 2-3 种搭配，建议一种 → 等确认
**3d. 复盘什么** — 给出 N 个问题，2-3 组，建议一组 → 等确认

一个 session 确认完毕后，再进入下一个。禁止一次性列出所有 session。

### 第 4 步 — 整体确认

所有 session 确认完毕后，展示汇总表。只问这一句：
> "全部 X 次计划都看一遍，有想调整的吗？"

等用户确认。

**产出**：每次计划详情写入 `NOTES.md`。后续费曼检验和 AI 考官以这些 session 为时间节点。
```

- [ ] **Step 2: Commit**

```bash
git add skills/productivity/learn/SKILL.md
git commit -m "feat(learn): add Tool 3 - 20-Hour Method (one-decision-at-a-time mode)"
```

---

### Task 6: Write SKILL.md — Tool 4: 费曼检验（一问一答版）

**Files:**
- Modify: `skills/productivity/learn/SKILL.md`

**Design requirement:** One action at a time. Claude assigns concept → waits for user explanation → diagnoses → re-explains only gaps → waits for user re-explanation → iterates.

- [ ] **Step 1: Append the Feynman test tool section**

```markdown
## 工具 4：费曼检验

**目的**：逼用户用自己的话讲清概念，暴露"以为懂了"的幻觉。

**何时运行**：每节 lesson 学完后。

**核心交互规则：一问一答。每次 Claude 只做一件事，等用户回答后再继续。**

### 第 1 步 — 指定话题

只问这一句：
> "上一节你学了 [具体概念]。用你自己的话讲给我听——假设我是一个 12 岁小孩，完全不懂这个领域。"

等用户讲完。

### 第 2 步 — 诊断报告

用户讲完后，Claude 给出诊断（四个维度）：
- **讲对了什么**
- **漏了什么**
- **混淆了什么**
- **用了但没懂的词**

### 第 3 步 — 只补漏洞

Claude 只重新解释漏掉/混淆/没真懂的部分。不重复已掌握内容。

解释完后，只问这一句：
> "现在你再讲一遍，还是用你自己的话。"

### 第 4 步 — 迭代

重复第 2-3 步，直到用户完全讲清。最多 N 轮（N 由 Claude 判断）。

**产出**：诊断内容写入 `learning-records/<编号>-feynman-<概念>.md`。
```

- [ ] **Step 2: Commit**

```bash
git add skills/productivity/learn/SKILL.md
git commit -m "feat(learn): add Tool 4 - Feynman Test (one-action-at-a-time mode)"
```

---

### Task 7: Write SKILL.md — Tool 5: AI 考官（一问一答版）

**Files:**
- Modify: `skills/productivity/learn/SKILL.md`

**Design requirement:** One question at a time during exam. Ask timing route → wait. Then one exam question at a time: ask → wait for answer → give feedback → next question. Never output multiple questions at once.

- [ ] **Step 1: Append the AI examiner tool section**

```markdown
## 工具 5：AI 考官

**目的**：渐进式压力测试，从简单到困难，定位知识盲区。

**何时运行**：一个阶段的学习结束后。

**核心交互规则：一问一答。一次只出一道题，等用户答完并收到反馈后，再出下一题。禁止一次性出多道题。**

### 时机选择（路由）

Claude 先分析 session 间的知识边界，然后只问这一句：

> "我建议在 session X、Y、Z 后面各安排一次考试，因为这三个节点分别对应 [基础/进阶/实战] 的收口。你也可以选择：A. 每个阶段后都考 / B. 整个计划学完只考一次 / C. 我建议的节点。你选哪个？"

等用户选择。

### 出题规则

- 必须覆盖 20% 最核心知识（来自 20 小时学习法提炼的内容）
- 混合主观题 + 客观题，题数 N 由 Claude 根据阶段内容量决定
- 难度渐进：知识记忆 → 理解原理 → 场景应用 → 批判发散

### 考试流程

一次只出一道题。出题后等用户回答。用户答完后给出反馈，再出下一题。

每道题回答后，Claude 给出：
- 得分（X/10）
- 对了什么
- 错了什么
- 漏了什么
- 只解释没掌握的部分
- 然后出下一题

### 判定

N 题全部答完后，计算总平均分。< M 分（M 默认 6，Claude 可根据阶段难度建议调整，用户确认）→ 不通过。

### 综合评估

N 题全部结束后，给出综合评估：
- **扎实的部分**：简明列出
- **需要补的部分**：必须给出具体 lesson HTML 路径 + 对应章节/段落引用，让用户能点进去精准复习

**产出**：考试成绩 + 评估写入 `learning-records/<编号>-exam-<阶段>.md`。
```

- [ ] **Step 2: Commit**

```bash
git add skills/productivity/learn/SKILL.md
git commit -m "feat(learn): add Tool 5 - AI Examiner (one-question-at-a-time mode)"
```

---

### Task 8: Write SKILL.md — Tool 6: 一页速查表

**Files:**
- Modify: `skills/productivity/learn/SKILL.md`

- [ ] **Step 1: Append the cheatsheet tool section**

```markdown
## 工具 6：一页速查表

**目的**：把整个主题的知识压缩到一页可打印 HTML，按使用场景定制。

**何时运行**：整个学习周期结束时（全部 lesson 学完、费曼检验和 AI 考官通过后）。

**流程**：

1. **路由（使用场景）**：
   - A. 面试突击 — 常见面试题、一句话回答、易被追问的坑
   - B. 考前复习 — 公式/语法速查、题型模板、易混概念对比
   - C. 演讲/分享 — 叙事逻辑线、关键数据/案例、金句
   - D. 日常查阅 — API/命令速查、代码片段、检查清单
   - E. 教别人 — 类比解释、概念关系图、循序理解路径
   - F. 项目实战 — 最佳实践、常见错误、项目模板

2. Claude 基于前 5 个工具的积累 + 用户选择的使用场景，直接生成第一版 HTML。内容结构根据场景动态调整，非固定模板。

3. 用户反馈，调整定稿。

**产出**：`reference/<主题>-cheatsheet.html`，美观可打印。
```

- [ ] **Step 2: Commit**

```bash
git add skills/productivity/learn/SKILL.md
git commit -m "feat(learn): add Tool 6 - Cheatsheet"
```

---

### Task 9: Write SKILL.md — Lessons, Reference, and Design Standards

**Files:**
- Modify: `skills/productivity/learn/SKILL.md`

- [ ] **Step 1: Append the lessons section**

```markdown
## 课程（Lessons）

课程是主要产出——知识和技能触达用户的单元。每节课是一个自包含的 HTML 文件，保存在 `./lessons/`，命名 `0001-<名称>.html`，编号递增。

### 课程结构

每节课应：
- **简短**：学习者的工作记忆很小，必须在其容量内完成。但每节课应给用户一个具体的、可感知的收获。
- **绑定使命**：直接关联 MISSION.md 中的目标。
- **处于 ZPD**：刚好超出用户的当前水平。
- **知识先行**：先教必要的知识（来自 RESOURCES.md 中的高信任资源），再引导用户通过互动反馈循环练习技能。
- **引用外部来源**：课程中应布满引文——外部链接支撑任何断言，增加可信度。

### 推荐主源

每节课应推荐一个主源供用户阅读或观看——这是你找到的关于该主题最优质、最高信任度的资源。

### 追问提醒

每节课应包含一条提醒：用户可以随时向 AI 追问。AI 是他们的老师，可以协助任何不清楚的地方。

### 课程间链接

通过 HTML 锚点链接到其他课程和参考文档。
```

- [ ] **Step 2: Append the reference documents section**

```markdown
## 参考资料（Reference）

创建课程的同时，也应创建参考资料。课程可以引用这些文档——它们用于追踪跨课程有用的原始知识单元。课程很少会被重访，参考资料会。

适合做成参考的内容：
- 编程的语法和代码片段
- 流程的算法和流程图
- 瑜伽的体式和序列
- 健身的练习和计划
- 任何有专用术语的领域的术语表

术语表尤其重要——一旦创建，每节课都应遵守。

### 一页速查表

速查表是 reference 目录下的一种特化格式（见工具 6）。它把整个主题压缩到一页可打印 HTML。
```

- [ ] **Step 3: Append the assets section**

```markdown
## 组件（Assets）

课程由可复用组件构建，存储在 `./assets/` 中：样式表、测验组件、模拟器、图表工具——任何第二节课可能复用的东西。

复用是默认，不是例外。在编写课程前，先读 `./assets/` 的内容，用已有组件构建。需要新的可复用内容时，写入 `./assets/` 并链接——永远不要在课程内内联未来会重复的代码。

共享样式表是每个工作空间首先获得的组件：每节课都链接它，让课程看起来像一个连贯的课程体系，而非一堆一次性产物。随着工作空间增长，组件库也应增长。
```

- [ ] **Step 4: Append the frontend design standards (minimal)**

```markdown
## 视觉设计标准

课程 HTML 和速查表应遵循以下标准，确保美观、独特、可打印。

### 配色

定义 4-6 个命名 hex 值构成调色板。避免三种 AI 模板配色：
1. 奶油暖色背景（#F4F1EA）+ 高对比衬线标题 + 陶土色强调
2. 近黑背景 + 亮酸绿或朱红单色强调
3. 报纸栏式布局 + 发丝分隔线 + 零圆角

### 字体

至少 2 个角色：有个性的展示字体（克制使用）+ 互补的正文字体。需要时加一个辅助字体用于标注或数据。

### 布局

一句话描述布局概念。一个记忆点（signature element）——本页最让人记住的那个元素。其余保持简洁克制。

### 质量底线

响应式到移动端、可见键盘焦点、尊重 `prefers-reduced-motion`。
```

- [ ] **Step 5: Append the learning records and glossary sections**

```markdown
## 学习记录（Learning Records）

见 [LEARNING-RECORD-FORMAT.md](./LEARNING-RECORD-FORMAT.md)。关键规则：
- 编号递增（扫描 `learning-records/` 找最大编号 +1）
- 覆盖不等于学会——等证据出现再写
- 被推翻的记录标记 `Status: superseded by LR-NNNN`，不要删除

## 术语表（Glossary）

术语表是一种特殊的 reference 文档。一旦创建，在所有课程中保持一致使用。不确定用户是否理解某个术语时，先定义再使用。

## NOTES.md

用户有时会表达教学偏好或其他应记住的事项。记录在 `NOTES.md` 中，供设计课程或与用户互动时参考。
```

- [ ] **Step 6: Commit**

```bash
git add skills/productivity/learn/SKILL.md
git commit -m "feat(learn): add lessons, reference, design standards sections"
```

---

### Task 10: Update plugin.json, README files, and create docs page

**Files:**
- Modify: `.claude-plugin/plugin.json`
- Modify: `skills/productivity/README.md`
- Modify: `README.md`
- Create: `docs/productivity/learn.md`

- [ ] **Step 1: Update plugin.json**

Add `"./skills/productivity/learn"` to the skills array in `.claude-plugin/plugin.json`, after the teach entry:

```json
"./skills/productivity/teach",
"./skills/productivity/learn",
```

- [ ] **Step 2: Update skills/productivity/README.md**

Add learn entry to the User-invoked section, after teach:

```markdown
- **[learn](./learn/SKILL.md)** — 以 10 倍速度学习任何技能或概念——6 个串联工具从规划到检验到沉淀。
```

- [ ] **Step 3: Update top-level README.md**

Add learn entry in the User-invoked section of productivity skills, after teach:

```markdown
- **[learn](./skills/productivity/learn/SKILL.md)** — Learn any skill or concept 10x faster with 6串联工具: learning ladder, signal filter, 20-hour method, Feynman test, AI examiner, cheatsheet.
```

- [ ] **Step 4: Create docs page**

Create `docs/productivity/learn.md` following `.agents/writing-docs.md` template. Content should mirror the design spec's overview and 6-tool descriptions, written for human readers.

- [ ] **Step 5: Run link-skills.sh**

```bash
bash scripts/link-skills.sh
```

- [ ] **Step 6: Run changeset**

```bash
npx changeset
```
Select minor bump. Message: "feat: add learn skill — 10x learning accelerator with 6串联工具"

- [ ] **Step 7: Verify changes**

```bash
bash scripts/list-skills.sh
```
Expected: learn skill appears in the list.

- [ ] **Step 8: Commit**

```bash
git add .claude-plugin/plugin.json skills/productivity/README.md README.md docs/productivity/learn.md
git commit -m "feat(learn): register learn skill in plugin manifest and README"
```

---

### Task 11: TDD Testing — RED Phase (Baseline)

Per `writing-skills` skill, run pressure scenarios WITHOUT the skill to document baseline behavior.

**Files:**
- Create: `docs/superpowers/specs/2026-07-06-learn-skill-test-results.md`

- [ ] **Step 1: Design pressure scenarios**

Create 3 pressure scenarios that test whether Claude can perform the 6-tool workflow without the learn skill loaded:

1. **Simple learning request**: "我想学 React hooks，帮我设计一个学习计划"
2. **80/20 extraction**: "我刚决定学 Rust，只有 15 小时，帮我只学最重要的部分"
3. **End-to-end learning flow**: "我想从零学 Docker，目标是能写 Dockerfile 和 docker-compose"

- [ ] **Step 2: Run baseline scenarios**

For each scenario, spawn a subagent WITHOUT the learn skill. Document:
- What choices did they make?
- Did they give a learning ladder? Signal filter? Exam?
- What rationalizations did they use?
- Which of the 6 tools were missing?

- [ ] **Step 3: Document baseline failures**

Write findings to `docs/superpowers/specs/2026-07-06-learn-skill-test-results.md`. Expected: agent won't naturally produce learning ladders, won't apply 80/20 to content selection, won't do Feynman-style comprehension checks, won't act as a progressive examiner.

- [ ] **Step 4: Commit**

```bash
git add docs/superpowers/specs/2026-07-06-learn-skill-test-results.md
git commit -m "test(learn): document RED phase baseline behavior"
```

---

### Task 12: TDD Testing — GREEN Phase (Verify with skill)

- [ ] **Step 1: Run same scenarios WITH the learn skill**

Spawn subagents with the learn skill loaded. Verify they now:
- Ask the route question before the learning ladder
- Produce a 5-level ladder with all four required questions
- Filter resources with annotations (what to skip)
- Apply 80/20 to content extraction
- Offer Feynman-style comprehension checks
- Act as a progressive examiner with scoring
- Produce a scenario-specific cheatsheet

- [ ] **Step 2: Document GREEN results**

Append to test results file. Note any remaining gaps.

- [ ] **Step 3: Commit**

```bash
git add docs/superpowers/specs/2026-07-06-learn-skill-test-results.md
git commit -m "test(learn): document GREEN phase results"
```

---

### Task 13: TDD Testing — REFACTOR Phase (Close loopholes)

- [ ] **Step 1: Identify rationalizations from GREEN phase**

Review test results for any loopholes or rationalizations where the agent partially followed the skill but cut corners.

- [ ] **Step 2: Add explicit counters**

Update SKILL.md to close each loophole found.

- [ ] **Step 3: Re-test until bulletproof**

Run scenarios again. Repeat until clean.

- [ ] **Step 4: Commit**

```bash
git add skills/productivity/learn/SKILL.md docs/superpowers/specs/2026-07-06-learn-skill-test-results.md
git commit -m "fix(learn): close loopholes found in REFACTOR phase"
```

---

### Task 14: Final quality checks

- [ ] **Step 1: Verify all files exist**

```bash
ls -la skills/productivity/learn/
```
Expected: SKILL.md, MISSION-FORMAT.md, RESOURCES-FORMAT.md, LEARNING-RECORD-FORMAT.md

- [ ] **Step 2: Verify plugin.json is valid JSON**

```bash
cat .claude-plugin/plugin.json | python -m json.tool
```

- [ ] **Step 3: Verify links in READMEs point to correct paths**

- [ ] **Step 4: Run npm version**

```bash
npm run version
```

- [ ] **Step 5: Final status check**

```bash
git status
```

- [ ] **Step 6: Commit**

```bash
git add .
git commit -m "chore(learn): final quality checks and version bump"
```
