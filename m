From: Mariya Rampurawala <mariya.r26@gmail.com>
Subject: error in generation of trace files
Date: Thu, 27 Feb 2014 16:36:24 +0530
Message-ID: <CAB7sTjgY9OpaQG-Cs2gnHA6s3+hHuutkP=6wPPVq5TkfdY-hng__39771.0080295385$1393499241$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2053355382=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-we0-f195.google.com ([74.125.82.195])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <mariya.r26@gmail.com>) id 1WIynO-00052w-D3
	for lttng-dev@lists.lttng.org; Thu, 27 Feb 2014 06:06:31 -0500
Received: by mail-we0-f195.google.com with SMTP id q58so862533wes.10
	for <lttng-dev@lists.lttng.org>; Thu, 27 Feb 2014 03:06:24 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============2053355382==
Content-Type: multipart/alternative; boundary=f46d044287d8de2a7c04f3614fec

--f46d044287d8de2a7c04f3614fec
Content-Type: text/plain; charset=ISO-8859-1

Hello,
 I'm new to lttng. I use ubuntu 13.10. While performing basic operations,
on command lttng view, i get the following error.
[error] Cannot open any trace for reading.

[error] opening trace "/home/mariya/lttng-traces/mysession-20140227-163353"
for reading.

[error] none of the specified trace paths could be opened.


the o/p of the command "lttng-sessiond --verbose" is as follows

DEBUG3: Creating LTTng run directory: /home/mariya/.lttng [in
create_lttng_rundir() at main.c:3692]
DEBUG1: Client socket path /home/mariya/.lttng/client-lttng-sessiond [in
main() at main.c:3995]
DEBUG1: Application socket path /home/mariya/.lttng/apps-lttng-sessiond [in
main() at main.c:3996]
DEBUG1: LTTng run directory path: /home/mariya/.lttng [in main() at
main.c:3997]
Error: Already running daemon.

Could you please help me solve the error and proceed with my project?

--f46d044287d8de2a7c04f3614fec
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Hello,<br></div>=A0I&#39;m new to lttng. I =
use ubuntu 13.10. While performing basic operations, on command lttng view,=
 i get the following error.<br>[error] Cannot open any trace for reading.<b=
r>
<br>[error] opening trace &quot;/home/mariya/lttng-traces/mysession-2014022=
7-163353&quot; for reading.<br><br>[error] none of the specified trace path=
s could be opened.<br><br><br></div>the o/p of the command &quot;lttng-sess=
iond --verbose&quot; is as follows<br>
<br>DEBUG3: Creating LTTng run directory: /home/mariya/.lttng [in create_lt=
tng_rundir() at main.c:3692]<br>DEBUG1: Client socket path /home/mariya/.lt=
tng/client-lttng-sessiond [in main() at main.c:3995]<br>DEBUG1: Application=
 socket path /home/mariya/.lttng/apps-lttng-sessiond [in main() at main.c:3=
996]<br>
DEBUG1: LTTng run directory path: /home/mariya/.lttng [in main() at main.c:=
3997]<br>Error: Already running daemon.<br><br></div>Could you please help =
me solve the error and proceed with my project?<br></div>

--f46d044287d8de2a7c04f3614fec--


--===============2053355382==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2053355382==--
