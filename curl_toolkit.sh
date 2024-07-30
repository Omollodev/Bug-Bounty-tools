#!/bin/bash

# Function to display the menu
show_menu() {
    echo "Curl Toolkit"
    echo "1. Fetch a Web Page"
    echo "2. Save a Web Page to a File"
    echo "3. Fetch HTTP Headers"
    echo "4. Send Custom Headers"
    echo "5. Make a POST Request"
    echo "6. Send JSON Data"
    echo "7. Download a File"
    echo "8. Follow Redirects"
    echo "9. Authenticate with Username and Password"
    echo "10. Upload a File"
    echo "11. Verbose Mode"
    echo "12. Exit"
}

# Function to read user choice
read_choice() {
    read -p "Enter your choice [1-12]: " choice
    return $choice
}

# Fetch a web page
fetch_web_page() {
    read -p "Enter URL: " url
    curl "$url"
}

# Save a web page to a file
save_web_page() {
    read -p "Enter URL: " url
    read -p "Enter filename to save: " filename
    curl "$url" -o "$filename"
}

# Fetch HTTP headers
fetch_http_headers() {
    read -p "Enter URL: " url
    curl -I "$url"
}

# Send custom headers
send_custom_headers() {
    read -p "Enter URL: " url
    read -p "Enter custom header (format: Header: value): " header
    curl -H "$header" "$url"
}

# Make a POST request
post_request() {
    read -p "Enter URL: " url
    read -p "Enter data (format: key1=value1&key2=value2): " data
    curl -d "$data" -X POST "$url"
}

# Send JSON data
send_json_data() {
    read -p "Enter URL: " url
    read -p "Enter JSON data: " json_data
    curl -H "Content-Type: application/json" -d "$json_data" -X POST "$url"
}

# Download a file
download_file() {
    read -p "Enter URL: " url
    curl -O "$url"
}

# Follow redirects
follow_redirects() {
    read -p "Enter URL: " url
    curl -L "$url"
}

# Authenticate with username and password
authenticate() {
    read -p "Enter URL: " url
    read -p "Enter username: " username
    read -sp "Enter password: " password
    echo
    curl -u "$username:$password" "$url"
}

# Upload a file
upload_file() {
    read -p "Enter URL: " url
    read -p "Enter file path to upload: " file_path
    curl -F "file=@$file_path" "$url"
}

# Verbose mode
verbose_mode() {
    read -p "Enter URL: " url
    curl -v "$url"
}

# Main loop
while true; do
    show_menu
    read_choice
    choice=$?
    
    case $choice in
        1) fetch_web_page ;;
        2) save_web_page ;;
        3) fetch_http_headers ;;
        4) send_custom_headers ;;
        5) post_request ;;
        6) send_json_data ;;
        7) download_file ;;
        8) follow_redirects ;;
        9) authenticate ;;
        10) upload_file ;;
        11) verbose_mode ;;
        12) exit 0 ;;
        *) echo "Invalid choice, please try again." ;;
    esac

    echo
    read -p "Press Enter to continue..."
done
