#!/bin/bash

#interface_name=""

##############################################################################################################

f_banner(){
echo
echo "

    ██     ██ ██       ███████ ██      ██████ ██████   █████   ██████ ██   ██ ███████ ██████
    ██     ██ ██       ██      ██     ██      ██   ██ ██   ██ ██      ██  ██  ██      ██   ██
    ██  █  ██ ██ █████ █████   ██     ██      ██████  ███████ ██      █████   █████   ██████
    ██ ███ ██ ██       ██      ██     ██      ██   ██ ██   ██ ██      ██  ██  ██      ██   ██
     ███ ███  ██       ██      ██      ██████ ██   ██ ██   ██  ██████ ██   ██ ███████ ██   ██

                                 Developed By The Winter Soldier "
echo
echo

}

##############################################################################################################

## Functions

setup_wireless_adapter() {
  echo
}

do_four_way_method() {
  echo
}

do_pmkid_hashcat() {
  echo
}

crack_password() {
  echo
}

install_dependencies() {
  echo "Install all dependencies required for this script"
  echo "1. Aircrack-NG"
  sudo apt install aircrack-ng
}



select_wireless_nic() {
  interface_name=$(iwconfig 2>&1 | grep ESSID | sed 's/\"//g' | cut -f1  -d" "  )
#  mac_address=$(sudo ip -a link | grep $interface_name | sed 's/\"//g' | cut -f1  -d" " )
}

set_monitor_mode() {
  sudo ip link set $interface_name down
  sudo iw $interface_name set monitor none
  sudo ip link set $interface_name up
  select_wireless_nic
}

change_mac_address() {
  echo
}

check_wireless_nic_performance() {
  echo
}

##############################################################################################################

## Wireless NIC Menu

setup_wireless_adapter() {
menu=""
until [ "$menu" = "10" ]; do

clear
f_banner

echo
echo -e "\e[34m---------------------------------------------------------------------------------------------------------\e[00m"
echo -e "\e[93m[+]\e[00m CURRENT CONFIGURATION: " "$interface_name" " with MAC: " "$mac_address"
echo -e "\e[34m---------------------------------------------------------------------------------------------------------\e[00m"
echo ""
echo "1. Select Wireless Network Interface Controller (NIC)"
echo "2. Place Wireless NIC in MONITOR Mode"
echo "3. Change MAC Address Wireless NIC"
echo ""
echo "0. Back"
echo

read menu
case $menu in

1)
clear
f_banner
select_wireless_nic
sleep 2
;;

2)
clear
f_banner
set_monitor_mode
sleep 2
;;

3)
clear
f_banner
change_mac_address
sleep 2
;;

0)
break
;;

*) ;;

esac
done
}



##############################################################################################################

## Automatic scan (no menu)



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
echo "1. Setup Wireless NIC"
echo "2. Four-Way Handshake method"
echo "3. PMKID Hashcat method"
echo "4. Password cracking"
echo "5. Install Dependencies"
echo ""
echo "0. Back"
echo

read menu
case $menu in

1)
clear
f_banner
setup_wireless_adapter
;;

1)
clear
f_banner
do_four_way_method
;;

1)
clear
f_banner
do_pmkid_hashcat
;;

1)
clear
f_banner
crack_password
;;

5)
clear
f_banner
install_dependencies
;;

0)
break
;;

*) ;;

esac
done
