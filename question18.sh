#!/bin/bash

# 切换到 main 分支并更新
git checkout main
git pull origin main

# 获取远程分支列表
git fetch --all

# 获取所有本地和远程分支（排除 HEAD）
branches=$(git branch -r | grep -v '\->' | sed 's/origin\///')

# === 合并 ready 开头的分支 ===
for branch in $branches; do
  if [[ $branch == ready* ]]; then
    git checkout main
    git merge origin/$branch -m "Merged $branch into main"
    
    # 如有冲突提示用户解决
    if [[ $? -ne 0 ]]; then
      echo "⚠️ Merge conflict in $branch. Please resolve manually!"
      exit 1
    fi

    # 删除远程和本地该分支（如果存在）
    git push origin --delete $branch
    git branch -D $branch 2>/dev/null || true
  fi
done

# === 更新 update 开头的分支 ===
for branch in $branches; do
  if [[ $branch == update* ]]; then
    git checkout -b $branch origin/$branch
    git merge main -m "Merged latest main into $branch"

    # 如有冲突提示用户解决
    if [[ $? -ne 0 ]]; then
      echo "⚠️ Merge conflict in $branch. Please resolve manually!"
      exit 1
    fi

    git push origin $branch
  fi
done

# 返回 main 分支
git checkout main
