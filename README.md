# Getting Started

### ブランチ操作編
> ブランチを選択し、選択したブランチに対してアクションを実行するスクリプト
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

### git add, git reset 編
> キーワード検索でステージング、アンステージングできるスクリプト
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

