From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: destroy session removes
 the default config file
Date: Mon, 25 May 2015 15:18:42 -0400
Message-ID: <CA+jJMxsMHrN7D7XhAte8jSn9=yd2+aSvJM9e5jNexTYaexXcLg__10962.4390527189$1432581617$gmane$org@mail.gmail.com>
References: <87h9r7yt1m.fsf@hahabo.in>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1211560967=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1Ywxtg-00088A-Il
 for lttng-dev@lists.lttng.org; Mon, 25 May 2015 15:18:56 -0400
Received: by qkx62 with SMTP id 62so71222758qkx.3
 for <lttng-dev@lists.lttng.org>; Mon, 25 May 2015 12:18:42 -0700 (PDT)
In-Reply-To: <87h9r7yt1m.fsf@hahabo.in>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Partha Pratim Mukherjee <ppm.floss@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1211560967==
Content-Type: multipart/alternative; boundary=001a11359d10c77d760516ece013

--001a11359d10c77d760516ece013
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Partha,

First, thanks for the patch! Unfortunately, there are a couple of issues
with this fix. Read on.


On Wed, May 20, 2015 at 2:59 PM, Partha Pratim Mukherjee <
ppm.floss@gmail.com> wrote:

> Destroy session command by default removes the default config file
> without checking the current session. As a result when we call any
> other command which expects a default session by calling
> get_session_name() function, it fails.
>
> This patch will fix this by checking that the default config file gets
> removed only when destroy session is called with the current session.
>
> Fixes: #887
>
> Signed-off-by: Partha Pratim Mukherjee <ppm.floss@gmail.com>
> ---
>  src/bin/lttng/commands/destroy.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/src/bin/lttng/commands/destroy.c
> b/src/bin/lttng/commands/destroy.c
> index 95343c9..3fcecc2 100644
> --- a/src/bin/lttng/commands/destroy.c
> +++ b/src/bin/lttng/commands/destroy.c
> @@ -90,7 +90,9 @@ static int destroy_session(struct lttng_session *sessio=
n)
>         }
>
>         MSG("Session %s destroyed", session->name);
> -       config_destroy_default();
> +       if (strncmp(session->name, get_session_name(), NAME_MAX) =3D=3D 0=
) {
>


This will leak the string returned by get_session_name().

Moreover, config_read_session_name(), which is called by get_session_name()
will spam the error logs anytime an .lttngrc file can't be found; the error
logging statement should be moved out to the different callers.

Looking forward to a v2!
J=C3=A9r=C3=A9mie



> +               config_destroy_default();
> +       }
>
>         if (lttng_opt_mi) {
>                 ret =3D mi_lttng_session(writer, session, 0);
> --
> 1.7.10.4
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

--001a11359d10c77d760516ece013
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Partha,</div><div><br></div><div>First, thanks for=
 the patch! Unfortunately, there are a couple of issues with this fix. Read=
 on.</div><div><br></div><div class=3D"gmail_extra"><br><div class=3D"gmail=
_quote">On Wed, May 20, 2015 at 2:59 PM, Partha Pratim Mukherjee <span dir=
=3D"ltr">&lt;<a href=3D"mailto:ppm.floss@gmail.com" target=3D"_blank">ppm.f=
loss@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rg=
b(204,204,204);border-left-style:solid;padding-left:1ex">Destroy session co=
mmand by default removes the default config file<br>
without checking the current session. As a result when we call any<br>
other command which expects a default session by calling<br>
get_session_name() function, it fails.<br>
<br>
This patch will fix this by checking that the default config file gets<br>
removed only when destroy session is called with the current session.<br>
<br>
Fixes: #887<br>
<br>
Signed-off-by: Partha Pratim Mukherjee &lt;<a href=3D"mailto:ppm.floss@gmai=
l.com">ppm.floss@gmail.com</a>&gt;<br>
---<br>
=C2=A0src/bin/lttng/commands/destroy.c |=C2=A0 =C2=A0 4 +++-<br>
=C2=A01 file changed, 3 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/src/bin/lttng/commands/destroy.c b/src/bin/lttng/commands/dest=
roy.c<br>
index 95343c9..3fcecc2 100644<br>
--- a/src/bin/lttng/commands/destroy.c<br>
+++ b/src/bin/lttng/commands/destroy.c<br>
@@ -90,7 +90,9 @@ static int destroy_session(struct lttng_session *session)=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 MSG(&quot;Session %s destroyed&quot;, session-&=
gt;name);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0config_destroy_default();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (strncmp(session-&gt;name, get_session_name(=
), NAME_MAX) =3D=3D 0) {<br></blockquote><div><br></div><div><br></div><div=
>This will leak the string returned by get_session_name().</div><div><br></=
div><div>Moreover, config_read_session_name(), which is called by=C2=A0get_=
session_name() will spam the error logs anytime an .lttngrc file can&#39;t =
be found; the error logging statement should be moved out to the different =
callers.</div><div><br></div><div>Looking forward to a v2!</div><div>J=C3=
=A9r=C3=A9mie<br></div><div><br></div><div>=C2=A0</div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;borde=
r-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0config_destroy_defa=
ult();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (lttng_opt_mi) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D mi_lttng_se=
ssion(writer, session, 0);<br>
<span class=3D""><font color=3D"#888888">--<br>
1.7.10.4<br>
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
</div></div>

--001a11359d10c77d760516ece013--


--===============1211560967==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1211560967==--
