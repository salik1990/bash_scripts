#!/bin/bash

# Bold text
echo -e "\e[1mThis is bold text\e[0m"

# Colored text
echo -e "\e[31mThis is red text\e[0m"
echo -e "\e[32mThis is green text\e[0m"
echo -e "\e[33mThis is yellow text\e[0m"
echo -e "\e[34mThis is blue text\e[0m"
echo -e "\e[35mThis is magenta text\e[0m"
echo -e "\e[36mThis is cyan text\e[0m"

# Underlined text
echo -e "\e[4mThis is underlined text\e[0m"

# Background colors
echo -e "\e[41mThis is text with red background\e[0m"
echo -e "\e[42mThis is text with green background\e[0m"
echo -e "\e[43mThis is text with yellow background\e[0m"
echo -e "\e[44mThis is text with blue background\e[0m"
echo -e "\e[45mThis is text with magenta background\e[0m"
echo -e "\e[46mThis is text with cyan background\e[0m"

# Combining formatting
echo -e "\e[1;31mThis is bold and red text\e[0m"
echo -e "\e[4;32mThis is underlined and green text\e[0m"
echo -e "\e[1;4;34mThis is bold, underlined, and blue text\e[0m"
