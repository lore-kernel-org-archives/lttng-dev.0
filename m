From: Randy Wijnants <randy@tty32.org>
Subject: Re: [documentation] Drawing: LTTng architecture in
 relation to the commandline / buffer options
Date: Wed, 28 May 2014 13:49:35 +0200
Message-ID: <CANq1AQru_Wxgcp3dXFmCjgerVYL6fh7qcgeiqRpGBNzW8R-NiA__48814.5392890603$1401303740$gmane$org@mail.gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD359AE5D5@VAL-E-01.valcartier.drdc-rddc.gc.ca>
 <CANq1AQoMPSEVyN0JxM-JWYcaaW=kyuOHUhgC03zMxdTnxroO-g@mail.gmail.com>
 <48CF5AC71E61DB46B70D0F388054EFFD359AE7A9@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1081821110=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <randy@tty32.org>) id 1WpcMX-0000rR-Lz
 for lttng-dev@lists.lttng.org; Wed, 28 May 2014 07:49:44 -0400
Received: by mail-qg0-f48.google.com with SMTP id i50so17036767qgf.21
 for <lttng-dev@lists.lttng.org>; Wed, 28 May 2014 04:49:36 -0700 (PDT)
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD359AE7A9@VAL-E-01.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Cc: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

--===============1081821110==
Content-Type: multipart/alternative; boundary=001a11c2c16612f34c04fa74682f

--001a11c2c16612f34c04fa74682f
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Thanks for the explaination of the interface between the session and
consumer daemon.

Incorporated all of your suggestions into the graphic.

Updated version:
http://tty32.org/Logging%20configuration2.png
http://tty32.org/Logging%20configuration2.svg

Should i push the SVGs to lttng git repo at this point?

Met vriendelijke groet,
Randy Wijnants.

"The good part about UDP jokes is that i don't have to worry if you get it
or not"


On 27 May 2014 15:18, Thibault, Daniel <Daniel.Thibault@drdc-rddc.gc.ca>wro=
te:

>  *De :* Randy Wijnants [mailto:randy@tty32.org]
> *Envoy=C3=A9 :* 27 mai 2014 06:34
>
>   > Changed the dashed arrows into dotted arrows.
>
> >
>
> > Is the arrow running from the lttng session daemon to liblttng-ust
> valid?
>
> > Does the liblttng-ust always write to the shared memory buffer or only
> if the session daemon instructs it to (via which interface?)
>
> > And what is the interface used between the session and consumer daemon?
>
> >
>
> > New version:
>
> > http://tty32.org/Logging%20configuration2.png<http://--ESFSECEV-TY3011-=
--------------------------->
>
> >
>
> > Randy Wijnants.
>
>
>
>    Unless I=E2=80=99m mistaken, when a session daemon disables a channel,=
 for
> instance, it asks liblttng-ust to turn off the immediate value test in th=
e
> registered applications (each tracepoint entry is guarded by an immediate
> value test which is controlled by changing a single byte).  That=E2=80=99=
s the
> principle, anyway.  I haven=E2=80=99t actually followed this through the =
tangle of
> LTTng=E2=80=99s code.
>
>    Rest assured that if liblttng-ust writes to a channel=E2=80=99s buffer=
, it=E2=80=99s
> because the event was enabled at the time.
>
>    I know the consumer daemon(s) read(s) /run/lttng/lttng-session.pid (or
> $HOME/.lttng/lttng-session.pid) to reach the session daemon.  I think the
> session daemon uses the /run/lttng/ustconsumerd64 (or
> $HOME/.lttng/ustconsumerd64; 32-bit versions may also exist) socket to se=
nd
> commands to the consumer daemon(s).
>
>    About the only things the diagram is missing now are:
>
> * the lttng-relayd daemon (which completes the =E2=80=9CNetwork destinati=
on /
> streaming=E2=80=9D box);
>
> * the add-context command (easily put beside enable-channel and
> enable-event); and
>
> * the buffers-global / buffers-pid / buffers-uid alternative (could be pu=
t
> opposite the output TYPE at the Buffer=E2=80=99s top right).
>
>    Change:
>
> * =E2=80=9CLTTv=E2=80=9D into =E2=80=9CLTTV=E2=80=9D
>
> * =E2=80=9CEclipse=E2=80=9D into =E2=80=9CEclipse TMF=E2=80=9D
>
> * =E2=80=9Ctracefilesize=E2=80=9D into =E2=80=9Ctracefile-size=E2=80=9D
>
> * =E2=80=9Ccommandline=E2=80=9D into =E2=80=9Ccommand line=E2=80=9D
>
> Daniel U. Thibault
> Protection des syst=C3=A8mes et contremesures (PSC) | Systems Protection =
&
> Countermeasures (SPC)
> Cyber s=C3=A9curit=C3=A9 pour les missions essentielles (CME) | Mission C=
ritical
> Cyber Security (MCCS)
> R & D pour la d=C3=A9fense Canada - Valcartier (RDDC Valcartier) | Defenc=
e R&D
> Canada - Valcartier (DRDC Valcartier)
> 2459 route de la Bravoure
> Qu=C3=A9bec QC  G3J 1X5
> CANADA
> Vox : (418) 844-4000 x4245
> Fax : (418) 844-4538
> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ> <*h=
ttp://www.travelgis.com/map.asp?addr=3D918V%20QSDJ
> <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>*>
> Gouvernement du Canada | Government of Canada
> <http://www.valcartier.drdc-rddc.gc.ca/>
>

--001a11c2c16612f34c04fa74682f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Thanks for the explaination of the interface between =
the session and consumer daemon.</div><div><br></div><div>Incorporated all =
of your suggestions into the graphic.</div><div><br></div><div>Updated vers=
ion:</div>
<a href=3D"http://tty32.org/Logging%20configuration2.png">http://tty32.org/=
Logging%20configuration2.png</a><br><div><a href=3D"http://tty32.org/Loggin=
g%20configuration2.svg">http://tty32.org/Logging%20configuration2.svg</a><b=
r>
</div><div><br></div><div>Should i push the SVGs to lttng git repo at this =
point?</div></div><div class=3D"gmail_extra"><br clear=3D"all"><div><div di=
r=3D"ltr"><div>Met vriendelijke groet,</div><div>Randy Wijnants.</div><div>=
<br>
</div><div><span style=3D"font-family:arial;font-size:small">&quot;The good=
 part about UDP jokes is that i don&#39;t have to worry if you get it or no=
t&quot;</span><br></div></div></div>
<br><br><div class=3D"gmail_quote">On 27 May 2014 15:18, Thibault, Daniel <=
span dir=3D"ltr">&lt;<a href=3D"mailto:Daniel.Thibault@drdc-rddc.gc.ca" tar=
get=3D"_blank">Daniel.Thibault@drdc-rddc.gc.ca</a>&gt;</span> wrote:<br><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex">






<div lang=3D"FR-CA" link=3D"blue" vlink=3D"purple">
<div>
<p class=3D"MsoNormal"><b><span lang=3D"FR" style=3D"font-size:10.0pt;font-=
family:&quot;Tahoma&quot;,&quot;sans-serif&quot;">De=C2=A0:</span></b><span=
 lang=3D"FR" style=3D"font-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot=
;sans-serif&quot;"> Randy Wijnants [mailto:<a href=3D"mailto:randy@tty32.or=
g" target=3D"_blank">randy@tty32.org</a>]
<br>
<b>Envoy=C3=A9=C2=A0:</b> 27 mai 2014 06:34<br>
<br>
<u></u><u></u></span></p>
<div><div class=3D"">
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1f497d">&gt; </=
span><span lang=3D"EN-CA">Changed the dashed arrows into dotted arrows.<u><=
/u><u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1f497d">&gt;</s=
pan><span lang=3D"EN-CA"><u></u>=C2=A0<u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1f497d">&gt; </=
span><span lang=3D"EN-CA">Is the arrow running from the lttng session daemo=
n to liblttng-ust valid?<span style=3D"color:#1f497d"><u></u><u></u></span>=
</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1f497d">&gt;</s=
pan><span lang=3D"EN-CA"> Does the liblttng-ust always write to the shared =
memory buffer or only if the session daemon instructs it to (via which inte=
rface?)<u></u><u></u></span></p>

</div>
</div><div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1f497d">&gt; </=
span><span lang=3D"EN-CA">And what is the interface used between the sessio=
n
<span style=3D"color:#1f497d">a</span>n<span style=3D"color:#1f497d">d</spa=
n> consumer daemon?<u></u><u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1f497d">&gt;</s=
pan><span lang=3D"EN-CA"><u></u>=C2=A0<u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1f497d">&gt; </=
span>New version:=C2=A0<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1f497d">&gt; </=
span><a href=3D"http://--ESFSECEV-TY3011----------------------------" targe=
t=3D"_blank">http://tty32.org/Logging%20configuration2.png</a><u></u><u></u=
></p>

</div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1f497d">&gt;</s=
pan><u></u>=C2=A0<u></u></p>
<div>
<div>
<div>
<div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1f497d">&gt; </=
span><span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,&quot;sa=
ns-serif&quot;">Randy Wijnants.<u></u><u></u></span></p>
</div>
</div>
</div>
</div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"color:=
#1f497d"><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span lang=3D"EN-CA" =
style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&=
quot;;color:#1f497d">=C2=A0=C2=A0 Unless I=E2=80=99m mistaken, when a sessi=
on daemon disables a channel, for instance, it asks liblttng-ust to turn of=
f the
 immediate value test in the registered applications (each tracepoint entry=
 is guarded by an immediate value test which is controlled by changing a si=
ngle byte). =C2=A0That=E2=80=99s the principle, anyway.=C2=A0 I haven=E2=80=
=99t actually followed this through the tangle of LTTng=E2=80=99s
 code.<u></u><u></u></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span lang=3D"EN-CA" =
style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&=
quot;;color:#1f497d">=C2=A0=C2=A0 Rest assured that if liblttng-ust writes =
to a channel=E2=80=99s buffer, it=E2=80=99s because the event was enabled a=
t the time.<u></u><u></u></span></p>

<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span lang=3D"EN-CA" =
style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&=
quot;;color:#1f497d">=C2=A0=C2=A0 I know the consumer daemon(s) read(s) /ru=
n/lttng/lttng-session.pid (or $HOME/.lttng/lttng-session.pid) to reach
 the session daemon.=C2=A0 I think the session daemon uses the /run/lttng/u=
stconsumerd64 (or $HOME/.lttng/ustconsumerd64; 32-bit versions may also exi=
st) socket to send commands to the consumer daemon(s).<u></u><u></u></span>=
</p>

<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span lang=3D"EN-CA" =
style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&=
quot;;color:#1f497d">=C2=A0=C2=A0 About the only things the diagram is miss=
ing now are:<u></u><u></u></span></p>

<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span lang=3D"EN-CA" =
style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&=
quot;;color:#1f497d">* the lttng-relayd daemon (which completes the =E2=80=
=9CNetwork destination / streaming=E2=80=9D box);<u></u><u></u></span></p>

<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span lang=3D"EN-CA" =
style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&=
quot;;color:#1f497d">* the add-context command (easily put beside enable-ch=
annel and enable-event); and<u></u><u></u></span></p>

<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span lang=3D"EN-CA" =
style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&=
quot;;color:#1f497d">* the buffers-global / buffers-pid / buffers-uid alter=
native (could be put opposite the output TYPE at the Buffer=E2=80=99s
 top right).<u></u><u></u></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span lang=3D"EN-CA" =
style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&=
quot;;color:#1f497d">=C2=A0=C2=A0 Change:<u></u><u></u></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span lang=3D"EN-CA" =
style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&=
quot;;color:#1f497d">* =E2=80=9CLTTv=E2=80=9D into =E2=80=9CLTTV=E2=80=9D<u=
></u><u></u></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span lang=3D"EN-CA" =
style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&=
quot;;color:#1f497d">* =E2=80=9CEclipse=E2=80=9D into =E2=80=9CEclipse TMF=
=E2=80=9D<u></u><u></u></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span lang=3D"EN-CA" =
style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&=
quot;;color:#1f497d">* =E2=80=9Ctracefilesize=E2=80=9D into =E2=80=9Ctracef=
ile-size=E2=80=9D<u></u><u></u></span></p>

<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span lang=3D"EN-CA" =
style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&=
quot;;color:#1f497d">* =E2=80=9Ccommandline=E2=80=9D into =E2=80=9Ccommand =
line=E2=80=9D<u></u><u></u></span></p>
<div class=3D"">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:Consolas=
;color:#1f497d">Daniel U. Thibault<br>
Protection des syst=C3=A8mes et contremesures (PSC) | Systems Protection &a=
mp; Countermeasures (SPC)<br>
Cyber s=C3=A9curit=C3=A9 pour les missions essentielles (CME) | Mission Cri=
tical Cyber Security (MCCS)<br>
R &amp; D pour la d=C3=A9fense Canada - Valcartier (RDDC Valcartier) | Defe=
nce R&amp;D Canada - Valcartier (DRDC Valcartier)<br>
2459 route de la Bravoure<br>
Qu=C3=A9bec QC=C2=A0 G3J 1X5<br>
CANADA<br>
Vox</span><span style=3D"font-size:10.5pt;font-family:Consolas;color:#1f497=
d">=C2=A0</span><span style=3D"font-size:11.0pt;font-family:Consolas;color:=
#1f497d">: <a href=3D"tel:%28418%29%20844-4000%20x4245" value=3D"+141884440=
00" target=3D"_blank">(418) 844-4000 x4245</a><br>

Fax</span><span style=3D"font-size:10.5pt;font-family:Consolas;color:#1f497=
d">=C2=A0</span><span style=3D"font-size:11.0pt;font-family:Consolas;color:=
#1f497d">: <a href=3D"tel:%28418%29%20844-4538" value=3D"+14188444538" targ=
et=3D"_blank">(418) 844-4538</a><br>

</span><span style=3D"font-size:11.0pt;font-family:Consolas;color:#1f497d">=
NAC=C2=A0: </span>
<span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-family:&quot;Calibri&qu=
ot;,&quot;sans-serif&quot;;color:#1f497d"><a href=3D"http://www.travelgis.c=
om/map.asp?addr=3D918V%20QSDJ" target=3D"_blank"><span lang=3D"FR-CA" style=
=3D"font-size:10.0pt;font-family:&quot;Courier New&quot;">918V QSDJ</span><=
/a></span><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-family:&quot;=
Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">
</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;;color:#1f497d">&lt;</span><u><span style=3D"font-size:10=
.0pt;font-family:&quot;Courier New&quot;;color:blue"><a href=3D"http://www.=
travelgis.com/map.asp?addr=3D918V%20QSDJ" target=3D"_blank">http://www.trav=
elgis.com/map.asp?addr=3D918V%20QSDJ</a></span></u><span style=3D"font-size=
:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497=
d">&gt;</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quo=
t;,&quot;sans-serif&quot;;color:#1f497d"><br>

</span><span style=3D"font-size:11.0pt;font-family:Consolas;color:#1f497d">=
Gouvernement du Canada=C2=A0| Government of Canada<br>
</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;;color:#1f497d">&lt;</span><span lang=3D"EN-CA" style=3D"=
font-size:10.0pt;font-family:&quot;Courier New&quot;;color:blue"><a href=3D=
"http://www.valcartier.drdc-rddc.gc.ca/" target=3D"_blank"><span lang=3D"FR=
-CA">http://www.valcartier.drdc-rddc.gc.ca/</span></a></span><span style=3D=
"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:#1f497d">&gt;</span><span style=3D"font-size:10.5pt;font-family:Consola=
s;color:#1f497d"><u></u><u></u></span></p>

</div></div>
</div>
</div>
</div>

</blockquote></div><br></div>

--001a11c2c16612f34c04fa74682f--


--===============1081821110==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1081821110==--
