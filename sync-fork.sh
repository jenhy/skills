# 同步 fork main 和 study 分支到上游最新
# 用法：在仓库根目录执行 bash sync-fork.sh

set -euo pipefail

# 1. 获取上游最新
git fetch upstream

# 2. 同步 main 分支
git checkout main
git merge upstream/main --ff-only
git push origin main

# 3. 同步 study 分支（基于 main 变基）
git checkout study
git rebase main
git push origin study

# 4. 切回 main
git checkout main