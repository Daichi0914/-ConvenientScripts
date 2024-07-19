#!/bin/bash

# シグナルをキャッチして中断時の処理を行う関数
cleanup() {
    echo "Aborted."
    exit 1
}

# Control + Cが押されたときにcleanup関数を実行するように設定
trap cleanup INT

# オレンジ色のANSIエスケープシーケンスコード
orange=$'\e[38;5;208m'
reset=$'\e[0m'

# 現在のブランチを表示
echo "==============================="
echo CURRENT: $(git branch --show-current)
echo "==============================="

# ブランチの一覧を取得
branches=$(git branch -a --format="%(refname:short)")

echo "$branches"

# ブランチをfzfで選択
selected_branch=$(
    echo "$branches" | awk '/origin\// {print "'"$orange"'" $0 "'"$reset"'"} !/origin\// {print $0}' | \
    fzf --height 20 --layout=reverse --ansi --border --prompt="Select a branch: " --bind "j:down,k:up" --no-multi
) || { cleanup; }

# 選択したブランチ名を表示
echo "==============================="
echo "SELECTED: $selected_branch"
echo "==============================="

# アクション一覧を定義
actions="switch\ndelete\nmerge\ncherry-pick\nrename"
if [[ $selected_branch == origin/* ]]; then
    actions="$actions\ncheckout(local)"
fi


# 選択したブランチに対するGit操作を選択
action=$(
    echo -e "$actions" | \
    fzf --height 20 --layout=reverse --border --prompt="Select an action: " --bind "j:down,k:up" --no-multi
) || { cleanup; }

# 選択したアクション名を表示
echo "==============================="
echo "SELECTED: $action"
echo "==============================="

# 選択したアクションに応じてGit操作を実行
case $action in
    switch)
        git switch "$selected_branch"
        ;;
    merge)
        git merge "$selected_branch"
        ;;
    delete)
        git branch -d "$selected_branch"
        ;;
    cherry-pick)
        # cherry-pickの対象となるコミットを選択
        selected_commits=$(
	    git log --oneline --color=always "$selected_branch" | \
	    fzf --height 30 \
                --layout=reverse \
                --border \
                --multi \
                --ansi \
                --no-sort \
                --bind "j:down,k:up" \
                --prompt="Tabで複数選択"
        ) || { cleanup; }

        # 選択したコミットのハッシュを取得
        selected_hashes=$(echo "$selected_commits" | awk '{print $1}')
        for hash in $selected_hashes; do
            git cherry-pick $hash
        done
        ;;
    rename)
        read -p "New branch name: " new_branch_name
        git branch -m "$selected_branch" "$new_branch_name"
        echo "Renamed: $selected_branch -> $new_branch_name"
        ;;
    checkout\(local\))
        local_branch=$(echo "$selected_branch" | sed 's/^origin\///')
        echo $local_branch
        git checkout -b "$local_branch" "$selected_branch"
        ;;
    *)
        echo "Invalid action"
        ;;
esac

