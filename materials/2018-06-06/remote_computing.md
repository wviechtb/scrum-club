## Remote Computing

Basically, remote computing means that we make use of a different computer than the one we are sitting in front of for carrying out our computations and analyses. This is especially useful when doing computationally intensive work, as it leaves the computer we are working with free to do other tasks. Also, the remote computer may be a much more powerful computer (faster CPU, more cores, more memory) and therefore may be able to complete the computations more quickly.

There are various setups for remote computing. A common case is having "shell access" to the remote computer that typically runs some kind of flavor of Linux/Unix. After connecting with the remote computer, one then interacts with the remote computer via a command line interface. This is the topic of today's meeting.

### SSH

In the old days, connections were typically made via [telnet](https://en.wikipedia.org/wiki/Telnet). However, telnet (by default) does not encrypt the data sent over the connection (including passwords!), which makes it rather insecure. These days, the most common method for connecting to a remote shell is via the [secure shell](https://en.wikipedia.org/wiki/Secure_Shell) protocol. SSH automatically encrypts the connection, allows for 'passwordless' login via public/private keys, and has other advantages. To make a SSH connection:

- on Windows, use a client like [Putty](https://putty.org/)
- on MacOS/Linux, use the `ssh` command on the terminal

### Bash Shell

On most Linux/Unix systems, you will get access to the (bash)[https://en.wikipedia.org/wiki/Bash_(Unix_shell)] (Unix) shell. Therefore, to make use of such computing facilities, you need to learn some basic bash commands (see previous meeting). Although possible, by default you cannot make use of software that uses a graphical user interface (GUI). The software you use for the computations (e.g., R, Python, Matlab) therefore also needs to be used via the command line.

### Editor

You can type / copy-paste commands directly into the shell, but you will often want to write scripts for the software you are using for the computations. You can edit those scripts on your local machine or directly on the remote computer. In the latter case, you will need to use an editor that can be used through the command line. Common choices for this are [vim](https://en.wikipedia.org/wiki/Vim_(text_editor)), [emacs](https://en.wikipedia.org/wiki/Emacs), and [nano](https://en.wikipedia.org/wiki/GNU_nano).

### Screen

Using the [screen](https://en.wikipedia.org/wiki/GNU_Screen) command, you can log off the remote computer and leave computations running.

A few commands we will need for this:

```
screen
screen -ls
screen -r
```

In screen:

- `ctrl-a d` to detach
- `ctrl-a c` to create new shell
- `ctrl-a n` to go to next shell

### X Server

In order to use software on the remote computer that uses a GUI, you typically will need to have an [X Server](https://en.wikipedia.org/wiki/X.Org_Server) installed on your local machine.

### Some commands we will need for the demo

```
cp /tmp/script.r ~/
```
```
install.packages("metafor")
```
```
source("script.r")
```
```
Rscript script.r
```
