#!/bin/bash

first_list=$(nm -u ./cp_dir/libftprintf.a | sed "/^_ft_/d")

if [ "$1" = "details" ]; then
	first_list=$(echo "$first_list" | sed "/\.a(.*):$\./d")
	printf ""
else
	first_list=$(echo "$first_list" | sed "/\.a(.*):/d")
fi

first_list=$(echo "$first_list" | sed "/^___/d")
first_list=$(echo "$first_list" | sed "/^_malloc$/d")
first_list=$(echo "$first_list" | sed "/^_free$/d")
first_list=$(echo "$first_list" | sed "/^_write$/d")
first_list=$(echo "$first_list" | sed "/^_exit$/d")

esc=$(printf "\033")
first_list=$(echo "$first_list" | sed "s/^_\(.*\)$/${esc}[31m${esc}[4m\1${esc}[0m/g")
found=$(echo "$first_list" | sed "/^$/d")

if [ "$found" = "" ]; then
  printf "\x1b[92mno forbidden functions found.\n"
else
  printf "\x1b[31mForbidden functions found in your library: \n\x1b[0m%s\x1b[0m\n" "$found"
  printf "\x1b[91mNote that if you use functions from another library, functions not starting by 'ft_' will be detected.\n"
  printf "\x1b[91mLauch './findforbidden.sh details' for details.\n"
  printf "\x1b[91mYou can possibly ignore this if you have functions you dont use.\n"
fi
