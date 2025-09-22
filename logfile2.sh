#!/bin/bash

echo "Welcome to Log Analyzer!"

echo "Please enter log file path:"
read file_path

if [ ! -f "$file_path" ]
then
    echo "Sorry, file not found!"
    exit 1
fi

echo "Great! File exists."

# Enhanced error analysis function
analyze_errors() {
    local log_file="$1"
    
    echo ""
    echo "DETAILED ERROR ANALYSIS:"
    echo "-----------------------"
    
    # Count total errors
    total_errors=$(grep -i "error\|fail\|exception\|critical\|warning" "$log_file" | wc -l)
    echo "Total error-related entries: $total_errors"
    
    # Count by error type
    echo ""
    echo "Breakdown by type:"
    echo "Errors: $(grep -i "error" "$log_file" | wc -l)"
    echo "Failures: $(grep -i "fail" "$file_path" | wc -l)"
    echo "Exceptions: $(grep -i "exception" "$file_path" | wc -l)"
    echo "Warnings: $(grep -i "warning" "$file_path" | wc -l)"
    
    # Show most frequent error messages (top 5)
    echo ""
    echo "Most frequent error messages:"
    grep -i "error" "$log_file" | sort | uniq -c | sort -nr | head -5
    
    # Check for recent errors (last hour if timestamps available)
    echo ""
    echo "Recent errors (if timestamps available):"
    # This assumes timestamp format like [2023-12-07 10:30:45]
    recent_errors=$(grep -i "error" "$log_file" | grep "$(date '+%Y-%m-%d %H')" | head -5)
    if [ -n "$recent_errors" ]; then
        echo "$recent_errors"
    else
        echo "No recent errors found or unable to parse timestamps"
        # Fallback: show last 5 errors
        grep -i "error" "$log_file" | tail -5
    fi
}

# Execute the error analysis
analyze_errors "$file_path"

# Continue with original functionality...
echo ""
echo "What keyword do you want to search for?"
read search_word

result=$(grep -i "$search_word" "$file_path" | wc -l)

echo ""
echo "..........................................."
echo "RESULTS:"
echo "--------"
echo "File searched: $file_path"
echo "Keyword: $search_word"
echo "Times found: $result"

echo ""
echo "---------------------------------------------"
echo "Save to file? Type 'yes' or 'no':"
read answer

if [ "$answer" = "yes" ]
then
    report_name="report_$(date '+%Y%m%d_%H%M%S').txt"
    
    {
        echo "Log Analysis Report - Generated on $(date)"
        echo "=========================================="
        echo "File: $file_path"
        echo "Search Keyword: $search_word"
        echo "Occurrences: $result"
        echo ""
        echo "ERROR SUMMARY:"
        echo "--------------"
        echo "Total errors: $(grep -i "error" "$file_path" | wc -l)"
        echo "Total failures: $(grep -i "fail" "$file_path" | wc -l)"
        echo "Total warnings: $(grep -i "warning" "$file_path" | wc -l)"
        echo ""
        echo "SAMPLE ERRORS:"
        grep -i "error" "$file_path" | head -10
    } > "$report_name"
    
    echo "Saved to $report_name"
else
    echo "Not saved."
fi

echo "Thank you for using Log Analyzer!"
