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
alias mend='git commit --amend --no-edit'

alias chk='git checkout'
alias branch='git branch'
alias chp='git cherry-pick'
alias cm='git commit -m'
alias getit='chk main && git pull && chk - && git rebase main'
alias log='git log'
alias pop='git stash pop'
alias reba='git rebase --abort'
alias rebc='git rebase --continue'
alias recent='git branch --sort=-committerdate | head -n 20'
alias rmorig='rm *.orig && rm **/*.orig'
alias show='git show'
alias stash='git stash'
alias stat='git status'

alias mt='git mergetool -y'
alias scrub='git branch --merged | xargs git branch -d'

gg() { git grep --break --heading --line-number $@; }
ggo() { code $(git grep -l $@); }
rebi() { git rebase -i HEAD~$@; }
rebo() { git rebase -i origin/main; }

# Opens all tracked changed files
# TODO: Fix to run from git root, not current directory
stato() { code $(git status --porcelain | sed -ne 's/^ M //p'); }

# Sets upstream branch to current branchname on origin
upstr() {
  git branch --set-upstream-to=origin/$(git rev-parse --abbrev-ref HEAD)
}

# Setup nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Install or load .nvmrc version on directory change
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm install # Switched to install from use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc
