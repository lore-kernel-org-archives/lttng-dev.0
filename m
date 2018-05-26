From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools 1/2] Add missing include for
	ssize_t on Cygwin
Date: Sat, 26 May 2018 04:44:59 -0400
Message-ID: <CA+jJMxuC7k1BX=cnZHkPkd6iCS8DFR=ic_C9UjCpOPUrodsC8A__44405.9400739663$1527324208$gmane$org@mail.gmail.com>
References: <20180515201949.4201-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4787339614266551385=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 40tGsg2Gjnz18VG
 for <lttng-dev@lists.lttng.org>; Sat, 26 May 2018 04:45:27 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id E66AFF726
 for <lttng-dev@lists.lttng.org>; Sat, 26 May 2018 04:45:21 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
 with ESMTP id qWtKiZN1pWin for <lttng-dev@lists.lttng.org>;
 Sat, 26 May 2018 04:45:21 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 79B22F715
 for <lttng-dev@lists.lttng.org>; Sat, 26 May 2018 04:45:21 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
 with ESMTP id DjuX_S6FGwmy for <lttng-dev@lists.lttng.org>;
 Sat, 26 May 2018 04:45:21 -0400 (EDT)
Received: from mail-wr0-f174.google.com (mail-wr0-f174.google.com
 [209.85.128.174])
 by mail.efficios.com (Postfix) with ESMTPSA id 3238CF700
 for <lttng-dev@lists.lttng.org>; Sat, 26 May 2018 04:45:21 -0400 (EDT)
Received: by mail-wr0-f174.google.com with SMTP id w10-v6so12798990wrk.9
 for <lttng-dev@lists.lttng.org>; Sat, 26 May 2018 01:45:21 -0700 (PDT)
In-Reply-To: <20180515201949.4201-1-mjeanson@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

--===============4787339614266551385==
Content-Type: multipart/alternative; boundary="0000000000008f4c5d056d17e765"

--0000000000008f4c5d056d17e765
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Merged in master, stable-2.10, and stable-2.9 (only the first patch).

Thanks!
J=C3=A9r=C3=A9mie

On 15 May 2018 at 16:19, Michael Jeanson <mjeanson@efficios.com> wrote:

> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
>  include/lttng/condition/condition-internal.h  | 1 +
>  include/lttng/condition/evaluation-internal.h | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/include/lttng/condition/condition-internal.h
> b/include/lttng/condition/condition-internal.h
> index 72a8922b..969c7682 100644
> --- a/include/lttng/condition/condition-internal.h
> +++ b/include/lttng/condition/condition-internal.h
> @@ -24,6 +24,7 @@
>  #include <stdbool.h>
>  #include <urcu/list.h>
>  #include <stdint.h>
> +#include <sys/types.h>
>
>  typedef void (*condition_destroy_cb)(struct lttng_condition *condition);
>  typedef bool (*condition_validate_cb)(const struct lttng_condition
> *condition);
> diff --git a/include/lttng/condition/evaluation-internal.h
> b/include/lttng/condition/evaluation-internal.h
> index 414760e0..e2b6c384 100644
> --- a/include/lttng/condition/evaluation-internal.h
> +++ b/include/lttng/condition/evaluation-internal.h
> @@ -22,6 +22,7 @@
>  #include <common/macros.h>
>  #include <common/buffer-view.h>
>  #include <stdbool.h>
> +#include <sys/types.h>
>
>  typedef void (*evaluation_destroy_cb)(struct lttng_evaluation
> *evaluation);
>  typedef ssize_t (*evaluation_serialize_cb)(struct lttng_evaluation
> *evaluation,
> --
> 2.17.0
>
>


--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--0000000000008f4c5d056d17e765
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Merged in master, stable-2.10, and stable-2.9 (only t=
he first patch).</div><div><br></div><div>Thanks!</div><div>J=C3=A9r=C3=A9m=
ie<br></div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote"=
>On 15 May 2018 at 16:19, Michael Jeanson <span dir=3D"ltr">&lt;<a href=3D"=
mailto:mjeanson@efficios.com" target=3D"_blank">mjeanson@efficios.com</a>&g=
t;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">Signed-off-by: Michael J=
eanson &lt;<a href=3D"mailto:mjeanson@efficios.com">mjeanson@efficios.com</=
a>&gt;<br>
---<br>
=C2=A0include/lttng/condition/<wbr>condition-internal.h=C2=A0 | 1 +<br>
=C2=A0include/lttng/condition/<wbr>evaluation-internal.h | 1 +<br>
=C2=A02 files changed, 2 insertions(+)<br>
<br>
diff --git a/include/lttng/condition/<wbr>condition-internal.h b/include/lt=
tng/condition/<wbr>condition-internal.h<br>
index 72a8922b..969c7682 100644<br>
--- a/include/lttng/condition/<wbr>condition-internal.h<br>
+++ b/include/lttng/condition/<wbr>condition-internal.h<br>
@@ -24,6 +24,7 @@<br>
=C2=A0#include &lt;stdbool.h&gt;<br>
=C2=A0#include &lt;urcu/list.h&gt;<br>
=C2=A0#include &lt;stdint.h&gt;<br>
+#include &lt;sys/types.h&gt;<br>
<br>
=C2=A0typedef void (*condition_destroy_cb)(struct lttng_condition *conditio=
n);<br>
=C2=A0typedef bool (*condition_validate_cb)(const struct lttng_condition *c=
ondition);<br>
diff --git a/include/lttng/condition/<wbr>evaluation-internal.h b/include/l=
ttng/condition/<wbr>evaluation-internal.h<br>
index 414760e0..e2b6c384 100644<br>
--- a/include/lttng/condition/<wbr>evaluation-internal.h<br>
+++ b/include/lttng/condition/<wbr>evaluation-internal.h<br>
@@ -22,6 +22,7 @@<br>
=C2=A0#include &lt;common/macros.h&gt;<br>
=C2=A0#include &lt;common/buffer-view.h&gt;<br>
=C2=A0#include &lt;stdbool.h&gt;<br>
+#include &lt;sys/types.h&gt;<br>
<br>
=C2=A0typedef void (*evaluation_destroy_cb)(<wbr>struct lttng_evaluation *e=
valuation);<br>
=C2=A0typedef ssize_t (*evaluation_serialize_cb)(<wbr>struct lttng_evaluati=
on *evaluation,<br>
<span class=3D"HOEnZb"><font color=3D"#888888">-- <br>
2.17.0<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><br>-- <br><div clas=
s=3D"gmail_signature" data-smartmail=3D"gmail_signature">J=C3=A9r=C3=A9mie =
Galarneau<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com" target=3D=
"_blank">http://www.efficios.com</a></div>
</div>

--0000000000008f4c5d056d17e765--

--===============4787339614266551385==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============4787339614266551385==--
