# Path to your oh-my-zsh installation.
  export ZSH=/home/qiang/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="avit"
# ZSH_THEME="bullet-train"
# ZSH_THEME="powerline"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git autojump ag htop ccat web-search wd last-working-dir extract z d docker)

# User configuration

# export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin/:/usr/bin:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

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
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# 设置快捷命令
# 清除终端
alias cls='clear'
# ls 命令
alias ll='ls -l'
alias la='ls -al'
alias lh='ls -alh'
# grep 自动多色
alias grep="grep --color=auto"
# 解压命令，使用zsh z插件就不需要了
# alias gz='sudo tar -xzvf'
# alias bz='sudo tar -xjvf'
# alias xz='sudo xz -d'
# 
# 远程ssh登陆阿里云服务器
alias aliyun='ssh 'root@120.76.73.209''

# python3.5 pip package from pypi.douban.com
alias py3='sudo pip3 install $1 -i http://pypi.douban.com/simple --trusted-host pypi.douban.com'

# ssh登陆内网服务器
alias dms='ssh 'root@192.168.199.131''

# 查看文件内容，去除空行、# 注释、;注释内容
alias ge='sudo grep -Ev "^($|#|;)" $1'

# 打开文件夹
alias o='nautilus $1'

# 查询某个软件是否在运行
alias pg='ps -aux|grep $1'
# 查询端口是否被占用
alias portcheck='sudo netstat -pan|grep $1'

# nginx 开启，重启，关闭
alias nginxstart='sudo systemctl start nginx'
alias nginxreload='sudo systemctl reload nginx'
alias nginxstop='sudo systemctl stop nginx'

# docker command
# 杀死所有正在运行的容器
alias dockerkall='sudo docker kill `sudo docker ps -qf status=running`'
# 删除所有已经停止的容器
alias dockercleanc='sudo docker rm `sudo docker ps -qf status=exited`'
# 删除所有未dangling标签的镜像
alias dockercleani='sudo docker rmi `sudo docker images -qf dangling=true`'
# 删除所有已经停止的容器和未打标签的镜像
alias dockerclean='dockercleanc || true && dockercleani'
# 查看所有镜像
alias dockerimages='sudo docker images'
# 查看所有容器
alias dockercontainer='sudo docker ps -a'

# 删除停止并删除运行的容器
alias dockerstop='sudo docker stop $1'
alias dockerdeletec='sudo docker rm $1'
alias dockerdeletei='sudo docker rmi $1'

# docker加速器
[ -f ~/.bashrc_docker ] && . ~/.bashrc_docker

# gossh
alias gosshstart='sudo python /opt/shadowsocks/shadowsocks/local.py -c /etc/shadowsocks.json -d start'
alias gosshstop='sudo python /opt/shadowsocks/shadowsocks/local.py -d stop'
alias gosshrestart='sudo python /opt/shadowsocks/shadowsocks/local.py -d restart'


# ==============================================================================
# percol搜索增强
function exists { which $1 &> /dev/null }

if exists percol; then
    function percol_select_history() {
        local tac
        exists gtac && tac="gtac" || { exists tac && tac="tac" || { tac="tail -r" } }
        BUFFER=$(fc -l -n 1 | eval $tac | percol --query "$LBUFFER")
        CURSOR=$#BUFFER         # move cursor
        zle -R -c               # refresh
    }

    zle -N percol_select_history
    bindkey '^R' percol_select_history
fi
# ==============================================================================
# percol ppgrep ppkill function
function ppgrep() {
    if [[ $1 == "" ]]; then
        PERCOL=percol
    else
        PERCOL="percol --query $1"
    fi
    ps aux | eval $PERCOL | awk '{ print $2 }'
}

function ppkill() {
    if [[ $1 =~ "^-" ]]; then
        QUERY=""            # options only
    else
        QUERY=$1            # with a query
        [[ $# > 0 ]] && shift
    fi
    ppgrep $QUERY | xargs kill $*
}
# ==============================================================================
# 进入目录并执行ls
function chpwd(){
    emulate -L zsh
    ls -lh
}

# ==============================================================================
# tmux配置
alias tmuxv='bash /home/qiang/tmux.sh'
# ==============================================================================
# 制定python虚拟环境路径
export WORKON_HOME=~/Job/Envs
export PROJECT_HOME=~/Job/Envs/Projects
source /usr/bin/virtualenvwrapper.sh
