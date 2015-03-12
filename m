From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Alternative to signals/sys_membarrier() in liburcu
Date: Thu, 12 Mar 2015 14:57:07 +0000 (UTC)
Message-ID: <867044376.285926.1426172227750.JavaMail.zimbra__21458.0820910216$1426172335$gmane$org@efficios.com>
References: <CANW5cDmTCM9ZmhN7-2eWUEYvD+Y=sGt2i7mecdPTTLHMcT8fPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1153270058=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1YW4Xy-0003YC-Uy
 for lttng-dev@lists.lttng.org; Thu, 12 Mar 2015 10:57:25 -0400
In-Reply-To: <CANW5cDmTCM9ZmhN7-2eWUEYvD+Y=sGt2i7mecdPTTLHMcT8fPg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Michael Sullivan <sully@msully.net>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1153270058==
Content-Type: multipart/alternative;
	boundary="----=_Part_285925_1574855893.1426172227749"

------=_Part_285925_1574855893.1426172227749
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- Original Message -----

> From: "Michael Sullivan" <sully@msully.net>
> To: lttng-dev@lists.lttng.org
> Sent: Tuesday, February 10, 2015 7:03:53 PM
> Subject: [lttng-dev] Alternative to signals/sys_membarrier() in liburcu

> I've been looking at the RCU library (as part of gathering examples for my
> research on weak memory models) and was thinking about ways to force other
> threads to issue barriers. Since it seems like sys_membarrier() never made
> it into the kernel, I was pondering whether there was some other way to more
> or less get its effect; as it turns out, there is, but it is a hack:
> mprotect(2).

> When a thread revokes write permissions on a page, the kernel needs to do a
> TLB shootdown to make sure that none of the other CPUs running code in that
> address space have a writable mapping for that page cached. In Linux, this
> is done by forcing code to invalidate the mappings to run on every CPU in
> the address space, and waiting for completion. The code for the "run this
> function on another CPU" mechanism forces the target CPU to issue an
> smp_mb().

> (In practice TLB shootdowns are done when permissions are added, not just
> when they are removed, but they needn't be; faults caused by using a cached
> entry with less permissions can be fixed up by the page fault handler.
> They're also needed when unmapping memory, but mprotect() seems cheaper than
> having to mmap() and munmap(). Also TLB shootdowns aren't needed if the page
> is non-present because it's never been backed or has been swapped out, so
> mlock(2) is used to keep it in place).

> I hacked this up and in my limited testing, it does seem to have way better
> write side performance than the signal version has. That said, it is also
> super hacky and is certainly depending on behaviors of mprotect() that are
> not actually specified. It would be unusual, I think, to implement
> mprotect() in a way where this didn't work? It may well be to janky to
> actually be useful, though.

> I can send the code if you're interested.

That's certainly an interesting way to mimick sys_membarrier! 

Even though it depends on internal behavior not currently specified by mprotect, 
I'd very much like to see the prototype you have, 

Thanks! 

Mathieu 

> -Michael Sullivan

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_285925_1574855893.1426172227749
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><div><br></div><hr id=3D"zwchr"><bloc=
kquote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:=
5px;color:#000;font-weight:normal;font-style:normal;text-decoration:none;fo=
nt-family:Helvetica,Arial,sans-serif;font-size:12pt;" data-mce-style=3D"bor=
der-left: 2px solid #1010FF; margin-left: 5px; padding-left: 5px; color: #0=
00; font-weight: normal; font-style: normal; text-decoration: none; font-fa=
mily: Helvetica,Arial,sans-serif; font-size: 12pt;"><b>From: </b>"Michael S=
ullivan" &lt;sully@msully.net&gt;<br><b>To: </b>lttng-dev@lists.lttng.org<b=
r><b>Sent: </b>Tuesday, February 10, 2015 7:03:53 PM<br><b>Subject: </b>[lt=
tng-dev] Alternative to signals/sys_membarrier() in liburcu<br><div><br></d=
iv><div dir=3D"ltr"><div><div><div><div><div>I've been looking at the RCU l=
ibrary (as part of gathering examples for my research on weak memory models=
) and was thinking about ways to force other threads to issue barriers. Sin=
ce it seems like sys_membarrier() never made it into the kernel, I was pond=
ering whether there was some other way to more or less get its effect; as i=
t turns out, there is, but it is a hack: mprotect(2).<br><div><br></div></d=
iv>When a thread revokes write permissions on a page, the kernel needs to d=
o a TLB shootdown to make sure that none of the other CPUs running code in =
that address space have a writable mapping for that page cached. In Linux, =
this is done by forcing code to invalidate the mappings to run on every CPU=
 in the address space, and waiting for completion. The code for the "run th=
is function on another CPU" mechanism forces the target CPU to issue an smp=
_mb().<br><div><br></div></div>(In practice TLB shootdowns are done when pe=
rmissions are added, not just when they are removed, but they needn't be; f=
aults caused by using a cached entry with less permissions can be fixed up =
by the page fault handler. They're also needed when unmapping memory, but m=
protect() seems cheaper than having to mmap() and munmap(). Also TLB shootd=
owns aren't needed if the page is non-present because it's never been backe=
d or has been swapped out, so mlock(2) is used to keep it in place).<br><di=
v><br></div></div>I hacked this up and in my limited testing, it does seem =
to have way better write side performance than the signal version has. That=
 said, it is also super hacky and is certainly depending on behaviors of mp=
rotect() that are not actually specified. It would be unusual, I think, to =
implement mprotect() in a way where this didn't work? It may well be to jan=
ky to actually be useful, though.<br><div><br></div></div>I can send the co=
de if you're interested.</div></div></blockquote><div><br></div><div>That's=
 certainly an interesting way to mimick sys_membarrier!<br></div><div><br><=
/div><div>Even though it depends on internal behavior not currently specifi=
ed by mprotect,<br></div><div>I'd very much like to see the prototype you h=
ave,<br></div><div><br></div><div>Thanks!<br></div><div><br></div><div>Math=
ieu<br></div><div><br></div><blockquote style=3D"border-left:2px solid #101=
0FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-sty=
le:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-=
size:12pt;" data-mce-style=3D"border-left: 2px solid #1010FF; margin-left: =
5px; padding-left: 5px; color: #000; font-weight: normal; font-style: norma=
l; text-decoration: none; font-family: Helvetica,Arial,sans-serif; font-siz=
e: 12pt;"><div dir=3D"ltr"><div><div><br></div></div>-Michael Sullivan<br><=
/div><br>_______________________________________________<br>lttng-dev maili=
ng list<br>lttng-dev@lists.lttng.org<br>http://lists.lttng.org/cgi-bin/mail=
man/listinfo/lttng-dev<br></blockquote><div><br><br></div><div><br></div><d=
iv>-- <br></div><div><span name=3D"x"></span>Mathieu Desnoyers<br>EfficiOS =
Inc.<br>http://www.efficios.com<span name=3D"x"></span><br></div></div></bo=
dy></html>
------=_Part_285925_1574855893.1426172227749--


--===============1153270058==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1153270058==--
