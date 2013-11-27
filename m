From: =?ISO-8859-1?Q?Charles_Bri=E8re?= <charlesbriere.flatzo@gmail.com>
Subject: Re: [PATCH liburcu 3/5] Added a compat layer for
	'syscall.h'
Date: Wed, 27 Nov 2013 09:20:59 -0800
Message-ID: <CACnpWGTMyA3nVwiXAEar7fxEHtJC-7HQiqiCcHsza81Ox9EtnQ__41314.155169721$1385572939$gmane$org@mail.gmail.com>
References: <1385567313-8138-1-git-send-email-charlesbriere.flatzo@gmail.com>
	<1385567313-8138-3-git-send-email-charlesbriere.flatzo@gmail.com>
	<1311213495.76736.1385569780668.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0298347680=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f47.google.com ([209.85.216.47])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <charlesbriere.flatzo@gmail.com>) id 1VlinQ-0002qw-Oj
	for lttng-dev@lists.lttng.org; Wed, 27 Nov 2013 12:21:11 -0500
Received: by mail-qa0-f47.google.com with SMTP id w5so6015938qac.13
	for <lttng-dev@lists.lttng.org>; Wed, 27 Nov 2013 09:20:59 -0800 (PST)
In-Reply-To: <1311213495.76736.1385569780668.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0298347680==
Content-Type: multipart/alternative; boundary=047d7b6d97ec16a41604ec2bd2ea

--047d7b6d97ec16a41604ec2bd2ea
Content-Type: text/plain; charset=ISO-8859-1

I can't recall the reason as this is a rebase from a patch from long ago,
but changing it back to __linux__ doesn't affect at all compilation on
Android and this line in the patch can be discarded.

Sorry about that,
Charles




On Wed, Nov 27, 2013 at 8:29 AM, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> ----- Original Message -----
> > From: "Charles Briere" <charlesbriere.flatzo@gmail.com>
> > To: "mathieu desnoyers" <mathieu.desnoyers@efficios.com>
> > Cc: lttng-dev@lists.lttng.org, "Pierre-Luc St-Charles" <
> pierre-luc.st-charles@polymtl.ca>, "Charles Briere"
> > <charlesbriere.flatzo@gmail.com>
> > Sent: Wednesday, November 27, 2013 10:48:31 AM
> > Subject: [PATCH liburcu 3/5] Added a compat layer for 'syscall.h'
> >
> > From: Pierre-Luc St-Charles <pierre-luc.st-charles@polymtl.ca>
> >
> > Path to include syscall.h is different on Android
> >
> > Signed-off-by: Charles Briere <charlesbriere.flatzo@gmail.com>
> > ---
> >  Makefile.am              |  2 +-
> >  tests/common/thread-id.h |  5 ++---
> >  urcu.c                   |  2 +-
> >  urcu/futex.h             |  2 +-
> >  urcu/syscall-compat.h    | 36 ++++++++++++++++++++++++++++++++++++
> >  5 files changed, 41 insertions(+), 6 deletions(-)
> >  create mode 100644 urcu/syscall-compat.h
> >
> > diff --git a/Makefile.am b/Makefile.am
> > index baac8b9..64073a1 100644
> > --- a/Makefile.am
> > +++ b/Makefile.am
> > @@ -20,7 +20,7 @@ nobase_dist_include_HEADERS = urcu/compiler.h
> urcu/hlist.h
> > urcu/list.h \
> >               urcu/wfqueue.h urcu/rculfstack.h urcu/rculfqueue.h \
> >               urcu/ref.h urcu/cds.h urcu/urcu_ref.h urcu/urcu-futex.h \
> >               urcu/uatomic_arch.h urcu/rculfhash.h urcu/wfcqueue.h \
> > -             urcu/lfstack.h \
> > +             urcu/lfstack.h urcu/syscall-compat.h \
> >               $(top_srcdir)/urcu/map/*.h \
> >               $(top_srcdir)/urcu/static/*.h \
> >               urcu/tls-compat.h
> > diff --git a/tests/common/thread-id.h b/tests/common/thread-id.h
> > index 9378edc..bad3006 100644
> > --- a/tests/common/thread-id.h
> > +++ b/tests/common/thread-id.h
> > @@ -17,9 +17,8 @@
> >   * provided the above notices are retained, and a notice that the code
> was
> >   * modified is included with the above copyright notice.
> >   */
> > -
> > -#ifdef __linux__
> > -# include <syscall.h>
> > +#ifdef __Linux__
>
> Changing from __linux__ to __Linux__ breaks things here on non-Android.
> Why are you changing this ?
>
> In file included from test_rwlock.c:39:0:
> ../../tests/common/thread-id.h:46:3: warning: #warning "use pid as thread
> ID" [-Wcpp]
>
> Thanks,
>
> Mathieu
>
> > +# include <urcu/syscall-compat.h>
> >
> >  # if defined(_syscall0)
> >  _syscall0(pid_t, gettid)
> > diff --git a/urcu.c b/urcu.c
> > index 759b94b..69ebcaa 100644
> > --- a/urcu.c
> > +++ b/urcu.c
> > @@ -66,7 +66,7 @@
> >   * RCU_MEMBARRIER is only possibly available on Linux.
> >   */
> >  #if defined(RCU_MEMBARRIER) && defined(__linux__)
> > -#include <syscall.h>
> > +#include <urcu/syscall-compat.h>
> >  #endif
> >
> >  /* If the headers do not support SYS_membarrier, fall back on RCU_MB */
> > diff --git a/urcu/futex.h b/urcu/futex.h
> > index cdaa430..bb270c2 100644
> > --- a/urcu/futex.h
> > +++ b/urcu/futex.h
> > @@ -45,7 +45,7 @@ extern "C" {
> >   */
> >
> >  #ifdef CONFIG_RCU_HAVE_FUTEX
> > -#include <syscall.h>
> > +#include <urcu/syscall-compat.h>
> >  #define futex(...)   syscall(__NR_futex, __VA_ARGS__)
> >  #define futex_noasync(uaddr, op, val, timeout, uaddr2, val3) \
> >               futex(uaddr, op, val, timeout, uaddr2, val3)
> > diff --git a/urcu/syscall-compat.h b/urcu/syscall-compat.h
> > new file mode 100644
> > index 0000000..55576f0
> > --- /dev/null
> > +++ b/urcu/syscall-compat.h
> > @@ -0,0 +1,36 @@
> > +#ifndef _URCU_SYSCALL_COMPAT_H
> > +#define _URCU_SYSCALL_COMPAT_H
> > +
> > +/*
> > + * urcu/syscall-compat.h
> > + *
> > + * Userspace RCU library - Syscall Compatibility Header
> > + *
> > + * Copyright 2013 - Pierre-Luc St-Charles <
> pierre-luc.st-charles@polymtl.ca>
> > + *
> > + * Note: this file is only used to simplify the code required to
> > + * include the 'syscall.h' system header across multiple platforms,
> > + * which might not always be located at the same place (or needed at
> all).
> > + *
> > + * This library is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU Lesser General Public
> > + * License as published by the Free Software Foundation; either
> > + * version 2.1 of the License, or (at your option) any later version.
> > + *
> > + * This library is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > + * Lesser General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU Lesser General Public
> > + * License along with this library; if not, write to the Free Software
> > + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> 02110-1301
> > USA
> > + */
> > +
> > +#if defined(__ANDROID__)
> > +#include <sys/syscall.h>
> > +#elif defined(__linux__)
> > +#include <syscall.h>
> > +#endif
> > +
> > +#endif /* _URCU_SYSCALL_COMPAT_H */
> > --
> > 1.8.4.2
> >
> >
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>

--047d7b6d97ec16a41604ec2bd2ea
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I can&#39;t recall the reason as this is a rebase from a p=
atch from long ago, but changing it back to __linux__ doesn&#39;t affect at=
 all compilation on Android and this line in the patch can be discarded.=A0=
<div>
<br></div><div>Sorry about that,</div><div>Charles<br><div><br></div><div><=
br></div></div></div><div class=3D"gmail_extra"><br><br><div class=3D"gmail=
_quote">On Wed, Nov 27, 2013 at 8:29 AM, Mathieu Desnoyers <span dir=3D"ltr=
">&lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_blank">m=
athieu.desnoyers@efficios.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">----=
- Original Message -----<br>
&gt; From: &quot;Charles Briere&quot; &lt;<a href=3D"mailto:charlesbriere.f=
latzo@gmail.com">charlesbriere.flatzo@gmail.com</a>&gt;<br>
&gt; To: &quot;mathieu desnoyers&quot; &lt;<a href=3D"mailto:mathieu.desnoy=
ers@efficios.com">mathieu.desnoyers@efficios.com</a>&gt;<br>
&gt; Cc: <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng=
.org</a>, &quot;Pierre-Luc St-Charles&quot; &lt;<a href=3D"mailto:pierre-lu=
c.st-charles@polymtl.ca">pierre-luc.st-charles@polymtl.ca</a>&gt;, &quot;Ch=
arles Briere&quot;<br>

&gt; &lt;<a href=3D"mailto:charlesbriere.flatzo@gmail.com">charlesbriere.fl=
atzo@gmail.com</a>&gt;<br>
&gt; Sent: Wednesday, November 27, 2013 10:48:31 AM<br>
&gt; Subject: [PATCH liburcu 3/5] Added a compat layer for &#39;syscall.h&#=
39;<br>
&gt;<br>
&gt; From: Pierre-Luc St-Charles &lt;<a href=3D"mailto:pierre-luc.st-charle=
s@polymtl.ca">pierre-luc.st-charles@polymtl.ca</a>&gt;<br>
&gt;<br>
&gt; Path to include syscall.h is different on Android<br>
&gt;<br>
&gt; Signed-off-by: Charles Briere &lt;<a href=3D"mailto:charlesbriere.flat=
zo@gmail.com">charlesbriere.flatzo@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; =A0Makefile.am =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A02 +-<br>
&gt; =A0tests/common/thread-id.h | =A05 ++---<br>
&gt; =A0urcu.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A02 +-<br>
&gt; =A0urcu/futex.h =A0 =A0 =A0 =A0 =A0 =A0 | =A02 +-<br>
&gt; =A0urcu/syscall-compat.h =A0 =A0| 36 +++++++++++++++++++++++++++++++++=
+++<br>
&gt; =A05 files changed, 41 insertions(+), 6 deletions(-)<br>
&gt; =A0create mode 100644 urcu/syscall-compat.h<br>
&gt;<br>
&gt; diff --git a/Makefile.am b/Makefile.am<br>
&gt; index baac8b9..64073a1 100644<br>
&gt; --- a/Makefile.am<br>
&gt; +++ b/Makefile.am<br>
&gt; @@ -20,7 +20,7 @@ nobase_dist_include_HEADERS =3D urcu/compiler.h urcu=
/hlist.h<br>
&gt; urcu/list.h \<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 urcu/wfqueue.h urcu/rculfstack.h urcu/rcul=
fqueue.h \<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 urcu/ref.h urcu/cds.h urcu/urcu_ref.h urcu=
/urcu-futex.h \<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 urcu/uatomic_arch.h urcu/rculfhash.h urcu/=
wfcqueue.h \<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 urcu/lfstack.h \<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 urcu/lfstack.h urcu/syscall-compat.h \<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 $(top_srcdir)/urcu/map/*.h \<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 $(top_srcdir)/urcu/static/*.h \<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 urcu/tls-compat.h<br>
&gt; diff --git a/tests/common/thread-id.h b/tests/common/thread-id.h<br>
&gt; index 9378edc..bad3006 100644<br>
&gt; --- a/tests/common/thread-id.h<br>
&gt; +++ b/tests/common/thread-id.h<br>
&gt; @@ -17,9 +17,8 @@<br>
&gt; =A0 * provided the above notices are retained, and a notice that the c=
ode was<br>
&gt; =A0 * modified is included with the above copyright notice.<br>
&gt; =A0 */<br>
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
../../tests/common/thread-id.h:46:3: warning: #warning &quot;use pid as thr=
ead ID&quot; [-Wcpp]<br>
<br>
Thanks,<br>
<br>
Mathieu<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt; +# include &lt;urcu/syscall-compat.h&gt;<br>
&gt;<br>
&gt; =A0# if defined(_syscall0)<br>
&gt; =A0_syscall0(pid_t, gettid)<br>
&gt; diff --git a/urcu.c b/urcu.c<br>
&gt; index 759b94b..69ebcaa 100644<br>
&gt; --- a/urcu.c<br>
&gt; +++ b/urcu.c<br>
&gt; @@ -66,7 +66,7 @@<br>
&gt; =A0 * RCU_MEMBARRIER is only possibly available on Linux.<br>
&gt; =A0 */<br>
&gt; =A0#if defined(RCU_MEMBARRIER) &amp;&amp; defined(__linux__)<br>
&gt; -#include &lt;syscall.h&gt;<br>
&gt; +#include &lt;urcu/syscall-compat.h&gt;<br>
&gt; =A0#endif<br>
&gt;<br>
&gt; =A0/* If the headers do not support SYS_membarrier, fall back on RCU_M=
B */<br>
&gt; diff --git a/urcu/futex.h b/urcu/futex.h<br>
&gt; index cdaa430..bb270c2 100644<br>
&gt; --- a/urcu/futex.h<br>
&gt; +++ b/urcu/futex.h<br>
&gt; @@ -45,7 +45,7 @@ extern &quot;C&quot; {<br>
&gt; =A0 */<br>
&gt;<br>
&gt; =A0#ifdef CONFIG_RCU_HAVE_FUTEX<br>
&gt; -#include &lt;syscall.h&gt;<br>
&gt; +#include &lt;urcu/syscall-compat.h&gt;<br>
&gt; =A0#define futex(...) =A0 syscall(__NR_futex, __VA_ARGS__)<br>
&gt; =A0#define futex_noasync(uaddr, op, val, timeout, uaddr2, val3) \<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 futex(uaddr, op, val, timeout, uaddr2, val=
3)<br>
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
e-luc.st-charles@polymtl.ca">pierre-luc.st-charles@polymtl.ca</a>&gt;<br>
&gt; + *<br>
&gt; + * Note: this file is only used to simplify the code required to<br>
&gt; + * include the &#39;syscall.h&#39; system header across multiple plat=
forms,<br>
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
&gt; + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the GN=
U<br>
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
</div></div><span class=3D"HOEnZb"><font color=3D"#888888">--<br>
Mathieu Desnoyers<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.c=
om</a><br>
</font></span></blockquote></div><br></div>

--047d7b6d97ec16a41604ec2bd2ea--


--===============0298347680==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0298347680==--
