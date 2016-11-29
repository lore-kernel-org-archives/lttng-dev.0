From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: CTF parser library or plugin location?
Date: Tue, 29 Nov 2016 01:21:02 +0000 (UTC)
Message-ID: <1730636642.18966.1480382462061.JavaMail.zimbra__16089.6961497658$1480382394$gmane$org@efficios.com>
References: <CAAuy2ASOUuJn2tAiV1vWNU2E9vZAFJcPiSsdNjsJ97F8uJYaSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1988024795475961427=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3tSQjp3KD4zmZZ
 for <lttng-dev@lists.lttng.org>; Tue, 29 Nov 2016 01:21:18 +0000 (UTC)
In-Reply-To: <CAAuy2ASOUuJn2tAiV1vWNU2E9vZAFJcPiSsdNjsJ97F8uJYaSA@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Ebelechukwu Nwafor <ebelechukwu.nwafor@bison.howard.edu>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1988024795475961427==
Content-Type: multipart/alternative;
	boundary="=_2abac69e-6c84-440a-b974-484f29547d8d"

--=_2abac69e-6c84-440a-b974-484f29547d8d
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Nov 28, 2016, at 7:59 PM, Ebelechukwu Nwafor <ebelechukwu.nwafor@bison.howard.edu> wrote: 

> Hello All.
> I am new to lttng and linux tracing. I was trying to download the linux update
> plugin so i can use the CTF parser to read events. I followed instructions on
> the eclipse documentation located at:

> [
> http://help.eclipse.org/luna/index.jsp?topic=%2Forg.eclipse.linuxtools.lttng.help%2Fdoc%2FInstallation.html
> |
> http://help.eclipse.org/luna/index.jsp?topic=%2Forg.eclipse.linuxtools.lttng.help%2Fdoc%2FInstallation.html
> ]

> The CTF parser and LTTNG tracing toolkit does not seem to be included in the
> Linux tools plugin anymore. Does anyone know how i could get the library for
> CTF parsing or possibly plugin location?

Hi, 

This is now under its own Eclipse project: http://tracecompass.org/ 
You can use it either as a stand alone app, or as an eclipse plugin (see http://tracecompass.org/download.html). 

Thanks, 

Mathieu 

> Best Regards.

> --
> Ebelechukwu Nwafor,
> Graduate Student,
> Howard University.

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_2abac69e-6c84-440a-b974-484f29547d8d
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><br></div><div><span id=3D"zwchr" data-mark=
er=3D"__DIVIDER__">----- On Nov 28, 2016, at 7:59 PM, Ebelechukwu Nwafor &l=
t;ebelechukwu.nwafor@bison.howard.edu&gt; wrote:<br></span></div><div data-=
marker=3D"__QUOTED_TEXT__"><blockquote style=3D"border-left:2px solid #1010=
FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-styl=
e:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-s=
ize:12pt;"><div dir=3D"ltr">Hello All.<br><div>I am new to lttng and linux =
tracing. I was trying to download the linux update plugin so i can use the =
CTF parser to read events. I followed instructions on the eclipse documenta=
tion located at:&nbsp;</div><br><div><a href=3D"http://help.eclipse.org/lun=
a/index.jsp?topic=3D%2Forg.eclipse.linuxtools.lttng.help%2Fdoc%2FInstallati=
on.html" target=3D"_blank">http://help.eclipse.org/luna/index.jsp?topic=3D%=
2Forg.eclipse.linuxtools.lttng.help%2Fdoc%2FInstallation.html</a><br data-m=
ce-bogus=3D"1"></div><br><div> The CTF parser and LTTNG tracing toolkit doe=
s not seem to be included in the Linux tools plugin anymore. Does anyone kn=
ow how i could get the library for CTF parsing or possibly plugin location?=
</div><br></div></blockquote><div><br></div><div>Hi,<br data-mce-bogus=3D"1=
"></div><div><br data-mce-bogus=3D"1"></div><div>This is now under its own =
Eclipse project: http://tracecompass.org/<br data-mce-bogus=3D"1"></div><di=
v>You can use it either as a stand alone app, or as an eclipse plugin (see =
http://tracecompass.org/download.html).<br data-mce-bogus=3D"1"></div><div>=
<br data-mce-bogus=3D"1"></div><div>Thanks,<br data-mce-bogus=3D"1"></div><=
div><br data-mce-bogus=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1"></d=
iv><div><br data-mce-bogus=3D"1"></div><blockquote style=3D"border-left:2px=
 solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:norm=
al;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-=
serif;font-size:12pt;"><div dir=3D"ltr"><br><div>Best Regards.<br clear=3D"=
all"><br>-- <br><div class=3D"gmail_signature"><div dir=3D"ltr">Ebelechukwu=
 Nwafor,<div>Graduate Student,</div><div>Howard University.</div></div></di=
v></div></div><br>_______________________________________________<br>lttng-=
dev mailing list<br>lttng-dev@lists.lttng.org<br>https://lists.lttng.org/cg=
i-bin/mailman/listinfo/lttng-dev<br></blockquote></div><div><br></div><div =
data-marker=3D"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiO=
S Inc.<br>http://www.efficios.com</div></div></body></html>
--=_2abac69e-6c84-440a-b974-484f29547d8d--

--===============1988024795475961427==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============1988024795475961427==--
