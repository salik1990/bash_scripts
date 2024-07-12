#!/bin/bash
<<Brief
    This is Script to automate User management for developers/administrators.
    It will ask user for an option to delete or create user.
    It will take username and password as input for user creation and deletion.
Brief


display_menu ()
{
    #echo "Total number of Arguments are:$#"
    echo "Welcome to UserManagement Menu Script"
    echo -e "\e[1;32m----------------------------\e[0m"
    echo -e "\e[1;32m1. Enter c for User Creation\e[0m"
    echo -e "\e[1;32m2. Enter d for User Deletion\e[0m"
    echo -e "\e[1;32m3. Enter e for Exit\e[0m"
    echo -e "\e[1;32m----------------------------\e[0m"
}
    
perform_action() {
    case $1 in
    c)
        echo "Executing User Creation"
        create_user
        ;;
    d)  echo "Executing User Deletion"
        delete_user
        ;;
    e)  echo "Exititing"
        exit 0
        ;;  
    *)
        echo "Invalud Option"
        ;;
    esac
}

create_user() {
    read -p "Enter the username to Create: " username
    read -p "Enter the password for user : " password
    # Check if the user already exists
    if id "$username" &>/dev/null; then
        echo -e "\e[1;31m----------------------------\e[0m"
        echo -e "\e[1;31mUser '$username' already exists.\e[0m"
        echo -e "\e[1;31m----------------------------\e[0m"
        return 1
    fi

    # Create the user
    sudo useradd -m "$username"
    if [ $? -ne 0 ]; then
        echo -e "\e[1;31m-------------------------------\e[0m"
        echo -e "\e[1;31mFailed to add user '$username'.\e[0m]"
        echo -e "\e[1;31m-------------------------------\e[0m"
        return 1
    fi

    # Set the user's password
    echo "$username:$password" | sudo chpasswd
    if [ $? -ne 0 ]; then
        echo -e "\e[1;31m--------------------------------------------\e[0m"
        echo -e "\e[1;31mFailed to set password for user '$username'.\e[0m"
        echo -e "\e[1;31m--------------------------------------------\e[0m"
        return 1
    fi
    echo -e "\e[1;32m--------------------------------------\e[0m"
    echo -e "\e[1;32mUser '$username' created successfully.\e[0m"
    echo -e "\e[1;32m--------------------------------------\e[0m"
    return 0
}

delete_user() {
    read -p "Enter the username to delete: " username

    # Prompt for whether to delete the home directory
    read -p "Delete home directory as well? (y/n): " delete_home

    # Check if the user exists
    if ! id "$username" &>/dev/null; then
        echo -e "\e[1;31m--------------------------------\e[0m"
        echo -e "\e[1;31mUser '$username' does not exist.\e[0m"
        echo -e "\e[1;31m--------------------------------\e[0m"
        return 1
    fi

    # Delete the user
    if [ "$delete_home" == "y" ] || [ "$delete_home" == "Y" ]; then
        sudo userdel -r "$username"
    else
        sudo userdel "$username"
    fi

    if [ $? -ne 0 ]; then
        echo -e "\e[1;31m----------------------------------\e[0m"
        echo -e "\e[1;31mFailed to delete user '$username'.\e[0m"
        echo -e "\e[1;31m----------------------------------\e[0m"
        return 1
    fi
    echo -e "\e[1;32m--------------------------------------\e[0m"
    echo -e "\e[1;32mUser '$username' deleted successfully.\e[0m"
    echo -e "\e[1;32m--------------------------------------\e[0m"
    return 0
}

while true;do
    # if [ $# -ne 2 ]; then
    # echo -e "\e[1;31mWrong Format :(\e[0m"
    # echo -e "\e[1;31mEnter Username as argument (1) and Password as argument (2) after $0 file\e[0m"
    # echo -e "\e[1:31mUsage []: \e[32;1m./$0 username password\e[0m"
    # exit 0
    # fi
    display_menu
    read -p "Enter your choise: " choice
    perform_action "$choice"
    done