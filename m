From: Randy Wijnants <randy@tty32.org>
Subject: Re: [documentation] Drawing: LTTng architecture in
 relation to the commandline / buffer options
Date: Tue, 27 May 2014 12:34:13 +0200
Message-ID: <CANq1AQoMPSEVyN0JxM-JWYcaaW=kyuOHUhgC03zMxdTnxroO-g__1344.5766679526$1401187917$gmane$org@mail.gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD359AE5D5@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0205382835=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <randy@tty32.org>) id 1WpEi2-0007zg-LJ
 for lttng-dev@lists.lttng.org; Tue, 27 May 2014 06:34:23 -0400
Received: by mail-qg0-f46.google.com with SMTP id q108so13562936qgd.33
 for <lttng-dev@lists.lttng.org>; Tue, 27 May 2014 03:34:13 -0700 (PDT)
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD359AE5D5@VAL-E-01.valcartier.drdc-rddc.gc.ca>
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

--===============0205382835==
Content-Type: multipart/alternative; boundary=001a11c035f4a51d0a04fa5f3c2f

--001a11c035f4a51d0a04fa5f3c2f
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Thanks for your reply!

Changed the dashed arrows into dotted arrows.

Is the arrow running from the lttng session daemon to liblttng-ust valid?
Does the liblttng-ust always write to the shared memory buffer or only if
the session daemon instructs it to (via which interface?)
And what is the interface used between the session en consumer daemon?

New version:
http://tty32.org/Logging%20configuration2.png

Greetings,
Randy Wijnants.
"The good part about UDP jokes is that i don't have to worry if you get it
or not"


On 26 May 2014 18:37, Thibault, Daniel <Daniel.Thibault@drdc-rddc.gc.ca>wro=
te:

> ----------------------------------------------------------------------
> Date: Mon, 26 May 2014 11:27:35 +0200
> From: Randy Wijnants <randy@tty32.org>
>
> > I've drawn the LTTng architecture in relation to the commandline /
> buffer options.
> > It would be nice if it would be used on the lttng website (if you find
> it usefull ofcourse).
> > I'm using this for a presentation at our company to explain more
> in-depth lttng configuration details.
> >
> > Originally posted on IRC. As suggested by Compudj i've released it unde=
r
> CC license.
> >
> > Let me know what you think of it or if you have suggestions /
> improvements
> >:)
> > I can also provide SVG image, or push it to the repo?
> >
> > http://tty32.org/Logging%20configuration2.png
> >
> > Randy Wijnants.
> ----------------------------------------------------------------------
>    SVG, please.  I may end up integrating it into the DocBook
> documentation.
>
>    The dashed arrows running from userspace to liblttng-ust and the kerne=
l
> to LTTng kernel module(s) don't make sense.  The remaining dashed arrows
> (all running from the session daemon) all represent control flow, which i=
s
> not what happens between userspace/kernel and
> liblttng-ust/LTTng-kernel-modules.  You should use a different convention=
,
> such as dotted arrows.
>
>    The enable-channel arrow should be accompanied by an enable-event arro=
w
> (same functionality, different resolution).
>
>    You could also add a box for the lttng client, which talks to
> (controls) the session daemon.
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

--001a11c035f4a51d0a04fa5f3c2f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Thanks for your reply!</div><div><br></div><div>Chang=
ed the dashed arrows into dotted arrows.</div><div><br></div><div>Is the ar=
row running from the lttng session daemon to liblttng-ust valid? Does the l=
iblttng-ust always write to the shared memory buffer or only if the session=
 daemon instructs it to (via which interface?)</div>
<div>And what is the interface used between the session en consumer daemon?=
</div><div><br></div><div>New version:=C2=A0</div><div><a href=3D"http://tt=
y32.org/Logging%20configuration2.png" target=3D"_blank">http://tty32.org/Lo=
gging%20configuration2.png</a></div>
<br><div class=3D"gmail_extra"><div><div dir=3D"ltr"><div><div style=3D"fon=
t-family:arial,sans-serif;font-size:13px">Greetings,</div><div style=3D"fon=
t-family:arial,sans-serif;font-size:13px">Randy Wijnants.<br></div><div sty=
le=3D"font-family:arial,sans-serif;font-size:13px">
&quot;The good part about UDP jokes is that i don&#39;t have to worry if yo=
u get it or not&quot;</div>
</div></div></div>
<br><br><div class=3D"gmail_quote">On 26 May 2014 18:37, Thibault, Daniel <=
span dir=3D"ltr">&lt;<a href=3D"mailto:Daniel.Thibault@drdc-rddc.gc.ca" tar=
get=3D"_blank">Daniel.Thibault@drdc-rddc.gc.ca</a>&gt;</span> wrote:<br><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;padd=
ing-left:1ex">

----------------------------------------------------------------------<br>
Date: Mon, 26 May 2014 11:27:35 +0200<br>
From: Randy Wijnants &lt;<a href=3D"mailto:randy@tty32.org" target=3D"_blan=
k">randy@tty32.org</a>&gt;<br>
<div><br>
&gt; I&#39;ve drawn the LTTng architecture in relation to the commandline /=
 buffer options.<br>
&gt; It would be nice if it would be used on the lttng website (if you find=
 it usefull ofcourse).<br>
&gt; I&#39;m using this for a presentation at our company to explain more i=
n-depth lttng configuration details.<br>
&gt;<br>
&gt; Originally posted on IRC. As suggested by Compudj i&#39;ve released it=
 under CC license.<br>
&gt;<br>
&gt; Let me know what you think of it or if you have suggestions / improvem=
ents<br>
&gt;:)<br>
&gt; I can also provide SVG image, or push it to the repo?<br>
&gt;<br>
&gt; <a href=3D"http://tty32.org/Logging%20configuration2.png" target=3D"_b=
lank">http://tty32.org/Logging%20configuration2.png</a><br>
&gt;<br>
</div>&gt; Randy Wijnants.<br>
----------------------------------------------------------------------<br>
=C2=A0 =C2=A0SVG, please. =C2=A0I may end up integrating it into the DocBoo=
k documentation.<br>
<br>
=C2=A0 =C2=A0The dashed arrows running from userspace to liblttng-ust and t=
he kernel to LTTng kernel module(s) don&#39;t make sense. =C2=A0The remaini=
ng dashed arrows (all running from the session daemon) all represent contro=
l flow, which is not what happens between userspace/kernel and liblttng-ust=
/LTTng-kernel-modules. =C2=A0You should use a different convention, such as=
 dotted arrows.<br>


<br>
=C2=A0 =C2=A0The enable-channel arrow should be accompanied by an enable-ev=
ent arrow (same functionality, different resolution).<br>
<br>
=C2=A0 =C2=A0You could also add a box for the lttng client, which talks to =
(controls) the session daemon.<br>
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

--001a11c035f4a51d0a04fa5f3c2f--


--===============0205382835==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0205382835==--
