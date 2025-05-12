# Getting Started

### ブランチ操作編
> ブランチを選択し、選択したブランチに対してアクションを実行するスクリプト

![Image](https://github.com/user-attachments/assets/b611ad1f-2aac-4efb-a7b4-665abf10d8e2)

1. fzfをinstall
```shell
brew install fzf
```
2. 以下のファイルを任意の場所に置く（クローンする）
```shell
git_branch_action.sh
```
3. `.zshrc`でエイリアスを貼る
```shell
// .zshrc
alias gb='~/任意の場所/git_branch_action.sh'
```
※文字入力で検索する際、以下のキーを入力すると説明通りの挙動が実行されるので、不要であれば`--bind`の記述から削除すること
| キーバインド | 説明 |
| --- | --- |
| ^ + c | 実行を中断 |
| q | 実行を中断 |
| j | 下に移動 |
| k | 上に移動 |

### git add, git reset 編
> キーワード検索でステージング、アンステージングできるスクリプト

![Image](https://github.com/user-attachments/assets/4b252a75-9cc7-4930-88e4-926ba0c71fa3)

1. 以下のファイルを任意の場所に置く（クローンする）
```shell
git_add.sh
git_reset.sh
```
2. `.zshrc`でエイリアスを貼る
```shell
alias ga='~/任意の場所/git_add.sh'
alias gres='~/任意の場所/git_reset.sh'
```
3. コマンドの後にキーワードを入れて実行する
```shell
// 例えば拡張子がjsのものだけaddする場合
ga js
// 逆に、拡張子がjsのものだけunstageする場合
gres js
```

