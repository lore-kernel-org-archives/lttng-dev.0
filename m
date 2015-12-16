From: Didier Nadeau <didier.nadeau@gmail.com>
Subject: Re: [PATCH] Support for Xeon-Phi with newer MPSS
Date: Wed, 16 Dec 2015 15:21:14 -0500
Message-ID: <CAK0EQJHm5tZdt+KCnw-kYBRjfejtc+8YtY=xuPq7pC6Rin05Ug__29738.7640610852$1450297329$gmane$org@mail.gmail.com>
References: <1450296167-9584-1-git-send-email-didier.nadeau@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1622202984=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <didier.nadeau@gmail.com>) id 1a9IZb-0005C0-VE
 for lttng-dev@lists.lttng.org; Wed, 16 Dec 2015 15:21:23 -0500
Received: by mail-oi0-f46.google.com with SMTP id l9so2361421oia.2
 for <lttng-dev@lists.lttng.org>; Wed, 16 Dec 2015 12:21:19 -0800 (PST)
In-Reply-To: <1450296167-9584-1-git-send-email-didier.nadeau@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1622202984==
Content-Type: multipart/alternative; boundary=001a1134f584db5b32052709a5a1

--001a1134f584db5b32052709a5a1
Content-Type: text/plain; charset=UTF-8

This patch concerns userspace-rcu, I should have specified it.

2015-12-16 15:02 GMT-05:00 Didier Nadeau <didier.nadeau@gmail.com>:

> The Xeon-Phi is now considered as a new architecture instead of a
> vendor in MPSS version 3.4.4. This change is backward compatible with
> previous MPSS versions.
>
> Signed-off-by: Didier Nadeau <didier.nadeau@gmail.com>
> ---
>  configure.ac | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/configure.ac b/configure.ac
> index e7e300b..39a7777 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -103,6 +103,7 @@ AC_CHECK_HEADERS([ \
>
>  # Find arch type
>  AS_CASE([$host_cpu],
> +       [k1om], [ARCHTYPE="x86"],
>         [i386], [ARCHTYPE="x86" && SUBARCHTYPE="x86compat"],
>         [i486], [ARCHTYPE="x86"],
>         [i586], [ARCHTYPE="x86"],
> @@ -189,7 +190,7 @@ AS_IF([test "x$ARCHTYPE" = "xx86"],[
>         #
>         #k1om is the name for the Intel MIC family (Xeon Phi). It is an
> x86_64
>         #variant but lacks fence instructions.
> -       AS_IF([test "x$host_cpu" != "xi386" -a "x$host_cpu" != "xi486" -a
> "x$host_cpu" != "xi586" -a "x$host_cpu" != "xi686" -a "x$host_vendor" !=
> "xk1om"],[
> +       AS_IF([test "x$host_cpu" != "xi386" -a "x$host_cpu" != "xi486" -a
> "x$host_cpu" != "xi586" -a "x$host_cpu" != "xi686" -a "x$host_vendor" !=
> "xk1om" -a "x$host_cpu" != "xk1om"],[
>                 AC_MSG_RESULT([yes])
>                 AC_DEFINE([CONFIG_RCU_HAVE_FENCE], [1])
>         ],[
> --
> 1.9.1
>
>

--001a1134f584db5b32052709a5a1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">This patch concerns userspace-rcu, I should have specified=
 it.<br></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">201=
5-12-16 15:02 GMT-05:00 Didier Nadeau <span dir=3D"ltr">&lt;<a href=3D"mail=
to:didier.nadeau@gmail.com" target=3D"_blank">didier.nadeau@gmail.com</a>&g=
t;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex">The Xeon-Phi is now considered=
 as a new architecture instead of a<br>
vendor in MPSS version 3.4.4. This change is backward compatible with<br>
previous MPSS versions.<br>
<br>
Signed-off-by: Didier Nadeau &lt;<a href=3D"mailto:didier.nadeau@gmail.com"=
>didier.nadeau@gmail.com</a>&gt;<br>
---<br>
=C2=A0<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a> | 3 ++-<br>
=C2=A01 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_=
blank">configure.ac</a> b/<a href=3D"http://configure.ac" rel=3D"noreferrer=
" target=3D"_blank">configure.ac</a><br>
index e7e300b..39a7777 100644<br>
--- a/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a><br>
+++ b/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a><br>
@@ -103,6 +103,7 @@ AC_CHECK_HEADERS([ \<br>
<br>
=C2=A0# Find arch type<br>
=C2=A0AS_CASE([$host_cpu],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0[k1om], [ARCHTYPE=3D&quot;x86&quot;],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 [i386], [ARCHTYPE=3D&quot;x86&quot; &amp;&amp; =
SUBARCHTYPE=3D&quot;x86compat&quot;],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 [i486], [ARCHTYPE=3D&quot;x86&quot;],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 [i586], [ARCHTYPE=3D&quot;x86&quot;],<br>
@@ -189,7 +190,7 @@ AS_IF([test &quot;x$ARCHTYPE&quot; =3D &quot;xx86&quot;=
],[<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 #<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 #k1om is the name for the Intel MIC family (Xeo=
n Phi). It is an x86_64<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 #variant but lacks fence instructions.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0AS_IF([test &quot;x$host_cpu&quot; !=3D &quot;x=
i386&quot; -a &quot;x$host_cpu&quot; !=3D &quot;xi486&quot; -a &quot;x$host=
_cpu&quot; !=3D &quot;xi586&quot; -a &quot;x$host_cpu&quot; !=3D &quot;xi68=
6&quot; -a &quot;x$host_vendor&quot; !=3D &quot;xk1om&quot;],[<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0AS_IF([test &quot;x$host_cpu&quot; !=3D &quot;x=
i386&quot; -a &quot;x$host_cpu&quot; !=3D &quot;xi486&quot; -a &quot;x$host=
_cpu&quot; !=3D &quot;xi586&quot; -a &quot;x$host_cpu&quot; !=3D &quot;xi68=
6&quot; -a &quot;x$host_vendor&quot; !=3D &quot;xk1om&quot; -a &quot;x$host=
_cpu&quot; !=3D &quot;xk1om&quot;],[<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AC_MSG_RESULT([yes]=
)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AC_DEFINE([CONFIG_R=
CU_HAVE_FENCE], [1])<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ],[<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
1.9.1<br>
<br>
</font></span></blockquote></div><br></div>

--001a1134f584db5b32052709a5a1--


--===============1622202984==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1622202984==--
