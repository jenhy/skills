#!/usr/bin/env bash
# 同步 fork 的 study 和 main 分支到上游最新
# 用法：在仓库根目录执行 bash sync-fork.sh
# 若 merge 冲突，脚本会停下并提示，需手动解决冲突后继续

set -euo pipefail

# 0. 确保在仓库根目录
cd "$(git rev-parse --show-toplevel)"

# 1. 获取上游最新
git fetch upstream

# 2. 同步 main 分支
# 注意：main 含本地独有提交（如 learn skill），不能用 --ff-only，只能普通 merge
git checkout main
if git merge upstream/main --no-edit; then
    echo "main 已合并上游最新：$(git log -1 --format=%h upstream/main)"
    git push origin main
else
    echo "main 与上游合并冲突。请解决冲突后运行 git merge --continue，再手动 git push origin main"
    exit 1
fi

# 3. 同步 study 分支：合并 main，吸收本地提交和上游更新
git checkout study
if git merge main --no-edit; then
    echo "study 已合并 main 最新：$(git log -1 --format=%h main)"
    git push origin study
else
    echo "study 与 main 合并冲突。请解决冲突后运行 git merge --continue，再手动 git push origin study"
    exit 1
fi

# 4. 切回 main
git checkout main
