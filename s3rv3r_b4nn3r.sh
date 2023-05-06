#!/bin/bash


######################################
# 		Author : Z3R0D4YH4X0R		 #
######################################

# usage: ./s3rv3r_b4nn3r.sh <File containing LIST of URL>

input=$1

RED='\033[0;31m'
Green='\033[0;32m'
Yellow='\033[0;33m'
NC='\033[0m' # No Color

if [[ ! -x $(which curl) ]]; then
    echo "[-] WARNING: Optional dependencies unmet. Please verify curl is installed or not" >&2
    exit 1
fi


while read -r line
do
  server=`curl -sI $line | grep -wi server`
  if test -z "$server" ;then
   	printf "$line : ${Green}NOT DETECTED${NC}\n"
  else
  	server_version=`echo "$server" | awk '/[[:digit:]]/'`
  	if test -n  "$server_version" ;then
   		printf "$line : ${RED}$server_version${NC}\n"
   	else
   		[[ "$server" =~ ^[^0-9]+$ ]] && printf "$line : ${Yellow}$server${NC}\n"
   	fi
  fi
done < "$input"

