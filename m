From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools v2 0/5] Support probes with the
 same name but different event payload
Date: Wed, 30 May 2018 14:44:45 -0400
Message-ID: <CA+jJMxv86kjQXHSRWtigYP0zj_QTNMsUAHsPNHTsAKDJH35=3w__26381.9280350164$1527705798$gmane$org@mail.gmail.com>
References: <1518032219-28072-1-git-send-email-francis.deslauriers@efficios.com>
 <1518213412-16593-1-git-send-email-francis.deslauriers@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7037613177608650331=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 40wzzv0yt5z18Bp
 for <lttng-dev@lists.lttng.org>; Wed, 30 May 2018 14:45:14 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 3F59B225151
 for <lttng-dev@lists.lttng.org>; Wed, 30 May 2018 14:45:09 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
 with ESMTP id emXAh4s5njAv for <lttng-dev@lists.lttng.org>;
 Wed, 30 May 2018 14:45:08 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 21BBB225147
 for <lttng-dev@lists.lttng.org>; Wed, 30 May 2018 14:45:08 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
 with ESMTP id iEabT-kW_2_O for <lttng-dev@lists.lttng.org>;
 Wed, 30 May 2018 14:45:08 -0400 (EDT)
Received: from mail-lf0-f43.google.com (mail-lf0-f43.google.com
 [209.85.215.43])
 by mail.efficios.com (Postfix) with ESMTPSA id 9B8BE22512F
 for <lttng-dev@lists.lttng.org>; Wed, 30 May 2018 14:45:07 -0400 (EDT)
Received: by mail-lf0-f43.google.com with SMTP id v135-v6so5862382lfa.9
 for <lttng-dev@lists.lttng.org>; Wed, 30 May 2018 11:45:07 -0700 (PDT)
In-Reply-To: <1518213412-16593-1-git-send-email-francis.deslauriers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Francis Deslauriers <francis.deslauriers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

--===============7037613177608650331==
Content-Type: multipart/alternative; boundary="000000000000db8dd8056d70bf30"

--000000000000db8dd8056d70bf30
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Merged with a number of fixes to the test patch. Thanks!

The CFLAGS have to be propagated to the probes target, and I added a target
to ensure the EXTRA_DIST files are copied to the build directory.

Also, the "comparison" test did not work on 32-bit x86 since "long" and
"int" have the same size on that architecture. The test expected the events
to be different, but they will be merged (as both are 32-bit integers).

J=C3=A9r=C3=A9mie

On 9 February 2018 at 16:56, Francis Deslauriers <
francis.deslauriers@efficios.com> wrote:

> This patch set allows for multiple probes with the same name to be
> hooked on the same callsite. Right now, the Session Daemon only
> considers the name and signature of the events to determine if two
> events are identical. This could lead to trace corruptions when two
> probes would have the same name and signature but really different
> binary trace layouts.
>
> We now compare probes by doing a deep compare of every field. If two
> events are _exactly_ the same and have the same metadata then the same
> event ID will be used, if they are different a new event ID is created.
>
> When used with its corresponding UST patch set[1], it allows for dynamic
> library upgrade scenarios during tracing. The user can now dlopen a new
> version of a provider library and dlclose an old version without
> restarting the process.
>
> This patch set also includes regression tests for both the deep
> comparaison and the newly added dlclose capability.
>
> [1]: https://github.com/frdeso/lttng-ust/tree/dlclose-support
>
> Francis Deslauriers (5):
>   Fix: probes should be compared strictly by events metadata
>   Fix: calling ht_{hash, match}_enum with wrong argument
>   Tests: allow the use of regular expressions to match events
>   Tests: add function to validate the number of an event name in
>     metadata
>   Tests: add duplicated providers tests
>
>  configure.ac                                    |   1 +
>  src/bin/lttng-sessiond/Makefile.am              |   3 +-
>  src/bin/lttng-sessiond/ust-field-utils.c        | 289
> ++++++++++++++++++++++++
>  src/bin/lttng-sessiond/ust-field-utils.h        |  29 +++
>  src/bin/lttng-sessiond/ust-registry.c           |  46 +++-
>  tests/fast_regression                           |   1 +
>  tests/regression/ust/multi-lib/Makefile.am      | 114 ++++++++++
>  tests/regression/ust/multi-lib/README           |  21 ++
>  tests/regression/ust/multi-lib/callsites.c      |  34 +++
>  tests/regression/ust/multi-lib/callsites.h      |  21 ++
>  tests/regression/ust/multi-lib/multi-lib-test.c | 251
> ++++++++++++++++++++
>  tests/regression/ust/multi-lib/probes.c         |  18 ++
>  tests/regression/ust/multi-lib/probes.h         | 195 ++++++++++++++++
>  tests/regression/ust/multi-lib/test_multi_lib   | 262
> +++++++++++++++++++++
>  tests/unit/Makefile.am                          |   1 +
>  tests/utils/utils.sh                            |  27 ++-
>  16 files changed, 1299 insertions(+), 14 deletions(-)
>  create mode 100644 src/bin/lttng-sessiond/ust-field-utils.c
>  create mode 100644 src/bin/lttng-sessiond/ust-field-utils.h
>  create mode 100644 tests/regression/ust/multi-lib/Makefile.am
>  create mode 100644 tests/regression/ust/multi-lib/README
>  create mode 100644 tests/regression/ust/multi-lib/callsites.c
>  create mode 100644 tests/regression/ust/multi-lib/callsites.h
>  create mode 100644 tests/regression/ust/multi-lib/multi-lib-test.c
>  create mode 100644 tests/regression/ust/multi-lib/probes.c
>  create mode 100644 tests/regression/ust/multi-lib/probes.h
>  create mode 100755 tests/regression/ust/multi-lib/test_multi_lib
>
> --
> 2.7.4
>
>


--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--000000000000db8dd8056d70bf30
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Merged with a number of fixes to the test patch. Than=
ks!<br></div><div><br></div><div>The CFLAGS have to be propagated to the pr=
obes target, and I added a target to ensure the EXTRA_DIST files are copied=
 to the build directory.<br></div><div><br></div><div>Also, the &quot;compa=
rison&quot; test did not work on 32-bit x86 since &quot;long&quot; and &quo=
t;int&quot; have the same size on that architecture. The test expected the =
events to be different, but they will be merged (as both are 32-bit integer=
s).</div><div><br></div><div>J=C3=A9r=C3=A9mie<br></div></div><div class=3D=
"gmail_extra"><br><div class=3D"gmail_quote">On 9 February 2018 at 16:56, F=
rancis Deslauriers <span dir=3D"ltr">&lt;<a href=3D"mailto:francis.deslauri=
ers@efficios.com" target=3D"_blank">francis.deslauriers@efficios.com</a>&gt=
;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">This pat=
ch set allows for multiple probes with the same name to be<br>
hooked on the same callsite. Right now, the Session Daemon only<br>
considers the name and signature of the events to determine if two<br>
events are identical. This could lead to trace corruptions when two<br>
probes would have the same name and signature but really different<br>
binary trace layouts.<br>
<br>
We now compare probes by doing a deep compare of every field. If two<br>
</span>events are _exactly_ the same and have the same metadata then the sa=
me<br>
<span class=3D"">event ID will be used, if they are different a new event I=
D is created.<br>
<br>
</span>When used with its corresponding UST patch set[1], it allows for dyn=
amic<br>
library upgrade scenarios during tracing. The user can now dlopen a new<br>
version of a provider library and dlclose an old version without<br>
restarting the process.<br>
<span class=3D""><br>
This patch set also includes regression tests for both the deep<br>
comparaison and the newly added dlclose capability.<br>
<br>
[1]: <a href=3D"https://github.com/frdeso/lttng-ust/tree/dlclose-support" r=
el=3D"noreferrer" target=3D"_blank">https://github.com/frdeso/<wbr>lttng-us=
t/tree/dlclose-support</a><br>
<br>
Francis Deslauriers (5):<br>
</span>=C2=A0 Fix: probes should be compared strictly by events metadata<br=
>
=C2=A0 Fix: calling ht_{hash, match}_enum with wrong argument<br>
<span class=3D"">=C2=A0 Tests: allow the use of regular expressions to matc=
h events<br>
=C2=A0 Tests: add function to validate the number of an event name in<br>
=C2=A0 =C2=A0 metadata<br>
=C2=A0 Tests: add duplicated providers tests<br>
<br>
=C2=A0<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A01 +<br>
=C2=A0src/bin/lttng-sessiond/<wbr>Makefile.am=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A03 +-<br>
</span>=C2=A0src/bin/lttng-sessiond/ust-<wbr>field-utils.c=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 289 ++++++++++++++++++++++++<br>
=C2=A0src/bin/lttng-sessiond/ust-<wbr>field-utils.h=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 29 +++<br>
=C2=A0src/bin/lttng-sessiond/ust-<wbr>registry.c=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0|=C2=A0 46 +++-<br>
<span class=3D"">=C2=A0tests/fast_regression=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A01 +<br>
=C2=A0tests/regression/ust/multi-<wbr>lib/Makefile.am=C2=A0 =C2=A0 =C2=A0 |=
 114 ++++++++++<br>
</span><span class=3D"">=C2=A0tests/regression/ust/multi-<wbr>lib/README=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 21 ++<br>
=C2=A0tests/regression/ust/multi-<wbr>lib/callsites.c=C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 34 +++<br>
=C2=A0tests/regression/ust/multi-<wbr>lib/callsites.h=C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 21 ++<br>
=C2=A0tests/regression/ust/multi-<wbr>lib/multi-lib-test.c | 251 ++++++++++=
++++++++++<br>
</span><span class=3D"">=C2=A0tests/regression/ust/multi-<wbr>lib/probes.c=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 18 ++<br>
=C2=A0tests/regression/ust/multi-<wbr>lib/probes.h=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| 195 ++++++++++++++++<br>
</span>=C2=A0tests/regression/ust/multi-<wbr>lib/test_multi_lib=C2=A0 =C2=
=A0| 262 +++++++++++++++++++++<br>
<span class=3D"">=C2=A0tests/unit/Makefile.am=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A01 +<br>
=C2=A0tests/utils/utils.sh=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 27 ++-<br>
</span>=C2=A016 files changed, 1299 insertions(+), 14 deletions(-)<br>
<div class=3D"HOEnZb"><div class=3D"h5">=C2=A0create mode 100644 src/bin/lt=
tng-sessiond/ust-<wbr>field-utils.c<br>
=C2=A0create mode 100644 src/bin/lttng-sessiond/ust-<wbr>field-utils.h<br>
=C2=A0create mode 100644 tests/regression/ust/multi-<wbr>lib/Makefile.am<br=
>
=C2=A0create mode 100644 tests/regression/ust/multi-<wbr>lib/README<br>
=C2=A0create mode 100644 tests/regression/ust/multi-<wbr>lib/callsites.c<br=
>
=C2=A0create mode 100644 tests/regression/ust/multi-<wbr>lib/callsites.h<br=
>
=C2=A0create mode 100644 tests/regression/ust/multi-<wbr>lib/multi-lib-test=
.c<br>
=C2=A0create mode 100644 tests/regression/ust/multi-<wbr>lib/probes.c<br>
=C2=A0create mode 100644 tests/regression/ust/multi-<wbr>lib/probes.h<br>
=C2=A0create mode 100755 tests/regression/ust/multi-<wbr>lib/test_multi_lib=
<br>
<br>
-- <br>
2.7.4<br>
<br>
</div></div></blockquote></div><br><br clear=3D"all"><br>-- <br><div class=
=3D"gmail_signature" data-smartmail=3D"gmail_signature">J=C3=A9r=C3=A9mie G=
alarneau<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com" target=3D"=
_blank">http://www.efficios.com</a></div>
</div>

--000000000000db8dd8056d70bf30--

--===============7037613177608650331==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============7037613177608650331==--
