#!/bin/bash

echo "Welcome to Log Analyzer!"                                # Printing a welcome message


echo "Please enter log file path:"                              # will ask user to enter the log file path
read file_path                                                  # 'read' command takes user input and stores it in a variable

if [ ! -f "$file_path" ]                                          # Check if the file exists using -f test
then
    echo "Sorry, file not found!"
    exit 1                                                      # Exit the script with error code 1
fi

echo "Great! File exists."                                      # If we find that file exists then it will print the msg file exists

echo "What keyword do you want to search for?"                  # will ask  the user for the keyword to search
read search_word                                                 # will read the keyword and store it in search_word variable

result=$(grep -i "$search_word" "$file_path" | wc -l)

                                                                # Use grep command to search for the keyword
                                                                # -i makes search case-insensitive (Path = path = PATH) so we can search for the word by not looking at the wheather it is in capitol letter or small letter
                                                                # wc -l counts the number of lines
                                                                # $ symbol accesses the value stored in variable
                                                                
echo ""
echo "..........................................."
echo "RESULTS:"                                                 # after searching will Show or display the results
echo "--------"
echo "File searched: $file_path"                                # will display the file searched by the user
echo "Keyword: $search_word"                                    # will display the word searched by the user
echo "Times found: $result"                                     # will display the result of the search


echo ""
echo "---------------------------------------------"           # will ask if user wants to save the search rersult or not!
echo "Save to file? Type 'yes' or 'no':"                       # displaying the msg for the user"
read answer                                                    # will read the user answer to save the result or not


if [ "$answer" = "yes" ]                                       # will Check user's answer to the question
then
    report_name="report.txt"                                    # Create a simple report file name to save all the report details


    echo "Search Results" > "$report_name"  #search result will be saved inthis file                                   # Write results to file   , > creates  or overwrites the file, >> adds or appends to existing file
    echo "File: $file_path" >> "$report_name" #file name or path will be saved into this file.
    echo "Keyword: $search_word" >> "$report_name"  #keyword will be saved to this file.
    echo "Count: $result" >> "$report_name" #count will also be saved into this file only

    echo "Saved to $report_name"
else
    echo "Not saved."
fi

echo "thank you for using"                                     # display thank you message at the end
