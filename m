From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Tracepoints overhead in x86_64
Date: Thu, 3 Oct 2013 12:50:21 +0000 (UTC)
Message-ID: <1686324762.28278.1380804621255.JavaMail.zimbra__5704.22448586232$1380804683$gmane$org@efficios.com>
References: <CAJWsiu=og9Xnt4m31e1KGqDnEaCq9QWe8HnW5RE4foh4KCo5XA@mail.gmail.com>
	<20130831202107.GA21499@Krystal>
	<CAJWsiukmE7s1KkLwg_EJy_fsX4BsQYLb+R_skFBM6YQ_S6FB6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0219397528=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VRiMN-0008Pz-LC
	for lttng-dev@lists.lttng.org; Thu, 03 Oct 2013 08:50:34 -0400
In-Reply-To: <CAJWsiukmE7s1KkLwg_EJy_fsX4BsQYLb+R_skFBM6YQ_S6FB6Q@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Gianluca Borello <g.borello@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0219397528==
Content-Type: multipart/alternative;
	boundary="----=_Part_28277_729557355.1380804621254"

------=_Part_28277_729557355.1380804621254
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- Original Message -----

> From: "Gianluca Borello" <g.borello@gmail.com>
> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: lttng-dev@lists.lttng.org
> Sent: Saturday, August 31, 2013 6:16:35 PM
> Subject: Re: [lttng-dev] Tracepoints overhead in x86_64

> On Aug 31, 2013 1:21 PM, "Mathieu Desnoyers" < mathieu.desnoyers@efficios.com
> > wrote:
> >
> > My recommendation would be to implement a dummy trace_sys_enter and
> > trace_sys_exit, and then benchmark the overhead of enabling system call
> > tracing (this will set TIF_SYSCALL_TRACEPOINT in every thread). So at
> > least it would help you pinpoint where most of the overhead comes from.
> >

> Yes, I already did that before writing the patch I attached in the previous
> mail, and I can confirm that simply setting TIF_SYSCALL_TRACEPOINT in all
> threads (without registering any tracepoint) shows the same overhead.
Good to know! 

> > Indeed, if you come up with ways to shrink the overhead of this "slow
> > path", I'm sure the LTTng community would gladly welcome this. Of
> > course, these changes would have to be proposed to the Linux kernel
> > community. You will need to keep in mind that they will frown upon
> > pretty much _any_ slowdown of the fast path (common case, no tracing)
> > for improving the speed of the slow (uncommon) case.
> >

> That might be interesting.
> I guess I have a couple of questions:

> 1) Where do you think I could find an answer to the question "can
> trace_sys_enter be safely called from the fast path?". In my tests it worked
> just fine, but I'm concerned that calling the tracepoint without using the
> IRET slow path could lead to the potential DoS the commit was fixing.
I'm concerned that it could not be called safely from fast path. You might want to ask the x86 Linux kernel maintainers about this, CCing linux-kernel@vger.kernel.org 

> 2) How do you think the kernel community would react to a patch that adds the
> tracepoint call to the fast path? Basically, if it works, I'd check the
> TIF_SYSCALL_TRACEPOINT directly in the fast path and, if set, I would
> proceed in saving the registers and calling the probes, so in the common
> case there would be just one more check against the current thread's flags.
As soon as they can notice any overhead on some crazy workloads, they will probably refuse the change. You should try, and ask them which workloads they care about, and try to prove them that it does not have any perceivable impact on performances. However, success is far from guaranteed. 

Another approach you could take is to wrap this call in a macro, that expands either to the tracing call if CONFIG_TRACE_SYSCALL_FASTPATH is set, or to nothing otherwise (default to nothing). Therefore, if yourself, or a distribution, care about tracing speed more than usual, they can tune their kernel at compile time. 

Thanks, 

Mathieu 

> Thank you again!
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_28277_729557355.1380804621254
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><div><br></div><div><br></div><hr id=
=3D"zwchr"><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5=
px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;text-de=
coration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><b>Fr=
om: </b>"Gianluca Borello" &lt;g.borello@gmail.com&gt;<br><b>To: </b>"Mathi=
eu Desnoyers" &lt;mathieu.desnoyers@efficios.com&gt;<br><b>Cc: </b>lttng-de=
v@lists.lttng.org<br><b>Sent: </b>Saturday, August 31, 2013 6:16:35 PM<br><=
b>Subject: </b>Re: [lttng-dev] Tracepoints overhead in x86_64<br><div><br><=
/div><p dir=3D"ltr"><br>
On Aug 31, 2013 1:21 PM, "Mathieu Desnoyers" &lt;<a href=3D"mailto:mathieu.=
desnoyers@efficios.com" target=3D"_blank">mathieu.desnoyers@efficios.com</a=
>&gt; wrote:<br>
&gt;<br>
&gt; My recommendation would be to implement a dummy trace_sys_enter and<br=
>
&gt; trace_sys_exit, and then benchmark the overhead of enabling system cal=
l<br>
&gt; tracing (this will set TIF_SYSCALL_TRACEPOINT in every thread). So at<=
br>
&gt; least it would help you pinpoint where most of the overhead comes from=
.<br>
&gt;</p><p dir=3D"ltr">Yes, I already did that before writing the patch I a=
ttached in the previous mail, and I can confirm that simply setting&nbsp; T=
IF_SYSCALL_TRACEPOINT in all threads (without registering any tracepoint) s=
hows the same overhead.</p></blockquote><div><br></div><div>Good to know!<b=
r></div><div><br></div><blockquote style=3D"border-left:2px solid #1010FF;m=
argin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:no=
rmal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:=
12pt;"><p dir=3D"ltr">&gt; Indeed, if you come up with ways to shrink the o=
verhead of this "slow<br>
&gt; path", I'm sure the LTTng community would gladly welcome this. Of<br>
&gt; course, these changes would have to be proposed to the Linux kernel<br=
>
&gt; community. You will need to keep in mind that they will frown upon<br>
&gt; pretty much _any_ slowdown of the fast path (common case, no tracing)<=
br>
&gt; for improving the speed of the slow (uncommon) case.<br>
&gt;</p><p dir=3D"ltr">That might be interesting.<br>
I guess I have a couple of questions:</p><p dir=3D"ltr">1) Where do you thi=
nk I could find an answer to the question "can trace_sys_enter be safely ca=
lled from the fast path?". In my tests it worked just fine, but I'm concern=
ed that calling the tracepoint without using the IRET slow path could lead =
to the potential DoS the commit was fixing.</p></blockquote><div><br></div>=
<div>I'm concerned that it could not be called safely from fast path. You m=
ight want to ask the x86 Linux kernel maintainers about this, CCing linux-k=
ernel@vger.kernel.org<br></div><div><br></div><blockquote style=3D"border-l=
eft:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weig=
ht:normal;font-style:normal;text-decoration:none;font-family:Helvetica,Aria=
l,sans-serif;font-size:12pt;"><p dir=3D"ltr">2) How do you think the kernel=
 community would react to a patch that adds the tracepoint call to the fast=
 path? Basically, if it works, I'd check the TIF_SYSCALL_TRACEPOINT directl=
y in the fast path and, if set, I would proceed in saving the registers and=
 calling the probes, so in the common case there would be just one more che=
ck against the current thread's flags.</p></blockquote><div><br></div><div>=
As soon as they can notice any overhead on some crazy workloads, they will =
probably refuse the change. You should try, and ask them which workloads th=
ey care about, and try to prove them that it does not have any perceivable =
impact on performances. However, success is far from guaranteed.<br></div><=
div><br></div><div>Another approach you could take is to wrap this call in =
a macro, that expands either to the tracing call if CONFIG_TRACE_SYSCALL_FA=
STPATH is set, or to nothing otherwise (default to nothing). Therefore, if =
yourself, or a distribution, care about tracing speed more than usual, they=
 can tune their kernel at compile time.<br></div><div><br></div><div>Thanks=
,<br></div><div><br></div><div>Mathieu<br></div><div><br></div><blockquote =
style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;col=
or:#000;font-weight:normal;font-style:normal;text-decoration:none;font-fami=
ly:Helvetica,Arial,sans-serif;font-size:12pt;"><p dir=3D"ltr">Thank you aga=
in!</p><br>_______________________________________________<br>lttng-dev mai=
ling list<br>lttng-dev@lists.lttng.org<br>http://lists.lttng.org/cgi-bin/ma=
ilman/listinfo/lttng-dev<br></blockquote><div><br><br></div><div><br></div>=
<div>-- <br></div><div><span name=3D"x"></span>Mathieu Desnoyers<br>EfficiO=
S Inc.<br>http://www.efficios.com<span name=3D"x"></span><br></div></div></=
body></html>
------=_Part_28277_729557355.1380804621254--


--===============0219397528==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0219397528==--
