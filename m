From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH babeltrace] Fix: don't access missing ctf
 trace when getting metadata
Date: Mon, 17 Aug 2015 20:50:36 -0400
Message-ID: <CA+jJMxsYMkE_fgBDs26Ox5xrKhsmZj60DcnmkDtksCMtqGx0kw__48355.6234198206$1439859098$gmane$org@mail.gmail.com>
References: <1439855624-9915-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0833516368=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yk0-f178.google.com ([209.85.160.178])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1ZRV6w-0002wQ-Oj
 for lttng-dev@lists.lttng.org; Mon, 17 Aug 2015 20:50:45 -0400
Received: by ykfw73 with SMTP id w73so90098387ykf.3
 for <lttng-dev@lists.lttng.org>; Mon, 17 Aug 2015 17:50:37 -0700 (PDT)
In-Reply-To: <1439855624-9915-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

--===============0833516368==
Content-Type: multipart/alternative; boundary=001a113947466d373a051d8b4ed2

--001a113947466d373a051d8b4ed2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2015 at 7:53 PM, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> We can get metadata when still in the trace open functions, in which
> case the ctf trace is now allocated nor available yet. This fixes a
>

Do you mean "is neither allocated nor available yet"?


> segmentation fault in stress-test.
>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  formats/lttng-live/lttng-live-comm.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/formats/lttng-live/lttng-live-comm.c
> b/formats/lttng-live/lttng-live-comm.c
> index 9b409bc..57586a1 100644
> --- a/formats/lttng-live/lttng-live-comm.c
> +++ b/formats/lttng-live/lttng-live-comm.c
> @@ -600,6 +600,11 @@ int append_metadata(struct lttng_live_ctx *ctx,
>         struct lttng_live_viewer_stream *metadata;
>         char *metadata_buf =3D NULL;
>
> +       if (!viewer_stream->ctf_trace->handle) {
>

If the ctf_trace can be unallocated, shouldn't we check for:

if (!viewer_stream->ctf_trace) ?

J=C3=A9r=C3=A9mie


> +               printf_verbose("append_metadata: trace handle not ready
> yet.\n");
> +               return 0;
> +       }
> +
>         printf_verbose("get_next_index: new metadata needed\n");
>         ret =3D get_new_metadata(ctx, viewer_stream, &metadata_buf);
>         if (ret < 0) {
> --
> 2.1.4
>
>


--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--001a113947466d373a051d8b4ed2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Mon, Aug 17, 2015 at 7:53 PM, Mathieu Desnoyers <span dir=3D"ltr">&l=
t;<a href=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_blank">mathi=
eu.desnoyers@efficios.com</a>&gt;</span> wrote:<br><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex">We can get metadata when still in the trace open functions, in which=
<br>
case the ctf trace is now allocated nor available yet. This fixes a<br></bl=
ockquote><div><br></div><div>Do you mean &quot;is neither allocated nor ava=
ilable yet&quot;?</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
segmentation fault in stress-test.<br>
<br>
Signed-off-by: Mathieu Desnoyers &lt;<a href=3D"mailto:mathieu.desnoyers@ef=
ficios.com">mathieu.desnoyers@efficios.com</a>&gt;<br>
---<br>
=C2=A0formats/lttng-live/lttng-live-comm.c | 5 +++++<br>
=C2=A01 file changed, 5 insertions(+)<br>
<br>
diff --git a/formats/lttng-live/lttng-live-comm.c b/formats/lttng-live/lttn=
g-live-comm.c<br>
index 9b409bc..57586a1 100644<br>
--- a/formats/lttng-live/lttng-live-comm.c<br>
+++ b/formats/lttng-live/lttng-live-comm.c<br>
@@ -600,6 +600,11 @@ int append_metadata(struct lttng_live_ctx *ctx,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct lttng_live_viewer_stream *metadata;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 char *metadata_buf =3D NULL;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!viewer_stream-&gt;ctf_trace-&gt;handle) {<=
br></blockquote><div><br></div><div>If the ctf_trace can be unallocated, sh=
ouldn&#39;t we check for:</div><div><br></div><div>if (!viewer_stream-&gt;c=
tf_trace) ?</div><div><br></div><div>J=C3=A9r=C3=A9mie</div><div>=C2=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf_verbose(&quo=
t;append_metadata: trace handle not ready yet.\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 printf_verbose(&quot;get_next_index: new metada=
ta needed\n&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D get_new_metadata(ctx, viewer_stream, &a=
mp;metadata_buf);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0) {<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
2.1.4<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature">J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS In=
c.<br><a href=3D"http://www.efficios.com" target=3D"_blank">http://www.effi=
cios.com</a></div>
</div></div>

--001a113947466d373a051d8b4ed2--


--===============0833516368==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0833516368==--
