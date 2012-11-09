From: =?UTF-8?Q?Marek_Vavru=C5=A1a?= <marek.vavrusa@nic.cz>
Subject: Re: [urcu commit] Fix TLS detection: test with linker,
	add --disable-compiler-tls
Date: Fri, 9 Nov 2012 09:22:25 +0100
Message-ID: <CACgotOQhzheqKiAjTVqNPQOobEybq=6ny2cT3WBhFeCtZi1xeA__43460.2674948566$1352449574$gmane$org@mail.gmail.com>
References: <20121109025418.GA26014@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1588408544=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-la0-f48.google.com ([209.85.215.48])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <marek@vavrusa.com>) id 1TWjrX-0003gi-6b
	for lttng-dev@lists.lttng.org; Fri, 09 Nov 2012 03:22:51 -0500
Received: by mail-la0-f48.google.com with SMTP id o2so1157112lag.35
	for <lttng-dev@lists.lttng.org>; Fri, 09 Nov 2012 00:22:45 -0800 (PST)
In-Reply-To: <20121109025418.GA26014@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Jim Reid <jim@rfc1035.com>
List-Id: lttng-dev@lists.lttng.org

--===============1588408544==
Content-Type: multipart/alternative; boundary=e0cb4efe2a28fcc19104ce0ba752

--e0cb4efe2a28fcc19104ce0ba752
Content-Type: text/plain; charset=ISO-8859-1

Nice, I can confirm it compiles on OSX10.8 with default gcc and
autodisables __thread correctly.
It also builds with clang, __thread enabled/disabled.
For backported 0.7, i think the patch for MAP_ANONYMOUS compatibility needs
to be backported as well (if it's not already).
Great work, thanks!

Marek

On 9 November 2012 03:54, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com>wrote:

> The following commit is now in the userspace RCU master branch
> (backported to stable-0.7 branch too). It should fix TLS detection on
> both NetBSD <= 5.1, and on Darwin, and adds a --disable-compiler-tls
> flag to force using the pthread_getspecific fallback.
>
>
> commit 75478b32ffe53b0d8b5e687d9cf7ebdd77a085de
> Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Date:   Thu Nov 8 21:45:04 2012 -0500
>
>     Fix TLS detection: test with linker, add --disable-compiler-tls
>
>     NetBSD 5.1 and older, as well as Darwin, succeed to compile code
>     containing TLS, but cannot link it. Test with linker in addition to
>     compiler for TLS support.
>
>     Also add a --disable-compiler-tls configure option to allow users to
>     force using the pthread getspecific fall back.
>
>     Fixes #288
>
>     Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>
> Feedback is welcome!
>
> Thanks,
>
> Mathieu
>
> --
> Mathieu Desnoyers
> Operating System Efficiency R&D Consultant
> EfficiOS Inc.
> http://www.efficios.com
>

--e0cb4efe2a28fcc19104ce0ba752
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Nice, I can confirm it compiles on OSX10.8 with default gcc and autodisable=
s __thread correctly.<div>It also builds with clang, __thread enabled/disab=
led.</div><div>For backported 0.7, i think the patch for MAP_ANONYMOUS comp=
atibility needs to be backported as well (if it&#39;s not already).</div>

<div>Great work, thanks!</div><div><br></div><div>Marek<br><br><div class=
=3D"gmail_quote">On 9 November 2012 03:54, Mathieu Desnoyers <span dir=3D"l=
tr">&lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_blank"=
>mathieu.desnoyers@efficios.com</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">The following commit is now in the userspace=
 RCU master branch<br>
(backported to stable-0.7 branch too). It should fix TLS detection on<br>
both NetBSD &lt;=3D 5.1, and on Darwin, and adds a --disable-compiler-tls<b=
r>
flag to force using the pthread_getspecific fallback.<br>
<br>
<br>
commit 75478b32ffe53b0d8b5e687d9cf7ebdd77a085de<br>
Author: Mathieu Desnoyers &lt;<a href=3D"mailto:mathieu.desnoyers@efficios.=
com">mathieu.desnoyers@efficios.com</a>&gt;<br>
Date: =A0 Thu Nov 8 21:45:04 2012 -0500<br>
<br>
=A0 =A0 Fix TLS detection: test with linker, add --disable-compiler-tls<br>
<br>
=A0 =A0 NetBSD 5.1 and older, as well as Darwin, succeed to compile code<br=
>
=A0 =A0 containing TLS, but cannot link it. Test with linker in addition to=
<br>
=A0 =A0 compiler for TLS support.<br>
<br>
=A0 =A0 Also add a --disable-compiler-tls configure option to allow users t=
o<br>
=A0 =A0 force using the pthread getspecific fall back.<br>
<br>
=A0 =A0 Fixes #288<br>
<br>
=A0 =A0 Signed-off-by: Mathieu Desnoyers &lt;<a href=3D"mailto:mathieu.desn=
oyers@efficios.com">mathieu.desnoyers@efficios.com</a>&gt;<br>
<br>
Feedback is welcome!<br>
<br>
Thanks,<br>
<br>
Mathieu<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
Mathieu Desnoyers<br>
Operating System Efficiency R&amp;D Consultant<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.c=
om</a><br>
</font></span></blockquote></div><br></div>

--e0cb4efe2a28fcc19104ce0ba752--


--===============1588408544==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1588408544==--
