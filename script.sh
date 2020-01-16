#Created by Cameron Williams
#Version 1.0
#Last Modified 21/09/17

#!/bin/bash

clear
echo -e "\e[33m#############################################################"
echo -e "\e[33m#############################################################"
echo -e "\e[33m##                                                         ##"
echo -e "\e[33m##             ████████╗██╗  ██╗███████╗                   ##"
echo -e "\e[33m##             ╚══██╔══╝██║  ██║██╔════╝                 ##"
echo -e "\e[33m##                ██║   ███████║█████╗                   ##"
echo -e "\e[33m##                ██║   ██╔══██║██╔══╝                   ##"
echo -e "\e[33m##                ██║   ██║  ██║███████╗                 ##"
echo -e "\e[33m##                ╚═╝   ╚═╝  ╚═╝╚══════╝                 ##"
echo -e "\e[33m##                                                       ##"
echo -e "\e[33m##   ██████╗  ██████╗ ███╗   ███╗ █████╗ ██╗███╗   ██╗   ##"
echo -e "\e[33m##   ██╔══██╗██╔═══██╗████╗ ████║██╔══██╗██║████╗  ██║   ##"
echo -e "\e[33m##   ██║  ██║██║   ██║██╔████╔██║███████║██║██╔██╗ ██║   ##"
echo -e "\e[33m##   ██║  ██║██║   ██║██║╚██╔╝██║██╔══██║██║██║╚██╗██║   ##"
echo -e "\e[33m##   ██████╔╝╚██████╔╝██║ ╚═╝ ██║██║  ██║██║██║ ╚████║   ##"
echo -e "\e[33m##   ╚═════╝  ╚═════╝ ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝   ##"
echo -e "\e[33m##                                                       ##"
echo -e "\e[33m##          ████████╗ ██████╗  ██████╗ ██╗               ##"
echo -e "\e[33m##          ╚══██╔══╝██╔═══██╗██╔═══██╗██║               ##"
echo -e "\e[33m##             ██║   ██║   ██║██║   ██║██║               ##"
echo -e "\e[33m##             ██║   ██║   ██║██║   ██║██║               ##"
echo -e "\e[33m##             ██║   ╚██████╔╝╚██████╔╝███████╗          ##"
echo -e "\e[33m##             ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝          ##"
echo -e "\e[33m##                                                       ##"
echo -e "\e[33m#############################################################"
echo -e "\e[33m#############################################################"

echo ""
echo ""
URL=$1 #Assigning URL to variable

echo -e  "\e[96mTesting: \e[32m"
echo $URL
echo -e "\e[96mPinging Server\e[92m" 
PING=$(ping $URL -c 1 | grep -E -o '[0-9]+ received' | cut -f1 -d' ')
if [ "1" != "$PING" ]
then
  echo -e "\e[31mServer Offline"
echo -e  "\e[96mA Record :\e[39m"
dig A $URL +short
echo -e  "\e[96mNameservers  :\e[39m "
dig NS $URL +short
echo -e  "\e[96mWHOIS Nameservers  :\e[39m "
whois $URL | grep -i "name server:"
echo -e  "\e[96mMX Records :\e[39m "
dig MX $URL +short
else
echo -e  "\e[32mServer Online!!"
echo -e  "\e[96mA Record :\e[39m"
dig A $URL +short
echo -e  "\e[96mNameservers :\e[39m "
dig NS $URL +short
echo -e  "\e[96mWHOIS Nameservers  :\e[39m "
whois $URL | grep -i "name Server:"
echo -e  "\e[96mMX Records :\e[39m "
dig MX $URL +short
echo -e  "\e[96mReverse DNS :\e[39m "
nmap -sP $URL | grep rDNS
echo -e  "\e[96mPort Scan results :\e[39m"
nmap -Pn -n $URL -p 21 -oG -T4 | grep 21/
nmap -Pn -n $URL -p 22 -oG -T4 | grep 22/
nmap -Pn -n $URL -p 23 -oG -T4 | grep 23/
nmap -Pn -n $URL -p 25 -oG -T4 | grep 25/
nmap -Pn -n $URL -p 53 -oG -T4 | grep 53/
nmap -Pn -n $URL -p 80 -oG -T4 | grep 80/
nmap -Pn -n $URL -p 110 -oG -T4 | grep 110/
nmap -Pn -n $URL -p 143 -oG -T4 | grep 143/
nmap -Pn -n $URL -p 443 -oG -T4 | grep 443/
nmap -Pn -n $URL -p 389 -oG -T4 | grep 389/
nmap -Pn -n $URL -p 465 -oG -T4 | grep 465/
nmap -Pn -n $URL -p 587 -oG -T4 | grep 587/
nmap -Pn -n $URL -p 993 -oG -T4 | grep 993/
nmap -Pn -n $URL -p 995 -oG -T4 | grep 995/
nmap -Pn -n $URL -p 1433 -oG -T4 | grep 1433/
nmap -Pn -n $URL -p 1521 -oG -T4 | grep 1521/
nmap -Pn -n $URL -p 2087 -oG -T4 | grep 2087/
nmap -Pn -n $URL -p 3306 -oG -T4 | grep 3306/
nmap -Pn -n $URL -p 3389 -oG -T4 | grep 3389/
nmap -Pn -n $URL -p 5900 -oG -T4 | grep 5900/
nmap -Pn -n $URL -p 8080 -oG -T4 | grep 8080/
nmap -Pn -n $URL -p 8443 -oG -T4 | grep 8443/
fi






