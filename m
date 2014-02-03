From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Tagging traces with arbitrary data (as in
 custommetadata)
Date: Mon, 3 Feb 2014 16:09:04 +0000 (UTC)
Message-ID: <1927955167.18151.1391443744893.JavaMail.zimbra__5320.44328651882$1391443807$gmane$org@efficios.com>
References: <C62A2692A7474EDFAB0AD54DA97D77E8@DVDMANDT5>
	<1726942705.57214.1383661201794.JavaMail.zimbra@efficios.com>
	<C28F32BAA3794A9895BA53E358410D54@DVDMANDT5>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1998302797=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1WAM57-0004oC-GO
	for lttng-dev@lists.lttng.org; Mon, 03 Feb 2014 11:09:15 -0500
In-Reply-To: <C28F32BAA3794A9895BA53E358410D54@DVDMANDT5>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David =?utf-8?Q?Lindstr=C3=B6m?= <david.lindstrom@percepio.se>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1998302797==
Content-Type: multipart/alternative;
	boundary="----=_Part_18150_322358643.1391443744891"

------=_Part_18150_322358643.1391443744891
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

----- Original Message -----

> From: "David Lindstr=C3=B6m" <david.lindstrom@percepio.se>
> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>, "DavidLindstr=
=C3=B6m"
> <david.lindstrom@percepio.se>
> Cc: lttng-dev@lists.lttng.org
> Sent: Tuesday, November 5, 2013 9:49:08 AM
> Subject: Re: [lttng-dev] Tagging traces with arbitrary data (as in
> custommetadata)

> > From: Mathieu Desnoyers
>=20
> > Sent: Tuesday, November 05, 2013 3:20 PM
>=20
> > To: DavidLindstr=C3=B6m
>=20
> > Cc: lttng-dev@lists.lttng.org
>=20
> > Subject: Re: [lttng-dev] Tagging traces with arbitrary data (as in
> > custommetadata)
>=20
> > ----- Original Message -----
>=20

> > > From: "David Lindstr=C3=B6m" <david.lindstrom@percepio.se>
> >=20
>=20
> > > To: lttng-dev@lists.lttng.org
> >=20
>=20
> > > Sent: Tuesday, November 5, 2013 9:15:14 AM
> >=20
>=20
> > > Subject: [lttng-dev] Tagging traces with arbitrary data (as in custom
> > > metadata)
> >=20
>=20
> > > Hi, I was wondering if there=E2=80=99s a way to tag a trace with some=
 additional
> > > information. A general example would be to include a description of t=
he
> > > current experiment. One way to do this currently would be to create a
> > > custom
> > > lttng-message application with some UST tracepoint and then just log =
that
> > > to
> > > a separate channel, but that would be pretty ugly. It would be much
> > > cleaner
> > > to insert extra fields into the metadata stream. Is something like th=
at
> > > possible in current versions of LTTng and/or would it be possible to =
add
> > > it
> > > for a future version?
> >=20
>=20

> > The CTF metadata has an environment (env {}) section that contains this
> > kind
> > of information. LTTng already uses it to store the tracer version and s=
ome
> > info about the system. We could eventually add a feature like this, a
> > "tag",
> > that would be added to the CTF environment information. I would guess t=
hat
> > users would provide this tag on the lttng command line for their sessio=
n,
> > and it would be passed to the tracers by sessiond.
>=20
> > Thoughts ?
>=20

> I have no idea how this would be implemented, I=E2=80=99m only looking at=
 potential
> uses. A simple tag field in the env{} section should cover my initial use
> cases. I have to wonder though, how much more complicated it would be to
> allow multiple named tags? For example, tags.description =3D =E2=80=9DSom=
e
> description=E2=80=9D instead of tag =3D =E2=80=9CSome description=E2=80=
=9D?

This could be called "user-provided environment", and could look like this =
in the metadata:=20

env {=20
....=20
user.myenvname =3D "text";=20
}=20

> Also, how would one specify this? As an option to the lttng create comman=
d or
> as a separate command (lttng set-tag ...)?

lttng set-env "text"=20

Thoughts ?=20

Thanks,=20

Mathieu=20

> Mvh
> David Lindstr=C3=B6m

> > Thanks,
>=20
> > Mathieu
>=20

> > > Mvh
> >=20
>=20
> > > David Lindstr=C3=B6m
> >=20
>=20

> > > _______________________________________________
> >=20
>=20
> > > lttng-dev mailing list
> >=20
>=20
> > > lttng-dev@lists.lttng.org
> >=20
>=20
> > > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >=20
>=20

> > --
>=20
> > Mathieu Desnoyers
>=20
> > EfficiOS Inc.
>=20
> > http://www.efficios.com
>=20

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

------=_Part_18150_322358643.1391443744891
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><hr id=3D"zwchr"><blockquote style=3D=
"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;=
font-weight:normal;font-style:normal;text-decoration:none;font-family:Helve=
tica,Arial,sans-serif;font-size:12pt;"><b>From: </b>"David Lindstr=C3=B6m" =
&lt;david.lindstrom@percepio.se&gt;<br><b>To: </b>"Mathieu Desnoyers" &lt;m=
athieu.desnoyers@efficios.com&gt;, "DavidLindstr=C3=B6m" &lt;david.lindstro=
m@percepio.se&gt;<br><b>Cc: </b>lttng-dev@lists.lttng.org<br><b>Sent: </b>T=
uesday, November 5, 2013 9:49:08 AM<br><b>Subject: </b>Re: [lttng-dev] Tagg=
ing traces with arbitrary data (as in custommetadata)<br><div><br></div><di=
v dir=3D"ltr"><div style=3D"FONT-SIZE: 12pt; FONT-FAMILY: 'Calibri'; COLOR:=
 #000000"><blockquote style=3D"MARGIN-RIGHT: 0px" dir=3D"ltr"><div><div sty=
le=3D"FONT-SIZE: small; FONT-FAMILY: 'Calibri'; FONT-WEIGHT: normal; COLOR:=
 #000000; FONT-STYLE: normal; TEXT-DECORATION: none; DISPLAY: inline"><b>Fr=
om:</b><a title=3D"mathieu.desnoyers@efficios.com" href=3D"mailto:mathieu.d=
esnoyers@efficios.com" target=3D"_blank">Mathieu Desnoyers</a><br data-mce-=
bogus=3D"1"></div><div style=3D"FONT: 10pt tahoma"><div style=3D"BACKGROUND=
: #f5f5f5"><div><b>Sent:</b> Tuesday, November 05, 2013 3:20 PM</div><div><=
b>To:</b><a title=3D"david.lindstrom@percepio.se" href=3D"mailto:david.lind=
strom@percepio.se" target=3D"_blank">DavidLindstr=C3=B6m</a><br data-mce-bo=
gus=3D"1"></div><div><b>Cc:</b><a title=3D"lttng-dev@lists.lttng.org" href=
=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.ltt=
ng.org</a><br data-mce-bogus=3D"1"></div><div><b>Subject:</b> Re: [lttng-de=
v] Tagging traces with arbitrary data (as in=20
  custommetadata)</div></div></div></div><div style=3D"FONT-SIZE: small; FO=
NT-FAMILY: 'Calibri'; FONT-WEIGHT: normal; COLOR: #000000; FONT-STYLE: norm=
al; TEXT-DECORATION: none; DISPLAY: inline"><div style=3D"FONT-SIZE: 12pt; =
FONT-FAMILY: times new roman, new york, times, serif; COLOR: #000000"><hr i=
d=3D"zwchr"><blockquote style=3D"FONT-SIZE: 12pt; FONT-FAMILY: helvetica,ar=
ial,sans-serif; FONT-WEIGHT: normal; COLOR: #000; FONT-STYLE: normal; PADDI=
NG-LEFT: 5px; MARGIN-LEFT: 5px; TEXT-DECORATION: none; BORDER-LEFT: #1010ff=
 2px solid"><b>From:=20
    </b>"David Lindstr=C3=B6m" &lt;david.lindstrom@percepio.se&gt;<br><b>To=
:=20
    </b>lttng-dev@lists.lttng.org<br><b>Sent: </b>Tuesday, November 5, 2013=
=20
    9:15:14 AM<br><b>Subject: </b>[lttng-dev] Tagging traces with arbitrary=
 data=20
    (as in custom&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; metadata)<br><d=
iv dir=3D"ltr"><div style=3D"FONT-SIZE: 12pt; FONT-FAMILY: 'Calibri'; COLOR=
: #000000"><div>Hi, I was wondering if there=E2=80=99s a way to tag a trace=
 with some=20
    additional information. A general example would be to include a descrip=
tion=20
    of the current experiment. One way to do this currently would be to cre=
ate a=20
    custom lttng-message application with some UST tracepoint and then just=
 log=20
    that to a separate channel, but that would be pretty ugly. It would be =
much=20
    cleaner to insert extra fields into the metadata stream. Is something l=
ike=20
    that possible in current versions of LTTng and/or would it be possible =
to=20
    add it for a future version?</div></div></div></blockquote><div>The CTF=
 metadata has an environment (env {}) section that contains this=20
  kind of information. LTTng already uses it to store the tracer version an=
d=20
  some info about the system. We could eventually add a feature like this, =
a=20
  "tag", that would be added to the CTF environment information. I would gu=
ess=20
  that users would provide this tag on the lttng command line for their ses=
sion,=20
  and it would be passed to the tracers by sessiond.<br></div><div>Thoughts=
 ?<br></div></div></div></blockquote><div dir=3D"ltr">I have no idea how th=
is would be implemented, I=E2=80=99m only looking at=20
potential uses. A simple tag field in the env{} section should cover my ini=
tial=20
use cases. I have to wonder though, how much more complicated it would be t=
o=20
allow multiple named tags? For example, tags.description =3D =E2=80=9DSome =
description=E2=80=9D=20
instead of tag =3D =E2=80=9CSome description=E2=80=9D?</div></div></div></b=
lockquote><div><br></div><div>This could be called "user-provided environme=
nt", and could look like this in the metadata:<br></div><div><br></div><div=
>env {<br></div><div>&nbsp; ....<br></div><div>&nbsp; user.myenvname =3D "t=
ext";<br></div><div>}<br></div><div><br></div><div><br></div><blockquote st=
yle=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color=
:#000;font-weight:normal;font-style:normal;text-decoration:none;font-family=
:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><div style=3D=
"FONT-SIZE: 12pt; FONT-FAMILY: 'Calibri'; COLOR: #000000"><div dir=3D"ltr">=
Also, how would one specify this? As an option to the lttng create=20
command or as a separate command (lttng set-tag ...)?</div></div></div></bl=
ockquote><div>lttng set-env "text"<br></div><div><br></div><div>Thoughts ?<=
br></div><div><br></div><div>Thanks,<br></div><div><br></div><div>Mathieu<b=
r></div><div><br></div><div><br></div><blockquote style=3D"border-left:2px =
solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:norma=
l;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-s=
erif;font-size:12pt;"><div dir=3D"ltr"><div style=3D"FONT-SIZE: 12pt; FONT-=
FAMILY: 'Calibri'; COLOR: #000000"><div dir=3D"ltr">Mvh</div><div dir=3D"lt=
r">David Lindstr=C3=B6m</div><blockquote style=3D"MARGIN-RIGHT: 0px" dir=3D=
"ltr"><div style=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new roman, new york=
, times, serif; COLOR: #000000">Thanks,<br></div><div style=3D"FONT-SIZE: 1=
2pt; FONT-FAMILY: times new roman, new york, times, serif; COLOR: #000000">=
Mathieu<br></div><blockquote style=3D"FONT-SIZE: 12pt; FONT-FAMILY: helveti=
ca,arial,sans-serif; FONT-WEIGHT: normal; COLOR: #000; FONT-STYLE: normal; =
PADDING-LEFT: 5px; MARGIN-LEFT: 5px; TEXT-DECORATION: none; BORDER-LEFT: #1=
010ff 2px solid"><div dir=3D"ltr"><div style=3D"FONT-SIZE: 12pt; FONT-FAMIL=
Y: 'Calibri'; COLOR: #000000"><div style=3D"FONT-SIZE: 12pt; FONT-FAMILY: '=
Calibri'; COLOR: #000000">Mvh<br>David=20
    Lindstr=C3=B6m</div></div></div><br>___________________________________=
____________<br>lttng-dev=20
    mailing=20
    list<br>lttng-dev@lists.lttng.org<br>http://lists.lttng.org/cgi-bin/mai=
lman/listinfo/lttng-dev<br></blockquote><div style=3D"FONT-SIZE: 12pt; FONT=
-FAMILY: times new roman, new york, times, serif; COLOR: #000000"><br><div>=
<br></div></div><div style=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new roman=
, new york, times, serif; COLOR: #000000">--=20
  <br></div><div style=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new roman, ne=
w york, times, serif; COLOR: #000000">Mathieu Desnoyers<br>EfficiOS=20
  Inc.<br>http://www.efficios.com<br></div></blockquote></div></div></block=
quote><div><br><br></div><div><br></div><div>-- <br></div><div><span name=
=3D"x"></span>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com=
<span name=3D"x"></span><br></div></div></body></html>
------=_Part_18150_322358643.1391443744891--


--===============1998302797==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1998302797==--
