cmake_minimum_required(VERSION 3.19)
project(VE477_lab1 C)

set(CMAKE_C_STANDARD 11)

add_executable(VE477_lab1 main.c)
add_executable(Dict dictionary.c dictionary.h dictTest.c)
add_executable(Hash hash.c hash.h hashTest.c)