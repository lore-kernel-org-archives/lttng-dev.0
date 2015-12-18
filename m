From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: A strange problem encountered using urcu-based
	hash	table
Date: Fri, 18 Dec 2015 20:26:30 +0000 (UTC)
Message-ID: <2117619532.264122.1450470390420.JavaMail.zimbra__39465.4960641221$1450470463$gmane$org@efficios.com>
References: <CAN0x0o0AEp=jMF1HD1sunGegTc9D-76x5hGVMf+8CLvoxmNiaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1212705054=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1aA1br-0006Fi-Mj
 for lttng-dev@lists.lttng.org; Fri, 18 Dec 2015 15:26:45 -0500
In-Reply-To: <CAN0x0o0AEp=jMF1HD1sunGegTc9D-76x5hGVMf+8CLvoxmNiaw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?utf-8?B?6ZmI5b+X5paH?= <zwchen@aimlab.org>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1212705054==
Content-Type: multipart/alternative;
	boundary="----=_Part_264121_1561099078.1450470390419"

------=_Part_264121_1561099078.1450470390419
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

----- On Dec 18, 2015, at 5:02 AM, =E9=99=88=E5=BF=97=E6=96=87 <zwchen@aiml=
ab.org> wrote:=20

> Hi, I'm a Ph.D from Hunan University of China. Recently, our group are te=
nding
> to analysis concurrent hash tables using different synchronization mechan=
isms,
> urcu-based hashing is one of our targets. Today, we running an urcu-based=
 hash
> table with only ten percent update operations. We found its CPU utilizati=
on is
> only 3% (while in a read-only workload, the CPU utilization is 50%). Is t=
here
> any writer performance limits for urcu? Or why this happened in your eye?
> There is our platform information: Intel SandyBridge EP with 2 sockets, e=
ach
> sockets with 8 cores and 2 physical threads for each core. OS: Ubuntu 14.=
04
> LTS.
> Experimental configuration: 16 threads, ten percent of update operations =
and 1
> million initial elements in hash table.

Are you invoking "synchronize_rcu()" after each removal from the hash table=
 directly=20
from your updater thread ? This would very likely explain a low CPU utiliza=
tion.=20

I would recommend using the call_rcu() mechanism to batch those synchronize=
_rcu()=20
calls if you don't use it already.=20

If it's not your situation, then emailing us a copy of your test code would=
 likely help us=20
pinpoint the slowdown cause.=20

Thanks,=20

Mathieu=20

> We are looking forward for your reply.

> Thanks!

> --
> aimlab zwchen

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

------=_Part_264121_1561099078.1450470390419
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><br></div><span id=3D"zwchr" data-marker=3D=
"__DIVIDER__">----- On Dec 18, 2015, at 5:02 AM, =E9=99=88=E5=BF=97=E6=96=
=87 &lt;zwchen@aimlab.org&gt; wrote:<br></span><div data-marker=3D"__QUOTED=
_TEXT__"><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5px=
;padding-left:5px;color:#000;font-weight:normal;font-style:normal;text-deco=
ration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div di=
r=3D"ltr">Hi, I'm a Ph.D from Hunan University of China. Recently, our grou=
p are tending to analysis concurrent hash tables using different synchroniz=
ation mechanisms, urcu-based hashing is one of our targets. Today, we runni=
ng an urcu-based hash table with only ten percent update operations. We fou=
nd its CPU utilization is only 3% (while in a read-only workload, the CPU u=
tilization is 50%). Is there any writer performance limits for urcu? Or why=
 this happened in your eye?<br><div>There is our platform information: Inte=
l SandyBridge EP with 2 sockets, each sockets with 8 cores and 2 physical t=
hreads for each core. OS: Ubuntu 14.04 LTS.</div><div>Experimental configur=
ation: 16 threads, ten percent of update operations and 1 million initial e=
lements in hash table.</div></div></blockquote><div><br></div><div>Are you =
invoking "synchronize_rcu()" after each removal from the hash table directl=
y<br data-mce-bogus=3D"1"></div><div>from your updater thread ? This would =
very likely explain a low CPU utilization.<br data-mce-bogus=3D"1"></div><d=
iv><br data-mce-bogus=3D"1"></div><div>I would recommend using the call_rcu=
() mechanism to batch those synchronize_rcu()<br data-mce-bogus=3D"1"></div=
><div>calls if you don't use it already.<br data-mce-bogus=3D"1"></div><div=
><br data-mce-bogus=3D"1"></div><div>If it's not your situation, then email=
ing us a copy of your test code would likely help us</div><div>pinpoint the=
 slowdown cause.<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1=
"></div><div>Thanks,<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=
=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1"></div><div><br data-mce-b=
ogus=3D"1"></div><blockquote style=3D"border-left:2px solid #1010FF;margin-=
left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;t=
ext-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"=
><div dir=3D"ltr"><br><div>We are looking forward for your reply.</div><br>=
<div>Thanks!&nbsp;<br clear=3D"all"><br>-- <br><div class=3D"gmail_signatur=
e"><div dir=3D"ltr">aimlab zwchen</div></div></div></div><br>______________=
_________________________________<br>lttng-dev mailing list<br>lttng-dev@li=
sts.lttng.org<br>http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<=
br></blockquote></div><br><div data-marker=3D"__SIG_POST__">-- <br></div><d=
iv>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com</div></div=
></body></html>
------=_Part_264121_1561099078.1450470390419--


--===============1212705054==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1212705054==--
