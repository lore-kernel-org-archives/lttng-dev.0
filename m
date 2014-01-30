From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] Use uint32_t for
 lttng_viewer_stream.metadata_flag
Date: Thu, 30 Jan 2014 22:54:46 +0000 (UTC)
Message-ID: <17774810.15998.1391122486437.JavaMail.zimbra__38571.0471346558$1391122650$gmane$org@efficios.com>
References: <1390002463-21184-1-git-send-email-marc-andre.laperle@ericsson.com>
	<CAFXXi0nYX8xQAvDW+uox6bfx0ODa2Rdr4ex35pP8PmXotnMjyg@mail.gmail.com>
	<D381217948BF4C45AF756AFC995BEB9F1C1A2A4D@eusaamb103.ericsson.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1589479481=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1W90VW-0004DD-JS
	for lttng-dev@lists.lttng.org; Thu, 30 Jan 2014 17:54:56 -0500
In-Reply-To: <D381217948BF4C45AF756AFC995BEB9F1C1A2A4D@eusaamb103.ericsson.se>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?utf-8?Q?Marc-Andr=C3=A9?= Laperle <marc-andre.laperle@ericsson.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1589479481==
Content-Type: multipart/alternative;
	boundary="----=_Part_15997_251714200.1391122486435"

------=_Part_15997_251714200.1391122486435
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Using a char should be OK here.=20

----- Original Message -----

> From: "Marc-Andr=C3=A9 Laperle" <marc-andre.laperle@ericsson.com>
> To: "Simon Marchi" <simon.marchi@polymtl.ca>
> Cc: lttng-dev@lists.lttng.org
> Sent: Monday, January 20, 2014 3:25:07 PM
> Subject: Re: [lttng-dev] [PATCH] Use uint32_t for
> lttng_viewer_stream.metadata_flag

> I'm not sure that's possible. Whether I change them to uint8_t or int8_t,=
 I
> get warnings because they get used with strncpy which wants char. Any ide=
a
> how to solve this?

> Marc-Andr=C3=A9

> From: thundersim@gmail.com [thundersim@gmail.com] on behalf of Simon Marc=
hi
> [simon.marchi@polymtl.ca]
> Sent: Friday, 17 January 2014 9:31 PM
> To: Marc-Andr=C3=A9 Laperle
> Cc: lttng-dev@lists.lttng.org
> Subject: Re: [lttng-dev] [PATCH] Use uint32_t for
> lttng_viewer_stream.metadata_flag

> While you are at it, you could change the char fields as well, since char=
 is
> not exact-width either.

> On 17 January 2014 18:47, Marc-Andre Laperle <
> marc-andre.laperle@ericsson.com > wrote:

> > This struct is meant to be sent over the network so members should be
>=20
> > of exact-width.
>=20

> > Signed-off-by: Marc-Andre Laperle < marc-andre.laperle@ericsson.com >
>=20
> > ---
>=20
> > src/bin/lttng-relayd/lttng-viewer.h | 2 +-
>=20
> > 1 file changed, 1 insertion(+), 1 deletion(-)
>=20

> > diff --git a/src/bin/lttng-relayd/lttng-viewer.h
> > b/src/bin/lttng-relayd/lttng-viewer.h
>=20
> > index 1977a43..6330270 100644
>=20
> > --- a/src/bin/lttng-relayd/lttng-viewer.h
>=20
> > +++ b/src/bin/lttng-relayd/lttng-viewer.h
>=20
> > @@ -100,7 +100,7 @@ struct lttng_viewer_session {
>=20
> > struct lttng_viewer_stream {
>=20
> > uint64_t id;
>=20
> > uint64_t ctf_trace_id;
>=20
> > - int metadata_flag;
>=20
> > + uint32_t metadata_flag;
>=20
> > char path_name[LTTNG_VIEWER_PATH_MAX];
>=20
> > char channel_name[LTTNG_VIEWER_NAME_MAX];
>=20
> > } __attribute__((__packed__));
>=20
> > --
>=20
> > 1.8.3.2
>=20

> > _______________________________________________
>=20
> > lttng-dev mailing list
>=20
> > lttng-dev@lists.lttng.org
>=20
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>=20

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

------=_Part_15997_251714200.1391122486435
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><div>Using a char should be OK here.<=
br></div><div><br></div><div><br></div><hr id=3D"zwchr"><blockquote style=
=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#0=
00;font-weight:normal;font-style:normal;text-decoration:none;font-family:He=
lvetica,Arial,sans-serif;font-size:12pt;"><b>From: </b>"Marc-Andr=C3=A9 Lap=
erle" &lt;marc-andre.laperle@ericsson.com&gt;<br><b>To: </b>"Simon Marchi" =
&lt;simon.marchi@polymtl.ca&gt;<br><b>Cc: </b>lttng-dev@lists.lttng.org<br>=
<b>Sent: </b>Monday, January 20, 2014 3:25:07 PM<br><b>Subject: </b>Re: [lt=
tng-dev] [PATCH] Use uint32_t for lttng_viewer_stream.metadata_flag<br><div=
><br></div>


<style id=3D"owaParaStyle">P {margin-top:0;margin-bottom:0;}</style>


<div style=3D"direction: ltr;font-family: Tahoma;color: #000000;font-size: =
10pt;">I'm not sure that's possible. Whether I change them to uint8_t or in=
t8_t, I get warnings because they get used with strncpy which wants char. A=
ny idea how to solve this?<br>
<br>
Marc-Andr=C3=A9<br>
<br>
<div style=3D"font-family: Times New Roman; color: #000000; font-size: 16px=
">
<hr>
<div style=3D"direction: ltr;" id=3D"divRpF924636"><span style=3D"color: #0=
00000; font-family: Tahoma; font-size: small;" data-mce-style=3D"color: #00=
0000; font-family: Tahoma; font-size: small;" color=3D"#000000" face=3D"Tah=
oma" size=3D"2"><b>From:</b> thundersim@gmail.com [thundersim@gmail.com] on=
 behalf of Simon Marchi [simon.marchi@polymtl.ca]<br>
<b>Sent:</b> Friday, 17 January 2014 9:31 PM<br>
<b>To:</b> Marc-Andr=C3=A9 Laperle<br>
<b>Cc:</b> lttng-dev@lists.lttng.org<br>
<b>Subject:</b> Re: [lttng-dev] [PATCH] Use uint32_t for lttng_viewer_strea=
m.metadata_flag<br>
</span><br>
</div>
<div></div>
<div>
<div dir=3D"ltr">While you are at it, you could change the char fields as w=
ell, since char is not exact-width either.</div>
<div class=3D"gmail_extra"><br>
<br>
<div class=3D"gmail_quote">On 17 January 2014 18:47, Marc-Andre Laperle <sp=
an dir=3D"ltr">
&lt;<a href=3D"mailto:marc-andre.laperle@ericsson.com" target=3D"_blank">ma=
rc-andre.laperle@ericsson.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex; border-left:1=
px #ccc solid; padding-left:1ex">
This struct is meant to be sent over the network so members should be<br>
of exact-width.<br>
<br>
Signed-off-by: Marc-Andre Laperle &lt;<a href=3D"mailto:marc-andre.laperle@=
ericsson.com" target=3D"_blank">marc-andre.laperle@ericsson.com</a>&gt;<br>
---<br>
&nbsp;src/bin/lttng-relayd/lttng-viewer.h | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/src/bin/lttng-relayd/lttng-viewer.h b/src/bin/lttng-relayd/ltt=
ng-viewer.h<br>
index 1977a43..6330270 100644<br>
--- a/src/bin/lttng-relayd/lttng-viewer.h<br>
+++ b/src/bin/lttng-relayd/lttng-viewer.h<br>
@@ -100,7 +100,7 @@ struct lttng_viewer_session {<br>
&nbsp;struct lttng_viewer_stream {<br>
&nbsp; &nbsp; &nbsp; &nbsp; uint64_t id;<br>
&nbsp; &nbsp; &nbsp; &nbsp; uint64_t ctf_trace_id;<br>
- &nbsp; &nbsp; &nbsp; int metadata_flag;<br>
+ &nbsp; &nbsp; &nbsp; uint32_t metadata_flag;<br>
&nbsp; &nbsp; &nbsp; &nbsp; char path_name[LTTNG_VIEWER_PATH_MAX];<br>
&nbsp; &nbsp; &nbsp; &nbsp; char channel_name[LTTNG_VIEWER_NAME_MAX];<br>
&nbsp;} __attribute__((__packed__));<br>
<span class=3D"HOEnZb"><span style=3D"color: #888888;" data-mce-style=3D"co=
lor: #888888;" color=3D"#888888">--<br>
1.8.3.2<br>
<br>
<br>
_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
</span></span></blockquote>
</div>
<br>
</div>
</div>
</div>
</div>


<br>_______________________________________________<br>lttng-dev mailing li=
st<br>lttng-dev@lists.lttng.org<br>http://lists.lttng.org/cgi-bin/mailman/l=
istinfo/lttng-dev<br></blockquote><div><br><br></div><div><br></div><div>--=
 <br></div><div><span name=3D"x"></span>Mathieu Desnoyers<br>EfficiOS Inc.<=
br>http://www.efficios.com<span name=3D"x"></span><br></div></div></body></=
html>
------=_Part_15997_251714200.1391122486435--


--===============1589479481==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1589479481==--
