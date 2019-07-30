From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re:
 =?utf-8?b?5Zue5aSNOlJlOiAg5Zue5aSNOlJlOiAgUHJvcyBh?=
 =?utf-8?q?nd_Cons_of_LTTng?=
Date: Tue, 30 Jul 2019 10:04:25 -0400 (EDT)
Message-ID: <690853193.4342.1564495465063.JavaMail.zimbra__2637.88181343756$1564495483$gmane$org@efficios.com>
References: <tencent_264479D416B7725164217DB5@qq.com>
 <438504875.11742.1564069712337.JavaMail.zimbra@efficios.com>
 <tencent_3F4BC66C590FBA9B49519E62@qq.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0806250067337943698=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 45ydbH0ptmz1JBx
 for <lttng-dev@lists.lttng.org>; Tue, 30 Jul 2019 10:04:26 -0400 (EDT)
In-Reply-To: <tencent_3F4BC66C590FBA9B49519E62@qq.com>
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

--===============0806250067337943698==
Content-Type: multipart/alternative;
	boundary="=_fe269bc2-a16a-42bb-a298-8ddba3423a05"

--=_fe269bc2-a16a-42bb-a298-8ddba3423a05
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,=20

The current LTTng kernel tracer (lttng-modules) supports Linux 3.0+ only.=
=20

If you only need to trace user-space, you might be able to use lttng-tools =
and lttng-ust=20
on an older kernel. Please refer to the README.md files of each project for=
 information=20
about their environment prerequisites.=20

The RHEL6 kernel variant based on 2.6.32-2.6.35 Linux kernels has never bee=
n supported by=20
the LTTng 2.x kernel tracers without kernel patching.=20

Thanks,=20

Mathieu=20

----- On Jul 29, 2019, at 8:34 PM, =E6=9D=A8=E6=B5=B7 <hai.yang@magic-shiel=
d.com> wrote:=20

> Hi Mathieu,
> Thanks. I am looking for packages for older distributions like CentOS 6 (=
with
> kernel 2.6) but could not find it. And which kernel version is minimum
> requirement for LTTng?

> Regards
> Hai

> ------------------ Original ------------------
> From: "Mathieu Desnoyers"<mathieu.desnoyers@efficios.com>;
> Date: Thu, Jul 25, 2019 11:48 PM
> To: "=E6=9D=A8=E6=B5=B7"<hai.yang@magic-shield.com>;
> Cc: "Jonathan Rajotte"<jonathan.rajotte-julien@efficios.com>;
> "lttng-dev"<lttng-dev@lists.lttng.org>;
> Subject: Re: [lttng-dev] =E5=9B=9E=E5=A4=8D:Re: =E5=9B=9E=E5=A4=8D:Re: Pr=
os and Cons of LTTng
> ----- On Jul 25, 2019, at 4:21 PM, =E6=9D=A8=E6=B5=B7 <hai.yang@magic-shi=
eld.com> wrote:

>> Hi

>> Thanks for quick response.
>> LTTng is really impressive on performance=EF=BC=8Cespecially under heavy=
 workload. When
>> using it on critical machines=EF=BC=8Cstability is also essential.
>> I wonder how LTTng is commercialized and any products or OS distribution=
s
>> already enabled it.
>> I took a look at lttng-modules bug list=EF=BC=8Cthere are a few kernel o=
ops years ago
>> and got resolved. May I say it is very stable or it has not been fully t=
ested?

> Hi,

> EfficiOS has had commercial customers using LTTng in production for many =
years
> now.
> LTTng per-se is distributed as packages in all major Linux distributions.
> EfficiOS also provides
> more up-to-date packages for some distributions through [
> http://packages.efficios.com/ | http://packages.efficios.com/ ]

> The way we commercialize LTTng is through funding for design and implemen=
tation
> of
> customer's feature requests. We also provide commercial support tailored =
to
> specific
> customer's environments, which includes SLA and continuous integration te=
sting
> of specific
> environments.

> If those are services you are interested in, please feel free to contact =
us in
> private so we
> can further discuss your needs.

> Best regards,

> Mathieu

>> regards
>> Hai

>> --------------=E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6--------------
>> =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A"Jonathan Rajotte-Julien "<jonathan.=
rajotte-julien@efficios.com>;
>> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2019=E5=B9=B47=E6=9C=8823=
=E6=97=A5(=E6=98=9F=E6=9C=9F=E4=BA=8C) =E4=B8=8A=E5=8D=886:20
>> =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9A"=E6=9D=A8=E6=B5=B7" <hai.yang@magic=
-shield.com>;
>> =E6=8A=84=E9=80=81=EF=BC=9A"lttng-dev "<lttng-dev@lists.lttng.org>;
>> =E4=B8=BB=E9=A2=98=EF=BC=9ARe: =E5=9B=9E=E5=A4=8D:Re: [lttng-dev] Pros a=
nd Cons of LTTng
>> -----------------------------------
>> Hi,

>>> As to LD_PRELOAD, it is also used for privilege escalation. Will it be =
regarded
>> > as vulnerability and forbidden on some Linux systems?

>> It could yes.
>> In that case you will be limited to the syscalls interface for the libc
>> observability unless you instrument it and distribute it.

>> Cheers.

>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

--=_fe269bc2-a16a-42bb-a298-8ddba3423a05
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div>Hi,<br></div><div><br data-mce-bogus=3D"1">=
</div><div>The current LTTng kernel tracer (lttng-modules) supports Linux 3=
.0+ only.<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div=
><div>If you only need to trace user-space, you might be able to use lttng-=
tools and lttng-ust<br data-mce-bogus=3D"1"></div><div>on an older kernel. =
Please refer to the README.md files of each project for information<br data=
-mce-bogus=3D"1"></div><div>about their environment prerequisites.<br data-=
mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>The RHEL6 ke=
rnel variant based on 2.6.32-2.6.35 Linux kernels has never been supported =
by<br data-mce-bogus=3D"1"></div><div>the LTTng 2.x kernel tracers without =
kernel patching.<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1=
"></div><div>Thanks,<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=
=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1"></div><div><br></div><div=
><span id=3D"zwchr" data-marker=3D"__DIVIDER__">----- On Jul 29, 2019, at 8=
:34 PM, =E6=9D=A8=E6=B5=B7 &lt;hai.yang@magic-shield.com&gt; wrote:<br></sp=
an></div><div data-marker=3D"__QUOTED_TEXT__"><blockquote style=3D"border-l=
eft:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weig=
ht:normal;font-style:normal;text-decoration:none;font-family:Helvetica,Aria=
l,sans-serif;font-size:12pt;"><span style=3D"display:!important;float:none;=
background-color:transparent;color:rgb( 0 , 0 , 0 );font-family:'arial' , '=
helvetica' , sans-serif;font-size:16px;font-style:normal;font-variant:norma=
l;font-weight:400;letter-spacing:normal;text-align:left;text-decoration:non=
e;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px">=
Hi Mathieu,</span><br><div>Thanks. I am looking for packages for older dist=
ributions like CentOS 6 (with kernel 2.6) but could not find it. And which =
kernel version is minimum requirement for LTTng?</div><br><div>Regards</div=
><div>Hai</div><br><div style=3D"color:#909090;font-family:'arial narrow';f=
ont-size:12px"><div><br><br></div></div><div><div style=3D"font:'verdana' n=
ormal 14px;color:#000"><div style=3D"font-size:12px;font-family:'arial narr=
ow';padding:2px 0 2px 0">------------------&nbsp;Original&nbsp;------------=
------</div><div style=3D"font-size:12px;background:#efefef;padding:8px"><d=
iv><b>From: </b>&nbsp;"Mathieu Desnoyers"&lt;mathieu.desnoyers@efficios.com=
&gt;;</div><div><b>Date: </b>&nbsp;Thu, Jul 25, 2019 11:48 PM</div><div><b>=
To: </b>&nbsp;"=E6=9D=A8=E6=B5=B7"&lt;hai.yang@magic-shield.com&gt;; </div>=
<div><b>Cc: </b>&nbsp;"Jonathan Rajotte"&lt;jonathan.rajotte-julien@efficio=
s.com&gt;; "lttng-dev"&lt;lttng-dev@lists.lttng.org&gt;; </div><div><b>Subj=
ect: </b>&nbsp;Re: [lttng-dev] =E5=9B=9E=E5=A4=8D:Re:  =E5=9B=9E=E5=A4=8D:R=
e:  Pros and Cons of LTTng</div></div><div>&nbsp;</div><div><div style=3D"f=
ont-family:'arial' , 'helvetica' , sans-serif;font-size:12pt;color:#000000"=
><div><span id=3D"zwchr">----- On Jul 25, 2019, at 4:21 PM, =E6=9D=A8=E6=B5=
=B7 &lt;hai.yang@magic-shield.com&gt; wrote:<br></span></div><div><blockquo=
te style=3D"border-left:2px solid #1010ff;margin-left:5px;padding-left:5px;=
color:#000;font-weight:normal;font-style:normal;text-decoration:none;font-f=
amily:'helvetica' , 'arial' , sans-serif;font-size:12pt"><div>Hi</div><br><=
div>Thanks for quick response. </div><div>LTTng is really impressive on per=
formance=EF=BC=8Cespecially under heavy workload. When using it on critical=
 machines=EF=BC=8Cstability is also essential. </div><div>I wonder how LTTn=
g is commercialized and any products or OS distributions already enabled it=
. </div><div>I took a look at lttng-modules bug list=EF=BC=8Cthere are a fe=
w kernel oops years ago and got resolved. May I say it is very stable or it=
 has not been fully tested? </div></blockquote><br><div>Hi,<br></div><br><d=
iv>EfficiOS has had commercial customers using LTTng in production for many=
 years now.</div><div>LTTng per-se is distributed as packages in all major =
Linux distributions. EfficiOS also provides<br></div><div>more up-to-date p=
ackages for some distributions through <a href=3D"http://packages.efficios.=
com/" target=3D"_blank" rel=3D"nofollow noopener noreferrer">http://package=
s.efficios.com/</a><br data-mce-bogus=3D"1"></div><br><div>The way we comme=
rcialize LTTng is through funding for design and implementation of</div><di=
v>customer's feature requests. We also provide commercial support tailored =
to specific</div><div>customer's environments, which includes SLA and conti=
nuous integration testing of specific</div><div>environments.<br></div><br>=
<div>If those are services you are interested in, please feel free to conta=
ct us in private so we</div><div>can further discuss your needs.<br></div><=
br><div>Best regards,<br></div><br><div>Mathieu</div><br><blockquote style=
=3D"border-left:2px solid #1010ff;margin-left:5px;padding-left:5px;color:#0=
00;font-weight:normal;font-style:normal;text-decoration:none;font-family:'h=
elvetica' , 'arial' , sans-serif;font-size:12pt"><br><div>regards</div><div=
>Hai<br><p><br><br></p><br><br>--------------=E5=8E=9F=E5=A7=8B=E9=82=AE=E4=
=BB=B6--------------<br>=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A"Jonathan Rajot=
te-Julien "&lt;jonathan.rajotte-julien@efficios.com&gt;;<br>=E5=8F=91=E9=80=
=81=E6=97=B6=E9=97=B4=EF=BC=9A2019=E5=B9=B47=E6=9C=8823=E6=97=A5(=E6=98=9F=
=E6=9C=9F=E4=BA=8C) =E4=B8=8A=E5=8D=886:20<br>=E6=94=B6=E4=BB=B6=E4=BA=BA=
=EF=BC=9A"=E6=9D=A8=E6=B5=B7" &lt;hai.yang@magic-shield.com&gt;;<br>=E6=8A=
=84=E9=80=81=EF=BC=9A"lttng-dev "&lt;lttng-dev@lists.lttng.org&gt;;<br>=E4=
=B8=BB=E9=A2=98=EF=BC=9ARe:  =E5=9B=9E=E5=A4=8D:Re: [lttng-dev] Pros and Co=
ns of LTTng<br>-----------------------------------<br></div> <div><div>Hi,<=
br><br>&gt; As to LD_PRELOAD, it is also used for privilege escalation. Wil=
l it be regarded as vulnerability and forbidden on some Linux systems?<br><=
br>It could yes.<br>In that case you will be limited to the syscalls interf=
ace for the libc<br>observability unless you instrument it and distribute i=
t.<br><br>Cheers.<br></div></div><br>______________________________________=
_________<br>lttng-dev mailing list<br>lttng-dev@lists.lttng.org<br>https:/=
/lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<br></blockquote></div><=
br><div>-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.=
efficios.com</div></div>
</div></div></div><br></blockquote></div><div><br></div><div data-marker=3D=
"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http=
://www.efficios.com</div></div></body></html>
--=_fe269bc2-a16a-42bb-a298-8ddba3423a05--

--===============0806250067337943698==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0806250067337943698==--
