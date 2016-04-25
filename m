From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: lttng index file not closed when rotating
Date: Mon, 25 Apr 2016 14:02:26 +0000 (UTC)
Message-ID: <869587750.68555.1461592946295.JavaMail.zimbra__36222.0508665361$1461592987$gmane$org@efficios.com>
References: <a055198e-ed92-47e5-9d29-68abc982e608.zhenyu.ren@aliyun.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2640268379144591502=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id BE30EA32BD
 for <lttng-dev@lists.lttng.org>; Mon, 25 Apr 2016 14:02:33 +0000 (UTC)
In-Reply-To: <a055198e-ed92-47e5-9d29-68abc982e608.zhenyu.ren@aliyun.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============2640268379144591502==
Content-Type: multipart/alternative;
	boundary="----=_Part_68554_1477760260.1461592946295"

------=_Part_68554_1477760260.1461592946295
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Apr 25, 2016, at 5:10 AM, zhenyu.ren <zhenyu.ren@aliyun.com> wrote: 

> Hi,Dev

> I am using lttng-tools 2.6.0 , it seems that lttng-consumerd does not close old
> index file when rotating to a new one.

> lsof -p $lttng-consumerd |wc -l showes file number is keeping increased...

> Does anyone know this bug?

Hi, 

LTTng 2.6.0 is not supported anymore. Please upgrade to 2.7.x, or at the very least 
try LTTng tools 2.6.2 (which is not officially maintained anymore, but could help solving 
your issue). 

Thanks, 

Mathieu 

> Thanks
> zhenyu.ren

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_68554_1477760260.1461592946295
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><span id=3D"zwchr" data-marker=3D"__DIVIDER=
__">----- On Apr 25, 2016, at 5:10 AM, zhenyu.ren &lt;zhenyu.ren@aliyun.com=
&gt; wrote:<br></span></div><div data-marker=3D"__QUOTED_TEXT__"><blockquot=
e style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;c=
olor:#000;font-weight:normal;font-style:normal;text-decoration:none;font-fa=
mily:Helvetica,Arial,sans-serif;font-size:12pt;"><div class=3D"__aliyun_ema=
il_body_block"><div style=3D"clear: both;"><span style=3D"font-family: Taho=
ma,Arial,STHeiti,SimSun; font-size: 14px; color: rgb(0, 0, 0);">Hi,Dev</spa=
n></div><div style=3D"clear: both;"><span style=3D"font-family: Tahoma,Aria=
l,STHeiti,SimSun; font-size: 14px; color: rgb(0, 0, 0);"><br></span></div><=
div style=3D"clear: both;"><span style=3D"font-family: Tahoma,Arial,STHeiti=
,SimSun; font-size: 14px; color: rgb(0, 0, 0);">&nbsp;&nbsp; I am using ltt=
ng-tools 2.6.0 , it seems that lttng-consumerd does not close old index fil=
e when rotating to a new one. </span></div><div style=3D"clear: both;"><spa=
n style=3D"font-family: Tahoma,Arial,STHeiti,SimSun; font-size: 14px; color=
: rgb(0, 0, 0);"><br></span></div><div style=3D"clear: both;"><span style=
=3D"font-family: Tahoma,Arial,STHeiti,SimSun; font-size: 14px; color: rgb(0=
, 0, 0);">&nbsp;&nbsp; lsof -p $lttng-consumerd |wc -l&nbsp; showes file nu=
mber is keeping increased... </span></div><div style=3D"clear: both;"><span=
 style=3D"font-family: Tahoma,Arial,STHeiti,SimSun; font-size: 14px; color:=
 rgb(0, 0, 0);"><br></span></div><div style=3D"clear: both;"><span style=3D=
"font-family: Tahoma,Arial,STHeiti,SimSun; font-size: 14px; color: rgb(0, 0=
, 0);">&nbsp;&nbsp; Does anyone know this bug?</span></div></div></blockquo=
te><div><br></div><div><div>Hi,<br></div><div><br></div><div>LTTng 2.6.0 is=
 not supported anymore. Please upgrade to 2.7.x, or at the very least</div>=
<div>try LTTng tools 2.6.2 (which is not officially maintained anymore, but=
 could help solving</div><div>your issue).</div><div><br></div><div>Thanks,=
</div><div><br></div><div>Mathieu</div></div><div><br data-mce-bogus=3D"1">=
</div><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;pa=
dding-left:5px;color:#000;font-weight:normal;font-style:normal;text-decorat=
ion:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div class=
=3D"__aliyun_email_body_block"><div style=3D"clear: both;"><span style=3D"f=
ont-family: Tahoma,Arial,STHeiti,SimSun; font-size: 14px; color: rgb(0, 0, =
0);"><br></span></div><div style=3D"clear: both;"><span style=3D"font-famil=
y: Tahoma,Arial,STHeiti,SimSun; font-size: 14px; color: rgb(0, 0, 0);">Than=
ks</span></div><div style=3D"clear: both;"><span style=3D"font-family: Taho=
ma,Arial,STHeiti,SimSun; font-size: 14px; color: rgb(0, 0, 0);">zhenyu.ren<=
br></span></div></div><br>_______________________________________________<b=
r>lttng-dev mailing list<br>lttng-dev@lists.lttng.org<br>https://lists.lttn=
g.org/cgi-bin/mailman/listinfo/lttng-dev<br></blockquote></div><div><br></d=
iv><div data-marker=3D"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br=
>EfficiOS Inc.<br>http://www.efficios.com</div></div></body></html>
------=_Part_68554_1477760260.1461592946295--

--===============2640268379144591502==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============2640268379144591502==--
