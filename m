From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Build: bump autoconf version
	requirement to 2.64
Date: Thu, 2 Jul 2015 20:20:09 -0400
Message-ID: <CA+jJMxsai0V-aW6VMphgDmT7MhiMeOqRU6W9FEd9=RsFOa9vMQ__712.690541013394$1435882884$gmane$org@mail.gmail.com>
References: <1435877732-29499-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0325240972=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1ZAoiF-0007GH-MG
 for lttng-dev@lists.lttng.org; Thu, 02 Jul 2015 20:20:19 -0400
Received: by paceq1 with SMTP id eq1so47802733pac.3
 for <lttng-dev@lists.lttng.org>; Thu, 02 Jul 2015 17:20:10 -0700 (PDT)
In-Reply-To: <1435877732-29499-1-git-send-email-jonathan.rajotte-julien@efficios.com>
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

--===============0325240972==
Content-Type: multipart/alternative; boundary=047d7bd754bcd49ab90519ed8416

--047d7bd754bcd49ab90519ed8416
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Merged in master, stable-2.6 and stable-2.5.

Thanks!
J=C3=A9r=C3=A9mie

On Thu, Jul 2, 2015 at 6:55 PM, Jonathan Rajotte <
jonathan.rajotte-julien@efficios.com> wrote:

> AC_INIT with package_url was introduced in AC 2.64
>
> Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
> ---
>  README.md    | 2 +-
>  configure.ac | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/README.md b/README.md
> index 2cb75b1..8c412cd 100644
> --- a/README.md
> +++ b/README.md
> @@ -59,7 +59,7 @@ This source tree is based on the Autotools suite from
> GNU to simplify
>  portability. Here are some things you should have on your system in
>  order to compile the Git repository tree:
>
> -  - GNU Autotools (Automake >=3D 1.10, Autoconf >=3D 2.50,
> +  - GNU Autotools (Automake >=3D 1.10, Autoconf >=3D 2.64,
>      Autoheader >=3D 2.50; make sure your system-wide `automake` points t=
o
>      a recent version!)
>    - [GNU Libtool](http://www.gnu.org/software/autoconf/) >=3D 2.2
> diff --git a/configure.ac b/configure.ac
> index 48c3cb3..1fcac72 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -1,3 +1,4 @@
> +AC_PREREQ([2.64])
>  AC_INIT([lttng-tools],[2.7.0-pre],[jeremie.galarneau@efficios.com],[],[
> https://lttng.org])
>  AC_CONFIG_AUX_DIR([config])
>  AC_CANONICAL_TARGET
> --
> 2.1.4
>
>


--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--047d7bd754bcd49ab90519ed8416
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Merged in master, stable-2.6 and stable-2.5.<div><br></div=
><div>Thanks!</div><div>J=C3=A9r=C3=A9mie</div></div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Thu, Jul 2, 2015 at 6:55 PM, Jonatha=
n Rajotte <span dir=3D"ltr">&lt;<a href=3D"mailto:jonathan.rajotte-julien@e=
fficios.com" target=3D"_blank">jonathan.rajotte-julien@efficios.com</a>&gt;=
</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">AC_INIT with package_url w=
as introduced in AC 2.64<br>
<br>
Signed-off-by: Jonathan Rajotte &lt;<a href=3D"mailto:jonathan.rajotte-juli=
en@efficios.com">jonathan.rajotte-julien@efficios.com</a>&gt;<br>
---<br>
=C2=A0README.md=C2=A0 =C2=A0 | 2 +-<br>
=C2=A0<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a> | 1 +<br>
=C2=A02 files changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/README.md b/README.md<br>
index 2cb75b1..8c412cd 100644<br>
--- a/README.md<br>
+++ b/README.md<br>
@@ -59,7 +59,7 @@ This source tree is based on the Autotools suite from GNU=
 to simplify<br>
=C2=A0portability. Here are some things you should have on your system in<b=
r>
=C2=A0order to compile the Git repository tree:<br>
<br>
-=C2=A0 - GNU Autotools (Automake &gt;=3D 1.10, Autoconf &gt;=3D 2.50,<br>
+=C2=A0 - GNU Autotools (Automake &gt;=3D 1.10, Autoconf &gt;=3D 2.64,<br>
=C2=A0 =C2=A0 =C2=A0Autoheader &gt;=3D 2.50; make sure your system-wide `au=
tomake` points to<br>
=C2=A0 =C2=A0 =C2=A0a recent version!)<br>
=C2=A0 =C2=A0- [GNU Libtool](<a href=3D"http://www.gnu.org/software/autocon=
f/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.org/software/autoco=
nf/</a>) &gt;=3D 2.2<br>
diff --git a/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_=
blank">configure.ac</a> b/<a href=3D"http://configure.ac" rel=3D"noreferrer=
" target=3D"_blank">configure.ac</a><br>
index 48c3cb3..1fcac72 100644<br>
--- a/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a><br>
+++ b/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a><br>
@@ -1,3 +1,4 @@<br>
+AC_PREREQ([2.64])<br>
=C2=A0AC_INIT([lttng-tools],[2.7.0-pre],[<a href=3D"mailto:jeremie.galarnea=
u@efficios.com">jeremie.galarneau@efficios.com</a>],[],[<a href=3D"https://=
lttng.org" rel=3D"noreferrer" target=3D"_blank">https://lttng.org</a>])<br>
=C2=A0AC_CONFIG_AUX_DIR([config])<br>
=C2=A0AC_CANONICAL_TARGET<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
2.1.4<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature">J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS In=
c.<br><a href=3D"http://www.efficios.com" target=3D"_blank">http://www.effi=
cios.com</a></div>
</div>

--047d7bd754bcd49ab90519ed8416--


--===============0325240972==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0325240972==--
