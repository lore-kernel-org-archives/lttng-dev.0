From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: handle sys_futex()
 FUTEX_WAIT interrupted by signal
Date: Fri, 10 Jul 2015 15:54:29 -0400
Message-ID: <CA+jJMxvOJ7d2rAKaiXyNEWFYxeT9TuvyLSD=7F6tk2pwkvWDeA__27567.146838601$1436558136$gmane$org@mail.gmail.com>
References: <1436218114-24098-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0657336903=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1ZDeNX-0004pj-77
 for lttng-dev@lists.lttng.org; Fri, 10 Jul 2015 15:54:36 -0400
Received: by pdjr16 with SMTP id r16so27971310pdj.3
 for <lttng-dev@lists.lttng.org>; Fri, 10 Jul 2015 12:54:29 -0700 (PDT)
In-Reply-To: <1436218114-24098-1-git-send-email-mathieu.desnoyers@efficios.com>
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

--===============0657336903==
Content-Type: multipart/alternative; boundary=001a11c326e26ffcaa051a8abd4e

--001a11c326e26ffcaa051a8abd4e
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Merged in master, stable-2.6 and stable-2.5. Thanks!

J=C3=A9r=C3=A9mie

On Mon, Jul 6, 2015 at 5:28 PM, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> We need to handle EINTR returned by sys_futex() FUTEX_WAIT, otherwise a
> signal interrupting this system call could make sys_futex return too
> early, and therefore cause a synchronization issue.
>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  src/common/futex.c | 37 ++++++++++++++++++++++++++++---------
>  1 file changed, 28 insertions(+), 9 deletions(-)
>
> diff --git a/src/common/futex.c b/src/common/futex.c
> index 7f07b11..0781867 100644
> --- a/src/common/futex.c
> +++ b/src/common/futex.c
> @@ -55,8 +55,11 @@ void futex_wait_update(int32_t *futex, int active)
>  {
>         if (active) {
>                 uatomic_set(futex, 1);
> -               futex_async(futex, FUTEX_WAKE,
> -                               INT_MAX, NULL, NULL, 0);
> +               if (futex_async(futex, FUTEX_WAKE,
> +                               INT_MAX, NULL, NULL, 0) < 0) {
> +                       PERROR("futex_async");
> +                       abort();
> +               }
>         } else {
>                 uatomic_set(futex, 0);
>         }
> @@ -84,10 +87,23 @@ void futex_nto1_wait(int32_t *futex)
>  {
>         cmm_smp_mb();
>
> -       if (uatomic_read(futex) =3D=3D -1) {
> -               futex_async(futex, FUTEX_WAIT, -1, NULL, NULL, 0);
> +       if (uatomic_read(futex) !=3D -1)
> +               goto end;
> +       while (futex_async(futex, FUTEX_WAIT, -1, NULL, NULL, 0)) {
> +               switch (errno) {
> +               case EWOULDBLOCK:
> +                       /* Value already changed. */
> +                       goto end;
> +               case EINTR:
> +                       /* Retry if interrupted by signal. */
> +                       break;  /* Get out of switch. */
> +               default:
> +                       /* Unexpected error. */
> +                       PERROR("futex_async");
> +                       abort();
> +               }
>         }
> -
> +end:
>         DBG("Futex n to 1 wait done");
>  }
>
> @@ -97,10 +113,13 @@ void futex_nto1_wait(int32_t *futex)
>  LTTNG_HIDDEN
>  void futex_nto1_wake(int32_t *futex)
>  {
> -       if (caa_unlikely(uatomic_read(futex) =3D=3D -1)) {
> -               uatomic_set(futex, 0);
> -               futex_async(futex, FUTEX_WAKE, 1, NULL, NULL, 0);
> +       if (caa_unlikely(uatomic_read(futex) !=3D -1))
> +               goto end;
> +       uatomic_set(futex, 0);
> +       if (futex_async(futex, FUTEX_WAKE, 1, NULL, NULL, 0) < 0) {
> +               PERROR("futex_async");
> +               abort();
>         }
> -
> +end:
>         DBG("Futex n to 1 wake done");
>  }
> --
> 2.1.4
>
>


--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--001a11c326e26ffcaa051a8abd4e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Merged in master, stable-2.6 and stable-2.5. Thanks!<=
/div><div><br></div><div>J=C3=A9r=C3=A9mie</div></div><div class=3D"gmail_e=
xtra"><br><div class=3D"gmail_quote">On Mon, Jul 6, 2015 at 5:28 PM, Mathie=
u Desnoyers <span dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.desnoyers@effic=
ios.com" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;</span> wr=
ote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex"><span class=3D"">We need to handle E=
INTR returned by sys_futex() FUTEX_WAIT, otherwise a<br>
signal interrupting this system call could make sys_futex return too<br>
early, and therefore cause a synchronization issue.<br>
<br>
</span><span class=3D"">Signed-off-by: Mathieu Desnoyers &lt;<a href=3D"mai=
lto:mathieu.desnoyers@efficios.com">mathieu.desnoyers@efficios.com</a>&gt;<=
br>
---<br>
</span>=C2=A0src/common/futex.c | 37 ++++++++++++++++++++++++++++---------<=
br>
=C2=A01 file changed, 28 insertions(+), 9 deletions(-)<br>
<br>
diff --git a/src/common/futex.c b/src/common/futex.c<br>
index 7f07b11..0781867 100644<br>
--- a/src/common/futex.c<br>
+++ b/src/common/futex.c<br>
@@ -55,8 +55,11 @@ void futex_wait_update(int32_t *futex, int active)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (active) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uatomic_set(futex, =
1);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0futex_async(futex, =
FUTEX_WAKE,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0INT_MAX, NULL, NULL, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (futex_async(fut=
ex, FUTEX_WAKE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0INT_MAX, NULL, NULL, 0) &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0PERROR(&quot;futex_async&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0abort();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uatomic_set(futex, =
0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
@@ -84,10 +87,23 @@ void futex_nto1_wait(int32_t *futex)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmm_smp_mb();<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (uatomic_read(futex) =3D=3D -1) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0futex_async(futex, =
FUTEX_WAIT, -1, NULL, NULL, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (uatomic_read(futex) !=3D -1)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto end;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0while (futex_async(futex, FUTEX_WAIT, -1, NULL,=
 NULL, 0)) {<br>
<span class=3D"">+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sw=
itch (errno) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case EWOULDBLOCK:<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* Value already changed. */<br>
</span>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0goto end;<br>
<span class=3D"">+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ca=
se EINTR:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* Retry if interrupted by signal. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;=C2=A0 /* Get out of switch. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* Unexpected error. */<br>
</span>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0PERROR(&quot;futex_async&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0abort();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-<br>
+end:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 DBG(&quot;Futex n to 1 wait done&quot;);<br>
=C2=A0}<br>
<br>
@@ -97,10 +113,13 @@ void futex_nto1_wait(int32_t *futex)<br>
=C2=A0LTTNG_HIDDEN<br>
=C2=A0void futex_nto1_wake(int32_t *futex)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (caa_unlikely(uatomic_read(futex) =3D=3D -1)=
) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uatomic_set(futex, =
0);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0futex_async(futex, =
FUTEX_WAKE, 1, NULL, NULL, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (caa_unlikely(uatomic_read(futex) !=3D -1))<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto end;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uatomic_set(futex, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (futex_async(futex, FUTEX_WAKE, 1, NULL, NUL=
L, 0) &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PERROR(&quot;futex_=
async&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0abort();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-<br>
+end:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 DBG(&quot;Futex n to 1 wake done&quot;);<br>
=C2=A0}<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
2.1.4<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature">J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS In=
c.<br><a href=3D"http://www.efficios.com" target=3D"_blank">http://www.effi=
cios.com</a></div>
</div>

--001a11c326e26ffcaa051a8abd4e--


--===============0657336903==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0657336903==--
