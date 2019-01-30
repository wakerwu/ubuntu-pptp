if [ $(id -u) != "0" ]; then
    printf "Error: You must be root to run this tool!\n"
    exit 1
fi
clear
printf "
####################################################
#                                                  #
# This is a Shell-Based tool of pptp installation  #
# Version: 1.0                                     #
# Author: wakerwu                                  #
# For Debian/Ubuntu 32bit and 64bit                #
#                                                  #
####################################################
"
apt-get update
apt-get install pptpd
echo 1 > /proc/sys/net/ipv4/ip_forward 
sed -i "13iiptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE"  /etc/rc.local
sed -i "13i/etc/init.d/pptpd restart"  /etc/rc.local
echo "localip 11.0.0.10" >> /etc/pptpd.conf
echo "remoteip 11.0.0.100-200" >> /etc/pptpd.conf
echo "ms-dns 8.8.8.8" >> /etc/ppp/options
echo "ms-dns 8.8.4.4" >> /etc/ppp/options
echo "wakerwu pptpd p19890202 *" >> /etc/ppp/chap-secrets
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
sysctl -p
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
/etc/init.d/pptpd restart
printf "
####################################################
#                                                  #
# This is a Shell-Based tool of pptp installation  #
# Version: 1.0                                     #
# Author: wakerwu                                  #
# For Debian/Ubuntu 32bit and 64bit                #
#                                                  #
####################################################
username:wakerwu
password:p19890202
---------------------
"

