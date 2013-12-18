From: Anand Neeli <anand.neeli@gmail.com>
Subject: lttng with syslog and stdout
Date: Wed, 18 Dec 2013 16:21:21 +0530
Message-ID: <CAM5kDqzmGS7w7B6-KdvP_wEafJ626omhJQ5RC7Q8sV4-RU5riQ__13093.8510912985$1387363931$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2136963728=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <anand.neeli@gmail.com>) id 1VtEit-0001Vv-IQ
	for lttng-dev@lists.lttng.org; Wed, 18 Dec 2013 05:51:30 -0500
Received: by mail-pd0-f178.google.com with SMTP id y10so8048206pdj.37
	for <lttng-dev@lists.lttng.org>; Wed, 18 Dec 2013 02:51:21 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============2136963728==
Content-Type: multipart/alternative; boundary=e89a8ff1cce455d19004edccd317

--e89a8ff1cce455d19004edccd317
Content-Type: text/plain; charset=ISO-8859-1

Hi All,
Here are some queries i have. Can someone please help me with them.

1) is there a way send selective traces from lttng to syslog; and should be
configurable based on the priority. (say like i want to send all CRIT or
EMRG traces to syslog)

2) is there a way to stdout the logs of lttng. (similar to above this
should also be configurable based on the priority)

What i'm trying here is to use syslog for critical messages and use stdout
when debugging live.

Please give me pointers if this is already there.

Thanks in advance.
Anand Neeli

--e89a8ff1cce455d19004edccd317
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi All,<div>Here are some queries i have. Can someone plea=
se help me with them.</div><div>=A0<br></div><div>1) is there a way send se=
lective traces from lttng to syslog; and should be configurable based on th=
e priority. (say like i want to send all CRIT or EMRG traces to syslog)</di=
v>
<div><br></div><div>2) is there a way to stdout the logs of lttng. (similar=
 to above this should also be configurable based on the priority)</div><div=
><br></div><div>What i&#39;m trying here is to use syslog for critical mess=
ages and use stdout when debugging live.</div>
<div><br></div><div>Please give me pointers if this is already there.</div>=
<div><br></div><div>Thanks in advance.</div><div>Anand Neeli</div><div><br>=
</div></div>

--e89a8ff1cce455d19004edccd317--


--===============2136963728==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2136963728==--
