From: Gaylord Charles <gaylord.charles@veo-labs.com>
Subject: LTTng-modules with RT kernel
Date: Mon, 24 Oct 2016 17:23:30 +0200
Message-ID: <CAAqXYd31SHfHyrW2SWrBe8EmbQnAc1dwNXy0xo+EXXLXYaEung__45321.4561603547$1477322638$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7202113462058144957=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lf0-f51.google.com (mail-lf0-f51.google.com
 [209.85.215.51])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id E6B55A0E1C
 for <lttng-dev@lists.lttng.org>; Mon, 24 Oct 2016 15:23:39 +0000 (UTC)
Received: by mail-lf0-f51.google.com with SMTP id t133so1648262lff.6
 for <lttng-dev@lists.lttng.org>; Mon, 24 Oct 2016 08:23:33 -0700 (PDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============7202113462058144957==
Content-Type: multipart/alternative; boundary=94eb2c0c894c79e9ea053f9df904

--94eb2c0c894c79e9ea053f9df904
Content-Type: text/plain; charset=UTF-8

Hello,

I am currently testing LTTng latest versions with a PREEMPT_RT kernel
(4.6.7-rt12). I've got:
 - LTTng-modules 2.8.3
 - LTTng-tools 2.8.2
 - LTTng-UST 2.8.1

When calling "lttng create", the following message appears:
     Cannot add context lttng_add_preemptible_to_ctx
     Cannot add context lttng_add_migratable_to_ctx

A quick look at the source code (lttng-context.c) makes me wonder if there
could be a bug. The "lttng_add_preemptible_to_ctx" function returns 0, so
if my understanding is correct, there is no problem.
Do I miss something ?

Regards.
Gaylord

--94eb2c0c894c79e9ea053f9df904
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div><div><div><div>Hello,<br><br></di=
v>I am currently testing LTTng latest versions with a PREEMPT_RT kernel (4.=
6.7-rt12). I&#39;ve got:<br></div>=C2=A0- LTTng-modules 2.8.3<br></div>=C2=
=A0- LTTng-tools 2.8.2<br></div>=C2=A0- LTTng-UST 2.8.1<br><br></div>When c=
alling &quot;lttng create&quot;, the following message appears: <br>=C2=A0=
=C2=A0=C2=A0=C2=A0 Cannot add context lttng_add_preemptible_to_ctx<br>=C2=
=A0=C2=A0=C2=A0=C2=A0 Cannot add context lttng_add_migratable_to_ctx<br><br=
></div>A quick look at the source code (lttng-context.c) makes me wonder if=
 there could be a bug. The &quot;lttng_add_preemptible_to_ctx&quot; functio=
n returns 0, so if my understanding is correct, there is no problem.<br></d=
iv>Do I miss something ?<br><br></div>Regards.<br><div><div><div><div><div>=
<div><div><div><div>Gaylord<br></div></div></div></div></div></div></div></=
div></div></div>

--94eb2c0c894c79e9ea053f9df904--

--===============7202113462058144957==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============7202113462058144957==--
