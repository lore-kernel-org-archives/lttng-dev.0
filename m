From: Nesrine Zouari <nesrine.zouari@enis.tn>
Subject: Re: Babeltrace Patch
Date: Wed, 11 Apr 2018 16:09:57 +0100
Message-ID: <CAPHFV4mr4O5VGRpF=269w7NxL=G4oG++xrQfDWncdiFAR54FQQ__583.965334999625$1523459325$gmane$org@mail.gmail.com>
References: <CAPHFV4no6vfu0HV-D9Fy0HwGnuN84LT-4m3yLV_9ZOjqA+ytqQ@mail.gmail.com>
 <4dc85d3f-8397-31e2-f9d2-fd0f81bdc2f8@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5801636507787667183=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt0-x233.google.com (mail-qt0-x233.google.com
 [IPv6:2607:f8b0:400d:c0d::233])
 by lists.lttng.org (Postfix) with ESMTPS id 40LnXj2jbWzx4N
 for <lttng-dev@lists.lttng.org>; Wed, 11 Apr 2018 11:10:28 -0400 (EDT)
Received: by mail-qt0-x233.google.com with SMTP id w23so2268709qtn.3
 for <lttng-dev@lists.lttng.org>; Wed, 11 Apr 2018 08:10:28 -0700 (PDT)
In-Reply-To: <4dc85d3f-8397-31e2-f9d2-fd0f81bdc2f8@suse.de>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mohamad Gebai <mgebai@suse.de>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============5801636507787667183==
Content-Type: multipart/alternative; boundary="001a1140cfc40938480569940a8f"

--001a1140cfc40938480569940a8f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for your response.

I have already tested lttng-relayd on a Linux remote machine and it had
worked. But the problem is that my remote machine is WINDOWS so I don't
think that I can run lttng-relayd on it.
Is there a solution to run lttng-relayd on Windows??


=E2=80=8C

On Wed, Apr 11, 2018 at 3:41 PM, Mohamad Gebai <mgebai@suse.de> wrote:

> Hi Nesrine,
>
> You can use LTTng to send your traces over the network. See
> https://lttng.org/docs/v2.10/#doc-sending-trace-data-over-the-network
>
> Mohamad
>
>
>
> On 04/11/2018 08:11 AM, Nesrine Zouari wrote:
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


--=20
---------------------------------------------------------------------------=
--------------

Nesrine ZOUARI
Computer Engineering Student
Department of Computer Engineering and Applied Mathematics
National Engineering School of Sfax (ENIS)
University of Sfax-Tunisia
Tel: +216 52 620 475

--001a1140cfc40938480569940a8f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><img width=3D"0" height=3D"0" class=3D"mailtrack-img" alt=
=3D"" style=3D"display:flex" src=3D"https://mailtrack.io/trace/mail/b20778b=
c84649fb8d3550538c6d9a8019aa68b8b.png?u=3D2189147"><div><span style=3D"colo=
r:rgb(34,34,34);font-family:arial,sans-serif;font-size:12.8px;font-style:no=
rmal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400=
;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:none=
;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text=
-decoration-style:initial;text-decoration-color:initial;float:none;display:=
inline">Thank you for your response.</span><div style=3D"color:rgb(34,34,34=
);font-family:arial,sans-serif;font-size:12.8px;font-style:normal;font-vari=
ant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacin=
g:normal;text-align:start;text-indent:0px;text-transform:none;white-space:n=
ormal;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-st=
yle:initial;text-decoration-color:initial"><br><div>I have already tested=
=C2=A0<span style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-=
size:12.8px;font-style:normal;font-variant-ligatures:normal;font-variant-ca=
ps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-inden=
t:0px;text-transform:none;white-space:normal;word-spacing:0px;background-co=
lor:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:in=
itial;float:none;display:inline">lttng-relayd</span><span>=C2=A0</span>on a=
 Linux remote machine and it had worked. But the problem is that my remote =
machine is WINDOWS so I don&#39;t think that I can run<span>=C2=A0</span><s=
pan style=3D"font-size:12.8px">lttng-relayd</span><span>=C2=A0</span>on it.=
=C2=A0</div><div>Is there a solution to run=C2=A0<span style=3D"font-size:1=
2.8px">lttng-relayd on Windows??</span></div></div></div><br><br>=E2=80=8C<=
/div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Wed, Apr =
11, 2018 at 3:41 PM, Mohamad Gebai <span dir=3D"ltr">&lt;<a href=3D"mailto:=
mgebai@suse.de" target=3D"_blank">mgebai@suse.de</a>&gt;</span> wrote:<br><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">
 =20
   =20
 =20
  <div text=3D"#000000" bgcolor=3D"#FFFFFF">
    Hi Nesrine,<br>
    <br>
    You can use LTTng to send your traces over the network. See
    <a class=3D"m_970056615943322938moz-txt-link-freetext" href=3D"https://=
lttng.org/docs/v2.10/#doc-sending-trace-data-over-the-network" target=3D"_b=
lank">https://lttng.org/docs/v2.10/#<wbr>doc-sending-trace-data-over-<wbr>t=
he-network</a><br>
    <br>
    Mohamad<div><div class=3D"h5"><br>
    <br>
    <br>
    <div class=3D"m_970056615943322938moz-cite-prefix">On 04/11/2018 08:11 =
AM, Nesrine Zouari
      wrote:<br>
    </div>
    </div></div><blockquote type=3D"cite"><div><div class=3D"h5">
      <div dir=3D"ltr"><img class=3D"m_970056615943322938mailtrack-img" alt=
=3D"" style=3D"display:flex" src=3D"data:image/gif;base64,R0lGODlhAQABAIAAA=
AAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" height=3D"0" width=3D"0">
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
</span></span><span class=3D"m_970056615943322938gmail-m_-59900657589272444=
63gmail-m_6820945704080840124gmail-m_-6755159426057962638gmail-m_3226980521=
649496158gmail-m_4311176812459725481gmail-m_3469504987072534619gmail-m_-214=
3354602622622349gmail-m_5367336902020713707gmail-m_567988643051350633gmail-=
m_-2504658086804125746m_-670507402164016222gmail-il" style=3D"font-family:a=
rial,sans-serif;font-style:normal;font-variant-ligatures:normal;font-varian=
t-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-i=
ndent:0px;text-transform:none;white-space:normal;word-spacing:0px;backgroun=
d-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-colo=
r:initial">Qemu</span><span style=3D"font-family:arial,sans-serif;font-styl=
e:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight=
:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:=
none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);=
text-decoration-style:initial;text-decoration-color:initial;float:none;disp=
lay:inline"><span>=C2=A0</span>Trace.=C2=A0</span></font></div>
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
<span style=3D"background-color:rgb(255,255,255)"><span class=3D"m_97005661=
5943322938gmail-m_-5990065758927244463gmail-m_6820945704080840124gmail-m_-6=
755159426057962638gmail-m_3226980521649496158gmail-m_4311176812459725481gma=
il-m_3469504987072534619gmail-il" style=3D"font-family:arial,sans-serif;fon=
t-size:12.8px;font-style:normal;font-variant-ligatures:normal;font-variant-=
caps:normal;font-weight:400;letter-spacing:normal;text-transform:none;white=
-space:normal;word-spacing:0px"><font color=3D"#000000"><br>
                    </font></span></span></span></div>
            <div style=3D"font-family:arial,sans-serif;font-size:12.8px;fon=
t-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-=
weight:400;letter-spacing:normal;text-transform:none;white-space:normal;wor=
d-spacing:0px"><span style=3D"text-align:start;text-indent:0px;text-decorat=
ion-style:initial;text-decoration-color:initial;float:none;display:inline">=
<span style=3D"background-color:rgb(255,255,255)"><font color=3D"#000000"><=
span class=3D"m_970056615943322938gmail-m_-5990065758927244463gmail-m_68209=
45704080840124gmail-m_-6755159426057962638gmail-m_3226980521649496158gmail-=
m_4311176812459725481gmail-m_3469504987072534619gmail-il" style=3D"font-fam=
ily:arial,sans-serif;font-size:12.8px;font-style:normal;font-variant-ligatu=
res:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;t=
ext-transform:none;white-space:normal;word-spacing:0px">1)
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
        <div class=3D"m_970056615943322938gmail_signature" data-smartmail=
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
                        <div dir=3D"ltr"><font face=3D"arial, helvetica,
                            sans-serif" size=3D"2" color=3D"#444444"><br>
                          </font></div>
                        <div dir=3D"ltr"><font face=3D"arial, helvetica,
                            sans-serif" size=3D"2" color=3D"#444444">Nesrin=
e
                            ZOUARI</font></div>
                        <div dir=3D"ltr"><font face=3D"arial, helvetica,
                            sans-serif" size=3D"2" color=3D"#444444">Comput=
er
                            Engineering Student=C2=A0<br>
                          </font></div>
                        <div dir=3D"ltr"><font face=3D"arial, helvetica,
                            sans-serif" size=3D"2" color=3D"#444444">Depart=
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
0px;padding:0px;border:0px" face=3D"arial, helvetica, sans-serif" size=3D"2=
">University of Sfax-</font><span style=3D"font-family:arial,helvetica,sans=
-serif;font-size:small">Tunisia<br>
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
      <fieldset class=3D"m_970056615943322938mimeAttachmentHeader"></fields=
et>
      <br>
      </div></div><pre>______________________________<wbr>_________________
lttng-dev mailing list
<a class=3D"m_970056615943322938moz-txt-link-abbreviated" href=3D"mailto:lt=
tng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a>
<a class=3D"m_970056615943322938moz-txt-link-freetext" href=3D"https://list=
s.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" target=3D"_blank">https://l=
ists.lttng.org/cgi-<wbr>bin/mailman/listinfo/lttng-dev</a>
</pre>
    </blockquote>
    <br>
  </div>

</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><d=
iv><div dir=3D"ltr"><div><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"=
 style=3D"font-size:12.8px"><div dir=3D"ltr"><span style=3D"font-size:12.8p=
x"><font color=3D"#444444">------------------------------------------------=
-----------------------------------------</font></span></div><div dir=3D"lt=
r"><font color=3D"#444444" face=3D"arial, helvetica, sans-serif" size=3D"2"=
><br></font></div><div dir=3D"ltr"><font color=3D"#444444" face=3D"arial, h=
elvetica, sans-serif" size=3D"2">Nesrine ZOUARI</font></div><div dir=3D"ltr=
"><font color=3D"#444444" face=3D"arial, helvetica, sans-serif" size=3D"2">=
Computer Engineering Student=C2=A0<br></font></div><div dir=3D"ltr"><font c=
olor=3D"#444444" face=3D"arial, helvetica, sans-serif" size=3D"2">Departmen=
t of Computer Engineering and Applied Mathematics</font></div><div dir=3D"l=
tr"><span style=3D"color:rgb(68,68,68);font-family:arial,helvetica,sans-ser=
if;font-size:small">National Engineering School=C2=A0of=C2=A0Sfax (ENIS)</s=
pan></div><div dir=3D"ltr"><div dir=3D"ltr" style=3D"font-size:12.8px;margi=
n:0px;padding:0px;border:0px"><font color=3D"#444444"><font style=3D"margin=
:0px;padding:0px;border:0px" face=3D"arial, helvetica, sans-serif" size=3D"=
2">University of Sfax-</font><span style=3D"font-family:arial,helvetica,san=
s-serif;font-size:small">Tunisia<br></span></font></div><div style=3D"font-=
size:12.8px;margin:0px;padding:0px;border:0px none"><font color=3D"#444444"=
><span style=3D"font-family:arial,helvetica,sans-serif;font-size:small">Tel=
: +216 52 620 475<br></span></font></div><div dir=3D"ltr" style=3D"font-siz=
e:12.8px;margin:0px;padding:0px;border:0px"><font color=3D"#444444"><span s=
tyle=3D"font-family:arial,helvetica,sans-serif;font-size:small"><br></span>=
</font></div><div><font color=3D"#444444"><span style=3D"font-family:arial,=
helvetica,sans-serif;font-size:small"><br></span></font></div></div></div><=
/div></div></div></div></div></div></div>
</div>

--001a1140cfc40938480569940a8f--

--===============5801636507787667183==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============5801636507787667183==--
