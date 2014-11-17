From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Strange result from LTTng porting to ARM
Date: Mon, 17 Nov 2014 16:53:36 +0000 (UTC)
Message-ID: <1715996455.14931.1416243216473.JavaMail.zimbra__12850.4338478253$1416243265$gmane$org@efficios.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD6FBC890A@VAL-E-02.valcartier.drdc-rddc.gc.ca>
 <CACtA8QRE5Y70-Tiss4siDufPyoUzgKBR7BUWR_XYwNSL0UkKuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0783175507=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1XqPYe-00022R-93
 for lttng-dev@lists.lttng.org; Mon, 17 Nov 2014 11:53:46 -0500
In-Reply-To: <CACtA8QRE5Y70-Tiss4siDufPyoUzgKBR7BUWR_XYwNSL0UkKuQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: J Lin <jmlin.jmlin@gmail.com>
Cc: lttng-dev@lists.lttng.org, Daniel Thibault <Daniel.Thibault@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

--===============0783175507==
Content-Type: multipart/alternative;
	boundary="----=_Part_14930_867043050.1416243216472"

------=_Part_14930_867043050.1416243216472
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,=20

There is little we can do without information about the kernel=20
customization that have been done in your use-case. Most likely,=20
there might be one customization that breaks tracepoints located=20
in the core kernel. It appears that only the tracepoints present in=20
the lttng-module modules are traced.=20

Just as a guess, do you have CONFIG_JUMP_LABEL=3Dy=20
in your config ? Try setting it to "n'. Just in case they would=20
happen to be broken on your specific kernel version/customization.=20

Good luck!=20

Mathieu=20

----- Original Message -----

> From: "J Lin" <jmlin.jmlin@gmail.com>
> To: "Daniel Thibault" <Daniel.Thibault@drdc-rddc.gc.ca>
> Cc: lttng-dev@lists.lttng.org
> Sent: Thursday, November 13, 2014 6:12:14 AM
> Subject: Re: [lttng-dev] Strange result from LTTng porting to ARM

> Hello Daniel,

> I should correct myself and say cross compiled LTTng to run on ARM. We
> installed lttng-modules via insmod and verified with lsmod. Regarding
> lttng-modules, there was a problem compiling where duplicate definition
> occurred. We use kernel version 3.8 and in the source code saw the
> conflicting section "should be" guarded for version less than 3.15. So we
> added version check to work around it.

> We have not tested ust yet. But have compiled all three (lttng-ust,
> lttng-tools, lttng-modules) and placed on development board. Right now, w=
e
> are just doing a simple trace for a certain irq that triggers every 4ms.
> This is the most information we got:
> [00:01:36.985006316] (+0.001175688) (none) lttng_statedump_interrupt: {
> cpu_id =3D 0 }, { irq =3D 29, name =3D "GIC", action =3D "twd" }

> Also noticed this when creating a session:
> [ 2][ 64.512057] ##### send signal SIG : 10, lttng-sessiond(373)->lttng(2=
62)
> __send_signal

> Thanks,
> MIKE

> 2014-11-13 3:10 GMT+08:00 Thibault, Daniel < Daniel.Thibault@drdc-rddc.gc=
.ca
> > :

> > ----------------------------------------------------------------------
>=20
> > Date: Wed, 12 Nov 2014 23:26:41 +0800
>=20
> > From: J Lin < jmlin.jmlin@gmail.com >
>=20

> > > I've recently ported LTTng to ARM and I can't seem to understand what=
 is
> > > going wrong with my results. I ran a typical session with "lttng
> > > enable-event -k -a" for test. Here are the observations:
>=20
> > >
>=20
> > > 1. only "lttng_xxx (e.g, lttng_statedump_interrupts)" are recorded 2.
> > > different sessions yield trace on different CPU (the system has 4) bu=
t
> > > not
> > > for all 4, just 1 cpu 3. no recorded session span more than 1 second
> > > though I would run sleep (i.e., 10s) between "start" and "stop"
>=20
> > >
>=20
> > > This leads me to believe LTTng might be dependent on something in the
> > > system that isn't present. This is a customized kernel of a client. I=
t
> > > has
> > > all required configs.
>=20
> > >
>=20
> > > If there is a trigger mechanism after running "lttng start", what wou=
ld
> > > it
> > > be? It seems it grabs items initially then doesn't continue. I read i=
n
> > > one
> > > of the papers that LTTng is architecture dependent. Any help is
> > > appreciated.
>=20
> > >
>=20
> > > Mike
>=20

> > How exactly did you "port" LTTng to ARM? As far as I know, you need onl=
y
> > rebuild it there. Your symptoms lead me to believe you may have not
> > installed the requisite lttng-modules. Did you test user-space tracing?
>=20

> > Daniel U. Thibault
>=20
> > Protection des syst=C3=A8mes et contremesures (PSC) | Systems Protectio=
n &
> > Countermeasures (SPC)
>=20
> > Cyber s=C3=A9curit=C3=A9 pour les missions essentielles (CME) | Mission=
 Critical
> > Cyber
> > Security (MCCS)
>=20
> > RDDC - Centre de recherches de Valcartier | DRDC - Valcartier Research
> > Centre
>=20
> > 2459 route de la Bravoure
>=20
> > Qu=C3=A9bec QC G3J 1X5
>=20
> > CANADA
>=20
> > Vox : (418) 844-4000 x4245
>=20
> > Fax : (418) 844-4538
>=20
> > NAC : 918V QSDJ < http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ >
>=20
> > Gouvernement du Canada | Government of Canada
>=20
> > < http://www.valcartier.drdc-rddc.gc.ca/ >
>=20

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

------=_Part_14930_867043050.1416243216472
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><div>Hi,<br></div><div><br></div><div=
>There is little we can do without information about the kernel<br></div><d=
iv>customization that have been done in your use-case. Most likely,<br></di=
v><div>there might be one customization that breaks tracepoints located<br>=
</div><div>in the core kernel. It appears that only the tracepoints present=
 in<br></div><div>the lttng-module modules are traced.<br></div><div><br></=
div><div>Just as a guess, do you have CONFIG_JUMP_LABEL=3Dy<br></div><div>i=
n your config ? Try setting it to "n'. Just in case they would<br></div><di=
v>happen to be broken on your specific kernel version/customization.<br></d=
iv><div><br></div><div>Good luck!<br></div><div><br></div><div>Mathieu<br><=
/div><div><br></div><hr id=3D"zwchr"><blockquote style=3D"border-left:2px s=
olid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal=
;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-se=
rif;font-size:12pt;" data-mce-style=3D"border-left: 2px solid #1010FF; marg=
in-left: 5px; padding-left: 5px; color: #000; font-weight: normal; font-sty=
le: normal; text-decoration: none; font-family: Helvetica,Arial,sans-serif;=
 font-size: 12pt;"><b>From: </b>"J Lin" &lt;jmlin.jmlin@gmail.com&gt;<br><b=
>To: </b>"Daniel Thibault" &lt;Daniel.Thibault@drdc-rddc.gc.ca&gt;<br><b>Cc=
: </b>lttng-dev@lists.lttng.org<br><b>Sent: </b>Thursday, November 13, 2014=
 6:12:14 AM<br><b>Subject: </b>Re: [lttng-dev] Strange result from LTTng po=
rting to ARM<br><div><br></div><div dir=3D"ltr"><span style=3D"font-family:=
arial,sans-serif;font-size:14px" data-mce-style=3D"font-family: arial,sans-=
serif; font-size: 14px;">Hello Daniel,</span><div style=3D"font-family:aria=
l,sans-serif;font-size:14px" data-mce-style=3D"font-family: arial,sans-seri=
f; font-size: 14px;"><br></div><div style=3D"font-family:arial,sans-serif;f=
ont-size:14px" data-mce-style=3D"font-family: arial,sans-serif; font-size: =
14px;">I should correct myself and say cross compiled LTTng to run on ARM. =
We installed lttng-modules via insmod and verified with lsmod. Regarding lt=
tng-modules, there was a problem compiling where duplicate definition occur=
red. We use kernel version 3.8 and in the source code saw the conflicting s=
ection "should be" guarded for version less than 3.15. So we added version =
check to work around it.</div><div style=3D"font-family:arial,sans-serif;fo=
nt-size:14px" data-mce-style=3D"font-family: arial,sans-serif; font-size: 1=
4px;"><br></div><div style=3D"font-family:arial,sans-serif;font-size:14px" =
data-mce-style=3D"font-family: arial,sans-serif; font-size: 14px;">We have =
not tested ust yet. But have compiled all three (lttng-ust, lttng-tools, lt=
tng-modules) and placed on development board. Right now, we are just doing =
a simple trace for a certain irq that triggers every 4ms. This is the most =
information we got:<br></div><div style=3D"font-family:arial,sans-serif;fon=
t-size:14px" data-mce-style=3D"font-family: arial,sans-serif; font-size: 14=
px;">[00:01:36.985006316] (+0.001175688) (none) lttng_statedump_interrupt: =
{ cpu_id =3D 0 }, { irq =3D 29, name =3D "GIC", action =3D "twd" }<br></div=
><div style=3D"font-family:arial,sans-serif;font-size:14px" data-mce-style=
=3D"font-family: arial,sans-serif; font-size: 14px;"><br></div><div style=
=3D"font-family:arial,sans-serif;font-size:14px" data-mce-style=3D"font-fam=
ily: arial,sans-serif; font-size: 14px;">Also noticed this when creating a =
session:</div><div style=3D"font-family:arial,sans-serif;font-size:14px" da=
ta-mce-style=3D"font-family: arial,sans-serif; font-size: 14px;">[ 2][ &nbs=
p; 64.512057] ##### send signal SIG : 10, lttng-sessiond(373)-&gt;lttng(262=
) __send_signal</div><div style=3D"font-family:arial,sans-serif;font-size:1=
4px" data-mce-style=3D"font-family: arial,sans-serif; font-size: 14px;"><br=
></div><div style=3D"font-family:arial,sans-serif;font-size:14px" data-mce-=
style=3D"font-family: arial,sans-serif; font-size: 14px;">Thanks,</div><div=
 style=3D"font-family:arial,sans-serif;font-size:14px" data-mce-style=3D"fo=
nt-family: arial,sans-serif; font-size: 14px;">MIKE</div><div class=3D"gmai=
l_extra"><br><div class=3D"gmail_quote">2014-11-13 3:10 GMT+08:00 Thibault,=
 Daniel <span dir=3D"ltr">&lt;<a href=3D"mailto:Daniel.Thibault@drdc-rddc.g=
c.ca" target=3D"_blank" data-mce-href=3D"mailto:Daniel.Thibault@drdc-rddc.g=
c.ca">Daniel.Thibault@drdc-rddc.gc.ca</a>&gt;</span>:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex" data-mce-style=3D"margin: 0 0 0 .8ex; border-left: 1px #ccc s=
olid; padding-left: 1ex;">-------------------------------------------------=
---------------------<br> Date: Wed, 12 Nov 2014 23:26:41 +0800<br> From: J=
 Lin &lt;<a href=3D"mailto:jmlin.jmlin@gmail.com" target=3D"_blank" data-mc=
e-href=3D"mailto:jmlin.jmlin@gmail.com">jmlin.jmlin@gmail.com</a>&gt;<br><d=
iv><div class=3D"h5"><br> &gt; I've recently ported LTTng to ARM and I can'=
t seem to understand what is going wrong with my results. I ran a typical s=
ession with "lttng enable-event -k -a" for test. Here are the observations:=
<br> &gt;<br> &gt; 1. only "lttng_xxx (e.g, lttng_statedump_interrupts)" ar=
e recorded 2. different sessions yield trace on different CPU (the system h=
as 4) but not for all 4, just 1 cpu 3. no recorded session span more than 1=
 second though I would run sleep (i.e., 10s) between "start" and "stop"<br>=
 &gt;<br> &gt; This leads me to believe LTTng might be dependent on somethi=
ng in the system that isn't present. This is a customized kernel of a clien=
t. It has all required configs.<br> &gt;<br> &gt; If there is a trigger mec=
hanism after running "lttng start", what would it be? It seems it grabs ite=
ms initially then doesn't continue. I read in one of the papers that LTTng =
is architecture dependent. Any help is appreciated.<br> &gt;<br></div></div=
>&gt; Mike<br> <br> &nbsp; &nbsp;How exactly did you "port" LTTng to ARM?&n=
bsp; As far as I know, you need only rebuild it there.&nbsp; Your symptoms =
lead me to believe you may have not installed the requisite lttng-modules.&=
nbsp; Did you test user-space tracing?<br> <br> Daniel U. Thibault<br> Prot=
ection des syst=C3=A8mes et contremesures (PSC) | Systems Protection &amp; =
Countermeasures (SPC)<br> Cyber s=C3=A9curit=C3=A9 pour les missions essent=
ielles (CME) | Mission Critical Cyber Security (MCCS)<br> RDDC - Centre de =
recherches de Valcartier | DRDC - Valcartier Research Centre<br> 2459 route=
 de la Bravoure<br> Qu=C3=A9bec QC&nbsp; G3J 1X5<br> CANADA<br> Vox : <a hr=
ef=3D"tel:%28418%29%20844-4000%20x4245" target=3D"_blank" data-mce-href=3D"=
tel:%28418%29%20844-4000%20x4245">(418) 844-4000 x4245</a><br> Fax : <a hre=
f=3D"tel:%28418%29%20844-4538" target=3D"_blank" data-mce-href=3D"tel:%2841=
8%29%20844-4538">(418) 844-4538</a><br> NAC : 918V QSDJ &lt;<a href=3D"http=
://www.travelgis.com/map.asp?addr=3D918V%20QSDJ" target=3D"_blank" data-mce=
-href=3D"http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ">http://www.tr=
avelgis.com/map.asp?addr=3D918V%20QSDJ</a>&gt;<br> Gouvernement du Canada |=
 Government of Canada<br> &lt;<a href=3D"http://www.valcartier.drdc-rddc.gc=
.ca/" target=3D"_blank" data-mce-href=3D"http://www.valcartier.drdc-rddc.gc=
.ca/">http://www.valcartier.drdc-rddc.gc.ca/</a>&gt;<br></blockquote></div>=
<br></div></div><br>_______________________________________________<br>lttn=
g-dev mailing list<br>lttng-dev@lists.lttng.org<br>http://lists.lttng.org/c=
gi-bin/mailman/listinfo/lttng-dev<br></blockquote><div><br><br></div><div><=
br></div><div>-- <br></div><div><span name=3D"x"></span>Mathieu Desnoyers<b=
r>EfficiOS Inc.<br>http://www.efficios.com<span name=3D"x"></span><br></div=
></div></body></html>
------=_Part_14930_867043050.1416243216472--


--===============0783175507==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0783175507==--
