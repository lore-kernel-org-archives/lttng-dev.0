From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Initialize ret to zero
Date: Wed, 2 May 2018 10:25:43 -0400
Message-ID: <CA+jJMxuc1_JjE29Sw=iW9iGTs0EStLJwRktL_B_KP8SKBMR58g__36869.8943908841$1525271053$gmane$org@mail.gmail.com>
References: <20180430182735.12118-1-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5087729738494367163=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lf0-x22d.google.com (mail-lf0-x22d.google.com
 [IPv6:2a00:1450:4010:c07::22d])
 by lists.lttng.org (Postfix) with ESMTPS id 40bgYp59rNz17lN
 for <lttng-dev@lists.lttng.org>; Wed,  2 May 2018 10:26:06 -0400 (EDT)
Received: by mail-lf0-x22d.google.com with SMTP id j193-v6so21143168lfg.6
 for <lttng-dev@lists.lttng.org>; Wed, 02 May 2018 07:26:06 -0700 (PDT)
In-Reply-To: <20180430182735.12118-1-jonathan.rajotte-julien@efficios.com>
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

--===============5087729738494367163==
Content-Type: multipart/alternative; boundary="000000000000ef1e95056b39dd2b"

--000000000000ef1e95056b39dd2b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Merged, thanks!

J=C3=A9r=C3=A9mie

On 30 April 2018 at 14:27, Jonathan Rajotte <
jonathan.rajotte-julien@efficios.com> wrote:

> sample_channel_positions return garbage if cds_lfht_is_node_deleted(&
> stream->node.node)
> on first and "possibly" only iteration of the
> consumer_data.stream_per_chan_id_ht
> hash table.
>
> Found by scan-build
>
> Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
> ---
>  src/common/consumer/consumer-timer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/common/consumer/consumer-timer.c b/src/common/consumer/
> consumer-timer.c
> index 721f146e..38b8b30d 100644
> --- a/src/common/consumer/consumer-timer.c
> +++ b/src/common/consumer/consumer-timer.c
> @@ -637,7 +637,7 @@ int sample_channel_positions(struct
> lttng_consumer_channel *channel,
>                 sample_positions_cb sample, get_consumed_cb get_consumed,
>                 get_produced_cb get_produced)
>  {
> -       int ret;
> +       int ret =3D 0;
>         struct lttng_ht_iter iter;
>         struct lttng_consumer_stream *stream;
>         bool empty_channel =3D true;
> --
> 2.17.0
>
>


--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--000000000000ef1e95056b39dd2b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Merged, thanks!<br><br></div>J=C3=A9r=C3=A9mie<br></d=
iv><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On 30 April 20=
18 at 14:27, Jonathan Rajotte <span dir=3D"ltr">&lt;<a href=3D"mailto:jonat=
han.rajotte-julien@efficios.com" target=3D"_blank">jonathan.rajotte-julien@=
efficios.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">sample=
_channel_positions return garbage if cds_lfht_is_node_deleted(&amp;<wbr>str=
eam-&gt;node.node)<br>
on first and &quot;possibly&quot; only iteration of the consumer_data.strea=
m_per_chan_<wbr>id_ht<br>
hash table.<br>
<br>
Found by scan-build<br>
<br>
Signed-off-by: Jonathan Rajotte &lt;<a href=3D"mailto:jonathan.rajotte-juli=
en@efficios.com">jonathan.rajotte-julien@<wbr>efficios.com</a>&gt;<br>
---<br>
=C2=A0src/common/consumer/consumer-<wbr>timer.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/src/common/consumer/<wbr>consumer-timer.c b/src/common/consume=
r/<wbr>consumer-timer.c<br>
index 721f146e..38b8b30d 100644<br>
--- a/src/common/consumer/<wbr>consumer-timer.c<br>
+++ b/src/common/consumer/<wbr>consumer-timer.c<br>
@@ -637,7 +637,7 @@ int sample_channel_positions(<wbr>struct lttng_consumer=
_channel *channel,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sample_positions_cb=
 sample, get_consumed_cb get_consumed,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 get_produced_cb get=
_produced)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct lttng_ht_iter iter;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct lttng_consumer_stream *stream;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool empty_channel =3D true;<br>
<span class=3D"HOEnZb"><font color=3D"#888888">-- <br>
2.17.0<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><br>-- <br><div clas=
s=3D"gmail_signature" data-smartmail=3D"gmail_signature">J=C3=A9r=C3=A9mie =
Galarneau<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com" target=3D=
"_blank">http://www.efficios.com</a></div>
</div>

--000000000000ef1e95056b39dd2b--

--===============5087729738494367163==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============5087729738494367163==--
