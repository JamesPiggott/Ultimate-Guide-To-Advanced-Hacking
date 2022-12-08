# Firewall management

## Check access control profiles
```
sudo aa-status
```

## Install gufw front-end
```
sudo apt install gufw
```
After start up you will see three profiles: Home, Public and Office.

## UFW commands
```
sudo ufw status verbose            # For detailed firewall info

# Set up default policies
sudo ufw default deny incoming
sudo ufw default allow outgoing

# To allow incoming SSH
sudo ufw enable ssh
sudo ufw enable

```