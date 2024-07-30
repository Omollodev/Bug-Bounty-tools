#!/bin/bash
PATH=$PATH
export $PATH


# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <domain1,domain2,...> <process1,process2,...>"
  echo "Processes: dns,http_headers,whois,ssl,gobuster,sublist3r,nmap"
  exit 1
fi

# Parse the domains and processes
IFS=',' read -r -a domains <<< "$1"
IFS=',' read -r -a processes <<< "$2"

# Function to check if a process is in the list
function in_process_list() {
  local process=$1
  for p in "${processes[@]}"; do
    if [ "$p" == "$process" ]; then
      return 0
    fi
  done
  return 1
}

# Iterate over each domain
for DOMAIN in "${domains[@]}"; do
  OUTPUT_FILE="${DOMAIN}_info.txt"
  
  echo "Processing domain: $DOMAIN"

  {
    echo "Domain: $DOMAIN"

    if in_process_list "dns"; then
      # Resolve domain to IP
      IP=$(dig +short $DOMAIN)
      if [ -z "$IP" ]; then
        echo "Failed to resolve domain."
      else
        echo "IP address: $IP"
      fi
    fi

    if in_process_list "http_headers"; then
      # Retrieve HTTP headers
      echo "Fetching HTTP headers..."
      HEADERS=$(curl -sI $DOMAIN)
      echo "$HEADERS"
    fi

    if in_process_list "whois"; then
      # Perform WHOIS lookup
      echo "Performing WHOIS lookup..."
      WHOIS=$(whois $DOMAIN)
      echo "$WHOIS"
    fi

    if in_process_list "ssl"; then
      # Fetch SSL certificate details
      echo "Fetching SSL certificate details..."
      CERT=$(echo | openssl s_client -servername $DOMAIN -connect $DOMAIN:443 2>/dev/null | openssl x509 -noout -text)
      echo "$CERT"
    fi

    if in_process_list "gobuster"; then
      # Retrieve files and directories using gobuster
      echo "Retrieving files and directories with gobuster..."
      
      /usr/bin/gobuster dir -u http://$DOMAIN -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt -o gobuster_output.txt
      GOBUSTER_OUTPUT=$(cat gobuster_output.txt)
      echo "$GOBUSTER_OUTPUT"
    fi

    if in_process_list "sublist3r"; then
      # Enumerate subdomains using sublist3r
      echo "Enumerating subdomains with sublist3r..."
      sublist3r -d $DOMAIN -o subdomains.txt
      SUBDOMAINS=$(cat subdomains.txt)
      echo "$SUBDOMAINS"
    fi

    if in_process_list "nmap"; then
      # Run nmap port scan with vulnerability scripts
      echo "Running nmap port scan..."
      NMAP_OUTPUT=$(nmap -Pn -sV -p- --script vuln $DOMAIN)
      echo "$NMAP_OUTPUT"
    fi
  } > "$OUTPUT_FILE"

  echo "Information gathering for $DOMAIN complete. Output saved to $OUTPUT_FILE."
done

echo "All tasks complete."
