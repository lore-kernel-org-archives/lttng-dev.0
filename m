From: J Lin <jmlin.jmlin@gmail.com>
Subject: Re: Strange result from LTTng porting to ARM
Date: Thu, 13 Nov 2014 13:12:14 +0800
Message-ID: <CACtA8QRE5Y70-Tiss4siDufPyoUzgKBR7BUWR_XYwNSL0UkKuQ__49554.3215693489$1415855587$gmane$org@mail.gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD6FBC890A@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0106084362=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jmlin.jmlin@gmail.com>) id 1Xomhg-0002Yu-8W
 for lttng-dev@lists.lttng.org; Thu, 13 Nov 2014 00:12:21 -0500
Received: by mail-ie0-f170.google.com with SMTP id tp5so15180403ieb.29
 for <lttng-dev@lists.lttng.org>; Wed, 12 Nov 2014 21:12:14 -0800 (PST)
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD6FBC890A@VAL-E-02.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0106084362==
Content-Type: multipart/alternative; boundary=001a113fe8862f28b80507b68ef2

--001a113fe8862f28b80507b68ef2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello Daniel,

I should correct myself and say cross compiled LTTng to run on ARM. We
installed lttng-modules via insmod and verified with lsmod. Regarding
lttng-modules, there was a problem compiling where duplicate definition
occurred. We use kernel version 3.8 and in the source code saw the
conflicting section "should be" guarded for version less than 3.15. So we
added version check to work around it.

We have not tested ust yet. But have compiled all three (lttng-ust,
lttng-tools, lttng-modules) and placed on development board. Right now, we
are just doing a simple trace for a certain irq that triggers every 4ms.
This is the most information we got:
[00:01:36.985006316] (+0.001175688) (none) lttng_statedump_interrupt: {
cpu_id =3D 0 }, { irq =3D 29, name =3D "GIC", action =3D "twd" }

Also noticed this when creating a session:
[ 2][   64.512057] ##### send signal SIG : 10,
lttng-sessiond(373)->lttng(262) __send_signal

Thanks,
MIKE

2014-11-13 3:10 GMT+08:00 Thibault, Daniel <Daniel.Thibault@drdc-rddc.gc.ca=
>
:

> ----------------------------------------------------------------------
> Date: Wed, 12 Nov 2014 23:26:41 +0800
> From: J Lin <jmlin.jmlin@gmail.com>
>
> > I've recently ported LTTng to ARM and I can't seem to understand what i=
s
> going wrong with my results. I ran a typical session with "lttng
> enable-event -k -a" for test. Here are the observations:
> >
> > 1. only "lttng_xxx (e.g, lttng_statedump_interrupts)" are recorded 2.
> different sessions yield trace on different CPU (the system has 4) but no=
t
> for all 4, just 1 cpu 3. no recorded session span more than 1 second thou=
gh
> I would run sleep (i.e., 10s) between "start" and "stop"
> >
> > This leads me to believe LTTng might be dependent on something in the
> system that isn't present. This is a customized kernel of a client. It ha=
s
> all required configs.
> >
> > If there is a trigger mechanism after running "lttng start", what would
> it be? It seems it grabs items initially then doesn't continue. I read in
> one of the papers that LTTng is architecture dependent. Any help is
> appreciated.
> >
> > Mike
>
>    How exactly did you "port" LTTng to ARM?  As far as I know, you need
> only rebuild it there.  Your symptoms lead me to believe you may have not
> installed the requisite lttng-modules.  Did you test user-space tracing?
>
> Daniel U. Thibault
> Protection des syst=C3=A8mes et contremesures (PSC) | Systems Protection =
&
> Countermeasures (SPC)
> Cyber s=C3=A9curit=C3=A9 pour les missions essentielles (CME) | Mission C=
ritical
> Cyber Security (MCCS)
> RDDC - Centre de recherches de Valcartier | DRDC - Valcartier Research
> Centre
> 2459 route de la Bravoure
> Qu=C3=A9bec QC  G3J 1X5
> CANADA
> Vox : (418) 844-4000 x4245
> Fax : (418) 844-4538
> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada | Government of Canada
> <http://www.valcartier.drdc-rddc.gc.ca/>
>

--001a113fe8862f28b80507b68ef2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span style=3D"font-family:arial,sans-serif;font-size:14px=
">Hello Daniel,</span><div style=3D"font-family:arial,sans-serif;font-size:=
14px"><br></div><div style=3D"font-family:arial,sans-serif;font-size:14px">=
I should correct myself and say cross compiled LTTng to run on ARM. We inst=
alled lttng-modules via insmod and verified with lsmod. Regarding lttng-mod=
ules, there was a problem compiling where duplicate definition occurred. We=
 use kernel version 3.8 and in the source code saw the conflicting section =
&quot;should be&quot; guarded for version less than 3.15. So we added versi=
on check to work around it.</div><div style=3D"font-family:arial,sans-serif=
;font-size:14px"><br></div><div style=3D"font-family:arial,sans-serif;font-=
size:14px">We have not tested ust yet. But have compiled all three (lttng-u=
st, lttng-tools, lttng-modules) and placed on development board. Right now,=
 we are just doing a simple trace for a certain irq that triggers every 4ms=
. This is the most information we got:<br></div><div style=3D"font-family:a=
rial,sans-serif;font-size:14px">[00:01:36.985006316] (+0.001175688) (none) =
lttng_statedump_interrupt: { cpu_id =3D 0 }, { irq =3D 29, name =3D &quot;G=
IC&quot;, action =3D &quot;twd&quot; }<br></div><div style=3D"font-family:a=
rial,sans-serif;font-size:14px"><br></div><div style=3D"font-family:arial,s=
ans-serif;font-size:14px">Also noticed this when creating a session:</div><=
div style=3D"font-family:arial,sans-serif;font-size:14px">[ 2][ =C2=A0 64.5=
12057] ##### send signal SIG : 10, lttng-sessiond(373)-&gt;lttng(262) __sen=
d_signal</div><div style=3D"font-family:arial,sans-serif;font-size:14px"><b=
r></div><div style=3D"font-family:arial,sans-serif;font-size:14px">Thanks,<=
/div><div style=3D"font-family:arial,sans-serif;font-size:14px">MIKE</div><=
div class=3D"gmail_extra"><br><div class=3D"gmail_quote">2014-11-13 3:10 GM=
T+08:00 Thibault, Daniel <span dir=3D"ltr">&lt;<a href=3D"mailto:Daniel.Thi=
bault@drdc-rddc.gc.ca" target=3D"_blank">Daniel.Thibault@drdc-rddc.gc.ca</a=
>&gt;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">---------------------------=
-------------------------------------------<br>
Date: Wed, 12 Nov 2014 23:26:41 +0800<br>
From: J Lin &lt;<a href=3D"mailto:jmlin.jmlin@gmail.com">jmlin.jmlin@gmail.=
com</a>&gt;<br>
<div><div class=3D"h5"><br>
&gt; I&#39;ve recently ported LTTng to ARM and I can&#39;t seem to understa=
nd what is going wrong with my results. I ran a typical session with &quot;=
lttng enable-event -k -a&quot; for test. Here are the observations:<br>
&gt;<br>
&gt; 1. only &quot;lttng_xxx (e.g, lttng_statedump_interrupts)&quot; are re=
corded 2. different sessions yield trace on different CPU (the system has 4=
) but not for all 4, just 1 cpu 3. no recorded session span more than 1 sec=
ond though I would run sleep (i.e., 10s) between &quot;start&quot; and &quo=
t;stop&quot;<br>
&gt;<br>
&gt; This leads me to believe LTTng might be dependent on something in the =
system that isn&#39;t present. This is a customized kernel of a client. It =
has all required configs.<br>
&gt;<br>
&gt; If there is a trigger mechanism after running &quot;lttng start&quot;,=
 what would it be? It seems it grabs items initially then doesn&#39;t conti=
nue. I read in one of the papers that LTTng is architecture dependent. Any =
help is appreciated.<br>
&gt;<br>
</div></div>&gt; Mike<br>
<br>
=C2=A0 =C2=A0How exactly did you &quot;port&quot; LTTng to ARM?=C2=A0 As fa=
r as I know, you need only rebuild it there.=C2=A0 Your symptoms lead me to=
 believe you may have not installed the requisite lttng-modules.=C2=A0 Did =
you test user-space tracing?<br>
<br>
Daniel U. Thibault<br>
Protection des syst=C3=A8mes et contremesures (PSC) | Systems Protection &a=
mp; Countermeasures (SPC)<br>
Cyber s=C3=A9curit=C3=A9 pour les missions essentielles (CME) | Mission Cri=
tical Cyber Security (MCCS)<br>
RDDC - Centre de recherches de Valcartier | DRDC - Valcartier Research Cent=
re<br>
2459 route de la Bravoure<br>
Qu=C3=A9bec QC=C2=A0 G3J 1X5<br>
CANADA<br>
Vox : <a href=3D"tel:%28418%29%20844-4000%20x4245" value=3D"+14188444000">(=
418) 844-4000 x4245</a><br>
Fax : <a href=3D"tel:%28418%29%20844-4538" value=3D"+14188444538">(418) 844=
-4538</a><br>
NAC : 918V QSDJ &lt;<a href=3D"http://www.travelgis.com/map.asp?addr=3D918V=
%20QSDJ" target=3D"_blank">http://www.travelgis.com/map.asp?addr=3D918V%20Q=
SDJ</a>&gt;<br>
Gouvernement du Canada | Government of Canada<br>
&lt;<a href=3D"http://www.valcartier.drdc-rddc.gc.ca/" target=3D"_blank">ht=
tp://www.valcartier.drdc-rddc.gc.ca/</a>&gt;<br>
</blockquote></div><br></div></div>

--001a113fe8862f28b80507b68ef2--


--===============0106084362==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0106084362==--
