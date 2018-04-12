From: Nesrine Zouari <nesrine.zouari@enis.tn>
Subject: Re: Babeltrace Patch
Date: Thu, 12 Apr 2018 09:48:16 +0100
Message-ID: <CAPHFV4kM+6woCshhKR=_kTS6TO5++fEArer0FEZhdn6Y6=FXLA__142.303753136908$1523522812$gmane$org@mail.gmail.com>
References: <CAPHFV4no6vfu0HV-D9Fy0HwGnuN84LT-4m3yLV_9ZOjqA+ytqQ@mail.gmail.com>
 <d0e120c7-1c29-271f-fbff-2b8023b6e75b@versatic.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5341349309496598820=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt0-x232.google.com (mail-qt0-x232.google.com
 [IPv6:2607:f8b0:400d:c0d::232])
 by lists.lttng.org (Postfix) with ESMTPS id 40MF1r1wXgz156T
 for <lttng-dev@lists.lttng.org>; Thu, 12 Apr 2018 04:48:47 -0400 (EDT)
Received: by mail-qt0-x232.google.com with SMTP id w23so5327707qtn.3
 for <lttng-dev@lists.lttng.org>; Thu, 12 Apr 2018 01:48:47 -0700 (PDT)
In-Reply-To: <d0e120c7-1c29-271f-fbff-2b8023b6e75b@versatic.net>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: =?UTF-8?Q?Genevi=C3=A8ve_Bastien?= <gbastien@versatic.net>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============5341349309496598820==
Content-Type: multipart/alternative; boundary="001a114f2fcedd94980569a2d2f5"

--001a114f2fcedd94980569a2d2f5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for your response Genevi=C3=A8ve.

I have already tried Tracecompass and lttng-scope and they match exactly my
project use case.

But as I said in the beginning, I am working on my *graduation project* and
I have to develop *client/server applications communicating through TCP
socket (in C language).*

This is a short description of my project requirements:
My project is divided into two parts:

*      1)* Collecting traces from Qemu (It is already an instrumented user
space application).

*       2)* Sending the collected traces to a third-party tool for analysis=
.

* Qemu, LTTng demons and my server application are running on the same
Linux machine.

* The client application is running on a remote WINDOWS machine.
   Client is able now to control the trace remotely (start and stop) and
get the trace collected in a text file.


*This is what I am trying to do right now:*

Instead of writing the traces to a text file, I would like to send those
traces over TCP to my client application.
So I think that the problem now is* how to make Babeltrace convert CTF
traces and send them to my client application through TCP.*

I would be grateful if you will give me some hints or another idea to
satisfy my project requirements.

Best regards,


=E2=80=8C

On Wed, Apr 11, 2018 at 4:37 PM, Genevi=C3=A8ve Bastien <gbastien@versatic.=
net>
wrote:

> Hi Nesrine,
>
>
> I don't know about babeltrace over TCP/IP. But there are tools to read
> lttng traces on Windows: Trace Compass [1] can read and analyse a trace
> with all kind of data driven analyzes. It can also control a tracing
> session [2] and bring the trace on your windows machine. There's also
> lttng-scope that reads CTF traces on Windows [3].
>
> [1] http://tracecompass.org
> [2] http://archive.eclipse.org/tracecompass/doc/stable/org.
> eclipse.tracecompass.doc.user/LTTng-Tracer-Control.html#
> LTTng_Tracer_Control
> [3] https://lttng.org/beta/
>
> Cheers,
>
> Genevi=C3=A8ve
>
>
>
> On 2018-04-11 08:11 AM, Nesrine Zouari wrote:
>
> Hello,
>
> I am computer engineering student and I am actually working on my
> graduation project which is about Qemu Trace.
>
> In this project, Qemu is considered as a user-space instrumented
> application.
>
> I have used:
>
> 1) LTTng-Tools to control Qemu trace.
>
> 2) Babeltrace to convert the CTF traces to a human readable text.
>
> Now, I aim to develop a patch to the Babeltrace. Instead of printing the
> traces on the console or in a file, I would like to send the traces over
> TCP/IP to a third-party tool for processing.
> My third-party tool is installed on a windows machine. For this reason,
> the use of LTTng relay daemon will not be a good solution.
>
> My question is the following:
>
> To which file (of the Babeltrace source code) should I make changes to
> answer my use case?
>
> Best regards,
>
> ------------------------------------------------------------
> -----------------------------
>
> Nesrine ZOUARI
> Computer Engineering Student
> Department of Computer Engineering and Applied Mathematics
> National Engineering School of Sfax (ENIS)
> University of Sfax-Tunisia
> Tel: +216 52 620 475
>
>
> =E2=80=8C
>
>
> _______________________________________________
> lttng-dev mailing listlttng-dev@lists.lttng.orghttps://lists.lttng.org/cg=
i-bin/mailman/listinfo/lttng-dev
>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>


--=20
---------------------------------------------------------------------------=
--------------

Nesrine ZOUARI
Computer Engineering Student
Department of Computer Engineering and Applied Mathematics
National Engineering School of Sfax (ENIS)
University of Sfax-Tunisia
Tel: +216 52 620 475

--001a114f2fcedd94980569a2d2f5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><img width=3D"0" height=3D"0" class=3D"mailtrack-img" alt=
=3D"" style=3D"display:flex" src=3D"https://mailtrack.io/trace/mail/1f553b1=
316d97791e0bc4b24eef0b2451aae073d.png?u=3D2189147"><div></div><div><div sty=
le=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-style:normal;fo=
nt-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter=
-spacing:normal;text-align:start;text-indent:0px;text-transform:none;white-=
space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decora=
tion-style:initial;text-decoration-color:initial;font-size:small"><span sty=
le=3D"font-family:arial,sans-serif;font-size:12.8px;font-style:normal;font-=
variant-ligatures:normal;font-variant-caps:normal;letter-spacing:normal;tex=
t-align:start;text-indent:0px;text-transform:none;white-space:normal;word-s=
pacing:0px;background-color:rgb(255,255,255);text-decoration-style:initial;=
text-decoration-color:initial;float:none;display:inline"><font color=3D"#00=
0000">Thank you for your response Genevi=C3=A8ve.</font></span></div><font =
color=3D"#000000" style=3D"font-family:arial,sans-serif;font-style:normal;f=
ont-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;lette=
r-spacing:normal;text-align:start;text-indent:0px;text-transform:none;white=
-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decor=
ation-style:initial;text-decoration-color:initial;font-size:small"></font><=
div style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-style:no=
rmal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400=
;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:none=
;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text=
-decoration-style:initial;text-decoration-color:initial;font-size:small"><s=
pan style=3D"font-family:arial,sans-serif;font-size:12.8px;font-style:norma=
l;font-variant-ligatures:normal;font-variant-caps:normal;letter-spacing:nor=
mal;text-align:start;text-indent:0px;text-transform:none;white-space:normal=
;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:i=
nitial;text-decoration-color:initial;float:none;display:inline"><font color=
=3D"#000000"><br></font></span></div><div style=3D"color:rgb(34,34,34);font=
-family:arial,sans-serif;font-style:normal;font-variant-ligatures:normal;fo=
nt-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:sta=
rt;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;=
background-color:rgb(255,255,255);text-decoration-style:initial;text-decora=
tion-color:initial;font-size:small"><span style=3D"font-family:arial,sans-s=
erif;font-size:12.8px;font-style:normal;font-variant-ligatures:normal;font-=
variant-caps:normal;letter-spacing:normal;text-align:start;text-indent:0px;=
text-transform:none;white-space:normal;word-spacing:0px;background-color:rg=
b(255,255,255);text-decoration-style:initial;text-decoration-color:initial;=
float:none;display:inline"><font color=3D"#000000">I have already tried Tra=
cecompass and=C2=A0<span style=3D"font-family:arial,sans-serif;font-size:12=
.8px;font-style:normal;font-variant-ligatures:normal;font-variant-caps:norm=
al;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:no=
ne;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);te=
xt-decoration-style:initial;text-decoration-color:initial;float:none;displa=
y:inline">lttng-scope and they match exactly my project use case.=C2=A0</sp=
an></font></span></div><div style=3D"color:rgb(34,34,34);font-family:arial,=
sans-serif;font-style:normal;font-variant-ligatures:normal;font-variant-cap=
s:normal;font-weight:400;letter-spacing:normal;text-align:start;text-indent=
:0px;text-transform:none;white-space:normal;word-spacing:0px;background-col=
or:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:ini=
tial;font-size:small"><span style=3D"font-family:arial,sans-serif;font-size=
:12.8px;font-style:normal;font-variant-ligatures:normal;font-variant-caps:n=
ormal;letter-spacing:normal;text-align:start;text-indent:0px;text-transform=
:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255)=
;text-decoration-style:initial;text-decoration-color:initial;float:none;dis=
play:inline"><font color=3D"#000000"><span style=3D"font-family:arial,sans-=
serif;font-size:12.8px;font-style:normal;font-variant-ligatures:normal;font=
-variant-caps:normal;letter-spacing:normal;text-align:start;text-indent:0px=
;text-transform:none;white-space:normal;word-spacing:0px;background-color:r=
gb(255,255,255);text-decoration-style:initial;text-decoration-color:initial=
;float:none;display:inline"><br>But as I said in the beginning, I am workin=
g on my<span>=C2=A0</span><b>graduation project</b><span>=C2=A0</span>and I=
 have to develop<span>=C2=A0</span><b><span style=3D"font-family:arial,sans=
-serif;font-size:12.8px;font-style:normal;font-variant-ligatures:normal;fon=
t-variant-caps:normal;letter-spacing:normal;text-align:start;text-indent:0p=
x;text-transform:none;white-space:normal;word-spacing:0px;background-color:=
rgb(255,255,255);text-decoration-style:initial;text-decoration-color:initia=
l;float:none;display:inline">client/server applications communicating throu=
gh TCP socket (</span>in C language).</b></span></font></span></div><div st=
yle=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-style:normal;f=
ont-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;lette=
r-spacing:normal;text-align:start;text-indent:0px;text-transform:none;white=
-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decor=
ation-style:initial;text-decoration-color:initial;font-size:small"><span st=
yle=3D"font-family:arial,sans-serif;font-size:12.8px;font-style:normal;font=
-variant-ligatures:normal;font-variant-caps:normal;letter-spacing:normal;te=
xt-align:start;text-indent:0px;text-transform:none;white-space:normal;word-=
spacing:0px;background-color:rgb(255,255,255);text-decoration-style:initial=
;text-decoration-color:initial;float:none;display:inline"><font color=3D"#0=
00000"><span style=3D"font-family:arial,sans-serif;font-size:12.8px;font-st=
yle:normal;font-variant-ligatures:normal;font-variant-caps:normal;letter-sp=
acing:normal;text-align:start;text-indent:0px;text-transform:none;white-spa=
ce:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decoratio=
n-style:initial;text-decoration-color:initial;float:none;display:inline"><b=
r></span></font></span></div><div style=3D"color:rgb(34,34,34);font-family:=
arial,sans-serif;font-style:normal;font-variant-ligatures:normal;font-varia=
nt-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-=
indent:0px;text-transform:none;white-space:normal;word-spacing:0px;backgrou=
nd-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-col=
or:initial;font-size:small"><span style=3D"font-family:arial,sans-serif;fon=
t-size:12.8px;font-style:normal;font-variant-ligatures:normal;font-variant-=
caps:normal;letter-spacing:normal;text-align:start;text-indent:0px;text-tra=
nsform:none;white-space:normal;word-spacing:0px;background-color:rgb(255,25=
5,255);text-decoration-style:initial;text-decoration-color:initial;float:no=
ne;display:inline"><font color=3D"#000000"><span style=3D"font-family:arial=
,sans-serif;font-size:12.8px;font-style:normal;font-variant-ligatures:norma=
l;font-variant-caps:normal;letter-spacing:normal;text-align:start;text-inde=
nt:0px;text-transform:none;white-space:normal;word-spacing:0px;background-c=
olor:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:i=
nitial;float:none;display:inline">This is a short description of my project=
 requirements:=C2=A0</span></font></span></div><div style=3D"color:rgb(34,3=
4,34);font-family:arial,sans-serif;font-style:normal;font-variant-ligatures=
:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text=
-align:start;text-indent:0px;text-transform:none;white-space:normal;word-sp=
acing:0px;background-color:rgb(255,255,255);text-decoration-style:initial;t=
ext-decoration-color:initial;font-size:small"><span style=3D"font-size:12.8=
px;color:rgb(0,0,0)">My project is divided into two parts:</span><br></div>=
<div style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:12=
.8px;font-style:normal;font-variant-ligatures:normal;font-variant-caps:norm=
al;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;t=
ext-transform:none;white-space:normal;word-spacing:0px;text-decoration-styl=
e:initial;text-decoration-color:initial;background-color:rgb(255,255,255)">=
<font color=3D"#000000"><div style=3D"color:rgb(34,34,34);font-family:arial=
,sans-serif;font-size:12.8px;font-style:normal;font-variant-ligatures:norma=
l;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align=
:start;text-indent:0px;text-transform:none;white-space:normal;word-spacing:=
0px;background-color:rgb(255,255,255);text-decoration-style:initial;text-de=
coration-color:initial"><font color=3D"#000000"><br style=3D"font-family:ar=
ial,sans-serif;font-size:12.8px;font-style:normal;font-variant-ligatures:no=
rmal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-al=
ign:start;text-indent:0px;text-transform:none;white-space:normal;word-spaci=
ng:0px;background-color:rgb(255,255,255);text-decoration-style:initial;text=
-decoration-color:initial"><span style=3D"text-align:start;text-indent:0px;=
background-color:rgb(255,255,255);text-decoration-style:initial;text-decora=
tion-color:initial;float:none;display:inline"><span style=3D"font-size:12.8=
px"><b>=C2=A0 =C2=A0 =C2=A0 1)</b><span>=C2=A0</span>Collecting traces from=
 Qemu (It is already an instrumented user space=C2=A0application).</span></=
span></font></div><div style=3D"color:rgb(34,34,34);font-family:arial,sans-=
serif;font-size:12.8px;font-style:normal;font-variant-ligatures:normal;font=
-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start=
;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;ba=
ckground-color:rgb(255,255,255);text-decoration-style:initial;text-decorati=
on-color:initial"><font color=3D"#000000"><br style=3D"font-family:arial,sa=
ns-serif;font-size:12.8px;font-style:normal;font-variant-ligatures:normal;f=
ont-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:st=
art;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px=
;background-color:rgb(255,255,255);text-decoration-style:initial;text-decor=
ation-color:initial"><span style=3D"font-family:arial,sans-serif;font-size:=
12.8px;font-style:normal;font-variant-ligatures:normal;font-variant-caps:no=
rmal;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:=
none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);=
text-decoration-style:initial;text-decoration-color:initial;float:none;disp=
lay:inline"><b>=C2=A0 =C2=A0 =C2=A0 =C2=A02)</b></span><span style=3D"font-=
family:arial,sans-serif;font-size:12.8px;font-style:normal;font-variant-lig=
atures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:norma=
l;text-align:start;text-indent:0px;text-transform:none;white-space:normal;w=
ord-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:ini=
tial;text-decoration-color:initial;float:none;display:inline"><span>=C2=A0<=
/span>Sending the collected traces to a third-party tool for analysis.</spa=
n><br></font></div><br></font></div><div style=3D"color:rgb(34,34,34);font-=
family:arial,sans-serif;font-size:12.8px;font-style:normal;font-variant-lig=
atures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:norma=
l;text-align:start;text-indent:0px;text-transform:none;white-space:normal;w=
ord-spacing:0px;text-decoration-style:initial;text-decoration-color:initial=
;background-color:rgb(255,255,255)"><font color=3D"#000000">* Qemu,=C2=A0LT=
Tng demons and my server application are running on the same Linux machine.=
</font></div><div style=3D"color:rgb(34,34,34);font-family:arial,sans-serif=
;font-size:12.8px;font-style:normal;font-variant-ligatures:normal;font-vari=
ant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text=
-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-de=
coration-style:initial;text-decoration-color:initial;background-color:rgb(2=
55,255,255)"><font color=3D"#000000"><br></font></div><div style=3D"color:r=
gb(34,34,34);font-family:arial,sans-serif;font-size:12.8px;font-style:norma=
l;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;le=
tter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;wh=
ite-space:normal;word-spacing:0px;text-decoration-style:initial;text-decora=
tion-color:initial;background-color:rgb(255,255,255)"><span style=3D"color:=
rgb(0,0,0)">* The client application is running on a remote WINDOWS machine=
.=C2=A0</span></div><div style=3D"color:rgb(34,34,34);font-family:arial,san=
s-serif;font-size:12.8px;font-style:normal;font-variant-ligatures:normal;fo=
nt-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:sta=
rt;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;=
text-decoration-style:initial;text-decoration-color:initial;background-colo=
r:rgb(255,255,255)"><font color=3D"#000000">=C2=A0 =C2=A0Client is able now=
 to control the trace remotely (start and stop) and get the trace=C2=A0</fo=
nt><span style=3D"color:rgb(0,0,0)">collected in a text file.</span></div><=
div style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:12.=
8px;font-style:normal;font-variant-ligatures:normal;font-variant-caps:norma=
l;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;te=
xt-transform:none;white-space:normal;word-spacing:0px;text-decoration-style=
:initial;text-decoration-color:initial;background-color:rgb(255,255,255)"><=
font color=3D"#000000"><span style=3D"font-family:arial,sans-serif;font-siz=
e:12.8px;font-style:normal;font-variant-ligatures:normal;font-variant-caps:=
normal;letter-spacing:normal;text-align:start;text-indent:0px;text-transfor=
m:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255=
);text-decoration-style:initial;text-decoration-color:initial;float:none;di=
splay:inline"><br></span></font></div><div style=3D"color:rgb(34,34,34);fon=
t-family:arial,sans-serif;font-size:12.8px;font-style:normal;font-variant-l=
igatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:nor=
mal;text-align:start;text-indent:0px;text-transform:none;white-space:normal=
;word-spacing:0px;text-decoration-style:initial;text-decoration-color:initi=
al;background-color:rgb(255,255,255)"><font color=3D"#000000">=C2=A0 =C2=A0=
 =C2=A0 =C2=A0</font></div><div style=3D"color:rgb(34,34,34);font-family:ar=
ial,sans-serif;font-size:12.8px;font-style:normal;font-variant-ligatures:no=
rmal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-al=
ign:start;text-indent:0px;text-transform:none;white-space:normal;word-spaci=
ng:0px;text-decoration-style:initial;text-decoration-color:initial;backgrou=
nd-color:rgb(255,255,255)"><font color=3D"#000000"><b>This is what I am try=
ing to do right now:</b></font></div><div style=3D"color:rgb(34,34,34);font=
-family:arial,sans-serif;font-size:12.8px;font-style:normal;font-variant-li=
gatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:norm=
al;text-align:start;text-indent:0px;text-transform:none;white-space:normal;=
word-spacing:0px;text-decoration-style:initial;text-decoration-color:initia=
l;background-color:rgb(255,255,255)"><span style=3D"font-size:12.8px"><font=
 color=3D"#000000"><br></font></span></div><div style=3D"color:rgb(34,34,34=
);font-family:arial,sans-serif;font-size:12.8px;font-style:normal;font-vari=
ant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacin=
g:normal;text-align:start;text-indent:0px;text-transform:none;white-space:n=
ormal;word-spacing:0px;text-decoration-style:initial;text-decoration-color:=
initial;background-color:rgb(255,255,255)"><font color=3D"#000000"><span st=
yle=3D"font-size:12.8px">Instead of writing the traces to a text file,=C2=
=A0</span>I would like=C2=A0<span style=3D"font-size:small">to send those t=
races over TCP to my client application.</span></font></div><div style=3D"c=
olor:rgb(34,34,34);font-family:arial,sans-serif;font-size:12.8px;font-style=
:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:=
400;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:n=
one;white-space:normal;word-spacing:0px;text-decoration-style:initial;text-=
decoration-color:initial;background-color:rgb(255,255,255)"><font color=3D"=
#000000"><span style=3D"font-size:small"><span style=3D"color:rgb(0,0,0);fo=
nt-family:arial,sans-serif;font-size:12.8px;font-style:normal;font-variant-=
ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:no=
rmal;text-align:start;text-indent:0px;text-transform:none;white-space:norma=
l;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:=
initial;text-decoration-color:initial;float:none;display:inline">So I think=
 that the problem now is</span><span style=3D"color:rgb(0,0,0);font-family:=
arial,sans-serif;font-size:12.8px;font-style:normal;font-variant-ligatures:=
normal;font-variant-caps:normal;letter-spacing:normal;text-align:start;text=
-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;backgro=
und-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-co=
lor:initial;float:none;display:inline"><b><span>=C2=A0</span>how to make Ba=
beltrace convert CTF traces and send them to my client application through =
TCP.</b></span><br></span></font></div><br class=3D"gmail-m_917832856897988=
5764gmail-Apple-interchange-newline" style=3D"color:rgb(34,34,34);font-fami=
ly:arial,sans-serif;font-style:normal;font-variant-ligatures:normal;font-va=
riant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;te=
xt-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;backg=
round-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-=
color:initial;font-size:small"><span style=3D"font-family:arial,sans-serif;=
font-size:12.8px;font-style:normal;font-variant-ligatures:normal;font-varia=
nt-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-=
indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-dec=
oration-style:initial;text-decoration-color:initial;background-color:rgb(25=
5,255,255);color:rgb(0,0,0);float:none;display:inline">I would be grateful =
if you will give me some hints or another idea to satisfy my project requir=
ements.</span></div><div><br style=3D"font-family:arial,sans-serif;font-siz=
e:12.8px;font-style:normal;font-variant-ligatures:normal;font-variant-caps:=
normal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0=
px;text-transform:none;white-space:normal;word-spacing:0px;background-color=
:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:initi=
al;color:rgb(0,0,0)"><span style=3D"font-family:arial,sans-serif;font-size:=
12.8px;font-style:normal;font-variant-ligatures:normal;font-variant-caps:no=
rmal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px=
;text-transform:none;white-space:normal;word-spacing:0px;text-decoration-st=
yle:initial;text-decoration-color:initial;background-color:rgb(255,255,255)=
;color:rgb(0,0,0);float:none;display:inline">Best regards,</span><br></div>=
<br><br>=E2=80=8C</div><div class=3D"gmail_extra"><br><div class=3D"gmail_q=
uote">On Wed, Apr 11, 2018 at 4:37 PM, Genevi=C3=A8ve Bastien <span dir=3D"=
ltr">&lt;<a href=3D"mailto:gbastien@versatic.net" target=3D"_blank">gbastie=
n@versatic.net</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
 =20
   =20
 =20
  <div text=3D"#000000" bgcolor=3D"#FFFFFF">
    <p>Hi Nesrine,</p>
    <p><br>
    </p>
    <p>I don&#39;t know about babeltrace over TCP/IP. But there are tools t=
o
      read lttng traces on Windows: Trace Compass [1] can read and
      analyse a trace with all kind of data driven analyzes. It can also
      control a tracing session [2] and bring the trace on your windows
      machine. There&#39;s also lttng-scope that reads CTF traces on Window=
s
      [3]. <br>
    </p>
    <p>[1] <a class=3D"m_-1937269249166450159moz-txt-link-freetext" href=3D=
"http://tracecompass.org" target=3D"_blank">http://tracecompass.org</a><br>
      [2]
<a class=3D"m_-1937269249166450159moz-txt-link-freetext" href=3D"http://arc=
hive.eclipse.org/tracecompass/doc/stable/org.eclipse.tracecompass.doc.user/=
LTTng-Tracer-Control.html#LTTng_Tracer_Control" target=3D"_blank">http://ar=
chive.eclipse.org/<wbr>tracecompass/doc/stable/org.<wbr>eclipse.tracecompas=
s.doc.user/<wbr>LTTng-Tracer-Control.html#<wbr>LTTng_Tracer_Control</a><br>
      [3] <a class=3D"m_-1937269249166450159moz-txt-link-freetext" href=3D"=
https://lttng.org/beta/" target=3D"_blank">https://lttng.org/beta/</a></p>
    <p>Cheers,</p>
    <p>Genevi=C3=A8ve<br>
    </p><div><div class=3D"h5">
    <br>
    <br>
    <br>
    <div class=3D"m_-1937269249166450159moz-cite-prefix">On 2018-04-11 08:1=
1 AM, Nesrine Zouari
      wrote:<br>
    </div>
    </div></div><blockquote type=3D"cite"><div><div class=3D"h5">
      <div dir=3D"ltr"><img class=3D"m_-1937269249166450159mailtrack-img" a=
lt=3D"" style=3D"display:flex" src=3D"data:image/gif;base64,R0lGODlhAQABAIA=
AAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" width=3D"0" height=3D"0">
        <div style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font=
-size:12.8px;font-style:normal;font-variant-ligatures:normal;font-variant-c=
aps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-inde=
nt:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decorat=
ion-style:initial;text-decoration-color:initial;background-color:rgb(255,25=
5,255)"><span style=3D"font-family:arial,sans-serif;font-size:12.8px;font-s=
tyle:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-wei=
ght:400;letter-spacing:normal;text-transform:none;white-space:normal;word-s=
pacing:0px;text-align:start;text-indent:0px;text-decoration-style:initial;t=
ext-decoration-color:initial;background-color:rgb(255,255,255);float:none;d=
isplay:inline"><font color=3D"#000000">Hello,</font></span>
          <div style=3D"font-family:arial,sans-serif;font-size:12.8px;font-=
style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-we=
ight:400;letter-spacing:normal;text-transform:none;white-space:normal;word-=
spacing:0px;text-align:start;text-indent:0px;text-decoration-style:initial;=
text-decoration-color:initial;background-color:rgb(255,255,255)"><span styl=
e=3D"font-family:arial,sans-serif;font-style:normal;font-variant-ligatures:=
normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-=
align:start;text-indent:0px;text-transform:none;white-space:normal;word-spa=
cing:0px;background-color:rgb(255,255,255);text-decoration-style:initial;te=
xt-decoration-color:initial;float:none;display:inline"><font color=3D"#0000=
00"><br>
              </font></span></div>
          <div style=3D"font-family:arial,sans-serif;font-size:12.8px;font-=
style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-we=
ight:400;letter-spacing:normal;text-transform:none;white-space:normal;word-=
spacing:0px;text-align:start;text-indent:0px;text-decoration-style:initial;=
text-decoration-color:initial;background-color:rgb(255,255,255)"><font colo=
r=3D"#000000"><span style=3D"font-family:arial,sans-serif;font-style:normal=
;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;let=
ter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;whi=
te-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-dec=
oration-style:initial;text-decoration-color:initial;float:none;display:inli=
ne">I
                am computer engineering student and I am actually
                working on my graduation project which is about<span>=C2=A0=
</span></span><span class=3D"m_-1937269249166450159gmail-m_-599006575892724=
4463gmail-m_6820945704080840124gmail-m_-6755159426057962638gmail-m_32269805=
21649496158gmail-m_4311176812459725481gmail-m_3469504987072534619gmail-m_-2=
143354602622622349gmail-m_5367336902020713707gmail-m_567988643051350633gmai=
l-m_-2504658086804125746m_-670507402164016222gmail-il" style=3D"font-family=
:arial,sans-serif;font-style:normal;font-variant-ligatures:normal;font-vari=
ant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text=
-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;backgro=
und-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-co=
lor:initial">Qemu</span><span style=3D"font-family:arial,sans-serif;font-st=
yle:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weig=
ht:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transfor=
m:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255=
);text-decoration-style:initial;text-decoration-color:initial;float:none;di=
splay:inline"><span>=C2=A0</span>Trace.=C2=A0</span></font></div>
          <div style=3D"text-align:start;text-indent:0px;text-decoration-st=
yle:initial;text-decoration-color:initial"><font style=3D"font-family:arial=
,sans-serif;font-size:12.8px;font-style:normal;font-variant-ligatures:norma=
l;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-trans=
form:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,=
255)" color=3D"#000000"><br>
            </font>
            <div style=3D"font-family:arial,sans-serif;font-size:12.8px;fon=
t-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-=
weight:400;letter-spacing:normal;text-transform:none;white-space:normal;wor=
d-spacing:0px"><span style=3D"text-align:start;text-indent:0px;text-decorat=
ion-style:initial;text-decoration-color:initial;float:none;display:inline">=
<font color=3D"#000000"><font style=3D"font-style:normal;font-variant-ligat=
ures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;=
text-transform:none;white-space:normal;word-spacing:0px;font-family:arial,s=
ans-serif;font-size:12.8px;background-color:rgb(255,255,255)"><span style=
=3D"font-size:12.8px">In this project, Qemu is<span>=C2=A0</span></span></f=
ont><span style=3D"font-style:normal;font-variant-ligatures:normal;font-var=
iant-caps:normal;font-weight:400;letter-spacing:normal;text-transform:none;=
white-space:normal;word-spacing:0px;font-family:arial,sans-serif;font-size:=
12.8px;background-color:rgb(255,255,255)">considered</span><font><span styl=
e=3D"background-color:rgb(255,255,255)"><span style=3D"font-size:12.8px">=
=C2=A0as a user-space
                        instrumented application.=C2=A0</span></span></font=
></font></span></div>
            <div style=3D"font-family:arial,sans-serif;font-size:12.8px;fon=
t-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-=
weight:400;letter-spacing:normal;text-transform:none;white-space:normal;wor=
d-spacing:0px"><span style=3D"text-align:start;text-indent:0px;text-decorat=
ion-style:initial;text-decoration-color:initial;float:none;display:inline">=
<span style=3D"background-color:rgb(255,255,255)"><span style=3D"font-size:=
12.8px"><font color=3D"#000000"><br>
                    </font></span></span></span></div>
            <div style=3D"font-family:arial,sans-serif;font-size:12.8px;fon=
t-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-=
weight:400;letter-spacing:normal;text-transform:none;white-space:normal;wor=
d-spacing:0px"><span style=3D"text-align:start;text-indent:0px;text-decorat=
ion-style:initial;text-decoration-color:initial;float:none;display:inline">=
<span style=3D"background-color:rgb(255,255,255)"><span style=3D"font-size:=
12.8px"><font color=3D"#000000">I
                      have used:</font></span></span></span></div>
            <div style=3D"font-family:arial,sans-serif;font-size:12.8px;fon=
t-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-=
weight:400;letter-spacing:normal;text-transform:none;white-space:normal;wor=
d-spacing:0px"><span style=3D"text-align:start;text-indent:0px;text-decorat=
ion-style:initial;text-decoration-color:initial;float:none;display:inline">=
<span style=3D"background-color:rgb(255,255,255)"><span class=3D"m_-1937269=
249166450159gmail-m_-5990065758927244463gmail-m_6820945704080840124gmail-m_=
-6755159426057962638gmail-m_3226980521649496158gmail-m_4311176812459725481g=
mail-m_3469504987072534619gmail-il" style=3D"font-family:arial,sans-serif;f=
ont-size:12.8px;font-style:normal;font-variant-ligatures:normal;font-varian=
t-caps:normal;font-weight:400;letter-spacing:normal;text-transform:none;whi=
te-space:normal;word-spacing:0px"><font color=3D"#000000"><br>
                    </font></span></span></span></div>
            <div style=3D"font-family:arial,sans-serif;font-size:12.8px;fon=
t-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-=
weight:400;letter-spacing:normal;text-transform:none;white-space:normal;wor=
d-spacing:0px"><span style=3D"text-align:start;text-indent:0px;text-decorat=
ion-style:initial;text-decoration-color:initial;float:none;display:inline">=
<span style=3D"background-color:rgb(255,255,255)"><font color=3D"#000000"><=
span class=3D"m_-1937269249166450159gmail-m_-5990065758927244463gmail-m_682=
0945704080840124gmail-m_-6755159426057962638gmail-m_3226980521649496158gmai=
l-m_4311176812459725481gmail-m_3469504987072534619gmail-il" style=3D"font-f=
amily:arial,sans-serif;font-size:12.8px;font-style:normal;font-variant-liga=
tures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal=
;text-transform:none;white-space:normal;word-spacing:0px">1)
                      LTTng</span><span style=3D"font-size:12.8px">-Tools
                      to control Qemu trace.=C2=A0</span></font></span></sp=
an></div>
            <div style=3D"font-family:arial,sans-serif;font-size:12.8px;fon=
t-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-=
weight:400;letter-spacing:normal;text-transform:none;white-space:normal;wor=
d-spacing:0px"><span style=3D"text-align:start;text-indent:0px;text-decorat=
ion-style:initial;text-decoration-color:initial;float:none;display:inline">=
<span style=3D"background-color:rgb(255,255,255)"><span style=3D"font-size:=
12.8px"><font color=3D"#000000"><br>
                    </font></span></span></span></div>
            <div style=3D"font-family:arial,sans-serif;font-size:12.8px;fon=
t-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-=
weight:400;letter-spacing:normal;text-transform:none;white-space:normal;wor=
d-spacing:0px"><span style=3D"text-align:start;text-indent:0px;text-decorat=
ion-style:initial;text-decoration-color:initial;float:none;display:inline">=
<span style=3D"background-color:rgb(255,255,255)"><font color=3D"#000000"><=
span style=3D"font-size:12.8px">2)
                      Babeltrace to convert the CTF traces to=C2=A0</span><=
span style=3D"text-align:start;text-indent:0px;background-color:rgb(255,255=
,255);text-decoration-style:initial;text-decoration-color:initial;float:non=
e;display:inline"><span style=3D"font-size:12.8px">a human readable=C2=A0te=
xt.</span></span></font></span></span></div>
            <div style=3D"font-family:arial,sans-serif;font-size:12.8px;fon=
t-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-=
weight:400;letter-spacing:normal;text-transform:none;white-space:normal;wor=
d-spacing:0px;background-color:rgb(255,255,255)"><font color=3D"#000000"><b=
r>
              </font></div>
            <div style=3D"font-family:arial,sans-serif;font-size:12.8px;fon=
t-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-=
weight:400;letter-spacing:normal;text-transform:none;white-space:normal;wor=
d-spacing:0px;background-color:rgb(255,255,255)"><font color=3D"#000000"><s=
pan style=3D"background-color:rgb(247,247,247);font-family:Cabin,sans-serif=
;font-size:12.8px">Now,=C2=A0</span><span style=3D"font-size:12.8px">I aim =
to develop a patch to
                  the Babeltrace. Instead of printing the traces on the
                  console or in a file,=C2=A0</span></font><span style=3D"c=
olor:rgb(0,0,0)">I would like=C2=A0</span><span style=3D"color:rgb(0,0,0);f=
ont-size:small">to send the
                traces over TCP/IP to a third-party tool for processing.</s=
pan></div>
            <div style=3D"background-color:rgb(255,255,255)"><font color=3D=
"#000000">My third-party tool is installed on a
                windows machine. For this reason, the use of LTTng relay
                daemon=C2=A0will not be a good solution.</font></div>
            <div style=3D"font-family:arial,sans-serif;font-size:12.8px;fon=
t-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-=
weight:400;letter-spacing:normal;text-transform:none;white-space:normal;wor=
d-spacing:0px;background-color:rgb(255,255,255)"><br>
            </div>
          </div>
          <font style=3D"font-family:arial,sans-serif;font-size:12.8px;font=
-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-w=
eight:400;letter-spacing:normal;text-transform:none;white-space:normal;word=
-spacing:0px" color=3D"#000000">My question is the following:</font></div>
        <div style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font=
-size:12.8px;font-style:normal;font-variant-ligatures:normal;font-variant-c=
aps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-inde=
nt:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decorat=
ion-style:initial;text-decoration-color:initial;background-color:rgb(255,25=
5,255)"><font color=3D"#000000"><br>
          </font></div>
        <div style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font=
-size:12.8px;font-style:normal;font-variant-ligatures:normal;font-variant-c=
aps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-inde=
nt:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decorat=
ion-style:initial;text-decoration-color:initial;background-color:rgb(255,25=
5,255)"><font color=3D"#000000">To which file (of the Babeltrace=C2=A0sourc=
e
            code) should I make changes to answer my use case?<br>
          </font></div>
        <div style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font=
-size:12.8px;font-style:normal;font-variant-ligatures:normal;font-variant-c=
aps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-inde=
nt:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decorat=
ion-style:initial;text-decoration-color:initial;background-color:rgb(255,25=
5,255)"><font color=3D"#000000"><br>
          </font></div>
        <div style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font=
-size:12.8px;font-style:normal;font-variant-ligatures:normal;font-variant-c=
aps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-inde=
nt:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decorat=
ion-style:initial;text-decoration-color:initial;background-color:rgb(255,25=
5,255)"><font color=3D"#000000">Best regards,</font></div>
        <br>
        <div class=3D"m_-1937269249166450159gmail_signature" data-smartmail=
=3D"gmail_signature">
          <div dir=3D"ltr">
            <div>
              <div dir=3D"ltr">
                <div>
                  <div dir=3D"ltr">
                    <div dir=3D"ltr">
                      <div dir=3D"ltr" style=3D"font-size:12.8px">
                        <div dir=3D"ltr"><span style=3D"font-size:12.8px"><=
font color=3D"#444444">------------------------------<wbr>-----------------=
-------------<wbr>-----------------------------</font></span></div>
                        <div dir=3D"ltr"><font size=3D"2" face=3D"arial,
                            helvetica, sans-serif" color=3D"#444444"><br>
                          </font></div>
                        <div dir=3D"ltr"><font size=3D"2" face=3D"arial,
                            helvetica, sans-serif" color=3D"#444444">Nesrin=
e
                            ZOUARI</font></div>
                        <div dir=3D"ltr"><font size=3D"2" face=3D"arial,
                            helvetica, sans-serif" color=3D"#444444">Comput=
er
                            Engineering Student=C2=A0<br>
                          </font></div>
                        <div dir=3D"ltr"><font size=3D"2" face=3D"arial,
                            helvetica, sans-serif" color=3D"#444444">Depart=
ment
                            of Computer Engineering and Applied
                            Mathematics</font></div>
                        <div dir=3D"ltr"><span style=3D"color:rgb(68,68,68)=
;font-family:arial,helvetica,sans-serif;font-size:small">National
                            Engineering School=C2=A0of=C2=A0Sfax (ENIS)</sp=
an></div>
                        <div dir=3D"ltr">
                          <div dir=3D"ltr" style=3D"font-size:12.8px;margin=
:0px;padding:0px;border:0px"><font color=3D"#444444"><font style=3D"margin:=
0px;padding:0px;border:0px" size=3D"2" face=3D"arial, helvetica,
                                sans-serif">University of Sfax-</font><span=
 style=3D"font-family:arial,helvetica,sans-serif;font-size:small">Tunisia<b=
r>
                              </span></font></div>
                          <div style=3D"font-size:12.8px;margin:0px;padding=
:0px;border:0px none"><font color=3D"#444444"><span style=3D"font-family:ar=
ial,helvetica,sans-serif;font-size:small">Tel:
                                +216 52 620 475<br>
                              </span></font></div>
                          <div dir=3D"ltr" style=3D"font-size:12.8px;margin=
:0px;padding:0px;border:0px"><font color=3D"#444444"><span style=3D"font-fa=
mily:arial,helvetica,sans-serif;font-size:small"><br>
                              </span></font></div>
                          <div><font color=3D"#444444"><span style=3D"font-=
family:arial,helvetica,sans-serif;font-size:small"><br>
                              </span></font></div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        =E2=80=8C</div>
      <br>
      <fieldset class=3D"m_-1937269249166450159mimeAttachmentHeader"></fiel=
dset>
      <br>
      </div></div><span class=3D""><pre>______________________________<wbr>=
_________________
lttng-dev mailing list
<a class=3D"m_-1937269249166450159moz-txt-link-abbreviated" href=3D"mailto:=
lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a>
<a class=3D"m_-1937269249166450159moz-txt-link-freetext" href=3D"https://li=
sts.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" target=3D"_blank">https:/=
/lists.lttng.org/cgi-<wbr>bin/mailman/listinfo/lttng-dev</a>
</pre>
    </span></blockquote>
    <br>
  </div>

<br>______________________________<wbr>_________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-<wbr>bin/mail=
man/listinfo/lttng-dev</a><br>
<br></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div cla=
ss=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr">=
<div><div dir=3D"ltr"><div><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"lt=
r" style=3D"font-size:12.8px"><div dir=3D"ltr"><span style=3D"font-size:12.=
8px"><font color=3D"#444444">----------------------------------------------=
-------------------------------------------</font></span></div><div dir=3D"=
ltr"><font color=3D"#444444" face=3D"arial, helvetica, sans-serif" size=3D"=
2"><br></font></div><div dir=3D"ltr"><font color=3D"#444444" face=3D"arial,=
 helvetica, sans-serif" size=3D"2">Nesrine ZOUARI</font></div><div dir=3D"l=
tr"><font color=3D"#444444" face=3D"arial, helvetica, sans-serif" size=3D"2=
">Computer Engineering Student=C2=A0<br></font></div><div dir=3D"ltr"><font=
 color=3D"#444444" face=3D"arial, helvetica, sans-serif" size=3D"2">Departm=
ent of Computer Engineering and Applied Mathematics</font></div><div dir=3D=
"ltr"><span style=3D"color:rgb(68,68,68);font-family:arial,helvetica,sans-s=
erif;font-size:small">National Engineering School=C2=A0of=C2=A0Sfax (ENIS)<=
/span></div><div dir=3D"ltr"><div dir=3D"ltr" style=3D"font-size:12.8px;mar=
gin:0px;padding:0px;border:0px"><font color=3D"#444444"><font style=3D"marg=
in:0px;padding:0px;border:0px" face=3D"arial, helvetica, sans-serif" size=
=3D"2">University of Sfax-</font><span style=3D"font-family:arial,helvetica=
,sans-serif;font-size:small">Tunisia<br></span></font></div><div style=3D"f=
ont-size:12.8px;margin:0px;padding:0px;border:0px none"><font color=3D"#444=
444"><span style=3D"font-family:arial,helvetica,sans-serif;font-size:small"=
>Tel: +216 52 620 475<br></span></font></div><div dir=3D"ltr" style=3D"font=
-size:12.8px;margin:0px;padding:0px;border:0px"><font color=3D"#444444"><sp=
an style=3D"font-family:arial,helvetica,sans-serif;font-size:small"><br></s=
pan></font></div><div><font color=3D"#444444"><span style=3D"font-family:ar=
ial,helvetica,sans-serif;font-size:small"><br></span></font></div></div></d=
iv></div></div></div></div></div></div></div>
</div>

--001a114f2fcedd94980569a2d2f5--

--===============5341349309496598820==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============5341349309496598820==--
