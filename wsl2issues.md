# wsl2 issues

---

## ISSUES-1

```sh
$ snap list
```
>> snap list field is "notes" display broken 

### SOLVATION [[ISSUES-1]]
 
#### case-one

```sh
$ git clone https://github.com/DamionGans/ubuntu-wsl2-systemd-script.git
$ cd ubuntu-wsl2-systemd-script
$ sed -i 's|self_dir="$(dirname $0)"|self_dir="$(dirname -- $0)"|g' ubuntu-wsl2-systemd-script.sh
$ sed -i 's|SYSTEMD_EXE="/lib/systemd/systemd --unit=basic.target"|SYSTEMD_EXE="/lib/systemd/systemd --unit=multi-user.target"|g' start-systemd-namespace && sudo sed -i 's|SYSTEMD_EXE="/lib/systemd/systemd --unit=basic.target"|SYSTEMD_EXE="/lib/systemd/systemd --unit=multi-user.target"|g' enter-systemd-namespace
$ sed -i 's|sudo cp "$self_dir/start-systemd-namespace" /usr/sbin/start-systemd-namespace|sudo cp "$self_dir/start-systemd-namespace" /usr/sbin/|g' ubuntu-wsl2-systemd-script.sh && sudo sed -i 's|sudo cp "$self_dir/enter-systemd-namespace" /usr/sbin/enter-systemd-namespace|sudo cp "$self_dir/enter-systemd-namespace" /usr/sbin/|g' ubuntu-wsl2-systemd-script.sh
$ ps -ef # check ps /lib/systemd/systemd --unit=multi-user.target
```
#### case-two

```sh
$ sudo apt-get update && sudo apt-get install -yqq daemonize dbus-user-session fontconfig
$ echo "sudo daemonize /usr/bin/unshare --fork --pid --mount-proc /lib/systemd/systemd --system-unit=basic.target | exec sudo nsenter -t $(pidof systemd) -a su - $LOGNAME" >> ${HOME}/.bashrc
```

---

## ISSUES-2

```sh
$ modprobe [modules]
```
>> can't find /lib/modules/$(uname -r)

### SOLVATION [[ISSUES-2]]

complie self linux kernel:
https://falco.org/blog/falco-wsl2-custom-kernel/

```sh
sudo apt install -y build-essential flex bison libssl-dev libelf-dev

git clone https://github.com/microsoft/WSL2-Linux-Kernel.git WSL2-Linux-Kernel
cd /WSL2-Linux-Kernel/
make KCONFIG_CONFIG=Microsoft/config-wsl -j8
# This compilation should take about 10 minutes or more. Don’t forget to pass the “-j” argument at the end of the command, with the number of CPU cores that your machine has, so that the compilation takes place in parallel and speeds up the process a lot.
sudo make modules_install -j8
cp arch/x86/boot/bzImage /mnt/c/Users/<username>/wslkernel/mswslkernel
vi /mnt/c/Users/<username>/.wslconfig
# .wslconfig
[wsl2]
kernel=c:\\User\\<username>\\wslkernel\\mswslkernel
localhostForwarding=true
swap=0
[user]
default = <username>
# .wslconfig END

```

---

## ISSUES-3

```sh
$ sudo /snap/bin/lxc network create lxdbr0

>> Failed adding outbound NAT rules for network "lxdbr0" (ip): Failed apply nftables config: Failed to run: nft table ip lxd

$ sudo systemctl start lxc-net.service
>> Failed to start lxc-net.service: Unit lxc-net.service is masked.
sudo lxc network edit lxcbr0
>> Error: Only managed networks can be modified
```

```sh
sudo apt install lxc-utils
sudo apt install ifupdown btrfs-tools lxc-templates lxctl

# The following additional packages will be installed:
#   bridge-utils dns-root-data dnsmasq-base libidn11 liblxc-common liblxc1 libpam-cgfs lxcfs uidmap
# Suggested packages:
#   ifupdown btrfs-tools lxc-templates lxctl
# The following NEW packages will be installed:
#   bridge-utils dns-root-data dnsmasq-base libidn11 liblxc-common liblxc1 libpam-cgfs lxc-utils lxcfs uidmap

```

---

## ISSUES-4

```sh
$ sudo snap install lxd
$ sudo lxc && sudo lxd
```
>> sudo: lxc: command not found && sudo: lxd: command not found

### SOLVATION [[ISSUES-4]]

```sh 
$ sudo visudo 
# append snap/bin to secure_path
```
>> secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:snap/bin"


## ISSUES-5

```sh
sudo lxc launch -p default -p microk8s ubuntu:20.04 microk8s

Error: Failed to run: /snap/lxd/current/bin/lxd forkstart microk8s /var/snap/lxd/common/lxd/containers /var/snap/lxd/common/lxd/logs/microk8s/lxc.conf:
Try `lxc info --show-log local:microk8s` for more info
```

