From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: =?utf-8?b?562U5aSNOiDnrZTlpI06IGx0dG5nIGxpc3QgLXUg?=
 =?utf-8?q?coredump?=
Date: Tue, 22 Oct 2013 04:59:27 +0000 (UTC)
Message-ID: <917978419.47122.1382417967569.JavaMail.zimbra__30302.8987524614$1382418021$gmane$org@efficios.com>
References: <7f26c4b5-6de0-46b8-8752-7c40d01e9655@aliyun.com> <",
	20130913140919.GA20034"@Krystal,
	ac1f03bd-cb96-43b1-8567-98684ab82191@aliyun.com>
	<00f8295a-e65f-4d53-8722-3f7c42f4ddd8@aliyun.com> <",
	1307757412.43408.1382023623436.JavaMail.zimbra"@efficios.com>
	<f5e3b3cb-118a-48b8-8fd6-29d63ee36e85@aliyun.com> <",
	1005237918.46514.1382347246419.JavaMail.zimbra"@efficios.com>
	<436ff36d-c5ec-464f-9f32-32137898f61d@aliyun.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2121629515=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VYU44-0002O2-UP
	for lttng-dev@lists.lttng.org; Tue, 22 Oct 2013 00:59:37 -0400
In-Reply-To: <436ff36d-c5ec-464f-9f32-32137898f61d@aliyun.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============2121629515==
Content-Type: multipart/alternative;
	boundary="----=_Part_47121_1655483793.1382417967567"

------=_Part_47121_1655483793.1382417967567
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

----- Original Message -----

> From: "zhenyu.ren" <zhenyu.ren@aliyun.com>
> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>, "David Goulet"
> <dgoulet@efficios.com>
> Cc: "lttng-dev" <lttng-dev@lists.lttng.org>
> Sent: Tuesday, October 22, 2013 4:49:19 AM
> Subject: =E7=AD=94=E5=A4=8D: =E7=AD=94=E5=A4=8D: lttng list -u coredump

> > Therefore, the &(pos)->member !=3D NULL check will break out of the loo=
p
> > immediately,

> As you pointed out,pos is a very large pointer value(i.e
> 0xffffffffffffff88,say an invalid pointer) . Before check itself,
> &(pos)->member has been deferenced anyway.

Can you point out what in the C99 specification makes you believe that the =
pointer is actually dereferenced in the expression "&(pos)->member" ?=20

AFAIK, this only evaluates to the address of field "member" within "pos". T=
he compiler should not dereference the pointer "pos" at all.=20

I'm concerned that focusing on the hash table iteration might be leading us=
 in the wrong direction. What we see in the information you provided is a a=
n error detected by glibc "free()", which seems much more likely to point t=
o the culprit. However, we'd need more information about the symbols in thi=
s backtrace. Probably that getting it with a lttng-sessiond compiled with "=
-g -O0" (no optimisations, with debug symbols) would help us make more sens=
e out of the free() error output.=20

Thanks,=20

Mathieu=20

> > Please provide details about the lttng-tools, lttng-ust, lttng-modules,
> > userspace RCU versions you are using

> lttng-tools,lttng-ust and lttng-modules are 2.3.0,userspace RCU is 0.8.0

> thanks
> zhenyu.ren

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

------=_Part_47121_1655483793.1382417967567
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><hr id=3D"zwchr"><blockquote style=3D=
"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;=
font-weight:normal;font-style:normal;text-decoration:none;font-family:Helve=
tica,Arial,sans-serif;font-size:12pt;" data-mce-style=3D"border-left: 2px s=
olid #1010FF; margin-left: 5px; padding-left: 5px; color: #000; font-weight=
: normal; font-style: normal; text-decoration: none; font-family: Helvetica=
,Arial,sans-serif; font-size: 12pt;"><b>From: </b>"zhenyu.ren" &lt;zhenyu.r=
en@aliyun.com&gt;<br><b>To: </b>"Mathieu Desnoyers" &lt;mathieu.desnoyers@e=
fficios.com&gt;, "David Goulet" &lt;dgoulet@efficios.com&gt;<br><b>Cc: </b>=
"lttng-dev" &lt;lttng-dev@lists.lttng.org&gt;<br><b>Sent: </b>Tuesday, Octo=
ber 22, 2013 4:49:19 AM<br><b>Subject: </b>=E7=AD=94=E5=A4=8D: =E7=AD=94=E5=
=A4=8D: lttng list -u coredump<br><div><br></div><div class=3D"__aliyun_ema=
il_body_block"><div style=3D"" data-mce-style=3D""><br></div><div class=3D"=
__aliyun_signature_wrap">&gt;<span style=3D"font-family: 'times new roman',=
 'new york', times, serif; font-size: 16px; line-height: 24px; " data-mce-s=
tyle=3D"font-family: 'times new roman', 'new york', times, serif; font-size=
: 16px; line-height: 24px;">Therefore, the &amp;(pos)-&gt;member !=3D NULL =
check will break out of the loop immediately,</span><br><div><br></div></di=
v><div class=3D"__aliyun_signature_wrap">As you pointed out,pos is a very l=
arge pointer value(i.e <span style=3D"color: rgb(51, 51, 51); font-size: 13=
px; line-height: 19px; " data-mce-style=3D"color: #333333; font-size: 13px;=
 line-height: 19px;">&nbsp;0xffffffffffffff88,say</span>&nbsp;an invalid po=
inter) . Before check itself,&nbsp;<span style=3D"font-family: 'times new r=
oman', 'new york', times, serif; font-size: 16px; line-height: 24px; " data=
-mce-style=3D"font-family: 'times new roman', 'new york', times, serif; fon=
t-size: 16px; line-height: 24px;">&amp;(pos)-&gt;member has been deferenced=
 anyway.</span></div></div></blockquote><div>Can you point out what in the =
C99 specification makes you believe that the pointer is actually dereferenc=
ed in the expression "&amp;(pos)-&gt;member" ?<br></div><div><br></div><div=
>AFAIK, this only evaluates to the address of field "member" within "pos". =
The compiler should not dereference the pointer "pos" at all.<br></div><div=
><br></div><div>I'm concerned that focusing on the hash table iteration mig=
ht be leading us in the wrong direction. What we see in the information you=
 provided is a an error detected by glibc "free()", which seems much more l=
ikely to point to the culprit. However, we'd need more information about th=
e symbols in this backtrace. Probably that getting it with a lttng-sessiond=
 compiled with "-g -O0" (no optimisations, with debug symbols) would help u=
s make more sense out of the free() error output.<br></div><div><br></div><=
div>Thanks,<br></div><div><br></div><div>Mathieu<br></div><div><br></div><b=
lockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-le=
ft:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:none=
;font-family:Helvetica,Arial,sans-serif;font-size:12pt;" data-mce-style=3D"=
border-left: 2px solid #1010FF; margin-left: 5px; padding-left: 5px; color:=
 #000; font-weight: normal; font-style: normal; text-decoration: none; font=
-family: Helvetica,Arial,sans-serif; font-size: 12pt;"><div class=3D"__aliy=
un_email_body_block"><div class=3D"__aliyun_signature_wrap"><span style=3D"=
color: rgb(51, 51, 51); font-size: 13px; line-height: 19px; " data-mce-styl=
e=3D"color: #333333; font-size: 13px; line-height: 19px;"><br></span></div>=
<div class=3D"__aliyun_signature_wrap"><span style=3D"font-family: 'times n=
ew roman', 'new york', times, serif; font-size: 16px; line-height: 24px; " =
data-mce-style=3D"font-family: 'times new roman', 'new york', times, serif;=
 font-size: 16px; line-height: 24px;"><br></span></div><div class=3D"__aliy=
un_signature_wrap"><span style=3D"font-family: 'times new roman', 'new york=
', times, serif; font-size: 16px; line-height: 24px; " data-mce-style=3D"fo=
nt-family: 'times new roman', 'new york', times, serif; font-size: 16px; li=
ne-height: 24px;">&gt;<span style=3D"font-family: 'times new roman', 'new y=
ork', times, serif; font-size: 16px; line-height: 24px; " data-mce-style=3D=
"font-family: 'times new roman', 'new york', times, serif; font-size: 16px;=
 line-height: 24px;">Please provide details about the lttng-tools, lttng-us=
t, lttng-modules, userspace RCU versions you are using</span></span></div><=
div class=3D"__aliyun_signature_wrap"><span style=3D"font-family: 'times ne=
w roman', 'new york', times, serif; font-size: 16px; line-height: 24px; " d=
ata-mce-style=3D"font-family: 'times new roman', 'new york', times, serif; =
font-size: 16px; line-height: 24px;"><br></span></div><div class=3D"__aliyu=
n_signature_wrap"><span style=3D"font-family: 'times new roman', 'new york'=
, times, serif; font-size: 16px; line-height: 24px; " data-mce-style=3D"fon=
t-family: 'times new roman', 'new york', times, serif; font-size: 16px; lin=
e-height: 24px;">lttng-tools,lttng-ust and lttng-modules are 2.3.0,userspac=
e RCU is 0.8.0</span></div></div></blockquote><blockquote style=3D"border-l=
eft:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weig=
ht:normal;font-style:normal;text-decoration:none;font-family:Helvetica,Aria=
l,sans-serif;font-size:12pt;" data-mce-style=3D"border-left: 2px solid #101=
0FF; margin-left: 5px; padding-left: 5px; color: #000; font-weight: normal;=
 font-style: normal; text-decoration: none; font-family: Helvetica,Arial,sa=
ns-serif; font-size: 12pt;"><div class=3D"__aliyun_email_body_block"><div c=
lass=3D"__aliyun_signature_wrap"><span style=3D"font-family: 'times new rom=
an', 'new york', times, serif; font-size: 16px; line-height: 24px; " data-m=
ce-style=3D"font-family: 'times new roman', 'new york', times, serif; font-=
size: 16px; line-height: 24px;">thanks</span></div><div class=3D"__aliyun_s=
ignature_wrap"><span style=3D"font-family: 'times new roman', 'new york', t=
imes, serif; font-size: 16px; line-height: 24px; " data-mce-style=3D"font-f=
amily: 'times new roman', 'new york', times, serif; font-size: 16px; line-h=
eight: 24px;">zhenyu.ren</span></div><div class=3D"__aliyun_previous_quote"=
><div style=3D"font-family: times new roman , new york , times , serif;font=
-size: 12.0pt;color: #000000;" data-mce-style=3D"font-family: times new rom=
an , new york , times , serif; font-size: 12.0pt; color: #000000;"><div><br=
></div></div></div></div></blockquote><div><br><div><br></div></div><div><b=
r></div><div>-- <br></div><div><span name=3D"x"></span>Mathieu Desnoyers<br=
>EfficiOS Inc.<br>http://www.efficios.com<span name=3D"x"></span><br></div>=
</div></body></html>
------=_Part_47121_1655483793.1382417967567--


--===============2121629515==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2121629515==--
