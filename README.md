# libftprintf_testerizer

You can use this project to easily make tests to compare your ft_printf output with the true printf.

It is not possible to do all kind of tests (like %n) yet.
If you want tu use addresses (cf "%p"), use hard-coded values, dont create a pointer above the test.

Lots of bonuses are tested, so expect to have a few fails. However you should never crash.
Also some undefined behavior cases are tested.

# Install

- Clone this repository.
- Edit the .sh file to set the config. Options are explained in it.

# Usage

This tester is NOT enough to be sure that your printf works. *Dont use only it*.

Usage: ?.sh [run] [test_name]
use 'run' as the first option to not recompile the project (work only on copyed projects).
replace 'test_name' to only run tests from a single file.
