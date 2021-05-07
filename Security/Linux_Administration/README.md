# Primer on Linux Administration

## System hardening

### Install and use Lynis
```
sudo apt-cache policy lynis
wget -O - https://packages.cisofy.com/keys/cisofy-software-public.key | sudo apt-key add -
echo "deb https://packages.cisofy.com/community/lynis/deb/ stable main" | sudo tee /etc/apt/sources.list.d/cisofy-lynis.list
sudo apt install apt-transport-https
sudo apt update
sudo apt install lynis

lynis audit system
```

### Install and set Auditd rules
```
sudo apt install auditd
auditctl -l | grep /usr/bin/dockerd
sudo gedit /etc/audit/audit.rules
echo '-w /usr/bin/dockerd -k docker' >> /etc/audit/audit.rules
service auditd restart
```