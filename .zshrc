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
plugins=(git git-prompt aws zsh-dircolors-solarized kubectl autojump zsh-autosuggestions)

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
[ -s "$HOME/.config/i3/local-env.sh" ] && source "$HOME/.config/i3/local-env.sh" # load site specific settings

alias passphraser="openssl rand -base64 32"
alias accountid="cat ~/work/organizer/accounts.txt| grep -i"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh" # This loads nvm

GODIR=/usr/local/go
GOPATH=$HOME/work/go
PATH=$PATH:$GODIR/bin:$GOPATH/bin:~/bin/kubebuilder/bin
export GOPATH PATH

# added by travis gem
[ -f /home/ians/.travis/travis.sh ] && source /home/ians/.travis/travis.sh

# k00bs
# export KUBECONFIG=~/.kube/config-test:~/.kube/config-development:~/.kube/config-production:~/.kube/config-preprod kubectl config view

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /home/ians/.nvm/versions/node/v7.8.0/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /home/ians/.nvm/versions/node/v7.8.0/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /home/ians/.nvm/versions/node/v7.8.0/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /home/ians/.nvm/versions/node/v7.8.0/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh

# Cluster configs
DEFAULT_KUBE_NAMESPACE="platform-enablement"
alias k-auth-dev="myob-auth k -e dev -n $DEFAULT_KUBE_NAMESPACE"
alias k-auth-preprod="myob-auth k -e jupiter-preprod -n $DEFAULT_KUBE_NAMESPACE"
alias k-auth-prod="myob-auth k -e jupiter -n $DEFAULT_KUBE_NAMESPACE"
alias k-auth-clear="rm $HOME/.kube/config"
alias k="kubectl"

if [ $commands[kubectl] ]; then
  source <(kubectl completion zsh)
fi

k-tail() {
  kubetail -v foo >/dev/null 2>&1 || { echo >&2 "kubetail not installed.  See: https://github.com/johanhaleby/kubetail for installation instructions."; return 0; }
  kubetail $*
}

k-events() {
  params=($*)
  k get ev -o=custom-columns=Name:metadata.name,Reason:reason,Type:type,Kind:involvedObject.kind,FirstSeen:firstTimestamp,LastSeen:lastTimestamp,Component:source.component --sort-by='lastTimestamp' ${params}
}

k-pods() {
  params=($*)
  k get pods -o custom-columns=Name:metadata.name,Host:spec.nodeName,Status:status.phase $params
}

k-pods-g() {
  k-pods |grep "$1"
}

w-k-events() {
  params=($*)
  cmd="kubectl get ev -o=custom-columns=Name:metadata.name,Reason:reason,Type:type,Kind:involvedObject.kind,FirstSeen:firstTimestamp,LastSeen:lastTimestamp,Component:source.component --sort-by='lastTimestamp' ${params}"
  watch $cmd
}

# Cluster configs
alias k-auth-dev="myob-auth k -e dev -n kube-system"

k-pf-dash() {
 export POD_NAME=$(kubectl get pods --namespace kube-system -l " k8s-app=kubernetes-dashboard" -o jsonpath="{.items[0].metadata.name}")
 kubectl --namespace kube-system port-forward $POD_NAME 9090
}

k-pf-prometheus() {
 export POD_NAME=$(kubectl get pods -l "app=prometheus,component=server" -o jsonpath="{.items[0].metadata.name}")
 echo $POD_NAME
 kubectl port-forward $POD_NAME 9090
}

k-pf-grafana() {
 export POD_NAME=$(kubectl get pods -l "app=grafana" -o jsonpath="{.items[0].metadata.name}")
 kubectl port-forward $POD_NAME 3000
}

k-pf-alertmgr () {
    kubectl port-forward alertmanager-0 9093
}

k-pods-all() {
  params=($*)
  k-pods --all-namespaces --show-all $params
}

k-pods-labels() {
  params=($*)
  k get pods --all-namespaces --show-labels |grep "$1"
}

k-nodes() {
  k get nodes $*
}

k-nodes-desc() {
  k describe nodes $*
}

w-k-nodes() {
  cmd="kubectl get nodes $*"
  watch $cmd
}

k-namespace() {
  k config set-context `k config current-context` --namespace $1
}

kc () {
  kubectl config current-context
}

k-netshoot () {
   kubectl run -it --rm --restart=Never netshoot --image=nicolaka/netshoot bash
}

k-events () {
    params=($*)
    k get ev -o=custom-columns=Name:metadata.name,Reason:reason,Type:type,Kind:involvedObject.kind,FirstSeen:firstTimestamp,LastSeen:lastTimestamp,Component:source.component --sort-by='lastTimestamp' ${params}
}

git-diff() {
  git diff $*^!
}

private-ips () {
  cluster=$1
  aws ec2 describe-instances --region ap-southeast-2 --filters "Name=tag:KubernetesCluster,Values=$cluster" --query 'Reservations[].Instances[] | sort_by(@, &Tags[?Key==`Name`].Value[]|[0]) | [].{ IP:PrivateIpAddress, Name:Tags[?Key==`Name`].Value[]|[0] }' --output table
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.oh-my-zsh/custom/plugins/kube-ps1/kube-ps1.sh ] && source ~/.oh-my-zsh/custom/plugins/kube-ps1/kube-ps1.sh
[ -f ~/.config/i3/ssh-agent.sh ] && source ~/.config/i3/ssh-agent.sh

docker-clean() {
  docker image prune -a
  docker system prune -a
}

PROMPT='$(kube_ps1)'$'\n'$PROMPT
