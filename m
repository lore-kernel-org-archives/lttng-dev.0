From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Can TP_ARGS contain more than 10 elements?
Date: Tue, 24 Nov 2015 12:15:34 +0000 (UTC)
Message-ID: <665263955.148558.1448367334580.JavaMail.zimbra__41586.9305063554$1448367420$gmane$org@efficios.com>
References: <169a15b5-94ec-4014-b435-f6ca95532412.zhenyu.ren@aliyun.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0289352296=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1a1CVi-0004ol-JA
 for lttng-dev@lists.lttng.org; Tue, 24 Nov 2015 07:15:55 -0500
In-Reply-To: <169a15b5-94ec-4014-b435-f6ca95532412.zhenyu.ren@aliyun.com>
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

--===============0289352296==
Content-Type: multipart/alternative;
	boundary="----=_Part_148557_564474060.1448367334580"

------=_Part_148557_564474060.1448367334580
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Nov 24, 2015, at 1:23 AM, zhenyu.ren <zhenyu.ren@aliyun.com> wrote: 

> Hi,

> From man lttng-ust, I get "TP_ARGS macro contains the arguments passed for the
> tracepoint it is in the following format TP_ARGS(type1, name1, type2, name2,
> ... type10, name10) where there can be from zero to ten elements"

> Does anyone know is it possible to contain more than 10 elements in one TP_ARGS?
> If so ,how to do that ?

No, it is not possible. You may want to pass a structure instead. 

Thanks, 

Mathieu 

> Thanks in advance
> zhenyu.ren

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_148557_564474060.1448367334580
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><br></div><span id=3D"zwchr" data-marker=3D=
"__DIVIDER__">----- On Nov 24, 2015, at 1:23 AM, zhenyu.ren &lt;zhenyu.ren@=
aliyun.com&gt; wrote:<br></span><div data-marker=3D"__QUOTED_TEXT__"><block=
quote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5=
px;color:#000;font-weight:normal;font-style:normal;text-decoration:none;fon=
t-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div class=3D"__aliyun=
_email_body_block"><div style=3D"clear: both;"><span style=3D"font-family: =
Tahoma, Arial, STHeiti, SimSun; font-size: 14px; color: rgb(0, 0, 0);">Hi,<=
/span></div><div style=3D"clear: both;"><span style=3D"font-family: Tahoma,=
 Arial, STHeiti, SimSun; font-size: 14px; color: rgb(0, 0, 0);"><br></span>=
</div><div style=3D"clear: both;"><span style=3D"font-family: Tahoma, Arial=
, STHeiti, SimSun; font-size: 14px; color: rgb(0, 0, 0);">&nbsp; &nbsp;From=
 man lttng-ust, I get "TP_ARGS&nbsp;macro&nbsp;contains&nbsp;the&nbsp;argum=
ents&nbsp;passed&nbsp;for&nbsp;the&nbsp;tracepoint&nbsp;it&nbsp;is&nbsp;in&=
nbsp;the&nbsp;following&nbsp;format&nbsp;TP_ARGS(type1,&nbsp;name1,&nbsp;ty=
pe2,&nbsp;name2,&nbsp;...&nbsp;type10,&nbsp;name10)&nbsp;where&nbsp;there&n=
bsp;can&nbsp;be&nbsp;from&nbsp;zero&nbsp;to&nbsp;ten&nbsp;elements"</span><=
/div><div style=3D"clear: both;"><span style=3D"font-family: Tahoma, Arial,=
 STHeiti, SimSun; font-size: 14px; color: rgb(0, 0, 0);"><br></span></div><=
div style=3D"clear: both;"><span style=3D"font-family: Tahoma, Arial, STHei=
ti, SimSun; font-size: 14px; color: rgb(0, 0, 0);">&nbsp; Does anyone know =
is it possible to contain more than 10 elements in one TP_ARGS? If so ,how =
to do that ?</span></div></div></blockquote><div><br></div><div>No, it is n=
ot possible. You may want to pass a structure instead.<br data-mce-bogus=3D=
"1"></div><div><br data-mce-bogus=3D"1"></div><div>Thanks,<br data-mce-bogu=
s=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Mathieu<br data-mce-=
bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><blockquote style=3D"=
border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;f=
ont-weight:normal;font-style:normal;text-decoration:none;font-family:Helvet=
ica,Arial,sans-serif;font-size:12pt;"><div class=3D"__aliyun_email_body_blo=
ck"><div style=3D"clear: both;"><span style=3D"font-family: Tahoma, Arial, =
STHeiti, SimSun; font-size: 14px; color: rgb(0, 0, 0);"><br></span></div><d=
iv style=3D"clear: both;"><span style=3D"font-family: Tahoma, Arial, STHeit=
i, SimSun; font-size: 14px; color: rgb(0, 0, 0);">Thanks in advance</span><=
/div><div style=3D"clear: both;"><span style=3D"font-family: Tahoma, Arial,=
 STHeiti, SimSun; font-size: 14px; color: rgb(0, 0, 0);">zhenyu.ren</span><=
/div></div><br>_______________________________________________<br>lttng-dev=
 mailing list<br>lttng-dev@lists.lttng.org<br>http://lists.lttng.org/cgi-bi=
n/mailman/listinfo/lttng-dev<br></blockquote></div><br><div data-marker=3D"=
__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http:=
//www.efficios.com</div></div></body></html>
------=_Part_148557_564474060.1448367334580--


--===============0289352296==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0289352296==--
