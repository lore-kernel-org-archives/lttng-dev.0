From: Lea Brunschwig <lea.brunschwig@univ-pau.fr>
Subject: CTF writer in Java
Date: Mon, 6 May 2019 13:40:00 +0200 (CEST)
Message-ID: <34675397.591240.1557142800147.JavaMail.zimbra__35444.3200210639$1557143354$gmane$org@univ-pau.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8004745031486379712=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtpout20.partage.renater.fr (smtpout02-ext4.partage.renater.fr
 [194.254.241.31])
 by lists.lttng.org (Postfix) with ESMTP id 44yLc72cS6z1Kx5
 for <lttng-dev@lists.lttng.org>; Mon,  6 May 2019 07:48:55 -0400 (EDT)
Received: from zmtaout02.partage.renater.fr (zmtaout02.partage.renater.fr
 [194.254.241.30])
 by smtpout20.partage.renater.fr (Postfix) with ESMTP id 5B9E7BFA0A
 for <lttng-dev@lists.lttng.org>; Mon,  6 May 2019 13:40:00 +0200 (CEST)
Received: from zmtaout02.partage.renater.fr (localhost [127.0.0.1])
 by zmtaout02.partage.renater.fr (Postfix) with ESMTPS id 4F42A2005E
 for <lttng-dev@lists.lttng.org>; Mon,  6 May 2019 13:40:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zmtaout02.partage.renater.fr (Postfix) with ESMTP id 3FFBC20285
 for <lttng-dev@lists.lttng.org>; Mon,  6 May 2019 13:40:00 +0200 (CEST)
Received: from zmtaout02.partage.renater.fr ([127.0.0.1])
 by localhost (zmtaout02.partage.renater.fr [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id Pv_iYGW9Qygv for <lttng-dev@lists.lttng.org>;
 Mon,  6 May 2019 13:40:00 +0200 (CEST)
Received: from zstore-b1-008.partage.renater.fr
 (zstore-b1-008.partage.renater.fr [10.254.240.123])
 by zmtaout02.partage.renater.fr (Postfix) with ESMTP id 26D632005E
 for <lttng-dev@lists.lttng.org>; Mon,  6 May 2019 13:40:00 +0200 (CEST)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============8004745031486379712==
Content-Type: multipart/alternative;
	boundary="=_6e19a08f-fb88-4f1a-b8e2-ac931723c271"

--=_6e19a08f-fb88-4f1a-b8e2-ac931723c271
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,=20

I am working on a Java API that permits to create UML state machine and to =
run them. I have created a Java interface allowing to implement customizabl=
e trace for this tool: the user can implement its own way to gather informa=
tion from the execution for instance print in the console via System.out.pr=
intln() or print in a xml file, etc...=20

In the scope of the project I am working on I would like to provide the use=
rs a Java class implemeting my interface with the CTF format but I can not =
manage to find a code able to write a CTF trace in Java.=20
Does such a code exist?=20

Since CTF traces seem to be really specific I do not want to intent to writ=
e my own version of a CTF trace because I am scared it would not be accurat=
e and would not work with the already existing CTF readers.=20

Thank you in advance.=20
L=C3=A9a Brunschwig=20

--=_6e19a08f-fb88-4f1a-b8e2-ac931723c271
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div>Hello,<br><br>I am working on a Java API th=
at permits to create UML state machine and to run them. I have created a Ja=
va interface allowing to implement customizable trace for this tool: the us=
er can implement its own way to gather information from the execution for i=
nstance print in the console via System.out.println() or print in a xml fil=
e, etc...<br><br>In the scope of the project I am working on I would like t=
o provide the users a Java class implemeting my interface with the CTF form=
at but I can not manage to find a code able to write a CTF trace in Java.<b=
r>Does such a code exist?&nbsp;<br><br>Since CTF traces seem to be really s=
pecific I do not want to intent to write my own version of a CTF trace beca=
use I am scared it would not be accurate and would not work with the alread=
y existing CTF readers.<br><br>Thank you in advance.<br>L=C3=A9a Brunschwig=
</div></div></body></html>
--=_6e19a08f-fb88-4f1a-b8e2-ac931723c271--

--===============8004745031486379712==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============8004745031486379712==--
