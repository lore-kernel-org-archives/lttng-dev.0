From: "=?UTF-8?Q?David_Lindstr=C3=B6m?=" <david.lindstrom@percepio.se>
Subject: Re: Tagging traces with arbitrary data (as in
	custommetadata)
Date: Tue, 5 Nov 2013 15:49:08 +0100
Message-ID: <C28F32BAA3794A9895BA53E358410D54__34005.6396941238$1383663025$gmane$org@DVDMANDT5>
References: <C62A2692A7474EDFAB0AD54DA97D77E8@DVDMANDT5>
	<1726942705.57214.1383661201794.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2047510567=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <david.lindstrom@percepio.se>) id 1VdhwT-0005UO-Vp
	for lttng-dev@lists.lttng.org; Tue, 05 Nov 2013 09:49:24 -0500
Received: by mail-lb0-f182.google.com with SMTP id w6so6695217lbh.13
	for <lttng-dev@lists.lttng.org>; Tue, 05 Nov 2013 06:49:11 -0800 (PST)
In-Reply-To: <1726942705.57214.1383661201794.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, =?UTF-8?Q?DavidLindstr=C3=B6m?= <david.lindstrom@percepio.se>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This is a multi-part message in MIME format.

--===============2047510567==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0BAE_01CEDA3E.907FDF90"

This is a multi-part message in MIME format.

------=_NextPart_000_0BAE_01CEDA3E.907FDF90
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

  From: Mathieu Desnoyers=20
  Sent: Tuesday, November 05, 2013 3:20 PM
  To: DavidLindstr=C3=B6m=20
  Cc: lttng-dev@lists.lttng.org=20
  Subject: Re: [lttng-dev] Tagging traces with arbitrary data (as in =
custommetadata)


-------------------------------------------------------------------------=
-----

    From: "David Lindstr=C3=B6m" <david.lindstrom@percepio.se>
    To: lttng-dev@lists.lttng.org
    Sent: Tuesday, November 5, 2013 9:15:14 AM
    Subject: [lttng-dev] Tagging traces with arbitrary data (as in =
custom        metadata)


    Hi, I was wondering if there=E2=80=99s a way to tag a trace with =
some additional information. A general example would be to include a =
description of the current experiment. One way to do this currently =
would be to create a custom lttng-message application with some UST =
tracepoint and then just log that to a separate channel, but that would =
be pretty ugly. It would be much cleaner to insert extra fields into the =
metadata stream. Is something like that possible in current versions of =
LTTng and/or would it be possible to add it for a future version?

  The CTF metadata has an environment (env {}) section that contains =
this kind of information. LTTng already uses it to store the tracer =
version and some info about the system. We could eventually add a =
feature like this, a "tag", that would be added to the CTF environment =
information. I would guess that users would provide this tag on the =
lttng command line for their session, and it would be passed to the =
tracers by sessiond.


  Thoughts ?


I have no idea how this would be implemented, I=E2=80=99m only looking =
at potential uses. A simple tag field in the env{} section should cover =
my initial use cases. I have to wonder though, how much more complicated =
it would be to allow multiple named tags? For example, tags.description =
=3D =E2=80=9DSome description=E2=80=9D instead of tag =3D =E2=80=9CSome =
description=E2=80=9D?

Also, how would one specify this? As an option to the lttng create =
command or as a separate command (lttng set-tag ...)?

Mvh
David Lindstr=C3=B6m

  Thanks,


  Mathieu


    Mvh
    David Lindstr=C3=B6m

    _______________________________________________
    lttng-dev mailing list
    lttng-dev@lists.lttng.org
    http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev





  --=20

  Mathieu Desnoyers
  EfficiOS Inc.
  http://www.efficios.com

------=_NextPart_000_0BAE_01CEDA3E.907FDF90
Content-Type: text/html;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<HTML><HEAD></HEAD>
<BODY dir=3Dltr>
<DIV dir=3Dltr>
<DIV style=3D"FONT-SIZE: 12pt; FONT-FAMILY: 'Calibri'; COLOR: #000000">
<BLOCKQUOTE style=3D"MARGIN-RIGHT: 0px" dir=3Dltr>
  <DIV>
  <DIV=20
  style=3D"FONT-SIZE: small; FONT-FAMILY: 'Calibri'; FONT-WEIGHT: =
normal; COLOR: #000000; FONT-STYLE: normal; TEXT-DECORATION: none; =
DISPLAY: inline"><B>From:</B>=20
  <A title=3Dmathieu.desnoyers@efficios.com=20
  href=3D"mailto:mathieu.desnoyers@efficios.com">Mathieu Desnoyers</A> =
</DIV>
  <DIV style=3D"FONT: 10pt tahoma">
  <DIV style=3D"BACKGROUND: #f5f5f5">
  <DIV><B>Sent:</B> Tuesday, November 05, 2013 3:20 PM</DIV>
  <DIV><B>To:</B> <A title=3Ddavid.lindstrom@percepio.se=20
  href=3D"mailto:david.lindstrom@percepio.se">DavidLindstr=C3=B6m</A> =
</DIV>
  <DIV><B>Cc:</B> <A title=3Dlttng-dev@lists.lttng.org=20
  =
href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</A> =
</DIV>
  <DIV><B>Subject:</B> Re: [lttng-dev] Tagging traces with arbitrary =
data (as in=20
  custommetadata)</DIV></DIV></DIV>
  <DIV>&nbsp;</DIV></DIV>
  <DIV=20
  style=3D"FONT-SIZE: small; FONT-FAMILY: 'Calibri'; FONT-WEIGHT: =
normal; COLOR: #000000; FONT-STYLE: normal; TEXT-DECORATION: none; =
DISPLAY: inline">
  <DIV=20
  style=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new roman, new york, =
times, serif; COLOR: #000000">
  <HR id=3Dzwchr>

  <BLOCKQUOTE=20
  style=3D"FONT-SIZE: 12pt; FONT-FAMILY: helvetica,arial,sans-serif; =
FONT-WEIGHT: normal; COLOR: #000; FONT-STYLE: normal; PADDING-LEFT: 5px; =
MARGIN-LEFT: 5px; TEXT-DECORATION: none; BORDER-LEFT: #1010ff 2px =
solid"><B>From:=20
    </B>"David Lindstr=C3=B6m" =
&lt;david.lindstrom@percepio.se&gt;<BR><B>To:=20
    </B>lttng-dev@lists.lttng.org<BR><B>Sent: </B>Tuesday, November 5, =
2013=20
    9:15:14 AM<BR><B>Subject: </B>[lttng-dev] Tagging traces with =
arbitrary data=20
    (as in custom&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
metadata)<BR>
    <DIV>&nbsp;</DIV>
    <DIV dir=3Dltr>
    <DIV style=3D"FONT-SIZE: 12pt; FONT-FAMILY: 'Calibri'; COLOR: =
#000000">
    <DIV>Hi, I was wondering if there=E2=80=99s a way to tag a trace =
with some=20
    additional information. A general example would be to include a =
description=20
    of the current experiment. One way to do this currently would be to =
create a=20
    custom lttng-message application with some UST tracepoint and then =
just log=20
    that to a separate channel, but that would be pretty ugly. It would =
be much=20
    cleaner to insert extra fields into the metadata stream. Is =
something like=20
    that possible in current versions of LTTng and/or would it be =
possible to=20
    add it for a future version?</DIV></DIV></DIV></BLOCKQUOTE>
  <DIV>&nbsp;</DIV>
  <DIV>The CTF metadata has an environment (env {}) section that =
contains this=20
  kind of information. LTTng already uses it to store the tracer version =
and=20
  some info about the system. We could eventually add a feature like =
this, a=20
  "tag", that would be added to the CTF environment information. I would =
guess=20
  that users would provide this tag on the lttng command line for their =
session,=20
  and it would be passed to the tracers by sessiond.<BR></DIV>
  <DIV>&nbsp;</DIV>
  <DIV>Thoughts ?<BR></DIV>
  <DIV><FONT face=3DCalibri></FONT>&nbsp;</DIV></DIV></DIV></BLOCKQUOTE>
<DIV dir=3Dltr>I have no idea how this would be implemented, I=E2=80=99m =
only looking at=20
potential uses. A simple tag field in the env{} section should cover my =
initial=20
use cases. I have to wonder though, how much more complicated it would =
be to=20
allow multiple named tags? For example, tags.description =3D =
=E2=80=9DSome description=E2=80=9D=20
instead of tag =3D =E2=80=9CSome description=E2=80=9D?</DIV>
<DIV dir=3Dltr>&nbsp;</DIV>
<DIV dir=3Dltr>Also, how would one specify this? As an option to the =
lttng create=20
command or as a separate command (lttng set-tag ...)?</DIV>
<DIV dir=3Dltr>&nbsp;</DIV>
<DIV dir=3Dltr>Mvh</DIV>
<DIV dir=3Dltr>David Lindstr=C3=B6m</DIV>
<BLOCKQUOTE style=3D"MARGIN-RIGHT: 0px" dir=3Dltr>
  <DIV=20
  style=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new roman, new york, =
times, serif; COLOR: #000000"><FONT=20
  face=3DCalibri></FONT>&nbsp;</DIV>
  <DIV=20
  style=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new roman, new york, =
times, serif; COLOR: #000000">Thanks,<BR></DIV>
  <DIV=20
  style=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new roman, new york, =
times, serif; COLOR: #000000">&nbsp;</DIV>
  <DIV=20
  style=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new roman, new york, =
times, serif; COLOR: #000000">Mathieu<BR></DIV>
  <DIV=20
  style=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new roman, new york, =
times, serif; COLOR: #000000">&nbsp;</DIV>
  <BLOCKQUOTE=20
  style=3D"FONT-SIZE: 12pt; FONT-FAMILY: helvetica,arial,sans-serif; =
FONT-WEIGHT: normal; COLOR: #000; FONT-STYLE: normal; PADDING-LEFT: 5px; =
MARGIN-LEFT: 5px; TEXT-DECORATION: none; BORDER-LEFT: #1010ff 2px =
solid">
    <DIV dir=3Dltr>
    <DIV style=3D"FONT-SIZE: 12pt; FONT-FAMILY: 'Calibri'; COLOR: =
#000000">
    <DIV=20
    style=3D"FONT-SIZE: 12pt; FONT-FAMILY: 'Calibri'; COLOR: =
#000000">Mvh<BR>David=20
    =
Lindstr=C3=B6m</DIV></DIV></DIV><BR>_____________________________________=
__________<BR>lttng-dev=20
    mailing=20
    =
list<BR>lttng-dev@lists.lttng.org<BR>http://lists.lttng.org/cgi-bin/mailm=
an/listinfo/lttng-dev<BR></BLOCKQUOTE>
  <DIV=20
  style=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new roman, new york, =
times, serif; COLOR: #000000"><BR><BR></DIV>
  <DIV=20
  style=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new roman, new york, =
times, serif; COLOR: #000000">&nbsp;</DIV>
  <DIV=20
  style=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new roman, new york, =
times, serif; COLOR: #000000">--=20
  <BR></DIV>
  <DIV=20
  style=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new roman, new york, =
times, serif; COLOR: #000000"><SPAN=20
  name=3D"x"></SPAN>Mathieu Desnoyers<BR>EfficiOS=20
  Inc.<BR>http://www.efficios.com<SPAN=20
name=3D"x"></SPAN><BR></DIV></BLOCKQUOTE></DIV></DIV>
<DIV></DIV></BODY></HTML>

------=_NextPart_000_0BAE_01CEDA3E.907FDF90--



--===============2047510567==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2047510567==--
