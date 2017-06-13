# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/home/ians/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="blinks"
ZSH_THEME="schminitz"
SOLARIZED_THEME="dark"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git git-prompt aws zsh-dircolors-solarized kubectl)

source $ZSH/oh-my-zsh.sh
source $ZSH/custom/plugins/zsh-dircolors-solarized/zsh-dircolors-solarized.zsh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias aumeladmin="xfreerdp +clipboard /d:MYOB /u:admin-ian.stahnke /h:1024 /w:1280 /v:aumeladmin01.myob.myobcorp.net"
alias aumeladfs="xfreerdp +clipboard /d:MYOB /u:admin-ian.stahnke /h:1024 /w:1280 /v:aumeladfs01.myob.myobcorp.net"
alias aumelipki01="xfreerdp +clipboard /d:MYOB /u:admin-ian.stahnke /h:1024 /w:1280 /v:aumelipki01.myob.myobcorp.net"
alias aumelipki02="xfreerdp +clipboard /d:MYOB /u:admin-ian.stahnke /h:1024 /w:1280 /v:aumelipki02.myob.myobcorp.net"
alias passphraser="date +%s | sha256sum | base64 | head -c 32 ; echo"

# rvm
[ -s "/etc/profile.d/rvm.sh" ] && source /etc/profile.d/rvm.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh" # This loads nvm

GODIR=/usr/local/go
GOPATH=$HOME/work/go
PATH=$PATH:$GODIR/bin:$GOPATH/bin
export GOPATH PATH

# added by travis gem
[ -f /home/ians/.travis/travis.sh ] && source /home/ians/.travis/travis.sh

# k00bs
export KUBECONFIG=~/.kube/config-development:~/.kube/config-production:~/.kube/config-preprod kubectl config view

function k() {
  kenv="dev"
  kontext=""
  if [  -n "$1" ]
  then
    kenv="$1"
  fi
  case $kenv in 
    dev*)
      kontext="k8s.ex-central-development.myob.com"
      ;;
    pre*)
      kontext="jupiter-preprod.platform.myob.com"
      ;;
    pro*)
      kontext="jupiter.platform.myob.com"
      ;;
    *)
      echo unknown context: $kenv
      echo defaulting to development
      kontext="k8s.ex-central-development.myob.com"
      ;;
  esac
  kubectl config use-context ${kontext}
}
