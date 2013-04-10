From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: Google Summer of Code
Date: Wed, 10 Apr 2013 17:53:13 -0400
Message-ID: <CA+jJMxtP+n274AhsXQ23TXYPo8UsXtShjYxwJwwO69e=N1nbnQ__3043.05875110931$1365630831$gmane$org@mail.gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD12D0DC32@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0685263220=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1UQ2xD-00005V-5N
	for lttng-dev@lists.lttng.org; Wed, 10 Apr 2013 17:53:19 -0400
Received: by mail-wg0-f48.google.com with SMTP id m15so1019985wgh.27
	for <lttng-dev@lists.lttng.org>; Wed, 10 Apr 2013 14:53:13 -0700 (PDT)
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD12D0DC32@VAL-E-02.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "Couture,
	Mario" <Mario.Couture@drdc-rddc.gc.ca>, "Painchaud,
	Frederic" <Frederic.Painchaud@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

--===============0685263220==
Content-Type: multipart/alternative; boundary=f46d044286ca53506404da08b222

--f46d044286ca53506404da08b222
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Certainly seems worthwhile to me although I never heard about debugfs being
phased out. Could you clarify that point?

J=E9r=E9mie

On Tue, Apr 9, 2013 at 11:21 AM, Thibault, Daniel <
Daniel.Thibault@drdc-rddc.gc.ca> wrote:

>    The Google Summer of Code LTTng entry (
> http://bugs.lttng.org/projects/lttng/wiki/Google_Summer_of_Code_2013) is
> a promising initiative.  May I propose another little project idea?
>
> Babeltrace support for the debugfs (/sys/kernel/debug/tracing) trace form=
at
>
> Brief explanation:
> Provide a Babeltrace plug-in to allow Babeltrace to read from traces
> created by the debugfs service (/sys/kernel/debug/tracing/trace).
>
> Expected results: A Babeltrace plug-in, tests, examples and documentation=
.
>
> Skill level: Easy - Medium
>
> Prerequisite Knowledge: C, OO development
>
> Mentors: ?
>
>    Even if the debugfs tracing facility is destined for eventual
> withdrawal from the Linux kernel, it may be of interest to some to recove=
r
> older traces generated in this way -if only in order to be able to proces=
s
> them in the same way as CTF text dumps.  Conversion to the babeltrace tex=
t
> format should be fairly straightforward; conversion to CTF would be
> trickier.
>
>    Is this idea worthwhile or worthless?
>
> Daniel U. Thibault
> R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) / Defence R=
&D
> Canada - Valcartier (DRDC Valcartier)
> Cyber s=E9curit=E9 pour les missions essentielles (CME) / Mission Critica=
l
> Cyber Security (MCCS)
> Protection des syst=E8mes et contremesures (PSC) / Systems Protection &
> Countermeasures (SPC)
> 2459 route de la Bravoure
> Qu=E9bec, QC  G3J 1X5
> CANADA
> Vox : (418) 844-4000 x4245
> Fax : (418) 844-4538
> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada / Government of Canada
> <http://www.valcartier.drdc-rddc.gc.ca/>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>



--=20
J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--f46d044286ca53506404da08b222
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Certainly seems worthwhile to me although I never heard ab=
out debugfs being phased out. Could you clarify that point?<div><br></div><=
div><div>J=E9r=E9mie<br></div><div><div class=3D"gmail_extra"><br><div clas=
s=3D"gmail_quote">
On Tue, Apr 9, 2013 at 11:21 AM, Thibault, Daniel <span dir=3D"ltr">&lt;<a =
href=3D"mailto:Daniel.Thibault@drdc-rddc.gc.ca" target=3D"_blank">Daniel.Th=
ibault@drdc-rddc.gc.ca</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex">
=A0 =A0The Google Summer of Code LTTng entry (<a href=3D"http://bugs.lttng.=
org/projects/lttng/wiki/Google_Summer_of_Code_2013" target=3D"_blank">http:=
//bugs.lttng.org/projects/lttng/wiki/Google_Summer_of_Code_2013</a>) is a p=
romising initiative. =A0May I propose another little project idea?<br>

<br>
Babeltrace support for the debugfs (/sys/kernel/debug/tracing) trace format=
<br>
<br>
Brief explanation:<br>
Provide a Babeltrace plug-in to allow Babeltrace to read from traces create=
d by the debugfs service (/sys/kernel/debug/tracing/trace).<br>
<br>
Expected results: A Babeltrace plug-in, tests, examples and documentation.<=
br>
<br>
Skill level: Easy - Medium<br>
<br>
Prerequisite Knowledge: C, OO development<br>
<br>
Mentors: ?<br>
<br>
=A0 =A0Even if the debugfs tracing facility is destined for eventual withdr=
awal from the Linux kernel, it may be of interest to some to recover older =
traces generated in this way -if only in order to be able to process them i=
n the same way as CTF text dumps. =A0Conversion to the babeltrace text form=
at should be fairly straightforward; conversion to CTF would be trickier.<b=
r>

<br>
=A0 =A0Is this idea worthwhile or worthless?<br>
<br>
Daniel U. Thibault<br>
R &amp; D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) / Defence=
 R&amp;D Canada - Valcartier (DRDC Valcartier)<br>
Cyber s=E9curit=E9 pour les missions essentielles (CME) / Mission Critical =
Cyber Security (MCCS)<br>
Protection des syst=E8mes et contremesures (PSC) / Systems Protection &amp;=
 Countermeasures (SPC)<br>
2459 route de la Bravoure<br>
Qu=E9bec, QC=A0 G3J 1X5<br>
CANADA<br>
Vox=A0: <a href=3D"tel:%28418%29%20844-4000%20x4245" value=3D"+14188444000"=
>(418) 844-4000 x4245</a><br>
Fax=A0: <a href=3D"tel:%28418%29%20844-4538" value=3D"+14188444538">(418) 8=
44-4538</a><br>
NAC=A0: 918V QSDJ &lt;<a href=3D"http://www.travelgis.com/map.asp?addr=3D91=
8V%20QSDJ" target=3D"_blank">http://www.travelgis.com/map.asp?addr=3D918V%2=
0QSDJ</a>&gt;<br>
Gouvernement du Canada=A0/ Government of Canada<br>
&lt;<a href=3D"http://www.valcartier.drdc-rddc.gc.ca/" target=3D"_blank">ht=
tp://www.valcartier.drdc-rddc.gc.ca/</a>&gt;<br>
<br>
_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>J=E9r=E9mie =
Galarneau<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com" target=3D=
"_blank">http://www.efficios.com</a>
</div></div></div></div>

--f46d044286ca53506404da08b222--


--===============0685263220==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0685263220==--
