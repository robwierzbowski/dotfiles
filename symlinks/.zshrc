# Path to your oh-my-zsh installation.
export ZSH=/Users/RobW/.oh-my-zsh

# Sindre's Pure promp init part 1
ZSH_THEME=""

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-syntax-highlighting)

# Load OH MY! ZSHHHH
source $ZSH/oh-my-zsh.sh

# Sindre's Pure promp init part 2
autoload -U promptinit; promptinit
prompt pure

# Good old PATH. Inherits some stuff from BASH I belive
export PATH="/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

# Add Homebrew
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

# Add nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# Don't use nvm dir completion; we have it already with zsh.

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# Import private, un-versioned auth tokens
source ~/.auth

# Load up that z search
. /usr/local/Cellar/z/1.8/etc/profile.d/z.sh

# Preferred editor for local and remote sessions
# export EDITOR='subl'

# ssh
ssh-add -K ~/.ssh/id_rsa

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# Remove oh-my-zsh git aliases
unalias -m 'g*'

# General aliases
alias zshrc='subl ~/.zshrc'
alias reload='source ~/.zshrc'
alias ip='ipconfig getifaddr en0'

# Git aliases
alias cm='git commit -m'
alias amend='git commit --amend'
alias branch='git branch'
alias chk='git checkout'
alias chp='git cherry-pick'
alias rebc='git rebase --continue'
alias reba='git rebase --abort'
alias stat='git status'
alias log='git log'
alias show='git show'
alias stash='git stash'
alias pop='git stash pop'
alias mt='git mergetool -y'
# Deletes merged branches
alias scrub='git branch --merged | xargs git branch -d'

# Fix the weird no mic issue
# http://superuser.com/questions/566102/microphone-not-working-with-google-hangout
alias fixaudio="sudo killall coreaudiod"

# Functions
rebi() {
  git rebase -i HEAD~$@;
}
rebo() {
  git rebase -i origin/master;
}
gg() {
  git grep --break --heading --line-number $@;
}
ggo() {
  subl $(git grep -l $@);
}
stato() {
  subl $(git status --porcelain | sed -ne 's/^ M //p')
}
