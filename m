From: Anders Wallin <wallinux@gmail.com>
Subject: Re: lttng-tools 2.10.4 broken when auto loading session
Date: Thu, 03 May 2018 17:57:29 +0000
Message-ID: <CAF2baFdYyXhXwLvjY89SPu_rPigOZB2dyaQfO_QVH5TRA8PsMw__22027.7542634451$1525370144$gmane$org@mail.gmail.com>
References: <CAF2baFdqgzUQyfDn6gi8-+SvDYy058EzMkG8k3a5gnA1Df7tnw@mail.gmail.com>
 <20180503153252.GA2332@joraj-alpa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="00000000000077f7b3056b50f0ad"
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-oi0-x236.google.com (mail-oi0-x236.google.com
 [IPv6:2607:f8b0:4003:c06::236])
 by lists.lttng.org (Postfix) with ESMTPS id 40cNCS683Xz17yv
 for <lttng-dev@lists.lttng.org>; Thu,  3 May 2018 13:57:40 -0400 (EDT)
Received: by mail-oi0-x236.google.com with SMTP id a6-v6so16888162oia.2
 for <lttng-dev@lists.lttng.org>; Thu, 03 May 2018 10:57:40 -0700 (PDT)
In-Reply-To: <20180503153252.GA2332@joraj-alpa>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--00000000000077f7b3056b50f0ad
Content-Type: multipart/alternative; boundary="00000000000077f7b1056b50f0ab"

--00000000000077f7b1056b50f0ab
Content-Type: text/plain; charset="UTF-8"

File appended

Regards
Anders

tors 3 maj 2018 kl 17:33 skrev Jonathan Rajotte-Julien <
jonathan.rajotte-julien@efficios.com>:

> On Thu, May 03, 2018 at 12:27:48PM +0000, Anders Wallin wrote:
> > Hi,
> >
> > lttng-tools hangs when a session is stored /etc/lttng/session/auto/
> >
> > $ head -10 /etc/lttng/sessions/auto/test.lttng
> > <?xml version="1.0" encoding="UTF-8"?>
> > <sessions>
> >         <session>
> >                 <name>test</name>
> >                 <domains>
> >                         <domain>
> >                                 <type>UST</type>
> >                                 <buffer_type>PER_UID</buffer_type>
> >                                 <channels>
> >                                         <channel>
>
> Could you give us the complete xml?
>
> Cheers
>
> > $ lttng-sessiond -d  # Hanging forever
> >
> > I will continue investigate why, but I though you wanna know ASAP
> >
> > Regards
> > Anders Wallin
>
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
> --
> Jonathan Rajotte-Julien
> EfficiOS
>

--00000000000077f7b1056b50f0ab
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">File appended<div><br></div><div>Regards</div><div>Anders<=
br><br><div class=3D"gmail_quote"><div dir=3D"ltr">tors 3 maj 2018 kl 17:33=
 skrev Jonathan Rajotte-Julien &lt;<a href=3D"mailto:jonathan.rajotte-julie=
n@efficios.com">jonathan.rajotte-julien@efficios.com</a>&gt;:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex">On Thu, May 03, 2018 at 12:27:48PM +0000, Anders=
 Wallin wrote:<br>
&gt; Hi,<br>
&gt; <br>
&gt; lttng-tools hangs when a session is stored /etc/lttng/session/auto/<br=
>
&gt; <br>
&gt; $ head -10 /etc/lttng/sessions/auto/test.lttng<br>
&gt; &lt;?xml version=3D&quot;1.0&quot; encoding=3D&quot;UTF-8&quot;?&gt;<b=
r>
&gt; &lt;sessions&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;session&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;name&=
gt;test&lt;/name&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;domai=
ns&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0&lt;domain&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;type&gt;UST&lt;/type&gt=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;buffer_type&gt;PER_UID&=
lt;/buffer_type&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;channels&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&lt;channel&gt;<br>
<br>
Could you give us the complete xml?<br>
<br>
Cheers<br>
<br>
&gt; $ lttng-sessiond -d=C2=A0 # Hanging forever<br>
&gt; <br>
&gt; I will continue investigate why, but I though you wanna know ASAP<br>
&gt; <br>
&gt; Regards<br>
&gt; Anders Wallin<br>
<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-d=
ev@lists.lttng.org</a><br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bin/mailm=
an/listinfo/lttng-dev</a><br>
<br>
<br>
-- <br>
Jonathan Rajotte-Julien<br>
EfficiOS<br>
</blockquote></div></div></div>

--00000000000077f7b1056b50f0ab--

--00000000000077f7b3056b50f0ad
Content-Type: application/octet-stream; name="test.lttng"
Content-Disposition: attachment; filename="test.lttng"
Content-Transfer-Encoding: base64
Content-ID: <16327266b9d276862491>
X-Attachment-Id: 16327266b9d276862491

PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHNlc3Npb25zPgoJPHNlc3Np
b24+CgkJPG5hbWU+dGVzdDwvbmFtZT4KCQk8ZG9tYWlucz4KCQkJPGRvbWFpbj4KCQkJCTx0eXBl
PlVTVDwvdHlwZT4KCQkJCTxidWZmZXJfdHlwZT5QRVJfVUlEPC9idWZmZXJfdHlwZT4KCQkJCTxj
aGFubmVscz4KCQkJCQk8Y2hhbm5lbD4KCQkJCQkJPG5hbWU+Y2gxPC9uYW1lPgoJCQkJCQk8ZW5h
YmxlZD50cnVlPC9lbmFibGVkPgoJCQkJCQk8b3ZlcndyaXRlX21vZGU+T1ZFUldSSVRFPC9vdmVy
d3JpdGVfbW9kZT4KCQkJCQkJPHN1YmJ1ZmZlcl9zaXplPjgxOTI8L3N1YmJ1ZmZlcl9zaXplPgoJ
CQkJCQk8c3ViYnVmZmVyX2NvdW50Pjg8L3N1YmJ1ZmZlcl9jb3VudD4KCQkJCQkJPHN3aXRjaF90
aW1lcl9pbnRlcnZhbD4wPC9zd2l0Y2hfdGltZXJfaW50ZXJ2YWw+CgkJCQkJCTxyZWFkX3RpbWVy
X2ludGVydmFsPjA8L3JlYWRfdGltZXJfaW50ZXJ2YWw+CgkJCQkJCTxvdXRwdXRfdHlwZT5NTUFQ
PC9vdXRwdXRfdHlwZT4KCQkJCQkJPGJsb2NraW5nX3RpbWVvdXQ+MDwvYmxvY2tpbmdfdGltZW91
dD4KCQkJCQkJPG1vbml0b3JfdGltZXJfaW50ZXJ2YWw+MTAwMDAwMDwvbW9uaXRvcl90aW1lcl9p
bnRlcnZhbD4KCQkJCQkJPHRyYWNlZmlsZV9zaXplPjA8L3RyYWNlZmlsZV9zaXplPgoJCQkJCQk8
dHJhY2VmaWxlX2NvdW50PjA8L3RyYWNlZmlsZV9jb3VudD4KCQkJCQkJPGxpdmVfdGltZXJfaW50
ZXJ2YWw+MDwvbGl2ZV90aW1lcl9pbnRlcnZhbD4KCQkJCQkJPGV2ZW50cz4KCQkJCQkJCTxldmVu
dD4KCQkJCQkJCQk8bmFtZT4qPC9uYW1lPgoJCQkJCQkJCTxlbmFibGVkPnRydWU8L2VuYWJsZWQ+
CgkJCQkJCQkJPHR5cGU+VFJBQ0VQT0lOVDwvdHlwZT4KCQkJCQkJCQk8bG9nbGV2ZWxfdHlwZT5B
TEw8L2xvZ2xldmVsX3R5cGU+CgkJCQkJCQk8L2V2ZW50PgoJCQkJCQk8L2V2ZW50cz4KCQkJCQkJ
PGNvbnRleHRzLz4KCQkJCQk8L2NoYW5uZWw+CgkJCQkJPGNoYW5uZWw+CgkJCQkJCTxuYW1lPmNo
MjwvbmFtZT4KCQkJCQkJPGVuYWJsZWQ+dHJ1ZTwvZW5hYmxlZD4KCQkJCQkJPG92ZXJ3cml0ZV9t
b2RlPk9WRVJXUklURTwvb3ZlcndyaXRlX21vZGU+CgkJCQkJCTxzdWJidWZmZXJfc2l6ZT42NTUz
Njwvc3ViYnVmZmVyX3NpemU+CgkJCQkJCTxzdWJidWZmZXJfY291bnQ+Mjwvc3ViYnVmZmVyX2Nv
dW50PgoJCQkJCQk8c3dpdGNoX3RpbWVyX2ludGVydmFsPjA8L3N3aXRjaF90aW1lcl9pbnRlcnZh
bD4KCQkJCQkJPHJlYWRfdGltZXJfaW50ZXJ2YWw+MDwvcmVhZF90aW1lcl9pbnRlcnZhbD4KCQkJ
CQkJPG91dHB1dF90eXBlPk1NQVA8L291dHB1dF90eXBlPgoJCQkJCQk8YmxvY2tpbmdfdGltZW91
dD4wPC9ibG9ja2luZ190aW1lb3V0PgoJCQkJCQk8bW9uaXRvcl90aW1lcl9pbnRlcnZhbD4xMDAw
MDAwPC9tb25pdG9yX3RpbWVyX2ludGVydmFsPgoJCQkJCQk8dHJhY2VmaWxlX3NpemU+MDwvdHJh
Y2VmaWxlX3NpemU+CgkJCQkJCTx0cmFjZWZpbGVfY291bnQ+MDwvdHJhY2VmaWxlX2NvdW50PgoJ
CQkJCQk8bGl2ZV90aW1lcl9pbnRlcnZhbD4wPC9saXZlX3RpbWVyX2ludGVydmFsPgoJCQkJCQk8
ZXZlbnRzLz4KCQkJCQkJPGNvbnRleHRzLz4KCQkJCQk8L2NoYW5uZWw+CgkJCQk8L2NoYW5uZWxz
PgoJCQkJPHRyYWNrZXJzLz4KCQkJPC9kb21haW4+CgkJCTxkb21haW4+CgkJCQk8dHlwZT5KVUw8
L3R5cGU+CgkJCQk8YnVmZmVyX3R5cGU+UEVSX1VJRDwvYnVmZmVyX3R5cGU+CgkJCQk8Y2hhbm5l
bHMvPgoJCQk8L2RvbWFpbj4KCQkJPGRvbWFpbj4KCQkJCTx0eXBlPkxPRzRKPC90eXBlPgoJCQkJ
PGJ1ZmZlcl90eXBlPlBFUl9VSUQ8L2J1ZmZlcl90eXBlPgoJCQkJPGNoYW5uZWxzLz4KCQkJPC9k
b21haW4+CgkJCTxkb21haW4+CgkJCQk8dHlwZT5QWVRIT048L3R5cGU+CgkJCQk8YnVmZmVyX3R5
cGU+UEVSX1VJRDwvYnVmZmVyX3R5cGU+CgkJCQk8Y2hhbm5lbHMvPgoJCQk8L2RvbWFpbj4KCQk8
L2RvbWFpbnM+CgkJPHN0YXJ0ZWQ+ZmFsc2U8L3N0YXJ0ZWQ+CgkJPGF0dHJpYnV0ZXM+CgkJCTxz
bmFwc2hvdF9tb2RlPnRydWU8L3NuYXBzaG90X21vZGU+CgkJPC9hdHRyaWJ1dGVzPgoJCTxvdXRw
dXQ+CgkJCTxzbmFwc2hvdF9vdXRwdXRzPgoJCQkJPG91dHB1dD4KCQkJCQk8bmFtZT5zbmFwc2hv
dC0xPC9uYW1lPgoJCQkJCTxtYXhfc2l6ZT4wPC9tYXhfc2l6ZT4KCQkJCQk8Y29uc3VtZXJfb3V0
cHV0PgoJCQkJCQk8ZW5hYmxlZD50cnVlPC9lbmFibGVkPgoJCQkJCQk8ZGVzdGluYXRpb24+CgkJ
CQkJCQk8cGF0aD4vcm9vdC9sdHRuZy10cmFjZXMvdGVzdC0yMDE4MDUwMy0xNDExMTQ8L3BhdGg+
CgkJCQkJCTwvZGVzdGluYXRpb24+CgkJCQkJPC9jb25zdW1lcl9vdXRwdXQ+CgkJCQk8L291dHB1
dD4KCQkJPC9zbmFwc2hvdF9vdXRwdXRzPgoJCTwvb3V0cHV0PgoJPC9zZXNzaW9uPgo8L3Nlc3Np
b25zPgo=
--00000000000077f7b3056b50f0ad
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--00000000000077f7b3056b50f0ad--
