# Anonymize Traffic

## Install Proxychains & Tor
```
sudo apt install proxychains tor -y
```

## Set configuration
```
sudo gedit /etc/proxychains.conf

uncomment line 'dynamic_chain'
Add line at bottom 'socks5 127.0.0.1 9050'
```

## Start Tor service
```
sudo systemctl enable tor.service
sudo systemctl start tor.service
```

## Check status of Tor service
```
sudo systemctl status tor.service
```

## Use Proxychains command
Now we can use the proxychains command with every terminal command
```
proxychains firefox [website]

proxychains nmap -sS -sV [ip_addr]
```