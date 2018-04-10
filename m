From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Can liburcu protect multiple independent
	shared	resource?
Date: Tue, 10 Apr 2018 13:10:46 -0400 (EDT)
Message-ID: <1258050065.6838.1523380246038.JavaMail.zimbra__39781.8562727936$1523380142$gmane$org@efficios.com>
References: <HKNPR03MB2244D9D748447AAC392210ECF8BF0@HKNPR03MB2244.apcprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8242099298235512221=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 40LDG42bDPzxpd
 for <lttng-dev@lists.lttng.org>; Tue, 10 Apr 2018 13:10:52 -0400 (EDT)
In-Reply-To: <HKNPR03MB2244D9D748447AAC392210ECF8BF0@HKNPR03MB2244.apcprd03.prod.outlook.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: =?utf-8?B?5b+X5piMIOS9mQ==?= <yuzhichang_scl@hotmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============8242099298235512221==
Content-Type: multipart/alternative;
	boundary="=_0bcf9356-bdcf-4c97-a420-65d93490ebdc"

--=_0bcf9356-bdcf-4c97-a420-65d93490ebdc
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,=20

There is no "write_lock" in RCU per se. The update side uses a synchronize_=
rcu() instead.=20

Yes, there can be interference between multiple shared resources using the =
same liburcu=20
flavor. Very long read-side critical sections can delay completion of synch=
ronize_rcu.=20

I've done prototypes of liburcu flavors that have a "domain" structure, thu=
s allowing each=20
liburcu users to have their own grace period domain, but never had time to =
complete it and=20
get it upstream.=20

Thanks,=20

Mathieu=20

----- On Apr 9, 2018, at 2:32 AM, =E5=BF=97=E6=98=8C =E4=BD=99 <yuzhichang_=
scl@hotmail.com> wrote:=20

> According to [ https://github.com/urcu/userspace-rcu/blob/master/doc/rcu-=
api.md
> | https://github.com/urcu/userspace-rcu/blob/master/doc/rcu-api.md ] , no=
ne
> librcu API take the resource address.
> If there're multiple independent shared resource, seems there's i nterfer=
ence
> between read_lock of resource A and write_lock of resource B.

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

--=_0bcf9356-bdcf-4c97-a420-65d93490ebdc
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div>Hi,</div><div><br data-mce-bogus=3D"1"></di=
v><div>There is no "write_lock" in RCU per se. The update side uses a synch=
ronize_rcu() instead.<br></div><div><br data-mce-bogus=3D"1"></div><div>Yes=
, there can be interference between multiple shared resources using the sam=
e liburcu<br data-mce-bogus=3D"1"></div><div>flavor. Very long read-side cr=
itical sections can delay completion of synchronize_rcu.<br data-mce-bogus=
=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>I've done prototypes =
of liburcu flavors that have a "domain" structure, thus allowing each<br da=
ta-mce-bogus=3D"1"></div><div>liburcu users to have their own grace period =
domain, but never had time to complete it and<br data-mce-bogus=3D"1"></div=
><div>get it upstream.<br data-mce-bogus=3D"1"></div><div><br data-mce-bogu=
s=3D"1"></div><div>Thanks,<br data-mce-bogus=3D"1"></div><div><br data-mce-=
bogus=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1"></div><div><style st=
yle=3D"display:none;"> P {margin-top:0;margin-bottom:0;} </style></div><div=
><br></div><div><br></div><div><span id=3D"zwchr" data-marker=3D"__DIVIDER_=
_">----- On Apr 9, 2018, at 2:32 AM, =E5=BF=97=E6=98=8C =E4=BD=99 &lt;yuzhi=
chang_scl@hotmail.com&gt; wrote:<br></span></div><div data-marker=3D"__QUOT=
ED_TEXT__"><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5=
px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;text-de=
coration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;">


<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
According to&nbsp;<a href=3D"https://github.com/urcu/userspace-rcu/blob/mas=
ter/doc/rcu-api.md" id=3D"LPNoLP727713" target=3D"_blank">https://github.co=
m/urcu/userspace-rcu/blob/master/doc/rcu-api.md</a>, none&nbsp;librcu API t=
ake the resource address.&nbsp;</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
If there're&nbsp;<span style=3D"color: rgb(0, 0, 0); font-family: Calibri, =
Helvetica, sans-serif; font-size: 12pt;">multiple independent shared resour=
ce, seems there's i</span><span style=3D"color: rgb(0, 0, 0); font-family: =
Calibri, Helvetica, sans-serif; font-size: 12pt;">nterference
 between&nbsp;read_lock of&nbsp;</span><span style=3D"color: rgb(0, 0, 0); =
font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;">resource A a=
nd write_lock of resource B.</span></div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<span style=3D"color: rgb(0, 0, 0); font-family: Calibri, Helvetica, sans-s=
erif; font-size: 12pt;"><br>
</span></div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<br>


<br>_______________________________________________<br>lttng-dev mailing li=
st<br>lttng-dev@lists.lttng.org<br>https://lists.lttng.org/cgi-bin/mailman/=
listinfo/lttng-dev<br></blockquote></div><div><br></div><div data-marker=3D=
"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http=
://www.efficios.com</div></div></body></html>
--=_0bcf9356-bdcf-4c97-a420-65d93490ebdc--

--===============8242099298235512221==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============8242099298235512221==--
