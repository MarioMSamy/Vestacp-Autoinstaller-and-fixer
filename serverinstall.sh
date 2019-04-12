clear
echo "Welcome , I will setup server for you and fix many problems too"
echo "so , Please enter your hostname need to set"
read hostnameset
if [ -z "$hostnameset" ]
then
	hostnameoutput=$( hostname )
	hostnameset=$hostnameoutput
echo "we set the default vale"
else
      echo "Thank you"
fi
wait
echo your hostname is : $hostnameset
wait
echo Please enter your server password
read servermail
if [ -z "$servermail" ]
then
      servermail=mario.magdy2012@gmail.com
echo "we set the default value"
else
      echo "Admin Mail set"
fi
wait
echo Please enter your server password
read serverpass
if [ -z "$serverpass" ]
then
      serverpass=000000
echo "we set the default vale"
else
      echo "Password set"
fi
apt install curl zip unzip
cd /tmp/
curl -O http://vestacp.com/pub/vst-install.sh
bash vst-install.sh --nginx yes --apache yes --phpfpm no --named yes --remi yes --vsftpd yes --proftpd no --iptables yes --fail2ban yes --quota yes --exim yes --dovecot yes --spamassassin yes --clamav yes --softaculous no --mysql yes --postgresql no --hostname $hostnameset --email $servermail --password $serverpass
wait
echo "Server installed :) "
echo "fix some issues for you "
echo "fix ssl issue"
mv /usr/local/vesta/ssl/certificate.crt /usr/local/vesta/ssl/unusablecer.crt
mv /usr/local/vesta/ssl/certificate.key /usr/local/vesta/ssl/unusablecer.key
cd /root
git clone https://github.com/letsencrypt/letsencrypt
cd letsencrypt
./letsencrypt-auto --help
./letsencrypt-auto certonly --renew-by-default --webroot -w /home/admin/web/$hostnameset/public_html -d $hostnameset
cp /etc/letsencrypt/live/$hostnameset/cert.pem /usr/local/vesta/ssl/certificate.crt
cp /etc/letsencrypt/live/$hostnameset/privkey.pem /usr/local/vesta/ssl/certificate.key
service vesta restart
echo "fix ssl issue done !"
echo "Fix phpmyadmin problem"
curl -O -k https://raw.githubusercontent.com/skurudo/phpmyadmin-fixer/master/pma-debian.sh && chmod +x pma-debian.sh && ./pma-debian.sh
echo "Fix phpmyadmin problem done !"
echo "now you can login to vestacp"
echo server : $hostnameset:8083
echo password : $serverpass
echo Congratolations
echo Writen by Mario M. Samy
echo contact me if there is any problem mario.magdy2012@gmail