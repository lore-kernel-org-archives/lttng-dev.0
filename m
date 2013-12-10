From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: What are sys calls starting with compat?
Date: Tue, 10 Dec 2013 01:55:48 +0000 (UTC)
Message-ID: <2046508974.82289.1386640548755.JavaMail.zimbra__40678.0398371213$1386640606$gmane$org@efficios.com>
References: <CAKQh6pjTETiXbDVxwkZeQ3Et8313StbiLTWZx7uV9P5YQ2zVuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1729788109=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VqCY9-00080y-1j
	for lttng-dev@lists.lttng.org; Mon, 09 Dec 2013 20:55:55 -0500
In-Reply-To: <CAKQh6pjTETiXbDVxwkZeQ3Et8313StbiLTWZx7uV9P5YQ2zVuA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Shariyar <syed.shariyar@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1729788109==
Content-Type: multipart/alternative;
	boundary="----=_Part_82288_1627185296.1386640548754"

------=_Part_82288_1627185296.1386640548754
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- Original Message -----

> From: "Shariyar" <syed.shariyar@gmail.com>
> To: lttng-dev@lists.lttng.org
> Sent: Friday, December 6, 2013 10:47:37 PM
> Subject: [lttng-dev] What are sys calls starting with compat?

> Can someone kindly explain the difference between system calls starting with
> "compat" prefix and regular system calls?

System calls with "compat" prefix are for e.g. 32-bit processes running on a 64-bit kernel: those processes are using a different system call table (ia32 for Intel) than 64-bit processes, and therefore those system calls are named "compat_*" by LTTng. 

Thanks, 

Mathieu 

> Compat system calls do not appear in the system call table:
> http://syscalls.kernelgrok.com/ . However, I did found them in the source
> code of Linux.

> Thanks,
> Shariyar

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_82288_1627185296.1386640548754
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><hr id=3D"zwchr"><blockquote style=3D=
"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;=
font-weight:normal;font-style:normal;text-decoration:none;font-family:Helve=
tica,Arial,sans-serif;font-size:12pt;"><b>From: </b>"Shariyar" &lt;syed.sha=
riyar@gmail.com&gt;<br><b>To: </b>lttng-dev@lists.lttng.org<br><b>Sent: </b=
>Friday, December 6, 2013 10:47:37 PM<br><b>Subject: </b>[lttng-dev] What a=
re sys calls starting with compat?<br><div><br></div><div dir=3D"ltr"><div>=
<div>Can someone kindly explain the difference between system calls startin=
g with "compat" prefix and regular system calls?</div></div></div></blockqu=
ote><div><br></div><div>System calls with "compat" prefix are for e.g. 32-b=
it processes running on a 64-bit kernel: those processes are using a differ=
ent system call table (ia32 for Intel) than 64-bit processes, and therefore=
 those system calls are named "compat_*" by LTTng.<br></div><div><br></div>=
<div>Thanks,<br></div><div><br></div><div>Mathieu<br></div><div><br></div><=
blockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-l=
eft:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:non=
e;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr">=
<div><div><div><br></div>&nbsp;Compat system calls do not appear in the sys=
tem call table: <a href=3D"http://syscalls.kernelgrok.com/" target=3D"_blan=
k">http://syscalls.kernelgrok.com/</a>. However, I did found them in the so=
urce code of Linux.<br><br></div>Thanks,<br></div>Shariyar<br></div><br>___=
____________________________________________<br>lttng-dev mailing list<br>l=
ttng-dev@lists.lttng.org<br>http://lists.lttng.org/cgi-bin/mailman/listinfo=
/lttng-dev<br></blockquote><div><br><br></div><div><br></div><div>-- <br></=
div><div><span name=3D"x"></span>Mathieu Desnoyers<br>EfficiOS Inc.<br>http=
://www.efficios.com<span name=3D"x"></span><br></div></div></body></html>
------=_Part_82288_1627185296.1386640548754--


--===============1729788109==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1729788109==--
