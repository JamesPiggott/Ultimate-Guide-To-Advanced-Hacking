# 0_Basics

Here is hoping you already know the commands listed on this page. If you do not, then you have a long way ahead. An excellent reference source for beginner is [LinuxJourney.com](). Check it out if you want to steadily improve your Linux-Fu and gets some background information on this OS as well.

## The Terminal

You can open a new Linux terminal with Ctrl-Alt-T. The blinking cursor indicates you can press any command. If you regularly use more than one terminal consider using an application such as Terminator. Which can be installed usign the following commands:

```
sudo add-apt-repository -y ppa:gnome-terminator
sudo apt-get -y update
sudo apt-get -y install terminator
```

## List files

With the 'ls' command you list the files and directories of the present wokring directory. If you use it right after opening a terminal it will list those found in the HOME directory.


Examples:

$ ls
$ la -la                list all hidden files as well

## Current directory

## Changing drectories