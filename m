From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH babeltrace] Build: add version check on
	autoconf
Date: Thu, 2 Jul 2015 18:18:06 -0400
Message-ID: <CA+jJMxsMW5z9Rzx+EtjETRZozxteTYHumDUgyXLUjP6eZ9AJQA__37052.6764113039$1435875608$gmane$org@mail.gmail.com>
References: <1435866620-959-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0299803195=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1ZAmo8-0006Xz-3n
 for lttng-dev@lists.lttng.org; Thu, 02 Jul 2015 18:18:13 -0400
Received: by pdcu2 with SMTP id u2so52823279pdc.3
 for <lttng-dev@lists.lttng.org>; Thu, 02 Jul 2015 15:18:06 -0700 (PDT)
In-Reply-To: <1435866620-959-1-git-send-email-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0299803195==
Content-Type: multipart/alternative; boundary=047d7bd74d164fb3f70519ebd0c0

--047d7bd74d164fb3f70519ebd0c0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Merged in master and stable-1.2, thanks!

J=C3=A9r=C3=A9mie

On Thu, Jul 2, 2015 at 3:50 PM, Jonathan Rajotte <
jonathan.rajotte-julien@efficios.com> wrote:

> Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
> ---
>  configure.ac | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/configure.ac b/configure.ac
> index f8d43d8..afd6db5 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -1,6 +1,7 @@
>  #                                               -*- Autoconf -*-
>  # Process this file with autoconf to produce a configure script.
>
> +AC_PREREQ([2.50])
>  AC_INIT([babeltrace],[1.3.0-pre],[jeremie dot galarneau at efficios dot
> com])
>
>  # Following the numbering scheme proposed by libtool for the library
> version
> --
> 2.1.4
>
>


--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--047d7bd74d164fb3f70519ebd0c0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Merged in master and stable-1.2, thanks!<div><br></div><di=
v>J=C3=A9r=C3=A9mie</div></div><div class=3D"gmail_extra"><br><div class=3D=
"gmail_quote">On Thu, Jul 2, 2015 at 3:50 PM, Jonathan Rajotte <span dir=3D=
"ltr">&lt;<a href=3D"mailto:jonathan.rajotte-julien@efficios.com" target=3D=
"_blank">jonathan.rajotte-julien@efficios.com</a>&gt;</span> wrote:<br><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex">Signed-off-by: Jonathan Rajotte &lt;<a href=3D"m=
ailto:jonathan.rajotte-julien@efficios.com">jonathan.rajotte-julien@efficio=
s.com</a>&gt;<br>
---<br>
=C2=A0<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a> | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br>
diff --git a/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_=
blank">configure.ac</a> b/<a href=3D"http://configure.ac" rel=3D"noreferrer=
" target=3D"_blank">configure.ac</a><br>
index f8d43d8..afd6db5 100644<br>
--- a/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a><br>
+++ b/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a><br>
@@ -1,6 +1,7 @@<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0-*- Autoconf -*-<br>
=C2=A0# Process this file with autoconf to produce a configure script.<br>
<br>
+AC_PREREQ([2.50])<br>
=C2=A0AC_INIT([babeltrace],[1.3.0-pre],[jeremie dot galarneau at efficios d=
ot com])<br>
<br>
=C2=A0# Following the numbering scheme proposed by libtool for the library =
version<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
2.1.4<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature">J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS In=
c.<br><a href=3D"http://www.efficios.com" target=3D"_blank">http://www.effi=
cios.com</a></div>
</div>

--047d7bd74d164fb3f70519ebd0c0--


--===============0299803195==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0299803195==--
