From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH babeltrace] Build: m4 macro for Bison
	version check
Date: Thu, 2 Jul 2015 18:17:53 -0400
Message-ID: <CA+jJMxtOzsC=FnPZ5_fL_3HcZ25-vFSsWDY-Cs7s6jvuk0zs9g__15532.5342355811$1435875546$gmane$org@mail.gmail.com>
References: <1435864351-30236-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0741334274=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1ZAmnv-0006Xj-R1
 for lttng-dev@lists.lttng.org; Thu, 02 Jul 2015 18:18:11 -0400
Received: by pdjd13 with SMTP id d13so51971315pdj.0
 for <lttng-dev@lists.lttng.org>; Thu, 02 Jul 2015 15:17:54 -0700 (PDT)
In-Reply-To: <1435864351-30236-1-git-send-email-jonathan.rajotte-julien@efficios.com>
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

--===============0741334274==
Content-Type: multipart/alternative; boundary=047d7b5d848d929aa60519ebcf1d

--047d7b5d848d929aa60519ebcf1d
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Merged in master and stable-1.2, thanks!

J=C3=A9r=C3=A9mie

On Thu, Jul 2, 2015 at 3:12 PM, Jonathan Rajotte <
jonathan.rajotte-julien@efficios.com> wrote:

> This new m4 macro make check for a supported version of Bison.
> This macro is valid starting from commit id
> e79137accc7ea0352cd4677ff22818f9c68d4eab of the GNU Bison git tree[1].
> This check works for version 1.29b to this day.
>
> [1]
> http://git.savannah.gnu.org/cgit/bison.git/commit/?id=3De79137accc7ea0352=
cd4677ff22818f9c68d4eab
>
> Fixes: #891
> Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
> ---
>  configure.ac                |   4 +
>  m4/ax_compare_version.m4    | 177
> ++++++++++++++++++++++++++++++++++++++++++++
>  m4/ax_prog_bison_version.m4 |  64 ++++++++++++++++
>  3 files changed, 245 insertions(+)
>  create mode 100644 m4/ax_compare_version.m4
>  create mode 100644 m4/ax_prog_bison_version.m4
>
> diff --git a/configure.ac b/configure.ac
> index f8d43d8..3421cbd 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -35,6 +35,10 @@ if test ! -f
> "$srcdir/formats/ctf/metadata/ctf-parser.h"; then
>                  AC_MSG_ERROR([[bison not found and is required when
> building from git.
>                  Please install bison]])
>          fi
> +        AC_PATH_PROG([BISON],[bison])
> +        AX_PROG_BISON_VERSION([2.4], [],[
> +                AC_MSG_ERROR([[Bison >=3D 2.4 is required when building
> from git]])
> +        ])
>  fi
>
>  if test ! -f "$srcdir/formats/ctf/metadata/ctf-lexer.c"; then
> diff --git a/m4/ax_compare_version.m4 b/m4/ax_compare_version.m4
> new file mode 100644
> index 0000000..74dc0fd
> --- /dev/null
> +++ b/m4/ax_compare_version.m4
> @@ -0,0 +1,177 @@
> +#
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +#    http://www.gnu.org/software/autoconf-archive/ax_compare_version.htm=
l
> +#
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +#
> +# SYNOPSIS
> +#
> +#   AX_COMPARE_VERSION(VERSION_A, OP, VERSION_B, [ACTION-IF-TRUE],
> [ACTION-IF-FALSE])
> +#
> +# DESCRIPTION
> +#
> +#   This macro compares two version strings. Due to the various number o=
f
> +#   minor-version numbers that can exist, and the fact that string
> +#   comparisons are not compatible with numeric comparisons, this is not
> +#   necessarily trivial to do in a autoconf script. This macro makes doi=
ng
> +#   these comparisons easy.
> +#
> +#   The six basic comparisons are available, as well as checking equalit=
y
> +#   limited to a certain number of minor-version levels.
> +#
> +#   The operator OP determines what type of comparison to do, and can be
> one
> +#   of:
> +#
> +#    eq  - equal (test A =3D=3D B)
> +#    ne  - not equal (test A !=3D B)
> +#    le  - less than or equal (test A <=3D B)
> +#    ge  - greater than or equal (test A >=3D B)
> +#    lt  - less than (test A < B)
> +#    gt  - greater than (test A > B)
> +#
> +#   Additionally, the eq and ne operator can have a number after it to
> limit
> +#   the test to that number of minor versions.
> +#
> +#    eq0 - equal up to the length of the shorter version
> +#    ne0 - not equal up to the length of the shorter version
> +#    eqN - equal up to N sub-version levels
> +#    neN - not equal up to N sub-version levels
> +#
> +#   When the condition is true, shell commands ACTION-IF-TRUE are run,
> +#   otherwise shell commands ACTION-IF-FALSE are run. The environment
> +#   variable 'ax_compare_version' is always set to either 'true' or
> 'false'
> +#   as well.
> +#
> +#   Examples:
> +#
> +#     AX_COMPARE_VERSION([3.15.7],[lt],[3.15.8])
> +#     AX_COMPARE_VERSION([3.15],[lt],[3.15.8])
> +#
> +#   would both be true.
> +#
> +#     AX_COMPARE_VERSION([3.15.7],[eq],[3.15.8])
> +#     AX_COMPARE_VERSION([3.15],[gt],[3.15.8])
> +#
> +#   would both be false.
> +#
> +#     AX_COMPARE_VERSION([3.15.7],[eq2],[3.15.8])
> +#
> +#   would be true because it is only comparing two minor versions.
> +#
> +#     AX_COMPARE_VERSION([3.15.7],[eq0],[3.15])
> +#
> +#   would be true because it is only comparing the lesser number of mino=
r
> +#   versions of the two values.
> +#
> +#   Note: The characters that separate the version numbers do not matter=
.
> An
> +#   empty string is the same as version 0. OP is evaluated by autoconf,
> not
> +#   configure, so must be a string, not a variable.
> +#
> +#   The author would like to acknowledge Guido Draheim whose advice abou=
t
> +#   the m4_case and m4_ifvaln functions make this macro only include the
> +#   portions necessary to perform the specific comparison specified by t=
he
> +#   OP argument in the final configure script.
> +#
> +# LICENSE
> +#
> +#   Copyright (c) 2008 Tim Toolan <toolan@ele.uri.edu>
> +#
> +#   Copying and distribution of this file, with or without modification,
> are
> +#   permitted in any medium without royalty provided the copyright notic=
e
> +#   and this notice are preserved. This file is offered as-is, without a=
ny
> +#   warranty.
> +
> +#serial 11
> +
> +dnl
> #########################################################################
> +AC_DEFUN([AX_COMPARE_VERSION], [
> +  AC_REQUIRE([AC_PROG_AWK])
> +
> +  # Used to indicate true or false condition
> +  ax_compare_version=3Dfalse
> +
> +  # Convert the two version strings to be compared into a format that
> +  # allows a simple string comparison.  The end result is that a version
> +  # string of the form 1.12.5-r617 will be converted to the form
> +  # 0001001200050617.  In other words, each number is zero padded to fou=
r
> +  # digits, and non digits are removed.
> +  AS_VAR_PUSHDEF([A],[ax_compare_version_A])
> +  A=3D`echo "$1" | sed -e 's/\([[0-9]]*\)/Z\1Z/g' \
> +                     -e 's/Z\([[0-9]]\)Z/Z0\1Z/g' \
> +                     -e 's/Z\([[0-9]][[0-9]]\)Z/Z0\1Z/g' \
> +                     -e 's/Z\([[0-9]][[0-9]][[0-9]]\)Z/Z0\1Z/g' \
> +                     -e 's/[[^0-9]]//g'`
> +
> +  AS_VAR_PUSHDEF([B],[ax_compare_version_B])
> +  B=3D`echo "$3" | sed -e 's/\([[0-9]]*\)/Z\1Z/g' \
> +                     -e 's/Z\([[0-9]]\)Z/Z0\1Z/g' \
> +                     -e 's/Z\([[0-9]][[0-9]]\)Z/Z0\1Z/g' \
> +                     -e 's/Z\([[0-9]][[0-9]][[0-9]]\)Z/Z0\1Z/g' \
> +                     -e 's/[[^0-9]]//g'`
> +
> +  dnl # In the case of le, ge, lt, and gt, the strings are sorted as
> necessary
> +  dnl # then the first line is used to determine if the condition is tru=
e.
> +  dnl # The sed right after the echo is to remove any indented white
> space.
> +  m4_case(m4_tolower($2),
> +  [lt],[
> +    ax_compare_version=3D`echo "x$A
> +x$B" | sed 's/^ *//' | sort -r | sed "s/x${A}/false/;s/x${B}/true/;1q"`
> +  ],
> +  [gt],[
> +    ax_compare_version=3D`echo "x$A
> +x$B" | sed 's/^ *//' | sort | sed "s/x${A}/false/;s/x${B}/true/;1q"`
> +  ],
> +  [le],[
> +    ax_compare_version=3D`echo "x$A
> +x$B" | sed 's/^ *//' | sort | sed "s/x${A}/true/;s/x${B}/false/;1q"`
> +  ],
> +  [ge],[
> +    ax_compare_version=3D`echo "x$A
> +x$B" | sed 's/^ *//' | sort -r | sed "s/x${A}/true/;s/x${B}/false/;1q"`
> +  ],[
> +    dnl Split the operator from the subversion count if present.
> +    m4_bmatch(m4_substr($2,2),
> +    [0],[
> +      # A count of zero means use the length of the shorter version.
> +      # Determine the number of characters in A and B.
> +      ax_compare_version_len_A=3D`echo "$A" | $AWK '{print(length)}'`
> +      ax_compare_version_len_B=3D`echo "$B" | $AWK '{print(length)}'`
> +
> +      # Set A to no more than B's length and B to no more than A's lengt=
h.
> +      A=3D`echo "$A" | sed "s/\(.\{$ax_compare_version_len_B\}\).*/\1/"`
> +      B=3D`echo "$B" | sed "s/\(.\{$ax_compare_version_len_A\}\).*/\1/"`
> +    ],
> +    [[0-9]+],[
> +      # A count greater than zero means use only that many subversions
> +      A=3D`echo "$A" | sed
> "s/\(\([[0-9]]\{4\}\)\{m4_substr($2,2)\}\).*/\1/"`
> +      B=3D`echo "$B" | sed
> "s/\(\([[0-9]]\{4\}\)\{m4_substr($2,2)\}\).*/\1/"`
> +    ],
> +    [.+],[
> +      AC_WARNING(
> +        [illegal OP numeric parameter: $2])
> +    ],[])
> +
> +    # Pad zeros at end of numbers to make same length.
> +    ax_compare_version_tmp_A=3D"$A`echo $B | sed 's/./0/g'`"
> +    B=3D"$B`echo $A | sed 's/./0/g'`"
> +    A=3D"$ax_compare_version_tmp_A"
> +
> +    # Check for equality or inequality as necessary.
> +    m4_case(m4_tolower(m4_substr($2,0,2)),
> +    [eq],[
> +      test "x$A" =3D "x$B" && ax_compare_version=3Dtrue
> +    ],
> +    [ne],[
> +      test "x$A" !=3D "x$B" && ax_compare_version=3Dtrue
> +    ],[
> +      AC_WARNING([illegal OP parameter: $2])
> +    ])
> +  ])
> +
> +  AS_VAR_POPDEF([A])dnl
> +  AS_VAR_POPDEF([B])dnl
> +
> +  dnl # Execute ACTION-IF-TRUE / ACTION-IF-FALSE.
> +  if test "$ax_compare_version" =3D "true" ; then
> +    m4_ifvaln([$4],[$4],[:])dnl
> +    m4_ifvaln([$5],[else $5])dnl
> +  fi
> +]) dnl AX_COMPARE_VERSION
> diff --git a/m4/ax_prog_bison_version.m4 b/m4/ax_prog_bison_version.m4
> new file mode 100644
> index 0000000..6b95585
> --- /dev/null
> +++ b/m4/ax_prog_bison_version.m4
> @@ -0,0 +1,64 @@
> +# SYNOPSIS
> +#
> +#   AX_PROG_BISON_VERSION([VERSION],[ACTION-IF-TRUE],[ACTION-IF-FALSE])
> +#
> +# DESCRIPTION
> +#
> +#   Makes sure that bison version is greater or equal to the version
> indicated.
> +#   If true the shell commands in ACTION-IF-TRUE are executed. If not th=
e
> shell
> +#   commands in commands in ACTION-IF-TRUE are executed. If not the shel=
l
> +#   commands in ACTION-IF-FALSE are run. Note if $BISON is not set (for
> example
> +#   by running AC_CHECK_PROG or AC_PATH_PROG) the macro will fail.
> +#
> +#   Example:
> +#
> +#     AC_PATH_PROG([BISON],[bison])
> +#     AX_PROG_BISON_VERSION([3.0.2],[ ... ],[ ... ])
> +#
> +#   This will check to make sure that the bison you have is at least
> +#   version 3.0.2 or greater.
> +#
> +#   NOTE: This macro uses the $BISON variable to perform the check.
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
> +#serial 12
> +
> +AC_DEFUN([AX_PROG_BISON_VERSION],[
> +    AC_REQUIRE([AC_PROG_SED])
> +    AC_REQUIRE([AC_PROG_GREP])
> +
> +    AS_IF([test -n "$BISON"],[
> +        ax_bison_version=3D"$1"
> +
> +        AC_MSG_CHECKING([for bison version])
> +        changequote(<<,>>)
> +        bison_version=3D`$BISON --version 2>&1 \
> +          | $SED -n -e '/bison (GNU Bison)/b inspect
> +b
> +: inspect
> +s/.* (\{0,1\}\([0-9]*\.[0-9]*\.[0-9]*\))\{0,1\}.*/\1/;p'`
> +        changequote([,])
> +        AC_MSG_RESULT($bison_version)
> +
> +       AC_SUBST([BISON_VERSION],[$bison_version])
> +
> +        AX_COMPARE_VERSION([$bison_version],[ge],[$ax_bison_version],[
> +           :
> +            $2
> +        ],[
> +           :
> +            $3
> +        ])
> +    ],[
> +        AC_MSG_WARN([could not find bison])
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

--047d7b5d848d929aa60519ebcf1d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Merged in master and stable-1.2, thanks!<div><br></div><di=
v>J=C3=A9r=C3=A9mie</div></div><div class=3D"gmail_extra"><br><div class=3D=
"gmail_quote">On Thu, Jul 2, 2015 at 3:12 PM, Jonathan Rajotte <span dir=3D=
"ltr">&lt;<a href=3D"mailto:jonathan.rajotte-julien@efficios.com" target=3D=
"_blank">jonathan.rajotte-julien@efficios.com</a>&gt;</span> wrote:<br><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex">This new m4 macro make check for a supported ver=
sion of Bison.<br>
This macro is valid starting from commit id<br>
e79137accc7ea0352cd4677ff22818f9c68d4eab of the GNU Bison git tree[1].<br>
This check works for version 1.29b to this day.<br>
<br>
[1] <a href=3D"http://git.savannah.gnu.org/cgit/bison.git/commit/?id=3De791=
37accc7ea0352cd4677ff22818f9c68d4eab" rel=3D"noreferrer" target=3D"_blank">=
http://git.savannah.gnu.org/cgit/bison.git/commit/?id=3De79137accc7ea0352cd=
4677ff22818f9c68d4eab</a><br>
<br>
Fixes: #891<br>
Signed-off-by: Jonathan Rajotte &lt;<a href=3D"mailto:jonathan.rajotte-juli=
en@efficios.com">jonathan.rajotte-julien@efficios.com</a>&gt;<br>
---<br>
=C2=A0<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A04 +<br>
=C2=A0m4/ax_compare_version.m4=C2=A0 =C2=A0 | 177 +++++++++++++++++++++++++=
+++++++++++++++++++<br>
=C2=A0m4/ax_prog_bison_version.m4 |=C2=A0 64 ++++++++++++++++<br>
=C2=A03 files changed, 245 insertions(+)<br>
=C2=A0create mode 100644 m4/ax_compare_version.m4<br>
=C2=A0create mode 100644 m4/ax_prog_bison_version.m4<br>
<br>
diff --git a/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_=
blank">configure.ac</a> b/<a href=3D"http://configure.ac" rel=3D"noreferrer=
" target=3D"_blank">configure.ac</a><br>
index f8d43d8..3421cbd 100644<br>
--- a/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a><br>
+++ b/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a><br>
@@ -35,6 +35,10 @@ if test ! -f &quot;$srcdir/formats/ctf/metadata/ctf-pars=
er.h&quot;; then<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AC_MSG_ERROR(=
[[bison not found and is required when building from git.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Please instal=
l bison]])<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 AC_PATH_PROG([BISON],[bison])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 AX_PROG_BISON_VERSION([2.4], [],[<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AC_MSG_ERROR([[Bis=
on &gt;=3D 2.4 is required when building from git]])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ])<br>
=C2=A0fi<br>
<br>
=C2=A0if test ! -f &quot;$srcdir/formats/ctf/metadata/ctf-lexer.c&quot;; th=
en<br>
diff --git a/m4/ax_compare_version.m4 b/m4/ax_compare_version.m4<br>
new file mode 100644<br>
index 0000000..74dc0fd<br>
--- /dev/null<br>
+++ b/m4/ax_compare_version.m4<br>
@@ -0,0 +1,177 @@<br>
+# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D<br>
+#=C2=A0 =C2=A0 <a href=3D"http://www.gnu.org/software/autoconf-archive/ax_=
compare_version.html" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/software/autoconf-archive/ax_compare_version.html</a><br>
+# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D<br>
+#<br>
+# SYNOPSIS<br>
+#<br>
+#=C2=A0 =C2=A0AX_COMPARE_VERSION(VERSION_A, OP, VERSION_B, [ACTION-IF-TRUE=
], [ACTION-IF-FALSE])<br>
+#<br>
+# DESCRIPTION<br>
+#<br>
+#=C2=A0 =C2=A0This macro compares two version strings. Due to the various =
number of<br>
+#=C2=A0 =C2=A0minor-version numbers that can exist, and the fact that stri=
ng<br>
+#=C2=A0 =C2=A0comparisons are not compatible with numeric comparisons, thi=
s is not<br>
+#=C2=A0 =C2=A0necessarily trivial to do in a autoconf script. This macro m=
akes doing<br>
+#=C2=A0 =C2=A0these comparisons easy.<br>
+#<br>
+#=C2=A0 =C2=A0The six basic comparisons are available, as well as checking=
 equality<br>
+#=C2=A0 =C2=A0limited to a certain number of minor-version levels.<br>
+#<br>
+#=C2=A0 =C2=A0The operator OP determines what type of comparison to do, an=
d can be one<br>
+#=C2=A0 =C2=A0of:<br>
+#<br>
+#=C2=A0 =C2=A0 eq=C2=A0 - equal (test A =3D=3D B)<br>
+#=C2=A0 =C2=A0 ne=C2=A0 - not equal (test A !=3D B)<br>
+#=C2=A0 =C2=A0 le=C2=A0 - less than or equal (test A &lt;=3D B)<br>
+#=C2=A0 =C2=A0 ge=C2=A0 - greater than or equal (test A &gt;=3D B)<br>
+#=C2=A0 =C2=A0 lt=C2=A0 - less than (test A &lt; B)<br>
+#=C2=A0 =C2=A0 gt=C2=A0 - greater than (test A &gt; B)<br>
+#<br>
+#=C2=A0 =C2=A0Additionally, the eq and ne operator can have a number after=
 it to limit<br>
+#=C2=A0 =C2=A0the test to that number of minor versions.<br>
+#<br>
+#=C2=A0 =C2=A0 eq0 - equal up to the length of the shorter version<br>
+#=C2=A0 =C2=A0 ne0 - not equal up to the length of the shorter version<br>
+#=C2=A0 =C2=A0 eqN - equal up to N sub-version levels<br>
+#=C2=A0 =C2=A0 neN - not equal up to N sub-version levels<br>
+#<br>
+#=C2=A0 =C2=A0When the condition is true, shell commands ACTION-IF-TRUE ar=
e run,<br>
+#=C2=A0 =C2=A0otherwise shell commands ACTION-IF-FALSE are run. The enviro=
nment<br>
+#=C2=A0 =C2=A0variable &#39;ax_compare_version&#39; is always set to eithe=
r &#39;true&#39; or &#39;false&#39;<br>
+#=C2=A0 =C2=A0as well.<br>
+#<br>
+#=C2=A0 =C2=A0Examples:<br>
+#<br>
+#=C2=A0 =C2=A0 =C2=A0AX_COMPARE_VERSION([3.15.7],[lt],[3.15.8])<br>
+#=C2=A0 =C2=A0 =C2=A0AX_COMPARE_VERSION([3.15],[lt],[3.15.8])<br>
+#<br>
+#=C2=A0 =C2=A0would both be true.<br>
+#<br>
+#=C2=A0 =C2=A0 =C2=A0AX_COMPARE_VERSION([3.15.7],[eq],[3.15.8])<br>
+#=C2=A0 =C2=A0 =C2=A0AX_COMPARE_VERSION([3.15],[gt],[3.15.8])<br>
+#<br>
+#=C2=A0 =C2=A0would both be false.<br>
+#<br>
+#=C2=A0 =C2=A0 =C2=A0AX_COMPARE_VERSION([3.15.7],[eq2],[3.15.8])<br>
+#<br>
+#=C2=A0 =C2=A0would be true because it is only comparing two minor version=
s.<br>
+#<br>
+#=C2=A0 =C2=A0 =C2=A0AX_COMPARE_VERSION([3.15.7],[eq0],[3.15])<br>
+#<br>
+#=C2=A0 =C2=A0would be true because it is only comparing the lesser number=
 of minor<br>
+#=C2=A0 =C2=A0versions of the two values.<br>
+#<br>
+#=C2=A0 =C2=A0Note: The characters that separate the version numbers do no=
t matter. An<br>
+#=C2=A0 =C2=A0empty string is the same as version 0. OP is evaluated by au=
toconf, not<br>
+#=C2=A0 =C2=A0configure, so must be a string, not a variable.<br>
+#<br>
+#=C2=A0 =C2=A0The author would like to acknowledge Guido Draheim whose adv=
ice about<br>
+#=C2=A0 =C2=A0the m4_case and m4_ifvaln functions make this macro only inc=
lude the<br>
+#=C2=A0 =C2=A0portions necessary to perform the specific comparison specif=
ied by the<br>
+#=C2=A0 =C2=A0OP argument in the final configure script.<br>
+#<br>
+# LICENSE<br>
+#<br>
+#=C2=A0 =C2=A0Copyright (c) 2008 Tim Toolan &lt;<a href=3D"mailto:toolan@e=
le.uri.edu">toolan@ele.uri.edu</a>&gt;<br>
+#<br>
+#=C2=A0 =C2=A0Copying and distribution of this file, with or without modif=
ication, are<br>
+#=C2=A0 =C2=A0permitted in any medium without royalty provided the copyrig=
ht notice<br>
+#=C2=A0 =C2=A0and this notice are preserved. This file is offered as-is, w=
ithout any<br>
+#=C2=A0 =C2=A0warranty.<br>
+<br>
+#serial 11<br>
+<br>
+dnl ######################################################################=
###<br>
+AC_DEFUN([AX_COMPARE_VERSION], [<br>
+=C2=A0 AC_REQUIRE([AC_PROG_AWK])<br>
+<br>
+=C2=A0 # Used to indicate true or false condition<br>
+=C2=A0 ax_compare_version=3Dfalse<br>
+<br>
+=C2=A0 # Convert the two version strings to be compared into a format that=
<br>
+=C2=A0 # allows a simple string comparison.=C2=A0 The end result is that a=
 version<br>
+=C2=A0 # string of the form 1.12.5-r617 will be converted to the form<br>
+=C2=A0 # 0001001200050617.=C2=A0 In other words, each number is zero padde=
d to four<br>
+=C2=A0 # digits, and non digits are removed.<br>
+=C2=A0 AS_VAR_PUSHDEF([A],[ax_compare_version_A])<br>
+=C2=A0 A=3D`echo &quot;$1&quot; | sed -e &#39;s/\([[0-9]]*\)/Z\1Z/g&#39; \=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0-e &#39;s/Z\([[0-9]]\)Z/Z0\1Z/g&#39; \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0-e &#39;s/Z\([[0-9]][[0-9]]\)Z/Z0\1Z/g&#39; \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0-e &#39;s/Z\([[0-9]][[0-9]][[0-9]]\)Z/Z0\1Z/g&#39; \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0-e &#39;s/[[^0-9]]//g&#39;`<br>
+<br>
+=C2=A0 AS_VAR_PUSHDEF([B],[ax_compare_version_B])<br>
+=C2=A0 B=3D`echo &quot;$3&quot; | sed -e &#39;s/\([[0-9]]*\)/Z\1Z/g&#39; \=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0-e &#39;s/Z\([[0-9]]\)Z/Z0\1Z/g&#39; \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0-e &#39;s/Z\([[0-9]][[0-9]]\)Z/Z0\1Z/g&#39; \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0-e &#39;s/Z\([[0-9]][[0-9]][[0-9]]\)Z/Z0\1Z/g&#39; \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0-e &#39;s/[[^0-9]]//g&#39;`<br>
+<br>
+=C2=A0 dnl # In the case of le, ge, lt, and gt, the strings are sorted as =
necessary<br>
+=C2=A0 dnl # then the first line is used to determine if the condition is =
true.<br>
+=C2=A0 dnl # The sed right after the echo is to remove any indented white =
space.<br>
+=C2=A0 m4_case(m4_tolower($2),<br>
+=C2=A0 [lt],[<br>
+=C2=A0 =C2=A0 ax_compare_version=3D`echo &quot;x$A<br>
+x$B&quot; | sed &#39;s/^ *//&#39; | sort -r | sed &quot;s/x${A}/false/;s/x=
${B}/true/;1q&quot;`<br>
+=C2=A0 ],<br>
+=C2=A0 [gt],[<br>
+=C2=A0 =C2=A0 ax_compare_version=3D`echo &quot;x$A<br>
+x$B&quot; | sed &#39;s/^ *//&#39; | sort | sed &quot;s/x${A}/false/;s/x${B=
}/true/;1q&quot;`<br>
+=C2=A0 ],<br>
+=C2=A0 [le],[<br>
+=C2=A0 =C2=A0 ax_compare_version=3D`echo &quot;x$A<br>
+x$B&quot; | sed &#39;s/^ *//&#39; | sort | sed &quot;s/x${A}/true/;s/x${B}=
/false/;1q&quot;`<br>
+=C2=A0 ],<br>
+=C2=A0 [ge],[<br>
+=C2=A0 =C2=A0 ax_compare_version=3D`echo &quot;x$A<br>
+x$B&quot; | sed &#39;s/^ *//&#39; | sort -r | sed &quot;s/x${A}/true/;s/x$=
{B}/false/;1q&quot;`<br>
+=C2=A0 ],[<br>
+=C2=A0 =C2=A0 dnl Split the operator from the subversion count if present.=
<br>
+=C2=A0 =C2=A0 m4_bmatch(m4_substr($2,2),<br>
+=C2=A0 =C2=A0 [0],[<br>
+=C2=A0 =C2=A0 =C2=A0 # A count of zero means use the length of the shorter=
 version.<br>
+=C2=A0 =C2=A0 =C2=A0 # Determine the number of characters in A and B.<br>
+=C2=A0 =C2=A0 =C2=A0 ax_compare_version_len_A=3D`echo &quot;$A&quot; | $AW=
K &#39;{print(length)}&#39;`<br>
+=C2=A0 =C2=A0 =C2=A0 ax_compare_version_len_B=3D`echo &quot;$B&quot; | $AW=
K &#39;{print(length)}&#39;`<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 # Set A to no more than B&#39;s length and B to no mo=
re than A&#39;s length.<br>
+=C2=A0 =C2=A0 =C2=A0 A=3D`echo &quot;$A&quot; | sed &quot;s/\(.\{$ax_compa=
re_version_len_B\}\).*/\1/&quot;`<br>
+=C2=A0 =C2=A0 =C2=A0 B=3D`echo &quot;$B&quot; | sed &quot;s/\(.\{$ax_compa=
re_version_len_A\}\).*/\1/&quot;`<br>
+=C2=A0 =C2=A0 ],<br>
+=C2=A0 =C2=A0 [[0-9]+],[<br>
+=C2=A0 =C2=A0 =C2=A0 # A count greater than zero means use only that many =
subversions<br>
+=C2=A0 =C2=A0 =C2=A0 A=3D`echo &quot;$A&quot; | sed &quot;s/\(\([[0-9]]\{4=
\}\)\{m4_substr($2,2)\}\).*/\1/&quot;`<br>
+=C2=A0 =C2=A0 =C2=A0 B=3D`echo &quot;$B&quot; | sed &quot;s/\(\([[0-9]]\{4=
\}\)\{m4_substr($2,2)\}\).*/\1/&quot;`<br>
+=C2=A0 =C2=A0 ],<br>
+=C2=A0 =C2=A0 [.+],[<br>
+=C2=A0 =C2=A0 =C2=A0 AC_WARNING(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 [illegal OP numeric parameter: $2])<br>
+=C2=A0 =C2=A0 ],[])<br>
+<br>
+=C2=A0 =C2=A0 # Pad zeros at end of numbers to make same length.<br>
+=C2=A0 =C2=A0 ax_compare_version_tmp_A=3D&quot;$A`echo $B | sed &#39;s/./0=
/g&#39;`&quot;<br>
+=C2=A0 =C2=A0 B=3D&quot;$B`echo $A | sed &#39;s/./0/g&#39;`&quot;<br>
+=C2=A0 =C2=A0 A=3D&quot;$ax_compare_version_tmp_A&quot;<br>
+<br>
+=C2=A0 =C2=A0 # Check for equality or inequality as necessary.<br>
+=C2=A0 =C2=A0 m4_case(m4_tolower(m4_substr($2,0,2)),<br>
+=C2=A0 =C2=A0 [eq],[<br>
+=C2=A0 =C2=A0 =C2=A0 test &quot;x$A&quot; =3D &quot;x$B&quot; &amp;&amp; a=
x_compare_version=3Dtrue<br>
+=C2=A0 =C2=A0 ],<br>
+=C2=A0 =C2=A0 [ne],[<br>
+=C2=A0 =C2=A0 =C2=A0 test &quot;x$A&quot; !=3D &quot;x$B&quot; &amp;&amp; =
ax_compare_version=3Dtrue<br>
+=C2=A0 =C2=A0 ],[<br>
+=C2=A0 =C2=A0 =C2=A0 AC_WARNING([illegal OP parameter: $2])<br>
+=C2=A0 =C2=A0 ])<br>
+=C2=A0 ])<br>
+<br>
+=C2=A0 AS_VAR_POPDEF([A])dnl<br>
+=C2=A0 AS_VAR_POPDEF([B])dnl<br>
+<br>
+=C2=A0 dnl # Execute ACTION-IF-TRUE / ACTION-IF-FALSE.<br>
+=C2=A0 if test &quot;$ax_compare_version&quot; =3D &quot;true&quot; ; then=
<br>
+=C2=A0 =C2=A0 m4_ifvaln([$4],[$4],[:])dnl<br>
+=C2=A0 =C2=A0 m4_ifvaln([$5],[else $5])dnl<br>
+=C2=A0 fi<br>
+]) dnl AX_COMPARE_VERSION<br>
diff --git a/m4/ax_prog_bison_version.m4 b/m4/ax_prog_bison_version.m4<br>
new file mode 100644<br>
index 0000000..6b95585<br>
--- /dev/null<br>
+++ b/m4/ax_prog_bison_version.m4<br>
@@ -0,0 +1,64 @@<br>
+# SYNOPSIS<br>
+#<br>
+#=C2=A0 =C2=A0AX_PROG_BISON_VERSION([VERSION],[ACTION-IF-TRUE],[ACTION-IF-=
FALSE])<br>
+#<br>
+# DESCRIPTION<br>
+#<br>
+#=C2=A0 =C2=A0Makes sure that bison version is greater or equal to the ver=
sion indicated.<br>
+#=C2=A0 =C2=A0If true the shell commands in ACTION-IF-TRUE are executed. I=
f not the shell<br>
+#=C2=A0 =C2=A0commands in commands in ACTION-IF-TRUE are executed. If not =
the shell<br>
+#=C2=A0 =C2=A0commands in ACTION-IF-FALSE are run. Note if $BISON is not s=
et (for example<br>
+#=C2=A0 =C2=A0by running AC_CHECK_PROG or AC_PATH_PROG) the macro will fai=
l.<br>
+#<br>
+#=C2=A0 =C2=A0Example:<br>
+#<br>
+#=C2=A0 =C2=A0 =C2=A0AC_PATH_PROG([BISON],[bison])<br>
+#=C2=A0 =C2=A0 =C2=A0AX_PROG_BISON_VERSION([3.0.2],[ ... ],[ ... ])<br>
+#<br>
+#=C2=A0 =C2=A0This will check to make sure that the bison you have is at l=
east<br>
+#=C2=A0 =C2=A0version 3.0.2 or greater.<br>
+#<br>
+#=C2=A0 =C2=A0NOTE: This macro uses the $BISON variable to perform the che=
ck.<br>
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
+#serial 12<br>
+<br>
+AC_DEFUN([AX_PROG_BISON_VERSION],[<br>
+=C2=A0 =C2=A0 AC_REQUIRE([AC_PROG_SED])<br>
+=C2=A0 =C2=A0 AC_REQUIRE([AC_PROG_GREP])<br>
+<br>
+=C2=A0 =C2=A0 AS_IF([test -n &quot;$BISON&quot;],[<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ax_bison_version=3D&quot;$1&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 AC_MSG_CHECKING([for bison version])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 changequote(&lt;&lt;,&gt;&gt;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bison_version=3D`$BISON --version 2&gt;&amp;1 =
\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | $SED -n -e &#39;/bison (GNU Bison)/b =
inspect<br>
+b<br>
+: inspect<br>
+s/.* (\{0,1\}\([0-9]*\.[0-9]*\.[0-9]*\))\{0,1\}.*/\1/;p&#39;`<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 changequote([,])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 AC_MSG_RESULT($bison_version)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0AC_SUBST([BISON_VERSION],[$bison_version])<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 AX_COMPARE_VERSION([$bison_version],[ge],[$ax_=
bison_version],[<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $2<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ],[<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $3<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ])<br>
+=C2=A0 =C2=A0 ],[<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 AC_MSG_WARN([could not find bison])<br>
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

--047d7b5d848d929aa60519ebcf1d--


--===============0741334274==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0741334274==--
