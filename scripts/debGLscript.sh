#!/usr/bin/env bash

apt update && DEBIAN_FRONTEND=noninteractive apt dist-upgrede -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold"

sed -i 's/"syntax on/syntax on/g' /etc/vim/vimrc
echo 'set mouse-=a' > ~/.vimrc && source ~/.vimrc
echo "alias ll='ls -ltrh'" >>  /root/.bash_profile && source /root/.bash_profile
apt install -y net-tools vim ntpdate tcpdump telnet ftp makepasswd curl jq
timedatectl set-timezone 'Asia/Baku' && ntpdate 0.asia.pool.ntp.org
#echo "username:newpass"|chpasswd
echo -e "freebsd\nfreebsd" | passwd root
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
cat <<EOF >> /etc/ssh/sshd_config
Port 22
Port 10022
EOF
systemctl restart sshd

if [ $(hostname -f) != 'apilb' ]
then
    sed -i "11 {s/^/#/}" /etc/fstab
    swapoff -a
fi 

if [ $(hostname -f) == kubeworker1 -o $(hostname -f) == kubeworker2 -o $(hostname -f) == kubeworker3 ]
then
    apt install -y python-pip
    pip install hostsman dnspython
    apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
    apt update && apt-get install -y docker-ce docker-ce-cli containerd.io
#    apt update && apt-get install -y docker-ce-cli 
fi

cat <<EOF > /etc/hosts
127.0.0.1       localhost
10.20.33.41     apilb apilb.kubernetes.loc
10.20.33.11     kubecontroller1 kubecontroller1.kubernetes.loc
10.20.33.12     kubecontroller2 kubecontroller2.kubernetes.loc
10.20.33.13     kubecontroller3 kubecontroller3.kubernetes.loc
10.20.33.21     kubeworker1 kubeworker1.kubernetes.loc
10.20.33.22     kubeworker2 kubeworker2.kubernetes.loc
10.20.33.23     kubeworker3 kubeworker3.kubernetes.loc
EOF

echo  "The IP address to SSH: $(ifconfig eth1 | grep 'inet ' | awk '{ print $2 }')"
