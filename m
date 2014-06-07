From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules] Fix: blktrace instrumentation
 for	backported branches
Date: Sat, 7 Jun 2014 15:17:13 +0000 (UTC)
Message-ID: <598170477.28122.1402154233383.JavaMail.zimbra__25246.3329853073$1402154274$gmane$org@efficios.com>
References: <CA+MZcXvcHsLm3y5hyTSU718OfPF5cP2A_+XOoesOJ6898iK-mQ@mail.gmail.com>
 <2019538324.28072.1402154174077.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0138320531=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1WtIMu-0001fR-8i
 for lttng-dev@lists.lttng.org; Sat, 07 Jun 2014 11:17:17 -0400
In-Reply-To: <2019538324.28072.1402154174077.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Antoine Busque <antoine.busque@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0138320531==
Content-Type: multipart/alternative;
	boundary="----=_Part_28121_2072133068.1402154233382"

------=_Part_28121_2072133068.1402154233382
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- Original Message -----

> From: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> To: "Antoine Busque" <antoine.busque@efficios.com>
> Cc: lttng-dev@lists.lttng.org
> Sent: Saturday, June 7, 2014 11:16:14 AM
> Subject: Re: [lttng-dev] [PATCH lttng-modules] Fix: blktrace instrumentation
> for backported branches

> ----- Original Message -----

> > From: "Antoine Busque" <antoine.busque@efficios.com>
> 
> > To: lttng-dev@lists.lttng.org
> 
> > Sent: Friday, June 6, 2014 6:00:59 PM
> 
> > Subject: [lttng-dev] [PATCH lttng-modules] Fix: blktrace instrumentation
> > for
> > backported branches
> 

> > The following commit from kernel 3.15 changing the API of a block layer
> 
> > tracepoint has been backported to multiple branches:
> 

> > commit af5040da01ef980670b3741b3e10733ee3e33566
> 
> > Author: Roman Pen < r.peniaev@gmail.com >
> 
> > Date: Tue Mar 4 23:13:10 2014 +0900
> 

> > blktrace: fix accounting of partially completed requests
> 

> > This patch fixes the resulting build failure by adding the proper
> 
> > version checks. The versions and corresponding commit SHA-1 hashes are
> 
> > as follow:
> 

> > 3.2.58
> 
> > commit 5b85afa68e4f56c27f1d5c6f49e5257bce6448e6
> 

> > 3.4.91
> 
> > commit 14eee5bd065d6aac0acbdc6092a25ba68c55b9c8
> 

> > 3.10.41
> 
> > commit e9d933941569c107e0083c3c115467c699a57db2
> 

> > 3.12.21
> 
> > commit 5104b40a981d26212ced149fbd43ad0b6b72910b
> 

> > 3.14.15
> 
> > commit 0a8eda9c00ef37e8b40de77f2b0714317191bcf2
> 

> > Signed-off-by: Antoine Busque < antoine.busque@efficios.com >
> 
> > ---
> 
> > instrumentation/events/lttng-module/block.h | 7 +++++--
> 
> > 1 file changed, 5 insertions(+), 2 deletions(-)
> 

> > diff --git a/instrumentation/events/lttng-module/block.h
> > b/instrumentation/events/lttng-module/block.h
> 
> > index 4f3460e..5684153 100644
> 
> > --- a/instrumentation/events/lttng-module/block.h
> 
> > +++ b/instrumentation/events/lttng-module/block.h
> 
> > @@ -221,8 +221,11 @@ DEFINE_EVENT(block_rq_with_error, block_rq_requeue,
> 
> > TP_ARGS(q, rq)
> 
> > )
> 

> > -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0) \
> 
> > - || LTTNG_KERNEL_RANGE(3,2,58, 3,3,0))
> 
> > +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,14,5) \
> 
> > + || LTTNG_KERNEL_RANGE(3,2,58, 3,3,0) \
> 
> > + || LTTNG_KERNEL_RANGE(3,4,91, 3,5,1) \
> 
> > + || LTTNG_KERNEL_RANGE(3,10,41, 3,11,0) \
> 
> > + || LTTNG_KERNEL_RANGE(3,12,21, 3,13,0))
> 

> It looks like your mail client turns tabs into spaces. Can you fix and
> re-send ?

git-send-email is very likely what you'll want to use. 

Thanks, 

Mathieu 

> thanks,

> Mathieu

> > /**
> 
> > * block_rq_complete - block IO operation completed by device driver
> 
> > --
> 
> > 2.0.0
> 

> > _______________________________________________
> 
> > lttng-dev mailing list
> 
> > lttng-dev@lists.lttng.org
> 
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 

> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_28121_2072133068.1402154233382
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><div><br></div><div><br></div><hr id=
=3D"zwchr"><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5=
px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;text-de=
coration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><b>Fr=
om: </b>"Mathieu Desnoyers" &lt;mathieu.desnoyers@efficios.com&gt;<br><b>To=
: </b>"Antoine Busque" &lt;antoine.busque@efficios.com&gt;<br><b>Cc: </b>lt=
tng-dev@lists.lttng.org<br><b>Sent: </b>Saturday, June 7, 2014 11:16:14 AM<=
br><b>Subject: </b>Re: [lttng-dev] [PATCH lttng-modules] Fix: blktrace inst=
rumentation for&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;backported b=
ranches<br><div><br></div><div style=3D"font-family: times new roman, new y=
ork, times, serif; font-size: 12pt; color: #000000"><div><br></div><hr id=
=3D"zwchr"><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5=
px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;text-de=
coration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><b>Fr=
om: </b>"Antoine Busque" &lt;antoine.busque@efficios.com&gt;<br><b>To: </b>=
lttng-dev@lists.lttng.org<br><b>Sent: </b>Friday, June 6, 2014 6:00:59 PM<b=
r><b>Subject: </b>[lttng-dev] [PATCH lttng-modules] Fix: blktrace instrumen=
tation for&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;backported branch=
es<br><div><br></div><div dir=3D"ltr">The following commit from kernel 3.15=
 changing the API of a block layer<br>tracepoint has been backported to mul=
tiple branches:<br><div><br></div>commit af5040da01ef980670b3741b3e10733ee3=
e33566<br>Author: Roman Pen &lt;<a href=3D"mailto:r.peniaev@gmail.com" targ=
et=3D"_blank">r.peniaev@gmail.com</a>&gt;<br>
Date:&nbsp;&nbsp; Tue Mar 4 23:13:10 2014 +0900<br><div><br></div>&nbsp;&nb=
sp;&nbsp; blktrace: fix accounting of partially completed requests<br><div>=
<br></div>This patch fixes the resulting build failure by adding the proper=
<br>version checks. The versions and corresponding commit SHA-1 hashes are<=
br>
as follow:<br><div><br></div>&nbsp;&nbsp; 3.2.58<br>&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; commit 5b85afa68e4f56c27f1d5c6f49e5257bce6448e6<br><div><br><=
/div>&nbsp;&nbsp; 3.4.91<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; commit 14e=
ee5bd065d6aac0acbdc6092a25ba68c55b9c8<br><div><br></div>&nbsp;&nbsp; 3.10.4=
1<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; commit e9d933941569c107e0083c3c11=
5467c699a57db2<br><div><br></div>&nbsp;&nbsp; 3.12.21<br>&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; commit 5104b40a981d26212ced149fbd43ad0b6b72910b<br><div>=
<br></div>&nbsp;&nbsp; 3.14.15<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; comm=
it 0a8eda9c00ef37e8b40de77f2b0714317191bcf2<br><div><br></div>Signed-off-by=
: Antoine Busque &lt;<a href=3D"mailto:antoine.busque@efficios.com" target=
=3D"_blank">antoine.busque@efficios.com</a>&gt;<br>
---<br>&nbsp;instrumentation/events/lttng-module/block.h | 7 +++++--<br>&nb=
sp;1 file changed, 5 insertions(+), 2 deletions(-)<br><div><br></div>diff -=
-git a/instrumentation/events/lttng-module/block.h b/instrumentation/events=
/lttng-module/block.h<br>
index 4f3460e..5684153 100644<br>--- a/instrumentation/events/lttng-module/=
block.h<br>+++ b/instrumentation/events/lttng-module/block.h<br>@@ -221,8 +=
221,11 @@ DEFINE_EVENT(block_rq_with_error, block_rq_requeue,<br>&nbsp;&nbs=
p;&nbsp;&nbsp; TP_ARGS(q, rq)<br>
&nbsp;)<br><div><br></div>-#if (LINUX_VERSION_CODE &gt;=3D KERNEL_VERSION(3=
,15,0)&nbsp;&nbsp;&nbsp; \<br>-&nbsp;&nbsp;&nbsp; || LTTNG_KERNEL_RANGE(3,2=
,58, 3,3,0))<br>+#if (LINUX_VERSION_CODE &gt;=3D KERNEL_VERSION(3,14,5)&nbs=
p;&nbsp;&nbsp; \<br>+&nbsp;&nbsp;&nbsp; || LTTNG_KERNEL_RANGE(3,2,58, 3,3,0=
)&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp; || LTTNG_KERNEL_RANGE(3,4,91, 3,5,1)&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp; \<br>+&nbsp;&nbsp;&nbsp; || LTTNG_KERNEL_RANGE(3,10,41, =
3,11,0)&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; \<br>+&nbsp;&nbsp;&nbsp; || LT=
TNG_KERNEL_RANGE(3,12,21, 3,13,0))</div></blockquote><div>It looks like you=
r mail client turns tabs into spaces. Can you fix and re-send ?</div></div>=
</blockquote><div>git-send-email is very likely what you'll want to use.<br=
></div><div><br></div><div>Thanks,<br></div><div><br></div><div>Mathieu<br>=
</div><div><br></div><div><br></div><blockquote style=3D"border-left:2px so=
lid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;=
font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-ser=
if;font-size:12pt;"><div style=3D"font-family: times new roman, new york, t=
imes, serif; font-size: 12pt; color: #000000"><div><br></div><div><br></div=
><div>thanks,<br></div><div><br></div><div>Mathieu<br></div><div><br></div>=
<div><br></div><blockquote style=3D"border-left:2px solid #1010FF;margin-le=
ft:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;tex=
t-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><=
div dir=3D"ltr"><br><div><br></div>&nbsp;/**<br>&nbsp; * block_rq_complete =
- block IO operation completed by device driver<br>
-- <br>2.0.0<br><div><br></div><br></div><br>______________________________=
_________________<br>lttng-dev mailing list<br>lttng-dev@lists.lttng.org<br=
>http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<br></blockquote>=
<div><br><div><br></div></div><div><br></div><div>-- <br></div><div>Mathieu=
 Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com<br></div></div></blo=
ckquote><div><br><br></div><div><br></div><div>-- <br></div><div><span name=
=3D"x"></span>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com=
<span name=3D"x"></span><br></div></div></body></html>
------=_Part_28121_2072133068.1402154233382--


--===============0138320531==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0138320531==--
