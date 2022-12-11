# Chapter 5 Programming

## Introduction

Programming is an absolutely necessary skill to have as a hacker. Yet, these days many that want to become hackers can hardly do it. There are two reasons for that, one bad and one good (sort of). The first, bad reason, is as you may have guessed the fact that there many hacking tools ensuring would-be hackers never learn the requisite skills, these are the so-called script kiddies. The second reason is that many that venture into the field of hacking do so from another field altogether. They learn computer configuration, network configuration without getting their hands dirty with the command or scripting. This chapter assumes you already know how to program applications. If not, well I added primers for both Python and C++ but I am uncertain how useful they are. 
This chapter is divided into two parts. In the first we use Python to create several small applications to get you started with the idea of creating your hacking applications or be able to modify those of others. If you already know how to program some of the applications may seem basic but I will bet you have never created proper hacking applications. So, see these are starter code. The second part focuses on programming in C++. This requires compiling and debugging. Both are requisite for detecting and creating malware. So lets get started.

## Part 1. The Basics of Programming

### A Primer on Python

### THe Problem with Python

### Writing Clean Code

### Network Sockets

### Web Scraping

### Test Code with Python

## Part 2. Beyond the basics, debugging and exploits with C

### Compile a C program

The next section of the book lasts about 40 pages. It uses C to explain the uses of a compiled language. Readers are taught to use GDP to debug code and use various tools to attempt to detect or create exploits.

```
$ gcc c_program.c -o c_program
$ ./c_program
```

### Automating the boring the stuff
### Creating a little web server
After going through the sections on Python, C and Bash you should be able to create some decent programs. Depending on your prior experience with creating applications this should go quickly or not. Let me explain, by now you should have the knowledge to create applications but you may be lacking the drive to set out to do so. As such I end this chapter with one last project that I hope will illustrate just how easy it is to create a web application, something that has so far not come to the fore. This application, once again written in Python uses the Flask framework to server the actual web pages and a PostgreSQL database to store user information. As such it is an example of a full stack application. I set a goal to get this done in 20 pages, lets see if I succeed.
