#!/bin/bash

# script modified from
# https://coderwall.com/p/moabdw/using-rsync-to-deploy-a-website-easy-one-liner-command

REMOTE_USER="user"
SERVER="blog.neverbot.com"
LOCAL_PATH="./"
REMOTE_PATH="/var/www/somewhere/"
EXCLUDE_FILE="exclude.txt"
ERROR="No."


if [ ! -f $EXCLUDE_FILE ]
then
    echo $ERROR $EXCLUDE_FILE "not found."
    exit
fi

if [ $# -eq 0 ]
then
    echo $ERROR "Syntax: deploy <server> [go]"
elif [ $1 == "prod" ]
then
    if [[ -z $2 ]]
    then
        echo "Running dry-run"
        rsync --dry-run -ahz --force --delete --progress --exclude-from=$EXCLUDE_FILE -e "ssh -p22" $LOCAL_PATH $REMOTE_USER@$SERVER:$REMOTE_PATH
    elif [ $2 == "go" ]
    then
        echo "Running actual deploy"
        rsync -ahz --force --delete --progress --exclude-from=$EXCLUDE_FILE -e "ssh -p22" $LOCAL_PATH $REMOTE_USER@$SERVER:$REMOTE_PATH
    else
        echo $ERROR
    fi
fi
