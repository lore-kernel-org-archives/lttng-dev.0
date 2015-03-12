From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Alternative to signals/sys_membarrier() in liburcu
Date: Thu, 12 Mar 2015 20:53:08 +0000 (UTC)
Message-ID: <666590480.287502.1426193588471.JavaMail.zimbra__17866.506384644$1426193661$gmane$org@efficios.com>
References: <CANW5cDmTCM9ZmhN7-2eWUEYvD+Y=sGt2i7mecdPTTLHMcT8fPg@mail.gmail.com>
 <867044376.285926.1426172227750.JavaMail.zimbra@efficios.com>
 <CANW5cDkiZoysNM3rqb4v6Tj996ocsaSh=OZoBLfp4h7ZGb4bxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0998762530=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1YWA6W-0005NH-8m
 for lttng-dev@lists.lttng.org; Thu, 12 Mar 2015 16:53:20 -0400
In-Reply-To: <CANW5cDkiZoysNM3rqb4v6Tj996ocsaSh=OZoBLfp4h7ZGb4bxg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Michael Sullivan <sully@msully.net>
Cc: Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, lttng-dev@lists.lttng.org, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>
List-Id: lttng-dev@lists.lttng.org

--===============0998762530==
Content-Type: multipart/alternative;
	boundary="----=_Part_287501_1604231795.1426193588469"

------=_Part_287501_1604231795.1426193588469
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi, 

Michael Sullivan proposed a clever hack abusing mprotect() to 
perform the same effect as sys_membarrier() I submitted a few 
years ago ( https://lkml.org/lkml/2010/4/18/15 ). 

At that time, the sys_membarrier implementation was deemed 
technically sound, but there were not enough users of the system call 
to justify its inclusion. 

So far, the number of users of liburcu has increased, but liburcu 
still appears to be the only direct user of sys_membarrier. On this 
front, we could argue that many other system calls have only 
one user: glibc. In that respect, liburcu is quite similar to glibc. 

So the question as it stands appears to be: would you be comfortable 
having users abuse mprotect(), relying on its side-effect of issuing 
a smp_mb() on each targeted CPU for the TLB shootdown, as 
an effective implementation of process-wide memory barrier ? 

Thoughts ? 

Thanks! 

Mathieu 

----- Original Message -----

> From: "Michael Sullivan" <sully@msully.net>
> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: lttng-dev@lists.lttng.org
> Sent: Thursday, March 12, 2015 12:04:07 PM
> Subject: Re: [lttng-dev] Alternative to signals/sys_membarrier() in liburcu

> On Thu, Mar 12, 2015 at 10:57 AM, Mathieu Desnoyers <
> mathieu.desnoyers@efficios.com > wrote:

> > Even though it depends on internal behavior not currently specified by
> > mprotect,
> 
> > I'd very much like to see the prototype you have,
> 

> I ended up posting my code at
> https://github.com/msullivan/userspace-rcu/tree/msync-barrier .
> The interesting patch is
> https://github.com/msullivan/userspace-rcu/commit/04656b468d418efbc5d934ab07954eb8395a7ab0
> .

> Quick blog post I wrote about it at
> http://www.msully.net/blog/2015/02/24/forcing-memory-barriers-on-other-cpus-with-mprotect2/
> .
> (I talked briefly about sys_membarrier in the post as best as I could piece
> together from LKML; if my comment on it is inaccurate I can edit the post.)

> -Michael Sullivan

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_287501_1604231795.1426193588469
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><div>Hi,<br></div><div><br></div><div=
>Michael Sullivan proposed a clever hack abusing mprotect() to</div><div>pe=
rform the same effect as sys_membarrier() I submitted a few</div><div>years=
 ago (<a href=3D"https://lkml.org/lkml/2010/4/18/15">https://lkml.org/lkml/=
2010/4/18/15</a>).<br></div><div><br></div><div>At that time, the sys_memba=
rrier implementation was deemed</div><div>technically sound, but there were=
 not enough users of the system call</div><div>to justify its inclusion.<br=
></div><div><br></div><div>So far, the number of users of liburcu has incre=
ased, but liburcu<br></div><div>still appears to be the only direct user of=
 sys_membarrier. On this</div><div>front, we could argue that many other sy=
stem calls have only</div><div>one user: glibc. In that respect, liburcu is=
 quite similar to glibc.<br></div><div><br></div><div>So the question as it=
 stands appears to be: would you be comfortable<br></div><div>having users =
abuse mprotect(), relying on its side-effect of issuing<br></div><div>a smp=
_mb() on each targeted CPU for the TLB shootdown, as<br></div><div>an effec=
tive implementation of process-wide memory barrier ?<br></div><div><br></di=
v><div>Thoughts ?<br></div><div><br></div><div>Thanks!<br></div><div><br></=
div><div>Mathieu<br></div><div><br></div><div><br></div><hr id=3D"zwchr"><b=
lockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-le=
ft:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:none=
;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><b>From: </b>"Mich=
ael Sullivan" &lt;sully@msully.net&gt;<br><b>To: </b>"Mathieu Desnoyers" &l=
t;mathieu.desnoyers@efficios.com&gt;<br><b>Cc: </b>lttng-dev@lists.lttng.or=
g<br><b>Sent: </b>Thursday, March 12, 2015 12:04:07 PM<br><b>Subject: </b>R=
e: [lttng-dev] Alternative to signals/sys_membarrier() in liburcu<br><div><=
br></div><div dir=3D"ltr">On Thu, Mar 12, 2015 at 10:57 AM, Mathieu Desnoye=
rs <span dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com" =
target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;</span> wrote:<br><=
div class=3D"gmail_extra"><div class=3D"gmail_quote"><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex"><div><div style=3D"font-family:times new roman,=
new york,times,serif;font-size:12pt;color:rgb(0,0,0)"><br><div>Even though =
it depends on internal behavior not currently specified by mprotect,<br></d=
iv><div>I'd very much like to see the prototype you have,<br></div><div><br=
></div></div></div></blockquote><div><br>I ended up posting my code at <a h=
ref=3D"https://github.com/msullivan/userspace-rcu/tree/msync-barrier" targe=
t=3D"_blank">https://github.com/msullivan/userspace-rcu/tree/msync-barrier<=
/a>.<br>The interesting patch is <a href=3D"https://github.com/msullivan/us=
erspace-rcu/commit/04656b468d418efbc5d934ab07954eb8395a7ab0" target=3D"_bla=
nk">https://github.com/msullivan/userspace-rcu/commit/04656b468d418efbc5d93=
4ab07954eb8395a7ab0</a>.<br><div><br></div></div><div>Quick blog post I wro=
te about it at <a href=3D"http://www.msully.net/blog/2015/02/24/forcing-mem=
ory-barriers-on-other-cpus-with-mprotect2/" target=3D"_blank">http://www.ms=
ully.net/blog/2015/02/24/forcing-memory-barriers-on-other-cpus-with-mprotec=
t2/</a>.<br></div><div>(I talked briefly about sys_membarrier in the post a=
s best as I could piece together from LKML; if my comment on it is inaccura=
te I can edit the post.)<br></div><div><br></div><div>-Michael Sullivan<br>=
</div></div></div></div>
</blockquote><div><br><br></div><div><br></div><div>-- <br></div><div><span=
 name=3D"x"></span>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficio=
s.com<span name=3D"x"></span><br></div></div></body></html>
------=_Part_287501_1604231795.1426193588469--


--===============0998762530==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0998762530==--
