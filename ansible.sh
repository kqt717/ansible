#!/bin/sh
#write by kqt717
#2016-02-29

CONF="/etc/ansible/ansible.cfg"
HOST="/etc/ansible/hosts"

#安装ansible
rpm -qa|grep epel || yum install epel-release -y
rpm -qa|grep ansible || yum install ansible  -y

#配置ansible
[ ! -f /etc/ansible/ansible.cfg.default ] && cp $CONF{,.default}

sed -i 's/#ask_pass/ask_pass/g' $CONF
sed -i 's/#host_key_checking/host_key_checking/g' $CONF

sed -i "/^$/d; /^#/d" $CONF   #删除空行和注释行

#添加主机
[ ! -f /etc/ansible/hosts.default ] && cp $HOST{,.default}

grep "IDC_web" $HOST || echo "[IDC_web]" >$HOST	#默认主机组为[IDC_web]

read -p "请输入需要受控的IP，输入quit退出:" host
while [ $host != 'quit' ];do
  grep $host $HOST || echo $host >>$HOST
  read -p "请输入需要受控的IP，输入quit退出:" host
done


