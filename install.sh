#! /bin/bash

#creamos los usuarios
useradd marta
useradd pere

echo "pere" | passwd --stdin pere
echo "marta" | passwd --stdin marta

# modificamos los xinetd

cp /opt/docker/ipop3 /etc/xinetd.d/ipop3
cp /opt/docker/pop3s /etc/xinetd.d/pop3s

#enviamos el email a las boxmailes

cat correo >> /var/spool/mail/marta 
cat correo >> /var/spool/mail/pere


