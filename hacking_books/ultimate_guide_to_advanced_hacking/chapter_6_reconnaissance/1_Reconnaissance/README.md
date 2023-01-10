# Chapter 6 Reconnaissance

## Network Exploration vs Web Exploration
This chapter is divided into two parts. The first focuses on network exploration, the act of discovering as many systems connected online that can be traced to a company or a person. Basically, it comes to finding as many IP addresses, or IP ranges as possible. The second part, web exploration, specifically is about extracting information from websites and domains. The second part includes fingerprinting and gathering information on target websites. While the first part is considered passive, in that never should a single data packet reach the target, the second part is active. You are sending data packets to the target and thus because of intentions might be violating laws in certain jurisdictions.

With Reconnaissance, look for the following pieces of information:
 - Usernames, profile names and or email addresses
 - Passwords: private keys, PINs etc
 - Domain names
 - Host names
 - IP addresses
 - Software and OS types, names and versions
 - Technical documentation, such as guides for systems.
 
You can manually trawl through source or use a tool. But the following are interesting places.
 - Personal websites, blogs
 - As many search engines as possible (Google, Bing and DuckDuckGo)
 - Social media: LinkedIn, Facebook, Twitter and Instagram
 - Other account: GitHub, forums, newsgroups etc
 - Public databases: ICANN, domain name registrars etc

A lot of what you will do in this chapter is related to DNS, or Domain Name System, the mechanism with which hostnames are translated to IP addresses. DNS will return repeatedly as tne topic of this chapter, so you might as well something about it.

``` 
DNS: Domain Name System
```

## Manual Network Exploration

There are plenty of tools available that will trawl all available information on a target for you.

### Dig
If you know the target’s name and domain then you can use Dig to lookup its IP address.
Dig is included with most Linux distributions, so simply type in the command into the Terminal with the target domain name appended. The output you get should be similar

### ARIN Search
There are also online resources we can consult. Large companies are likely to reserve IP ranges, they do so with ARIN or the American Registry of Internet Numbers. Using WHOIS we can perform a lookup on a company name and check what ranges they own.

### Google Dorks
Google is a fantastic search engine, and you can definitely use it to perform reconnaissance on your target. So called ‘dorks’ are the more advanced filters you an apply on a search query. Let’s use them to try and map the active subdomains of our target
To obtain only the result from within a target domain, prefix you search string with the following

site:target-url.com

#### site:

to limit our search result to strictly those of the target we prepend 'site:' to the name. So only results directly found on the target are listed. This is an invaluable filter, but don't limit yourself needlesly.

site:[target_url]

As you can see all search results originate from [target_url]. But we can be more specific

#### intext

#### filetype

This is probably the most useful filter. We can limit our results to just files located on the website. Common options include 'pdf', 'txt', 'doc', 'xls', 'ppt'. Basically any extension in use including code files. There is a good chance you find a long forgotten powerpoint (ppt) presentation containing way too much information!

Of course you can chain together these filters. If you get too many results you can add the intext filter

#### inurl

If you are not certain about the name of the target you can use inurl: to perform a larger search. For example, inurl:gov return every website tht has gov in its hostname. That includes '.gov' and 'gov.uk'

As test I ran the following search and I found way more than I though possible.

``` 
inurl:gov filetype:doc intext:"default password is"
``` 

We can also turn the 'inurl' dork on its head and add a minus to signal we want to filter out those results. We can remove those such as www

``` 
site:target-url.com -inurl:www
```

### DNSDumpster
This is a fantastic little website that allows you to find related subdomains and corresponding IP addresses. Large companies especially will have a multitude of those. Some might not be secured properly because they were only meant for testing.

### Hacker Target
With Hacker Target we can perform an easy search for subdomains and reverse DNS lookups. We can use their API to directly get the result
https://api.hackertarget.com/reversedns/?q=target-url.com

### Shodan 
Shodan is a search engine for internet connected devices. It queries every IP and its ports. It offers a lot of freedom for filtering for information
Automated Network Exploration

### SpiderFoot
SpiderFoot is an easy to install and use opensource automated intelligence gathering tool. It integrates numerous sources such as Shodan, VirusTotal and Censys. There is also a premium version, which we will discuss later.

```wget https://github.com/smicallef/spiderfoot/archive/v4.0.tar.gz
tar zxvf v4.0.tar.gz
cd spiderfoot-4.0
pip3 install -r requirements.txt
python3 ./sf.py -l 127.0.0.1:5001
```

As you can see installing SpiderFoot is very easy, as it is a community supported you can even make our own changes, or use part of the tool for your own benefit.
After navigate to localhost port 5001 (127.0.0.1:5001) you can start a new scan. Selecting the All option is the shotgun approach, the last of the four options: passive, will mean you remain mostly undetected.

### Recon-NG

## Web Exploration

### HTTrack
This is a simple tool ith which you can download websites. Afterwards it is possible to run the website locally so you can peruse it for weaknesses offline at your own leisure. While the tool is simple to use there are some limitations. A lot of websites are big, filled with Gigabytes of data. This tool is more suitable to download and emulate personal and hobbyist webpages. For ease of use HTTrack also comes with a GUI version, WebHTTrack. So lets first install them on Ubuntu.

Afterwards it is easy to start the software, just type in webhttrack without sudo.

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

## People Hunting

### PIPL
### EagleEye
### OSINT.rest
### Data Viper
