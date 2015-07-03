From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH babeltrace] Buid: add version check on flex
Date: Fri, 3 Jul 2015 17:57:20 -0400
Message-ID: <CA+jJMxtNpEAX47GTQh3Zhc+MdkCNHmj2aD8s2GpLc=esHW0mNQ__4882.07685198194$1435960702$gmane$org@mail.gmail.com>
References: <1435875625-21658-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0313222122=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1ZB8xa-0005Pd-CL
 for lttng-dev@lists.lttng.org; Fri, 03 Jul 2015 17:57:29 -0400
Received: by pdbep18 with SMTP id ep18so69212275pdb.1
 for <lttng-dev@lists.lttng.org>; Fri, 03 Jul 2015 14:57:20 -0700 (PDT)
In-Reply-To: <1435875625-21658-1-git-send-email-jonathan.rajotte-julien@efficios.com>
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

--===============0313222122==
Content-Type: multipart/alternative; boundary=047d7bd74d16e5cd730519ffa3f1

--047d7bd74d16e5cd730519ffa3f1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Merged in master and stable-1.2 with typo fix (Buid -> Build).

Thanks,
J=C3=A9r=C3=A9mie

On Thu, Jul 2, 2015 at 6:20 PM, Jonathan Rajotte <
jonathan.rajotte-julien@efficios.com> wrote:

> This new m4 macro is valid starting from [1].
>
> [1]
> http://sourceforge.net/p/flex/flex/ci/712c03b38fb35f9d7f16e0fdd27441c3efd=
a0071/tree/
>
> Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
> ---
>  configure.ac               |  4 +++
>  m4/ax_prog_flex_version.m4 | 64
> ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 68 insertions(+)
>  create mode 100644 m4/ax_prog_flex_version.m4
>
> diff --git a/configure.ac b/configure.ac
> index 3421cbd..ef2db73 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -46,6 +46,10 @@ if test ! -f
> "$srcdir/formats/ctf/metadata/ctf-lexer.c"; then
>                  AC_MSG_ERROR([[flex not found and is required when
> building from git.
>                  Please install flex]])
>          fi
> +        AC_PATH_PROG([FLEX],[flex])
> +        AX_PROG_FLEX_VERSION([2.5.35], [],[
> +                AC_MSG_ERROR([[Flex >=3D 2.5.35 is required when buildin=
g
> from git]])
> +        ])
>  fi
>
>
> diff --git a/m4/ax_prog_flex_version.m4 b/m4/ax_prog_flex_version.m4
> new file mode 100644
> index 0000000..f1ad9ef
> --- /dev/null
> +++ b/m4/ax_prog_flex_version.m4
> @@ -0,0 +1,64 @@
> +# SYNOPSIS
> +#
> +#   AX_PROG_FLEX_VERSION([VERSION],[ACTION-IF-TRUE],[ACTION-IF-FALSE])
> +#
> +# DESCRIPTION
> +#
> +#   Makes sure that flex version is greater or equal to the version
> indicated.
> +#   If true the shell commands in ACTION-IF-TRUE are executed. If not th=
e
> shell
> +#   commands in commands in ACTION-IF-TRUE are executed. If not the shel=
l
> +#   commands in ACTION-IF-FALSE are run. Note if $FLEX is not set (for
> example
> +#   by running AC_CHECK_PROG or AC_PATH_PROG) the macro will fail.
> +#
> +#   Example:
> +#
> +#     AC_PATH_PROG([FLEX],[flex])
> +#     AX_PROG_FLEX_VERSION([2.5.39],[ ... ],[ ... ])
> +#
> +#   This will check to make sure that the flex you have is at least
> +#   version 2.5.39 or greater.
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
> --
> 2.1.4
>
>


--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--047d7bd74d16e5cd730519ffa3f1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Merged in master and stable-1.2 with typo fix (Buid -&gt; =
Build).<div><br></div><div>Thanks,</div><div>J=C3=A9r=C3=A9mie</div></div><=
div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Thu, Jul 2, 201=
5 at 6:20 PM, Jonathan Rajotte <span dir=3D"ltr">&lt;<a href=3D"mailto:jona=
than.rajotte-julien@efficios.com" target=3D"_blank">jonathan.rajotte-julien=
@efficios.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">This =
new m4 macro is valid starting from [1].<br>
<br>
[1]<a href=3D"http://sourceforge.net/p/flex/flex/ci/712c03b38fb35f9d7f16e0f=
dd27441c3efda0071/tree/" rel=3D"noreferrer" target=3D"_blank">http://source=
forge.net/p/flex/flex/ci/712c03b38fb35f9d7f16e0fdd27441c3efda0071/tree/</a>=
<br>
<br>
Signed-off-by: Jonathan Rajotte &lt;<a href=3D"mailto:jonathan.rajotte-juli=
en@efficios.com">jonathan.rajotte-julien@efficios.com</a>&gt;<br>
---<br>
=C2=A0<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 4 +++<br>
=C2=A0m4/ax_prog_flex_version.m4 | 64 +++++++++++++++++++++++++++++++++++++=
+++++++++<br>
=C2=A02 files changed, 68 insertions(+)<br>
=C2=A0create mode 100644 m4/ax_prog_flex_version.m4<br>
<br>
diff --git a/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_=
blank">configure.ac</a> b/<a href=3D"http://configure.ac" rel=3D"noreferrer=
" target=3D"_blank">configure.ac</a><br>
index 3421cbd..ef2db73 100644<br>
--- a/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a><br>
+++ b/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a><br>
@@ -46,6 +46,10 @@ if test ! -f &quot;$srcdir/formats/ctf/metadata/ctf-lexe=
r.c&quot;; then<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AC_MSG_ERROR(=
[[flex not found and is required when building from git.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Please instal=
l flex]])<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 AC_PATH_PROG([FLEX],[flex])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 AX_PROG_FLEX_VERSION([2.5.35], [],[<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AC_MSG_ERROR([[Fle=
x &gt;=3D 2.5.35 is required when building from git]])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ])<br>
=C2=A0fi<br>
<br>
<br>
diff --git a/m4/ax_prog_flex_version.m4 b/m4/ax_prog_flex_version.m4<br>
new file mode 100644<br>
index 0000000..f1ad9ef<br>
--- /dev/null<br>
+++ b/m4/ax_prog_flex_version.m4<br>
@@ -0,0 +1,64 @@<br>
+# SYNOPSIS<br>
+#<br>
+#=C2=A0 =C2=A0AX_PROG_FLEX_VERSION([VERSION],[ACTION-IF-TRUE],[ACTION-IF-F=
ALSE])<br>
+#<br>
+# DESCRIPTION<br>
+#<br>
+#=C2=A0 =C2=A0Makes sure that flex version is greater or equal to the vers=
ion indicated.<br>
+#=C2=A0 =C2=A0If true the shell commands in ACTION-IF-TRUE are executed. I=
f not the shell<br>
+#=C2=A0 =C2=A0commands in commands in ACTION-IF-TRUE are executed. If not =
the shell<br>
+#=C2=A0 =C2=A0commands in ACTION-IF-FALSE are run. Note if $FLEX is not se=
t (for example<br>
+#=C2=A0 =C2=A0by running AC_CHECK_PROG or AC_PATH_PROG) the macro will fai=
l.<br>
+#<br>
+#=C2=A0 =C2=A0Example:<br>
+#<br>
+#=C2=A0 =C2=A0 =C2=A0AC_PATH_PROG([FLEX],[flex])<br>
+#=C2=A0 =C2=A0 =C2=A0AX_PROG_FLEX_VERSION([2.5.39],[ ... ],[ ... ])<br>
+#<br>
+#=C2=A0 =C2=A0This will check to make sure that the flex you have is at le=
ast<br>
+#=C2=A0 =C2=A0version 2.5.39 or greater.<br>
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
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
2.1.4<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature">J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS In=
c.<br><a href=3D"http://www.efficios.com" target=3D"_blank">http://www.effi=
cios.com</a></div>
</div>

--047d7bd74d16e5cd730519ffa3f1--


--===============0313222122==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0313222122==--
