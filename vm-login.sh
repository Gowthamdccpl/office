#!/bin/bash

echo "vm login automation "


DOWNLOADS_DIR="$HOME/Downloads"                                            # will look in downloads folder
SSH_KEY="office.pem"                                                       # giving the key pair 

                                        
if [ ! -f "$SSH_KEY" ]; then                                               # will check if office.pem is present or not
    echo -e "Error: office.pem not found in Downloads folder!${NC}"         
    echo "Please make sure 'office.pem' is in your Downloads folder."
    exit 1
fi

echo -e "Found SSH key: office.pem"

                                       
chmod 400 "$SSH_KEY"                                                        # giving only read permission for this file
echo "SSH key permissions set correctly."
echo ""

                                                                            # asking user for the public IP from user
while true; do                                                              # opening the while loop
    echo "Enter your EC2 instance public IP address"
    echo "Example: 15-206-79-21 (just the numbers with dashes)"
    read -p "Public IP: " PUBLIC_IP
    
                                                                            # Checking if input contains only numbers, dots, and dashes
    if [[ $PUBLIC_IP =~ ^[0-9\.\-]+$ ]]; then
                                                                            # Convert dots to dashes if user entered IP with dots
        PUBLIC_IP=$(echo "$PUBLIC_IP" | sed 's/\./-/g')
        break
    else
        echo -e "Invalid format! Please enter IP like: 15-206-79-21"        # if user enters wrong 
        echo ""
    fi
done

                                                                             # Building the full AWS hostname
AWS_HOSTNAME="ec2-${PUBLIC_IP}.ap-south-1.compute.amazonaws.com"

echo ""
echo -e "Connecting to your EC2 instance..."
echo "Hostname: $AWS_HOSTNAME"
echo "User: ubuntu"
echo "Key: office.pem"
echo ""

                                                                               # Connecting to the  EC2 instance
echo "Connecting..."
ssh -i "$SSH_KEY" ubuntu@"$AWS_HOSTNAME"

                                                                               # Checking connection result
if [ $? -eq 0 ]; then                                                          # here seeing last command was true or not
    echo ""
    echo -e "SSH connection is successfully."
else
    echo ""
    echo -e "Connection failed!"
    echo "plz check these issues:"
    echo "1. Wrong public IP address"
    echo "2. Instance is not running"
    echo "3. Security group doesn't allow SSH access"
    echo "4. Check if office.pem is the correct key for this instance"
fi
