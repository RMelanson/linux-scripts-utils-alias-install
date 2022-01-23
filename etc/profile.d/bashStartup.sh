#!/bin/bash
set -o vi
export PS1="[\u@\h:\w ] $ "

startUpAliasFilesDir="/etc/profile.d/startUpAliasFiles/"
SOURCE_DIR=$startUpAliasFilesDir/user_env
USER_DIR=~/.env
SET_ENV=". $USER_DIR/.e"

echoLog(){
 echo $* 2>&1 | tee -a setup.log
}

strInFile(){
   str=$1
   fname=$2
   echoLog Searching for String $str in File $fname
   echoLog EXECUTING: cat $fname \| grep -o "$str" \| wc -l
#   found=$(cat $fname | grep -c "$str")
   found=$(cat $fname | grep -o "$str" | wc -l)
   echoLog string found = $found
  [ ! $found -eq 0 ]
}

updateBashrc(){
  if strInFile "$SET_ENV" ~/.bashrc
   then
     echoLog LAUNCH BASH ENVIRONMENT ALIASE\'S ALREADY INSTALLED
  else
    echoLog LAUNCH BASH ENVIRONMENT ALIASE\'S SETTINGS >> ~/.bashrc
    echoLog EXECUTING: echo $SET_ENV \>\> ~/.bashrc
    echoLog $SET_ENV >> ~/.bashrc
  fi
}

setBashEnv(){
  if [ -d "$USER_DIR" ];
    then {
      echoLog "DIRECTORY $USER_DIR exists."
      echoLog "SETTING ENV"
    }
    else {
      echoLog "DIRECTORY $SOURCE_DIR Not Found."
      echoLog "EXECUTING: cp -rf $SOURCE_DIR $USER_DIR"
      cp -rf $SOURCE_DIR $USER_DIR
      echoLog 766 $USER_DIR
      chmod 766 $USER_DIR
      updateBashrc
      echoLog EXECUTING: $SET_ENV
      $SET_ENV
    }
  fi
}

updateBashrc
