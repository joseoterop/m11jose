### Primera parte, creación del Dockerfile y AWS

* conexión con AWS
 ```
  Nos conectamos con nuestra consola de AWS e iniciamos una maquina que tenga docker instalado, de las muchas que hemos desarrollado a lo largo del año.

  ssh -i "clave"  fedora@ip

 ```


* Configuración de las políticas del firewall

  ```
    Debemos gestionar el firewall de amazon para que permita las conexiones a puertos 110 y 995 estableciendo una regla nueva o modificando una de existente.


  ```




* Descarga del repositorio

```
  git clone https://github.com/joseoterop/m11jose.git

  Nos descargamos el repositorio git, para hacer la imagen en remoto, debido a que es menor el gasto de datos que realizamos en comparación con descargarnos toda la imagen de dockerhub.


```


* Creación de la imagen y puesta en marcha del contenedor

```
  Creamos la imagen docker build -t joterop/m11jose .

  inicamos el contenedor exponiendo los puertos

  docker run --name pepe --hostname pepe -p 110:110 -p 995:995 -d joterop/m11jose

  docker ps

  CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                                        NAMES
  cbb0769a2891        joterop/m11jose     "/opt/docker/startup…"   36 seconds ago      Up 35 seconds       0.0.0.0:110->110/tcp, 0.0.0.0:995->995/tcp   pepe



```



* Pruebas realizadas

```
  [isx41005342@i13 examen_final]$ telnet 52.56.141.9 110
  Trying 52.56.141.9...
  Connected to 52.56.141.9.
  Escape character is '^]'.
  +OK POP3 pepe 2007f.104 server ready
  USER pere
  +OK User name accepted, password please
  PASS pere
  +OK Mailbox open, 2 messages
  LIST
  +OK Mailbox scan listing follows
  1 210
  2 90
  .
  RETR 1
  +OK 210 octets
  Received: from ... by ... with ESMTP;
  Subject: Prueba
  From: <build.9.0.2416@ixazon.dynip.com>
  To: <junkdtectr@carolina.rr.com>
  Status:   

  >Desde el principio de los tiempos, la gente ha escrito cartas.
  .

 CON OPENSSL
  isx41005342@i13 examen_final]$ openssl s_client -connect 52.56.141.9:995
CONNECTED(00000003)
depth=0 C = --, ST = SomeState, L = SomeCity, O = SomeOrganization, OU = SomeOrganizationalUnit, CN = localhost.localdomain, emailAddress = root@localhost.localdomain
verify error:num=18:self signed certificate
verify return:1
depth=0 C = --, ST = SomeState, L = SomeCity, O = SomeOrganization, OU = SomeOrganizationalUnit, CN = localhost.localdomain, emailAddress = root@localhost.localdomain
verify return:1
---
Certificate chain
 0 s:/C=--/ST=SomeState/L=SomeCity/O=SomeOrganization/OU=SomeOrganizationalUnit/CN=localhost.localdomain/emailAddress=root@localhost.localdomain
   i:/C=--/ST=SomeState/L=SomeCity/O=SomeOrganization/OU=SomeOrganizationalUnit/CN=localhost.localdomain/emailAddress=root@localhost.localdomain
---
Server certificate
-----BEGIN CERTIFICATE-----
MIIETjCCAzagAwIBAgIJAMCNB6Sm2Rx6MA0GCSqGSIb3DQEBCwUAMIG7MQswCQYD
VQQGEwItLTESMBAGA1UECAwJU29tZVN0YXRlMREwDwYDVQQHDAhTb21lQ2l0eTEZ
MBcGA1UECgwQU29tZU9yZ2FuaXphdGlvbjEfMB0GA1UECwwWU29tZU9yZ2FuaXph
dGlvbmFsVW5pdDEeMBwGA1UEAwwVbG9jYWxob3N0LmxvY2FsZG9tYWluMSkwJwYJ
KoZIhvcNAQkBFhpyb290QGxvY2FsaG9zdC5sb2NhbGRvbWFpbjAeFw0xOTA1MDMx
MDAwMjNaFw0yMDA1MDIxMDAwMjNaMIG7MQswCQYDVQQGEwItLTESMBAGA1UECAwJ
U29tZVN0YXRlMREwDwYDVQQHDAhTb21lQ2l0eTEZMBcGA1UECgwQU29tZU9yZ2Fu
aXphdGlvbjEfMB0GA1UECwwWU29tZU9yZ2FuaXphdGlvbmFsVW5pdDEeMBwGA1UE
AwwVbG9jYWxob3N0LmxvY2FsZG9tYWluMSkwJwYJKoZIhvcNAQkBFhpyb290QGxv
Y2FsaG9zdC5sb2NhbGRvbWFpbjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
ggEBAMYIt8HQ4lqmEtYaT/8CJFLv3eam44Ei0ZTHW/6gei+oFD0ZsS5FLurrP1ph
FSgyVql/M1Q4lmWC7obhg11dKbAI24WizRWMl2OPX4M9E305qf/Ca689x1aZieYB
+lWrPELEIxXx9KUJ9lHqEKL9hwrmWzaHLE55gO0AYIvggP9sRI2Ib50u1QVAbWHq
F/o54mhalExpm9rBfgQeNnvIjYfJKnS0IkEePcdoKQREQ7QV4/8NhblYuXiFbGbo
vtMvoJZmQ1J1cXDXeFoXTUdeaXl45QwLdMhY4909e3V6xrb75czdQzrzb1DUK/zD
m8/pEZjd3jj62XdrJvQfROgM3PECAwEAAaNTMFEwHQYDVR0OBBYEFHdf4iEyxRtw
UxAkFhma3oXPT7aYMB8GA1UdIwQYMBaAFHdf4iEyxRtwUxAkFhma3oXPT7aYMA8G
A1UdEwEB/wQFMAMBAf8wDQYJKoZIhvcNAQELBQADggEBAEq1VMrukeeAx17MoXjX
nFMlpilh4OCkMNBxXQRXjYN2CvXFjk5BfJiW+SYaiI1Cjl+majrJZk4eIH0GNzsj
oSZePRPpfniqKZi7pp6jvcfufmM0D5mjRMfsTHvvCvYIEdxoju/hqr646DHYIFKj
T/tItWpm98TRx3CKn7BwZh1vEBXsbJekau6nSJbbK/YX5GB5RglfQAegMHnAFaID
3dZ2023GCXk676stU2k448uBR+NgWPcxBOWCCVvg+MIVPaLZEZJJ599c5HCqVNYK
ReJD7/hACttt00K7qY9OSoC6looNRR+5vzicgKzQDil9dtA03FqAykAIhz1hpV6d
Fp0=
-----END CERTIFICATE-----
subject=/C=--/ST=SomeState/L=SomeCity/O=SomeOrganization/OU=SomeOrganizationalUnit/CN=localhost.localdomain/emailAddress=root@localhost.localdomain
issuer=/C=--/ST=SomeState/L=SomeCity/O=SomeOrganization/OU=SomeOrganizationalUnit/CN=localhost.localdomain/emailAddress=root@localhost.localdomain
---
No client certificate CA names sent
Peer signing digest: SHA512
Server Temp Key: X25519, 253 bits
---
SSL handshake has read 1731 bytes and written 347 bytes
Verification error: self signed certificate
---
New, TLSv1.2, Cipher is ECDHE-RSA-AES256-GCM-SHA384
Server public key is 2048 bit
Secure Renegotiation IS supported
Compression: NONE
Expansion: NONE
No ALPN negotiated
SSL-Session:
    Protocol  : TLSv1.2
    Cipher    : ECDHE-RSA-AES256-GCM-SHA384
    Session-ID: 55B0373D1259813447DD982A6AD85AFF50C5DA6373950DE8CE0056F8EA98B20D
    Session-ID-ctx:
    Master-Key: 11C918E16A9F3589DABAD2936CC7CAB82FBE5143D17FBF06B8FB55F2DE64F5DE3DFE0F7F170D33CC6C81B7EA3FBEE941
    PSK identity: None
    PSK identity hint: None
    SRP username: None
    TLS session ticket lifetime hint: 7200 (seconds)
    TLS session ticket:
    0000 - 9c 8c 22 74 39 24 d5 3a-9a 4c d5 f6 a4 1b d9 2a   .."t9$.:.L.....*
    0010 - a2 d7 a1 19 b0 b4 70 8c-7d cf 71 6d 11 f0 e5 94   ......p.}.qm....
    0020 - bd ac 99 47 e9 3e 30 59-d5 5b 0a 55 14 dc 97 83   ...G.>0Y.[.U....
    0030 - d3 89 1b 82 e6 27 27 1d-08 71 bc fb a1 e7 2a a4   .....''..q....*.
    0040 - 2e 93 43 25 90 c8 e1 69-84 11 d1 ca 57 6d ef 50   ..C%...i....Wm.P
    0050 - 4e 26 f4 8e 79 57 98 0a-9b af 6d 0e 3a 7c 9b ce   N&..yW....m.:|..
    0060 - 59 2c 4d 10 15 f8 6e f6-c2 07 5a 06 eb e0 00 1f   Y,M...n...Z.....
    0070 - 5e 0f 3e e9 a5 3a 90 3a-96 94 fd 9c 4c f5 f5 94   ^.>..:.:....L...
    0080 - 2e 57 29 07 b1 dd f7 d2-c5 4e 75 f0 1a 63 0f c5   .W)......Nu..c..
    0090 - f3 7e 9d 6f 4d 36 82 4c-16 e7 7b 3a fa 2f 8a c5   .~.oM6.L..{:./..

    Start Time: 1556879408
    Timeout   : 7200 (sec)
    Verify return code: 18 (self signed certificate)
    Extended master secret: yes
---
+OK POP3 pepe 2007f.104 server ready
USER pere
+OK User name accepted, password please
PASS pere
+OK Mailbox open, 2 messages
LIST
+OK Mailbox scan listing follows
1 210
2 90
.




```

* Subir las imagenes a dockerhub

```
  Hacemos un Docker login
  docker tag joterop/m11jose joterop/m11jose:v1
  subimos las imagenes
  docker push joterop/m11jose:v1
  docker push joterop/m11jose

```


### Segunda parte del ejercicio DOCKER local, y descarga de correo


* creamos la red interna de docker para realizar el ejercicio

```
  [i13 ~]$ docker network create popnet
   7d9430dc1e763c73f075774df6b8334ac9ce9fdfad11a3a7ba797bebc1f30d3b
```
* Creamos el contenedor donde instalaremos las herramientas necesarias para realizar las diferentes pruebas de conexion

```
  [i13 ~]# docker run --name popserver --hostname popserver --network popnet -it fedora:28 /bin/bash

```

* Una vez dentro del servidor, instalamos las herramientas necesarias para desarrollar el ejercicio, basicamente el paquete del correo y la herramienta para crear usuarios.

```
  dnf -y install uw-imap passwd procps

```

* Creamos los usuarios para para poder acceder al email de forma remota

```
  useradd marta
  useradd pere

  passwd marta --> marta

  passwd pere --> pere

```

* Creamos correo basura dentro de sus respectivos `mailboxes`

```
  From hansolo@ixazon.dynip.com Sat Aug 03 02:56:55 2002
  Received: from ... by ... with ESMTP;
  Subject: Prueba
  From: <build.9.0.2416@ixazon.dynip.com>
  To: <junkdtectr@carolina.rr.com>

  >Desde el principio de los tiempos, la gente ha escrito cartas.

  From someoneelse@loa.invalid Sun Aug 04 12:56:55 2002
  Received: from ... by ... with SMTP
  Subject: Iggeret
  To: <you@aoeu.snth>

  Ha iggeret hazot niktava blashon ivrit.

  (Es el ejemplo de wikipedia)


```

* Copiamos el contenido basura dentro de sus `mailboxes`

```
  /var/spool/mail/marta
  /var/spool/mail/pere

```

* Abrimos los servicios necesarios de xinetd

```
cd /etc/xinetd.d
cambiamos el disable a"no" de los archivos ipop3 y pop3s

```

* Encendemos el servicio

```
/usr/sbin/xinetd (en la version detach tiene -dontfork)

```

* Comprobamos que los puertos asociados a los servicios, estén abiertos.

```
  [root@popserver xinetd.d]# nmap localhost

  Starting Nmap 7.60 ( https://nmap.org ) at 2019-05-03 08:43 UTC
  Nmap scan report for localhost (127.0.0.1)
  Host is up (0.000025s latency).
  Other addresses for localhost (not scanned): ::1
  Not shown: 998 closed ports
  PORT    STATE SERVICE
  110/tcp open  pop3
  995/tcp open  pop3s

```

* Descargamos el mail de `pere` desde el host del aula i13 usando POP3

```
  [isx41005342@i13 ~]$ telnet 172.26.0.2 110
  Trying 172.26.0.2...
  Connected to 172.26.0.2.
  Escape character is '^]'.
  +OK POP3 popserver 2007f.104 server ready
  USER pere
  +OK User name accepted, password please
  PASS pere
  +OK Mailbox open, 2 messages
  LIST
  +OK Mailbox scan listing follows
  1 210
  2 131
  .
  RETR 1
  +OK 210 octets
  Received: from ... by ... with ESMTP;
  Subject: Prueba
  From: <build.9.0.2416@ixazon.dynip.com>
  To: <junkdtectr@carolina.rr.com>
  Status:  O

  >Desde el principio de los tiempos, la gente ha escrito cartas.

```

* Descargamos el mail de `marta` desde el host del aula i13 usando POP3s

```
[isx41005342@i13 ~]$ openssl s_client -connect 172.26.0.2:995
CONNECTED(00000003)
write:errno=104
---
no peer certificate available
---
No client certificate CA names sent
---
SSL handshake has read 0 bytes and written 254 bytes
Verification: OK
---
New, (NONE), Cipher is (NONE)
Secure Renegotiation IS NOT supported
Compression: NONE
Expansion: NONE
No ALPN negotiated
SSL-Session:
    Protocol  : TLSv1.2
    Cipher    : 0000
    Session-ID:
    Session-ID-ctx:
    Master-Key:
    PSK identity: None
    PSK identity hint: None
    SRP username: None
    Start Time: 1556874848
    Timeout   : 7200 (sec)
    Verify return code: 0 (ok)
    Extended master secret: no
---

NO ENTIENDO MUY BIEN COMO GESTIONAR ESTO, en AWS funciona en local no ...

```
