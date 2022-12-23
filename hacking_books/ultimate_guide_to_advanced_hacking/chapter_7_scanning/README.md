# Chapter 7 Scanning

## Gobuster

Gobuster is a brute force tool that can be used for different use cases within pentests or bug bounty programs. One of
Gobuster's strengths is brute-forcing directories and files on web servers. Another use case is the brute-forcing of
subdomains. There is also the possibility to identify s3 buckets and VHOSTs. In the current version of Gobuster, at the time
of writing this article, it was version 3.1, the fuzzing mode has been added. In this article, all modes of Gobuster are
presented and explained with practical examples. Gobuster is developed in the Go programming language by OJ Reeves
and Christian Mehlmauer. The project has about 6200 stars on GitHub and quite a few supporters.

Gobuster makes use of fuzzing, sending random data to test an interface. The purpose is to induce unpredicatble behaviour, maybe even crash the system.
Gobuster was as the name might suggest developed using the Go programming language. If you want to build the application from source you will have to install the Go compiler. However, we will just be using APT to install the Gobuster binary package.

### Installing Gobuster

```
$ sudo apt install gobuster
$ gobuster versions
```

```
Download Go tar package
$ wget https://go.dev/dl/go1.19.4.linux-amd64.tar.gz

Remove old version of Go
$ sudo rm -rf /usr/local/go && tar -C /usr/local -xzf go1.19.4.linux-amd64.tar.gz
$ export PATH=$PATH:/usr/local/go/bin
$ go version
go version go1.19.4 linux/amd64

$ go install github.com/OJ/gobuster/v3@latest
$ gobuster version
```

### DNS mode

Gobuster uses various modes to carry it tasks. An example might be DNS. Just type `dns` after the name of the application. `help` is also a mode, if you need help with just DNS then combine the two

```
$ gobuster dns
$ gobuster help
$ gobuster dns help
```

The DNS mode can help with finding subdomains. For example for google.com we may want to find mail.google.com

```
$ gobuster dns -f google.com
```

However, in order to find other subdomains we will have to use a wordlist. If you are using Kali Linux then your are in luck. There are a number located in /usr/share/wordlists/, if you do not use Kali then your either copy them from Kali, or collect them online or even create your own. However, for Kali there is still plenty more wordlists. Enter the command `seclists` and press `y` to install.

Lets perform some sample runs

```
gobuster dns -d google.com -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt -t 30
```

Here the switch -w refers to the wordlist we want to use and -t to the number of Go threads the application should dedeicate. The default is 10. We can alsi add the flag `-i` that will also show the IP addresses of the subdomains.

### DIR mode

Another mode is dir which as the name suggests allows us to find directories. We use the `-u` switch to define the URL of the web server.

```
gobuster dir -u http://scifiempire.net -w /usr/share/seclists/dirbuster/directory-list-2.3-small.txt
```

We might get a number of status codes indicating the resource is not accessible. To remove these result we cna use the -s and -b switches. -s is basically the whitelist while -b is the blacklist. To remove 403 and 404s change the command to the following

```
gobuster dir -u http://scifiempire.net -w /usr/share/seclists/dirbuster/directory-list-2.3-small.txt -r -b "403, 404"
```

With the -d switch we can find common backup files