#!/bin/bash

# Uncomment if you haven't do the propper permission setup for wireshark/user
# if [ "$EUID" -ne 0 ]; then
#   echo "Please run as root (sudo)."
#   exit 1
# fi


declare -A protocols=(
  ["DHCP"]="udp port 67 or udp port 68"
  ["DNS"]="port 53"
  ["FTP"]="port 21"
  ["HTTPS"]="tcp port 443"
  ["SMB"]="tcp port 445"
  ["mDNS"]="udp port 5353"
)


echo "Select the protocol you want to capture:"
select proto in "${!protocols[@]}" "Quit"; do
  case $proto in
    "Quit")
      echo "Exiting..."
      exit 0
      ;;
    *)
      if [ -n "${protocols[$proto]}" ]; then
        echo "Selected protocol: $proto"

        
        read -p "Enter your network interface (e.g., eth0, ens33, any): " iface

        
        read -p "Enter capture duration in seconds (default: unlimited): " duration

        
        output_file="$HOME/wireshark_captures/${proto}_capture_$(date +%Y%m%d%H%M%S).pcapng"

        
        if [ -z "$duration" ]; then
          tshark -i "$iface" -f "${protocols[$proto]}" -w "$output_file"
        else
          tshark -i "$iface" -f "${protocols[$proto]}" -a duration:"$duration" -w "$output_file"
        fi

        echo "Capture complete! Saved as: $output_file"
        exit 0
      else
        echo "Invalid selection. Please try again."
      fi
      ;;
  esac
done

