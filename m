From: Shariyar <syed.shariyar@gmail.com>
Subject: What are sys calls starting with compat?
Date: Fri, 6 Dec 2013 22:47:37 -0500
Message-ID: <CAKQh6pjTETiXbDVxwkZeQ3Et8313StbiLTWZx7uV9P5YQ2zVuA__20655.9536433362$1386388118$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2069573184=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <syed.shariyar@gmail.com>) id 1Vp8rn-0000UE-RN
	for lttng-dev@lists.lttng.org; Fri, 06 Dec 2013 22:47:49 -0500
Received: by mail-pb0-f46.google.com with SMTP id md12so2156055pbc.19
	for <lttng-dev@lists.lttng.org>; Fri, 06 Dec 2013 19:47:38 -0800 (PST)
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

--===============2069573184==
Content-Type: multipart/alternative; boundary=001a11364facb5eb0a04ece99f55

--001a11364facb5eb0a04ece99f55
Content-Type: text/plain; charset=ISO-8859-1

Can someone kindly explain the difference between system calls starting
with "compat" prefix and regular system calls?

 Compat system calls do not appear in the system call table:
http://syscalls.kernelgrok.com/. However, I did found them in the source
code of Linux.

Thanks,
Shariyar

--001a11364facb5eb0a04ece99f55
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Can someone kindly explain the difference betwee=
n system calls starting with &quot;compat&quot; prefix and regular system c=
alls?<br><br>=A0Compat system calls do not appear in the system call table:=
 <a href=3D"http://syscalls.kernelgrok.com/">http://syscalls.kernelgrok.com=
/</a>. However, I did found them in the source code of Linux.<br>
<br></div>Thanks,<br></div>Shariyar<br></div>

--001a11364facb5eb0a04ece99f55--


--===============2069573184==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2069573184==--
