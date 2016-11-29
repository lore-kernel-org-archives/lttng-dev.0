From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: CTF parser library or plugin location?
Date: Tue, 29 Nov 2016 03:41:18 +0000 (UTC)
Message-ID: <951145749.19203.1480390878904.JavaMail.zimbra__19088.5422788144$1480390819$gmane$org@efficios.com>
References: <CAAuy2ASOUuJn2tAiV1vWNU2E9vZAFJcPiSsdNjsJ97F8uJYaSA@mail.gmail.com>
 <1730636642.18966.1480382462061.JavaMail.zimbra@efficios.com>
 <CAAuy2AQUdVMeoAzs_q4B6-pdcbFQx-THNZ3C6v3sYRk9=9ZWRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3598338009669417947=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3tSTqn2SCczmgF
 for <lttng-dev@lists.lttng.org>; Tue, 29 Nov 2016 03:41:40 +0000 (UTC)
In-Reply-To: <CAAuy2AQUdVMeoAzs_q4B6-pdcbFQx-THNZ3C6v3sYRk9=9ZWRA@mail.gmail.com>
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

--===============3598338009669417947==
Content-Type: multipart/alternative;
	boundary="=_ef1b8bfd-87fb-4fc5-a6d5-bf6073f17c2f"

--=_ef1b8bfd-87fb-4fc5-a6d5-bf6073f17c2f
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

The Trace Compass plugin contains a Java CTF reader. 
It does not have a CTF writer however. 

We have the babeltrace project which both read and write CTF, from 
either C or python. (http://diamon.org/babeltrace) 

We also have BareCTF which writes CTF, initially for baremetal, but 
can also accomodate other applications. (https://github.com/efficios/barectf) 

And LTTng-UST, and Linux application tracer, produces CTF. 
(http://lttng.org) 

Thanks, 

Mathieu 

----- On Nov 28, 2016, at 10:06 PM, Ebelechukwu Nwafor <ebelechukwu.nwafor@bison.howard.edu> wrote: 

> Hi Mathieu.
> Thanks for the information. It does not seem like the plugin contains the CTF
> parser that reads and write events. Is there an additional library that i have
> to import to do that?

> Thanks.

> On Mon, Nov 28, 2016 at 8:21 PM, Mathieu Desnoyers < [
> mailto:mathieu.desnoyers@efficios.com | mathieu.desnoyers@efficios.com ] >
> wrote:

>> ----- On Nov 28, 2016, at 7:59 PM, Ebelechukwu Nwafor < [
>> mailto:ebelechukwu.nwafor@bison.howard.edu |
>> ebelechukwu.nwafor@bison.howard.edu ] > wrote:

>>> Hello All.
>>> I am new to lttng and linux tracing. I was trying to download the linux update
>>> plugin so i can use the CTF parser to read events. I followed instructions on
>>> the eclipse documentation located at:

>>> [
>>> http://help.eclipse.org/luna/index.jsp?topic=%2Forg.eclipse.linuxtools.lttng.help%2Fdoc%2FInstallation.html
>>> |
>>> http://help.eclipse.org/luna/index.jsp?topic=%2Forg.eclipse.linuxtools.lttng.help%2Fdoc%2FInstallation.html
>>> ]

>>> The CTF parser and LTTNG tracing toolkit does not seem to be included in the
>>> Linux tools plugin anymore. Does anyone know how i could get the library for
>>> CTF parsing or possibly plugin location?

>> Hi,

>> This is now under its own Eclipse project: [ http://tracecompass.org/ |
>> http://tracecompass.org/ ]
>> You can use it either as a stand alone app, or as an eclipse plugin (see [
>> http://tracecompass.org/download.html | http://tracecompass.org/download.html ]
>> ).

>> Thanks,

>> Mathieu

>>> Best Regards.

>>> --
>>> Ebelechukwu Nwafor,
>>> Graduate Student,
>>> Howard University.

>>> _______________________________________________
>>> lttng-dev mailing list
>>> [ mailto:lttng-dev@lists.lttng.org | lttng-dev@lists.lttng.org ]
>>> [ https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev |
>>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev ]

>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> [ http://www.efficios.com/ | http://www.efficios.com ]

> --
> Ebelechukwu Nwafor,
> Graduate Student,
> Howard University.

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_ef1b8bfd-87fb-4fc5-a6d5-bf6073f17c2f
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div>The Trace Compass plugin contains a Java CT=
F reader.<br></div><div>It does not have a CTF writer however.<br data-mce-=
bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>We have the babe=
ltrace project which both read and write CTF, from<br data-mce-bogus=3D"1">=
</div><div>either C or python. (http://diamon.org/babeltrace)<br data-mce-b=
ogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>We also have Bare=
CTF which writes CTF, initially for baremetal, but<br data-mce-bogus=3D"1">=
</div><div>can also accomodate other applications. (https://github.com/effi=
cios/barectf)<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"><=
/div><div>And LTTng-UST, and Linux application tracer, produces CTF.<br dat=
a-mce-bogus=3D"1"></div><div>(http://lttng.org)<br data-mce-bogus=3D"1"></d=
iv><div><br data-mce-bogus=3D"1"></div><div>Thanks,<br data-mce-bogus=3D"1"=
></div><div><br data-mce-bogus=3D"1"></div><div>Mathieu<br data-mce-bogus=
=3D"1"></div><div><br></div><span id=3D"zwchr" data-marker=3D"__DIVIDER__">=
----- On Nov 28, 2016, at 10:06 PM, Ebelechukwu Nwafor &lt;ebelechukwu.nwaf=
or@bison.howard.edu&gt; wrote:<br></span><div data-marker=3D"__QUOTED_TEXT_=
_"><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;paddi=
ng-left:5px;color:#000;font-weight:normal;font-style:normal;text-decoration=
:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"l=
tr">Hi Mathieu.<br><div>Thanks for the information. It does not seem like t=
he plugin contains the CTF parser that reads and write events. Is there an =
additional library that i have to import to do that?</div><br><br><div>Than=
ks.</div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On=
 Mon, Nov 28, 2016 at 8:21 PM, Mathieu Desnoyers <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_blank">mathieu.des=
noyers@efficios.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
><div><div style=3D"font-family:arial,helvetica,sans-serif;font-size:12pt;c=
olor:#000000"><span class=3D""><br><div><span id=3D"m_8938727256088943259zw=
chr">----- On Nov 28, 2016, at 7:59 PM, Ebelechukwu Nwafor &lt;<a href=3D"m=
ailto:ebelechukwu.nwafor@bison.howard.edu" target=3D"_blank">ebelechukwu.nw=
afor@bison.howard.edu</a>&gt; wrote:<br></span></div></span><div><span clas=
s=3D""><blockquote style=3D"border-left:2px solid #1010ff;margin-left:5px;p=
adding-left:5px;color:#000;font-weight:normal;font-style:normal;text-decora=
tion:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt"><div dir=
=3D"ltr">Hello All.<br><div>I am new to lttng and linux tracing. I was tryi=
ng to download the linux update plugin so i can use the CTF parser to read =
events. I followed instructions on the eclipse documentation located at:&nb=
sp;</div><br><div><a href=3D"http://help.eclipse.org/luna/index.jsp?topic=
=3D%2Forg.eclipse.linuxtools.lttng.help%2Fdoc%2FInstallation.html" target=
=3D"_blank">http://help.eclipse.org/luna/index.jsp?topic=3D%2Forg.eclipse.l=
inuxtools.lttng.help%2Fdoc%2FInstallation.html</a><br></div><br><div> The C=
TF parser and LTTNG tracing toolkit does not seem to be included in the Lin=
ux tools plugin anymore. Does anyone know how i could get the library for C=
TF parsing or possibly plugin location?</div><br></div></blockquote><br></s=
pan><div>Hi,<br></div><br><div>This is now under its own Eclipse project: <=
a href=3D"http://tracecompass.org/" target=3D"_blank">http://tracecompass.o=
rg/</a><br></div><div>You can use it either as a stand alone app, or as an =
eclipse plugin (see <a href=3D"http://tracecompass.org/download.html" targe=
t=3D"_blank">http://tracecompass.org/download.html</a>).<br></div><br><div>=
Thanks,<br></div><br><div>Mathieu<br></div><br><blockquote style=3D"border-=
left:2px solid #1010ff;margin-left:5px;padding-left:5px;color:#000;font-wei=
ght:normal;font-style:normal;text-decoration:none;font-family:Helvetica,Ari=
al,sans-serif;font-size:12pt"><span class=3D""><div dir=3D"ltr"><br><div>Be=
st Regards.<br clear=3D"all"><br>-- <br><div class=3D"m_8938727256088943259=
gmail_signature"><div dir=3D"ltr">Ebelechukwu Nwafor,<div>Graduate Student,=
</div><div>Howard University.</div></div></div></div></div><br></span>_____=
__________________________________________<br>lttng-dev mailing list<br><a =
href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists=
.lttng.org</a><br><a href=3D"https://lists.lttng.org/cgi-bin/mailman/listin=
fo/lttng-dev" target=3D"_blank">https://lists.lttng.org/cgi-bin/mailman/lis=
tinfo/lttng-dev</a><span class=3D"HOEnZb"><span style=3D"color: #888888;" d=
ata-mce-style=3D"color: #888888;" color=3D"#888888"><br></span></span></blo=
ckquote></div><span class=3D"HOEnZb"><span style=3D"color: #888888;" data-m=
ce-style=3D"color: #888888;" color=3D"#888888"><br><div>-- <br></div><div>M=
athieu Desnoyers<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com" ta=
rget=3D"_blank">http://www.efficios.com</a><br data-mce-bogus=3D"1"></div><=
/span></span></div></div></blockquote></div><br><br clear=3D"all"><br>-- <b=
r><div class=3D"gmail_signature"><div dir=3D"ltr">Ebelechukwu Nwafor,<div>G=
raduate Student,</div><div>Howard University.</div></div></div>
</div><br></blockquote></div><br><div data-marker=3D"__SIG_POST__">-- <br><=
/div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com</di=
v></div></body></html>
--=_ef1b8bfd-87fb-4fc5-a6d5-bf6073f17c2f--

--===============3598338009669417947==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============3598338009669417947==--
