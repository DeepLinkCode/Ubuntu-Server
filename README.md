##Ubuntu-Server-20 LTS LEMP Stack
-------------------------------------------

### Setting Ubuntu Server Linux Machine on Windows

* Installing Ubuntu server automatically with provider using virtual box.
* Virtualization shoud be activated from BIOS. To check if it is activated or not then open cmd prompt type ```C:\>systeminfo```
- If you find your pc Virtualization parameters **OFF** then go to this [link on How to activate Virtualization in Windows.](https://support.lenovo.com/in/en/solutions/ht500006-how-to-enable-virtualization-technology-on-lenovo-computers) 

#### Required Tools

* Download Vagrant and install it. 
  - https://www.vagrantup.com/downloads

* Download Virtual box and install it.
  - https://www.virtualbox.org/wiki/Downloads

#### Installation

* Clone this repository 
* Change Directory to current repo.
* Use the following cmd and wait for it to provision. 
  -  ```vagrant up```
- After Install just SSH into the machine using ```vagrant ssh```

- That's all, in provison script you will find :-
    - PHP 7.2
    - Ngnix Server 
    - MongoDB 4.8
    - MySQL Server
    - Redis Server
- The Web Server is pointed to private IP : **192.168.33.12**
- Folder Name ```Code``` is synced to ```\var\www\``` Directory in Ubuntu Machine in vagrant.

####Vagrant's basic commands

- All commands should be executed inside the VDD directory.

 - > \> vagrant ssh
SSH into virtual machine.

 - > \> vagrant up
Start virtual machine.

 - > \> vagrant share
Share your virtual machine to the world via a temporary and unique url.

 - > \> vagrant halt
Halt virtual machine.

 - > \> vagrant destroy
Destroy your virtual machine. The source code and the content of the data directory will remain unchanged. Only the VirtualBox machine instance will be destroyed. You can build your machine again with the 'vagrant up' command. This command is useful if you want to save disk space.
Warning: this command will destroy your site databases. Backup them using drush sql-dump > db.sql for each site.

 - > \> vagrant provision
Reconfigure the virtual machine after a source code change.

 - > \> vagrant reload
Reload the virtual machine. Useful when you need to change network or synced folder settings.

The official Vagrant site has [good documentation](http://docs.vagrantup.com/v2/) .

#### Check Ubuntu Ofiicial Vagrant Cloud
- You can find other versions of official Ubuntu Server machines from vagrant cloud.
- [https://app.vagrantup.com/ubuntu](https://app.vagrantup.com/ubuntu)


