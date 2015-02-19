From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH babeltrace] Fix running tests out of tree
Date: Thu, 19 Feb 2015 15:01:58 -0500
Message-ID: <CA+jJMxsfxHALU18fNGP=qQZFgQk05XmEe5Enjuw3t0uVirFhLQ__46324.5688043118$1424376195$gmane$org@mail.gmail.com>
References: <1423939778-1788-1-git-send-email-simon.marchi@polymtl.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0149228897=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1YOXIS-0004vg-PM
 for lttng-dev@lists.lttng.org; Thu, 19 Feb 2015 15:02:08 -0500
Received: by mail-qg0-f52.google.com with SMTP id h3so9043457qgf.11
 for <lttng-dev@lists.lttng.org>; Thu, 19 Feb 2015 12:01:58 -0800 (PST)
In-Reply-To: <1423939778-1788-1-git-send-email-simon.marchi@polymtl.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Simon Marchi <simon.marchi@polymtl.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0149228897==
Content-Type: multipart/alternative; boundary=001a1134ee6e971552050f7668a2

--001a1134ee6e971552050f7668a2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Merged, thanks!

J=C3=A9r=C3=A9mie

On Sat, Feb 14, 2015 at 1:49 PM, Simon Marchi <simon.marchi@polymtl.ca>
wrote:

> When building out of tree, make check fails because the "tests" file is
> not found.
>
> Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
> ---
>  tests/Makefile.am | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/Makefile.am b/tests/Makefile.am
> index 8d84b16..2e307f4 100644
> --- a/tests/Makefile.am
> +++ b/tests/Makefile.am
> @@ -21,4 +21,4 @@ clean-local:
>         fi
>
>  check-am:
> -       ./run.sh tests
> +       ./run.sh $(srcdir)/tests
> --
> 2.3.0
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>



--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--001a1134ee6e971552050f7668a2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Merged, thanks!<div><br></div><div>J=C3=A9r=C3=A9mie</div>=
</div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Sat, Feb=
 14, 2015 at 1:49 PM, Simon Marchi <span dir=3D"ltr">&lt;<a href=3D"mailto:=
simon.marchi@polymtl.ca" target=3D"_blank">simon.marchi@polymtl.ca</a>&gt;<=
/span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">When building out of tree, =
make check fails because the &quot;tests&quot; file is<br>
not found.<br>
<br>
Signed-off-by: Simon Marchi &lt;<a href=3D"mailto:simon.marchi@polymtl.ca">=
simon.marchi@polymtl.ca</a>&gt;<br>
---<br>
=C2=A0tests/Makefile.am | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/tests/Makefile.am b/tests/Makefile.am<br>
index 8d84b16..2e307f4 100644<br>
--- a/tests/Makefile.am<br>
+++ b/tests/Makefile.am<br>
@@ -21,4 +21,4 @@ clean-local:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>
<br>
=C2=A0check-am:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0./run.sh tests<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0./run.sh $(srcdir)/tests<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
2.3.0<br>
<br>
<br>
_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature">J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS In=
c.<br><a href=3D"http://www.efficios.com" target=3D"_blank">http://www.effi=
cios.com</a></div>
</div>

--001a1134ee6e971552050f7668a2--


--===============0149228897==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0149228897==--
