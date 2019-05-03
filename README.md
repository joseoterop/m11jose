### Primera parte, creación del Dockerfile y AWS 







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
/usr/sbin/xinetd (no nos hace falta un -stayalive)

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

NO ENTIENDO MUY BIEN COMO GESTIONAR ESTO

```

