#!/bin/bash


echo "==== User Account Creation  ===="
echo

if [ "$EUID" -ne 0 ]; then  # it will wheather the user is root or not , if not it will display to run with sudo
    echo "Please run this script with sudo"
    echo "Example: sudo ./create_user.sh"
    exit 1
fi

create_user() {                    # function creation
    echo "Enter username:"         # asks for user name and reads from user input 
    read username
    
    echo "Enter password:"           # asks for password and rerads the user password
    read -s password                 # -s hides password input    
    
    echo "Enter groups (optional, press Enter to skip):"
    read groups
    
    echo "Creating user: $username"   # creates the user after all the inputs
    useradd -m $username              # useradd cmd creates new user and -m refers to home 
    
    if [ $? -eq 0 ]; then             # checking if user accnt is created or not , $?=holds the exot status of last cmd , 0 means success
        echo "✓ User $username created successfully" 
        
                                                 # Sets password
        echo "$username:$password" | chpasswd
        echo "✓ Password set for $username"
        
                                               # Add to groups if specified
        if [ ! -z "$groups" ]; then            # checks if groups is not empty
            usermod -a -G $groups $username    # if present then it will append user to those groups
            echo "✓ User $username added to groups: $groups"
        fi
        
                              # Log the action
        echo "$(date): Created user $username with groups: $groups" >> user_creation.log  # inserts the current date and appends it to the user_creation.log file
        echo "✓ Action logged"
        
    else
        echo "✗ Failed to create user $username"   # if the action failed then it will show error msg and appends the errors into the log file.
        echo "$(date): Failed to create user $username" >> user_creation.log
    fi
}

                                                            # Function to create multiple users
create_multiple_users() {                                   # funtion for multiple user creation
    echo "How many users do you want to create?"            # asking how many user to be created
    read count                                              # reading the count of the user
    
    for i in $(seq 1 $count); do                            # openig for loop and it will create the users according to the input given by the user
        echo
        echo "--- Creating user $i of $count ---"
        create_user
    done
}

                                            # Main menu
echo "Choose an option:"                    # gives user multiple option to choose from the list
echo "1) Create one user"
echo "2) Create multiple users"
echo "3) Exit"
read choice                                  # reads the choice stores it in variable choice

case $choice in                              # switch case is opened
    1)
        create_user                          # if the choice is 1 then it will create single user
        ;;
    2)
        create_multiple_users                # if the choice is 2 then it will create multiple user
    3)
        echo "Goodbye!"
        exit 0                               # if it is 3 then it will exit the switch case
        ;;
    *)
        echo "Invalid choice. Please run the script again."   # if user selects or guive wrong no then this msg will be displayed 
        exit 1
        ;;
esac

echo
echo "Done! Check user_creation.log for details"    # after creating it will tell user check details in this log file.
