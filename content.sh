#!/bin/bash
read -rp "Enter heading to search: " heading  # asking user for heading

content=$(curl -s https://www.thehindu.com/news/national/) # Fetching webpage content


# Search for heading
if echo "$content" | grep -qi "$heading"; then
    echo "successful"
else
    echo "failure"
fi