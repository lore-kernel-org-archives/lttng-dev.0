From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: cmd line options overwrite
 env variable config options
Date: Sat, 26 May 2018 04:43:24 -0400
Message-ID: <CA+jJMxtHarZznzVn-C1RQTwenZMMbxyRWECf5udoHfy8dPgBNA__38824.5447226383$1527324109$gmane$org@mail.gmail.com>
References: <20180518214557.6933-1-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1119155121522327908=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 40tGql5Fgcz18TB
 for <lttng-dev@lists.lttng.org>; Sat, 26 May 2018 04:43:47 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 007D6F625
 for <lttng-dev@lists.lttng.org>; Sat, 26 May 2018 04:43:47 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
 with ESMTP id BT3zodsZMWV2 for <lttng-dev@lists.lttng.org>;
 Sat, 26 May 2018 04:43:46 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id A6CF1F61A
 for <lttng-dev@lists.lttng.org>; Sat, 26 May 2018 04:43:46 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
 with ESMTP id qcKfF9vrbldf for <lttng-dev@lists.lttng.org>;
 Sat, 26 May 2018 04:43:46 -0400 (EDT)
Received: from mail-wr0-f176.google.com (mail-wr0-f176.google.com
 [209.85.128.176])
 by mail.efficios.com (Postfix) with ESMTPSA id 5ECE3F600
 for <lttng-dev@lists.lttng.org>; Sat, 26 May 2018 04:43:46 -0400 (EDT)
Received: by mail-wr0-f176.google.com with SMTP id r13-v6so12780061wrj.10
 for <lttng-dev@lists.lttng.org>; Sat, 26 May 2018 01:43:46 -0700 (PDT)
In-Reply-To: <20180518214557.6933-1-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

--===============1119155121522327908==
Content-Type: multipart/alternative; boundary="000000000000e83136056d17e15f"

--000000000000e83136056d17e15f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Merged in master and stable-2.10 with a minor fix.

Thanks!
J=C3=A9r=C3=A9mie


On 18 May 2018 at 17:45, Jonathan Rajotte <
jonathan.rajotte-julien@efficios.com> wrote:

> The doc is clear about the order of precedence regarding configuration.
>
> The command line options always override any config file or
> configuration by environment variables.
>
> Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
> ---
>  src/bin/lttng-sessiond/main.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.=
c
> index 37c0a932..de8df2e0 100644
> --- a/src/bin/lttng-sessiond/main.c
> +++ b/src/bin/lttng-sessiond/main.c
> @@ -5775,6 +5775,12 @@ int main(int argc, char **argv)
>                 goto exit_set_signal_handler;
>         }
>
> +       /*
>

There's a trailing whitespace here ^.


> +        * Init config from environment variables.
> +        * Command line option override env configuration per-doc. Do env
> first.
> +        */
> +       sessiond_config_apply_env_config(&config);
> +
>         /*
>          * Parse arguments and load the daemon configuration file.
>          *
> @@ -5789,9 +5795,6 @@ int main(int argc, char **argv)
>                 goto exit_options;
>         }
>
> -       /* Init config from environment variables. */
> -       sessiond_config_apply_env_config(&config);
> -
>         /*
>          * Resolve all paths received as arguments, configuration option,
> or
>          * through environment variable as absolute paths. This is
> necessary
> --
> 2.17.0
>
>


--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--000000000000e83136056d17e15f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Merged in master and stable-2.10 with a minor fix.</d=
iv><div><br></div><div>Thanks!<br></div><div>J=C3=A9r=C3=A9mie</div><div><b=
r></div><div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On 1=
8 May 2018 at 17:45, Jonathan Rajotte <span dir=3D"ltr">&lt;<a href=3D"mail=
to:jonathan.rajotte-julien@efficios.com" target=3D"_blank">jonathan.rajotte=
-julien@efficios.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
">The doc is clear about the order of precedence regarding configuration.<b=
r>
<br>
The command line options always override any config file or<br>
configuration by environment variables.<br>
<br>
Signed-off-by: Jonathan Rajotte &lt;<a href=3D"mailto:jonathan.rajotte-juli=
en@efficios.com">jonathan.rajotte-julien@<wbr>efficios.com</a>&gt;<br>
---<br>
=C2=A0src/bin/lttng-sessiond/main.c | 9 ++++++---<br>
=C2=A01 file changed, 6 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/src/bin/lttng-sessiond/main.<wbr>c b/src/bin/lttng-sessiond/ma=
in.<wbr>c<br>
index 37c0a932..de8df2e0 100644<br>
--- a/src/bin/lttng-sessiond/main.<wbr>c<br>
+++ b/src/bin/lttng-sessiond/main.<wbr>c<br>
@@ -5775,6 +5775,12 @@ int main(int argc, char **argv)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto exit_set_signa=
l_handler;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* <br></blockquote><div><br></div><div>There&#=
39;s a trailing whitespace here ^.<br></div><div>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Init config from environment variables.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Command line option override env configurati=
on per-doc. Do env first.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0sessiond_config_apply_env_<wbr>config(&amp;conf=
ig);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Parse arguments and load the daemon con=
figuration file.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*<br>
@@ -5789,9 +5795,6 @@ int main(int argc, char **argv)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto exit_options;<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Init config from environment variables. */<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0sessiond_config_apply_env_<wbr>config(&amp;conf=
ig);<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Resolve all paths received as arguments=
, configuration option, or<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* through environment variable as absolut=
e paths. This is necessary<br>
<span class=3D"HOEnZb"><font color=3D"#888888">-- <br>
2.17.0<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><br>-- <br><div clas=
s=3D"gmail_signature" data-smartmail=3D"gmail_signature">J=C3=A9r=C3=A9mie =
Galarneau<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com" target=3D=
"_blank">http://www.efficios.com</a></div>
</div></div></div>

--000000000000e83136056d17e15f--

--===============1119155121522327908==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============1119155121522327908==--
