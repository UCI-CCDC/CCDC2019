#!/bin/bash

echo Basic iptables setup. WILL overwrite old rules!
read -p "Are you sure? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
iptables -F INPUT
iptables -F FORWARD
iptables -F OUTPUT

iptables -P INPUT DROP							#drop all incoming
iptables -P FORWARD DROP						#drop all forwarded
iptables -P OUTPUT ACCEPT						#drop all output
iptables -A INPUT -i lo -j ACCEPT					# accept input on lo
iptables -A OUTPUT -o lo -j ACCEPT					#accept output on lo
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT	#accept related input

#for each service, enable rules below
#iptables -I INPUT -p tcp --dport PORT -j ACCEPT #GENERIC input on PORT

#HTTP/HTTPS
#iptables -I INPUT -p tcp --dport 80 -j ACCEPT  #http
#iptables -I INPUT -p tcp --dport 443 -j ACCEPT #https

#SSH
#iptables -I INPUT -p tcp --dport 22 -j ACCEPT #ssh

#DNS
#iptables -I INPUT -p tcp --dport 53 -j ACCEPT #dns tcp
#iptables -I INPUT -p udp --dport 53 -j ACCEPT #dns udp


fi