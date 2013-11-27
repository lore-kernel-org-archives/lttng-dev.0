From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH liburcu 3/5] Added a compat layer for
	'syscall.h'
Date: Wed, 27 Nov 2013 17:38:33 +0000 (UTC)
Message-ID: <1712609310.76795.1385573913846.JavaMail.zimbra__17287.8870428123$1385573978$gmane$org@efficios.com>
References: <1385567313-8138-1-git-send-email-charlesbriere.flatzo@gmail.com>
	<1385567313-8138-3-git-send-email-charlesbriere.flatzo@gmail.com>
	<1311213495.76736.1385569780668.JavaMail.zimbra@efficios.com>
	<CACnpWGTMyA3nVwiXAEar7fxEHtJC-7HQiqiCcHsza81Ox9EtnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1371286992=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1Vlj4M-0002Ss-M9
	for lttng-dev@lists.lttng.org; Wed, 27 Nov 2013 12:38:41 -0500
In-Reply-To: <CACnpWGTMyA3nVwiXAEar7fxEHtJC-7HQiqiCcHsza81Ox9EtnQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Charles =?utf-8?Q?Bri=C3=A8re?= <charlesbriere.flatzo@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1371286992==
Content-Type: multipart/alternative;
	boundary="----=_Part_76794_1156704622.1385573913844"

------=_Part_76794_1156704622.1385573913844
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

OK. All merged with minor edits.=20

Thanks,=20

Mathieu=20

----- Original Message -----

> From: "Charles Bri=C3=A8re" <charlesbriere.flatzo@gmail.com>
> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: lttng-dev@lists.lttng.org, "Pierre-Luc St-Charles"
> <pierre-luc.st-charles@polymtl.ca>
> Sent: Wednesday, November 27, 2013 12:20:59 PM
> Subject: Re: [PATCH liburcu 3/5] Added a compat layer for 'syscall.h'

> I can't recall the reason as this is a rebase from a patch from long ago,=
 but
> changing it back to __linux__ doesn't affect at all compilation on Androi=
d
> and this line in the patch can be discarded.

> Sorry about that,
> Charles

> On Wed, Nov 27, 2013 at 8:29 AM, Mathieu Desnoyers <
> mathieu.desnoyers@efficios.com > wrote:

> > ----- Original Message -----
>=20
> > > From: "Charles Briere" < charlesbriere.flatzo@gmail.com >
>=20
> > > To: "mathieu desnoyers" < mathieu.desnoyers@efficios.com >
>=20
> > > Cc: lttng-dev@lists.lttng.org , "Pierre-Luc St-Charles" <
> > > pierre-luc.st-charles@polymtl.ca >, "Charles Briere"
>=20
> > > < charlesbriere.flatzo@gmail.com >
>=20
> > > Sent: Wednesday, November 27, 2013 10:48:31 AM
>=20
> > > Subject: [PATCH liburcu 3/5] Added a compat layer for 'syscall.h'
>=20
> > >
>=20
> > > From: Pierre-Luc St-Charles < pierre-luc.st-charles@polymtl.ca >
>=20
> > >
>=20
> > > Path to include syscall.h is different on Android
>=20
> > >
>=20
> > > Signed-off-by: Charles Briere < charlesbriere.flatzo@gmail.com >
>=20
> > > ---
>=20
> > > Makefile.am | 2 +-
>=20
> > > tests/common/thread-id.h | 5 ++---
>=20
> > > urcu.c | 2 +-
>=20
> > > urcu/futex.h | 2 +-
>=20
> > > urcu/syscall-compat.h | 36 ++++++++++++++++++++++++++++++++++++
>=20
> > > 5 files changed, 41 insertions(+), 6 deletions(-)
>=20
> > > create mode 100644 urcu/syscall-compat.h
>=20
> > >
>=20
> > > diff --git a/Makefile.am b/Makefile.am
>=20
> > > index baac8b9..64073a1 100644
>=20
> > > --- a/Makefile.am
>=20
> > > +++ b/Makefile.am
>=20
> > > @@ -20,7 +20,7 @@ nobase_dist_include_HEADERS =3D urcu/compiler.h
> > > urcu/hlist.h
>=20
> > > urcu/list.h \
>=20
> > > urcu/wfqueue.h urcu/rculfstack.h urcu/rculfqueue.h \
>=20
> > > urcu/ref.h urcu/cds.h urcu/urcu_ref.h urcu/urcu-futex.h \
>=20
> > > urcu/uatomic_arch.h urcu/rculfhash.h urcu/wfcqueue.h \
>=20
> > > - urcu/lfstack.h \
>=20
> > > + urcu/lfstack.h urcu/syscall-compat.h \
>=20
> > > $(top_srcdir)/urcu/map/*.h \
>=20
> > > $(top_srcdir)/urcu/static/*.h \
>=20
> > > urcu/tls-compat.h
>=20
> > > diff --git a/tests/common/thread-id.h b/tests/common/thread-id.h
>=20
> > > index 9378edc..bad3006 100644
>=20
> > > --- a/tests/common/thread-id.h
>=20
> > > +++ b/tests/common/thread-id.h
>=20
> > > @@ -17,9 +17,8 @@
>=20
> > > * provided the above notices are retained, and a notice that the code=
 was
>=20
> > > * modified is included with the above copyright notice.
>=20
> > > */
>=20
> > > -
>=20
> > > -#ifdef __linux__
>=20
> > > -# include <syscall.h>
>=20
> > > +#ifdef __Linux__
>=20

> > Changing from __linux__ to __Linux__ breaks things here on non-Android.
>=20
> > Why are you changing this ?
>=20

> > In file included from test_rwlock.c:39:0:
>=20
> > ../../tests/common/thread-id.h:46:3: warning: #warning "use pid as thre=
ad
> > ID"
> > [-Wcpp]
>=20

> > Thanks,
>=20

> > Mathieu
>=20

> > > +# include <urcu/syscall-compat.h>
>=20
> > >
>=20
> > > # if defined(_syscall0)
>=20
> > > _syscall0(pid_t, gettid)
>=20
> > > diff --git a/urcu.c b/urcu.c
>=20
> > > index 759b94b..69ebcaa 100644
>=20
> > > --- a/urcu.c
>=20
> > > +++ b/urcu.c
>=20
> > > @@ -66,7 +66,7 @@
>=20
> > > * RCU_MEMBARRIER is only possibly available on Linux.
>=20
> > > */
>=20
> > > #if defined(RCU_MEMBARRIER) && defined(__linux__)
>=20
> > > -#include <syscall.h>
>=20
> > > +#include <urcu/syscall-compat.h>
>=20
> > > #endif
>=20
> > >
>=20
> > > /* If the headers do not support SYS_membarrier, fall back on RCU_MB =
*/
>=20
> > > diff --git a/urcu/futex.h b/urcu/futex.h
>=20
> > > index cdaa430..bb270c2 100644
>=20
> > > --- a/urcu/futex.h
>=20
> > > +++ b/urcu/futex.h
>=20
> > > @@ -45,7 +45,7 @@ extern "C" {
>=20
> > > */
>=20
> > >
>=20
> > > #ifdef CONFIG_RCU_HAVE_FUTEX
>=20
> > > -#include <syscall.h>
>=20
> > > +#include <urcu/syscall-compat.h>
>=20
> > > #define futex(...) syscall(__NR_futex, __VA_ARGS__)
>=20
> > > #define futex_noasync(uaddr, op, val, timeout, uaddr2, val3) \
>=20
> > > futex(uaddr, op, val, timeout, uaddr2, val3)
>=20
> > > diff --git a/urcu/syscall-compat.h b/urcu/syscall-compat.h
>=20
> > > new file mode 100644
>=20
> > > index 0000000..55576f0
>=20
> > > --- /dev/null
>=20
> > > +++ b/urcu/syscall-compat.h
>=20
> > > @@ -0,0 +1,36 @@
>=20
> > > +#ifndef _URCU_SYSCALL_COMPAT_H
>=20
> > > +#define _URCU_SYSCALL_COMPAT_H
>=20
> > > +
>=20
> > > +/*
>=20
> > > + * urcu/syscall-compat.h
>=20
> > > + *
>=20
> > > + * Userspace RCU library - Syscall Compatibility Header
>=20
> > > + *
>=20
> > > + * Copyright 2013 - Pierre-Luc St-Charles <
> > > pierre-luc.st-charles@polymtl.ca >
>=20
> > > + *
>=20
> > > + * Note: this file is only used to simplify the code required to
>=20
> > > + * include the 'syscall.h' system header across multiple platforms,
>=20
> > > + * which might not always be located at the same place (or needed at
> > > all).
>=20
> > > + *
>=20
> > > + * This library is free software; you can redistribute it and/or
>=20
> > > + * modify it under the terms of the GNU Lesser General Public
>=20
> > > + * License as published by the Free Software Foundation; either
>=20
> > > + * version 2.1 of the License, or (at your option) any later version=
.
>=20
> > > + *
>=20
> > > + * This library is distributed in the hope that it will be useful,
>=20
> > > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>=20
> > > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
>=20
> > > + * Lesser General Public License for more details.
>=20
> > > + *
>=20
> > > + * You should have received a copy of the GNU Lesser General Public
>=20
> > > + * License along with this library; if not, write to the Free Softwa=
re
>=20
> > > + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> > > 02110-1301
>=20
> > > USA
>=20
> > > + */
>=20
> > > +
>=20
> > > +#if defined(__ANDROID__)
>=20
> > > +#include <sys/syscall.h>
>=20
> > > +#elif defined(__linux__)
>=20
> > > +#include <syscall.h>
>=20
> > > +#endif
>=20
> > > +
>=20
> > > +#endif /* _URCU_SYSCALL_COMPAT_H */
>=20
> > > --
>=20
> > > 1.8.4.2
>=20
> > >
>=20
> > >
>=20

> > --
>=20
> > Mathieu Desnoyers
>=20
> > EfficiOS Inc.
>=20
> > http://www.efficios.com
>=20

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

------=_Part_76794_1156704622.1385573913844
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><div>OK. All merged with minor edits.=
<br></div><div><br></div><div>Thanks,<br></div><div><br></div><div>Mathieu<=
br></div><div><br></div><div><br></div><hr id=3D"zwchr"><blockquote style=
=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#0=
00;font-weight:normal;font-style:normal;text-decoration:none;font-family:He=
lvetica,Arial,sans-serif;font-size:12pt;"><b>From: </b>"Charles Bri=C3=A8re=
" &lt;charlesbriere.flatzo@gmail.com&gt;<br><b>To: </b>"Mathieu Desnoyers" =
&lt;mathieu.desnoyers@efficios.com&gt;<br><b>Cc: </b>lttng-dev@lists.lttng.=
org, "Pierre-Luc St-Charles" &lt;pierre-luc.st-charles@polymtl.ca&gt;<br><b=
>Sent: </b>Wednesday, November 27, 2013 12:20:59 PM<br><b>Subject: </b>Re: =
[PATCH liburcu 3/5] Added a compat layer for 'syscall.h'<br><div><br></div>=
<div dir=3D"ltr">I can't recall the reason as this is a rebase from a patch=
 from long ago, but changing it back to __linux__ doesn't affect at all com=
pilation on Android and this line in the patch can be discarded.&nbsp;<div>
<br></div><div>Sorry about that,</div><div>Charles<br><div><br></div><div><=
br></div></div></div><div class=3D"gmail_extra"><br><div><br></div><div cla=
ss=3D"gmail_quote">On Wed, Nov 27, 2013 at 8:29 AM, Mathieu Desnoyers <span=
 dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com" target=
=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">----=
- Original Message -----<br>
&gt; From: "Charles Briere" &lt;<a href=3D"mailto:charlesbriere.flatzo@gmai=
l.com" target=3D"_blank">charlesbriere.flatzo@gmail.com</a>&gt;<br>
&gt; To: "mathieu desnoyers" &lt;<a href=3D"mailto:mathieu.desnoyers@effici=
os.com" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;<br>
&gt; Cc: <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">ltt=
ng-dev@lists.lttng.org</a>, "Pierre-Luc St-Charles" &lt;<a href=3D"mailto:p=
ierre-luc.st-charles@polymtl.ca" target=3D"_blank">pierre-luc.st-charles@po=
lymtl.ca</a>&gt;, "Charles Briere"<br>

&gt; &lt;<a href=3D"mailto:charlesbriere.flatzo@gmail.com" target=3D"_blank=
">charlesbriere.flatzo@gmail.com</a>&gt;<br>
&gt; Sent: Wednesday, November 27, 2013 10:48:31 AM<br>
&gt; Subject: [PATCH liburcu 3/5] Added a compat layer for 'syscall.h'<br>
&gt;<br>
&gt; From: Pierre-Luc St-Charles &lt;<a href=3D"mailto:pierre-luc.st-charle=
s@polymtl.ca" target=3D"_blank">pierre-luc.st-charles@polymtl.ca</a>&gt;<br=
>
&gt;<br>
&gt; Path to include syscall.h is different on Android<br>
&gt;<br>
&gt; Signed-off-by: Charles Briere &lt;<a href=3D"mailto:charlesbriere.flat=
zo@gmail.com" target=3D"_blank">charlesbriere.flatzo@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; &nbsp;Makefile.am &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| &n=
bsp;2 +-<br>
&gt; &nbsp;tests/common/thread-id.h | &nbsp;5 ++---<br>
&gt; &nbsp;urcu.c &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; | &nbsp;2 +-<br>
&gt; &nbsp;urcu/futex.h &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | &nbsp;2=
 +-<br>
&gt; &nbsp;urcu/syscall-compat.h &nbsp; &nbsp;| 36 ++++++++++++++++++++++++=
++++++++++++<br>
&gt; &nbsp;5 files changed, 41 insertions(+), 6 deletions(-)<br>
&gt; &nbsp;create mode 100644 urcu/syscall-compat.h<br>
&gt;<br>
&gt; diff --git a/Makefile.am b/Makefile.am<br>
&gt; index baac8b9..64073a1 100644<br>
&gt; --- a/Makefile.am<br>
&gt; +++ b/Makefile.am<br>
&gt; @@ -20,7 +20,7 @@ nobase_dist_include_HEADERS =3D urcu/compiler.h urcu=
/hlist.h<br>
&gt; urcu/list.h \<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; urcu/wfqueue.h urcu/r=
culfstack.h urcu/rculfqueue.h \<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; urcu/ref.h urcu/cds.h=
 urcu/urcu_ref.h urcu/urcu-futex.h \<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; urcu/uatomic_arch.h u=
rcu/rculfhash.h urcu/wfcqueue.h \<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; urcu/lfstack.h \<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; urcu/lfstack.h urcu/syscal=
l-compat.h \<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; $(top_srcdir)/urcu/ma=
p/*.h \<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; $(top_srcdir)/urcu/st=
atic/*.h \<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; urcu/tls-compat.h<br>
&gt; diff --git a/tests/common/thread-id.h b/tests/common/thread-id.h<br>
&gt; index 9378edc..bad3006 100644<br>
&gt; --- a/tests/common/thread-id.h<br>
&gt; +++ b/tests/common/thread-id.h<br>
&gt; @@ -17,9 +17,8 @@<br>
&gt; &nbsp; * provided the above notices are retained, and a notice that th=
e code was<br>
&gt; &nbsp; * modified is included with the above copyright notice.<br>
&gt; &nbsp; */<br>
&gt; -<br>
&gt; -#ifdef __linux__<br>
&gt; -# include &lt;syscall.h&gt;<br>
&gt; +#ifdef __Linux__<br>
<br>
</div></div>Changing from __linux__ to __Linux__ breaks things here on non-=
Android.<br>
Why are you changing this ?<br>
<br>
In file included from test_rwlock.c:39:0:<br>
../../tests/common/thread-id.h:46:3: warning: #warning "use pid as thread I=
D" [-Wcpp]<br>
<br>
Thanks,<br>
<br>
Mathieu<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt; +# include &lt;urcu/syscall-compat.h&gt;<br>
&gt;<br>
&gt; &nbsp;# if defined(_syscall0)<br>
&gt; &nbsp;_syscall0(pid_t, gettid)<br>
&gt; diff --git a/urcu.c b/urcu.c<br>
&gt; index 759b94b..69ebcaa 100644<br>
&gt; --- a/urcu.c<br>
&gt; +++ b/urcu.c<br>
&gt; @@ -66,7 +66,7 @@<br>
&gt; &nbsp; * RCU_MEMBARRIER is only possibly available on Linux.<br>
&gt; &nbsp; */<br>
&gt; &nbsp;#if defined(RCU_MEMBARRIER) &amp;&amp; defined(__linux__)<br>
&gt; -#include &lt;syscall.h&gt;<br>
&gt; +#include &lt;urcu/syscall-compat.h&gt;<br>
&gt; &nbsp;#endif<br>
&gt;<br>
&gt; &nbsp;/* If the headers do not support SYS_membarrier, fall back on RC=
U_MB */<br>
&gt; diff --git a/urcu/futex.h b/urcu/futex.h<br>
&gt; index cdaa430..bb270c2 100644<br>
&gt; --- a/urcu/futex.h<br>
&gt; +++ b/urcu/futex.h<br>
&gt; @@ -45,7 +45,7 @@ extern "C" {<br>
&gt; &nbsp; */<br>
&gt;<br>
&gt; &nbsp;#ifdef CONFIG_RCU_HAVE_FUTEX<br>
&gt; -#include &lt;syscall.h&gt;<br>
&gt; +#include &lt;urcu/syscall-compat.h&gt;<br>
&gt; &nbsp;#define futex(...) &nbsp; syscall(__NR_futex, __VA_ARGS__)<br>
&gt; &nbsp;#define futex_noasync(uaddr, op, val, timeout, uaddr2, val3) \<b=
r>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; futex(uaddr, op, val,=
 timeout, uaddr2, val3)<br>
&gt; diff --git a/urcu/syscall-compat.h b/urcu/syscall-compat.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000..55576f0<br>
&gt; --- /dev/null<br>
&gt; +++ b/urcu/syscall-compat.h<br>
&gt; @@ -0,0 +1,36 @@<br>
&gt; +#ifndef _URCU_SYSCALL_COMPAT_H<br>
&gt; +#define _URCU_SYSCALL_COMPAT_H<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * urcu/syscall-compat.h<br>
&gt; + *<br>
&gt; + * Userspace RCU library - Syscall Compatibility Header<br>
&gt; + *<br>
&gt; + * Copyright 2013 - Pierre-Luc St-Charles &lt;<a href=3D"mailto:pierr=
e-luc.st-charles@polymtl.ca" target=3D"_blank">pierre-luc.st-charles@polymt=
l.ca</a>&gt;<br>
&gt; + *<br>
&gt; + * Note: this file is only used to simplify the code required to<br>
&gt; + * include the 'syscall.h' system header across multiple platforms,<b=
r>
&gt; + * which might not always be located at the same place (or needed at =
all).<br>
&gt; + *<br>
&gt; + * This library is free software; you can redistribute it and/or<br>
&gt; + * modify it under the terms of the GNU Lesser General Public<br>
&gt; + * License as published by the Free Software Foundation; either<br>
&gt; + * version 2.1 of the License, or (at your option) any later version.=
<br>
&gt; + *<br>
&gt; + * This library is distributed in the hope that it will be useful,<br=
>
&gt; + * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
&gt; + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. &nbsp;See the=
 GNU<br>
&gt; + * Lesser General Public License for more details.<br>
&gt; + *<br>
&gt; + * You should have received a copy of the GNU Lesser General Public<b=
r>
&gt; + * License along with this library; if not, write to the Free Softwar=
e<br>
&gt; + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 0211=
0-1301<br>
&gt; USA<br>
&gt; + */<br>
&gt; +<br>
&gt; +#if defined(__ANDROID__)<br>
&gt; +#include &lt;sys/syscall.h&gt;<br>
&gt; +#elif defined(__linux__)<br>
&gt; +#include &lt;syscall.h&gt;<br>
&gt; +#endif<br>
&gt; +<br>
&gt; +#endif /* _URCU_SYSCALL_COMPAT_H */<br>
&gt; --<br>
&gt; 1.8.4.2<br>
&gt;<br>
&gt;<br>
<br>
</div></div><span class=3D"HOEnZb"><span style=3D"color: #888888;" data-mce=
-style=3D"color: #888888;" color=3D"#888888">--<br>
Mathieu Desnoyers<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.c=
om</a><br>
</span></span></blockquote></div><br></div>
</blockquote><div><br><br></div><div><br></div><div>-- <br></div><div><span=
 name=3D"x"></span>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficio=
s.com<span name=3D"x"></span><br></div></div></body></html>
------=_Part_76794_1156704622.1385573913844--


--===============1371286992==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1371286992==--
