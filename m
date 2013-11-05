From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Tagging traces with arbitrary data (as in
	custom	metadata)
Date: Tue, 5 Nov 2013 14:20:01 +0000 (UTC)
Message-ID: <1726942705.57214.1383661201794.JavaMail.zimbra__14197.5339189687$1383661270$gmane$org@efficios.com>
References: <C62A2692A7474EDFAB0AD54DA97D77E8@DVDMANDT5>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1700417670=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VdhUE-00005U-UG
	for lttng-dev@lists.lttng.org; Tue, 05 Nov 2013 09:20:12 -0500
In-Reply-To: <C62A2692A7474EDFAB0AD54DA97D77E8@DVDMANDT5>
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

--===============1700417670==
Content-Type: multipart/alternative;
	boundary="----=_Part_57213_1650548772.1383661201793"

------=_Part_57213_1650548772.1383661201793
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

----- Original Message -----

> From: "David Lindstr=C3=B6m" <david.lindstrom@percepio.se>
> To: lttng-dev@lists.lttng.org
> Sent: Tuesday, November 5, 2013 9:15:14 AM
> Subject: [lttng-dev] Tagging traces with arbitrary data (as in custom
> metadata)

> Hi, I was wondering if there=E2=80=99s a way to tag a trace with some add=
itional
> information. A general example would be to include a description of the
> current experiment. One way to do this currently would be to create a cus=
tom
> lttng-message application with some UST tracepoint and then just log that=
 to
> a separate channel, but that would be pretty ugly. It would be much clean=
er
> to insert extra fields into the metadata stream. Is something like that
> possible in current versions of LTTng and/or would it be possible to add =
it
> for a future version?

The CTF metadata has an environment (env {}) section that contains this kin=
d of information. LTTng already uses it to store the tracer version and som=
e info about the system. We could eventually add a feature like this, a "ta=
g", that would be added to the CTF environment information. I would guess t=
hat users would provide this tag on the lttng command line for their sessio=
n, and it would be passed to the tracers by sessiond.=20

Thoughts ?=20

Thanks,=20

Mathieu=20

> Mvh
> David Lindstr=C3=B6m

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

------=_Part_57213_1650548772.1383661201793
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><hr id=3D"zwchr"><blockquote style=3D=
"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;=
font-weight:normal;font-style:normal;text-decoration:none;font-family:Helve=
tica,Arial,sans-serif;font-size:12pt;"><b>From: </b>"David Lindstr=C3=B6m" =
&lt;david.lindstrom@percepio.se&gt;<br><b>To: </b>lttng-dev@lists.lttng.org=
<br><b>Sent: </b>Tuesday, November 5, 2013 9:15:14 AM<br><b>Subject: </b>[l=
ttng-dev] Tagging traces with arbitrary data (as in custom&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;metadata)<br><div><br></div><div dir=3D"ltr"=
><div style=3D"FONT-SIZE: 12pt; FONT-FAMILY: 'Calibri'; COLOR: #000000"><di=
v>Hi, I was wondering if there=E2=80=99s a way to tag a trace with some add=
itional=20
information. A general example would be to include a description of the cur=
rent=20
experiment. One way to do this currently would be to create a custom=20
lttng-message application with some UST tracepoint and then just log that t=
o a=20
separate channel, but that would be pretty ugly. It would be much cleaner t=
o=20
insert extra fields into the metadata stream. Is something like that possib=
le in=20
current versions of LTTng and/or would it be possible to add it for a futur=
e=20
version?</div></div></div></blockquote><div><br></div><div>The CTF metadata=
 has an environment (env {}) section that contains this kind of information=
. LTTng already uses it to store the tracer version and some info about the=
 system. We could eventually add a feature like this, a "tag", that would b=
e added to the CTF environment information. I would guess that users would =
provide this tag on the lttng command line for their session, and it would =
be passed to the tracers by sessiond.<br></div><div><br></div><div>Thoughts=
 ?<br></div><div><br></div><div>Thanks,<br></div><div><br></div><div>Mathie=
u<br></div><div><br></div><blockquote style=3D"border-left:2px solid #1010F=
F;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style=
:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-si=
ze:12pt;"><div dir=3D"ltr"><div style=3D"FONT-SIZE: 12pt; FONT-FAMILY: 'Cal=
ibri'; COLOR: #000000"><div style=3D"FONT-SIZE: 12pt; FONT-FAMILY: 'Calibri=
'; COLOR: #000000">Mvh<br>David=20
Lindstr=C3=B6m</div></div></div><br>_______________________________________=
________<br>lttng-dev mailing list<br>lttng-dev@lists.lttng.org<br>http://l=
ists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<br></blockquote><div><br>=
<br></div><div><br></div><div>-- <br></div><div><span name=3D"x"></span>Mat=
hieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com<span name=3D"x">=
</span><br></div></div></body></html>
------=_Part_57213_1650548772.1383661201793--


--===============1700417670==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1700417670==--
