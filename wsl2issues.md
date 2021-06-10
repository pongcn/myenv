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
$ sed -i 's|self_dir="$(dirname $0)"|self_dir="$(dirname -- $0)"|g' ubuntu-wsl2-systemd-script.sh && sed -i 's|SYSTEMD_EXE="/lib/systemd/systemd --unit=basic.target"|SYSTEMD_EXE="/lib/systemd/systemd --unit=multi-user.target"|g' start-systemd-namespace && sudo sed -i 's|SYSTEMD_EXE="/lib/systemd/systemd --unit=basic.target"|SYSTEMD_EXE="/lib/systemd/systemd --unit=multi-user.target"|g' enter-systemd-namespace && sed -i 's|sudo cp "$self_dir/start-systemd-namespace" /usr/sbin/start-systemd-namespace|sudo cp "$self_dir/start-systemd-namespace" /usr/sbin/|g' ubuntu-wsl2-systemd-script.sh && sudo sed -i 's|sudo cp "$self_dir/enter-systemd-namespace" /usr/sbin/enter-systemd-namespace|sudo cp "$self_dir/enter-systemd-namespace" /usr/sbin/|g' ubuntu-wsl2-systemd-script.sh
$ bash ubuntu-wsl2-systemd-script.sh
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
>> can not find /lib/modules/$(uname -r)
```


### SOLVATION [[ISSUES-2]]

Building Custom Kernel with ZFS Built In

complie self linux kernel:

https://falco.org/blog/falco-wsl2-custom-kernel/

https://forum.level1techs.com/t/building-custom-kernel-with-zfs-built-in/117464


```sh
# Enter the kernel directory
cd ${HOME}/code/WSL2-Linux-Kernel
# Check if a ZFS reference already exist in the config file
grep ZFS Microsoft/.config-wsl
# Add the ZFS reference to the end of the config file
echo "CONFIG_ZFS=y" >> Microsoft/.config-wsl
# Confirm it has been correctly added
tail Microsoft/.config-wsl
# Install the modules built with the Kernel
sudo make modules_install

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

```sh
# download the last version
https://github.com/openzfs/zfs/tags
# Install the build tools and the dependencies
sudo apt install -yqq build-essential autoconf automake libtool gawk alien fakeroot dkms libblkid-dev uuid-dev libudev-dev libssl-dev \
zlib1g-dev libaio-dev libattr1-dev libelf-dev python3 python3-dev python3-setuptools python3-cffi libffi-dev flex bison
# Enter the ZFS directory
cd ../zfs-<version>/
# Run the autogen.sh script
sh autogen.sh
# Run the configure script
./configure --prefix=/ --libdir=/lib --includedir=/usr/include --datarootdir=/usr/share --enable-linux-builtin=yes --with-linux=${HOME}/code/WSL2-Linux-Kernel--with-linux-obj=${HOME}/code/WSL2-Linux-Kernel
# Run the copy-builtin script
./copy-builtin ${HOME}/code/WSL2-Linux-Kernel
# Build ZFS
make
# Install the binaries in your system
sudo make install
# Run the command zfs to see if it's installed and show the help
sudo /sbin/modprobe zfs
zfs
# Try to see which version is installed
zfs version
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

### SOLVATION [[ISSUES-3]]
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
sudo lxc launch -p default -p mk8s ubuntu:20.04 mk8s

Error: Failed to run: /snap/lxd/current/bin/lxd forkstart microk8s /var/snap/lxd/common/lxd/containers /var/snap/lxd/common/lxd/logs/mk8s/lxc.conf:
Try `lxc info --show-log local:microk8s` for more info

sudo lxc info --show-log local:mk8s

Name: mk8s
Location: none
Remote: unix://
Architecture: x86_64
Created: 2021/05/01 08:40 UTC
Status: Stopped
Type: container
Profiles: default, mk8s

Log:

lxc mk8s 20210501084102.771 WARN     cgfsng - cgroups/cgfsng.c:mkdir_eexist_on_last:1129 - File exists - Failed to create directory "/sys/fs/cgroup/cpuset//lxc.monitor.mk8s"
lxc mk8s 20210501084102.774 WARN     cgfsng - cgroups/cgfsng.c:mkdir_eexist_on_last:1129 - File exists - Failed to create directory "/sys/fs/cgroup/cpuset//lxc.payload.mk8s"
lxc mk8s 20210501084102.832 ERROR    conf - conf.c:turn_into_dependent_mounts:3062 - No such file or directory - Failed to recursively turn old root mount tree into dependent mount. Continuing...
lxc mk8s 20210501084102.903 ERROR    utils - utils.c:mkdir_p:234 - Operation not permitted - Failed to create directory "/var/snap/lxd/common/lxc//sys/module/apparmor/"
lxc mk8s 20210501084102.903 ERROR    conf - conf.c:mount_entry_create_dir_file:2093 - Operation not permitted - Failed to create directory "/var/snap/lxd/common/lxc//sys/module/apparmor/parameters/enabled"
lxc mk8s 20210501084102.903 ERROR    conf - conf.c:lxc_setup:3353 - Failed to setup mount entries
lxc mk8s 20210501084102.903 ERROR    start - start.c:do_start:1218 - Failed to setup container "mk8s"
lxc mk8s 20210501084102.903 ERROR    sync - sync.c:__sync_wait:36 - An error occurred in another process (expected sequence number 5)
lxc mk8s 20210501084102.903 WARN     network - network.c:lxc_delete_network_priv:3185 - Failed to rename interface with index 4 from "eth0" to its initial name "veth6b1dcc61"
lxc mk8s 20210501084102.903 ERROR    lxccontainer - lxccontainer.c:wait_on_daemonized_start:860 - Received container state "ABORTING" instead of "RUNNING"
lxc mk8s 20210501084102.903 ERROR    start - start.c:__lxc_start:1999 - Failed to spawn container "mk8s"
lxc mk8s 20210501084102.903 WARN     start - start.c:lxc_abort:1013 - No such process - Failed to send SIGKILL via pidfd 33 for process 2958
lxc mk8s 20210501084103.392 WARN     cgfsng - cgroups/cgfsng.c:cgfsng_monitor_destroy:1086 - Success - Failed to initialize cpuset /sys/fs/cgroup/cpuset//lxc.pivot/lxc.pivot
lxc 20210501084103.393 WARN     commands - commands.c:lxc_cmd_rsp_recv:126 - Connection reset by peer - Failed to receive response for command "get_state"

```

## ISSUES-6

```sh
$ sudo lxd init
- Name of the storage backend to use (zfs, ceph, btrfs, dir, lvm) [default=zfs]:

> Error: Failed to create storage pool 'zfs-local': Required tool 'zpool' is missing

```