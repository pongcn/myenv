# wsl2 issues

<!-- $ microk8s.status
#output> microk8s is not running. Use microk8s inspect for a deeper inspection.
$ snap services microk8s
#output> microk8s.daemon-etcd                  enabled  inactive  -
#output> microk8s.daemon-flanneld              enabled  inactive  -
$ kubectl get nodes
#output> node  NotReady
$ sudo systemctl status snap.microk8s.daemon-kubelet
#output> kubelet.go:2188] Container runtime network not ready
$ kubectl taint nodes --all node-role.kubernetes.io/master-
#output> The connection to the server localhost:8080 was refused - did you specify the right host or port?
$ kubectl describe nodes
#output> runtime network not ready: NetworkReady=false reason:NetworkPluginNotReady message:Network plugin returns error: cni plugin not initialized
#solvation >> still no working
# vim /var/snap/microk8s/current/args/kubelet  remove --network-plugin=cni


# sudo apt-get install net-tools # bash: netstat: command not found
# sudo apt-get install lsb-core # lsb_release: command not found
# alias kube='microk8s.kubectl' -->

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
$ sudo sed -i s|SYSTEMD_EXE="/lib/systemd/systemd --unit=basic.target"|SYSTEMD_EXE="/lib/systemd/systemd --unit=multi-user.target"|g start-systemd-namespace && sudo sed -i s|SYSTEMD_EXE="/lib/systemd/systemd --unit=basic.target"|SYSTEMD_EXE="/lib/systemd/systemd --unit=multi-user.target"|g enter-systemd-namespace
$ sudo sed -i s|self_dir="$(dirname $0)"|self_dir="$(dirname -- $0)"|g ubuntu-wsl2-systemd-script.sh
$ sudo sed -i s|sudo cp "$self_dir/start-systemd-namespace" /usr/sbin/start-systemd-namespace|sudo cp "$self_dir/start-systemd-namespace" /usr/sbin/|g ubuntu-wsl2-systemd-script.sh && sudo sed -i s|sudo cp "$self_dir/enter-systemd-namespace" /usr/sbin/enter-systemd-namespace|sudo cp "$self_dir/enter-systemd-namespace" /usr/sbin/|g ubuntu-wsl2-systemd-script.sh
$ systemctl
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
cp arch/x86/boot/bzImage /mnt/c/User/<username>/wslkernel/mswslkernel
vi /mnt/c/Users/<username>/.wslconfig
# .wslconfig
[wsl2]
kernel=c:\\User\\<username>\\wslkernel\\mswslkernel
localhostForwarding=true
swap=0
[user]
default = <wslusername>
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
sudo apt install nftables
sudo brctl addbr lxcbr0
brctl show
>> lxcbr0          8000.000000000000       no

$ sudo vi /etc/default/lxc-net
LXC_BRIDGE="lxcbr0"
LXC_ADDR="10.0.4.1"
LXC_NETMASK="255.255.255.0"
LXC_NETWORK="10.0.4.0/24"
LXC_DHCP_RANGE="10.0.4.2,10.0.4.254"
LXC_DHCP_MAX="253"

sudo vi /etc/lxc/default.conf
lxc.network.type = veth
lxc.network.link = lxcbr0
lxc.network.flags = up
lxc.network.hwaddr = 00:16:3e:xx:xx:xx

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

