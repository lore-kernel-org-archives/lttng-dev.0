From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Build Issue - lttng-modules - cross compiling for
 MIPSEL - syscall.h
Date: Mon, 18 Nov 2013 16:32:17 +0000 (UTC)
Message-ID: <343869476.70337.1384792337904.JavaMail.zimbra__26293.1317709901$1384792458$gmane$org@efficios.com>
References: <CAP0pN0uFfyA1GFjcDrqQ+QML_c0eLT-jksqYS0ZAt=C+==Lo7A@mail.gmail.com>
	<415109851.65357.1384285499971.JavaMail.zimbra@efficios.com>
	<CAP0pN0v_xaC8iZ=mDwGCbWtfyhGQ7TCsnBmXy+qXtTFUKjmKpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1168215033=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1ViRkJ-0006LZ-IE
	for lttng-dev@lists.lttng.org; Mon, 18 Nov 2013 11:32:25 -0500
In-Reply-To: <CAP0pN0v_xaC8iZ=mDwGCbWtfyhGQ7TCsnBmXy+qXtTFUKjmKpQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Shreyas Joshi <shreyasjoshi11@gmail.com>
Cc: lttng-dev@lists.lttng.org, Ralf Baechle <ralf@linux-mips.org>
List-Id: lttng-dev@lists.lttng.org

--===============1168215033==
Content-Type: multipart/alternative;
	boundary="----=_Part_70336_1732624628.1384792337902"

------=_Part_70336_1732624628.1384792337902
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

If you don't want this issue to be lost, please open a bug report against lttng-modules on bugs.lttng.org will all the relevant info (kernel version, lttng-modules version, .config, how to reproduce, bug detail) 

Thanks. 

Mathieu 

----- Original Message -----

> From: "Shreyas Joshi" <shreyasjoshi11@gmail.com>
> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: "Ralf Baechle" <ralf@linux-mips.org>, lttng-dev@lists.lttng.org
> Sent: Wednesday, November 13, 2013 1:00:38 AM
> Subject: Re: [lttng-dev] Build Issue - lttng-modules - cross compiling for
> MIPSEL - syscall.h

> Thanks! I am using kernel version - 3.3.8-2.4. I have attached the
> configuration here.
> The lttng-module version used is 2.3.0. Please do help me.

> Thanks & regards,
> Shreyas Joshi

> On Wed, Nov 13, 2013 at 1:14 AM, Mathieu Desnoyers <
> mathieu.desnoyers@efficios.com > wrote:

> > > From: "Shreyas Joshi" < shreyasjoshi11@gmail.com >
> > 
> 
> > > To: lttng-dev@lists.lttng.org
> > 
> 
> > > Sent: Friday, November 8, 2013 2:11:55 AM
> > 
> 
> > > Subject: [lttng-dev] Build Issue - lttng-modules - cross compiling for
> > > MIPSEL
> > > - syscall.h
> > 
> 

> > > Hi,
> > 
> 

> > > As you are aware that in mips linux there is no such file called -
> > 
> 

> > > #include <asm/syscall.h>
> > 
> 

> > > If I comment this line, then it get the issue for this function -
> > 
> 

> > > error: implicit declaration of function 'syscall_get_arguments'
> > 
> 

> > > It cannot find the syscall_get_arguments. Do you support lttng-modules
> > > for
> > > mips platform?
> > 
> 
> > > Is there any patch for it? I am stuck at the moment. Any help will be
> > > much
> > > appreciated.
> > 
> 

> > Adding Ralf Baechle who contributed the MIPS system call support.
> 

> > What kernel version are you building against ? Can we have a copy of your
> > .config file ?
> 

> > What lttng-modules version are you using ?
> 

> > Thanks,
> 

> > Mathieu
> 

> > > --
> > 
> 
> > > Thanks & regards
> > 
> 

> > > Shreyas Joshi
> > 
> 

> > > _______________________________________________
> > 
> 
> > > lttng-dev mailing list
> > 
> 
> > > lttng-dev@lists.lttng.org
> > 
> 
> > > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> > 
> 

> > --
> 
> > Mathieu Desnoyers
> 
> > EfficiOS Inc.
> 
> > http://www.efficios.com
> 

> --
> Thanks & regards

> Shreyas Joshi

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_70336_1732624628.1384792337902
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><div>If you don't want this issue to =
be lost, please open a bug report against lttng-modules on bugs.lttng.org w=
ill all the relevant info (kernel version, lttng-modules version, .config, =
how to reproduce, bug detail)<br></div><div><br></div><div>Thanks.<br></div=
><div><br></div><div>Mathieu<br></div><div><br></div><div><br></div><hr id=
=3D"zwchr"><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5=
px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;text-de=
coration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><b>Fr=
om: </b>"Shreyas Joshi" &lt;shreyasjoshi11@gmail.com&gt;<br><b>To: </b>"Mat=
hieu Desnoyers" &lt;mathieu.desnoyers@efficios.com&gt;<br><b>Cc: </b>"Ralf =
Baechle" &lt;ralf@linux-mips.org&gt;, lttng-dev@lists.lttng.org<br><b>Sent:=
 </b>Wednesday, November 13, 2013 1:00:38 AM<br><b>Subject: </b>Re: [lttng-=
dev] Build Issue - lttng-modules - cross compiling for MIPSEL - syscall.h<b=
r><div><br></div><div dir=3D"ltr"><div>Thanks! I am using kernel version - =
3.3.8-2.4. I have attached the configuration here.<br></div>The lttng-modul=
e version used is 2.3.0. Please do help me.<br><div><br></div>Thanks &amp; =
regards,<br>Shreyas Joshi<br>
</div><div class=3D"gmail_extra"><br><div><br></div><div class=3D"gmail_quo=
te">On Wed, Nov 13, 2013 at 1:14 AM, Mathieu Desnoyers <span dir=3D"ltr">&l=
t;<a href=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_blank">mathi=
eu.desnoyers@efficios.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div><div style=3D"font-size:12pt;font-famil=
y:times new roman,new york,times,serif"><hr><blockquote style=3D"padding-le=
ft:5px;font-size:12pt;font-style:normal;margin-left:5px;font-family:Helveti=
ca,Arial,sans-serif;text-decoration:none;font-weight:normal;border-left:2px=
 solid #1010ff">
<b>From: </b>"Shreyas Joshi" &lt;<a href=3D"mailto:shreyasjoshi11@gmail.com=
" target=3D"_blank">shreyasjoshi11@gmail.com</a>&gt;<br><b>To: </b><a href=
=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.ltt=
ng.org</a><br>
<b>Sent: </b>Friday, November 8, 2013 2:11:55 AM<br><b>Subject: </b>[lttng-=
dev] Build Issue - lttng-modules - cross compiling for&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;MIPSEL - syscall.h<div><div class=3D"h5"><br><di=
v><br></div><div dir=3D"ltr"><div><div><div>
Hi,<br><div><br></div>As you are aware that in mips linux there is no such =
file called - <br><div><br></div>#include &lt;asm/syscall.h&gt;<br><div><br=
></div></div>If I comment this line, then it get the issue for this functio=
n - <br>
<br>error: implicit declaration of function 'syscall_get_arguments'<br><div=
><br></div><br></div>It cannot find the syscall_get_arguments. Do you suppo=
rt lttng-modules for mips platform?<br></div>Is there any patch for it? I a=
m stuck at the moment. Any help will be much appreciated. <br clear=3D"all"=
>
</div></div></div></blockquote><div><br></div><div>Adding Ralf Baechle who =
contributed the MIPS system call support.<br></div><div><br></div><div>What=
 kernel version are you building against ? Can we have a copy of your .conf=
ig file ?<br>
</div><div><br></div><div>What lttng-modules version are you using ?<br></d=
iv><div><br></div><div>Thanks,<br></div><div><br></div><div>Mathieu<br></di=
v><div><br></div><blockquote style=3D"padding-left:5px;font-size:12pt;font-=
style:normal;margin-left:5px;font-family:Helvetica,Arial,sans-serif;text-de=
coration:none;font-weight:normal;border-left:2px solid #1010ff">
<div class=3D"im"><div dir=3D"ltr"><div><div><div><div><div>-- <br>Thanks &=
amp; regards<br><div><br></div>Shreyas Joshi
</div></div></div></div></div></div><br></div>_____________________________=
__________________<br>lttng-dev mailing list<br><a href=3D"mailto:lttng-dev=
@lists.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a><br><a hre=
f=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" target=3D"_=
blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><span c=
lass=3D"HOEnZb"><span style=3D"color: #888888;" data-mce-style=3D"color: #8=
88888;" color=3D"#888888"><br>
</span></span></blockquote><span class=3D"HOEnZb"><span style=3D"color: #88=
8888;" data-mce-style=3D"color: #888888;" color=3D"#888888"><div><br><div><=
br></div></div><div><br></div><div>-- <br></div><div><span></span>Mathieu D=
esnoyers<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com" target=3D"=
_blank">http://www.efficios.com</a><span></span><br>
</div></span></span></div></div></blockquote></div><br><br clear=3D"all"><b=
r>-- <br>Thanks &amp; regards<br><div><br></div>Shreyas Joshi
</div>
</blockquote><div><br><br></div><div><br></div><div>-- <br></div><div><span=
 name=3D"x"></span>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficio=
s.com<span name=3D"x"></span><br></div></div></body></html>
------=_Part_70336_1732624628.1384792337902--


--===============1168215033==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1168215033==--
