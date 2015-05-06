From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools 2/2] Fix: modprobe.c: fix
 tmp_list memory leak
Date: Wed, 6 May 2015 12:14:17 -0400
Message-ID: <CA+jJMxveRjbBgSvdxh_HGF=J=Oj+LwoUUY=xoC99b78hM4zDRw__44751.0208505721$1430929042$gmane$org@mail.gmail.com>
References: <1430255356-6566-1-git-send-email-eeppeliteloop@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0627081462=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1Yq1xm-0000ei-QU
 for lttng-dev@lists.lttng.org; Wed, 06 May 2015 12:14:31 -0400
Received: by qgej70 with SMTP id j70so7079610qge.2
 for <lttng-dev@lists.lttng.org>; Wed, 06 May 2015 09:14:17 -0700 (PDT)
In-Reply-To: <1430255356-6566-1-git-send-email-eeppeliteloop@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Philippe Proulx <eeppeliteloop@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0627081462==
Content-Type: multipart/alternative; boundary=001a11479df03f186405156c16d6

--001a11479df03f186405156c16d6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Merged in both master and stable-2.6, thanks!

J=C3=A9r=C3=A9mie

On Tue, Apr 28, 2015 at 5:09 PM, Philippe Proulx <eeppeliteloop@gmail.com>
wrote:

> Reported-by: Hannes Weisbach <hannes.weisbach@mailbox.tu-dresden.de>
> Signed-off-by: Philippe Proulx <eeppeliteloop@gmail.com>
> ---
>  src/bin/lttng-sessiond/modprobe.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/src/bin/lttng-sessiond/modprobe.c
> b/src/bin/lttng-sessiond/modprobe.c
> index d730a1d..32c4210 100644
> --- a/src/bin/lttng-sessiond/modprobe.c
> +++ b/src/bin/lttng-sessiond/modprobe.c
> @@ -360,11 +360,11 @@ static int append_list_to_probes(const char *list)
>  {
>         char *next;
>         int index =3D nr_probes, ret;
> -       char *tmp_list;
> +       char *tmp_list, *cur_list;
>
>         assert(list);
>
> -       tmp_list =3D strdup(list);
> +       cur_list =3D tmp_list =3D strdup(list);
>         if (!tmp_list) {
>                 PERROR("strdup temp list");
>                 return -ENOMEM;
> @@ -374,11 +374,11 @@ static int append_list_to_probes(const char *list)
>                 size_t name_len;
>                 struct kern_modules_param *cur_mod;
>
> -               next =3D strtok(tmp_list, ",");
> +               next =3D strtok(cur_list, ",");
>                 if (!next) {
>                         break;
>                 }
> -               tmp_list =3D NULL;
> +               cur_list =3D NULL;
>
>                 /* filter leading spaces */
>                 while (*next =3D=3D ' ') {
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

--001a11479df03f186405156c16d6
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Merged in both master and stable-2.6, thanks!<div><br></di=
v><div>J=C3=A9r=C3=A9mie</div></div><div class=3D"gmail_extra"><br><div cla=
ss=3D"gmail_quote">On Tue, Apr 28, 2015 at 5:09 PM, Philippe Proulx <span d=
ir=3D"ltr">&lt;<a href=3D"mailto:eeppeliteloop@gmail.com" target=3D"_blank"=
>eeppeliteloop@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex">Reported-by: Hannes Weisbach &lt;<a href=3D"mailto:hannes.weisbach@ma=
ilbox.tu-dresden.de">hannes.weisbach@mailbox.tu-dresden.de</a>&gt;<br>
Signed-off-by: Philippe Proulx &lt;<a href=3D"mailto:eeppeliteloop@gmail.co=
m">eeppeliteloop@gmail.com</a>&gt;<br>
---<br>
=C2=A0src/bin/lttng-sessiond/modprobe.c | 8 ++++----<br>
=C2=A01 file changed, 4 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/src/bin/lttng-sessiond/modprobe.c b/src/bin/lttng-sessiond/mod=
probe.c<br>
index d730a1d..32c4210 100644<br>
--- a/src/bin/lttng-sessiond/modprobe.c<br>
+++ b/src/bin/lttng-sessiond/modprobe.c<br>
@@ -360,11 +360,11 @@ static int append_list_to_probes(const char *list)<br=
>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 char *next;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int index =3D nr_probes, ret;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0char *tmp_list;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0char *tmp_list, *cur_list;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(list);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp_list =3D strdup(list);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0cur_list =3D tmp_list =3D strdup(list);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!tmp_list) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PERROR(&quot;strdup=
 temp list&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;<br>
@@ -374,11 +374,11 @@ static int append_list_to_probes(const char *list)<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t name_len;<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct kern_modules=
_param *cur_mod;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0next =3D strtok(tmp=
_list, &quot;,&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0next =3D strtok(cur=
_list, &quot;,&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!next) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tmp_list =3D NULL;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cur_list =3D NULL;<=
br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* filter leading s=
paces */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 while (*next =3D=3D=
 &#39; &#39;) {<br>
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

--001a11479df03f186405156c16d6--


--===============0627081462==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0627081462==--
