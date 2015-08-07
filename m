From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [BABELTRACE stable-1.2 PATCH] Hide the
	packet_seq_num field
Date: Fri, 7 Aug 2015 13:01:24 -0400
Message-ID: <CA+jJMxtpoyUipd3ZXdXSUu2EpXumnLoSMJ0Za1qNWyBUU58yfA__42275.9897694506$1438966950$gmane$org@mail.gmail.com>
References: <1438616138-29252-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1120051620=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yk0-f180.google.com ([209.85.160.180])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1ZNl1O-0004zN-Bn
 for lttng-dev@lists.lttng.org; Fri, 07 Aug 2015 13:01:36 -0400
Received: by ykdt205 with SMTP id t205so13072559ykd.1
 for <lttng-dev@lists.lttng.org>; Fri, 07 Aug 2015 10:01:25 -0700 (PDT)
In-Reply-To: <1438616138-29252-1-git-send-email-jdesfossez@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Julien Desfossez <jdesfossez@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

--===============1120051620==
Content-Type: multipart/alternative; boundary=001a11492a1404be1a051cbb96db

--001a11492a1404be1a051cbb96db
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Merged in master and stable-1.2.

Thanks,
J/r/mie ;-)

On Mon, Aug 3, 2015 at 11:35 AM, Julien Desfossez <jdesfossez@efficios.com>
wrote:

> The packet_seq_num is a new field in LTTng 2.8 that should be hidden
> from the ctf-text output as it is not really relevant for the users of
> the text output.
>
> Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
> ---
>  formats/ctf-text/ctf-text.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/formats/ctf-text/ctf-text.c b/formats/ctf-text/ctf-text.c
> index 9d5123a..2ba0823 100644
> --- a/formats/ctf-text/ctf-text.c
> +++ b/formats/ctf-text/ctf-text.c
> @@ -115,7 +115,8 @@ static GQuark Q_STREAM_PACKET_CONTEXT_TIMESTAMP_BEGIN=
,
>         Q_STREAM_PACKET_CONTEXT_TIMESTAMP_END,
>         Q_STREAM_PACKET_CONTEXT_EVENTS_DISCARDED,
>         Q_STREAM_PACKET_CONTEXT_CONTENT_SIZE,
> -       Q_STREAM_PACKET_CONTEXT_PACKET_SIZE;
> +       Q_STREAM_PACKET_CONTEXT_PACKET_SIZE,
> +       Q_STREAM_PACKET_CONTEXT_PACKET_SEQ_NUM;
>
>  static
>  void __attribute__((constructor)) init_quarks(void)
> @@ -125,6 +126,7 @@ void __attribute__((constructor)) init_quarks(void)
>         Q_STREAM_PACKET_CONTEXT_EVENTS_DISCARDED =3D
> g_quark_from_static_string("stream.packet.context.events_discarded");
>         Q_STREAM_PACKET_CONTEXT_CONTENT_SIZE =3D
> g_quark_from_static_string("stream.packet.context.content_size");
>         Q_STREAM_PACKET_CONTEXT_PACKET_SIZE =3D
> g_quark_from_static_string("stream.packet.context.packet_size");
> +       Q_STREAM_PACKET_CONTEXT_PACKET_SEQ_NUM =3D
> g_quark_from_static_string("stream.packet.context.packet_seq_num");
>  }
>
>  static
> @@ -152,6 +154,8 @@ int print_field(struct bt_definition *definition)
>                 return 0;
>         if (definition->path =3D=3D Q_STREAM_PACKET_CONTEXT_PACKET_SIZE)
>                 return 0;
> +       if (definition->path =3D=3D Q_STREAM_PACKET_CONTEXT_PACKET_SEQ_NU=
M)
> +               return 0;
>
>         return 1;
>  }
> --
> 1.9.1
>
>


--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--001a11492a1404be1a051cbb96db
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Merged in master and stable-1.2.<div><br></div><div>Thanks=
,</div><div>J/r/mie ;-)</div></div><div class=3D"gmail_extra"><br><div clas=
s=3D"gmail_quote">On Mon, Aug 3, 2015 at 11:35 AM, Julien Desfossez <span d=
ir=3D"ltr">&lt;<a href=3D"mailto:jdesfossez@efficios.com" target=3D"_blank"=
>jdesfossez@efficios.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex">The packet_seq_num is a new field in LTTng 2.8 that should be hidden<=
br>
from the ctf-text output as it is not really relevant for the users of<br>
the text output.<br>
<br>
Signed-off-by: Julien Desfossez &lt;<a href=3D"mailto:jdesfossez@efficios.c=
om">jdesfossez@efficios.com</a>&gt;<br>
---<br>
=C2=A0formats/ctf-text/ctf-text.c | 6 +++++-<br>
=C2=A01 file changed, 5 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/formats/ctf-text/ctf-text.c b/formats/ctf-text/ctf-text.c<br>
index 9d5123a..2ba0823 100644<br>
--- a/formats/ctf-text/ctf-text.c<br>
+++ b/formats/ctf-text/ctf-text.c<br>
@@ -115,7 +115,8 @@ static GQuark Q_STREAM_PACKET_CONTEXT_TIMESTAMP_BEGIN,<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Q_STREAM_PACKET_CONTEXT_TIMESTAMP_END,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Q_STREAM_PACKET_CONTEXT_EVENTS_DISCARDED,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Q_STREAM_PACKET_CONTEXT_CONTENT_SIZE,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0Q_STREAM_PACKET_CONTEXT_PACKET_SIZE;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0Q_STREAM_PACKET_CONTEXT_PACKET_SIZE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0Q_STREAM_PACKET_CONTEXT_PACKET_SEQ_NUM;<br>
<br>
=C2=A0static<br>
=C2=A0void __attribute__((constructor)) init_quarks(void)<br>
@@ -125,6 +126,7 @@ void __attribute__((constructor)) init_quarks(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Q_STREAM_PACKET_CONTEXT_EVENTS_DISCARDED =3D g_=
quark_from_static_string(&quot;stream.packet.context.events_discarded&quot;=
);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Q_STREAM_PACKET_CONTEXT_CONTENT_SIZE =3D g_quar=
k_from_static_string(&quot;stream.packet.context.content_size&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Q_STREAM_PACKET_CONTEXT_PACKET_SIZE =3D g_quark=
_from_static_string(&quot;stream.packet.context.packet_size&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0Q_STREAM_PACKET_CONTEXT_PACKET_SEQ_NUM =3D g_qu=
ark_from_static_string(&quot;stream.packet.context.packet_seq_num&quot;);<b=
r>
=C2=A0}<br>
<br>
=C2=A0static<br>
@@ -152,6 +154,8 @@ int print_field(struct bt_definition *definition)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (definition-&gt;path =3D=3D Q_STREAM_PACKET_=
CONTEXT_PACKET_SIZE)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (definition-&gt;path =3D=3D Q_STREAM_PACKET_=
CONTEXT_PACKET_SEQ_NUM)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;<br>
=C2=A0}<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
1.9.1<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature">J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS In=
c.<br><a href=3D"http://www.efficios.com" target=3D"_blank">http://www.effi=
cios.com</a></div>
</div>

--001a11492a1404be1a051cbb96db--


--===============1120051620==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1120051620==--
