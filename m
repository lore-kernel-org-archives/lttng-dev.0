From: "Nwafor, Ebelechukwu" <ebelechukwu.nwafor@bison.howard.edu>
Subject: Re: CTF parser library or plugin location?
Date: Mon, 28 Nov 2016 22:06:35 -0500
Message-ID: <CAAuy2AQUdVMeoAzs_q4B6-pdcbFQx-THNZ3C6v3sYRk9=9ZWRA__18001.6639912084$1480388810$gmane$org@mail.gmail.com>
References: <CAAuy2ASOUuJn2tAiV1vWNU2E9vZAFJcPiSsdNjsJ97F8uJYaSA@mail.gmail.com>
 <1730636642.18966.1480382462061.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5437723385986072059=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yb0-x235.google.com (mail-yb0-x235.google.com
 [IPv6:2607:f8b0:4002:c09::235])
 by lists.lttng.org (Postfix) with ESMTPS id 3tST5747ljzmd7
 for <lttng-dev@lists.lttng.org>; Tue, 29 Nov 2016 03:08:11 +0000 (UTC)
Received: by mail-yb0-x235.google.com with SMTP id d128so4442403ybh.2
 for <lttng-dev@lists.lttng.org>; Mon, 28 Nov 2016 19:06:36 -0800 (PST)
In-Reply-To: <1730636642.18966.1480382462061.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============5437723385986072059==
Content-Type: multipart/alternative; boundary=001a113ce56c47c724054267e05f

--001a113ce56c47c724054267e05f
Content-Type: text/plain; charset=UTF-8

Hi Mathieu.

Thanks for the information. It does not seem like the plugin contains the
CTF parser that reads and write events. Is there an additional library that
i have to import to do that?


Thanks.

On Mon, Nov 28, 2016 at 8:21 PM, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

>
> ----- On Nov 28, 2016, at 7:59 PM, Ebelechukwu Nwafor <
> ebelechukwu.nwafor@bison.howard.edu> wrote:
>
> Hello All.
> I am new to lttng and linux tracing. I was trying to download the linux
> update plugin so i can use the CTF parser to read events. I followed
> instructions on the eclipse documentation located at:
>
> http://help.eclipse.org/luna/index.jsp?topic=%2Forg.
> eclipse.linuxtools.lttng.help%2Fdoc%2FInstallation.html
>
> The CTF parser and LTTNG tracing toolkit does not seem to be included in
> the Linux tools plugin anymore. Does anyone know how i could get the
> library for CTF parsing or possibly plugin location?
>
>
> Hi,
>
> This is now under its own Eclipse project: http://tracecompass.org/
> You can use it either as a stand alone app, or as an eclipse plugin (see
> http://tracecompass.org/download.html).
>
> Thanks,
>
> Mathieu
>
>
> Best Regards.
>
> --
> Ebelechukwu Nwafor,
> Graduate Student,
> Howard University.
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>



-- 
Ebelechukwu Nwafor,
Graduate Student,
Howard University.

--001a113ce56c47c724054267e05f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Mathieu.<div><br></div><div>Thanks for the information.=
 It does not seem like the plugin contains the CTF parser that reads and wr=
ite events. Is there an additional library that i have to import to do that=
?</div><div><br></div><div><br></div><div>Thanks.</div></div><div class=3D"=
gmail_extra"><br><div class=3D"gmail_quote">On Mon, Nov 28, 2016 at 8:21 PM=
, Mathieu Desnoyers <span dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.desnoye=
rs@efficios.com" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;</=
span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex"><div><div style=3D"font-fami=
ly:arial,helvetica,sans-serif;font-size:12pt;color:#000000"><span class=3D"=
"><div><br></div><div><span id=3D"m_8938727256088943259zwchr">----- On Nov =
28, 2016, at 7:59 PM, Ebelechukwu Nwafor &lt;<a href=3D"mailto:ebelechukwu.=
nwafor@bison.howard.edu" target=3D"_blank">ebelechukwu.nwafor@bison.<wbr>ho=
ward.edu</a>&gt; wrote:<br></span></div></span><div><span class=3D""><block=
quote style=3D"border-left:2px solid #1010ff;margin-left:5px;padding-left:5=
px;color:#000;font-weight:normal;font-style:normal;text-decoration:none;fon=
t-family:Helvetica,Arial,sans-serif;font-size:12pt"><div dir=3D"ltr">Hello =
All.<br><div>I am new to lttng and linux tracing. I was trying to download =
the linux update plugin so i can use the CTF parser to read events. I follo=
wed instructions on the eclipse documentation located at:=C2=A0</div><br><d=
iv><a href=3D"http://help.eclipse.org/luna/index.jsp?topic=3D%2Forg.eclipse=
.linuxtools.lttng.help%2Fdoc%2FInstallation.html" target=3D"_blank">http://=
help.eclipse.org/luna/<wbr>index.jsp?topic=3D%2Forg.<wbr>eclipse.linuxtools=
.lttng.help%<wbr>2Fdoc%2FInstallation.html</a><br></div><br><div> The CTF p=
arser and LTTNG tracing toolkit does not seem to be included in the Linux t=
ools plugin anymore. Does anyone know how i could get the library for CTF p=
arsing or possibly plugin location?</div><br></div></blockquote><div><br></=
div></span><div>Hi,<br></div><div><br></div><div>This is now under its own =
Eclipse project: <a href=3D"http://tracecompass.org/" target=3D"_blank">htt=
p://tracecompass.org/</a><br></div><div>You can use it either as a stand al=
one app, or as an eclipse plugin (see <a href=3D"http://tracecompass.org/do=
wnload.html" target=3D"_blank">http://tracecompass.org/<wbr>download.html</=
a>).<br></div><div><br></div><div>Thanks,<br></div><div><br></div><div>Math=
ieu<br></div><div><br></div><blockquote style=3D"border-left:2px solid #101=
0ff;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-sty=
le:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-=
size:12pt"><span class=3D""><div dir=3D"ltr"><br><div>Best Regards.<br clea=
r=3D"all"><br>-- <br><div class=3D"m_8938727256088943259gmail_signature"><d=
iv dir=3D"ltr">Ebelechukwu Nwafor,<div>Graduate Student,</div><div>Howard U=
niversity.</div></div></div></div></div><br></span>________________________=
______<wbr>_________________<br>lttng-dev mailing list<br><a href=3D"mailto=
:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a>=
<br><a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" =
target=3D"_blank">https://lists.lttng.org/cgi-<wbr>bin/mailman/listinfo/ltt=
ng-dev</a><span class=3D"HOEnZb"><font color=3D"#888888"><br></font></span>=
</blockquote></div><span class=3D"HOEnZb"><font color=3D"#888888"><div><br>=
</div><div>-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br><a href=
=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.com</a><=
/div></font></span></div></div></blockquote></div><br><br clear=3D"all"><di=
v><br></div>-- <br><div class=3D"gmail_signature" data-smartmail=3D"gmail_s=
ignature"><div dir=3D"ltr">Ebelechukwu Nwafor,<div>Graduate Student,</div><=
div>Howard University.</div></div></div>
</div>

--001a113ce56c47c724054267e05f--

--===============5437723385986072059==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============5437723385986072059==--
