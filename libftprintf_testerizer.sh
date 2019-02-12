#!/bin/bash
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    libftprintf_testerizer.sh                          :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: bleplat <marvin@42.fr>                     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2019/02/05 16:52:11 by bleplat           #+#    #+#              #
#    Updated: 2019/02/05 18:17:03 by bleplat          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

### CONFIG ###
# Project to copy
project_dir=../no_try_yet
# Additional flags (cf -fsanitize=addressi)
add_flags="-fsanitize=address"


ret_printf=""
rst_printf=""
ret_ft_printf=""
rst_ft_printf=""

tests=""

col_def="\e[36m"
col_nam="\e[37m"
col_ok="\e[32m"
col_ko="\e[31m"
col_exp="\e[91m"

if [ "$1" = "run" ] ; then
	printf "${col_def}Just running tests\n"
else
	printf "${col_def}Recopying/Recompiling the project. Use './$0 run' to only re-run the tests\n"
	rm -rf "./cp_dir"
	cp -rf $project_dir "./cp_dir"
	make -C "./cp_dir"
fi

total_passed=0
total_failed=0

# init_test()
#
# $1: test to prepare
function init_test()
{
	rm -f init.c
	cat $1 | sed -e "/^TEST(.*)$/d" > init.c
}

function compile_test()
{
	gcc -w ${add_flags} -o runtest.out test.c -L ./cp_dir/ -lftprintf
}

function single_test()
{
	arguments=$(echo $1 | sed "s/TEST(\(.*\))/\1/p;d" | sed -e 's/[\/&]/\\&/g')
	printf "$col_def"
	printf "\t[$col_nam%s$col_def]: " "$arguments"
	cat main_tests.c | sed -e "s/printf()/printf($arguments)/g" > test.c
	compile_test
	rst_printf=$(./runtest.out printf)
	ret_printf=$?
	rst_ft_printf=$(./runtest.out ft_printf)
	ret_ft_printf=$?
	if [ "$rst_ft_printf" = "$rst_printf" -a "$ret_ft_printf" = "$ret_printf" ]
	then
		printf "$col_def[${col_ok}ok${col_def}]\n"
		total_passed="`expr $total_passed + 1`"
	else
		printf "$col_def[${col_ko}KO${col_def}]\n"
		printf "$col_exp"
		printf "printf    (%s):\t%s\n" "$ret_printf" "$rst_printf"
		printf "ft_printf (%s):\t%s\n" "$ret_ft_printf" "$rst_ft_printf"
		total_failed="`expr $total_failed + 1`"
	fi
	rm -f runtest.out
}

# test_file()
#
# run tests for a file
# $1: file to test
function test_file()
{
	printf "$col_def"
	printf "RUNNING TESTS FOR $col_nam%s\n" $(echo $1 | sed "s/.*\///g")
	init_test $1
	tests=$(cat $1 | sed "/^TEST(.*)$/p;d")
	while read -r singletest; do
		single_test "$singletest"
	done <<< "$tests"
}

for testname in ./tests_compare_printf/*; do
	test_file $testname
done


printf $col_def
printf "ALL DONE!"
printf "$col_ok\tPASSED: %s / %s" $total_passed "`expr $total_passed + $total_failed`"
printf "$col_ko\tFAILED: %s / %s" $total_failed "`expr $total_passed + $total_failed`"
