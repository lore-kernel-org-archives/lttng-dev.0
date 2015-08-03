From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: set session should not set
 not-existent session
Date: Mon, 3 Aug 2015 14:58:49 -0400
Message-ID: <CA+jJMxsQB_0wwa4Uk7ecYTO7RFoe8Hef3B+L+CjbNCn0-9Xs_w__36212.1296035641$1438628392$gmane$org@mail.gmail.com>
References: <87si8cwu1k.fsf@nono.intra.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1203763254=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yk0-f170.google.com ([209.85.160.170])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1ZMKwo-0001JN-Ti
 for lttng-dev@lists.lttng.org; Mon, 03 Aug 2015 14:58:57 -0400
Received: by ykeo23 with SMTP id o23so21644677yke.3
 for <lttng-dev@lists.lttng.org>; Mon, 03 Aug 2015 11:58:49 -0700 (PDT)
In-Reply-To: <87si8cwu1k.fsf@nono.intra.net>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Partha Pratim Mukherjee <ppm.floss@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1203763254==
Content-Type: multipart/alternative; boundary=001a1139d2ba89298c051c6cc21d

--001a1139d2ba89298c051c6cc21d
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Merged in master, stable-2.7, stable-2.6 and stable-2.5. Thanks!

J=C3=A9r=C3=A9mie

On Sat, Jul 25, 2015 at 3:55 AM, Partha Pratim Mukherjee <
ppm.floss@gmail.com> wrote:

> set session does not check the existence of a session before setting
> it as the current session. Fix it so that it gives error for
> not-existent session.
>
> Fixes: #885
>
> Signed-off-by: Partha Pratim Mukherjee <ppm.floss@gmail.com>
> ---
>  src/bin/lttng/commands/set_session.c |   25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/src/bin/lttng/commands/set_session.c
> b/src/bin/lttng/commands/set_session.c
> index 3196f12..14fe9af 100644
> --- a/src/bin/lttng/commands/set_session.c
> +++ b/src/bin/lttng/commands/set_session.c
> @@ -106,11 +106,34 @@ end:
>  static int set_session(void)
>  {
>         int ret =3D CMD_SUCCESS;
> +       int count, i;
> +       unsigned int session_found =3D 0;
> +       struct lttng_session *sessions;
>
>         if (opt_session_name && strlen(opt_session_name) > NAME_MAX) {
>                 ERR("Session name too long. Length must be lower or equal
> to %d",
>                         NAME_MAX);
>                 ret =3D CMD_ERROR;
> +               goto end;
> +       }
> +
> +       count =3D lttng_list_sessions(&sessions);
> +       if (count < 0) {
> +               ret =3D CMD_ERROR;
> +               ERR("%s", lttng_strerror(count));
> +               goto end;
> +       }
> +
> +       for (i =3D 0; i < count; i++) {
> +               if (strncmp(sessions[i].name, opt_session_name, NAME_MAX)
> =3D=3D 0) {
> +                       session_found =3D 1;
> +                       break;
> +               }
> +       }
> +
> +       if (!session_found) {
> +               ERR("Session '%s' not found", opt_session_name);
> +               ret =3D CMD_ERROR;
>                 goto error;
>         }
>
> @@ -133,6 +156,8 @@ static int set_session(void)
>         ret =3D CMD_SUCCESS;
>
>  error:
> +       free(sessions);
> +end:
>         return ret;
>  }
>
> --
> 1.7.10.4
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>



--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--001a1139d2ba89298c051c6cc21d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Merged in master, stable-2.7, stable-2.6 and stable-2.5. T=
hanks!<div><br></div><div>J=C3=A9r=C3=A9mie</div></div><div class=3D"gmail_=
extra"><br><div class=3D"gmail_quote">On Sat, Jul 25, 2015 at 3:55 AM, Part=
ha Pratim Mukherjee <span dir=3D"ltr">&lt;<a href=3D"mailto:ppm.floss@gmail=
.com" target=3D"_blank">ppm.floss@gmail.com</a>&gt;</span> wrote:<br><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">set session does not check the existence of a sess=
ion before setting<br>
it as the current session. Fix it so that it gives error for<br>
not-existent session.<br>
<br>
Fixes: #885<br>
<br>
Signed-off-by: Partha Pratim Mukherjee &lt;<a href=3D"mailto:ppm.floss@gmai=
l.com">ppm.floss@gmail.com</a>&gt;<br>
---<br>
=C2=A0src/bin/lttng/commands/set_session.c |=C2=A0 =C2=A025 +++++++++++++++=
++++++++++<br>
=C2=A01 file changed, 25 insertions(+)<br>
<br>
diff --git a/src/bin/lttng/commands/set_session.c b/src/bin/lttng/commands/=
set_session.c<br>
index 3196f12..14fe9af 100644<br>
--- a/src/bin/lttng/commands/set_session.c<br>
+++ b/src/bin/lttng/commands/set_session.c<br>
@@ -106,11 +106,34 @@ end:<br>
=C2=A0static int set_session(void)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret =3D CMD_SUCCESS;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int count, i;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int session_found =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct lttng_session *sessions;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (opt_session_name &amp;&amp; strlen(opt_sess=
ion_name) &gt; NAME_MAX) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ERR(&quot;Session n=
ame too long. Length must be lower or equal to %d&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 NAME_MAX);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D CMD_ERROR;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto end;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0count =3D lttng_list_sessions(&amp;sessions);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (count &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D CMD_ERROR;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ERR(&quot;%s&quot;,=
 lttng_strerror(count));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto end;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; count; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (strncmp(session=
s[i].name, opt_session_name, NAME_MAX) =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0session_found =3D 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!session_found) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ERR(&quot;Session &=
#39;%s&#39; not found&quot;, opt_session_name);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D CMD_ERROR;<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
@@ -133,6 +156,8 @@ static int set_session(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D CMD_SUCCESS;<br>
<br>
=C2=A0error:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0free(sessions);<br>
+end:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
=C2=A0}<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
1.7.10.4<br>
<br>
_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/li=
stinfo/lttng-dev</a><br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature">J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS In=
c.<br><a href=3D"http://www.efficios.com" target=3D"_blank">http://www.effi=
cios.com</a></div>
</div>

--001a1139d2ba89298c051c6cc21d--


--===============1203763254==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1203763254==--
