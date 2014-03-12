From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: undefined reference to `lttng_probe_register
Date: Wed, 12 Mar 2014 19:01:31 +0000 (UTC)
Message-ID: <1213630805.1753.1394650891647.JavaMail.zimbra__44778.5343662419$1394650969$gmane$org@efficios.com>
References: <77C8847D080A484EA4C78F8323DAB1FB24805A00@KLMAIL01.kl.imgtec.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1722977391=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1WNoPD-0002T5-Cj
	for lttng-dev@lists.lttng.org; Wed, 12 Mar 2014 15:01:37 -0400
In-Reply-To: <77C8847D080A484EA4C78F8323DAB1FB24805A00@KLMAIL01.kl.imgtec.org>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Ritchie Vickery <Ritchie.Vickery@imgtec.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1722977391==
Content-Type: multipart/alternative;
	boundary="----=_Part_1752_194798519.1394650891645"

------=_Part_1752_194798519.1394650891645
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

----- Original Message -----

> From: "Ritchie Vickery" <Ritchie.Vickery@imgtec.com>
> To: lttng-dev@lists.lttng.org
> Sent: Wednesday, March 12, 2014 7:09:08 AM
> Subject: [lttng-dev] undefined reference to `lttng_probe_register

> Hi,

> I=E2=80=99m trying to setup lttng for the first time.

> I=E2=80=99ve made librcu, lttng-ust, lttng-tools and lttng-modules and ha=
ve
> instrumented some User code.

> I have run the tool to generate the tracepoint code:

> $ lttng-gen-tp ustrcv.tp =E2=80=93o ustrcv.h =E2=80=93o ustrcv.c

> However, at the point where the user-mode library containing ustrcv.o get=
s
> linked, I see the following error:

> /usr/local/include/lttng/ust-tracepoint-event.h:779: undefined reference =
to
> `lttng_probe_register'

> Does anyone have any ideas what I may have missed?

You probably forgot to link the tracepoint probe against liblttng-ust. See =
lttng-ust(3) manpage for details.=20

Thanks,=20

Mathieu=20

> Many thanks,

> Ritchie

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

------=_Part_1752_194798519.1394650891645
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><hr id=3D"zwchr"><blockquote style=3D=
"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;=
font-weight:normal;font-style:normal;text-decoration:none;font-family:Helve=
tica,Arial,sans-serif;font-size:12pt;"><b>From: </b>"Ritchie Vickery" &lt;R=
itchie.Vickery@imgtec.com&gt;<br><b>To: </b>lttng-dev@lists.lttng.org<br><b=
>Sent: </b>Wednesday, March 12, 2014 7:09:08 AM<br><b>Subject: </b>[lttng-d=
ev] undefined reference to `lttng_probe_register<br><div><br></div><style><=
!--

@font-face
=09{font-family:Calibri;
=09panose-1:2 15 5 2 2 2 4 3 2 4;}

p.MsoNormal, li.MsoNormal, div.MsoNormal
=09{margin:0cm;
=09margin-bottom:.0001pt;
=09font-size:11.0pt;
=09font-family:"Calibri","sans-serif";
=09mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
=09{mso-style-priority:99;
=09color:blue;
=09text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
=09{mso-style-priority:99;
=09color:purple;
=09text-decoration:underline;}
span.EmailStyle17
=09{mso-style-type:personal-compose;
=09font-family:"Calibri","sans-serif";
=09color:windowtext;}
.MsoChpDefault
=09{mso-style-type:export-only;
=09font-family:"Calibri","sans-serif";
=09mso-fareast-language:EN-US;}
@page WordSection1
=09{size:612.0pt 792.0pt;
=09margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
=09{page:WordSection1;}
--></style><div class=3D"WordSection1"><p class=3D"MsoNormal">Hi,</p><p cla=
ss=3D"MsoNormal">I=E2=80=99m trying to setup lttng for the first time.</p><=
p class=3D"MsoNormal">I=E2=80=99ve made librcu, lttng-ust, lttng-tools and =
lttng-modules and have instrumented some User code.</p><p class=3D"MsoNorma=
l">I have run the tool to generate the tracepoint code:</p><p class=3D"MsoN=
ormal">$ lttng-gen-tp ustrcv.tp =E2=80=93o ustrcv.h =E2=80=93o ustrcv.c</p>=
<p class=3D"MsoNormal">However, at the point where the user-mode library co=
ntaining ustrcv.o gets linked, I see the following error:</p><p class=3D"Ms=
oNormal">/usr/local/include/lttng/ust-tracepoint-event.h:779: undefined ref=
erence to `lttng_probe_register'</p><p class=3D"MsoNormal">Does anyone have=
 any ideas what I may have missed?</p></div></blockquote><div><br></div><di=
v>You probably forgot to link the tracepoint probe against liblttng-ust. Se=
e lttng-ust(3) manpage for details.<br></div><div><br></div><div>Thanks,<br=
></div><div><br></div><div>Mathieu<br></div><div><br></div><blockquote styl=
e=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#=
000;font-weight:normal;font-style:normal;text-decoration:none;font-family:H=
elvetica,Arial,sans-serif;font-size:12pt;"><div class=3D"WordSection1"><p c=
lass=3D"MsoNormal">Many thanks,</p><p class=3D"MsoNormal">Ritchie</p></div>=
<br>_______________________________________________<br>lttng-dev mailing li=
st<br>lttng-dev@lists.lttng.org<br>http://lists.lttng.org/cgi-bin/mailman/l=
istinfo/lttng-dev<br></blockquote><div><br><br></div><div><br></div><div>--=
 <br></div><div><span name=3D"x"></span>Mathieu Desnoyers<br>EfficiOS Inc.<=
br>http://www.efficios.com<span name=3D"x"></span><br></div></div></body></=
html>
------=_Part_1752_194798519.1394650891645--


--===============1722977391==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1722977391==--
