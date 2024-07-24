# Homelabs

I have create a number of home labs and used them for various learning projects.  These were original setup using VirtualBox, but I have switched to VMWare Wokstation 17 to manage my VM and labs.

- gemini-setup.sh
This script is for setting up a new environment for pentesting with some of the tools that I like
- gethubdownload.py
Is a dependency for the gemini-setup.sh script
-lsd_bashzsh_aliases.txt
This is the list of LSD aliases for bashrc or zshrc

## Scripts
The gemini-setup.sh script is for setting up a virtual machine, like MX Linux, with some of the base tools that I like to have installed with any linux virtual or physical machine.  The githubdownload.py file was borrowed from [IppSec's Parrot Build Repo](https://github.com/IppSec/parrot-build)
## Labs

### Docker Playground
I have setup a Pop-OS VM running various docker images.  I have been experimenting with the various use cases for docker in my InfoSec learning including the straightfoward examples like bWAPP.  I have also setup some docker images to assit with [Pentesting](https://blog.ropnop.com/docker-for-pentesters/)

### Metasploitable 2
I setup this older VM with pfSense firewall VM to play around with attacking a machine through a firewall like pfSense as well as to be able to drop in other machines on this same network.  | **UPDATED** : [Reference here](https://github.com/Nexxsys/PandI/blob/main/InfoSec%20Projects/README.md)
