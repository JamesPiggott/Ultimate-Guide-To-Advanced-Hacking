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

Sometimes it can be useful to create an empty file to organize your work, set correct permissions and such. With touch you can do that. Touch does not know what you intend to do with the file so you can create any name or extension for your file.

```
$ touch test.txt
```
A quick use of ls reveals the file exists. 

### Nano

Nano is a very basic text editor that comes installed with most versions of Linux just because it is so basic and small. Supplying a Linux Distro without any kind of text editor would be problematic for a number of people if they do not know how to install software packages or make changes to files.
So knowing a little bit about Nano beyond just the basics will quickly provide dividend especially of no graphical user interface is possible.
To open a file using nano just type nano into the Terminal and followed by the filename

```
# nano test_file.txt
```

If the file does not yet exist, nano will create one. In that case Nano opens with an empty file for you to edit. The first thing you need to know is how to close the file after opening. With Ctrl-X you can do that. Note the command means press the Control key (Ctrl) and the x key. That is lower case x despite what the command depicts, so there is no point to use Shift to capitalize the x. 
Afterwards you are prompted for a confirmation. Just enter y for yes.

Try to use NANO on regular basis, that wy you will get good at it. Below is a cheat sheet of useful commands:

### Navigation

- `Ctrl + A` — Go to the beginning of the line  
- `Ctrl + E` — Go to the end of the line  
- `Ctrl + Y` — Move up one page  
- `Ctrl + V` — Move down one page  

### Copy, Cut & Paste

- `Ctrl + K` — Cut the current line and store it in the buffer  
- `Ctrl + U` — Paste the content from the buffer  
- `Alt + 6` — Copy the current line into the buffer (does not remove it)

### Searching Text

- `Ctrl + W` — Start a search. Type your string and press Enter; the cursor will jump to the first match  
- `Alt + W` — Repeat the last search

### Saving & Exiting

- `Ctrl + O` — Save the file; you'll be prompted to confirm changes  
- `Ctrl + X` — Exit. If there are unsaved changes, you'll be prompted to save

### Undo & Redo

- `Alt + U` — Undo the last action  
- `Alt + E` — Redo the last undone action  

### Setting a Mark (Selecting Text)

- Press `Alt + A` to set a mark (start selection)  
- Move the cursor to extend the selection  
- Use `Ctrl + K`, `Ctrl + U`, or `Alt + 6` to cut, paste, or copy the selected text

### Miscellaneous

- `Ctrl + C` — Show the current cursor position and total line count  
- `Ctrl + J` — Justify (reflow) the current paragraph  
- `Alt + {` or `Alt + }` — Indent or un-indent the current line  
- `Ctrl + G` — Display the help screen  
- `Ctrl + L` — Refresh the screen (useful if the display gets corrupted)  
- `Alt` (by itself) — Switch between multiple open files; the cut buffer is preserved across files  
- `Alt + 3` — Comment or uncomment the current line  
- `Ctrl + _` — Go to a specific line number


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

At any given time your Linux OS can be running a large number of applications, or processes. It is easy enough to 
stop a GUI application, but if it is a background process you have no way to stop it. Unless you use the command line.

### Top

Top or (table of processes) is exactly what the name suggests, it prints out the name of all the processes 
registered with the Kernel. It is the first go-to command I use to see what is up.

```
$ top
top - 12:48:17 up  3:51,  1 user,  load average: 2.60, 2.38, 1.33
Tasks: 359 total,   1 running, 358 sleeping,   0 stopped,   0 zombie
%Cpu(s):  0.9 us,  0.1 sy,  0.0 ni, 99.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
MiB Mem :   5899.8 total,    887.1 free,   2931.1 used,   2081.6 buff/cache
MiB Swap:   2048.0 total,   1686.5 free,    361.5 used.   2655.7 avail Mem 

    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND                                                                                                                                                                                                                                
    939 root      20   0 1566408  19696    644 S   1.6   0.3   1:30.99 containerd                                                                                                                                                                                                                              
  30080 root      20   0       0      0      0 I   1.0   0.0   0:00.45 kworker/7:1-events                                                                                                                                                                                                                       
    810 root      20   0  321884   5616   4228 S   0.7   0.1   0:33.67 vmtoolsd                                                                                                                                                                                                                                    
  20208 root      20   0       0      0      0 I   0.3   0.0   0:10.59 kworker/6:0-events                                                                                                                                             
  20263 root      20   0       0      0      0 I   0.3   0.0   0:13.56 kworker/4:1-events                                                                                                                                             
  27521 root      20   0       0      0      0 I   0.3   0.0   0:08.10 kworker/3:0-events                                                                                                                                             
  29419 root      20   0       0      0      0 I   0.3   0.0   0:09.84 kworker/2:1-events                                                                                                                                             
  30192 root      20   0       0      0      0 I   0.3   0.0   0:00.26 kworker/1:1-events_freezable                                                                                                                                   
      1 root      20   0  168640   8728   5460 S   0.0   0.1   0:06.16 systemd                                                                                                                                                    
      2 root      20   0       0      0      0 S   0.0   0.0   0:00.05 kthreadd                
```

As you can see you instantly get an overview of what is going on with your system, it is certainly overwhelmign for 
anyone who does not regularly use top. Note that top refreshes every 3 seconds, also you need to use Ctrl-C to exit 
from top. So what does everything in the table mean. I personally first check out the '%CPU' and '%MEM' columns. As 
their names suggests this indicates how much CPU usage or memory a process takes from the system. Those that use the 
most CPU cycles are listed at the top in descending order. Top itself should also be listed, it is a great way to 
determine which process is hogging all of the resources.

The other columns have the following meaning
 - PID: Unique Process ID given to each process.
 - User: Username of the process owner.
 - PR: Priority given to a process while scheduling.
 - NI: ‘nice’ value of a process.
 - VIRT: Amount of virtual memory used by a process.
 - RES: Amount of physical memory used by a process.
 - SHR: Amount of memory shared with other processes.
 - S: state of the process
    ‘D’ = uninterruptible sleep
    ‘R’ = running
    ‘S’ = sleeping
    ‘T’ = traced or stopped
    ‘Z’ = zombie

Now, PID is the unique number associated with a process. We can use it to kill a process, but that is for the next 
section. The user is self-evident, it is the user that has started the process. S stands for process state. Most are 
asleep, awaiting a change brought on by the OS or by the user. Those marked with R are running. Top should be 
running and can be stopped using Ctrl-C as mentioned before. Finally, as the top list cane be very long use the UP 
and DOWN arrows to navigate through the list.

### PS

The second command in this section is ps, or process. With it we can directly control a process, usually that means 
sorting through the list of all process and then killing the one we want ended. Lets start with just a plan 'ps'.
```
$ ps

    PID TTY          TIME CMD
  30340 pts/0    00:00:00 bash
  30431 pts/0    00:00:00 ps
```

It only shows the two running processes of this user, bash indicates the command and ps the ps command itself. Again 
there are several columns of note

 - PID: again indicates the process number, should be just the same as with Top.
 - TTY: terminal type
 - TIME: duration process have been running
 - CMD: name of command that launched process

```
$ ps -u

USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
test        1969  0.0  0.0 172652  4696 tty2     Ssl+ 08:57   0:00 /usr/lib/gdm3/gdm-x-session --run-script env 
GNOME_SHELL_SESSION_MODE=ubuntu /usr/bin/gnome-session --systemd --session=ubuntu
test        1971  2.2  1.0 344676 65592 tty2     Sl+  08:57   5:29 /usr/lib/xorg/Xorg vt2 -displayfd 3 -auth /run/user/1000/gdm/Xauthority -background none -noreset -keeptty -verbose 3
test        1989  0.0  0.1 199232  9740 tty2     Sl+  08:57   0:00 /usr/libexec/gnome-session-binary --systemd --systemd --session=ubuntu
test       30340  0.0  0.0  20040  5596 pts/0    Ss   12:47   0:00 bash
test       30446  0.0  0.0  20128  3276 pts/0    R+   13:03   0:00 ps -u
```

This will show all processes belonging to the current user. It also adds some more columns that are self-explanatory 
if you have studied top

```
$ ps -A
```
List every process belonging to every user.

### kill

There is blood in the water lets kill a process. There are in fact many ways this can be done. Use the -L option to 
list them.

```
$ kill -L

 1) SIGHUP	 2) SIGINT	 3) SIGQUIT	 4) SIGILL	 5) SIGTRAP
 6) SIGABRT	 7) SIGBUS	 8) SIGFPE	 9) SIGKILL	10) SIGUSR1
11) SIGSEGV	12) SIGUSR2	13) SIGPIPE	14) SIGALRM	15) SIGTERM
16) SIGSTKFLT	17) SIGCHLD	18) SIGCONT	19) SIGSTOP	20) SIGTSTP
21) SIGTTIN	22) SIGTTOU	23) SIGURG	24) SIGXCPU	25) SIGXFSZ
26) SIGVTALRM	27) SIGPROF	28) SIGWINCH	29) SIGIO	30) SIGPWR
31) SIGSYS	34) SIGRTMIN	35) SIGRTMIN+1	36) SIGRTMIN+2	37) SIGRTMIN+3
38) SIGRTMIN+4	39) SIGRTMIN+5	40) SIGRTMIN+6	41) SIGRTMIN+7	42) SIGRTMIN+8
43) SIGRTMIN+9	44) SIGRTMIN+10	45) SIGRTMIN+11	46) SIGRTMIN+12	47) SIGRTMIN+13
48) SIGRTMIN+14	49) SIGRTMIN+15	50) SIGRTMAX-14	51) SIGRTMAX-13	52) SIGRTMAX-12
53) SIGRTMAX-11	54) SIGRTMAX-10	55) SIGRTMAX-9	56) SIGRTMAX-8	57) SIGRTMAX-7
58) SIGRTMAX-6	59) SIGRTMAX-5	60) SIGRTMAX-4	61) SIGRTMAX-3	62) SIGRTMAX-2
63) SIGRTMAX-1	64) SIGRTMAX	
```

We are interested in #9 SIGKILL. If we want to kill a process all we have to do is use option -9 and add the PID of 
that process

```
$ kill -9 [PID]

$ kill -9 30340
```

This will kill the terminal, as this PID belongs to Bash as you can see in the earlier results. The terminal can be 
easily restarted using Ctrl-Alt-T.

### NICE

Finally, there is nice, you saw the column in top as NI. Basically it prioritizes the process. The default value is 
0 but we can shift a process between -20 and 19. I rarely use NICE, but this section is only complete if I mentioned it.

## Networking

Here networking does not mean people getting into touch with each, but instead set up your machine to allow it to 
communicate with the outside world, that could mean another machine on your local network (behind a router or switch)
or a machine connected through the internet. On top of that you need to be able to troubleshoot the inevitable 
problems that arise when a network become incorrectly configured. Finally, you need to know how to keep an eye out on 
your network and what information is passed around. You never know, you may be the victim of hacking yourself.

Now in chapter 3 you will learn all the basics a would-be hacker should know about networking: protocols, subnetting etc. This section of chapter 1 focuses on the basic commands available to you on Linux, commands you probably already use but here we do a deep dive and put everything together so you can use them as a Linux Administrator would. Lets get into it.

### ping

The ping command is such a lame introduction, but nearly everybody uses it to check if their network is still alive. 

```
ping [IP_ADDRESS]

ping google.com
```

What ping does is send ICMP echo requests to the target, in this case google.com. Ping will continue until you stop it with Ctrl-C. Below you can see that all of the packets arrived, and were responded to. Ping is so helpful to also include the IP address. Though I do not want to spoiler chapter 3 ping first sends a DNS request to discover what the IP address of the associated hostname is. Then the ICMP echo request is sent to the target, which hopefully returns a reply. 

```
┌──(kali㉿kali)-[~]
└─$ ping google.com           
PING google.com (142.251.209.142) 56(84) bytes of data.
64 bytes from ham11s07-in-f14.1e100.net (142.251.209.142): icmp_seq=1 ttl=128 time=38.5 ms
64 bytes from ham11s07-in-f14.1e100.net (142.251.209.142): icmp_seq=2 ttl=128 time=59.8 ms
64 bytes from ham11s07-in-f14.1e100.net (142.251.209.142): icmp_seq=3 ttl=128 time=40.8 ms
64 bytes from ham11s07-in-f14.1e100.net (142.251.209.142): icmp_seq=4 ttl=128 time=41.6 ms
64 bytes from ham11s07-in-f14.1e100.net (142.251.209.142): icmp_seq=5 ttl=128 time=37.4 ms
64 bytes from ham11s07-in-f14.1e100.net (142.251.209.142): icmp_seq=6 ttl=128 time=43.8 ms
64 bytes from ham11s07-in-f14.1e100.net (142.251.209.142): icmp_seq=7 ttl=128 time=39.9 ms
64 bytes from ham11s07-in-f14.1e100.net (142.251.209.142): icmp_seq=8 ttl=128 time=40.2 ms
^C
--- google.com ping statistics ---
8 packets transmitted, 8 received, 0% packet loss, time 7014ms
rtt min/avg/max/mdev = 37.380/42.737/59.758/6.679 ms
```

If you want you can start up tcpdump or Wireshark to observe these packets.

### traceroute / tracepath

Both command basically do the same thing but traceroute will probably have to be installed with apt while tracepath is now a staple with most Debian systems. Also the latter does not require root privileges. 
Both commands will show the route packets had to take between source and destination

```
root@user:/home/user# tracepath nostarch.com
```

It may not be the most useful command, it comes from a time when routing was more sensitive and could cause delay. Sadly however, a lot of hops now no longer display data, to prevent DDOS attacks close to a target.

### ifconfig

Chances are you will want to know if an IP address has been assigned to your machine. If this is not the case, it may be because it cannot connect to a DHCP server that hands out IP addresses. A DHCP server is less sexy than it sounds, even your own machien can act as a DHCP server to other machines, but often your switch or router has a built in DHCP server that allocated temporary IP addresses to machines on the local network. To connect to the internet that is enough, the switch or router will send the packets on it remembers who sent them.

Now lets ifonfig

```
ifconfig
```

You should see multiple sections, at least two and maybe three of besides a cabled connection you are also using wireless. Sections marked eth0 or wlan0 are of interest for this discussion.

```
┌──(kali㉿kali)-[~]
└─$ ifconfig
eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.233.130  netmask 255.255.255.0  broadcast 192.168.233.255
        inet6 fe80::1413:26df:fc0a:8d7  prefixlen 64  scopeid 0x20<link>
        ether 00:0c:29:21:ec:c3  txqueuelen 1000  (Ethernet)
        RX packets 45  bytes 5241 (5.1 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 69  bytes 7306 (7.1 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
```

Lets get right to it. Behind the flag marked 'inet'  you cna find your IP address. Note that it is private or local address, it starts with 192 and as uch has no validity anywhere online. The netmask marks the size of the local subdomain. The three sections marked 255 mean they are set and not under the control of the network configuration. This is proven by the broadcats address which ends with 255. With each possible subnet two private IP addresses are always reserved: the first as network ID and the last as broadcast. In this case considering the network configration spans the entirety of the last octet we can deduce that the network ID is 192.168.233.0. Finally there is also an IPv6 address and the MAC address of your NIC

With ifconfig we can directly control the NIC if we want, with the UP and Down commands.

```
ifconfig down eth0
```

If you run ifconfig again you will find eth0 is gone. And so will your internet connection be, just use pign to confirm this. If you are running your machine as a virtual machine (which I recommend) then you will not be able to switch off your NIC.

You can easily turn the NIC on again with UP.

```
ifconfig up eth0
```

### Netstat

Netstat or network statistics is an application that actively observes all internet connections on your machine, incoming and outgoing. It is very helpful in case you need to troubleshoot your connection or if you want to discover unwanted connections. While ping is fine as a canary down the coal mine it offers very little else. For proper troubleshooting Netstat is your go to program. Lets try it out.

```
netstat
```

The result may not exactly be what you expected. There is a lot of information on your screen. At any given time your machine may have dozen or even hundreds of connections. That does not mean that all will be actively transferrign data, but they may...

```
┌──(kali㉿kali)-[~]
└─$ netstat                       
Active Internet connections (w/o servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State      
udp        0      0 192.168.233.130:bootpc  192.168.233.254:bootps  ESTABLISHED
Active UNIX domain sockets (w/o servers)
Proto RefCnt Flags       Type       State         I-Node   Path
unix  3      [ ]         STREAM     CONNECTED     19535    @/tmp/.X11-unix/X0
unix  3      [ ]         STREAM     CONNECTED     18595    /run/systemd/journal/stdout
unix  3      [ ]         STREAM     CONNECTED     18592    /run/user/1000/bus
...
```

Luckily this is less bad than it looks. We got one active internet connection and then a huge number of active sockets. Let's try something. Open up another terminal and use to ping Google again. While you keep that running run netstat one more time.

I use netstat also when I want to discover the application that is using a particular port. In software development 
this is sometimes necessary when I inadvertently assign the same port number two multiple applications.

```
netstat -nlp | grep [PORT_NUMBER]
```

Here -nlp that does not mean natural language processing. Instead, the n means list using a numeric value, l means 
those processes that are listening and p means programs. So list all programs that are listening using a numeric 
filter which comes after the pipe |.

### NMCLI

Networking on Debian based syhstems such as Ubuntu and Kali is managed by the NetworkManager daemon. With nmcli network setup and configuration becomes relatively painless, and so it is a vital command to learn by heart. Consider all of the times you had or a colleague had a networking issue, now you do not have to reboot the system and hope for the best. 

```
root@user:/home/user# nmcli
```

Using the command as is without anyh kind of switch yields a result similar to ifconfig and ip addr show. You get an overview of your networking devices with associated ip addresses but in a format that is little cleaner

```
root@user:/home/user# nmcli general status

STATE      CONNECTIVITY  WIFI-HW  WIFI     WWAN-HW  WWAN    
connected  full          missing  enabled  missing  enabled
``

This shows the state of your networking along with the status of NetworkManager.

```
root@user:/home/user# nmcli device status
```

This command displays a list of all network interfaces along with their status (e.g., connected, disconnected).

```
root@user:/home/user# nmcli device wifi list
```

List only those Wi-Fi related devices

```
root@user:/home/user# nmcli device wifi connect <SSID> password <password>
```

```
root@user:/home/user# nmcli connection show 
```

Shows connection of devices. If you add the device name it will only show the details of that particular device.

Finally, the commands most people use for when nothing appears to work.

```
root@user:/home/user# nmcli networking off/on
```

## Hardening

Now that you have gone through a thorough introduction to administrating Linux lets create a hardened version of Ubuntu. Try to work along, that will bring everything you need to know together.

### Testing the hardened system with Lynis

Before we begin it is handy to set some sort of benchmark for hardening. With Lynis we can do exactly that. Install the application and run the audit test on your Ubuntu system.

```
$ sudo apt -y install lynis
$ sudo lynis --version
$ sudo lynis audit system
```

With Ubuntu, you should have a score of somewhere in the low 60s. Using the guide below we can crank that up about 20 points. No system is ever perfectly hardened, if it were you would not be able to run any applications on it.

### Updating the system

```
sudo apt update && sudo apt -y upgrade && sudo apt -y dist-upgrade && sudo apt -y autoremove && sudo apt clean
```

### Rename the system

It is vital to ensure the system has a proper logical name so you can easily distinguish it from others. You can either 
use the hostname command or change the hostname file

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

It will probably only be marginally better, to really get to above 80 we need to tackle most issues listed in the Lynis report. We will dom exactly that, using a lot of the commands we studied in this chapter.

#### Your profile contains one or more old-style configuration entries [GEN-0020]
https://cisofy.com/lynis/controls/GEN-0020/

This is a warning, which is more serious than just a recommendation. Basically it means your version of Lynis is out of date. Aptitude probably contains an older version of Lynis. We will remove and replace it with a version of Lynis pulled directly from its GitHub page.

```	  
apt remove lynis
apt-get purge lynis
apt-get purge --auto-remove lynis
```
That should have removed Lynis. Now lets download the source code and install it.
```	  
cd /usr/local
rm -rf lynis.old
mv lynis lynis.old
git clone https://github.com/CISOfy/lynis
chown -R root:root lynis
chmod 755 lynis/lynis
cd /usr/sbin
mv lynis lynis.old
ln -s /usr/local/lynis/lynis lynis
```  
If you go over the lines one by one they make sense, but I suggest you place them in a file called 'updatelynis' as you will be using it regularly. You can run it as follows.
```
sh updatelynis
```
The first time you might get an error stating the directory lynis does not exist, that makes sense. Running the script a second time should run smoothly.

#### Configure maximum password age in /etc/login.defs [AUTH-9286]
https://cisofy.com/lynis/controls/AUTH-9286/
	  
Set values to the following in the file /etc/login.defs
```
	PASS_MAX_DAYS   180
	PASS_MIN_DAYS   7
	PASS_WARN_AGE   14
```
This will set the maximum password age to 180 days, and the password cannot be reset during the first 7 days. Also 14 days before the password expires the user is given a warning when they log in.

#### Consider restricting file permissions [FILE-7524]
This is an easy one, but to get every file you will need to scour the lynis.log file. Lets give that a try. I know for a fact that the requested permission should be 750, so we can search for that
```
cat /var/log/lynis.log | grep 700
```
Sure enough the cat command spits out a number of lines, below are lines from my Kali machine.

2023-08-02 07:07:51 Found flags:    (rw nosuid relatime size=8143852k nr_inodes=2035963 mode=755 inode64) 
2023-08-02 07:07:51 Found flags:    (rw nosuid nodev noexec relatime size=1636812k mode=755 inode64) 
2023-08-02 07:08:21 Outcome: permissions of file /etc/cron.d are not matching expected value (755 != 700)
2023-08-02 07:08:21 Outcome: permissions of file /etc/cron.daily are not matching expected value (755 != 700)
2023-08-02 07:08:21 Outcome: permissions of file /etc/cron.hourly are not matching expected value (755 != 700)
2023-08-02 07:08:21 Outcome: permissions of file /etc/cron.weekly are not matching expected value (755 != 700)
2023-08-02 07:08:21 Outcome: permissions of file /etc/cron.monthly are not matching expected value (755 != 700)

As you can see 5 files do not have the correct values, for your machine they may differ but cron is definitely the usual suspect. With cron we can run any service or script as root at a specified time. It is thus dangerous that non-root users and groups should have write access. You can also alter the grep command above to find more culprits, for example for some files the access is restricted to 600.

```
chmod 600 /etc/cron.deny
chmod 600 /etc/crontab
chmod 600 /etc/ssh/sshd_config
chmod 700 /etc/cron.d
chmod 700 /etc/cron.hourly
chmod 700 /etc/cron.daily
chmod 700 /etc/cron.weekly
chmod 700 /etc/cron.monthly
```

#### Harden compilers like restricting access to root user only [HRDN-7222]
https://cisofy.com/lynis/controls/HRDN-7222/

Compilers can be dangerous as it could be a way for non-root users to bypass controls especially in conjunction with FILE-7524. The usual suspect is gcc, the generic compilers for Linux. Let's locate it with the which command.
```
which gcc

/usr/bin/gcc
```
No surprise there, 'ls -la /usr/bin/gcc' reveals it 777 access rights. We now have a choice, remove gcc but that might cause the OS to be unable to compile anything ot give it more restrictive rights. Let's do the latter.
```
apt remove gcc
```
Another culprit is the as or assembly compiler. This gets the same treatment. 

#### Purge old/removed packages (38 found) with aptitude purge or dpkg --purge command. This will cleanup old configuration files, cron jobs and startup scripts. [PKGS-7346]
https://cisofy.com/lynis/controls/PKGS-7346/

```
apt purge $(dpkg -l | grep '^rc' | awk '{print $2}')
```