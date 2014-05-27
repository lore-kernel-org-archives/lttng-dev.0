From: Randy Wijnants <dev@tty32.org>
Subject: Re: [documentation] Drawing: LTTng trace session in
 relation to commandline options
Date: Tue, 27 May 2014 19:40:30 +0200
Message-ID: <CANq1AQqq5j7165a3sQkcVvidd0DsX+4C17DApiF5uD0OS=k+tg__37886.9311688051$1401212511$gmane$org@mail.gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD359AE808@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1374221743=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <randy@tty32.org>) id 1WpLMa-0002X3-4K
 for lttng-dev@lists.lttng.org; Tue, 27 May 2014 13:40:45 -0400
Received: by mail-qg0-f53.google.com with SMTP id f51so14262341qge.26
 for <lttng-dev@lists.lttng.org>; Tue, 27 May 2014 10:40:30 -0700 (PDT)
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD359AE808@VAL-E-01.valcartier.drdc-rddc.gc.ca>
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

--===============1374221743==
Content-Type: multipart/alternative; boundary=089e014953ec2e23a004fa65311c

--089e014953ec2e23a004fa65311c
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Excelent! Used all of your improved syntaxes. Simplified /
restructured enable-event a
bit so that this is more readable in the drawing.

Also added lttng relayd / snapshot syntaxes.

Changed "Kernelspace specific" into "Kernel specific".

Added footnotes.

Excuse me for the SVG problem. I created this in google docs. I didn't
assume google's way of exporting SVGs was so poor, i have the same issue
using inkscape.
If i have time i will migrate it manually to inkscape. That might indeed
explain the misalignment issue you described.

Let me know what you think : )

http://tty32.org/Trace%20session.png


Greetings,
Randy Wijnants.
"The good part about UDP jokes is that i don't have to worry if you get it
or not"


On 27 May 2014 17:19, Thibault, Daniel <Daniel.Thibault@drdc-rddc.gc.ca>wro=
te:

> ----------------------------------------------------------------------
> Date: Tue, 27 May 2014 13:34:20 +0200
> From: Randy Wijnants <dev@tty32.org>
>
> > In addition to the LTTng architecture diagram, I've drawn a diagram tha=
t
> shows the relation between the command line options and how to configure =
a
> trace session.
> > I hope it proves to be useful, if you have any suggestions let me know!
> >
> > Originally posted on IRC. As suggested by Compudj i've released it unde=
r
> CC license.
> >
> > http://tty32.org/Trace%20session.png
> > http://tty32.org/Trace%20session.svg
> >
> > Randy Wijnants.
> ----------------------------------------------------------------------
>
>    Neither the png nor svg versions line up correctly the text and
> coloured boxes with each other.  This may be a local rendering issue.  At
> least the svg version has a proper white background (my png renders with =
a
> very dark grey background, making it very hard to make out some of the
> text).  However, the svg version is unusable because none of the text is
> text: everything is svg:path with opaque d attributes (this may explain t=
he
> alignment problems).
>
>    Here are improved (more accurate) expressions for the various command
> syntaxes:
>
> $ lttng create [NAME] [--ctrl-url URL --data-url URL | --output PATH |
> --set-url URL | --no-output] [--snapshot]
>    (the ctrl-url etc. options are in pre-emption order)
>
> $ lttng enable-channel (-k | -u) [--session NAME] NAME[,NAME2,...]
> [--discard | --overwrite] [--subbuf-size SIZE] [--num-subbuf NUM]
> [--switch-timer USEC] [--read-timer USEC] \
>
>                                       [--output (mmap | splice)]
> [--buffers-uid | --buffers-pid | --buffers-global] [--tracefile-size SIZE
> [--tracefile-count COUNT]]
>
> $ lttng enable-event (-k | -u) [--session NAME] [--channel NAME] (--all
> [--tracepoint | --syscall] | \
>                                             NAME[,NAME2,...] [--tracepoin=
t
> [(--loglevel | --loglevel-only) LOGLEVEL] [--filter 'EXPRESSION'] |
> (--probe | --function) (addr | symbol | symbol+offset)])
>
> $ lttng add-context (-k | -u) [--session NAME] [--channel NAME] (--type
> TYPE)+
>
> $ lttng list (-k | -u)
>    (not the full syntax, but rather the syntax that will get just a list
> of event names)
>
> $ lttng add-context --help
>    (the only one that doesn't change!)
>
>    Change "Kernelspace specific" into "Kernel specific".
>
>    Add footnotes:
> * --session NAME defaults to the current session
> * --channel NAME in the enable-event case defaults to 'channel0', but onl=
y
> if the domain is virgin
> * --channel NAME in the add-context case defaults to all channels
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
> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada | Government of Canada
> <http://www.valcartier.drdc-rddc.gc.ca/>
>

--089e014953ec2e23a004fa65311c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Excelent! Used all of your improved syntaxes. Simplified /=
 restructured=C2=A0<span style=3D"font-family:arial,sans-serif;font-size:13=
px">enable-event=C2=A0a bit so that this is more readable in the drawing.</=
span><div><font face=3D"arial, sans-serif"><br>

</font></div><div><font face=3D"arial, sans-serif">Also added lttng relayd =
/ snapshot syntaxes.</font></div><div><font face=3D"arial, sans-serif"><br>=
</font></div><div><span style=3D"font-family:arial,sans-serif;font-size:13p=
x">Changed &quot;Kernelspace specific&quot; into &quot;Kernel specific&quot=
;.</span><br>

</div><div><span style=3D"font-family:arial,sans-serif;font-size:13px"><br>=
</span></div><div><span style=3D"font-family:arial,sans-serif;font-size:13p=
x">Added footnotes.</span></div><div><span style=3D"font-family:arial,sans-=
serif;font-size:13px"><br>

</span></div><div><span style=3D"font-family:arial,sans-serif;font-size:13p=
x">Excuse me for the SVG problem. I created this in google docs. I didn&#39=
;t assume google&#39;s way of exporting SVGs was so poor, i have the same i=
ssue using inkscape.</span></div>

<div><span style=3D"font-family:arial,sans-serif;font-size:13px">If i have =
time i will migrate it manually to inkscape. That might indeed explain the =
misalignment issue you described.</span></div><div><span style=3D"font-fami=
ly:arial,sans-serif;font-size:13px"><br>

</span></div><div><span style=3D"font-family:arial,sans-serif;font-size:13p=
x">Let me know what you think : )</span></div><div><span style=3D"font-fami=
ly:arial,sans-serif;font-size:13px"><br></span></div><div><a href=3D"http:/=
/tty32.org/Trace%20session.png" style=3D"font-family:arial,sans-serif;font-=
size:13px" target=3D"_blank">http://tty32.org/Trace%20session.png</a><span =
style=3D"font-family:arial,sans-serif;font-size:13px"><br>

</span></div><div><div><br></div></div><div class=3D"gmail_extra"><br clear=
=3D"all"><div><div dir=3D"ltr"><div>Greetings,</div><div>Randy Wijnants.<br=
></div><div>&quot;The good part about UDP jokes is that i don&#39;t have to=
 worry if you get it or not&quot;</div>

</div></div>
<br><br><div class=3D"gmail_quote">On 27 May 2014 17:19, Thibault, Daniel <=
span dir=3D"ltr">&lt;<a href=3D"mailto:Daniel.Thibault@drdc-rddc.gc.ca" tar=
get=3D"_blank">Daniel.Thibault@drdc-rddc.gc.ca</a>&gt;</span> wrote:<br><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex">

----------------------------------------------------------------------<br>
Date: Tue, 27 May 2014 13:34:20 +0200<br>
From: Randy Wijnants &lt;<a href=3D"mailto:dev@tty32.org" target=3D"_blank"=
>dev@tty32.org</a>&gt;<br>
<br>
&gt; In addition to the LTTng architecture diagram, I&#39;ve drawn a diagra=
m that shows the relation between the command line options and how to confi=
gure a trace session.<br>
<div>&gt; I hope it proves to be useful, if you have any suggestions let me=
 know!<br>
&gt;<br>
&gt; Originally posted on IRC. As suggested by Compudj i&#39;ve released it=
 under CC license.<br>
&gt;<br>
&gt; <a href=3D"http://tty32.org/Trace%20session.png" target=3D"_blank">htt=
p://tty32.org/Trace%20session.png</a><br>
&gt; <a href=3D"http://tty32.org/Trace%20session.svg" target=3D"_blank">htt=
p://tty32.org/Trace%20session.svg</a><br>
&gt;<br>
</div>&gt; Randy Wijnants.<br>
----------------------------------------------------------------------<br>
<br>
=C2=A0 =C2=A0Neither the png nor svg versions line up correctly the text an=
d coloured boxes with each other. =C2=A0This may be a local rendering issue=
. =C2=A0At least the svg version has a proper white background (my png rend=
ers with a very dark grey background, making it very hard to make out some =
of the text). =C2=A0However, the svg version is unusable because none of th=
e text is text: everything is svg:path with opaque d attributes (this may e=
xplain the alignment problems).<br>


<br>
=C2=A0 =C2=A0Here are improved (more accurate) expressions for the various =
command syntaxes:<br>
<br>
$ lttng create [NAME] [--ctrl-url URL --data-url URL | --output PATH | --se=
t-url URL | --no-output] [--snapshot]<br>
=C2=A0 =C2=A0(the ctrl-url etc. options are in pre-emption order)<br>
<br>
$ lttng enable-channel (-k | -u) [--session NAME] NAME[,NAME2,...] [--disca=
rd | --overwrite] [--subbuf-size SIZE] [--num-subbuf NUM] [--switch-timer U=
SEC] [--read-timer USEC] \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 [--output (mmap | splice)] [--buffers-uid | --buff=
ers-pid | --buffers-global] [--tracefile-size SIZE [--tracefile-count COUNT=
]]<br>


<br>
$ lttng enable-event (-k | -u) [--session NAME] [--channel NAME] (--all [--=
tracepoint | --syscall] | \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 NAME[,NAME2,...] [--tracepoint [(--loglevel | --loglevel-only) LOGLE=
VEL] [--filter &#39;EXPRESSION&#39;] | (--probe | --function) (addr | symbo=
l | symbol+offset)])<br>
<br>
$ lttng add-context (-k | -u) [--session NAME] [--channel NAME] (--type TYP=
E)+<br>
<br>
$ lttng list (-k | -u)<br>
=C2=A0 =C2=A0(not the full syntax, but rather the syntax that will get just=
 a list of event names)<br>
<br>
$ lttng add-context --help<br>
=C2=A0 =C2=A0(the only one that doesn&#39;t change!)<br>
<br>
=C2=A0 =C2=A0Change &quot;Kernelspace specific&quot; into &quot;Kernel spec=
ific&quot;.<br>
<br>
=C2=A0 =C2=A0Add footnotes:<br>
* --session NAME defaults to the current session<br>
* --channel NAME in the enable-event case defaults to &#39;channel0&#39;, b=
ut only if the domain is virgin<br>
* --channel NAME in the add-context case defaults to all channels<br>
<br>
Daniel U. Thibault<br>
Protection des syst=C3=A8mes et contremesures (PSC) | Systems Protection &a=
mp; Countermeasures (SPC)<br>
Cyber s=C3=A9curit=C3=A9 pour les missions essentielles (CME) | Mission Cri=
tical Cyber Security (MCCS)<br>
R &amp; D pour la d=C3=A9fense Canada - Valcartier (RDDC Valcartier) | Defe=
nce R&amp;D Canada - Valcartier (DRDC Valcartier)<br>
2459 route de la Bravoure<br>
Qu=C3=A9bec QC =C2=A0G3J 1X5<br>
CANADA<br>
Vox : <a href=3D"tel:%28418%29%20844-4000%20x4245" value=3D"+14188444000" t=
arget=3D"_blank">(418) 844-4000 x4245</a><br>
Fax : <a href=3D"tel:%28418%29%20844-4538" value=3D"+14188444538" target=3D=
"_blank">(418) 844-4538</a><br>
NAC : 918V QSDJ &lt;<a href=3D"http://www.travelgis.com/map.asp?addr=3D918V=
%20QSDJ" target=3D"_blank">http://www.travelgis.com/map.asp?addr=3D918V%20Q=
SDJ</a>&gt;<br>
Gouvernement du Canada | Government of Canada<br>
&lt;<a href=3D"http://www.valcartier.drdc-rddc.gc.ca/" target=3D"_blank">ht=
tp://www.valcartier.drdc-rddc.gc.ca/</a>&gt;<br>
</blockquote></div><br></div></div>

--089e014953ec2e23a004fa65311c--


--===============1374221743==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1374221743==--
