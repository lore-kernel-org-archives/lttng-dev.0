From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: LTTng and Red Hat / CentOS RealTime Kernels
Date: Wed, 16 Nov 2016 22:27:11 +0000 (UTC)
Message-ID: <162450272.4446.1479335231606.JavaMail.zimbra__40997.6602918052$1479335193$gmane$org@efficios.com>
References: <9EF0E366B97A2444B715BD7861705886E293EE69@EX2010-CO-06.AERO.BALL.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6042767758709637107=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3tJzQm6VtlzlwY
 for <lttng-dev@lists.lttng.org>; Wed, 16 Nov 2016 22:27:28 +0000 (UTC)
In-Reply-To: <9EF0E366B97A2444B715BD7861705886E293EE69@EX2010-CO-06.AERO.BALL.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "Swartz, Shane" <sswartz@ball.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Daniel W Smith <dwsmith@ball.com>
List-Id: lttng-dev@lists.lttng.org

--===============6042767758709637107==
Content-Type: multipart/alternative;
	boundary="=_79dcaf89-ac58-4813-be5a-ad4d2af63fc2"

--=_79dcaf89-ac58-4813-be5a-ad4d2af63fc2
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Nov 15, 2016, at 11:52 PM, Swartz, Shane <sswartz@ball.com> wrote: 

> Is it possible to load the LTTng tools with a Red Hat or CentOS version 7 Real
> Time kernel? If yes, can it be done using the EfficiOS LTTng packages or only
> by building the packages from source code?

> Thanks.

Hi Shane, 

The LTTng kernel tracer works with a range of Preempt-RT kernel versions. 
It is tested in CI on the Preempt-RT kernel branches currently maintained 
by preempt-rt developers. However, it does not currently cover the 
3.8.13-rt27.34 kernel listed on the RHEL page, and the EfficiOS 
packages for RHEL do not currently target their Preempt-RT kernel. 

Thanks, 

Mathieu 

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_79dcaf89-ac58-4813-be5a-ad4d2af63fc2
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><style><!--

@font-face
=09{font-family:Calibri;
=09panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
=09{font-family:Tahoma;
=09panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
=09{font-family:Verdana;
=09panose-1:2 11 6 4 3 5 4 4 2 4;}

p.MsoNormal, li.MsoNormal, div.MsoNormal
=09{margin:0in;
=09margin-bottom:.0001pt;
=09font-size:11.0pt;
=09font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
=09{mso-style-priority:99;
=09color:blue;
=09text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
=09{mso-style-priority:99;
=09color:purple;
=09text-decoration:underline;}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
=09{mso-style-priority:99;
=09mso-style-link:"Balloon Text Char";
=09margin:0in;
=09margin-bottom:.0001pt;
=09font-size:8.0pt;
=09font-family:"Tahoma","sans-serif";}
span.EmailStyle17
=09{mso-style-type:personal-compose;
=09font-family:"Verdana","sans-serif";
=09color:windowtext;
=09font-weight:normal;
=09font-style:normal;
=09text-decoration:none none;}
span.BalloonTextChar
=09{mso-style-name:"Balloon Text Char";
=09mso-style-priority:99;
=09mso-style-link:"Balloon Text";
=09font-family:"Tahoma","sans-serif";}
.MsoChpDefault
=09{mso-style-type:export-only;
=09font-family:"Calibri","sans-serif";}
@page WordSection1
=09{size:8.5in 11.0in;
=09margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
=09{page:WordSection1;}
--></style></div><div><br></div><div><span id=3D"zwchr" data-marker=3D"__DI=
VIDER__">----- On Nov 15, 2016, at 11:52 PM, Swartz, Shane &lt;sswartz@ball=
.com&gt; wrote:<br></span></div><div data-marker=3D"__QUOTED_TEXT__"><block=
quote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5=
px;color:#000;font-weight:normal;font-style:normal;text-decoration:none;fon=
t-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div class=3D"WordSect=
ion1"><p class=3D"MsoNormal"><span style=3D"font-family:&quot;Verdana&quot;=
,&quot;sans-serif&quot;">Is it possible to load the LTTng tools with a Red =
Hat or CentOS version 7 Real Time kernel?&nbsp; If yes, can it be done usin=
g the EfficiOS LTTng packages or only by building the packages from
 source code?</span></p><p class=3D"MsoNormal"><span style=3D"font-family:&=
quot;Verdana&quot;,&quot;sans-serif&quot;">&nbsp;</span></p><p class=3D"Mso=
Normal"><span style=3D"font-family:&quot;Verdana&quot;,&quot;sans-serif&quo=
t;">Thanks.</span></p></div></blockquote><div><div>Hi Shane,<br></div><div>=
<br></div><div>The LTTng kernel tracer works with a range of Preempt-RT ker=
nel versions.</div><div>It is tested in CI on the Preempt-RT kernel branche=
s currently maintained</div><div>by preempt-rt developers. However, it does=
 not currently cover the</div><div>3.8.13-rt27.34 kernel listed on the RHEL=
 page, and the EfficiOS<br></div><div>packages for RHEL do not currently ta=
rget their Preempt-RT kernel.<br data-mce-bogus=3D"1"></div><div><br data-m=
ce-bogus=3D"1"></div>Thanks,<div><br></div><div>Mathieu</div></div><div><br=
 data-mce-bogus=3D"1"></div><br data-mce-bogus=3D"1"></div><div data-marker=
=3D"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>h=
ttp://www.efficios.com</div></div></body></html>
--=_79dcaf89-ac58-4813-be5a-ad4d2af63fc2--

--===============6042767758709637107==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============6042767758709637107==--
