# Chapter 6 Reconnaissance

Before being able to hack a target we need to know as much we can about it. It may surprise you, or it may not, that for most targets a lot of information can be found online, even with a simple Google search. These days most time spent penetration testing a target will go into reconnaissance. If done properly, and it being fruitful, finding possible vulnerabilities will be relatively easy. While performing reconnaissance as described in this chapter it is vital to understand the difference between passive and active recon. Only during the latter are packets actively being sent to the target. It is something you may well want to consider delaying until you have gathered all publicly available information on the target. It is also important to note that the online resources you consult may well keep a record of your search. Were you logged into Google while searching for that Excel file on the target website? That may be hard to deny if you are standing in court. Were possible, cover your tracks, use TOR, VPNs and browsers in private mode. 

Let's get started

## Network Exploration vs Web Exploration

This chapter is divided into two parts. The first focuses on network exploration, the act of discovering as many systems connected online that can be traced to a company or a person. Basically, it comes down to finding as many IP addresses, or IP ranges as possible. The second part, web exploration, specifically, is about extracting information from websites and domains. The second part includes fingerprinting and gathering information on target websites. While the first part is considered passive, in that never should a single data packet reach the target, the second part is active. You are sending data packets to the target and thus because of your intentions you might be violating laws in certain jurisdictions.

With Reconnaissance, look for the following pieces of information:
 - Usernames, profile names and or email addresses
 - Passwords: private keys, PINs etc
 - Domain names
 - Host names
 - IP addresses
 - Software and OS types, names and versions
 - Technical documentation, such as guides for systems.
 
You can manually trawl through a source or use a tool. But the following are interesting places to look.
 - Personal websites, blogs etc
 - As many search engines as possible (Google, Bing and DuckDuckGo)
 - Social media: LinkedIn, Facebook, Twitter and Instagram
 - Other accounts: GitHub, forums, newsgroups etc
 - Public databases: ICANN, domain name registrars etc

A lot of what you will do in this chapter is related to DNS, or Domain Name System, the mechanism with which hostnames are translated to IP addresses. DNS will return repeatedly as a topic of this chapter, so you might as well know something about it.

``` 
DNS: Domain Name System
```

## Manual Network Exploration

There are plenty of tools available that will trawl all available information on a target for you.

### Dig
If you know the target’s name and domain then you can use Dig to lookup its IP address.
Dig is included with most Linux distributions, so simply type in the command into the Terminal with the target domain name appended. The output you get should be similar to the one you ee below. [HOSTNAME] and [IP_ADDRESS] are the variables you will enter or see returned

```
$ dig [HOSTNAME]

; <<>> DiG 9.18.12-1ubuntu1.1-Ubuntu <<>> [HOSTNAME]
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 58822
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;[HOSTNAME].		IN	A

;; ANSWER SECTION:
[HOSTNAME].	5	IN	A	[IP_ADDRESS]

;; Query time: 15 msec
;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
;; WHEN: Mon Aug 07 09:34:02 CEST 2023
;; MSG SIZE  rcvd: 60
```

### ARIN Search
There are also online resources we can consult. Large companies are likely to reserve IP ranges, they do so with ARIN or the American Registry of Internet Numbers. Using WHOIS we can perform a lookup on a company name and check what ranges they own. Whoise is usually already installed on Kali Linus, but if you are using something like Ubuntu then Apt is your friend.

```
$ sudo apt install whois
$ whois google.com
```

### Google Dorks

Google is a fantastic search engine, and you can definitely use it to perform reconnaissance on your target. So called 'keyords' are the more advanced filters you can apply on a search query. Dorks can be used to map the active subdomains of our target, or to find compromising files, web pages vulnerable to SQL onjection attack and much more. But first lets get started on the basics. The following list are the most common keywords, they require a semicolon (:) between them and the search terms.

 - site: Google will restrict your search to the site or domain specified
 - filetype: Google restrict your search to those pages that have the filetype specified
 - link: shows only yhe sites that link to the specified URL
 - inanchor: search terms need to be in the website anchor
 - intext: search terms need to be in the text on the URL
 - intitle: search terms need to be in the title
 - inurl: search terms need to be in the url

The last four keywords also come in a special variant, with the prefix 'all', so allinanchor, allintext, allintitle, allinurl etc. As you may guess all the specified search terms need to be in the area designated by the keyword. But first lets give the vanilla keyword a try. Note down a couple of potential targets for you to investigate and go over them one by one using the examples below as guidance. Don't forget you can chain together keywords, in the case of filetype you will almost certainly have to.

#### site:

To limit our search result to strictly those of the target we prepend 'site:' to the URL. So only results directly found on the target are listed. This is an invaluable filter and I use it often. However, but don't limit yourself needlesly, perhaps another URL have information on your target.

site:[target_url]

As you can see all search results originate from [target_url].

#### filetype:

This is probably the most useful filter. We can limit our results to just files located on the website. Common options include 'pdf', 'txt', 'doc', 'xls', 'ppt'. Basically any extension in use including code files. There is a good chance you find a long forgotten powerpoint (ppt) presentation containing way too much information!

Of course you can chain together these filters. If you get too many results you can add the intext filter

#### intext:

With 'intext' we can scan the contents of the target. This is often not useful in finding insecured portals, but it may yield clues nontheless

site:[target_url] intext:"curriculum vitae"

Note the two quotes, basically this turn intext into version of allintext, except the latter requires the keywords to be on the webpage but not in a particulur order.

#### inurl

This is probably the most useful search keyword. Not only can be find subdomains with it we can find those with specific vulnerabilities. Have a look at the examples below

[target_url] inurl:email.xls
[target_url] inurl:index.php?id=

The possiblities are endless. However, you can also search for websites that specifically vulnerable by limiting yourself to just the inurl keyword. Just remove your target url. The same trick can be used with every single keyword from Google. An example, inurl:gov return every website tht has gov in its hostname. That includes '.gov' and 'gov.uk'. As test I ran the following search and I found way more than I though possible.

``` 
inurl:gov filetype:doc intext:"default password is"
``` 

We can also turn the 'inurl' dork on its head and add a minus to signal we want to filter out those results. We can remove those such as www. Again this can be applied to any of the keywords.

``` 
site:target-url.com -inurl:www
```

A final note on Google keywords, or Dorks as they are known. While Google is now limiting the ability to perform 'mailicious' searches there is often plenty of information available. Youy may well keep that in mind of you are on the Blue Team. Save yourself a lot of embarrassment and do look up the targets your are defending or maintaining. It only takes one Excel file or forgotten test server to undo your entire defenses.

### Netcraft

Netcraft is from the UK and tracks data regarding web servers. The paid service offers users incredible insights 
into who is the most reliable hosting company or what the market share is of a particular vendor. However, you can 
also find information regarding particular websites, such as your target URL.

You can do this from the homepage of Netcraft. About two-thirds of the way down you will see the label "What's that 
site running?". After entering your target you will get an overview that will make many other tools superfluous.

### Whois

Whois is more old-school, you can in fact just run it from your Terminal. Whois comes packaged with Kali, if your 
are using Ubuntu you will have to use your favorite package manager to install it. Afterward usage is easy, just 
type in whois with your target url.

```
whois [target_url]
```

The information that your can find are of the person or entity that has registered that domain. Information includes 
the nameserver, registrar, contact name, address, phone number and email address. However, most hosting companies 
now provide a service whereby this information is anonymized, and it merely shows the contact details of the hosting 
company. Considering that hosting companies such as Hostinger.com only require an email address which could be 
specifically created just to register the amount of information might be limited.

However, some domain are old and in the past might have been associated with genuine information on people. Whois 
does not provide such a 'wayback' option, but some tools do.

### DNSDumpster
This is a fantastic little website that allows you to find related subdomains and corresponding IP addresses. Large companies especially will have a multitude of those. Some might not be secured properly because they were only meant for testing.

### Hacker Target
With Hacker Target we can perform an easy search for subdomains and reverse DNS lookups. We can use their API to directly get the result
https://api.hackertarget.com/reversedns/?q=target-url.com

### Shodan 
Shodan is a search engine for internet connected devices. It queries every IP and its ports. It offers a lot of freedom for filtering for information
Automated Network Exploration

### SpiderFoot
SpiderFoot is an easy to install and use opensource automated intelligence gathering tool. It integrates numerous sources such as Shodan, VirusTotal and Censys. There is also a premium version, which we will discuss later. For this chapter we will only be using the application as a passive tool, performing recon on ip addresses, hostnames and people without sending packets to the first two targets.

```
wget https://github.com/smicallef/spiderfoot/archive/v4.0.tar.gz
tar zxvf v4.0.tar.gz
cd spiderfoot-4.0
pip3 install -r requirements.txt
python3 ./sf.py -l 127.0.0.1:5001
```

As you can see installing SpiderFoot is easy, as it is a community supported you can even make our own changes, or use part of the tool for your own benefit.
After the last Python command confirms the application is running navigate to localhost on port 5001 (127.0.0.1:5001) using your browser. Without further ado select "New scan". Selecting the All option is the shotgun approach, the last of the four options: passive, will mean you remain mostly undetected. We of course select the last option

### Recon-NG

## Web Exploration

### HTTrack
This is a simple tool ith which you can download websites. Afterward it is possible to run the website locally so you can peruse it for weaknesses offline at your own leisure. While the tool is simple to use there are some limitations. A lot of websites are big, filled with Gigabytes of data. This tool is more suitable to download and emulate personal and hobbyist webpages. For ease of use HTTrack also comes with a GUI version, WebHTTrack. So lets first install them on Ubuntu.

Afterward it is easy to start the software, just type in webhttrack without sudo.

```
$ webhttrack
```

You will have to click through some settings, it will probably set Chrome to be used as default (not cool, but what can you do?). Then select English as the default, now you can set your project name, choose something relevant to the website you want to emulate. Next you can set the website or set of websites you can to emulate, enter a small one of your choosing. Next change some of the settings. In Flow Control ensure the value for 'Maximum External Depth' is set to 0, this prevents a never ending download. Keep 'Maximum Depth' empty as that will ensure all files and links are downloaded. However, if it is a large website you may want to change this parameter. Next in Spider select the 'No Robots rule' otherwise it will follow the rules from robots.txt which may prevent website downloads completely.

Another option you may want to check in 'Flow Control' is 'N# Connections', this will regulate the number of simultaneous connections used to download the website. A higher value will speed up the process but may impact the website performance, and somebody may notice. The maximum value would be about 10. Finally, there are some options in 'Experts Only', set value of  'Global Travel Mode' to 'Stay On The Same Domain'

```
sudo apt-get install httrack webhttrack
```

If a website uses a CMS such as Wordpress then this tool will not copy that whole system, instead it will link the various webpages on its own accord. The result will look like the original website, but it really is just a set of pages. Login won't work, but there should be a login page and any other hidden pages the tool may have found. As such this is an excellent recon tool on small pages.

### Intrigue.io

## Digging For Gold

### Metagoofil
### Recon-NG metadata modules
### TheHarvester
### Shodan

## Final Words
Reconnaissance is a very large topic, too large to be covered in one chapter or even one book. It is also the most difficult step. I often get stuck performing a recce on a target because I feel I do not have enough information to proceed, the same goes for the next chapter on Scanning.

If you feel stuck, just proceed to the next step. Hacking is an iterative activity, and you will frequently need to come back to redo or at least verify some steps. Finally, I want to point out the larger world of OSINT, or Open-Source Intelligence of which reconnaissance forms a part. I have a whole separate chapter written on (Chapter 18) which points out that it may be possible to find the very compromising information on a target you were looking for without having to hack the target.

## Resources
 - Vinny Troia (PhD) (2020). Hunting Cyber Criminals: A Hacker's Guide to Online Intelligence Gathering Tools and Techniques. John Wiley & Sons, Inc.
