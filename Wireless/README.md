# Wireless hacking

## Setting up Ubuntu

While using Kali Linux for cracking Wi-Fi passwords is pretty good, a lot of pentesters will prefer to continue using Ubuntu, or another distro.

### Installing Aircrack-ng
```
sudo apt-get update
sudo apt-get install -y aircrack-ng
```

### Installing Hashcat
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