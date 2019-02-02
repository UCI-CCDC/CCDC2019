#!/bin/sh

# see http://www.cyberciti.biz/faq/howto-setup-freebsd-ipfw-firewall/
# do not forget to set right ip!

ip="FILL IN IP ADDRESS"
IPF="ipfw -q add"

setup_loopback

#flush old rules
ipfw -q -f flush

Allow anything outbound from this address.
${IPF} allow all from me to any out

# Deny anything outbound from other addresses.
${IPF} deny log all from any to any out

# Allow TCP through if setup succeeded.
${IPF} allow tcp from any to any established

# Allow IP fragments to pass through.
${IPF} allow all from any to any frag

# drop all IPv6 packets through - no need
${IPF} deny ipv6 from any to any


############################################################
############CUSTOMIZE/UNCOMMENT LINES BELOW#################
############################################################

#SSH
#${IPF} allow tcp from any to me 22 setup


#email
#${IPF} allow tcp from any to me 222 setup
#${IPF} allow tcp from any to me 25 setup

#tcp-dns
#${IPF} allow tcp from any to me 53 setup

#HTTP/HTTPS
#${IPF} allow tcp from any to me 80 setup
#${IPF} allow tcp from any to me 443 setup

#IMAP, IMAPS, POP3, POP3S
#${IPF} allow tcp from any to me 143 setup
#${IPF} allow tcp from any to me 993 setup
#${IPF} allow tcp from any to me 110 setup
#${IPF} allow tcp from any to me 995 setup

############################################################
############         END SERVICE LIST      #################
############################################################


# Deny inbound auth, netbios, ldap, and Microsoft's DB protocol
# without logging.
${IPF} reset tcp from any to me 113 setup
${IPF} reset tcp from any to me 139 setup
${IPF} reset tcp from any to me 389 setup
${IPF} reset tcp from any to me 445 setup

# Deny some chatty UDP broadcast protocols without logging.
${IPF} deny udp from any 137 to any
${IPF} deny udp from any to any 137
${IPF} deny udp from any 138 to any
${IPF} deny udp from any 513 to any
${IPF} deny udp from any 525 to any

# Allow inbound DNS and NTP replies.  This is somewhat of a hole,
# since we're looking at the incoming port number, which can be
# faked, but that's just the way DNS and NTP work.
${IPF} allow udp from any 53 to me
${IPF} allow udp from any 123 to me

# Allow inbound DNS queries.
${IPF} allow udp from any to me 53

# Allow inbound NTP queries.
${IPF} allow udp from any to me 123

# Allow traceroute to function, but not to get in.
${IPF} unreach port udp from any to me 33435-33524

# Allow some inbound icmps - echo reply, dest unreach, source quench,
# echo, ttl exceeded.
${IPF} allow icmp from any to any icmptypes 0,3,4,8,11

# Everything else is denied and logged.
${IPF} deny log all from any to any