# Setting up your wireless adapter 

The first step of collecting wireless frames for a target AP is to set up your wireless adapter into Monitor mode. The steps below show how that is done for Kali Linux and Ubuntu, both used as virtual machines using VMWare.

## Obtain information on your wireless adapter

You have a choice of either using your builtin NIC (Network Interface Card) or one connected as an external USB device.

If you chose the latter then you can if the device is attached with the following commands.

`# lsusb     # list all USB connected devices`

You should see your wireless adapter, though perhaps not under the name you would think. Probably the chip manufacturer is used instead such as Ralink.

In case your VMWare network is down use the following command

`# service NetworkManager start`

## Change wireless adapter interface (OPTIONAL)
```
 $ sudo ip -a link              # reveals the MAC address of your wireless adapter, useful for if you want to change it
 $ sudo iwconfig                # set and view parameters of wireless interfaces as seen by the OS
 $ sudo iwlist channel          # provides detailed  information on the capabilities of the wireless device, in this case the frequency channels are listed
 
 # Change the name of the wireless adapter interface, use 'ifconfig [current_interface_name] down' to force it.
 $ sudo ip link set [current_interface_name] name [name_to_be]`
```
The command 'iwlist' will also list information regarding encryption capabilities, transmission rates and power levels.

## Configuring the wireless adapter for Monitor Mode

First bring the wireless adapter down

`$ sudo ifconfig [interface_name] down`

Then kill any interfering processes with the program we will be using to listen to AP

`$ sudo airmon-ng check kill` 

Then start the wireless adapter in monitor mode

`$ sudo airmon-ng start [interface_name]`

## Now listen to Access Points and connected clients

`$ sudo airodump-ng [interface_name]`

You should see a list of Access Points organized according to BSSID which are the 24-bit MAC addresses of those APs. 
Below the list of APs there can also be a list of connected clients organized according to AP BSSID and client station which is the MAC address of those wireless adapters.

You are now set to attempt password cracking either using the four-way handshake or the PKMID attack method.
