From: Francesco Mariniello <mariniello.francesco@gmail.com>
Subject: cannot find lttng/tracepoint.h
Date: Sun, 13 May 2018 01:12:11 +0200
Message-ID: <CAM6CJXxdSwgGXjf-unmvdE-SO_50AT+3hRMm01Ubd8T2MzfYaA__48980.3457669497$1526306486$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2228609724649803203=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt0-x233.google.com (mail-qt0-x233.google.com
 [IPv6:2607:f8b0:400d:c0d::233])
 by lists.lttng.org (Postfix) with ESMTPS id 40k2mF3KT4z18gk
 for <lttng-dev@lists.lttng.org>; Sat, 12 May 2018 19:12:13 -0400 (EDT)
Received: by mail-qt0-x233.google.com with SMTP id e8-v6so11769581qth.0
 for <lttng-dev@lists.lttng.org>; Sat, 12 May 2018 16:12:13 -0700 (PDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============2228609724649803203==
Content-Type: multipart/alternative; boundary="000000000000f37e97056c0a6182"

--000000000000f37e97056c0a6182
Content-Type: text/plain; charset="UTF-8"

Hi lttng dev,
i'm a student writing my final paper on lttng, i'm currently trying to run
the example from the
https://lttng.org/docs/v2.10/#doc-tracing-your-own-user-application

but when i try to build the provider package

gcc -c -I. hello-tp.c


it says:

hello-tp.h:10:30: fatal error: lttng/tracepoint.h: No such file or directory

compilation terminated.


how can i fix this? I installed everything according to website, and i
have no problem running a kernel session.

best wishes,

francesco


<https://www.avast.com/sig-email?utm_medium=email&utm_source=link&utm_campaign=sig-email&utm_content=webmail>
Mail
priva di virus. www.avast.com
<https://www.avast.com/sig-email?utm_medium=email&utm_source=link&utm_campaign=sig-email&utm_content=webmail>
<#DAB4FAD8-2DD7-40BB-A1B8-4E2AA1F9FDF2>

--000000000000f37e97056c0a6182
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi lttng dev,<div>i&#39;m a student writing my final paper=
 on lttng, i&#39;m currently trying to run the example from the=C2=A0</div>=
<div><a href=3D"https://lttng.org/docs/v2.10/#doc-tracing-your-own-user-app=
lication">https://lttng.org/docs/v2.10/#doc-tracing-your-own-user-applicati=
on</a><br></div><div><br></div><div>but when i try to build the provider pa=
ckage=C2=A0</div><div><pre class=3D"gmail-commands" style=3D"margin-top:0px=
;margin-bottom:0px;padding:0px;border:0px;font-variant-numeric:inherit;font=
-variant-east-asian:inherit;font-stretch:inherit;font-size:12px;line-height=
:15px;font-family:&quot;Andale Mono WT&quot;,&quot;Andale Mono&quot;,&quot;=
Bitstream Vera Sans Mono&quot;,&quot;Liberation Mono&quot;,&quot;Nimbus Mon=
o L&quot;,&quot;Ubuntu Mono&quot;,Monaco,Consolas,&quot;Lucida Console&quot=
;,&quot;Lucida Sans Typewriter&quot;,&quot;Courier New&quot;,Courier,monosp=
ace;vertical-align:baseline;background-color:transparent;overflow-x:auto;co=
lor:rgba(0,0,0,0.75)">gcc -c -I. hello-tp.c</pre><pre class=3D"gmail-comman=
ds" style=3D"margin-top:0px;margin-bottom:0px;padding:0px;border:0px;font-v=
ariant-numeric:inherit;font-variant-east-asian:inherit;font-stretch:inherit=
;font-size:12px;line-height:15px;font-family:&quot;Andale Mono WT&quot;,&qu=
ot;Andale Mono&quot;,&quot;Bitstream Vera Sans Mono&quot;,&quot;Liberation =
Mono&quot;,&quot;Nimbus Mono L&quot;,&quot;Ubuntu Mono&quot;,Monaco,Consola=
s,&quot;Lucida Console&quot;,&quot;Lucida Sans Typewriter&quot;,&quot;Couri=
er New&quot;,Courier,monospace;vertical-align:baseline;background-color:tra=
nsparent;overflow-x:auto;color:rgba(0,0,0,0.75)"><br></pre><pre class=3D"gm=
ail-commands" style=3D"margin-top:0px;margin-bottom:0px;padding:0px;border:=
0px;font-variant-numeric:inherit;font-variant-east-asian:inherit;font-stret=
ch:inherit;font-size:12px;line-height:15px;font-family:&quot;Andale Mono WT=
&quot;,&quot;Andale Mono&quot;,&quot;Bitstream Vera Sans Mono&quot;,&quot;L=
iberation Mono&quot;,&quot;Nimbus Mono L&quot;,&quot;Ubuntu Mono&quot;,Mona=
co,Consolas,&quot;Lucida Console&quot;,&quot;Lucida Sans Typewriter&quot;,&=
quot;Courier New&quot;,Courier,monospace;vertical-align:baseline;background=
-color:transparent;overflow-x:auto;color:rgba(0,0,0,0.75)">it says: </pre><=
pre class=3D"gmail-commands" style=3D"margin-top:0px;margin-bottom:0px;padd=
ing:0px;border:0px;font-variant-numeric:inherit;font-variant-east-asian:inh=
erit;font-stretch:inherit;font-size:12px;line-height:15px;font-family:&quot=
;Andale Mono WT&quot;,&quot;Andale Mono&quot;,&quot;Bitstream Vera Sans Mon=
o&quot;,&quot;Liberation Mono&quot;,&quot;Nimbus Mono L&quot;,&quot;Ubuntu =
Mono&quot;,Monaco,Consolas,&quot;Lucida Console&quot;,&quot;Lucida Sans Typ=
ewriter&quot;,&quot;Courier New&quot;,Courier,monospace;vertical-align:base=
line;background-color:transparent;overflow-x:auto;color:rgba(0,0,0,0.75)">h=
ello-tp.h:10:30: fatal error: lttng/tracepoint.h: No such file or directory=
</pre><pre class=3D"gmail-commands" style=3D"margin-top:0px;margin-bottom:0=
px;padding:0px;border:0px;font-variant-numeric:inherit;font-variant-east-as=
ian:inherit;font-stretch:inherit;font-size:12px;line-height:15px;font-famil=
y:&quot;Andale Mono WT&quot;,&quot;Andale Mono&quot;,&quot;Bitstream Vera S=
ans Mono&quot;,&quot;Liberation Mono&quot;,&quot;Nimbus Mono L&quot;,&quot;=
Ubuntu Mono&quot;,Monaco,Consolas,&quot;Lucida Console&quot;,&quot;Lucida S=
ans Typewriter&quot;,&quot;Courier New&quot;,Courier,monospace;vertical-ali=
gn:baseline;background-color:transparent;overflow-x:auto;color:rgba(0,0,0,0=
.75)">compilation terminated.</pre><pre class=3D"gmail-commands" style=3D"m=
argin-top:0px;margin-bottom:0px;padding:0px;border:0px;font-variant-numeric=
:inherit;font-variant-east-asian:inherit;font-stretch:inherit;font-size:12p=
x;line-height:15px;font-family:&quot;Andale Mono WT&quot;,&quot;Andale Mono=
&quot;,&quot;Bitstream Vera Sans Mono&quot;,&quot;Liberation Mono&quot;,&qu=
ot;Nimbus Mono L&quot;,&quot;Ubuntu Mono&quot;,Monaco,Consolas,&quot;Lucida=
 Console&quot;,&quot;Lucida Sans Typewriter&quot;,&quot;Courier New&quot;,C=
ourier,monospace;vertical-align:baseline;background-color:transparent;overf=
low-x:auto;color:rgba(0,0,0,0.75)"><br></pre><pre class=3D"gmail-commands" =
style=3D"margin-top:0px;margin-bottom:0px;padding:0px;border:0px;font-varia=
nt-numeric:inherit;font-variant-east-asian:inherit;font-stretch:inherit;fon=
t-size:12px;line-height:15px;font-family:&quot;Andale Mono WT&quot;,&quot;A=
ndale Mono&quot;,&quot;Bitstream Vera Sans Mono&quot;,&quot;Liberation Mono=
&quot;,&quot;Nimbus Mono L&quot;,&quot;Ubuntu Mono&quot;,Monaco,Consolas,&q=
uot;Lucida Console&quot;,&quot;Lucida Sans Typewriter&quot;,&quot;Courier N=
ew&quot;,Courier,monospace;vertical-align:baseline;background-color:transpa=
rent;overflow-x:auto;color:rgba(0,0,0,0.75)">how can i fix this? I installe=
d everything according to website, and i have no problem running a kernel s=
ession.</pre><pre class=3D"gmail-commands" style=3D"margin-top:0px;margin-b=
ottom:0px;padding:0px;border:0px;font-variant-numeric:inherit;font-variant-=
east-asian:inherit;font-stretch:inherit;font-size:12px;line-height:15px;fon=
t-family:&quot;Andale Mono WT&quot;,&quot;Andale Mono&quot;,&quot;Bitstream=
 Vera Sans Mono&quot;,&quot;Liberation Mono&quot;,&quot;Nimbus Mono L&quot;=
,&quot;Ubuntu Mono&quot;,Monaco,Consolas,&quot;Lucida Console&quot;,&quot;L=
ucida Sans Typewriter&quot;,&quot;Courier New&quot;,Courier,monospace;verti=
cal-align:baseline;background-color:transparent;overflow-x:auto;color:rgba(=
0,0,0,0.75)">best wishes,</pre><pre class=3D"gmail-commands" style=3D"margi=
n-top:0px;margin-bottom:0px;padding:0px;border:0px;font-variant-numeric:inh=
erit;font-variant-east-asian:inherit;font-stretch:inherit;font-size:12px;li=
ne-height:15px;font-family:&quot;Andale Mono WT&quot;,&quot;Andale Mono&quo=
t;,&quot;Bitstream Vera Sans Mono&quot;,&quot;Liberation Mono&quot;,&quot;N=
imbus Mono L&quot;,&quot;Ubuntu Mono&quot;,Monaco,Consolas,&quot;Lucida Con=
sole&quot;,&quot;Lucida Sans Typewriter&quot;,&quot;Courier New&quot;,Couri=
er,monospace;vertical-align:baseline;background-color:transparent;overflow-=
x:auto;color:rgba(0,0,0,0.75)">francesco</pre></div></div><div id=3D"DAB4FA=
D8-2DD7-40BB-A1B8-4E2AA1F9FDF2"><br> <table style=3D"border-top:1px solid #=
d3d4de">
	<tr>
      <td style=3D"width:55px;padding-top:18px"><a href=3D"https://www.avas=
t.com/sig-email?utm_medium=3Demail&amp;utm_source=3Dlink&amp;utm_campaign=
=3Dsig-email&amp;utm_content=3Dwebmail" target=3D"_blank"><img src=3D"https=
://ipmcdn.avast.com/images/icons/icon-envelope-tick-round-orange-animated-n=
o-repeat-v1.gif" alt=3D"" width=3D"46" height=3D"29" style=3D"width: 46px; =
height: 29px;"></a></td>
		<td style=3D"width:470px;padding-top:17px;color:#41424e;font-size:13px;fo=
nt-family:Arial,Helvetica,sans-serif;line-height:18px">Mail priva di virus.=
 <a href=3D"https://www.avast.com/sig-email?utm_medium=3Demail&amp;utm_sour=
ce=3Dlink&amp;utm_campaign=3Dsig-email&amp;utm_content=3Dwebmail" target=3D=
"_blank" style=3D"color:#4453ea">www.avast.com</a> 		</td>
	</tr>
</table>
<a href=3D"#DAB4FAD8-2DD7-40BB-A1B8-4E2AA1F9FDF2" width=3D"1" height=3D"1">=
</a></div>

--000000000000f37e97056c0a6182--

--===============2228609724649803203==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============2228609724649803203==--
