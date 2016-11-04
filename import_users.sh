#!/bin/bash

aws iam list-users --query "Users[].[UserName]" --output text | while read Email; do
  User=`echo $Email | sed -e 's/@.*//g'`
  echo $User
  if id -u "$User" >/dev/null 2>&1; then
    echo "$User exists"
  else
    /usr/sbin/adduser "$User" --disabled-password -gecos ""
    echo "$User ALL=(ALL) NOPASSWD:ALL" > "/etc/sudoers.d/$User"
  fi
done
