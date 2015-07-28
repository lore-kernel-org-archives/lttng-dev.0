From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools 1/2] Fix: pids should be numbers
	only
Date: Tue, 28 Jul 2015 11:51:06 -0400
Message-ID: <CA+jJMxss0H3ZpkneDY9XAgehYnzi5DBRCEQoGs=E5WCFfVJa5w__1313.34368275038$1438098755$gmane$org@mail.gmail.com>
References: <1437774180-32746-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0389942609=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1ZK79s-0007YP-P1
 for lttng-dev@lists.lttng.org; Tue, 28 Jul 2015 11:51:20 -0400
Received: by pdbbh15 with SMTP id bh15so72813426pdb.1
 for <lttng-dev@lists.lttng.org>; Tue, 28 Jul 2015 08:51:07 -0700 (PDT)
In-Reply-To: <1437774180-32746-1-git-send-email-jonathan.rajotte-julien@efficios.com>
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

--===============0389942609==
Content-Type: multipart/alternative; boundary=047d7bd74d162f7f54051bf17042

--047d7bd74d162f7f54051bf17042
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Merged, thanks!

J/r/mie

On Fri, Jul 24, 2015 at 5:42 PM, Jonathan Rajotte <
jonathan.rajotte-julien@efficios.com> wrote:

> Ruled out cases: word, number+word, word+number, number+word+number
> Ex: foo, 123foo, foo123, 123foo123
>
> Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
> ---
>  src/bin/lttng/commands/track-untrack.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/src/bin/lttng/commands/track-untrack.c
> b/src/bin/lttng/commands/track-untrack.c
> index 52442cc..639e184 100644
> --- a/src/bin/lttng/commands/track-untrack.c
> +++ b/src/bin/lttng/commands/track-untrack.c
> @@ -96,6 +96,7 @@ int parse_pid_string(const char *_pid_string,
>         int count =3D 0;
>         int *pid_list =3D NULL;
>         char *pid_string =3D NULL;
> +       char *endptr;
>
>         if (all && _pid_string) {
>                 ERR("An empty PID string is expected with --all");
> @@ -132,13 +133,16 @@ int parse_pid_string(const char *_pid_string,
>         while (one_pid_str !=3D NULL) {
>                 unsigned long v;
>
> -               v =3D strtoul(one_pid_str, NULL, 10);
> +               errno =3D 0;
> +               v =3D strtoul(one_pid_str, &endptr, 10);
>                 if ((v =3D=3D 0 && errno =3D=3D EINVAL)
> -                               || (v =3D=3D ULONG_MAX && errno =3D=3D ER=
ANGE)) {
> +                               || (v =3D=3D ULONG_MAX && errno =3D=3D ER=
ANGE)
> +                               || (*one_pid_str !=3D '\0' && *endptr !=
=3D
> '\0')){
>                         ERR("Error parsing PID %s", one_pid_str);
>                         retval =3D CMD_ERROR;
>                         goto error;
>                 }
> +
>                 if ((long) v > INT_MAX || (int) v < 0) {
>                         ERR("Invalid PID value %ld", (long) v);
>                         retval =3D CMD_ERROR;
> --
> 2.1.4
>
>


--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--047d7bd74d162f7f54051bf17042
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Merged, thanks!<div><br></div><div>J/r/mie</div></div><div=
 class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Fri, Jul 24, 2015 =
at 5:42 PM, Jonathan Rajotte <span dir=3D"ltr">&lt;<a href=3D"mailto:jonath=
an.rajotte-julien@efficios.com" target=3D"_blank">jonathan.rajotte-julien@e=
fficios.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Ruled o=
ut cases: word, number+word, word+number, number+word+number<br>
Ex: foo, 123foo, foo123, 123foo123<br>
<br>
Signed-off-by: Jonathan Rajotte &lt;<a href=3D"mailto:jonathan.rajotte-juli=
en@efficios.com">jonathan.rajotte-julien@efficios.com</a>&gt;<br>
---<br>
=C2=A0src/bin/lttng/commands/track-untrack.c | 8 ++++++--<br>
=C2=A01 file changed, 6 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/src/bin/lttng/commands/track-untrack.c b/src/bin/lttng/command=
s/track-untrack.c<br>
index 52442cc..639e184 100644<br>
--- a/src/bin/lttng/commands/track-untrack.c<br>
+++ b/src/bin/lttng/commands/track-untrack.c<br>
@@ -96,6 +96,7 @@ int parse_pid_string(const char *_pid_string,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int count =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int *pid_list =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 char *pid_string =3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0char *endptr;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (all &amp;&amp; _pid_string) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ERR(&quot;An empty =
PID string is expected with --all&quot;);<br>
@@ -132,13 +133,16 @@ int parse_pid_string(const char *_pid_string,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 while (one_pid_str !=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long v;<br=
>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0v =3D strtoul(one_p=
id_str, NULL, 10);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0errno =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0v =3D strtoul(one_p=
id_str, &amp;endptr, 10);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((v =3D=3D 0 &am=
p;&amp; errno =3D=3D EINVAL)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|| (v =3D=3D ULONG_MAX &amp;&amp; err=
no =3D=3D ERANGE)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|| (v =3D=3D ULONG_MAX &amp;&amp; err=
no =3D=3D ERANGE)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|| (*one_pid_str !=3D &#39;\0&#39; &a=
mp;&amp; *endptr !=3D &#39;\0&#39;)){<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ERR(&quot;Error parsing PID %s&quot;, one_pid_str);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 retval =3D CMD_ERROR;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto error;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((long) v &gt; I=
NT_MAX || (int) v &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ERR(&quot;Invalid PID value %ld&quot;, (long) v);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 retval =3D CMD_ERROR;<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
2.1.4<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature">J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS In=
c.<br><a href=3D"http://www.efficios.com" target=3D"_blank">http://www.effi=
cios.com</a></div>
</div>

--047d7bd74d162f7f54051bf17042--


--===============0389942609==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0389942609==--
