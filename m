From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Removing timing overhead with tracepoint() <--
 query dropped by mailing list
Date: Thu, 17 Nov 2016 20:47:30 +0000 (UTC)
Message-ID: <1384678026.6657.1479415650848.JavaMail.zimbra__35765.4133382768$1479415605$gmane$org@efficios.com>
References: <9EF0E366B97A2444B715BD7861705886E293EE69@EX2010-CO-06.AERO.BALL.com>
 <162450272.4446.1479335231606.JavaMail.zimbra@efficios.com>
 <9EF0E366B97A2444B715BD7861705886E2942E56@EX2010-CO-06.AERO.BALL.com>
 <1321420326.5617.1479399119390.JavaMail.zimbra@efficios.com>
 <1484074426.2165170.1479403261514@mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0855897121757721230=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3tKY9H07SYzmsF
 for <lttng-dev@lists.lttng.org>; Thu, 17 Nov 2016 20:47:46 +0000 (UTC)
In-Reply-To: <1484074426.2165170.1479403261514@mail.yahoo.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "Mark E. Dawson, Jr." <medawsonjr@yahoo.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0855897121757721230==
Content-Type: multipart/alternative;
	boundary="=_787e6e2b-015a-4b31-b37e-70c3df069d89"

--=_787e6e2b-015a-4b31-b37e-70c3df069d89
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Nov 17, 2016, at 12:21 PM, Mark E. Dawson, Jr. <medawsonjr@yahoo.com> wrote: 

> Mathieu,

> My query appears to be getting dropped by the mailing list, forcing me to ask
> you directly which I understand is both inefficient and a nuisance. We met when
> I spoke (along with Christoph Lameter) at the Tracing Summit a couple years
> back.

Hi Mark, 

Not sure why the mailing list would have dropped your email. Everything looks fine in the 
admin interface. Adding it in CC. (Michael, can you check if lttng-dev has issues with emails 
from yahoo domains ?) 

> Anyway, my question is as follows:

> If I want to remove a ton of compiled-in calls to an "rdtsc-based" C timing
> function and make them all conditionally-enabled based on whether or not I
> enable a tracing session, I can do so by adding the aforementioned "rdtsc" call
> as one of the arguments to tracepoint() along with our defined provider and
> event name, correct?

You can take a few approaches there: 

1) Use if (tracepoint_enabled()) { ..read tsc... do_tracepoint(...); } 

2) do this function call or static inline invocation as an argument of tracepoint(). 

3) do the function call/static inline invocation within the tracepoint probe provider 
(TRACEPOINT_EVENT() code). 

Let me know if I somehow misunderstood the intent of your question. 

Thanks, 

Mathieu 

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_787e6e2b-015a-4b31-b37e-70c3df069d89
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><style>#yiv8954750564 #yiv8954750564  _filt=
ered #yiv8954750564 {font-family:Calibri;panose-1:2 15 5 2 2 2 4 3 2 4;}
 _filtered #yiv8954750564 {font-family:Tahoma;panose-1:2 11 6 4 3 5 4 4 2 4=
;}
 _filtered #yiv8954750564 {font-family:Verdana;panose-1:2 11 6 4 3 5 4 4 2 =
4;}

#yiv8954750564 p.yiv8954750564MsoNormal, #yiv8954750564 li.yiv8954750564Mso=
Normal, #yiv8954750564 div.yiv8954750564MsoNormal
=09{margin:0in;margin-bottom:.0001pt;font-size:11.0pt;}
#yiv8954750564 a:link, #yiv8954750564 span.yiv8954750564MsoHyperlink
=09{color:blue;text-decoration:underline;}
#yiv8954750564 a:visited, #yiv8954750564 span.yiv8954750564MsoHyperlinkFoll=
owed
=09{color:purple;text-decoration:underline;}
#yiv8954750564 p.yiv8954750564MsoAcetate, #yiv8954750564 li.yiv8954750564Ms=
oAcetate, #yiv8954750564 div.yiv8954750564MsoAcetate
=09{margin:0in;margin-bottom:.0001pt;font-size:8.0pt;}
#yiv8954750564 span.yiv8954750564BalloonTextChar
=09{}
#yiv8954750564 span.yiv8954750564EmailStyle19
=09{color:windowtext;font-weight:normal;font-style:normal;text-decoration:n=
one none;}
#yiv8954750564 span.yiv8954750564EmailStyle20
=09{color:#1F497D;font-weight:normal;font-style:normal;text-decoration:none=
 none;}
#yiv8954750564 .yiv8954750564MsoChpDefault
=09{font-size:10.0pt;}
 _filtered #yiv8954750564 {margin:1.0in 1.0in 1.0in 1.0in;}
#yiv8954750564 div.yiv8954750564WordSection1
=09{}
#yiv8954750564 </style></div><div><br></div><div><br></div><div><span id=3D=
"zwchr" data-marker=3D"__DIVIDER__">----- On Nov 17, 2016, at 12:21 PM, Mar=
k E. Dawson, Jr. &lt;medawsonjr@yahoo.com&gt; wrote:<br></span></div><div d=
ata-marker=3D"__QUOTED_TEXT__"><blockquote style=3D"border-left:2px solid #=
1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-=
style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;fo=
nt-size:12pt;"><div style=3D"color:#000; background-color:#fff; font-family=
:HelveticaNeue, Helvetica Neue, Helvetica, Arial, Lucida Grande, sans-serif=
;font-size:16px"><div id=3D"yui_3_16_0_ym19_1_1479402851121_60364"><span>Ma=
thieu,</span></div><div id=3D"yui_3_16_0_ym19_1_1479402851121_60364"><span>=
<br></span></div><div id=3D"yui_3_16_0_ym19_1_1479402851121_60364"><span id=
=3D"yui_3_16_0_ym19_1_1479402851121_60485">My query appears to be getting d=
ropped by the mailing list, forcing me to ask you directly which I understa=
nd is both inefficient and a nuisance. We met when I spoke (along with Chri=
stoph Lameter) at the Tracing Summit a couple years back.</span></div></div=
></blockquote><div><br></div><div><div>Hi Mark,<br></div><div><br></div><di=
v>Not sure why the mailing list would have dropped your email. Everything l=
ooks fine in the</div><div>admin interface. Adding it in CC. (Michael, can =
you check if lttng-dev has issues with emails</div><div>from yahoo domains =
?)</div></div><blockquote style=3D"border-left:2px solid #1010FF;margin-lef=
t:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;text=
-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><d=
iv style=3D"color:#000; background-color:#fff; font-family:HelveticaNeue, H=
elvetica Neue, Helvetica, Arial, Lucida Grande, sans-serif;font-size:16px">=
<div id=3D"yui_3_16_0_ym19_1_1479402851121_60364"><span>Anyway, my question=
 is as follows:</span></div><div id=3D"yui_3_16_0_ym19_1_1479402851121_6036=
4"><span><br></span></div><div id=3D"yui_3_16_0_ym19_1_1479402851121_60364"=
 dir=3D"ltr">If I want to remove a ton of compiled-in calls to an "rdtsc-ba=
sed" C timing function and make them all conditionally-enabled based on whe=
ther or not I enable a tracing session, I can do so by adding the aforement=
ioned "rdtsc" call as one of the arguments to tracepoint() along with our d=
efined provider and event name, correct?</div></div></blockquote><br>You ca=
n take a few approaches there:<br><div><br data-mce-bogus=3D"1"></div><div>=
1) Use if (tracepoint_enabled()) { ..read tsc... do_tracepoint(...); }<br d=
ata-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>2) do th=
is function call or static inline invocation as an argument of tracepoint()=
.<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>3)=
 do the function call/static inline invocation within the tracepoint probe =
provider<br data-mce-bogus=3D"1"></div><div>&nbsp;&nbsp;&nbsp;&nbsp; (TRACE=
POINT_EVENT() code).<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=
=3D"1"></div><div>Let me know if I somehow misunderstood the intent of your=
 question.<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></di=
v><div>Thanks,<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1">=
</div><div>Mathieu</div></div><div data-marker=3D"__QUOTED_TEXT__"><br data=
-mce-bogus=3D"1"></div><div data-marker=3D"__SIG_POST__">-- <br></div><div>=
Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com</div></div></=
body></html>
--=_787e6e2b-015a-4b31-b37e-70c3df069d89--

--===============0855897121757721230==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============0855897121757721230==--
