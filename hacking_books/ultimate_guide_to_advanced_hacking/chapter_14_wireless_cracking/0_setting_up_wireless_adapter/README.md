# Setting up your wireless adapter 

The first step of collecting wireless frames for a target AP is to set up your wireless adapter into Monitor mode. The steps below show how that is done for Kali Linux and Ubuntu, both used as virtual machines using VMWare.

## Obtain information on your wireless adapter

You have a choice of either using your builtin NIC (Network Interface Card) or one connected as an external USB device.

If you chose the latter then you can find it if the device is attached with the following command.

`$ lsusb     # list all USB connected devices`

You should see your wireless adapter, though perhaps not under the name you would think. Probably the chip manufacturer is used instead, such as Ralink.

In case your VMWare network is down use the following command

`# service NetworkManager start`

## Change wireless adapter interface (OPTIONAL)

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

## Configuring the wireless adapter for Monitor Mode

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

## Now listen to Access Points and connected clients

Finally, lets listen which access points and clients are currently transmitting in your vicinity.

`$ sudo airodump-ng [interface_name]`

You should see a list of Access Points organized according to BSSID which are the 24-bit MAC addresses of those APs. 
Below the list of APs there can also be a list of connected clients organized according to AP BSSID and client station which is the MAC address of those wireless adapters.

You are now set to attempt password cracking either using the four-way handshake or the PKMID attack method.
