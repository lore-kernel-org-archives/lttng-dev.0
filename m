From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools 2/2] Fix: do not spawn sessiond
 on track/untrack commands
Date: Mon, 27 Jul 2015 11:42:58 -0400
Message-ID: <CA+jJMxueXdT_9MApXHvFwmOzQyw=xN=_kppoPu09+4tR4s_LOw__11177.8605067686$1438011844$gmane$org@mail.gmail.com>
References: <1437774180-32746-1-git-send-email-jonathan.rajotte-julien@efficios.com>
 <1437774180-32746-2-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1649402420=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1ZJkYS-0008TD-G4
 for lttng-dev@lists.lttng.org; Mon, 27 Jul 2015 11:43:08 -0400
Received: by pdbbh15 with SMTP id bh15so53979566pdb.1
 for <lttng-dev@lists.lttng.org>; Mon, 27 Jul 2015 08:42:58 -0700 (PDT)
In-Reply-To: <1437774180-32746-2-git-send-email-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

--===============1649402420==
Content-Type: multipart/alternative; boundary=047d7bdc18a63fa444051bdd3566

--047d7bdc18a63fa444051bdd3566
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

I have decided to apply a different fix which ensures that only the
"create" command actually spawns a session daemon.

https://github.com/lttng/lttng-tools/commit/92360082fd291a95695fb612d773ae1=
bb991c256

Thanks!
J=C3=A9r=C3=A9mie

On Fri, Jul 24, 2015 at 5:43 PM, Jonathan Rajotte <
jonathan.rajotte-julien@efficios.com> wrote:

> Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
> ---
>  src/bin/lttng/lttng.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/src/bin/lttng/lttng.c b/src/bin/lttng/lttng.c
> index 13c7732..4cc320c 100644
> --- a/src/bin/lttng/lttng.c
> +++ b/src/bin/lttng/lttng.c
> @@ -432,7 +432,9 @@ static int check_args_no_sessiond(int argc, char
> **argv)
>                                 strncmp(argv[i], "--list-options",
> sizeof("--list-options")) =3D=3D 0 ||
>                                 strncmp(argv[i], "--list-commands",
> sizeof("--list-commands")) =3D=3D 0 ||
>                                 strncmp(argv[i], "version",
> sizeof("version")) =3D=3D 0 ||
> -                               strncmp(argv[i], "view", sizeof("view"))
> =3D=3D 0) {
> +                               strncmp(argv[i], "view", sizeof("view"))
> =3D=3D 0 ||
> +                               strncmp(argv[i], "track", sizeof("track")=
)
> =3D=3D 0 ||
> +                               strncmp(argv[i], "untrack",
> sizeof("untrack")) =3D=3D 0) {
>                         return 1;
>                 }
>         }
> --
> 2.1.4
>
>


--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--047d7bdc18a63fa444051bdd3566
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Jonathan,<div><br></div><div>I have decided to apply a =
different fix which ensures that only the &quot;create&quot; command actual=
ly spawns a session daemon.</div><div><br></div><div><a href=3D"https://git=
hub.com/lttng/lttng-tools/commit/92360082fd291a95695fb612d773ae1bb991c256">=
https://github.com/lttng/lttng-tools/commit/92360082fd291a95695fb612d773ae1=
bb991c256</a></div><div><br></div><div>Thanks!</div><div>J=C3=A9r=C3=A9mie<=
br><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Fri, Jul 24=
, 2015 at 5:43 PM, Jonathan Rajotte <span dir=3D"ltr">&lt;<a href=3D"mailto=
:jonathan.rajotte-julien@efficios.com" target=3D"_blank">jonathan.rajotte-j=
ulien@efficios.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">=
Signed-off-by: Jonathan Rajotte &lt;<a href=3D"mailto:jonathan.rajotte-juli=
en@efficios.com">jonathan.rajotte-julien@efficios.com</a>&gt;<br>
---<br>
=C2=A0src/bin/lttng/lttng.c | 4 +++-<br>
=C2=A01 file changed, 3 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/src/bin/lttng/lttng.c b/src/bin/lttng/lttng.c<br>
index 13c7732..4cc320c 100644<br>
--- a/src/bin/lttng/lttng.c<br>
+++ b/src/bin/lttng/lttng.c<br>
@@ -432,7 +432,9 @@ static int check_args_no_sessiond(int argc, char **argv=
)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strncmp(argv[i], &quot;--list-option=
s&quot;, sizeof(&quot;--list-options&quot;)) =3D=3D 0 ||<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strncmp(argv[i], &quot;--list-comman=
ds&quot;, sizeof(&quot;--list-commands&quot;)) =3D=3D 0 ||<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strncmp(argv[i], &quot;version&quot;=
, sizeof(&quot;version&quot;)) =3D=3D 0 ||<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strncmp(argv[i], &quot;view&quot;, si=
zeof(&quot;view&quot;)) =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strncmp(argv[i], &quot;view&quot;, si=
zeof(&quot;view&quot;)) =3D=3D 0 ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strncmp(argv[i], &quot;track&quot;, s=
izeof(&quot;track&quot;)) =3D=3D 0 ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strncmp(argv[i], &quot;untrack&quot;,=
 sizeof(&quot;untrack&quot;)) =3D=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return 1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
2.1.4<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature">J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS In=
c.<br><a href=3D"http://www.efficios.com" target=3D"_blank">http://www.effi=
cios.com</a></div>
</div></div></div>

--047d7bdc18a63fa444051bdd3566--


--===============1649402420==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1649402420==--
