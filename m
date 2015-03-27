From: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Subject: =?utf-8?b?562U5aSN77yaIGNsb2NrX2dldHRpbWUgdmRzbyBp?=
	=?utf-8?q?ssue?=
Date: Fri, 27 Mar 2015 08:57:43 +0800
Message-ID: <b11ab443-45d9-43ab-bde7-27524cf91b74__43143.3209371336$1427417953$gmane$org@aliyun.com>
References: <cf147ee4-5d02-423f-a352-672a739809d4@aliyun.com>
 <DUB123-W38081C479AED1FCAFCDED3DD080@phx.gbl>,
 1722941338.111044.1427387596544.JavaMail.zimbra@efficios.com
Reply-To: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2023309613=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtpcm9-320.freemail.mail.aliyun.com ([110.75.46.20])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <zhenyu.ren@aliyun.com>) id 1YbIb2-0007ZO-0b
 for lttng-dev@lists.lttng.org; Thu, 26 Mar 2015 20:58:02 -0400
In-Reply-To: 1722941338.111044.1427387596544.JavaMail.zimbra@efficios.com
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jesper Derehag <jderehag@hotmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============2023309613==
Content-Type: multipart/alternative;
  boundary="----=ALIBOUNDARY_19402_4c910940_5514ab07_1111"

------=ALIBOUNDARY_19402_4c910940_5514ab07_1111
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello=C2=A0 Are there any documents about what=C2=A0the clock override feature=
 is? It seems that the feature will hurt time resolution,doesn't it?In fact,I =
will try to get the symbol addr of =C2=A0__vdso_clock_gettime just like the sa=
me way glibc does with __vdso_gettimeofday.Is there any other cheaper way to c=
all=C2=A0  =C2=A0__vdso_clock_gettime=C2=A0=C2=A0?=0AThankszhenyu.ren=0A------=
------------------------------------------------------------=E5=8F=91=E4=BB=B6=
=E4=BA=BA=EF=BC=9AMathieu Desnoyers <mathieu.desnoyers@efficios.com>=E5=8F=91=E9=
=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2015=E5=B9=B43=E6=9C=8827=E6=97=A5(=E6=98=9F=E6=
=9C=9F=E4=BA=94) 00:33=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9AJesper Derehag <jder=
ehag@hotmail.com>=E6=8A=84=E3=80=80=E9=80=81=EF=BC=9Azhenyu.ren <zhenyu.ren@al=
iyun.com>=EF=BC=8Clttng-dev <lttng-dev@lists.lttng.org>=E4=B8=BB=E3=80=80=E9=A2=
=98=EF=BC=9ARe: [lttng-dev] clock_gettime vdso issue=0AYes, the clock override=
 feature, as well as the getcpu override,=0Ashould be merged within lttng-ust =
and lttng-tools master branches=0Athis week. Stay tuned!=0A=0AThanks,=0A=0AMat=
hieu=0A=0A----- Original Message -----=0A> There has been discussions regardin=
g adding capability to override the clock=0A> implementation.=0A> =0A> If that=
 support is arriving, you could always write your own (say a separate=0A> thre=
ad reading clock periodically and storing in a cache, then your own=0A> clock =
implementation could get that cached timestamp).=0A> Obviously you would need =
to think very carefully about clock resolution and=0A> frequency for your cloc=
k thread, but it should from a performance point of=0A> view be big improvemen=
t..=0A> =0A> Maybe Mathieu(?) could shed some light on the clock override?=0A>=
 =0A> /Jesper=0A> =0A> ________________________________=0A> > Date: Thu, 26 Ma=
r 2015 15:25:49 +0800=0A> > From: zhenyu.ren@aliyun.com=0A> > To: lttng-dev@li=
sts.lttng.org=0A> > Subject: [lttng-dev] clock_gettime vdso issue=0A> > =0A> >=
 =0A> > Hi,Team=0A> > =0A> > You may not feel how painful I am with a too old =
GLIBC which does=0A> > NOT support vdso clock_gettime. Especially in ust case,=
=0A> > trace_clock_read will call clock_gettime to record the time of every=0A=
> > event.=0A> > Does anyone know how to avoid system_call clock_gettime with =
this old=0A> > GLIBC??=0A> > =0A> > Thanks in advance=0A> > zhenyu.ren=0A> > =0A=
> > =0A> > _______________________________________________ lttng-dev mailing l=
ist=0A> > lttng-dev@lists.lttng.org=0A> > http://lists.lttng.org/cgi-bin/mailm=
an/listinfo/lttng-dev=0A>  		 	   		  =0A> ___________________________________=
____________=0A> lttng-dev mailing list=0A> lttng-dev@lists.lttng.org=0A> http=
://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev=0A> =0A=0A-- =0AMathieu =
Desnoyers=0AEfficiOS Inc.=0Ahttp://www.efficios.com
------=ALIBOUNDARY_19402_4c910940_5514ab07_1111
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div class=3D"__aliyun_email_body_block"><div style=3D"font-family:Tahoma,Aria=
l,STHeiti,SimSun;font-size:14px;color:#000000;">Hello</div><div style=3D"font-=
family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:#000000;"><br data-mce=
-bogus=3D"1"></div><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-=
size:14px;color:#000000;">&nbsp; Are there any documents about what&nbsp;<span=
 style=3D"color: rgb(0, 0, 0); font-family: Tahoma, Arial, STHeiti, SimSun; fo=
nt-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; =
letter-spacing: normal; line-height: 23px; orphans: auto; text-align: start; t=
ext-indent: 0px; text-transform: none; white-space: normal; widows: auto; word=
-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,=
 255); display: inline !important; float: none;">the clock override feature is=
? It seems that the feature will hurt time resolution,doesn't it?</span></div>=
<div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:#00=
0000;"><span style=3D"color: rgb(0, 0, 0); font-family: Tahoma, Arial, STHeiti=
, SimSun; font-size: 14px; font-style: normal; font-variant: normal; font-weig=
ht: normal; letter-spacing: normal; line-height: 23px; orphans: auto; text-ali=
gn: start; text-indent: 0px; text-transform: none; white-space: normal; widows=
: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: r=
gb(255, 255, 255); display: inline !important; float: none;">In fact,I will tr=
y to get the symbol addr of &nbsp;__vdso_clock_gettime just like the same way =
glibc does with __vdso_gettimeofday.</span></div><div style=3D"font-family:Tah=
oma,Arial,STHeiti,SimSun;font-size:14px;color:#000000;"><span style=3D"color: =
rgb(0, 0, 0); font-family: Tahoma, Arial, STHeiti, SimSun; font-size: 14px; fo=
nt-style: normal; font-variant: normal; font-weight: normal; letter-spacing: n=
ormal; line-height: 23px; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -w=
ebkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); display: i=
nline !important; float: none;">Is there any other cheaper way to call&nbsp;  =
<span style=3D"color: rgb(0, 0, 0); font-family: Tahoma, Arial, STHeiti, SimSu=
n; font-size: 14px; font-style: normal; font-variant: normal; font-weight: nor=
mal; letter-spacing: normal; line-height: 23px; orphans: auto; text-align: sta=
rt; text-indent: 0px; text-transform: none; white-space: normal; widows: auto;=
 word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255,=
 255, 255); display: inline !important; float: none;">&nbsp;__vdso_clock_getti=
me<span class=3D"Apple-converted-space">&nbsp;</span></span>&nbsp;?<span style=
=3D"color: rgb(0, 0, 0); font-family: Tahoma, Arial, STHeiti, SimSun; font-siz=
e: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter=
-spacing: normal; line-height: 23px; orphans: auto; text-align: start; text-in=
dent: 0px; text-transform: none; white-space: normal; widows: auto; word-spaci=
ng: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);=
 display: inline !important; float: none;"><span class=3D"Apple-converted-spac=
e"></span><br></span></span></div><div style=3D"font-family:Tahoma,Arial,STHei=
ti,SimSun;font-size:14px;color:#000000;"><span style=3D"color: rgb(0, 0, 0); f=
ont-family: Tahoma, Arial, STHeiti, SimSun; font-size: 14px; font-style: norma=
l; font-variant: normal; font-weight: normal; letter-spacing: normal; line-hei=
ght: 23px; orphans: auto; text-align: start; text-indent: 0px; text-transform:=
 none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stro=
ke-width: 0px; background-color: rgb(255, 255, 255); display: inline !importan=
t; float: none;"><br data-mce-bogus=3D"1"></span></div><div style=3D"font-fami=
ly:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:#000000;"><span style=3D"c=
olor: rgb(0, 0, 0); font-family: Tahoma, Arial, STHeiti, SimSun; font-size: 14=
px; font-style: normal; font-variant: normal; font-weight: normal; letter-spac=
ing: normal; line-height: 23px; orphans: auto; text-align: start; text-indent:=
 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0=
px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); disp=
lay: inline !important; float: none;">Thanks</span></div><div style=3D"font-fa=
mily:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:#000000;"><span style=3D=
"color: rgb(0, 0, 0); font-family: Tahoma, Arial, STHeiti, SimSun; font-size: =
14px; font-style: normal; font-variant: normal; font-weight: normal; letter-sp=
acing: normal; line-height: 23px; orphans: auto; text-align: start; text-inden=
t: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing:=
 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); di=
splay: inline !important; float: none;">zhenyu.ren</span></div><div class=3D"_=
_aliyun_signature_wrap"></div><div style=3D"font-family:Tahoma,Arial,STHeiti,S=
imSun;font-size:14px;color:#000000;"><br></div><blockquote style=3D"margin-rig=
ht:0;margin-top:0;margin-bottom:0"><div style=3D"font-family:Tahoma,Arial,STHe=
iti,SimSun;font-size:14px;color:#000000;">------------------------------------=
------------------------------</div><div style=3D"font-family:Tahoma,Arial,STH=
eiti,SimSun;font-size:14px;color:#000000;">=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A=
Mathieu Desnoyers &lt;mathieu.desnoyers@efficios.com&gt;</div><div style=3D"fo=
nt-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:#000000;">=E5=8F=91=
=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2015=E5=B9=B43=E6=9C=8827=E6=97=A5(=E6=98=9F=
=E6=9C=9F=E4=BA=94) 00:33</div><div style=3D"font-family:Tahoma,Arial,STHeiti,=
SimSun;font-size:14px;color:#000000;">=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9AJesp=
er Derehag &lt;jderehag@hotmail.com&gt;</div><div style=3D"font-family:Tahoma,=
Arial,STHeiti,SimSun;font-size:14px;color:#000000;">=E6=8A=84=E3=80=80=E9=80=81=
=EF=BC=9Azhenyu.ren &lt;zhenyu.ren@aliyun.com&gt;=EF=BC=8Clttng-dev &lt;lttng-=
dev@lists.lttng.org&gt;</div><div style=3D"font-family:Tahoma,Arial,STHeiti,Si=
mSun;font-size:14px;color:#000000;">=E4=B8=BB=E3=80=80=E9=A2=98=EF=BC=9ARe: [l=
ttng-dev] clock_gettime vdso issue</div><div style=3D"font-family:Tahoma,Arial=
,STHeiti,SimSun;font-size:14px;color:#000000;"><br></div>Yes, the clock overri=
de feature, as well as the getcpu override,<br>should be merged within lttng-u=
st and lttng-tools master branches<br>this week. Stay tuned!<br><br>Thanks,<br=
><br>Mathieu<br><br>----- Original Message -----<br>&gt; There has been discus=
sions regarding adding capability to override the clock<br>&gt; implementation=
.<br>&gt; <br>&gt; If that support is arriving, you could always write your ow=
n (say a separate<br>&gt; thread reading clock periodically and storing in a c=
ache, then your own<br>&gt; clock implementation could get that cached timesta=
mp).<br>&gt; Obviously you would need to think very carefully about clock reso=
lution and<br>&gt; frequency for your clock thread, but it should from a perfo=
rmance point of<br>&gt; view be big improvement..<br>&gt; <br>&gt; Maybe Mathi=
eu(?) could shed some light on the clock override?<br>&gt; <br>&gt; /Jesper<br=
>&gt; <br>&gt; ________________________________<br>&gt; &gt; Date: Thu, 26 Mar=
 2015 15:25:49 +0800<br>&gt; &gt; From: zhenyu.ren@aliyun.com<br>&gt; &gt; To:=
 lttng-dev@lists.lttng.org<br>&gt; &gt; Subject: [lttng-dev] clock_gettime vds=
o issue<br>&gt; &gt; <br>&gt; &gt; <br>&gt; &gt; Hi,Team<br>&gt; &gt; <br>&gt;=
 &gt; You may not feel how painful I am with a too old GLIBC which does<br>&gt=
; &gt; NOT support vdso clock_gettime. Especially in ust case,<br>&gt; &gt; tr=
ace_clock_read will call clock_gettime to record the time of every<br>&gt; &gt=
; event.<br>&gt; &gt; Does anyone know how to avoid system_call clock_gettime =
with this old<br>&gt; &gt; GLIBC??<br>&gt; &gt; <br>&gt; &gt; Thanks in advanc=
e<br>&gt; &gt; zhenyu.ren<br>&gt; &gt; <br>&gt; &gt; <br>&gt; &gt; ___________=
____________________________________ lttng-dev mailing list<br>&gt; &gt; lttng=
-dev@lists.lttng.org<br>&gt; &gt; http://lists.lttng.org/cgi-bin/mailman/listi=
nfo/lttng-dev<br>&gt;  		 	   		  <br>&gt; ___________________________________=
____________<br>&gt; lttng-dev mailing list<br>&gt; lttng-dev@lists.lttng.org<=
br>&gt; http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<br>&gt; <br>=
<br>-- <br>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com</bloc=
kquote></div>
------=ALIBOUNDARY_19402_4c910940_5514ab07_1111--



--===============2023309613==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2023309613==--
