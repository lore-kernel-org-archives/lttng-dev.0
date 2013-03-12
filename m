From: =?ISO-8859-1?Q?Rapha=EBl_Beamonte?= <raphael.beamonte@gmail.com>
Subject: Re: [lttng-tools PATCH] Correct LTTng version
Date: Tue, 12 Mar 2013 17:31:49 -0400
Message-ID: <CAE_Gge0+ympRPULDhugMjFCxDrs49t3wJy9BRbOUYNkyfCoU_A__11536.6002348766$1363123977$gmane$org@mail.gmail.com>
References: <14dbf3b61272282c1f4163c8a1a2f2b681f3989c.1363123481.git.raphael.beamonte@gmail.com>
	<513F9DF1.9030909@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0033194834=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <nashii@gmail.com>) id 1UFWnu-0003Sc-PS
	for lttng-dev@lists.lttng.org; Tue, 12 Mar 2013 17:32:14 -0400
Received: by mail-ob0-f170.google.com with SMTP id wc20so347771obb.29
	for <lttng-dev@lists.lttng.org>; Tue, 12 Mar 2013 14:32:09 -0700 (PDT)
In-Reply-To: <513F9DF1.9030909@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0033194834==
Content-Type: multipart/alternative; boundary=bcaec55238c495d46d04d7c10591

--bcaec55238c495d46d04d7c10591
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi David,

The tag version changed in LTTng but not the displayed version, and it made
me remove the whole LTTng tools from my computer and reinstall them as I
didn't understand why the version number displayed wasn't the one from the
version I was installing. It's not a very important bug, but it could be a
time consumer one...

Rapha=EBl

2013/3/12 David Goulet <dgoulet@efficios.com>

> Hi Rapha=EBl,
>
> This is not very relevant because we branch at each release so the
> master version is a bit useless.
>
> Do you have a need for that?
>
> Thanks
> David
>
> Rapha=EBl Beamonte:
> > Signed-off-by: Rapha=EBl Beamonte <raphael.beamonte@gmail.com>
> > ---
> >  configure.ac |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/configure.ac b/configure.ac
> > index 7e35c06..c8aa034 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -1,4 +1,4 @@
> > -AC_INIT([lttng-tools],[2.1.0],[dgoulet@efficios.com],[],[
> http://lttng.org])
> > +AC_INIT([lttng-tools],[2.1.1],[dgoulet@efficios.com],[],[
> http://lttng.org])
> >  AC_CONFIG_AUX_DIR([config])
> >  AC_CANONICAL_TARGET
> >  AC_CANONICAL_HOST
>

--bcaec55238c495d46d04d7c10591
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi David,<br><br>The tag version changed in LTTng but not the displayed ver=
sion, and it made me remove the whole LTTng tools from my computer and rein=
stall them as I didn&#39;t understand why the version number displayed wasn=
&#39;t the one from the version I was installing. It&#39;s not a very impor=
tant bug, but it could be a time consumer one...<br>

<br>Rapha=EBl<br><br><div class=3D"gmail_quote">2013/3/12 David Goulet <spa=
n dir=3D"ltr">&lt;<a href=3D"mailto:dgoulet@efficios.com" target=3D"_blank"=
>dgoulet@efficios.com</a>&gt;</span><br><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">

Hi Rapha=EBl,<br>
<br>
This is not very relevant because we branch at each release so the<br>
master version is a bit useless.<br>
<br>
Do you have a need for that?<br>
<br>
Thanks<br>
David<br>
<br>
Rapha=EBl Beamonte:<br>
<div class=3D"HOEnZb"><div class=3D"h5">&gt; Signed-off-by: Rapha=EBl Beamo=
nte &lt;<a href=3D"mailto:raphael.beamonte@gmail.com">raphael.beamonte@gmai=
l.com</a>&gt;<br>
&gt; ---<br>
&gt; =A0<a href=3D"http://configure.ac" target=3D"_blank">configure.ac</a> =
| =A0 =A02 +-<br>
&gt; =A01 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/<a href=3D"http://configure.ac" target=3D"_blank">configu=
re.ac</a> b/<a href=3D"http://configure.ac" target=3D"_blank">configure.ac<=
/a><br>
&gt; index 7e35c06..c8aa034 100644<br>
&gt; --- a/<a href=3D"http://configure.ac" target=3D"_blank">configure.ac</=
a><br>
&gt; +++ b/<a href=3D"http://configure.ac" target=3D"_blank">configure.ac</=
a><br>
&gt; @@ -1,4 +1,4 @@<br>
&gt; -AC_INIT([lttng-tools],[2.1.0],[<a href=3D"mailto:dgoulet@efficios.com=
">dgoulet@efficios.com</a>],[],[<a href=3D"http://lttng.org" target=3D"_bla=
nk">http://lttng.org</a>])<br>
&gt; +AC_INIT([lttng-tools],[2.1.1],[<a href=3D"mailto:dgoulet@efficios.com=
">dgoulet@efficios.com</a>],[],[<a href=3D"http://lttng.org" target=3D"_bla=
nk">http://lttng.org</a>])<br>
&gt; =A0AC_CONFIG_AUX_DIR([config])<br>
&gt; =A0AC_CANONICAL_TARGET<br>
&gt; =A0AC_CANONICAL_HOST<br>
</div></div></blockquote></div><br>

--bcaec55238c495d46d04d7c10591--


--===============0033194834==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0033194834==--
