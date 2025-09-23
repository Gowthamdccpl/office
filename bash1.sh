#!/bin/bash
echo "=== EC2 Login ==="

read -rp "Enter Public IP: " PUBLIC_IP                   # asking for public ip with user
PUBLIC_IP=$(echo "$PUBLIC_IP" | sed 's/\./-/g')          # converting the dots into dash      

if [[ "$PUBLIC_IP" =~ ^[0-9.-]+$ ]]; then
    echo "Numeric"
else
    echo "Alphanumeric"
fi

                                                 
HOSTNAME="ec2-${PUBLIC_IP}.ap-south-1.compute.amazonaws.com"   # Building hostname to connect

echo "Connecting to $HOSTNAME..."
ssh -i "office.pem" ubuntu@"$HOSTNAME"

echo"just another line"
