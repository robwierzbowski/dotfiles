# Add homebrew to path
eval $(/opt/homebrew/bin/brew shellenv)

# Add env vars
# export NPM_TOKEN="xxxxx"

# Add ssh keys
ssh-add --apple-load-keychain

# Configure zsh

# Set zsh to break word on any non-alphanumeric character
autoload -U select-word-style
select-word-style bash

# Use case-insensitive autocomple
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Use tab/menu style autocomple
zstyle ':completion:*' menu select

# TODO: Git completion not working — fix
# Load git completion
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh $fpath)
autoload -Uz compinit; compinit

# Turn off zsh regex matching so we can run commands with special characters,
# use URLs in commands, etc. Useful for installing packages by url.
unsetopt nomatch

# Load Pure prompt
fpath+=("$(brew --prefix)/share/zsh/site-functions")
autoload -U promptinit; promptinit
prompt pure

# Configure zsh plugins
export ZPLUG_HOME=/opt/homebrew/opt/zplug
source $ZPLUG_HOME/init.zsh
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search"
# Trying the zsh native rewrite of z. It's *fast* and has great autocomplete
zplug "agkozak/zsh-z"
# Install adds startup time, but it's easier than remembering to run install
# whenever we change the zshrc. Better UX > a little additional startup time.
zplug install
zplug load

# Use arrow keys with zsh-users/zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# General aliases
alias nom='echo "nom nom nom" && npm'
alias hyperrc='code ~/.hyper.js'
alias zshrc='code ~/.zshrc'

# Git aliases
alias amend='git commit --amend'
alias branch='git branch'
alias brecent='git branch --sort=-committerdate | head -n 20' # Recent branches, by date of latest change
alias chk='git checkout'
alias chp='git cherry-pick'
alias cm='git commit -m'
alias getit='chk master && git pull && chk - && git rebase master'
alias log='git log'
alias mend='git commit --amend --no-edit'
alias mt='git mergetool -y'
alias pop='git stash pop'
alias reba='git rebase --abort'
alias rebc='git rebase --continue'
alias rmmerged='git branch --merged | grep -Ev "(^\*|master)" | xargs git branch -d'
alias scrub='git branch --merged | xargs git branch -d'
alias stash='git stash'
alias stat='git status'
alias werkin='git add . && cm "werkin"'

gg() { git grep --break --heading --line-number $@; }
ggo() { code $(git grep -l $@); }
rebi() { git rebase -i HEAD~$@; }
rebo() { chk master; git pull; chk -; git rebase -i master; }

# Opens all tracked changed files
# TODO: Fix to run from git root, not current directory
stato() { code $(git status --porcelain | sed -ne 's/^ M //p'); }

# Sets upstream branch to current branchname on origin
upstr() {
  git branch --set-upstream-to=origin/$(git rev-parse --abbrev-ref HEAD)
}

# Activate `fnm`: https://github.com/Schniz/fnm
if command -v fnm >/dev/null; then
  eval "$(fnm env --use-on-cd)"
fi
