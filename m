From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: Some corrections to the
 lttng man page
Date: Mon, 3 Feb 2014 16:05:39 +0000 (UTC)
Message-ID: <36531237.18093.1391443539534.JavaMail.zimbra__9320.02794365889$1391443609$gmane$org@efficios.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD2679FA2C@VAL-E-01.valcartier.drdc-rddc.gc.ca>
	<CA+jJMxu4WNTRny2x6C3H96_wLQaYeBEPk+HX1pXVvhHjT3X8Uw@mail.gmail.com>
	<48CF5AC71E61DB46B70D0F388054EFFD267A10D1@VAL-E-01.valcartier.drdc-rddc.gc.ca>
	<CA+jJMxsfyhffdEVEybjWA-5arfetSNbM9XuZXZN5r7mKX2xEEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1321265057=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1WAM1q-0004ka-Ix
	for lttng-dev@lists.lttng.org; Mon, 03 Feb 2014 11:05:52 -0500
In-Reply-To: <CA+jJMxsfyhffdEVEybjWA-5arfetSNbM9XuZXZN5r7mKX2xEEg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?utf-8?B?SsOpcsOpbWll?= Galarneau <jeremie.galarneau@efficios.com>
Cc: lttng-dev@lists.lttng.org, Daniel Thibault <Daniel.Thibault@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

--===============1321265057==
Content-Type: multipart/alternative;
	boundary="----=_Part_18092_1824475250.1391443539533"

------=_Part_18092_1824475250.1391443539533
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Perhaps someone should open a bug report to track this, or submit a patch ?=
=20

Thanks,=20

Mathieu=20

----- Original Message -----

> From: "J=C3=A9r=C3=A9mie Galarneau" <jeremie.galarneau@efficios.com>
> To: "Daniel Thibault" <Daniel.Thibault@drdc-rddc.gc.ca>
> Cc: lttng-dev@lists.lttng.org
> Sent: Tuesday, November 5, 2013 8:25:12 PM
> Subject: Re: [lttng-dev] [PATCH lttng-tools] Fix: Some corrections to the
> lttng man page

> On Tue, Nov 5, 2013 at 4:34 PM, Thibault, Daniel <
> Daniel.Thibault@drdc-rddc.gc.ca > wrote:

> > De : jeremie.galarneau@gmail.com
>=20
> > Envoy=C3=A9 : 5 novembre 2013 15:51
>=20

> > On Thu, Oct 24, 2013 at 12:09 PM, Thibault, Daniel <
> > Daniel.Thibault@drdc-rddc.gc.ca > wrote:
>=20

> > > -----Message d'origine-----
> >=20
>=20
> > > Date: Wed, 23 Oct 2013 12:08:47 -0400
> >=20
>=20
> > > From: J?r?mie Galarneau < jeremie.galarneau@efficios.com >
> >=20
>=20

> > > > diff --git a/doc/man/lttng.1 b/doc/man/lttng.1
> >=20
>=20
> > > > [...]
> >=20
>=20

> > > > +All user-space applications instrumented with lttng-ust(3) will
> >=20
>=20
> > > > automatically register to the session daemon. This feature gives yo=
u
> > > > the
> >=20
>=20
> > > > ability to list available traceable applications and tracepoints on=
 a
> > > > per
> > > > user
> >=20
>=20
> > > > basis. (See \fBlist\fP command).
> >=20
>=20

> > > Is this a statement of intent? LTTng 2.3.0's list command identifies
> > > user-space events by trace provider name, event name, and process ID,=
 but
> > > not by user ID (in fact it doesn't even yet filter the kernel events =
out
> > > when one asks for 'list -u session'; see bug #654). And there is as y=
et
> > > no
> > > way to filter the 'lttng list' output by user ID (an optional argumen=
t
> > > for
> > > the -u option could do the trick).
> >=20
>=20
> > > Of course, listing available tracepoints is automatically per-user wh=
en
> > > using
> > > a local session daemon. But if you're a member of the 'tracing' group=
,
> > > you'll deal exclusively with the root daemon and won't have that choi=
ce.
> >=20
>=20
> > > I didn't change the meaning of the original sentence. It just means t=
hat
> > > "lttng list" will output the events registered to the user's
> > > corresponding
> > > session daemon.
>=20

> > > Perhaps you can suggest a better phrasing?
>=20

> > >
>=20

> > > J=C3=A9r=C3=A9mie
>=20

> > How about this?
>=20

> > Each user-space application instrumented with lttng-ust(3) will
> > automatically
>=20

> > register with the root session daemon and its user session daemon. This
> > allows
>=20

> > each daemon to list the available traceable applications and tracepoint=
s at
>=20

> > any given moment (See the \fBlist\fP command).
>=20

> Looks good to me.

> Cheers,
> J=C3=A9r=C3=A9mie

> > (There is no need to explain further the diff between the two daemons s=
ince
> > the preceding paragraph in the man page already talks about co-existing
> > session daemons)
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
> > R & D pour la d=C3=A9fense Canada - Valcartier (RDDC Valcartier) | Defe=
nce R&D
> > Canada - Valcartier (DRDC Valcartier)
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

> --
> J=C3=A9r=C3=A9mie Galarneau
> EfficiOS Inc.
> http://www.efficios.com

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

------=_Part_18092_1824475250.1391443539533
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><div>Perhaps someone should open a bu=
g report to track this, or submit a patch ?<br></div><div><br></div><div>Th=
anks,<br></div><div><br></div><div>Mathieu<br></div><div><br></div><div><br=
></div><hr id=3D"zwchr"><blockquote style=3D"border-left:2px solid #1010FF;=
margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:n=
ormal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size=
:12pt;"><b>From: </b>"J=C3=A9r=C3=A9mie Galarneau" &lt;jeremie.galarneau@ef=
ficios.com&gt;<br><b>To: </b>"Daniel Thibault" &lt;Daniel.Thibault@drdc-rdd=
c.gc.ca&gt;<br><b>Cc: </b>lttng-dev@lists.lttng.org<br><b>Sent: </b>Tuesday=
, November 5, 2013 8:25:12 PM<br><b>Subject: </b>Re: [lttng-dev] [PATCH ltt=
ng-tools] Fix: Some corrections to the lttng man page<br><div><br></div><di=
v dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div><br></div><div class=
=3D"gmail_quote">On Tue, Nov 5, 2013 at 4:34 PM, Thibault, Daniel <span dir=
=3D"ltr">&lt;<a href=3D"mailto:Daniel.Thibault@drdc-rddc.gc.ca" target=3D"_=
blank">Daniel.Thibault@drdc-rddc.gc.ca</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">





<div lang=3D"FR-CA">
<div>
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;font-family:&quot=
;Tahoma&quot;,&quot;sans-serif&quot;" lang=3D"EN-CA">De&nbsp;:</span></b><s=
pan style=3D"font-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-ser=
if&quot;" lang=3D"EN-CA"> <a href=3D"mailto:jeremie.galarneau@gmail.com" ta=
rget=3D"_blank">jeremie.galarneau@gmail.com</a><br>

<b>Envoy=C3=A9&nbsp;:</b> 5 novembre 2013 15:51<br>
<br>
<span style=3D"text-decoration: underline;" data-mce-style=3D"text-decorati=
on: underline;"></span><span style=3D"text-decoration: underline;" data-mce=
-style=3D"text-decoration: underline;"></span></span></p>
<div><div class=3D"im">
<p class=3D"MsoNormal"><span lang=3D"EN-CA">On Thu, Oct 24, 2013 at 12:09 P=
M, Thibault, Daniel &lt;</span><a href=3D"mailto:Daniel.Thibault@drdc-rddc.=
gc.ca" target=3D"_blank"><span lang=3D"EN-CA">Daniel.Thibault@drdc-rddc.gc.=
ca</span></a><span lang=3D"EN-CA">&gt; wrote:<span style=3D"text-decoration=
: underline;" data-mce-style=3D"text-decoration: underline;"></span><span s=
tyle=3D"text-decoration: underline;" data-mce-style=3D"text-decoration: und=
erline;"></span></span></p>

</div><div>
<div><div class=3D"im">
<blockquote style=3D"border:none;border-left:solid #cccccc 1.0pt;padding:0c=
m 0cm 0cm 6.0pt;margin-left:4.8pt;margin-right:0cm">
<p class=3D"MsoNormal">-----Message d'origine-----<br>
Date: Wed, 23 Oct 2013 12:08:47 -0400<br>
From: J?r?mie Galarneau &lt;<a href=3D"mailto:jeremie.galarneau@efficios.co=
m" target=3D"_blank">jeremie.galarneau@efficios.com</a>&gt;<br>
<br>
&gt; diff --git a/doc/man/lttng.1 b/doc/man/lttng.1<br>
&gt; [...]<span style=3D"text-decoration: underline;" data-mce-style=3D"tex=
t-decoration: underline;"></span><span style=3D"text-decoration: underline;=
" data-mce-style=3D"text-decoration: underline;"></span></p>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">&gt; +All user-space =
applications instrumented with lttng-ust(3) will<br>
&gt; automatically register to the session daemon. This feature gives you t=
he<br>
&gt; ability to list available traceable applications and tracepoints on a =
per user<br>
&gt; basis. (See \fBlist\fP command).<span style=3D"text-decoration: underl=
ine;" data-mce-style=3D"text-decoration: underline;"></span><span style=3D"=
text-decoration: underline;" data-mce-style=3D"text-decoration: underline;"=
></span></p>
</div>
<p class=3D"MsoNormal" style=3D"margin-right:0cm;margin-bottom:12.0pt;margi=
n-left:11.55pt">
&nbsp; &nbsp;Is this a statement of intent? &nbsp;LTTng 2.3.0's list comman=
d identifies user-space events by trace provider name, event name, and proc=
ess ID, but not by user ID (in fact it doesn't even yet filter the kernel e=
vents out when one asks for 'list -u session';
 see bug #654). &nbsp;And there is as yet no way to filter the 'lttng list'=
 output by user ID (an optional argument for the -u option could do the tri=
ck).<span style=3D"color:#1f497d"><span style=3D"text-decoration: underline=
;" data-mce-style=3D"text-decoration: underline;"></span><span style=3D"tex=
t-decoration: underline;" data-mce-style=3D"text-decoration: underline;"></=
span></span></p>
</blockquote>
</div><blockquote style=3D"border:none;border-left:solid #cccccc 1.0pt;padd=
ing:0cm 0cm 0cm 6.0pt;margin-left:4.8pt;margin-right:0cm">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span lang=3D"EN-CA">=
&nbsp; &nbsp;Of course, listing available tracepoints is automatically per-=
user when using a local session daemon. &nbsp;</span>But if you're a member=
 of the 'tracing' group, you'll deal exclusively with
 the root daemon and won't have that choice.<span style=3D"text-decoration:=
 underline;" data-mce-style=3D"text-decoration: underline;"></span><span st=
yle=3D"text-decoration: underline;" data-mce-style=3D"text-decoration: unde=
rline;"></span></p>
</blockquote>
</div><div class=3D"im">
<p class=3D"MsoNormal"><span style=3D"color:#1f497d" lang=3D"EN-CA">&gt; </=
span><span lang=3D"EN-CA">I didn't change the meaning of the original sente=
nce. It just means that "lttng list" will output the events registered to t=
he user's corresponding session daemon.<span style=3D"color:#1f497d"><span =
style=3D"text-decoration: underline;" data-mce-style=3D"text-decoration: un=
derline;"></span><span style=3D"text-decoration: underline;" data-mce-style=
=3D"text-decoration: underline;"></span></span></span></p>

<p class=3D"MsoNormal"><span style=3D"color:#1f497d" lang=3D"EN-CA">&gt;</s=
pan><span lang=3D"EN-CA"> Perhaps you can suggest a better phrasing?<span s=
tyle=3D"text-decoration: underline;" data-mce-style=3D"text-decoration: und=
erline;"></span><span style=3D"text-decoration: underline;" data-mce-style=
=3D"text-decoration: underline;"></span></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1f497d">&gt;</span><span style=
=3D"text-decoration: underline;" data-mce-style=3D"text-decoration: underli=
ne;"></span>&nbsp;<span style=3D"text-decoration: underline;" data-mce-styl=
e=3D"text-decoration: underline;"></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1f497d">&gt; </span>J=C3=A9r=
=C3=A9mie<span style=3D"text-decoration: underline;" data-mce-style=3D"text=
-decoration: underline;"></span><span style=3D"text-decoration: underline;"=
 data-mce-style=3D"text-decoration: underline;"></span></p>
<p class=3D"MsoNormal"><span style=3D"text-decoration: underline;" data-mce=
-style=3D"text-decoration: underline;"></span>&nbsp;<span style=3D"text-dec=
oration: underline;" data-mce-style=3D"text-decoration: underline;"></span>=
</p>
</div><p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp; How about th=
is?<span style=3D"text-decoration: underline;" data-mce-style=3D"text-decor=
ation: underline;"></span><span style=3D"text-decoration: underline;" data-=
mce-style=3D"text-decoration: underline;"></span></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA"><span style=3D"text-decoration:=
 underline;" data-mce-style=3D"text-decoration: underline;"></span>&nbsp;<s=
pan style=3D"text-decoration: underline;" data-mce-style=3D"text-decoration=
: underline;"></span></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">Each user-space application ins=
trumented with lttng-ust(3) will automatically
<span style=3D"text-decoration: underline;" data-mce-style=3D"text-decorati=
on: underline;"></span><span style=3D"text-decoration: underline;" data-mce=
-style=3D"text-decoration: underline;"></span></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">register with the root session =
daemon and its user session daemon. This allows
<span style=3D"text-decoration: underline;" data-mce-style=3D"text-decorati=
on: underline;"></span><span style=3D"text-decoration: underline;" data-mce=
-style=3D"text-decoration: underline;"></span></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">each daemon to list the availab=
le traceable applications and tracepoints at
<span style=3D"text-decoration: underline;" data-mce-style=3D"text-decorati=
on: underline;"></span><span style=3D"text-decoration: underline;" data-mce=
-style=3D"text-decoration: underline;"></span></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">any given moment (See the \fBli=
st\fP command).<span style=3D"text-decoration: underline;" data-mce-style=
=3D"text-decoration: underline;"></span><span style=3D"text-decoration: und=
erline;" data-mce-style=3D"text-decoration: underline;"></span></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA"><span style=3D"text-decoration:=
 underline;" data-mce-style=3D"text-decoration: underline;"></span>&nbsp;</=
span></p></div></div></div></div></blockquote><div><br></div><div>Looks goo=
d to me.</div><div><br></div><div>Cheers,</div><div>J=C3=A9r=C3=A9mie</div>=
<div>&nbsp;</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">
<div lang=3D"FR-CA"><div><div><div><p class=3D"MsoNormal"><span lang=3D"EN-=
CA"><span style=3D"text-decoration: underline;" data-mce-style=3D"text-deco=
ration: underline;"></span></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">(There is no need to explain fu=
rther the diff between the two daemons since the preceding paragraph in the=
 man page already talks about co-existing session daemons)<span style=3D"te=
xt-decoration: underline;" data-mce-style=3D"text-decoration: underline;"><=
/span><span style=3D"text-decoration: underline;" data-mce-style=3D"text-de=
coration: underline;"></span></span></p>
<div class=3D"im">
<p class=3D"MsoNormal"><span lang=3D"EN-CA"><span style=3D"text-decoration:=
 underline;" data-mce-style=3D"text-decoration: underline;"></span>&nbsp;<s=
pan style=3D"text-decoration: underline;" data-mce-style=3D"text-decoration=
: underline;"></span></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:Consolas=
;color:#1f497d">Daniel U. Thibault<br>
Protection des syst=C3=A8mes et contremesures (PSC) | Systems Protection &a=
mp; Countermeasures (SPC)<br>
Cyber s=C3=A9curit=C3=A9 pour les missions essentielles (CME) | Mission Cri=
tical Cyber Security (MCCS)<br>
R &amp; D pour la d=C3=A9fense Canada - Valcartier (RDDC Valcartier) | Defe=
nce R&amp;D Canada - Valcartier (DRDC Valcartier)<br>
2459 route de la Bravoure<br>
Qu=C3=A9bec QC&nbsp; G3J 1X5<br>
CANADA<br>
Vox</span><span style=3D"font-size:10.5pt;font-family:Consolas;color:#1f497=
d">&nbsp;</span><span style=3D"font-size:11.0pt;font-family:Consolas;color:=
#1f497d">: <a href=3D"tel:%28418%29%20844-4000%20x4245" target=3D"_blank">(=
418) 844-4000 x4245</a><br>

Fax</span><span style=3D"font-size:10.5pt;font-family:Consolas;color:#1f497=
d">&nbsp;</span><span style=3D"font-size:11.0pt;font-family:Consolas;color:=
#1f497d">: <a href=3D"tel:%28418%29%20844-4538" target=3D"_blank">(418) 844=
-4538</a><br>

</span><span style=3D"font-size:11.0pt;font-family:Consolas;color:#1f497d">=
NAC&nbsp;: </span>
<span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-=
serif&quot;;color:#1f497d" lang=3D"EN-CA"><a href=3D"http://www.travelgis.c=
om/map.asp?addr=3D918V%20QSDJ" target=3D"_blank"><span style=3D"font-size:1=
0.0pt;font-family:&quot;Courier New&quot;" lang=3D"FR-CA">918V QSDJ</span><=
/a></span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&=
quot;sans-serif&quot;;color:#1f497d" lang=3D"EN-CA">
</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;;color:#1f497d">&lt;</span><span style=3D"text-decoration=
: underline;" data-mce-style=3D"text-decoration: underline;"><span style=3D=
"font-size:10.0pt;font-family:&quot;Courier New&quot;;color:blue"><a href=
=3D"http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ" target=3D"_blank">=
http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ</a></span></span><span =
style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&=
quot;;color:#1f497d">&gt;</span><span style=3D"font-size:11.0pt;font-family=
:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d"><br>

</span><span style=3D"font-size:11.0pt;font-family:Consolas;color:#1f497d">=
Gouvernement du Canada&nbsp;| Government of Canada<br>
</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;;color:#1f497d">&lt;</span><span style=3D"font-size:10.0p=
t;font-family:&quot;Courier New&quot;;color:blue" lang=3D"EN-CA"><a href=3D=
"http://www.valcartier.drdc-rddc.gc.ca/" target=3D"_blank"><span lang=3D"FR=
-CA">http://www.valcartier.drdc-rddc.gc.ca/</span></a></span><span style=3D=
"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:#1f497d">&gt;</span><span style=3D"font-size:10.5pt;font-family:Consola=
s;color:#1f497d"><span style=3D"text-decoration: underline;" data-mce-style=
=3D"text-decoration: underline;"></span><span style=3D"text-decoration: und=
erline;" data-mce-style=3D"text-decoration: underline;"></span></span></p>

</div></div>
</div>
</div>
</div>

</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>J=C3=A9r=C3=
=A9mie Galarneau<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com" ta=
rget=3D"_blank">http://www.efficios.com</a>
</div></div>
<br>_______________________________________________<br>lttng-dev mailing li=
st<br>lttng-dev@lists.lttng.org<br>http://lists.lttng.org/cgi-bin/mailman/l=
istinfo/lttng-dev<br></blockquote><div><br><br></div><div><br></div><div>--=
 <br></div><div><span name=3D"x"></span>Mathieu Desnoyers<br>EfficiOS Inc.<=
br>http://www.efficios.com<span name=3D"x"></span><br></div></div></body></=
html>
------=_Part_18092_1824475250.1391443539533--


--===============1321265057==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1321265057==--
