From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH babeltrace] Build: Update m4 for bison &
 flex version check to match autoconf-archive file
Date: Fri, 10 Jul 2015 17:35:01 -0400
Message-ID: <CA+jJMxuszvHmnUAacgkKUhpaoqJ_=6rveH22cYGJbZDY2qq86w__42990.854002028$1436564160$gmane$org@mail.gmail.com>
References: <1436542605-22356-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0377202191=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1ZDfwp-0005Ql-IM
 for lttng-dev@lists.lttng.org; Fri, 10 Jul 2015 17:35:11 -0400
Received: by pdbep18 with SMTP id ep18so190554790pdb.1
 for <lttng-dev@lists.lttng.org>; Fri, 10 Jul 2015 14:35:02 -0700 (PDT)
In-Reply-To: <1436542605-22356-1-git-send-email-jonathan.rajotte-julien@efficios.com>
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

--===============0377202191==
Content-Type: multipart/alternative; boundary=047d7bfe9aa4fc9bbb051a8c24a8

--047d7bfe9aa4fc9bbb051a8c24a8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Merged in master and stable-1.2.

Thanks!
J=C3=A9r=C3=A9mie

On Fri, Jul 10, 2015 at 11:36 AM, Jonathan Rajotte <
jonathan.rajotte-julien@efficios.com> wrote:

> Officials m4 were merged in [1][2].
>
> [1]
> https://github.com/peti/autoconf-archive/commit/b2bdd8591b2d6b1eb580ead5f=
978a30e3ecfc36c
> [2]
> https://github.com/peti/autoconf-archive/commit/fd1f2862c1524e73495d67646=
d26000e2e85e807
>
> Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
> ---
>  m4/ax_prog_bison_version.m4 | 21 +++++++++++++--------
>  m4/ax_prog_flex_version.m4  | 19 ++++++++++++-------
>  2 files changed, 25 insertions(+), 15 deletions(-)
>
> diff --git a/m4/ax_prog_bison_version.m4 b/m4/ax_prog_bison_version.m4
> index 6b95585..5da478c 100644
> --- a/m4/ax_prog_bison_version.m4
> +++ b/m4/ax_prog_bison_version.m4
> @@ -1,22 +1,27 @@
> +#
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +#
> http://www.gnu.org/software/autoconf-archive/ax_prog_bison_version.html
> +#
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +#
>  # SYNOPSIS
>  #
>  #   AX_PROG_BISON_VERSION([VERSION],[ACTION-IF-TRUE],[ACTION-IF-FALSE])
>  #
>  # DESCRIPTION
>  #
> -#   Makes sure that bison version is greater or equal to the version
> indicated.
> -#   If true the shell commands in ACTION-IF-TRUE are executed. If not th=
e
> shell
> -#   commands in commands in ACTION-IF-TRUE are executed. If not the shel=
l
> -#   commands in ACTION-IF-FALSE are run. Note if $BISON is not set (for
> example
> -#   by running AC_CHECK_PROG or AC_PATH_PROG) the macro will fail.
> +#   Makes sure that bison version is greater or equal to the version
> +#   indicated. If true the shell commands in ACTION-IF-TRUE are executed=
.
> If
> +#   not the shell commands in commands in ACTION-IF-TRUE are executed. I=
f
> +#   not the shell commands in ACTION-IF-FALSE are run. Note if $BISON is
> not
> +#   set (for example by running AC_CHECK_PROG or AC_PATH_PROG) the macro
> +#   will fail.
>  #
>  #   Example:
>  #
>  #     AC_PATH_PROG([BISON],[bison])
>  #     AX_PROG_BISON_VERSION([3.0.2],[ ... ],[ ... ])
>  #
> -#   This will check to make sure that the bison you have is at least
> -#   version 3.0.2 or greater.
> +#   This will check to make sure that the bison you have is at least
> version
> +#   3.0.2 or greater.
>  #
>  #   NOTE: This macro uses the $BISON variable to perform the check.
>  #
> @@ -29,7 +34,7 @@
>  #   and this notice are preserved. This file is offered as-is, without a=
ny
>  #   warranty.
>
> -#serial 12
> +#serial 2
>
>  AC_DEFUN([AX_PROG_BISON_VERSION],[
>      AC_REQUIRE([AC_PROG_SED])
> diff --git a/m4/ax_prog_flex_version.m4 b/m4/ax_prog_flex_version.m4
> index f1ad9ef..da60e00 100644
> --- a/m4/ax_prog_flex_version.m4
> +++ b/m4/ax_prog_flex_version.m4
> @@ -1,22 +1,27 @@
> +#
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +#
> http://www.gnu.org/software/autoconf-archive/ax_prog_flex_version.html
> +#
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +#
>  # SYNOPSIS
>  #
>  #   AX_PROG_FLEX_VERSION([VERSION],[ACTION-IF-TRUE],[ACTION-IF-FALSE])
>  #
>  # DESCRIPTION
>  #
> -#   Makes sure that flex version is greater or equal to the version
> indicated.
> -#   If true the shell commands in ACTION-IF-TRUE are executed. If not th=
e
> shell
> -#   commands in commands in ACTION-IF-TRUE are executed. If not the shel=
l
> -#   commands in ACTION-IF-FALSE are run. Note if $FLEX is not set (for
> example
> -#   by running AC_CHECK_PROG or AC_PATH_PROG) the macro will fail.
> +#   Makes sure that flex version is greater or equal to the version
> +#   indicated. If true the shell commands in ACTION-IF-TRUE are executed=
.
> If
> +#   not the shell commands in commands in ACTION-IF-TRUE are executed. I=
f
> +#   not the shell commands in ACTION-IF-FALSE are run. Note if $FLEX is
> not
> +#   set (for example by running AC_CHECK_PROG or AC_PATH_PROG) the macro
> +#   will fail.
>  #
>  #   Example:
>  #
>  #     AC_PATH_PROG([FLEX],[flex])
>  #     AX_PROG_FLEX_VERSION([2.5.39],[ ... ],[ ... ])
>  #
> -#   This will check to make sure that the flex you have is at least
> -#   version 2.5.39 or greater.
> +#   This will check to make sure that the flex you have is at least
> version
> +#   2.5.39 or greater.
>  #
>  #   NOTE: This macro uses the $FLEX variable to perform the check.
>  #
> --
> 2.1.4
>
>


--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--047d7bfe9aa4fc9bbb051a8c24a8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Merged in master and stable-1.2.<div><br></div><div>Thanks=
!</div><div>J=C3=A9r=C3=A9mie</div></div><div class=3D"gmail_extra"><br><di=
v class=3D"gmail_quote">On Fri, Jul 10, 2015 at 11:36 AM, Jonathan Rajotte =
<span dir=3D"ltr">&lt;<a href=3D"mailto:jonathan.rajotte-julien@efficios.co=
m" target=3D"_blank">jonathan.rajotte-julien@efficios.com</a>&gt;</span> wr=
ote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex">Officials m4 were merged in [1][2].<=
br>
<br>
[1] <a href=3D"https://github.com/peti/autoconf-archive/commit/b2bdd8591b2d=
6b1eb580ead5f978a30e3ecfc36c" rel=3D"noreferrer" target=3D"_blank">https://=
github.com/peti/autoconf-archive/commit/b2bdd8591b2d6b1eb580ead5f978a30e3ec=
fc36c</a><br>
[2] <a href=3D"https://github.com/peti/autoconf-archive/commit/fd1f2862c152=
4e73495d67646d26000e2e85e807" rel=3D"noreferrer" target=3D"_blank">https://=
github.com/peti/autoconf-archive/commit/fd1f2862c1524e73495d67646d26000e2e8=
5e807</a><br>
<br>
Signed-off-by: Jonathan Rajotte &lt;<a href=3D"mailto:jonathan.rajotte-juli=
en@efficios.com">jonathan.rajotte-julien@efficios.com</a>&gt;<br>
---<br>
=C2=A0m4/ax_prog_bison_version.m4 | 21 +++++++++++++--------<br>
=C2=A0m4/ax_prog_flex_version.m4=C2=A0 | 19 ++++++++++++-------<br>
=C2=A02 files changed, 25 insertions(+), 15 deletions(-)<br>
<br>
diff --git a/m4/ax_prog_bison_version.m4 b/m4/ax_prog_bison_version.m4<br>
index 6b95585..5da478c 100644<br>
--- a/m4/ax_prog_bison_version.m4<br>
+++ b/m4/ax_prog_bison_version.m4<br>
@@ -1,22 +1,27 @@<br>
+# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D<br>
+#=C2=A0 =C2=A0<a href=3D"http://www.gnu.org/software/autoconf-archive/ax_p=
rog_bison_version.html" rel=3D"noreferrer" target=3D"_blank">http://www.gnu=
.org/software/autoconf-archive/ax_prog_bison_version.html</a><br>
+# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D<br>
+#<br>
=C2=A0# SYNOPSIS<br>
=C2=A0#<br>
=C2=A0#=C2=A0 =C2=A0AX_PROG_BISON_VERSION([VERSION],[ACTION-IF-TRUE],[ACTIO=
N-IF-FALSE])<br>
=C2=A0#<br>
=C2=A0# DESCRIPTION<br>
=C2=A0#<br>
-#=C2=A0 =C2=A0Makes sure that bison version is greater or equal to the ver=
sion indicated.<br>
-#=C2=A0 =C2=A0If true the shell commands in ACTION-IF-TRUE are executed. I=
f not the shell<br>
-#=C2=A0 =C2=A0commands in commands in ACTION-IF-TRUE are executed. If not =
the shell<br>
-#=C2=A0 =C2=A0commands in ACTION-IF-FALSE are run. Note if $BISON is not s=
et (for example<br>
-#=C2=A0 =C2=A0by running AC_CHECK_PROG or AC_PATH_PROG) the macro will fai=
l.<br>
+#=C2=A0 =C2=A0Makes sure that bison version is greater or equal to the ver=
sion<br>
+#=C2=A0 =C2=A0indicated. If true the shell commands in ACTION-IF-TRUE are =
executed. If<br>
+#=C2=A0 =C2=A0not the shell commands in commands in ACTION-IF-TRUE are exe=
cuted. If<br>
+#=C2=A0 =C2=A0not the shell commands in ACTION-IF-FALSE are run. Note if $=
BISON is not<br>
+#=C2=A0 =C2=A0set (for example by running AC_CHECK_PROG or AC_PATH_PROG) t=
he macro<br>
+#=C2=A0 =C2=A0will fail.<br>
=C2=A0#<br>
=C2=A0#=C2=A0 =C2=A0Example:<br>
=C2=A0#<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0AC_PATH_PROG([BISON],[bison])<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0AX_PROG_BISON_VERSION([3.0.2],[ ... ],[ ... ])<b=
r>
=C2=A0#<br>
-#=C2=A0 =C2=A0This will check to make sure that the bison you have is at l=
east<br>
-#=C2=A0 =C2=A0version 3.0.2 or greater.<br>
+#=C2=A0 =C2=A0This will check to make sure that the bison you have is at l=
east version<br>
+#=C2=A0 =C2=A03.0.2 or greater.<br>
=C2=A0#<br>
=C2=A0#=C2=A0 =C2=A0NOTE: This macro uses the $BISON variable to perform th=
e check.<br>
=C2=A0#<br>
@@ -29,7 +34,7 @@<br>
=C2=A0#=C2=A0 =C2=A0and this notice are preserved. This file is offered as-=
is, without any<br>
=C2=A0#=C2=A0 =C2=A0warranty.<br>
<br>
-#serial 12<br>
+#serial 2<br>
<br>
=C2=A0AC_DEFUN([AX_PROG_BISON_VERSION],[<br>
=C2=A0 =C2=A0 =C2=A0AC_REQUIRE([AC_PROG_SED])<br>
diff --git a/m4/ax_prog_flex_version.m4 b/m4/ax_prog_flex_version.m4<br>
index f1ad9ef..da60e00 100644<br>
--- a/m4/ax_prog_flex_version.m4<br>
+++ b/m4/ax_prog_flex_version.m4<br>
@@ -1,22 +1,27 @@<br>
+# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D<br>
+#=C2=A0 =C2=A0<a href=3D"http://www.gnu.org/software/autoconf-archive/ax_p=
rog_flex_version.html" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.=
org/software/autoconf-archive/ax_prog_flex_version.html</a><br>
+# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D<br>
+#<br>
=C2=A0# SYNOPSIS<br>
=C2=A0#<br>
=C2=A0#=C2=A0 =C2=A0AX_PROG_FLEX_VERSION([VERSION],[ACTION-IF-TRUE],[ACTION=
-IF-FALSE])<br>
=C2=A0#<br>
=C2=A0# DESCRIPTION<br>
=C2=A0#<br>
-#=C2=A0 =C2=A0Makes sure that flex version is greater or equal to the vers=
ion indicated.<br>
-#=C2=A0 =C2=A0If true the shell commands in ACTION-IF-TRUE are executed. I=
f not the shell<br>
-#=C2=A0 =C2=A0commands in commands in ACTION-IF-TRUE are executed. If not =
the shell<br>
-#=C2=A0 =C2=A0commands in ACTION-IF-FALSE are run. Note if $FLEX is not se=
t (for example<br>
-#=C2=A0 =C2=A0by running AC_CHECK_PROG or AC_PATH_PROG) the macro will fai=
l.<br>
+#=C2=A0 =C2=A0Makes sure that flex version is greater or equal to the vers=
ion<br>
+#=C2=A0 =C2=A0indicated. If true the shell commands in ACTION-IF-TRUE are =
executed. If<br>
+#=C2=A0 =C2=A0not the shell commands in commands in ACTION-IF-TRUE are exe=
cuted. If<br>
+#=C2=A0 =C2=A0not the shell commands in ACTION-IF-FALSE are run. Note if $=
FLEX is not<br>
+#=C2=A0 =C2=A0set (for example by running AC_CHECK_PROG or AC_PATH_PROG) t=
he macro<br>
+#=C2=A0 =C2=A0will fail.<br>
=C2=A0#<br>
=C2=A0#=C2=A0 =C2=A0Example:<br>
=C2=A0#<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0AC_PATH_PROG([FLEX],[flex])<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0AX_PROG_FLEX_VERSION([2.5.39],[ ... ],[ ... ])<b=
r>
=C2=A0#<br>
-#=C2=A0 =C2=A0This will check to make sure that the flex you have is at le=
ast<br>
-#=C2=A0 =C2=A0version 2.5.39 or greater.<br>
+#=C2=A0 =C2=A0This will check to make sure that the flex you have is at le=
ast version<br>
+#=C2=A0 =C2=A02.5.39 or greater.<br>
=C2=A0#<br>
=C2=A0#=C2=A0 =C2=A0NOTE: This macro uses the $FLEX variable to perform the=
 check.<br>
=C2=A0#<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
2.1.4<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature">J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS In=
c.<br><a href=3D"http://www.efficios.com" target=3D"_blank">http://www.effi=
cios.com</a></div>
</div>

--047d7bfe9aa4fc9bbb051a8c24a8--


--===============0377202191==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0377202191==--
