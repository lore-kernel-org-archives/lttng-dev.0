From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools 2/2] Build: add Flex version
	check
Date: Mon, 13 Jul 2015 10:55:57 -0400
Message-ID: <CA+jJMxuFBF_-oaZBa_DKdXWTNf8Lff+Mjw2hBzTeyf_m0H3+Xg__44476.5543019914$1436799486$gmane$org@mail.gmail.com>
References: <1436562198-14747-1-git-send-email-jonathan.rajotte-julien@efficios.com>
 <1436562198-14747-2-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1405642496=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1ZEf9H-0007wm-9q
 for lttng-dev@lists.lttng.org; Mon, 13 Jul 2015 10:56:04 -0400
Received: by pdjr16 with SMTP id r16so64164368pdj.3
 for <lttng-dev@lists.lttng.org>; Mon, 13 Jul 2015 07:55:57 -0700 (PDT)
In-Reply-To: <1436562198-14747-2-git-send-email-jonathan.rajotte-julien@efficios.com>
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

--===============1405642496==
Content-Type: multipart/alternative; boundary=047d7b86e4145042ed051ac2eb75

--047d7b86e4145042ed051ac2eb75
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Merged in master, stable-2.6 and stable-2.5.

Thanks!
J=C3=A9r=C3=A9mie

On Fri, Jul 10, 2015 at 5:03 PM, Jonathan Rajotte <
jonathan.rajotte-julien@efficios.com> wrote:

> Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
> ---
>  config/ax_prog_flex_version.m4 | 69
> ++++++++++++++++++++++++++++++++++++++++++
>  configure.ac                   |  4 +++
>  2 files changed, 73 insertions(+)
>  create mode 100644 config/ax_prog_flex_version.m4
>
> diff --git a/config/ax_prog_flex_version.m4
> b/config/ax_prog_flex_version.m4
> new file mode 100644
> index 0000000..da60e00
> --- /dev/null
> +++ b/config/ax_prog_flex_version.m4
> @@ -0,0 +1,69 @@
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
> +# SYNOPSIS
> +#
> +#   AX_PROG_FLEX_VERSION([VERSION],[ACTION-IF-TRUE],[ACTION-IF-FALSE])
> +#
> +# DESCRIPTION
> +#
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
> +#
> +#   Example:
> +#
> +#     AC_PATH_PROG([FLEX],[flex])
> +#     AX_PROG_FLEX_VERSION([2.5.39],[ ... ],[ ... ])
> +#
> +#   This will check to make sure that the flex you have is at least
> version
> +#   2.5.39 or greater.
> +#
> +#   NOTE: This macro uses the $FLEX variable to perform the check.
> +#
> +# LICENSE
> +#
> +#   Copyright (c) 2015 Jonathan Rajotte-Julien <
> jonathan.rajotte-julien@efficios.com>
> +#
> +#   Copying and distribution of this file, with or without modification,
> are
> +#   permitted in any medium without royalty provided the copyright notic=
e
> +#   and this notice are preserved. This file is offered as-is, without a=
ny
> +#   warranty.
> +
> +#serial 1
> +
> +AC_DEFUN([AX_PROG_FLEX_VERSION],[
> +    AC_REQUIRE([AC_PROG_SED])
> +    AC_REQUIRE([AC_PROG_GREP])
> +
> +    AS_IF([test -n "$FLEX"],[
> +        ax_flex_version=3D"$1"
> +
> +        AC_MSG_CHECKING([for flex version])
> +        changequote(<<,>>)
> +        flex_version=3D`$FLEX --version 2>&1 \
> +          | $SED -n -e '/flex /b inspect
> +b
> +: inspect
> +s/.* (\{0,1\}\([0-9]*\.[0-9]*\.[0-9]*\))\{0,1\}.*/\1/;p'`
> +        changequote([,])
> +        AC_MSG_RESULT($flex_version)
> +
> +       AC_SUBST([FLEX_VERSION],[$flex_version])
> +
> +        AX_COMPARE_VERSION([$flex_version],[ge],[$ax_flex_version],[
> +           :
> +            $2
> +        ],[
> +           :
> +            $3
> +        ])
> +    ],[
> +        AC_MSG_WARN([could not find flex])
> +        $3
> +    ])
> +])
> diff --git a/configure.ac b/configure.ac
> index b274ead..b7af59a 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -455,6 +455,10 @@ if test ! -f
> "$srcdir/src/lib/lttng-ctl/filter/filter-lexer.c"; then
>                 AC_MSG_ERROR([[flex not found and is required when
> building from git.
>                 Please install flex]])
>         fi
> +       AC_PATH_PROG([FLEX],[flex])
> +       AX_PROG_FLEX_VERSION([2.5.35], [],[
> +               AC_MSG_ERROR([[Flex >=3D 2.5.35 is required when building
> from git]])
> +       ])
>  fi
>
>  CFLAGS=3D"-Wall $CFLAGS -g -fno-strict-aliasing"
> --
> 2.1.4
>
>


--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--047d7b86e4145042ed051ac2eb75
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Merged in master, stable-2.6 and stable-2.5.</div><di=
v><br></div><div>Thanks!</div><div>J=C3=A9r=C3=A9mie</div></div><div class=
=3D"gmail_extra"><br><div class=3D"gmail_quote">On Fri, Jul 10, 2015 at 5:0=
3 PM, Jonathan Rajotte <span dir=3D"ltr">&lt;<a href=3D"mailto:jonathan.raj=
otte-julien@efficios.com" target=3D"_blank">jonathan.rajotte-julien@efficio=
s.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Signed-off-by=
: Jonathan Rajotte &lt;<a href=3D"mailto:jonathan.rajotte-julien@efficios.c=
om">jonathan.rajotte-julien@efficios.com</a>&gt;<br>
---<br>
=C2=A0config/ax_prog_flex_version.m4 | 69 +++++++++++++++++++++++++++++++++=
+++++++++<br>
=C2=A0<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 4 +++<br>
=C2=A02 files changed, 73 insertions(+)<br>
=C2=A0create mode 100644 config/ax_prog_flex_version.m4<br>
<br>
diff --git a/config/ax_prog_flex_version.m4 b/config/ax_prog_flex_version.m=
4<br>
new file mode 100644<br>
index 0000000..da60e00<br>
--- /dev/null<br>
+++ b/config/ax_prog_flex_version.m4<br>
@@ -0,0 +1,69 @@<br>
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
+# SYNOPSIS<br>
+#<br>
+#=C2=A0 =C2=A0AX_PROG_FLEX_VERSION([VERSION],[ACTION-IF-TRUE],[ACTION-IF-F=
ALSE])<br>
+#<br>
+# DESCRIPTION<br>
+#<br>
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
+#<br>
+#=C2=A0 =C2=A0Example:<br>
+#<br>
+#=C2=A0 =C2=A0 =C2=A0AC_PATH_PROG([FLEX],[flex])<br>
+#=C2=A0 =C2=A0 =C2=A0AX_PROG_FLEX_VERSION([2.5.39],[ ... ],[ ... ])<br>
+#<br>
+#=C2=A0 =C2=A0This will check to make sure that the flex you have is at le=
ast version<br>
+#=C2=A0 =C2=A02.5.39 or greater.<br>
+#<br>
+#=C2=A0 =C2=A0NOTE: This macro uses the $FLEX variable to perform the chec=
k.<br>
+#<br>
+# LICENSE<br>
+#<br>
+#=C2=A0 =C2=A0Copyright (c) 2015 Jonathan Rajotte-Julien &lt;<a href=3D"ma=
ilto:jonathan.rajotte-julien@efficios.com">jonathan.rajotte-julien@efficios=
.com</a>&gt;<br>
+#<br>
+#=C2=A0 =C2=A0Copying and distribution of this file, with or without modif=
ication, are<br>
+#=C2=A0 =C2=A0permitted in any medium without royalty provided the copyrig=
ht notice<br>
+#=C2=A0 =C2=A0and this notice are preserved. This file is offered as-is, w=
ithout any<br>
+#=C2=A0 =C2=A0warranty.<br>
+<br>
+#serial 1<br>
+<br>
+AC_DEFUN([AX_PROG_FLEX_VERSION],[<br>
+=C2=A0 =C2=A0 AC_REQUIRE([AC_PROG_SED])<br>
+=C2=A0 =C2=A0 AC_REQUIRE([AC_PROG_GREP])<br>
+<br>
+=C2=A0 =C2=A0 AS_IF([test -n &quot;$FLEX&quot;],[<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ax_flex_version=3D&quot;$1&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 AC_MSG_CHECKING([for flex version])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 changequote(&lt;&lt;,&gt;&gt;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 flex_version=3D`$FLEX --version 2&gt;&amp;1 \<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | $SED -n -e &#39;/flex /b inspect<br>
+b<br>
+: inspect<br>
+s/.* (\{0,1\}\([0-9]*\.[0-9]*\.[0-9]*\))\{0,1\}.*/\1/;p&#39;`<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 changequote([,])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 AC_MSG_RESULT($flex_version)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0AC_SUBST([FLEX_VERSION],[$flex_version])<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 AX_COMPARE_VERSION([$flex_version],[ge],[$ax_f=
lex_version],[<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $2<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ],[<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $3<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ])<br>
+=C2=A0 =C2=A0 ],[<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 AC_MSG_WARN([could not find flex])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 $3<br>
+=C2=A0 =C2=A0 ])<br>
+])<br>
diff --git a/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_=
blank">configure.ac</a> b/<a href=3D"http://configure.ac" rel=3D"noreferrer=
" target=3D"_blank">configure.ac</a><br>
index b274ead..b7af59a 100644<br>
--- a/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a><br>
+++ b/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a><br>
@@ -455,6 +455,10 @@ if test ! -f &quot;$srcdir/src/lib/lttng-ctl/filter/fi=
lter-lexer.c&quot;; then<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AC_MSG_ERROR([[flex=
 not found and is required when building from git.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Please install flex=
]])<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0AC_PATH_PROG([FLEX],[flex])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0AX_PROG_FLEX_VERSION([2.5.35], [],[<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AC_MSG_ERROR([[Flex=
 &gt;=3D 2.5.35 is required when building from git]])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0])<br>
=C2=A0fi<br>
<br>
=C2=A0CFLAGS=3D&quot;-Wall $CFLAGS -g -fno-strict-aliasing&quot;<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
2.1.4<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature">J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS In=
c.<br><a href=3D"http://www.efficios.com" target=3D"_blank">http://www.effi=
cios.com</a></div>
</div>

--047d7b86e4145042ed051ac2eb75--


--===============1405642496==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1405642496==--
