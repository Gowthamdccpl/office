#!/bin/bash

echo "Enter public ip"
echo "Enter number with dash, ex- 15-2-222-222 like this"
read -rp "IP: " ip && ssh -i "office.pem" ubuntu@ec2-$ip.ap-south-1.compute.amazonaws.com

echo "aajhvdgsnhdhgvhjd"
echo "jjjbgvhvefefef"