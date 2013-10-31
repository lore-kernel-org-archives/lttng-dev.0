From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Fwd: VERY EASY one-liner fix to LTTng
Date: Thu, 31 Oct 2013 12:23:52 +0000 (UTC)
Message-ID: <146744101.54224.1383222232515.JavaMail.zimbra__11616.1477905282$1383222282$gmane$org@efficios.com>
References: <E79B4F21-5D60-4AE0-BEBD-CA8DEF079300@gmail.com>
	<72E40E92-B166-4803-89CF-09A972C5B8F8@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0084765158=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VbrI5-0000VM-Q7
	for lttng-dev@lists.lttng.org; Thu, 31 Oct 2013 08:23:59 -0400
In-Reply-To: <72E40E92-B166-4803-89CF-09A972C5B8F8@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Marcus Tomlinson <themarcustomlinson@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0084765158==
Content-Type: multipart/alternative;
	boundary="----=_Part_54223_1317477874.1383222232514"

------=_Part_54223_1317477874.1383222232514
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Marcus,=20

I tried applying your patch, which was oddly formatted. Please try using "q=
uilt" or "git" next time (or if you really want to generate your patch by h=
and, you need to use diff -urN).=20

I re-wrote the patch to ensure the empty brackets are on the next line (sim=
ilar to the surrounding lines), with a space in between (coding style), and=
 ends with a comma (coding style).=20

Next time, please provide the compiler version and compile flags you use to=
 reproduce the issue.=20

Fix merged into master, stable 2.3, stable 2.2,=20

Thanks for reporting this problem,=20

Mathieu=20

----- Original Message -----

> From: "Marcus Tomlinson" <themarcustomlinson@gmail.com>
> To: lttng-dev@lists.lttng.org
> Sent: Wednesday, October 30, 2013 3:08:00 AM
> Subject: [lttng-dev] Fwd: VERY EASY one-liner fix to LTTng

> Hi again, so to make things a little easier than easy, here is a patch
> that=E2=80=99ll do the trick.
> If anyone manages to find some time to get this committed, please could y=
ou
> let me know.
> Thanks again!

> Begin forwarded message:

> > From: Marcus Tomlinson < themarcustomlinson@gmail.com >
>=20
> > Subject: VERY EASY one-liner fix to LTTng
>=20
> > Date: 29 October 2013 at 3:45:53 PM SAST
>=20
> > To: lttng-dev@lists.lttng.org
>=20

> > Hi, could I ask that somebody please make a VERY EASY fix to LTTng and =
push
> > it for me.
>=20

> > I get compiler warnings about a missing initialiser for member =E2=80=
=98padding=E2=80=99 in
> > tracepoint.
>=20
> > Removing these warnings is really simple:
>=20

> > line 252 of =E2=80=9Ctracepoint.h=E2=80=9D needs to change from:
>=20
> > _TP_EXTRACT_STRING(_args), \
>=20
> > to:
>=20
> > _TP_EXTRACT_STRING(_args), {} \
>=20

> > Thanks in advance!
>=20

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

------=_Part_54223_1317477874.1383222232514
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><div>Hi Marcus,<br></div><div><br></d=
iv><div>I tried applying your patch, which was oddly formatted. Please try =
using "quilt" or "git" next time (or if you really want to generate your pa=
tch by hand, you need to use diff -urN).<br></div><div><br></div><div>I re-=
wrote the patch to ensure the empty brackets are on the next line (similar =
to the surrounding lines), with a space in between (coding style), and ends=
 with a comma (coding style).<br></div><div><br></div><div>Next time, pleas=
e provide the compiler version and compile flags you use to reproduce the i=
ssue.<br></div><div><br></div><div>Fix merged into master, stable 2.3, stab=
le 2.2,<br></div><div><br></div><div>Thanks for reporting this problem,<br>=
</div><div><br></div><div>Mathieu<br></div><div><br></div><div><br></div><h=
r id=3D"zwchr"><blockquote style=3D"border-left:2px solid #1010FF;margin-le=
ft:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;tex=
t-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><=
b>From: </b>"Marcus Tomlinson" &lt;themarcustomlinson@gmail.com&gt;<br><b>T=
o: </b>lttng-dev@lists.lttng.org<br><b>Sent: </b>Wednesday, October 30, 201=
3 3:08:00 AM<br><b>Subject: </b>[lttng-dev] Fwd: VERY EASY one-liner fix to=
 LTTng<br><div><br></div><div>Hi again, so to make things a little easier t=
han easy, here is a patch that=E2=80=99ll do the trick.</div><div>If anyone=
 manages to find some time to get this committed, please could you let me k=
now.</div><div>Thanks again!</div><div><br></div><br><div><br></div><div><b=
r><div>Begin forwarded message:</div><br class=3D"Apple-interchange-newline=
"><blockquote><div style=3D"margin-top: 0px; margin-right: 0px; margin-bott=
om: 0px; margin-left: 0px;"><span style=3D"font-family:'Helvetica'; color:;=
"><b>From: </b></span><span style=3D"font-family:'Helvetica';">Marcus Tomli=
nson &lt;<a href=3D"mailto:themarcustomlinson@gmail.com" target=3D"_blank">=
themarcustomlinson@gmail.com</a>&gt;<br></span></div><div style=3D"margin-t=
op: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px;"><span st=
yle=3D"font-family:'Helvetica'; color:;"><b>Subject: </b></span><span style=
=3D"font-family:'Helvetica';"><b>VERY EASY one-liner fix to LTTng</b><br></=
span></div><div style=3D"margin-top: 0px; margin-right: 0px; margin-bottom:=
 0px; margin-left: 0px;"><span style=3D"font-family:'Helvetica'; color:;"><=
b>Date: </b></span><span style=3D"font-family:'Helvetica';">29 October 2013=
 at 3:45:53 PM SAST<br></span></div><div style=3D"margin-top: 0px; margin-r=
ight: 0px; margin-bottom: 0px; margin-left: 0px;"><span style=3D"font-famil=
y:'Helvetica'; color:;"><b>To: </b></span><span style=3D"font-family:'Helve=
tica';"><a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttn=
g-dev@lists.lttng.org</a><br></span></div><br><div><div style=3D"word-wrap:=
 break-word; -webkit-nbsp-mode: space; -webkit-line-break: after-white-spac=
e;">Hi, could I ask that somebody please make a VERY EASY fix to LTTng and =
push it for me.<div><br></div><div>I get compiler warnings about a missing =
initialiser for member =E2=80=98padding=E2=80=99 in tracepoint.</div><div>R=
emoving these warnings is really simple:</div><div><br></div><div>line 252 =
of =E2=80=9Ctracepoint.h=E2=80=9D needs to change from:</div><div>
<pre style=3D"margin-top: 0px; margin-bottom: 0px;"><span style=3D" color:#=
c0c0c0;">=09=09=09</span>_TP_EXTRACT_STRING(_args),<span style=3D" color:#c=
0c0c0;">=09=09=09=09</span><span style=3D" color:#c0c0c0;">\</span></pre></=
div><div>to:</div><div>
<pre style=3D"margin-top: 0px; margin-bottom: 0px;"><span style=3D" color:#=
c0c0c0;">=09=09=09</span>_TP_EXTRACT_STRING(_args), {}<span style=3D" color=
:#c0c0c0;">=09=09=09=09</span><span style=3D" color:#c0c0c0;">\</span></pre=
><pre style=3D"margin-top: 0px; margin-bottom: 0px;"><span style=3D" color:=
#c0c0c0;"><br></span></pre><pre style=3D"margin-top: 0px; margin-bottom: 0p=
x;"><div style=3D"font-family: Helvetica; white-space: normal;">Thanks in a=
dvance!</div></pre></div></div></div></blockquote></div><br><div><br></div>=
_______________________________________________<br>lttng-dev mailing list<b=
r>lttng-dev@lists.lttng.org<br>http://lists.lttng.org/cgi-bin/mailman/listi=
nfo/lttng-dev<br></blockquote><div><br><div><br></div></div><div><br></div>=
<div>-- <br></div><div><span name=3D"x"></span>Mathieu Desnoyers<br>EfficiO=
S Inc.<br>http://www.efficios.com<span name=3D"x"></span><br></div></div></=
body></html>
------=_Part_54223_1317477874.1383222232514--


--===============0084765158==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0084765158==--
