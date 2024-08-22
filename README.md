# Pascal to x86 Assembly Compiler  

Takes an existing program written in Pascal, tokenizes the files using flex and bison, and then outputs the program as an Assembly file.
This project was done as part of the CS4121 class at MTU, therefore some of this code was not written myself and was done either by the instructor or as an existing project by GNU.

Depdendencies:
-  flex: https://github.com/westes/flex
-  bison: https://github.com/akimd/bison

With both dependencies installed, run "make" in the main directory which will create a new executable called "pjc" which can be run on a Pascal program to convert it to Assembly.
This output of this program is the .s file that can be compiled using a C compiler, such as g++. 
