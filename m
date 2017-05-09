From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: lttng-ust traces are not generated
Date: Tue, 9 May 2017 17:35:13 +0000 (UTC)
Message-ID: <1221843436.175.1494351313670.JavaMail.zimbra__13719.5456926294$1494351333$gmane$org@efficios.com>
References: <52CDBD4F986AFC4CAEE1C14068436E7B94531026@EXCH-MB02-U1.nectechnologies.in>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7387243961508194830=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3wMmjS6f2VzrZh
 for <lttng-dev@lists.lttng.org>; Tue,  9 May 2017 17:35:24 +0000 (UTC)
In-Reply-To: <52CDBD4F986AFC4CAEE1C14068436E7B94531026@EXCH-MB02-U1.nectechnologies.in>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Swati J <Swati.J@nectechnologies.in>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============7387243961508194830==
Content-Type: multipart/alternative;
	boundary="=_e0a7ffc2-0a98-464a-8618-64a4a1373102"

--=_e0a7ffc2-0a98-464a-8618-64a4a1373102
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On May 9, 2017, at 5:45 AM, Swati J <Swati.J@nectechnologies.in> wrote: 

> Dear All,

> I am using lttng tool to generate userspace traces but the userspace traces are
> not getting generated .

> I have used the following commands:

> [root@pcmk1 ~]# lttng create

> Session auto-20170506-152941 created.

> Traces will be written in /root/lttng-traces/auto-20170506-152941

> [root@pcmk1 ~]# lttng enable-event --userspace --all All UST events are enabled
> in channel channel0

> [root@pcmk1 ~]# lttng start Tracing started for session auto-20170506-152941

> [root@pcmk1 ~]# systemctl start pcsd.service

> [root@pcmk1 ~]# lttng stop

> Waiting for data availability

> Tracing stopped for session auto-20170506-152941

> [root@pcmk1 ~]# lttng destroy

> Session auto-20170506-152941 destroyed

> I am not getting any error but also the file is not getting created

> I also tried to create userspace traces by logging-in via user rather than root
> but there is no difference .

> If anyone has any alternative approach or any suggestion please let me know .

Is the pcsd daemon instrumented (lttng-ust tracepoints added to its source code) ? 

You can use "lttng list -u" while the daemon runs to see if the tracepoints are visible. 

Thanks, 

Mathieu 

> Regards,

> Swati J

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_e0a7ffc2-0a98-464a-8618-64a4a1373102
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><style><!--

@font-face
=09{font-family:"Cambria Math";
=09panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
=09{font-family:Calibri;
=09panose-1:2 15 5 2 2 2 4 3 2 4;}

p.MsoNormal, li.MsoNormal, div.MsoNormal
=09{margin:0cm;
=09margin-bottom:.0001pt;
=09font-size:11.0pt;
=09font-family:"Calibri",sans-serif;
=09mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
=09{mso-style-priority:99;
=09color:#0563C1;
=09text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
=09{mso-style-priority:99;
=09color:#954F72;
=09text-decoration:underline;}
span.EmailStyle17
=09{mso-style-type:personal-compose;
=09font-family:"Calibri",sans-serif;
=09color:windowtext;}
.MsoChpDefault
=09{mso-style-type:export-only;
=09font-family:"Calibri",sans-serif;
=09mso-fareast-language:EN-US;}
@page WordSection1
=09{size:612.0pt 792.0pt;
=09margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
=09{page:WordSection1;}
--></style></div><div><span id=3D"zwchr" data-marker=3D"__DIVIDER__">----- =
On May 9, 2017, at 5:45 AM, Swati J &lt;Swati.J@nectechnologies.in&gt; wrot=
e:<br></span></div><div data-marker=3D"__QUOTED_TEXT__"><blockquote style=
=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#0=
00;font-weight:normal;font-style:normal;text-decoration:none;font-family:He=
lvetica,Arial,sans-serif;font-size:12pt;"><div class=3D"WordSection1"><p cl=
ass=3D"MsoNormal">Dear All, </p><p class=3D"MsoNormal">I am using lttng too=
l to generate userspace traces but the userspace traces are not getting gen=
erated .</p><p class=3D"MsoNormal">I have used the following commands:</p><=
p class=3D"MsoNormal">[root@pcmk1 ~]# lttng create</p><p class=3D"MsoNormal=
">Session auto-20170506-152941 created.</p><p class=3D"MsoNormal">Traces wi=
ll be written in /root/lttng-traces/auto-20170506-152941</p><p class=3D"Mso=
Normal">[root@pcmk1 ~]# lttng enable-event --userspace --all&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Al=
l UST events are enabled in channel channel0</p><p class=3D"MsoNormal">[roo=
t@pcmk1 ~]# lttng start&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Tracing started for session auto-201705=
06-152941</p><p class=3D"MsoNormal">[root@pcmk1 ~]# systemctl start pcsd.se=
rvice</p><p class=3D"MsoNormal">[root@pcmk1 ~]# lttng stop</p><p class=3D"M=
soNormal">Waiting for data availability</p><p class=3D"MsoNormal">Tracing s=
topped for session auto-20170506-152941</p><p class=3D"MsoNormal">[root@pcm=
k1 ~]# lttng destroy</p><p class=3D"MsoNormal">Session auto-20170506-152941=
 destroyed</p><p class=3D"MsoNormal">I am not getting any error but also th=
e file is not getting created
</p><p class=3D"MsoNormal">I also tried to create userspace traces by loggi=
ng-in via <b>
user</b> rather than root but there is no difference .</p><p class=3D"MsoNo=
rmal">If anyone has any alternative approach or any suggestion please let m=
e know .</p></div></blockquote><div>Is the pcsd daemon instrumented (lttng-=
ust tracepoints added to its source code) ?</div><div><br data-mce-bogus=3D=
"1"></div><div>You can use "lttng list -u" while the daemon runs to see if =
the tracepoints are visible.<br data-mce-bogus=3D"1"></div><div><br data-mc=
e-bogus=3D"1"></div><div>Thanks,<br data-mce-bogus=3D"1"></div><div><br dat=
a-mce-bogus=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1"></div><div><br=
 data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div><br da=
ta-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><blockquote st=
yle=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color=
:#000;font-weight:normal;font-style:normal;text-decoration:none;font-family=
:Helvetica,Arial,sans-serif;font-size:12pt;"><div class=3D"WordSection1"><p=
 class=3D"MsoNormal">Regards,</p><p class=3D"MsoNormal">Swati J </p></div><=
br>_______________________________________________<br>lttng-dev mailing lis=
t<br>lttng-dev@lists.lttng.org<br>https://lists.lttng.org/cgi-bin/mailman/l=
istinfo/lttng-dev<br></blockquote></div><div><br></div><div data-marker=3D"=
__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http:=
//www.efficios.com</div></div></body></html>
--=_e0a7ffc2-0a98-464a-8618-64a4a1373102--

--===============7387243961508194830==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============7387243961508194830==--
