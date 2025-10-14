# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

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

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source ~/kaas-teleport/aliases


[ -s "/Users/edgar.sarkisian/.scm_breeze/scm_breeze.sh" ] && source "/Users/edgar.sarkisian/.scm_breeze/scm_breeze.sh"
export PATH=$PATH:$(go env GOPATH)/bin
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
export PATH="~/scripts:$PATH"


alias k=kubectl
alias kd='kubectl describe'
alias kns='kubens'

# enable aws command completion https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-completion.html
complete -C '/usr/local/bin/aws_completer' aws


source /Users/edgar.sarkisian/teleport-tool/aliases

# kubectl get all pods on a node
function kgppn ()
{
    kubectl get pods -A --field-selector spec.nodeName=$1,status.phase='Pending' --sort-by '.metadata.creationTimestamp'
}

function kgpn ()
{
    kubectl get pods -A --field-selector spec.nodeName=$1 --sort-by '.metadata.creationTimestamp'
}

# port-forward grafana on localhost:808_
function grafana(){
  echo $(k get secret -n kaas-monitoring kube-grafana -o jsonpath="{.data.admin-user}" | base64 --decode)
  echo $(k get secret -n kaas-monitoring kube-grafana -o jsonpath="{.data.admin-password}" | base64 --decode)
  if [[ "$1" = "" ]];then
    echo "port index not specified"
  elif [[ "$1" = "AUTO" ]];then
    kubectl port-forward svc/kube-grafana -n kaas-monitoring ":80"
  else
    PORT_MAPPING="808$1"
    kubectl port-forward svc/kube-grafana -n kaas-monitoring "$PORT_MAPPING:80"
    echo "http://localhost:$PORT_MAPPING"
  fi
}

function kube-new(){
  if [[ "$1" = "" ]];then
    export KUBECONFIG=$(mktemp)
    cp ~/.kube/config $KUBECONFIG
  else
    export KUBECONFIG="/tmp/kubeconfig-$1.yaml"
    cp ~/.kube/config $KUBECONFIG
  fi
  echo "set KUBECONFIG to $KUBECONFIG"
}
alias kn='kube-new'

function image-size(){
    aws ecr describe-images --region $1 --repository-name $2  --image-ids imageTag=$3  --profile hosting-prod  | yq '.imageDetails[0].imageSizeInBytes' | awk '{print $1/1000000 " MB"}'
}
function kpodimagesize(){
    image-size $(kubectl get po -n $1 $2 -o yaml | yq '.spec.volumes[1].csi.volumeAttributes.image' | sed 's/.*.ecr.\(\b.*\).amazonaws.com\/\(\b.*\):\(\b.*\)/\1 \2 \3/')
}

function kgppnimagesize(){
    for ns pod _ _ _ _ in $(kgppnnh $1); do
        # echo $ns $pod;
        echo $ns $pod $(kpodimagesize $ns $pod)
    done
}

# get pending pods on a node without column headers
function kgppnnh(){
    kubectl get pods -A --field-selector spec.nodeName=$1,status.phase='Pending' --sort-by '.metadata.creationTimestamp' --no-headers
}

function kdrupalimagesize(){
    image-size $(kubectl get po -n $1 -l app=drupal -o yaml | yq '.items[0].spec.volumes[1].csi.volumeAttributes.image' | sed 's/.*.ecr.\(\b.*\).amazonaws.com\/\(\b.*\):\(\b.*\)/\1 \2 \3/')
}

function mknote() {
    mkdir ~/notes/$1 && touch ~/notes/$1/$1.md && cd ~/notes/$1/
}

function ssmnode() {
    PROVIDERID=$(kubectl get no $1 -o yaml | yq .spec.providerID | sed 's/.*\///')
    REGION=$(kubectl get no $1 -o yaml | yq '.metadata.labels["topology.kubernetes.io/region"]')
    aws ssm start-session --profile hosting-prod --region $REGION --target $PROVIDERID
}
alias yless="jless --yaml"

export TELEPORT_ADD_KEYS_TO_AGENT=no
