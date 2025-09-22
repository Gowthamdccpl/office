#!/bin/bash
echo "=== EC2 Login ==="

read -p "Enter Public IP: " PUBLIC_IP 
PUBLIC_IP=$(echo "$PUBLIC_IP" | sed 's/\./-/g')               # asking for public ip with user
                                                              # converting the dots into dash

                                                              # Building hostname and connect
HOSTNAME="ec2-${PUBLIC_IP}.ap-south-1.compute.amazonaws.com"

echo "Connecting to $HOSTNAME..."
ssh -i "office.pem" ubuntu@"$HOSTNAME"
