# Chapter 1 Linux Administration

This chapter is intended as our first deep dive into Linux, the open-source operating system that has taken the world by storm since the creation of its kernel in the early 90s by Linux Torvalds.
Linux is different from Windows in that it is mostly command line, or Terminal, centric. Sure, these days many of its flavors come with beautiful graphical interfaces not unlike Windows or OSX but to get anything done well you will inevitably need to use the command line.
This chapter assumes you are capable of using the command line and that you have entered commands plenty of times prior. However, like most casual Linux users learning more than the basics is vital if you want to make the most of the opportunities available. This chapter will attempt to teach you the Linux command line and operating system from the point of view of an administrator. This will be vital if you want to secure you own Linux servers and attempt to bypass security of those servers you are testing.
This book intends to let you learn by doing. As such our examination of Linux in this chapter has two practical purposes. The first is to create a hardened Linux Operating System which you can later use to deploy applications. Secondly, you will learn about potential weaknesses of a Linux Operating System should it not be properly be configured.
The hardened OS such as the one we will build is actively being used by the company I work for and has been tested thoroughly.

## Hardening

Hardening the operating system roughly means keeping up-to-date with the latest OS and software patches, installing management software and altering config files to keep the system secure. Despite this chapter being a general introduction to Linux which includes more topics than just hardening we will still follow the steps sequentially; each step will be marked. At the end of the chapter a small overview show what subsequent actions we still need to take.

## Linux Basics & The Command Line

In Ubuntu we use APT or Advanced Package Tool to keep the system up to date with patches, the tool is used through the Linux Terminal. This can be brought up with the command Ctrl+Alt+T.
By default, even as Administrator you do not have the permission to do just anything, you do not have the right privileges. Some actions can only be performed by the superuser, or root user account. As you installed the operating system you should be able to elevate commands to perform these actions. This is done by prefixing the word sudo, or superuser do, before the actual command you want to perform. Lets try this out, enter the command below and press enter.

```
$ sudo apt update
```

You will be prompted for the superuser password to be able to perform the command. If your ordinary user account is ever uncovered by someone else they will still not be able to use perform superuser tasks, thus limiting risks. If the password you entered is correct then the apt tool will perform the update. Another tasks is upgrade, which is often performed immediately after

```
$ sudo apt upgrade
```

Whereas update creates a list of available updates for each application the upgrade command actually downloads them and applies them. 
We can also elevate the users account so we do not need to type in sudo every time. Then we run the Terminal as superuser or root access, the prompt will the change to pound sign #. So dollar sign means ordinary, non-privileged user and pound sign means privileged. While it may tempting to always user root access it can be dangerous incorrect commands are immediately carried out. Try to restrict yourself to using non-privileged access and apply sudo when needed.
Back to upgrading your system. Upgrade will also install package dependencies. These may remain even after an application is removed. Perform the following two commands to remove such stale packages.

```
$ sudo apt autoremove
$ sudo apt clean
```

To install packages, use the install command (nothing highbrow here). For example, opens-ssh, which we want to use for our hardened system.

```
$ sudo apt install open-ssh
```

If you want to install more than one package just add them to the same command separated by whitespace. To remove a package, use remove

```
$ sudo apt remove open-ssh
```

## File Operations

As mentioned basically everything in Linux is a file, so we will need to read the, write to them, create new files as well as new folders and maintain them. Let’s start with reading them. The simplest, and most often used tool to read files is cat which outputs the entire content to the Terminal. Let’s start with an example, the commands update and upgrade you performed with sudo are logged in /var/log/audit.log, as the name suggests with this log file we can audit all administrative actions. In fact, the command below will show up as well because it is required to use sudo to view such a privileged file.

```
$ sudo cat /var/log/audit.log
```

## Text Editing

### Touch

### Nano

Nano is a very basic text editor that comes installed with most versions of Linux just because it is so basic and small. Supplying a Linux Distro without any kind of text editor would be problematic for a number of people if they do not know how to install software packages or make changes to files.
So knowing a little bit about Nano beyond just the basics will quickly provide dividend especially of no graphical user interface is possible.
To open a file using nano just type nano into the Terminal and followed by the filename

```
# nano test_file.txt
```

If the file does not yet exist, nano will create one. In that case Nano opens with an empty file for you to edit. The first thing you need to know is how to close the file after opening. With Ctrl-X you can do that. Note the command means press the Control key (Ctrl) and the x key. That is lower case x despite what the command depicts, so there is no point to use Shift to capitalize the x. 
Afterwards you are prompted for a confirmation. Just enter y for yes.

## User Management

User Management is an important administrative task on Linux systems. Controlling who has access to your network and who can use the system are part of hardening. Creating new users is important if you want to give people access or allow applications and services to run independently.

``` 
$ sudo adduser [USERNAME]
$ sudo deluser [USERNAME]
```

We can also decide to give the user access to sudo privileges with the command

```
$ sudo usermod -aG sudo [USERNAME]
```

Here -aG means add group, which of course will be sudo. Basically Linux groups are collections of Linux users with similar privileges. Superfluous user accounts should always be removed
Linux computers also have a hostname, a human-friendly name to identify a host. It may be necessary in case there are numerous endpoints within a network for the hostnames to be logically distinct. The hostname can be found with the hostname command (how novel)

```
$ hostname
```

Note that it is not necessary to use sudo, the hostname is hardly a secret. Hostnames can be changed, so to set them to something logically with the hostname command

```
$ sudo hostname your_hostname
```

## Permissions

The Linux permissions system is probably the most important thing you can leanr for its operating system. As everything in Linux is a file and files are associated with users it depends on the permissions set on a file whether or not you or any user you administrate can do anything. However, should you set the permissions too liberally users might damage the system, copy sensitive information and give hackers a way into the system. Thus learning how to correctly administer user and file persmissions is vital for the overall system. If you have a thorough grasp of permissions a lot of other Linux aspects will start to make more sense.

For users new to Linux incorrect file permissions are a major source of anguish. It feels that nothing might work, with the chmod command you can change file permissions for the file owner, the group members and for everybody else. It follows a numerical annotation when it comes to what a user is allowed to do. With the number 4 users are allowed to read a file, with 2 they are allowed to write to a file and with 1 allowed to execute it. These nunbers can be stacked. So the number 7 means giving a users the right to read, write and execute. Basically they are allowed to do everything with a file. So the infamous command 'chmod 777 [FILE_NAME]' assigns all right to everybody on the system. An open invitation to screw up.

So in one paragraph I have explained how inexperience or laziness can ruin a Linux system. It will take me the better part of several pages to explain how to administer file permissions correctly.

## Services

Linux has used a number of systems to control services over the years. Now systemctl is actively used to manage systemd, the init-daemon. Systemd contains all sorts of auxilliary tools that includes ways to analyze the boot process.

So you can do a lot with systemctl. Below the basics are first discussed, followed by some advanced examples. However, systemctl remains in use throughout the book, so knowing the basics are vital. 

The most common action with systemctl is starting a service

```
$ sudo systemctl start ssh.service
```

Of course you can also stop a service

```
$ sudo systemctl stop ssh.service
```

To prevent having to type in two commands you can also restart a service. This is particulalrly useful if you are also actively changing the service configuration. For SSH, this would be the file /etc/ssh/ssh_config.

```
$ sudo systemctl restart ssh.service
```

To check what the service is currently doing, you can use the status option.

```
$ sudo systemctl status ssh.service
```

For SSH you should see a description of the service. If everything is running correctly it starts with a little green circle. The description also contains vital information such as its full name, whether or not is it active, its PID so you can kill it, the MAN file and whethe or not it is enabled. This part ensures that the service will be started during boot. The commands to ensure that are simple enough, enable and disable.

```
$ sudo systemctl enable ssh.service
$ sudo systemctl disable ssh.service
```

One problem I often have with Ubuntu on VMware is that the network becomes inoperable, this happens especially when I log into a new Wi-Fi access point with the guest OS. If I were to use ping I get the following message:

```
ping: cnn.com: Temporary failure in name resolution
```

Now I have absolutely no idea what the problem is. I just know the cure

```
$ sudo systemctl restart NetworkManager.service
```

Of course I could have used both stop and start programs but restart is of course more succinct. To manage your network service there is an alternative, nmcli, which many administrators prefer.

```
$ sudo nmcli stop
$ sudo nmcli start
```

It basically does the same. Nmcli is a wrapper around NetworkManager.service and thus also offers some easy access diagnostics. Look at the man page for nmcli or use the -h switch for a smaller overview. The general keyword appears especially useful.

```
$ sudo nmcli general
```

## Processes


## Hardening

Now that you have gone through a thorough introduction to administrating Linux lets create a hardeneed version of Ubuntu. Try to work along, that will bring everything you need to know together.

### Testing the hardened system with Lynis

Before we begin it is handy to set some sort of benchmark for hardening. With Lynis we can do exactly that. Install the application and run the audit test on your Ubuntu system.


With Ubuntu you should have a score of somehwere in the low 60s. Using the guide below we cna crank that up about 20 points. No system is ever perfectly hardened, if it were you woud not be able to run any applications on it.

### Updating the system

```
sudo apt update && sudo apt -y upgrade && sudo apt -y dist-upgrade && sudo apt -y autoremove && sudo apt clean
```

### Rename the system

It is vital to ensure the system has a prop```
$ sudo apt -y install lynis
$ sudo lynis --version
$ sudo lynis audit system
```
er logical so you can easily distinguish it from others. You can either use the hostname command or change the hostname file

```
$ sudo hostname [new_system_name]
$ sudo nano /etc/hostname
```

### Adding New Users

```
$ adduser [username]
```

Optionally, you can add the user to the sudo group, but this should be limited

```
$ usermod -aG sudo [username]
```

Or add the user to a different group

```
$ usermod -aG [group_name] [username]
```

Rinse and repeat until you have set up your all your users properly.

### Allowing SSH access

First, install openssh-server

```
$ sudo apt install openssh-server
```

Lets check if it is running

```
$ sudo systemctl status ssh
```

We may need to add the service to the firewall, we will use the UFw wrapper for that

```
$ sudo ufw allow ssh
$ sudo ufw enable && sudo ufw reload
```

Next, we configure SSH to prevent root access and add users that may login

```
$ nano /etc/ssh/sshd_config
```

Uncomment the line with PermitRootLogin and ensure its value is set to no

Finally, restart SSH to ensure the configuration is used.

```
$ sudo systemctl status ssh
```

### Kicking the tires

Now that you have configured your Ubuntu lets see what the hardening score is now.

```
$ sudo lynis audit system
```
