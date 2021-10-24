#! /bin/sh

action_start()
{
echo "Start Tor Service :"
echo -n 'TOR [START]'
sudo service tor start
echo -e '\rTOR [COMPLETE]'
}

action_stop()
{
echo "Stop Tor Service :"
echo -n 'TOR [STOP]'
sudo service tor stop
echo -e '\rTOR [COMPLETE]'
}

action_newip()
{
echo "New Ip :"
echo -n 'REFRESH IP [START]'
sleep 0.5
sudo killall -HUP tor
echo -e '\rREFRESH IP [COMPLETE]'
}
while true
do
clear
ippub=$(wget http://checkip.dyndns.org/ -O - -o /dev/null | cut -d: -f 2 | cut -d' ' -f 2 | cut -d\< -f 1)
torst=$(systemctl show -p ActiveState --value tor)
if [ $torst = "inactive" ]
then
        ippro="No TOR"
	torproj=""
else
	ip1=$(proxychains wget http://checkip.dyndns.org/ -O - -o /dev/null | cut -d: -f 2 | cut -d' ' -f 2 | cut -d\< -f 1)
	ip2='('
	ippro=$ip2+$ip1
	torproj=$(curl --socks5 localhost:9050 --socks5-hostname localhost:9050 -s https://check.torproject.org/ | cat | grep -m 1 Congratulations | xargs)
fi

echo "Tor_select :"
echo ""
echo "Ip Public "$ippub" | Tor Status "$torst" | Ip Proxy "$ippro
echo $torproj
echo ""
echo "Selection :"
cat << "EOT"

	1 )  Start T0R
	2 )  Stop T0R
	3 )  New IP

	9 )  QUIT
EOT
echo "
>>"
tput cuu1
tput cuf 3
read answer 
clear
case "$answer" in
[1]*)  action_start;;
[2]*)  action_stop;;
[3]*)  action_newip;;

[9]*)  echo "See you later ..." ; exit 0 ;;
*)      echo "Please choose an option which is displayed on the menu" ;;
esac
echo ""
echo "PRESS RETURN FOR THE MENU"
read dummy
done



