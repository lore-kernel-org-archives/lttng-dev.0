From: Michael Sullivan <sully@msully.net>
Subject: Alternative to signals/sys_membarrier() in liburcu
Date: Tue, 10 Feb 2015 19:03:53 -0500
Message-ID: <CANW5cDmTCM9ZmhN7-2eWUEYvD+Y=sGt2i7mecdPTTLHMcT8fPg__39994.5929799744$1423747045$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1877633138=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f52.google.com ([209.85.216.52])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <msully4321@gmail.com>) id 1YLKmc-0000vP-Sp
 for lttng-dev@lists.lttng.org; Tue, 10 Feb 2015 19:04:01 -0500
Received: by mail-qa0-f52.google.com with SMTP id v10so196537qac.11
 for <lttng-dev@lists.lttng.org>; Tue, 10 Feb 2015 16:03:53 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1877633138==
Content-Type: multipart/alternative; boundary=001a11c2c2c4289619050ec4bd4e

--001a11c2c2c4289619050ec4bd4e
Content-Type: text/plain; charset=UTF-8

I've been looking at the RCU library (as part of gathering examples for my
research on weak memory models) and was thinking about ways to force other
threads to issue barriers. Since it seems like sys_membarrier() never made
it into the kernel, I was pondering whether there was some other way to
more or less get its effect; as it turns out, there is, but it is a hack:
mprotect(2).

When a thread revokes write permissions on a page, the kernel needs to do a
TLB shootdown to make sure that none of the other CPUs running code in that
address space have a writable mapping for that page cached. In Linux, this
is done by forcing code to invalidate the mappings to run on every CPU in
the address space, and waiting for completion. The code for the "run this
function on another CPU" mechanism forces the target CPU to issue an
smp_mb().

(In practice TLB shootdowns are done when permissions are added, not just
when they are removed, but they needn't be; faults caused by using a cached
entry with less permissions can be fixed up by the page fault handler.
They're also needed when unmapping memory, but mprotect() seems cheaper
than having to mmap() and munmap(). Also TLB shootdowns aren't needed if
the page is non-present because it's never been backed or has been swapped
out, so mlock(2) is used to keep it in place).

I hacked this up and in my limited testing, it does seem to have way better
write side performance than the signal version has. That said, it is also
super hacky and is certainly depending on behaviors of mprotect() that are
not actually specified. It would be unusual, I think, to implement
mprotect() in a way where this didn't work? It may well be to janky to
actually be useful, though.

I can send the code if you're interested.

-Michael Sullivan

--001a11c2c2c4289619050ec4bd4e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div>I&#39;ve been looking at the RCU =
library (as part of gathering examples for my research on weak memory model=
s) and was thinking about ways to force other threads to issue barriers. Si=
nce it seems like sys_membarrier() never made it into the kernel, I was pon=
dering whether there was some other way to more or less get its effect; as =
it turns out, there is, but it is a hack: mprotect(2).<br><br></div>When a =
thread revokes write permissions on a page, the kernel needs to do a TLB sh=
ootdown to make sure that none of the other CPUs running code in that addre=
ss space have a writable mapping for that page cached. In Linux, this is do=
ne by forcing code to invalidate the mappings to run on every CPU in the ad=
dress space, and waiting for completion. The code for the &quot;run this fu=
nction on another CPU&quot; mechanism forces the target CPU to issue an smp=
_mb().<br><br></div>(In practice TLB shootdowns are done when permissions a=
re added, not just when they are removed, but they needn&#39;t be; faults c=
aused by using a cached entry with less permissions can be fixed up by the =
page fault handler. They&#39;re also needed when unmapping memory, but mpro=
tect() seems cheaper than having to mmap() and munmap(). Also TLB shootdown=
s aren&#39;t needed if the page is non-present because it&#39;s never been =
backed or has been swapped out, so mlock(2) is used to keep it in place).<b=
r><br></div>I hacked this up and in my limited testing, it does seem to hav=
e way better write side performance than the signal version has. That said,=
 it is also super hacky and is certainly depending on behaviors of mprotect=
() that are not actually specified. It would be unusual, I think, to implem=
ent mprotect() in a way where this didn&#39;t work? It may well be to janky=
 to actually be useful, though.<br><br></div>I can send the code if you&#39=
;re interested.<br><br></div>-Michael Sullivan<br></div>

--001a11c2c2c4289619050ec4bd4e--


--===============1877633138==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1877633138==--
