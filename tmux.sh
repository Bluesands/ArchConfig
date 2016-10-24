#!/bin/bash

cmd=$(which tmux) # tmux path
session=work  # session name

# 判断session是否存在
$cmd has -t $session

# $?  最后运行的命令的结束代码（返回值） 
if [ $? != 0 ]; then
  $cmd new -d -n vim -s $session "vim -O2"
  $cmd splitw -v -p 20 -t $session "zsh"
  $cmd splitw -h -p 50 -t $session "zsh"
  $cmd neww -n zsh -t $session "zsh"
  $cmd splitw -h -p 50 -t $session "zsh"
  $cmd selectw -t $session:1
fi

$cmd att -t $session

exit 0
