# Chapter 5 Programming

## Introduction

Programming is an absolutely necessary skill to have as a hacker. Yet, these days many that want to become hackers can hardly do it. There are two reasons for that, one bad and one good (sort of). The first, bad reason, is as you may have guessed the fact that there many hacking tools ensuring would-be hackers never learn the requisite skills, these are the so-called script kiddies. The second reason is that many that venture into the field of hacking do so from another field altogether. They learn computer configuration, network configuration without getting their hands dirty with the command or scripting. This chapter assumes you already know how to program applications. If not, well I added primers for both Python and C++ but I am uncertain how useful they are. 
This chapter is divided into two parts. In the first we use Python to create several small applications to get you started with the idea of creating your hacking applications or be able to modify those of others. If you already know how to program some of the applications may seem basic but I will bet you have never created proper hacking applications. So, see these are starter code. The second part focuses on programming in C++. This requires compiling and debugging. Both are requisite for detecting and creating malware. So lets get started.

## Part 1. The Basics of Programming

### A Primer on Python

In this part the book will be covering the Python programming language. The text does assume you are at least familiar with programming. If not, you can still proceed but you will have a harder time and perhaps require additional sources for learning. That said, I do discuss the basics before proceeding with the pitfalss of Python followed by some coding examples typically used by hackers and cybersecurity specialists.

Python is a scripted language, what does means is it does not require compilation into a machine language as something like C. As it uses precompiled parts carried out in a sequential order Python applications are typically slower as compilers optimize the machine language. The plus sides are numerous: easy memory handling, low entry barrier and no compiling. Python can be used for just about anything, it is very popular to create little scripts for data cleaning or to experiment but business applications are also certainly made with Python. So lets get started with Python.

Assuming you are either running Ubuntu or Kali Linux Python will already have been pre-installed on your operating system. Only recently did the language switch from version 2 to 3 after co-existing for nearly 20 years. To check which version of Python you are running just type in the following command into the Terminal.

```
 $ python --version
 Python 3.10.7
```

What you should see is a single line that outputs which version of Python you are running. You might also get an error message suggesting you type in 'python3' instead, this means you have not set the alias properly. This is not a big deal but it will mean you have to remember to use 'python3' before running any program instead of just 'python'. If you want to change the alias then run the set of commands below.

```
 $ alias python='/usr/bin/python3.10'
 $ . ~/.bashrc
 $ python --version
```

Running a Python program is easy. Code will need to be entered into a file marked with a .py extension. Lets create a simple one-line applciation.

```
 $ touch hello_world.py
```

Using your favorite text editor (Gedit, nano or vim) enter the following line and save the file.

```
print("Hello, world!")
```

You are now all set to run it. You can check the files content with cat if you want to. Lets try and run the application, remember you always have to use the python prefix to any program written in the language, and the program needs to have the .py extension.

```
 $ python hello_world.py
Hello, world!
```
It can be that easy. The program uses the built-in function print() to print anything to the console that we have written between double or single quotes. There is no need to import such a built-in function. As python is a scripted language we can also run code straight from the Terminal using the Python Interactive Shell. Simply type in 'python' into the Terminal.

```
 $ python
Python 3.10.7 (main, Nov 24 2022, 19:45:47) [GCC 12.2.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> 
```

There is now a cursor waiting for you in which you can type any Python code possible, often used for debugging. Just type in some code and press Enter.

```
>>> print("Two plus two " + " equals four")
Two plus two equals four
```

I will be using the Python Interactive Shell to showcase the langauges basic syntax, it saves me the trouble of creating new programs for every feature.

#### Variables and data types

A variable is a little piece of data storage, basically it is a name associated with a piece of memory. Lets create the following variable 'hello_str'
```
>>> hello_str = "Hello, world!"
```
I have created the variable named 'hello_str' and assigned a value, in this case the string "Hello, world!". String are always encased in either single or double quotes, as mentioned above. Other data types are not. A number or a Boolean type. The latter always has either the value True or False.

```
>>> hello_int = 21
>>> hello_bool = True
```
These variables will have a value as long as the interactive shell is running, or if used in an application as long as the application is running. They exist in memory, ready to be whenever we want. Lets experimemt a little.

```
>>> print(hello_int)
21
>>> print(hello_bool)
True
>>> print(hello_str + hello_bool)
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: can only concatenate str (not "bool") to str
```
Aah, now we have our first error. We tried to use the plus sign to concatenate two variables, but as they were different types Python had no idea what you meant and it gave back a TypeError. Python requires explicit data type conversion. Using the str() or string function just about anything can be converted.

```
>>> print("test" + str(6))
test6
```
Note that we used one function within a another, this is not a problem and it is called encapsulation. It is similar to basic math evaluation. The innermost function is evaluated first and the order is from left to right.

Python has next to its primitive data types also container types: list, tuple and dictionary. Except for list they are immutable, meaning they cannot change their value. You would have to replace them to change them. Each of the data type remains ordered and they can contain any data type as values, including other container types. Below are a set of examples.

```
>>> hello_list = ("1", "2", "3")
>>> print(len(hello_list))               # as you may guess len() counts the number of items in a container
>>> hello_list.append("4")               # with append you can add another item
>>> print(hello_list)
1 2 3 4
>>> print(hello_list[0])                 # select item with index 0, that would be the firts element "1"
1

```
So far our little code lines have been simple, but programs are supposed to be good at making choices depending on values. Lets try that.


### The Problem with Python

### Writing Clean Code

### Network Sockets

### Web Scraping

### Test Code with Python

## Part 2. Beyond the basics, debugging and exploits with C

### Compile a C program

The C programming language was considered high-level when it was introduced, meaning programmers were far removed 
from accessing the underlying the system. This was in contrast with Assembly which requires programmers to directly 
access memory registers. Some programmers snubbed their nose at C, but with efficient libraries that are partly 
written in Assembly the C programming language is effective, and a lot easier to program or master than Assembly. 
Learning both C and Assembly is useful for debugging and creating malware. Using other high-level languages such as 
Java or scripted languages such as Python and Bash are more useful for creating hacking tools. Exploits are 
typically written in C or Assembly and delivered with a script written in Python, Perl or Bash. As such it is vital 
to learn C.

That was my little introduction to C, a programming language vital for many system but more often underestimated as 
archaic. In this section of the chapter I want to achieve several things:
 - Instruct you on the basics of the C programming language, how to write a program, compile it and run it
 - Explain how computer memory works and how this relates to a program written in C.
 - Debug a program written in C with gdb
 - Attempt at reverse engineering a C program

That is a lot of ground to cover, but it is a vital setup for the other chapters such as those covering malware and 
threat hunting. I won't be covering all the syntax of C, I think you will either know it or learn that from a 
different resource. Let's dive right into it with a proper example program.

```
$ gcc c_program.c -o c_program
$ ./c_program
```

### Automating the boring the stuff
### Creating a little web server
After going through the sections on Python, C and Bash you should be able to create some decent programs. Depending on your prior experience with creating applications this should go quickly or not. Let me explain, by now you should have the knowledge to create applications but you may be lacking the drive to set out to do so. As such I end this chapter with one last project that I hope will illustrate just how easy it is to create a web application, something that has so far not come to the fore. This application, once again written in Python uses the Flask framework to server the actual web pages and a PostgreSQL database to store user information. As such it is an example of a full stack application. I set a goal to get this done in 20 pages, lets see if I succeed.
