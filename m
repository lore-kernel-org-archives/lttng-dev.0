From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Fix linking failure when
 cross-compiling
Date: Sat, 26 Apr 2014 21:51:09 +0000 (UTC)
Message-ID: <1871833747.7966.1398549069563.JavaMail.zimbra__7047.48612265593$1398549651$gmane$org@efficios.com>
References: <1398442344-15165-1-git-send-email-adrienverge@gmail.com>
 <1751778549.7675.1398501609681.JavaMail.zimbra@efficios.com>
 <CANsc=4Xh67Jnuy1b9eqirHNVGERa+ugVEdzkU0Yy652a+Nw5PA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0186641412=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1WeAdk-0008R9-It
 for lttng-dev@lists.lttng.org; Sat, 26 Apr 2014 18:00:09 -0400
In-Reply-To: <CANsc=4Xh67Jnuy1b9eqirHNVGERa+ugVEdzkU0Yy652a+Nw5PA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Adrien =?utf-8?Q?Verg=C3=A9?= <adrienverge@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0186641412==
Content-Type: multipart/alternative;
	boundary="----=_Part_7965_2017905253.1398549069562"

------=_Part_7965_2017905253.1398549069562
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

----- Original Message -----

> From: "Adrien Verg=C3=A9" <adrienverge@gmail.com>
> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: lttng-dev@lists.lttng.org
> Sent: Saturday, April 26, 2014 6:23:09 PM
> Subject: Re: [lttng-dev] [PATCH lttng-ust] Fix linking failure when
> cross-compiling

> 2014-04-26 4:40 GMT-04:00 Mathieu Desnoyers < mathieu.desnoyers@efficios.=
com
> > :

> > It should change much things overall, but is there any reason for
>=20
> > this change ?
>=20

> Actually my first plan was to remove all trailing slashes, then I changed=
 my
> mind to change as little code as possible. But oops... forgot one slash :=
)

> Please tell me if I should resend a v2 patch with (or without) trailing
> slashes.

I asked, because the change was not described in the=20
changelog.=20

Since it appears that removing the final slash generates=20
a prettier path within the build (no double-slash), I'll=20
keep it as is.=20

Thanks!=20

Mathieu=20

> Thanks,

> Adrien

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

------=_Part_7965_2017905253.1398549069562
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><hr id=3D"zwchr"><blockquote style=3D=
"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;=
font-weight:normal;font-style:normal;text-decoration:none;font-family:Helve=
tica,Arial,sans-serif;font-size:12pt;"><b>From: </b>"Adrien Verg=C3=A9" &lt=
;adrienverge@gmail.com&gt;<br><b>To: </b>"Mathieu Desnoyers" &lt;mathieu.de=
snoyers@efficios.com&gt;<br><b>Cc: </b>lttng-dev@lists.lttng.org<br><b>Sent=
: </b>Saturday, April 26, 2014 6:23:09 PM<br><b>Subject: </b>Re: [lttng-dev=
] [PATCH lttng-ust] Fix linking failure when cross-compiling<br><div><br></=
div><div dir=3D"ltr">2014-04-26 4:40 GMT-04:00 Mathieu Desnoyers <span dir=
=3D"ltr">&lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_b=
lank">mathieu.desnoyers@efficios.com</a>&gt;</span>:<br><div class=3D"gmail=
_extra"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(20=
4,204,204);border-left-style:solid;padding-left:1ex">
It should change much things overall, but is there any reason for<br>
this change ?<br></blockquote><div><br></div>Actually my first plan was to =
remove all trailing slashes, then I changed my mind to change as little cod=
e as possible. But oops... forgot one slash :)<div><br></div><div>Please te=
ll me if I should resend a v2 patch with (or without) trailing slashes.</di=
v></div></div></div></blockquote><div>I asked, because the change was not d=
escribed in the<br></div><div>changelog.<br></div><div><br></div><div>Since=
 it appears that removing the final slash generates<br></div><div>a prettie=
r path within the build (no double-slash), I'll<br></div><div>keep it as is=
.<br></div><div><br></div><div>Thanks!<br></div><div><br></div><div>Mathieu=
<br></div><div><br></div><blockquote style=3D"border-left:2px solid #1010FF=
;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:=
normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-siz=
e:12pt;"><div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_qu=
ote"><div><br></div><div>Thanks,</div><div><br></div><div>Adrien</div></div=
></div></div></blockquote><div><br><br></div><div><br></div><div>-- <br></d=
iv><div><span name=3D"x"></span>Mathieu Desnoyers<br>EfficiOS Inc.<br>http:=
//www.efficios.com<span name=3D"x"></span><br></div></div></body></html>
------=_Part_7965_2017905253.1398549069562--


--===============0186641412==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0186641412==--
