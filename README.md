# Penetration Testing Guide

This repository contains a loose array of Python applications and scripts for use with penetration testing. Most are located on the folder 'Penetration Testing' which is further subdivided into the five stages of hacking: Reconnaissance, Scanning, Exploitation, Maintenance Access and Clearing Tracks. There are further folders on topics such as Encryption, Forensics and Security.

The purpose of this repository is to aid my desire to improve my knowledge of pen testing. Using these scripts and examples I can carry them out against my own test labs.


## Reconnaissance

### Recon-ng Framework
This is a open-source intelligence gathering tool. It automates information gathering and stores it in a database.
It uses modules that can be found on a marketplace.
[Download link](https://github.com/lanmaster53/recon-ng)

$ recon-ng # to start the application
> help     # show available commands
> shell ifconfig # perform command outside recon-ng. In this case ifconfig
> marketplace search # list all modules
> marketplace search whois # show all whois modules
> marketplace install recon/domains-contacts/whois_pocs # will install the module

> modules load recon/domains-contacts/whois_pocs # start using a module
> info # shows information of the module
	



## Install the Go Programming Language
wget https://golang.org/dl/go1.16.2.linux-amd64.tar.gz
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf go1.16.2.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
source $HOME/.profile

When creating a new Go project you will need to set GOPATH to:

GOPATH=$HOME/[location_of_directory]

After that is done create three new folders inside the directory: src, pkg and bin.