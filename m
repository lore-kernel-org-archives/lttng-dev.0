From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: =?utf-8?b?562U5aSN77yaIGNsb2NrX2dldHRpbWUgdmRzbyBp?=
 =?utf-8?q?ssue?=
Date: Fri, 27 Mar 2015 19:57:18 +0000 (UTC)
Message-ID: <1504720278.125126.1427486238413.JavaMail.zimbra__28002.9394002215$1427486336$gmane$org@efficios.com>
References: <cf147ee4-5d02-423f-a352-672a739809d4@aliyun.com>
 <DUB123-W38081C479AED1FCAFCDED3DD080@phx.gbl> <",
 1722941338.111044.1427387596544.JavaMail.zimbra"@efficios.com>
 <b11ab443-45d9-43ab-bde7-27524cf91b74@aliyun.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1928269079=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1YbaNg-0005AG-9y
 for lttng-dev@lists.lttng.org; Fri, 27 Mar 2015 15:57:27 -0400
In-Reply-To: <b11ab443-45d9-43ab-bde7-27524cf91b74@aliyun.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1928269079==
Content-Type: multipart/alternative;
	boundary="----=_Part_125125_1754287363.1427486238412"

------=_Part_125125_1754287363.1427486238412
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The feature is really just that: a way to let users override the clock=20
source. Depending on the clock provided by the end user, it may or=20
may not hurt resolution.=20

The feature branches are here:=20

https://github.com/compudj/lttng-ust-dev/tree/clock-getcpu-plugin=20
https://github.com/compudj/lttng-tools-dev/tree/clock-plugin-ust=20

Thanks,=20

Mathieu=20

----- Original Message -----

> Hello

> Are there any documents about what the clock override feature is? It seem=
s
> that the feature will hurt time resolution,doesn't it?
> In fact,I will try to get the symbol addr of __vdso_clock_gettime just li=
ke
> the same way glibc does with __vdso_gettimeofday.
> Is there any other cheaper way to call __vdso_clock_gettime ?

> Thanks
> zhenyu.ren

> > ------------------------------------------------------------------
>=20
> > =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9AMathieu Desnoyers <mathieu.desnoyer=
s@efficios.com>
>=20
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2015=E5=B9=B43=E6=9C=8827=
=E6=97=A5(=E6=98=9F=E6=9C=9F=E4=BA=94) 00:33
>=20
> > =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9AJesper Derehag <jderehag@hotmail.co=
m>
>=20
> > =E6=8A=84 =E9=80=81=EF=BC=9Azhenyu.ren <zhenyu.ren@aliyun.com>=EF=BC=8C=
lttng-dev
> > <lttng-dev@lists.lttng.org>
>=20
> > =E4=B8=BB =E9=A2=98=EF=BC=9ARe: [lttng-dev] clock_gettime vdso issue
>=20

> > Yes, the clock override feature, as well as the getcpu override,
>=20
> > should be merged within lttng-ust and lttng-tools master branches
>=20
> > this week. Stay tuned!
>=20

> > Thanks,
>=20

> > Mathieu
>=20

> > ----- Original Message -----
>=20
> > > There has been discussions regarding adding capability to override th=
e
> > > clock
>=20
> > > implementation.
>=20
> > >
>=20
> > > If that support is arriving, you could always write your own (say a
> > > separate
>=20
> > > thread reading clock periodically and storing in a cache, then your o=
wn
>=20
> > > clock implementation could get that cached timestamp).
>=20
> > > Obviously you would need to think very carefully about clock resoluti=
on
> > > and
>=20
> > > frequency for your clock thread, but it should from a performance poi=
nt
> > > of
>=20
> > > view be big improvement..
>=20
> > >
>=20
> > > Maybe Mathieu(?) could shed some light on the clock override?
>=20
> > >
>=20
> > > /Jesper
>=20
> > >
>=20
> > > ________________________________
>=20
> > > > Date: Thu, 26 Mar 2015 15:25:49 +0800
>=20
> > > > From: zhenyu.ren@aliyun.com
>=20
> > > > To: lttng-dev@lists.lttng.org
>=20
> > > > Subject: [lttng-dev] clock_gettime vdso issue
>=20
> > > >
>=20
> > > >
>=20
> > > > Hi,Team
>=20
> > > >
>=20
> > > > You may not feel how painful I am with a too old GLIBC which does
>=20
> > > > NOT support vdso clock_gettime. Especially in ust case,
>=20
> > > > trace_clock_read will call clock_gettime to record the time of ever=
y
>=20
> > > > event.
>=20
> > > > Does anyone know how to avoid system_call clock_gettime with this o=
ld
>=20
> > > > GLIBC??
>=20
> > > >
>=20
> > > > Thanks in advance
>=20
> > > > zhenyu.ren
>=20
> > > >
>=20
> > > >
>=20
> > > > _______________________________________________ lttng-dev mailing l=
ist
>=20
> > > > lttng-dev@lists.lttng.org
>=20
> > > > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>=20
> > >
>=20
> > > _______________________________________________
>=20
> > > lttng-dev mailing list
>=20
> > > lttng-dev@lists.lttng.org
>=20
> > > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>=20
> > >
>=20

> > --
>=20
> > Mathieu Desnoyers
>=20
> > EfficiOS Inc.
>=20
> > http://www.efficios.com
>=20
--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

------=_Part_125125_1754287363.1427486238412
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><div>The feature is really just that:=
 a way to let users override the clock<br></div><div>source. Depending on t=
he clock provided by the end user, it may or<br></div><div>may not hurt res=
olution.<br></div><div><br></div><div>The feature branches are here:<br></d=
iv><div><br></div><div><a href=3D"https://github.com/compudj/lttng-ust-dev/=
tree/clock-getcpu-plugin">https://github.com/compudj/lttng-ust-dev/tree/clo=
ck-getcpu-plugin</a></div><div><a href=3D"https://github.com/compudj/lttng-=
tools-dev/tree/clock-plugin-ust">https://github.com/compudj/lttng-tools-dev=
/tree/clock-plugin-ust</a></div><div><br></div><div>Thanks,<br></div><div><=
br></div><div>Mathieu<br></div><div><br></div><div><br></div><hr id=3D"zwch=
r"><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;paddi=
ng-left:5px;color:#000;font-weight:normal;font-style:normal;text-decoration=
:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div class=3D=
"__aliyun_email_body_block"><div style=3D"font-family:Tahoma,Arial,STHeiti,=
SimSun;font-size:14px;color:#000000;">Hello</div><div style=3D"font-family:=
Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:#000000;"><br></div><div s=
tyle=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:#00000=
0;">&nbsp; Are there any documents about what&nbsp;<span style=3D"color: rg=
b(0, 0, 0); font-family: Tahoma, Arial, STHeiti, SimSun; font-size: 14px; f=
ont-style: normal; font-variant: normal; font-weight: normal; letter-spacin=
g: normal; line-height: 23px; orphans: auto; text-align: start; text-indent=
: 0px; text-transform: none; white-space: normal; widows: auto; word-spacin=
g: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255=
); display: inline !important; float: none;">the clock override feature is?=
 It seems that the feature will hurt time resolution,doesn't it?</span></di=
v><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;colo=
r:#000000;"><span style=3D"color: rgb(0, 0, 0); font-family: Tahoma, Arial,=
 STHeiti, SimSun; font-size: 14px; font-style: normal; font-variant: normal=
; font-weight: normal; letter-spacing: normal; line-height: 23px; orphans: =
auto; text-align: start; text-indent: 0px; text-transform: none; white-spac=
e: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;=
 background-color: rgb(255, 255, 255); display: inline !important; float: n=
one;">In fact,I will try to get the symbol addr of &nbsp;__vdso_clock_getti=
me just like the same way glibc does with __vdso_gettimeofday.</span></div>=
<div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:=
#000000;"><span style=3D"color: rgb(0, 0, 0); font-family: Tahoma, Arial, S=
THeiti, SimSun; font-size: 14px; font-style: normal; font-variant: normal; =
font-weight: normal; letter-spacing: normal; line-height: 23px; orphans: au=
to; text-align: start; text-indent: 0px; text-transform: none; white-space:=
 normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; b=
ackground-color: rgb(255, 255, 255); display: inline !important; float: non=
e;">Is there any other cheaper way to call&nbsp;  <span style=3D"color: rgb=
(0, 0, 0); font-family: Tahoma, Arial, STHeiti, SimSun; font-size: 14px; fo=
nt-style: normal; font-variant: normal; font-weight: normal; letter-spacing=
: normal; line-height: 23px; orphans: auto; text-align: start; text-indent:=
 0px; text-transform: none; white-space: normal; widows: auto; word-spacing=
: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255)=
; display: inline !important; float: none;">&nbsp;__vdso_clock_gettime<span=
 class=3D"Apple-converted-space">&nbsp;</span></span>&nbsp;?<span style=3D"=
color: rgb(0, 0, 0); font-family: Tahoma, Arial, STHeiti, SimSun; font-size=
: 14px; font-style: normal; font-variant: normal; font-weight: normal; lett=
er-spacing: normal; line-height: 23px; orphans: auto; text-align: start; te=
xt-indent: 0px; text-transform: none; white-space: normal; widows: auto; wo=
rd-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255,=
 255, 255); display: inline !important; float: none;"><span class=3D"Apple-=
converted-space"></span><br></span></span></div><div style=3D"font-family:T=
ahoma,Arial,STHeiti,SimSun;font-size:14px;color:#000000;"><span style=3D"co=
lor: rgb(0, 0, 0); font-family: Tahoma, Arial, STHeiti, SimSun; font-size: =
14px; font-style: normal; font-variant: normal; font-weight: normal; letter=
-spacing: normal; line-height: 23px; orphans: auto; text-align: start; text=
-indent: 0px; text-transform: none; white-space: normal; widows: auto; word=
-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 2=
55, 255); display: inline !important; float: none;"><br></span></div><div s=
tyle=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:#00000=
0;"><span style=3D"color: rgb(0, 0, 0); font-family: Tahoma, Arial, STHeiti=
, SimSun; font-size: 14px; font-style: normal; font-variant: normal; font-w=
eight: normal; letter-spacing: normal; line-height: 23px; orphans: auto; te=
xt-align: start; text-indent: 0px; text-transform: none; white-space: norma=
l; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; backgro=
und-color: rgb(255, 255, 255); display: inline !important; float: none;">Th=
anks</span></div><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font=
-size:14px;color:#000000;"><span style=3D"color: rgb(0, 0, 0); font-family:=
 Tahoma, Arial, STHeiti, SimSun; font-size: 14px; font-style: normal; font-=
variant: normal; font-weight: normal; letter-spacing: normal; line-height: =
23px; orphans: auto; text-align: start; text-indent: 0px; text-transform: n=
one; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-str=
oke-width: 0px; background-color: rgb(255, 255, 255); display: inline !impo=
rtant; float: none;">zhenyu.ren</span></div><div class=3D"__aliyun_signatur=
e_wrap"></div><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-si=
ze:14px;color:#000000;"><br></div><blockquote style=3D"margin-right:0;margi=
n-top:0;margin-bottom:0"><div style=3D"font-family:Tahoma,Arial,STHeiti,Sim=
Sun;font-size:14px;color:#000000;">----------------------------------------=
--------------------------</div><div style=3D"font-family:Tahoma,Arial,STHe=
iti,SimSun;font-size:14px;color:#000000;">=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=
=9AMathieu Desnoyers &lt;mathieu.desnoyers@efficios.com&gt;</div><div style=
=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:#000000;">=
=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2015=E5=B9=B43=E6=9C=8827=E6=
=97=A5(=E6=98=9F=E6=9C=9F=E4=BA=94) 00:33</div><div style=3D"font-family:Ta=
homa,Arial,STHeiti,SimSun;font-size:14px;color:#000000;">=E6=94=B6=E4=BB=B6=
=E4=BA=BA=EF=BC=9AJesper Derehag &lt;jderehag@hotmail.com&gt;</div><div sty=
le=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:#000000;=
">=E6=8A=84=E3=80=80=E9=80=81=EF=BC=9Azhenyu.ren &lt;zhenyu.ren@aliyun.com&=
gt;=EF=BC=8Clttng-dev &lt;lttng-dev@lists.lttng.org&gt;</div><div style=3D"=
font-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:#000000;">=E4=
=B8=BB=E3=80=80=E9=A2=98=EF=BC=9ARe: [lttng-dev] clock_gettime vdso issue</=
div><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;co=
lor:#000000;"><br></div>Yes, the clock override feature, as well as the get=
cpu override,<br>should be merged within lttng-ust and lttng-tools master b=
ranches<br>this week. Stay tuned!<br><div><br></div>Thanks,<br><div><br></d=
iv>Mathieu<br><div><br></div>----- Original Message -----<br>&gt; There has=
 been discussions regarding adding capability to override the clock<br>&gt;=
 implementation.<br>&gt; <br>&gt; If that support is arriving, you could al=
ways write your own (say a separate<br>&gt; thread reading clock periodical=
ly and storing in a cache, then your own<br>&gt; clock implementation could=
 get that cached timestamp).<br>&gt; Obviously you would need to think very=
 carefully about clock resolution and<br>&gt; frequency for your clock thre=
ad, but it should from a performance point of<br>&gt; view be big improveme=
nt..<br>&gt; <br>&gt; Maybe Mathieu(?) could shed some light on the clock o=
verride?<br>&gt; <br>&gt; /Jesper<br>&gt; <br>&gt; ________________________=
________<br>&gt; &gt; Date: Thu, 26 Mar 2015 15:25:49 +0800<br>&gt; &gt; Fr=
om: zhenyu.ren@aliyun.com<br>&gt; &gt; To: lttng-dev@lists.lttng.org<br>&gt=
; &gt; Subject: [lttng-dev] clock_gettime vdso issue<br>&gt; &gt; <br>&gt; =
&gt; <br>&gt; &gt; Hi,Team<br>&gt; &gt; <br>&gt; &gt; You may not feel how =
painful I am with a too old GLIBC which does<br>&gt; &gt; NOT support vdso =
clock_gettime. Especially in ust case,<br>&gt; &gt; trace_clock_read will c=
all clock_gettime to record the time of every<br>&gt; &gt; event.<br>&gt; &=
gt; Does anyone know how to avoid system_call clock_gettime with this old<b=
r>&gt; &gt; GLIBC??<br>&gt; &gt; <br>&gt; &gt; Thanks in advance<br>&gt; &g=
t; zhenyu.ren<br>&gt; &gt; <br>&gt; &gt; <br>&gt; &gt; ____________________=
___________________________ lttng-dev mailing list<br>&gt; &gt; lttng-dev@l=
ists.lttng.org<br>&gt; &gt; http://lists.lttng.org/cgi-bin/mailman/listinfo=
/lttng-dev<br>&gt;  =09=09 =09   =09=09  <br>&gt; _________________________=
______________________<br>&gt; lttng-dev mailing list<br>&gt; lttng-dev@lis=
ts.lttng.org<br>&gt; http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-=
dev<br>&gt; <br><div><br></div>-- <br>Mathieu Desnoyers<br>EfficiOS Inc.<br=
>http://www.efficios.com</blockquote></div></blockquote><div><br><div><br><=
/div></div><div><br></div><div>-- <br></div><div><span name=3D"x"></span>Ma=
thieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com<span name=3D"x"=
></span><br></div></div></body></html>
------=_Part_125125_1754287363.1427486238412--


--===============1928269079==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1928269079==--
