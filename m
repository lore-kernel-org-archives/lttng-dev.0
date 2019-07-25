From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re:
 =?utf-8?b?5Zue5aSNOlJlOiAg5Zue5aSNOlJlOiAgUHJvcyBh?=
 =?utf-8?q?nd_Cons_of_LTTng?=
Date: Thu, 25 Jul 2019 11:48:32 -0400 (EDT)
Message-ID: <438504875.11742.1564069712337.JavaMail.zimbra__28558.2121390448$1564069732$gmane$org@efficios.com>
References: <tencent_264479D416B7725164217DB5@qq.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2730114321318119752=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 45vc7p0xWBz1HJW
 for <lttng-dev@lists.lttng.org>; Thu, 25 Jul 2019 11:48:38 -0400 (EDT)
In-Reply-To: <tencent_264479D416B7725164217DB5@qq.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: =?utf-8?B?5p2o5rW3?= <hai.yang@magic-shield.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============2730114321318119752==
Content-Type: multipart/alternative;
	boundary="=_815e93dd-d341-4a12-b7f1-29d99cfb2d63"

--=_815e93dd-d341-4a12-b7f1-29d99cfb2d63
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

----- On Jul 25, 2019, at 4:21 PM, =E6=9D=A8=E6=B5=B7 <hai.yang@magic-shiel=
d.com> wrote:=20

> Hi

> Thanks for quick response.
> LTTng is really impressive on performance=EF=BC=8Cespecially under heavy =
workload. When
> using it on critical machines=EF=BC=8Cstability is also essential.
> I wonder how LTTng is commercialized and any products or OS distributions
> already enabled it.
> I took a look at lttng-modules bug list=EF=BC=8Cthere are a few kernel oo=
ps years ago
> and got resolved. May I say it is very stable or it has not been fully te=
sted?

Hi,=20

EfficiOS has had commercial customers using LTTng in production for many ye=
ars now.=20
LTTng per-se is distributed as packages in all major Linux distributions. E=
fficiOS also provides=20
more up-to-date packages for some distributions through [ http://packages.e=
fficios.com/ | http://packages.efficios.com/ ]=20

The way we commercialize LTTng is through funding for design and implementa=
tion of=20
customer's feature requests. We also provide commercial support tailored to=
 specific=20
customer's environments, which includes SLA and continuous integration test=
ing of specific=20
environments.=20

If those are services you are interested in, please feel free to contact us=
 in private so we=20
can further discuss your needs.=20

Best regards,=20

Mathieu=20

> regards
> Hai

> --------------=E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6--------------
> =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A"Jonathan Rajotte-Julien "<jonathan.r=
ajotte-julien@efficios.com>;
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2019=E5=B9=B47=E6=9C=8823=E6=
=97=A5(=E6=98=9F=E6=9C=9F=E4=BA=8C) =E4=B8=8A=E5=8D=886:20
> =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9A"=E6=9D=A8=E6=B5=B7" <hai.yang@magic-=
shield.com>;
> =E6=8A=84=E9=80=81=EF=BC=9A"lttng-dev "<lttng-dev@lists.lttng.org>;
> =E4=B8=BB=E9=A2=98=EF=BC=9ARe: =E5=9B=9E=E5=A4=8D:Re: [lttng-dev] Pros an=
d Cons of LTTng
> -----------------------------------
> Hi,

>> As to LD_PRELOAD, it is also used for privilege escalation. Will it be r=
egarded
> > as vulnerability and forbidden on some Linux systems?

> It could yes.
> In that case you will be limited to the syscalls interface for the libc
> observability unless you instrument it and distribute it.

> Cheers.

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

--=_815e93dd-d341-4a12-b7f1-29d99cfb2d63
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><span id=3D"zwchr" data-marker=3D"__DIVIDER=
__">----- On Jul 25, 2019, at 4:21 PM, =E6=9D=A8=E6=B5=B7 &lt;hai.yang@magi=
c-shield.com&gt; wrote:<br></span></div><div data-marker=3D"__QUOTED_TEXT__=
"><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;paddin=
g-left:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:=
none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div>Hi</div><=
br><div>Thanks for quick response.&nbsp;</div><div>LTTng is really impressi=
ve on performance=EF=BC=8Cespecially under heavy workload. When using it on=
 critical machines=EF=BC=8Cstability is also essential.&nbsp;</div><div>I w=
onder how LTTng is commercialized and any products or OS distributions alre=
ady enabled it.&nbsp;</div><div>I took a look at lttng-modules bug list=EF=
=BC=8Cthere are a few kernel oops years ago and got resolved. May I say it =
is very stable or it has not been fully tested?&nbsp;</div></blockquote><di=
v><br></div><div>Hi,<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=
=3D"1"></div><div>EfficiOS has had commercial customers using LTTng in prod=
uction for many years now.</div><div>LTTng per-se is distributed as package=
s in all major Linux distributions. EfficiOS also provides<br data-mce-bogu=
s=3D"1"></div><div>more up-to-date packages for some distributions through =
<a href=3D"http://packages.efficios.com/">http://packages.efficios.com/</a>=
</div><div><br data-mce-bogus=3D"1"></div><div>The way we commercialize LTT=
ng is through funding for design and implementation of</div><div>customer's=
 feature requests. We also provide commercial support tailored to specific<=
/div><div>customer's environments, which includes SLA and continuous integr=
ation testing of specific</div><div>environments.<br data-mce-bogus=3D"1"><=
/div><div><br data-mce-bogus=3D"1"></div><div>If those are services you are=
 interested in, please feel free to contact us in private so we</div><div>c=
an further discuss your needs.<br data-mce-bogus=3D"1"></div><div><br data-=
mce-bogus=3D"1"></div><div>Best regards,<br data-mce-bogus=3D"1"></div><div=
><br data-mce-bogus=3D"1"></div><div>Mathieu</div><div><br data-mce-bogus=
=3D"1"></div><blockquote style=3D"border-left:2px solid #1010FF;margin-left=
:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;text-=
decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><br=
><div>regards</div><div>Hai<br><p><br><br></p><br><br>--------------=E5=8E=
=9F=E5=A7=8B=E9=82=AE=E4=BB=B6--------------<br>=E5=8F=91=E4=BB=B6=E4=BA=BA=
=EF=BC=9A"Jonathan Rajotte-Julien "&lt;jonathan.rajotte-julien@efficios.com=
&gt;;<br>=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2019=E5=B9=B47=E6=9C=
=8823=E6=97=A5(=E6=98=9F=E6=9C=9F=E4=BA=8C) =E4=B8=8A=E5=8D=886:20<br>=E6=
=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9A"=E6=9D=A8=E6=B5=B7" &lt;hai.yang@magic-sh=
ield.com&gt;;<br>=E6=8A=84=E9=80=81=EF=BC=9A"lttng-dev "&lt;lttng-dev@lists=
.lttng.org&gt;;<br>=E4=B8=BB=E9=A2=98=EF=BC=9ARe:  =E5=9B=9E=E5=A4=8D:Re: [=
lttng-dev] Pros and Cons of LTTng<br>-----------------------------------<br=
></div> <div><div>Hi,<br><br>&gt; As to LD_PRELOAD, it is also used for pri=
vilege escalation. Will it be regarded as vulnerability and forbidden on so=
me Linux systems?<br><br>It could yes.<br>In that case you will be limited =
to the syscalls interface for the libc<br>observability unless you instrume=
nt it and distribute it.<br><br>Cheers.<br></div></div><br>________________=
_______________________________<br>lttng-dev mailing list<br>lttng-dev@list=
s.lttng.org<br>https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<b=
r></blockquote></div><div><br></div><div data-marker=3D"__SIG_POST__">-- <b=
r></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com<=
/div></div></body></html>
--=_815e93dd-d341-4a12-b7f1-29d99cfb2d63--

--===============2730114321318119752==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2730114321318119752==--
