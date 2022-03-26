#!/bin/bash

ip_address=192.168.188.1
while getopts u:i: flag
do
    case "${flag}" in
        u) user_input=${OPTARG};;
        i) ip_address=${OPTARG};;
    esac
done

echo "User input: $user_input";
echo "IP address: $ip_address";


##############################################################################################################

f_banner(){
echo
echo "

    ███    ██ ███    ███  █████  ██████      ███████  ██████  █████  ███    ██ ███    ██ ███████ ██████
    ████   ██ ████  ████ ██   ██ ██   ██     ██      ██      ██   ██ ████   ██ ████   ██ ██      ██   ██
    ██ ██  ██ ██ ████ ██ ███████ ██████      ███████ ██      ███████ ██ ██  ██ ██ ██  ██ █████   ██████
    ██  ██ ██ ██  ██  ██ ██   ██ ██               ██ ██      ██   ██ ██  ██ ██ ██  ██ ██ ██      ██   ██
    ██   ████ ██      ██ ██   ██ ██          ███████  ██████ ██   ██ ██   ████ ██   ████ ███████ ██   ██

                                    Developed By The Winter Soldier "
echo
echo

}

##############################################################################################################

## Functions

icmp_echo_request() {
  SN_SCAN=$(nmap -sn $ip_address)

  IS_UP='Host is up'
  if [[ "$SN_SCAN" == *"$IS_UP"* ]]; then
    echo "Host: $ip_address is up"
    echo
  fi
}

syn_scan() {
  nmap -sS -Pn $ip_address
}

udp_scan() {
  nmap -sU $ip_address
}

os_discovery() {
  nmap -O -Pn $ip_address
}

service_discovery(){
  nmap -O -sV -Pn $ip_address
}

firewall_evasion(){
  nmap -sS -sV -F -Pn $ip_address
}

aggresive_scan() {
  nmap -sS -T4 -p- -A -Pn $ip_address
}

slow_aggressive_scan() {
  nmap -sS -T2 -A -Pn $ip_address
}


##############################################################################################################

## Automatic scan (no menu)

automatic_scan(){
  # Perform automatic scan
  echo
}

if [ "$user_input" = false ] ; then
  automatic_scan
else
  echo
  read -p "Enter target IP: " value
  echo
  ip_address=$value
fi

##############################################################################################################

## Main Menu

menu=""
until [ "$menu" = "10" ]; do

clear
f_banner

echo
echo -e "\e[34m---------------------------------------------------------------------------------------------------------\e[00m"
echo -e "\e[93m[+]\e[00m SELECT THE TASK YOU WANT TO PERFORM ON TARGET: " $ip_address
echo -e "\e[34m---------------------------------------------------------------------------------------------------------\e[00m"
echo ""
echo "1. ICMP Echo Request"
echo "2. SYN Scan"
echo "3. UDP Scan"
echo "4. OS Discovery Scan"
echo "5. Service Version Scan"
echo "6. Firewall Evasion Scan"
echo "7. Aggressive Scan"
echo "8. Slow Aggressive Scan"
echo ""
echo "0. Back"
echo

read menu
case $menu in

1)
icmp_echo_request
sleep 2
;;

2)
syn_scan
sleep 2
;;

3)
udp_scan
sleep 2
;;

4)
os_discovery
sleep 2
;;

5)
service_discovery
sleep 2
;;

6)
firewall_evasion
sleep 2
;;

7)
aggressive_scan
sleep 2
;;

8)
slow_aggressive_scan
sleep 2
;;

0)
break
;;

*) ;;

esac
done
