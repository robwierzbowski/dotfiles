# Add homebrew to path
eval $(/opt/homebrew/bin/brew shellenv)

# Add env vars
# export NPM_TOKEN="xxxxx"

# Add ssh keys
ssh-add --apple-load-keychain

# Pure prompt
fpath+=("$(brew --prefix)/share/zsh/site-functions")
autoload -U promptinit; promptinit
prompt pure

# Set ZSH to break word delete on any non-alphanumeric character
autoload -U select-word-style
select-word-style bash

# TODO: Antigen is abandoned; update to a supported script manager
# Load Antigen, ZSH plugin manager
source /opt/homebrew/share/antigen/antigen.zsh

# Completions
antigen bundle zsh-users/zsh-completions

# Extensions
antigen bundle zsh-users/zsh-history-substring-search

# Execute all antigen loaded scripts
antigen apply

# Bind zsh-users/zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Load Git completion
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh $fpath)
autoload -Uz compinit && compinit

# Turn off zsh regex matching for all commands (so we can install packages with
# special characters, use URLs in commands, etc.)
unsetopt nomatch

# Initialize z
. /opt/homebrew/etc/profile.d/z.sh

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

# TODO: Fix this to run from git root, not current directory
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
