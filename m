From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Build Issue - lttng-modules - cross compiling
	for	MIPSEL - syscall.h
Date: Tue, 12 Nov 2013 19:44:59 +0000 (UTC)
Message-ID: <415109851.65357.1384285499971.JavaMail.zimbra__48704.8593037345$1384285560$gmane$org@efficios.com>
References: <CAP0pN0uFfyA1GFjcDrqQ+QML_c0eLT-jksqYS0ZAt=C+==Lo7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1696195755=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VgJtV-0002r7-Tr
	for lttng-dev@lists.lttng.org; Tue, 12 Nov 2013 14:45:07 -0500
In-Reply-To: <CAP0pN0uFfyA1GFjcDrqQ+QML_c0eLT-jksqYS0ZAt=C+==Lo7A@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Shreyas Joshi <shreyasjoshi11@gmail.com>, Ralf Baechle <ralf@linux-mips.org>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1696195755==
Content-Type: multipart/alternative;
	boundary="----=_Part_65356_783274223.1384285499970"

------=_Part_65356_783274223.1384285499970
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- Original Message -----

> From: "Shreyas Joshi" <shreyasjoshi11@gmail.com>
> To: lttng-dev@lists.lttng.org
> Sent: Friday, November 8, 2013 2:11:55 AM
> Subject: [lttng-dev] Build Issue - lttng-modules - cross compiling for MIPSEL
> - syscall.h

> Hi,

> As you are aware that in mips linux there is no such file called -

> #include <asm/syscall.h>

> If I comment this line, then it get the issue for this function -

> error: implicit declaration of function 'syscall_get_arguments'

> It cannot find the syscall_get_arguments. Do you support lttng-modules for
> mips platform?
> Is there any patch for it? I am stuck at the moment. Any help will be much
> appreciated.

Adding Ralf Baechle who contributed the MIPS system call support. 

What kernel version are you building against ? Can we have a copy of your .config file ? 

What lttng-modules version are you using ? 

Thanks, 

Mathieu 

> --
> Thanks & regards

> Shreyas Joshi

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_65356_783274223.1384285499970
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><hr id=3D"zwchr"><blockquote style=3D=
"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;=
font-weight:normal;font-style:normal;text-decoration:none;font-family:Helve=
tica,Arial,sans-serif;font-size:12pt;"><b>From: </b>"Shreyas Joshi" &lt;shr=
eyasjoshi11@gmail.com&gt;<br><b>To: </b>lttng-dev@lists.lttng.org<br><b>Sen=
t: </b>Friday, November 8, 2013 2:11:55 AM<br><b>Subject: </b>[lttng-dev] B=
uild Issue - lttng-modules - cross compiling for&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;MIPSEL - syscall.h<br><div><br></div><div dir=3D"ltr">=
<div><div><div>Hi,<br><div><br></div>As you are aware that in mips linux th=
ere is no such file called - <br><div><br></div>#include &lt;asm/syscall.h&=
gt;<br><div><br></div></div>If I comment this line, then it get the issue f=
or this function - <br><br>error: implicit declaration of function 'syscall=
_get_arguments'<br><div><br></div><br></div>It cannot find the syscall_get_=
arguments. Do you support lttng-modules for mips platform?<br></div>Is ther=
e any patch for it? I am stuck at the moment. Any help will be much appreci=
ated. <br clear=3D"all"></div></blockquote><div><br></div><div>Adding Ralf =
Baechle who contributed the MIPS system call support.<br></div><div><br></d=
iv><div>What kernel version are you building against ? Can we have a copy o=
f your .config file ?<br></div><div><br></div><div>What lttng-modules versi=
on are you using ?<br></div><div><br></div><div>Thanks,<br></div><div><br><=
/div><div>Mathieu<br></div><div><br></div><blockquote style=3D"border-left:=
2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:n=
ormal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sa=
ns-serif;font-size:12pt;"><div dir=3D"ltr"><div><div><div><div><div>-- <br>=
Thanks &amp; regards<br><div><br></div>Shreyas Joshi
</div></div></div></div></div></div><br>___________________________________=
____________<br>lttng-dev mailing list<br>lttng-dev@lists.lttng.org<br>http=
://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<br></blockquote><div>=
<br><br></div><div><br></div><div>-- <br></div><div><span name=3D"x"></span=
>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com<span name=3D=
"x"></span><br></div></div></body></html>
------=_Part_65356_783274223.1384285499970--


--===============1696195755==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1696195755==--
