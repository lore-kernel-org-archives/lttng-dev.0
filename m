From: Nesrine Zouari <nesrine.zouari@enis.tn>
Subject: Babeltrace Patch
Date: Wed, 11 Apr 2018 13:11:46 +0100
Message-ID: <CAPHFV4no6vfu0HV-D9Fy0HwGnuN84LT-4m3yLV_9ZOjqA+ytqQ__13142.840358387$1523448621$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6042268861973963851=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt0-x22c.google.com (mail-qt0-x22c.google.com
 [IPv6:2607:f8b0:400d:c0d::22c])
 by lists.lttng.org (Postfix) with ESMTPS id 40Ljb53j0Nz15Nq
 for <lttng-dev@lists.lttng.org>; Wed, 11 Apr 2018 08:12:17 -0400 (EDT)
Received: by mail-qt0-x22c.google.com with SMTP id w23so1594750qtn.3
 for <lttng-dev@lists.lttng.org>; Wed, 11 Apr 2018 05:12:17 -0700 (PDT)
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

--===============6042268861973963851==
Content-Type: multipart/alternative; boundary="001a1140cfc4c5f1ce0569918c99"

--001a1140cfc4c5f1ce0569918c99
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I am computer engineering student and I am actually working on my
graduation project which is about Qemu Trace.

In this project, Qemu is considered as a user-space instrumented
application.

I have used:

1) LTTng-Tools to control Qemu trace.

2) Babeltrace to convert the CTF traces to a human readable text.

Now, I aim to develop a patch to the Babeltrace. Instead of printing the
traces on the console or in a file, I would like to send the traces over
TCP/IP to a third-party tool for processing.
My third-party tool is installed on a windows machine. For this reason, the
use of LTTng relay daemon will not be a good solution.

My question is the following:

To which file (of the Babeltrace source code) should I make changes to
answer my use case?

Best regards,

---------------------------------------------------------------------------=
--------------

Nesrine ZOUARI
Computer Engineering Student
Department of Computer Engineering and Applied Mathematics
National Engineering School of Sfax (ENIS)
University of Sfax-Tunisia
Tel: +216 52 620 475


=E2=80=8C

--001a1140cfc4c5f1ce0569918c99
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><img width=3D"0" height=3D"0" class=3D"mailtrack-img" alt=
=3D"" style=3D"display:flex" src=3D"https://mailtrack.io/trace/mail/e23be10=
a85712f90d75c20e203084a37d54d5929.png?u=3D2189147"><div></div><div style=3D=
"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:12.8px;font-sty=
le:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weigh=
t:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transform=
:none;white-space:normal;word-spacing:0px;text-decoration-style:initial;tex=
t-decoration-color:initial;background-color:rgb(255,255,255)"><span style=
=3D"font-family:arial,sans-serif;font-size:12.8px;font-style:normal;font-va=
riant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spac=
ing:normal;text-transform:none;white-space:normal;word-spacing:0px;text-ali=
gn:start;text-indent:0px;text-decoration-style:initial;text-decoration-colo=
r:initial;background-color:rgb(255,255,255);float:none;display:inline"><fon=
t color=3D"#000000">Hello,</font></span><div style=3D"font-family:arial,san=
s-serif;font-size:12.8px;font-style:normal;font-variant-ligatures:normal;fo=
nt-variant-caps:normal;font-weight:400;letter-spacing:normal;text-transform=
:none;white-space:normal;word-spacing:0px;text-align:start;text-indent:0px;=
text-decoration-style:initial;text-decoration-color:initial;background-colo=
r:rgb(255,255,255)"><span style=3D"font-family:arial,sans-serif;font-style:=
normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:4=
00;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:no=
ne;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);te=
xt-decoration-style:initial;text-decoration-color:initial;float:none;displa=
y:inline"><font color=3D"#000000"><br></font></span></div><div style=3D"fon=
t-family:arial,sans-serif;font-size:12.8px;font-style:normal;font-variant-l=
igatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:nor=
mal;text-transform:none;white-space:normal;word-spacing:0px;text-align:star=
t;text-indent:0px;text-decoration-style:initial;text-decoration-color:initi=
al;background-color:rgb(255,255,255)"><font color=3D"#000000"><span style=
=3D"font-family:arial,sans-serif;font-style:normal;font-variant-ligatures:n=
ormal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-a=
lign:start;text-indent:0px;text-transform:none;white-space:normal;word-spac=
ing:0px;background-color:rgb(255,255,255);text-decoration-style:initial;tex=
t-decoration-color:initial;float:none;display:inline">I am computer enginee=
ring student and I am actually working on my graduation project which is ab=
out<span>=C2=A0</span></span><span class=3D"gmail-m_-5990065758927244463gma=
il-m_6820945704080840124gmail-m_-6755159426057962638gmail-m_322698052164949=
6158gmail-m_4311176812459725481gmail-m_3469504987072534619gmail-m_-21433546=
02622622349gmail-m_5367336902020713707gmail-m_567988643051350633gmail-m_-25=
04658086804125746m_-670507402164016222gmail-il" style=3D"font-family:arial,=
sans-serif;font-style:normal;font-variant-ligatures:normal;font-variant-cap=
s:normal;font-weight:400;letter-spacing:normal;text-align:start;text-indent=
:0px;text-transform:none;white-space:normal;word-spacing:0px;background-col=
or:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:ini=
tial">Qemu</span><span style=3D"font-family:arial,sans-serif;font-style:nor=
mal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;=
letter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;=
white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-=
decoration-style:initial;text-decoration-color:initial;float:none;display:i=
nline"><span>=C2=A0</span>Trace.=C2=A0</span></font></div><div style=3D"tex=
t-align:start;text-indent:0px;text-decoration-style:initial;text-decoration=
-color:initial"><font color=3D"#000000" style=3D"font-family:arial,sans-ser=
if;font-size:12.8px;font-style:normal;font-variant-ligatures:normal;font-va=
riant-caps:normal;font-weight:400;letter-spacing:normal;text-transform:none=
;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255)"><br=
></font><div style=3D"font-family:arial,sans-serif;font-size:12.8px;font-st=
yle:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weig=
ht:400;letter-spacing:normal;text-transform:none;white-space:normal;word-sp=
acing:0px"><span style=3D"text-align:start;text-indent:0px;text-decoration-=
style:initial;text-decoration-color:initial;float:none;display:inline"><fon=
t color=3D"#000000"><font style=3D"font-style:normal;font-variant-ligatures=
:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text=
-transform:none;white-space:normal;word-spacing:0px;font-family:arial,sans-=
serif;font-size:12.8px;background-color:rgb(255,255,255)"><span style=3D"fo=
nt-size:12.8px">In this project, Qemu is<span>=C2=A0</span></span></font><s=
pan style=3D"font-style:normal;font-variant-ligatures:normal;font-variant-c=
aps:normal;font-weight:400;letter-spacing:normal;text-transform:none;white-=
space:normal;word-spacing:0px;font-family:arial,sans-serif;font-size:12.8px=
;background-color:rgb(255,255,255)">considered</span><font><span style=3D"b=
ackground-color:rgb(255,255,255)"><span style=3D"font-size:12.8px">=C2=A0as=
 a user-space instrumented application.=C2=A0</span></span></font></font></=
span></div><div style=3D"font-family:arial,sans-serif;font-size:12.8px;font=
-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-w=
eight:400;letter-spacing:normal;text-transform:none;white-space:normal;word=
-spacing:0px"><span style=3D"text-align:start;text-indent:0px;text-decorati=
on-style:initial;text-decoration-color:initial;float:none;display:inline"><=
span style=3D"background-color:rgb(255,255,255)"><span style=3D"font-size:1=
2.8px"><font color=3D"#000000"><br></font></span></span></span></div><div s=
tyle=3D"font-family:arial,sans-serif;font-size:12.8px;font-style:normal;fon=
t-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-=
spacing:normal;text-transform:none;white-space:normal;word-spacing:0px"><sp=
an style=3D"text-align:start;text-indent:0px;text-decoration-style:initial;=
text-decoration-color:initial;float:none;display:inline"><span style=3D"bac=
kground-color:rgb(255,255,255)"><span style=3D"font-size:12.8px"><font colo=
r=3D"#000000">I have used:</font></span></span></span></div><div style=3D"f=
ont-family:arial,sans-serif;font-size:12.8px;font-style:normal;font-variant=
-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:n=
ormal;text-transform:none;white-space:normal;word-spacing:0px"><span style=
=3D"text-align:start;text-indent:0px;text-decoration-style:initial;text-dec=
oration-color:initial;float:none;display:inline"><span style=3D"background-=
color:rgb(255,255,255)"><span class=3D"gmail-m_-5990065758927244463gmail-m_=
6820945704080840124gmail-m_-6755159426057962638gmail-m_3226980521649496158g=
mail-m_4311176812459725481gmail-m_3469504987072534619gmail-il" style=3D"fon=
t-family:arial,sans-serif;font-size:12.8px;font-style:normal;font-variant-l=
igatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:nor=
mal;text-transform:none;white-space:normal;word-spacing:0px"><font color=3D=
"#000000"><br></font></span></span></span></div><div style=3D"font-family:a=
rial,sans-serif;font-size:12.8px;font-style:normal;font-variant-ligatures:n=
ormal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-t=
ransform:none;white-space:normal;word-spacing:0px"><span style=3D"text-alig=
n:start;text-indent:0px;text-decoration-style:initial;text-decoration-color=
:initial;float:none;display:inline"><span style=3D"background-color:rgb(255=
,255,255)"><font color=3D"#000000"><span class=3D"gmail-m_-5990065758927244=
463gmail-m_6820945704080840124gmail-m_-6755159426057962638gmail-m_322698052=
1649496158gmail-m_4311176812459725481gmail-m_3469504987072534619gmail-il" s=
tyle=3D"font-family:arial,sans-serif;font-size:12.8px;font-style:normal;fon=
t-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-=
spacing:normal;text-transform:none;white-space:normal;word-spacing:0px">1) =
LTTng</span><span style=3D"font-size:12.8px">-Tools to control Qemu trace.=
=C2=A0</span></font></span></span></div><div style=3D"font-family:arial,san=
s-serif;font-size:12.8px;font-style:normal;font-variant-ligatures:normal;fo=
nt-variant-caps:normal;font-weight:400;letter-spacing:normal;text-transform=
:none;white-space:normal;word-spacing:0px"><span style=3D"text-align:start;=
text-indent:0px;text-decoration-style:initial;text-decoration-color:initial=
;float:none;display:inline"><span style=3D"background-color:rgb(255,255,255=
)"><span style=3D"font-size:12.8px"><font color=3D"#000000"><br></font></sp=
an></span></span></div><div style=3D"font-family:arial,sans-serif;font-size=
:12.8px;font-style:normal;font-variant-ligatures:normal;font-variant-caps:n=
ormal;font-weight:400;letter-spacing:normal;text-transform:none;white-space=
:normal;word-spacing:0px"><span style=3D"text-align:start;text-indent:0px;t=
ext-decoration-style:initial;text-decoration-color:initial;float:none;displ=
ay:inline"><span style=3D"background-color:rgb(255,255,255)"><font color=3D=
"#000000"><span style=3D"font-size:12.8px">2) Babeltrace to convert the CTF=
 traces to=C2=A0</span><span style=3D"text-align:start;text-indent:0px;back=
ground-color:rgb(255,255,255);text-decoration-style:initial;text-decoration=
-color:initial;float:none;display:inline"><span style=3D"font-size:12.8px">=
a human readable=C2=A0text.</span></span></font></span></span></div><div st=
yle=3D"font-family:arial,sans-serif;font-size:12.8px;font-style:normal;font=
-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-s=
pacing:normal;text-transform:none;white-space:normal;word-spacing:0px;backg=
round-color:rgb(255,255,255)"><font color=3D"#000000"><br></font></div><div=
 style=3D"font-family:arial,sans-serif;font-size:12.8px;font-style:normal;f=
ont-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;lette=
r-spacing:normal;text-transform:none;white-space:normal;word-spacing:0px;ba=
ckground-color:rgb(255,255,255)"><font color=3D"#000000"><span style=3D"bac=
kground-color:rgb(247,247,247);font-family:Cabin,sans-serif;font-size:12.8p=
x">Now,=C2=A0</span><span style=3D"font-size:12.8px">I aim to develop a pat=
ch to the Babeltrace. Instead of printing the traces on the console or in a=
 file,=C2=A0</span></font><span style=3D"color:rgb(0,0,0)">I would like=C2=
=A0</span><span style=3D"color:rgb(0,0,0);font-size:small">to send the trac=
es over TCP/IP to a third-party tool for processing.</span></div><div style=
=3D"background-color:rgb(255,255,255)"><font color=3D"#000000">My third-par=
ty tool is installed on a windows machine. For this reason, the use of LTTn=
g relay daemon=C2=A0will not be a good solution.</font></div><div style=3D"=
font-family:arial,sans-serif;font-size:12.8px;font-style:normal;font-varian=
t-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:=
normal;text-transform:none;white-space:normal;word-spacing:0px;background-c=
olor:rgb(255,255,255)"><br></div></div><font color=3D"#000000" style=3D"fon=
t-family:arial,sans-serif;font-size:12.8px;font-style:normal;font-variant-l=
igatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:nor=
mal;text-transform:none;white-space:normal;word-spacing:0px">My question is=
 the following:</font></div><div style=3D"color:rgb(34,34,34);font-family:a=
rial,sans-serif;font-size:12.8px;font-style:normal;font-variant-ligatures:n=
ormal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-a=
lign:start;text-indent:0px;text-transform:none;white-space:normal;word-spac=
ing:0px;text-decoration-style:initial;text-decoration-color:initial;backgro=
und-color:rgb(255,255,255)"><font color=3D"#000000"><br></font></div><div s=
tyle=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:12.8px;f=
ont-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;fon=
t-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-tr=
ansform:none;white-space:normal;word-spacing:0px;text-decoration-style:init=
ial;text-decoration-color:initial;background-color:rgb(255,255,255)"><font =
color=3D"#000000">To which file (of the Babeltrace=C2=A0source code) should=
 I make changes to answer my use case?<br></font></div><div style=3D"color:=
rgb(34,34,34);font-family:arial,sans-serif;font-size:12.8px;font-style:norm=
al;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;l=
etter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;w=
hite-space:normal;word-spacing:0px;text-decoration-style:initial;text-decor=
ation-color:initial;background-color:rgb(255,255,255)"><font color=3D"#0000=
00"><br></font></div><div style=3D"color:rgb(34,34,34);font-family:arial,sa=
ns-serif;font-size:12.8px;font-style:normal;font-variant-ligatures:normal;f=
ont-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:st=
art;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px=
;text-decoration-style:initial;text-decoration-color:initial;background-col=
or:rgb(255,255,255)"><font color=3D"#000000">Best regards,</font></div><br>=
<div class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=
=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div dir=3D"ltr"><div =
dir=3D"ltr" style=3D"font-size:12.8px"><div dir=3D"ltr"><span style=3D"font=
-size:12.8px"><font color=3D"#444444">-------------------------------------=
----------------------------------------------------</font></span></div><di=
v dir=3D"ltr"><font color=3D"#444444" face=3D"arial, helvetica, sans-serif"=
 size=3D"2"><br></font></div><div dir=3D"ltr"><font color=3D"#444444" face=
=3D"arial, helvetica, sans-serif" size=3D"2">Nesrine ZOUARI</font></div><di=
v dir=3D"ltr"><font color=3D"#444444" face=3D"arial, helvetica, sans-serif"=
 size=3D"2">Computer Engineering Student=C2=A0<br></font></div><div dir=3D"=
ltr"><font color=3D"#444444" face=3D"arial, helvetica, sans-serif" size=3D"=
2">Department of Computer Engineering and Applied Mathematics</font></div><=
div dir=3D"ltr"><span style=3D"color:rgb(68,68,68);font-family:arial,helvet=
ica,sans-serif;font-size:small">National Engineering School=C2=A0of=C2=A0Sf=
ax (ENIS)</span></div><div dir=3D"ltr"><div dir=3D"ltr" style=3D"font-size:=
12.8px;margin:0px;padding:0px;border:0px"><font color=3D"#444444"><font sty=
le=3D"margin:0px;padding:0px;border:0px" face=3D"arial, helvetica, sans-ser=
if" size=3D"2">University of Sfax-</font><span style=3D"font-family:arial,h=
elvetica,sans-serif;font-size:small">Tunisia<br></span></font></div><div st=
yle=3D"font-size:12.8px;margin:0px;padding:0px;border:0px none"><font color=
=3D"#444444"><span style=3D"font-family:arial,helvetica,sans-serif;font-siz=
e:small">Tel: +216 52 620 475<br></span></font></div><div dir=3D"ltr" style=
=3D"font-size:12.8px;margin:0px;padding:0px;border:0px"><font color=3D"#444=
444"><span style=3D"font-family:arial,helvetica,sans-serif;font-size:small"=
><br></span></font></div><div><font color=3D"#444444"><span style=3D"font-f=
amily:arial,helvetica,sans-serif;font-size:small"><br></span></font></div><=
/div></div></div></div></div></div></div></div></div>
=E2=80=8C</div>

--001a1140cfc4c5f1ce0569918c99--

--===============6042268861973963851==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============6042268861973963851==--
