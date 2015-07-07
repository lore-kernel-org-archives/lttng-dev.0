From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [RFC PATCH LTTNG-UST] Fix: Decrement sem_count when
 disabling local apps
Date: Tue, 7 Jul 2015 12:49:17 -0400
Message-ID: <CA+jJMxvrzcpd-mMSk0uDi4sc1k-yCH1qqS-PYFOps_HrmZSjTg__12055.5084351965$1436287810$gmane$org@mail.gmail.com>
References: <1436287682-3445-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0572030738=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1ZCW3f-0007Z7-JU
 for lttng-dev@lists.lttng.org; Tue, 07 Jul 2015 12:49:24 -0400
Received: by pacws9 with SMTP id ws9so117382187pac.0
 for <lttng-dev@lists.lttng.org>; Tue, 07 Jul 2015 09:49:18 -0700 (PDT)
In-Reply-To: <1436287682-3445-1-git-send-email-jeremie.galarneau@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0572030738==
Content-Type: multipart/alternative; boundary=047d7bd74d169b4f15051a4bcd54

--047d7bd74d169b4f15051a4bcd54
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2015 at 12:48 PM, J=C3=A9r=C3=A9mie Galarneau <
jeremie.galarneau@efficios.com> wrote:

> LTTng-UST will deadlock waiting on the "constructor_wait" semaphore
> if local apps, handled the session daemon running under the current UID,
> are disabled or "not_allowed".
>
> This deadlock can be triggered by setting an infinite registration
> timeout and clearing the HOME environment variable, which will cause
> setup_local_apps() to fail to determine the local_apps sock_path, thus
> leaving local_apps.allowed =3D=3D 0.
>
> Given that local_apps are not allowed at this point, the local_apps
> listener thread will not be launched. Therefore, the constructor_wait
> will not be waited on.
>

This should say "will not be posted".

J=C3=A9r=C3=A9mie


>
> The fix proposed here consists in decrementing "sem_count" if an error
> precluding the launch the the local_apps listener thread occurs.
>
> Signed-off-by: J=C3=A9r=C3=A9mie Galarneau <jeremie.galarneau@efficios.co=
m>
> ---
>  liblttng-ust/lttng-ust-comm.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/liblttng-ust/lttng-ust-comm.c b/liblttng-ust/lttng-ust-comm.=
c
> index b290204..c91627f 100644
> --- a/liblttng-ust/lttng-ust-comm.c
> +++ b/liblttng-ust/lttng-ust-comm.c
> @@ -373,6 +373,7 @@ void print_cmd(int cmd, int handle)
>  static
>  int setup_local_apps(void)
>  {
> +       int ret =3D 0;
>         const char *home_dir;
>         uid_t uid;
>
> @@ -382,13 +383,16 @@ int setup_local_apps(void)
>          */
>         if (uid !=3D geteuid()) {
>                 assert(local_apps.allowed =3D=3D 0);
> -               return 0;
> +               goto end;
>         }
>         home_dir =3D get_lttng_home_dir();
>         if (!home_dir) {
>                 WARN("HOME environment variable not set. Disabling
> LTTng-UST per-user tracing.");
>                 assert(local_apps.allowed =3D=3D 0);
> -               return -ENOENT;
> +               ret =3D -ENOENT;
> +               goto end;
> +       } else {
> +               DBG("home_dir: %s", home_dir);
>         }
>         local_apps.allowed =3D 1;
>         snprintf(local_apps.sock_path, PATH_MAX, "%s/%s/%s",
> @@ -398,7 +402,15 @@ int setup_local_apps(void)
>         snprintf(local_apps.wait_shm_path, PATH_MAX, "/%s-%u",
>                 LTTNG_UST_WAIT_FILENAME,
>                 uid);
> -       return 0;
> +end:
> +       if (!local_apps.allowed) {
> +               /*
> +                * Don't wait on the "local" listener thread since we
> won't be
> +                * communicating with the local session daemon.
> +                */
> +               uatomic_add(&sem_count, -1);
> +       }
> +       return ret;
>  }
>
>  /*
> --
> 2.4.4
>
>


--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--047d7bd74d169b4f15051a4bcd54
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Tue, Jul 7, 2015 at 12:48 PM, J=C3=A9r=C3=A9mie Galarneau <span dir=
=3D"ltr">&lt;<a href=3D"mailto:jeremie.galarneau@efficios.com" target=3D"_b=
lank">jeremie.galarneau@efficios.com</a>&gt;</span> wrote:<br><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex">LTTng-UST will deadlock waiting on the &quot;constructor_=
wait&quot; semaphore<br>
if local apps, handled the session daemon running under the current UID,<br=
>
are disabled or &quot;not_allowed&quot;.<br>
<br>
This deadlock can be triggered by setting an infinite registration<br>
timeout and clearing the HOME environment variable, which will cause<br>
setup_local_apps() to fail to determine the local_apps sock_path, thus<br>
leaving local_apps.allowed =3D=3D 0.<br>
<br>
Given that local_apps are not allowed at this point, the local_apps<br>
listener thread will not be launched. Therefore, the constructor_wait<br>
will not be waited on.<br></blockquote><div><br></div><div>This should say =
&quot;will not be posted&quot;.</div><div><br></div><div>J=C3=A9r=C3=A9mie<=
/div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
The fix proposed here consists in decrementing &quot;sem_count&quot; if an =
error<br>
precluding the launch the the local_apps listener thread occurs.<br>
<br>
Signed-off-by: J=C3=A9r=C3=A9mie Galarneau &lt;<a href=3D"mailto:jeremie.ga=
larneau@efficios.com">jeremie.galarneau@efficios.com</a>&gt;<br>
---<br>
=C2=A0liblttng-ust/lttng-ust-comm.c | 18 +++++++++++++++---<br>
=C2=A01 file changed, 15 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/liblttng-ust/lttng-ust-comm.c b/liblttng-ust/lttng-ust-comm.c<=
br>
index b290204..c91627f 100644<br>
--- a/liblttng-ust/lttng-ust-comm.c<br>
+++ b/liblttng-ust/lttng-ust-comm.c<br>
@@ -373,6 +373,7 @@ void print_cmd(int cmd, int handle)<br>
=C2=A0static<br>
=C2=A0int setup_local_apps(void)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *home_dir;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uid_t uid;<br>
<br>
@@ -382,13 +383,16 @@ int setup_local_apps(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (uid !=3D geteuid()) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(local_apps.a=
llowed =3D=3D 0);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto end;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 home_dir =3D get_lttng_home_dir();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!home_dir) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 WARN(&quot;HOME env=
ironment variable not set. Disabling LTTng-UST per-user tracing.&quot;);<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(local_apps.a=
llowed =3D=3D 0);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOENT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -ENOENT;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto end;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DBG(&quot;home_dir:=
 %s&quot;, home_dir);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 local_apps.allowed =3D 1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(local_apps.sock_path, PATH_MAX, &quot;=
%s/%s/%s&quot;,<br>
@@ -398,7 +402,15 @@ int setup_local_apps(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(local_apps.wait_shm_path, PATH_MAX, &q=
uot;/%s-%u&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 LTTNG_UST_WAIT_FILE=
NAME,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uid);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+end:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!local_apps.allowed) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Don&#39;t wait o=
n the &quot;local&quot; listener thread since we won&#39;t be<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * communicating wi=
th the local session daemon.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uatomic_add(&amp;se=
m_count, -1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0}<br>
<br>
=C2=A0/*<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
2.4.4<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature">J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS In=
c.<br><a href=3D"http://www.efficios.com" target=3D"_blank">http://www.effi=
cios.com</a></div>
</div></div>

--047d7bd74d169b4f15051a4bcd54--


--===============0572030738==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0572030738==--
