From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: Quick question about discarded events
Date: Tue, 5 Nov 2013 20:44:13 -0500
Message-ID: <CA+jJMxubqyOfqwJpsxOh9rX=BZkvck_bBRR9xGQjT3BLNP7eKw__27462.7601299018$1383702313$gmane$org@mail.gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD267A0FA7@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0663373759=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qe0-f51.google.com ([209.85.128.51])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1VdsAM-0000xo-QE
	for lttng-dev@lists.lttng.org; Tue, 05 Nov 2013 20:44:24 -0500
Received: by mail-qe0-f51.google.com with SMTP id q19so5686512qeb.10
	for <lttng-dev@lists.lttng.org>; Tue, 05 Nov 2013 17:44:13 -0800 (PST)
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD267A0FA7@VAL-E-01.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: "david.lindstrom@percepio.se" <david.lindstrom@percepio.se>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0663373759==
Content-Type: multipart/alternative; boundary=089e0149cd3a484eb804ea7849d9

--089e0149cd3a484eb804ea7849d9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2013 at 8:38 AM, Thibault, Daniel <
Daniel.Thibault@drdc-rddc.gc.ca> wrote:

> ------------------------------
> Date: Mon, 4 Nov 2013 14:32:02 +0100
> From: "=3D?iso-8859-1?Q?David_Lindstr=3DF6m?=3D"
>         <david.lindstrom@percepio.se>
>
> > If I encounter a trace where a packet contains the events_discarded fie=
ld
> > with a non-zero value, I want to warn/notify the user. Were the events
> > discarded before the timestamp_begin of the packet, after timestamp_end
> or
> > in between? I basically want to plot some symbol on my timeline
> > approximately where the user can expect bad/missing data.
> >
> > Mvh
> > David Lindstr?m
>
>    I do believe the events were lost in between the begin and end packet
> timestamps.
>
>
That's my interpretation too... which gives me an opportunity to bump bug
#589 [1].
It seems Babeltrace and TMF's interpretation of the specification differ on
this point. Mathieu can probably settle the debate ;)

Cheers,
J=E9r=E9mie

[1] https://bugs.lttng.org/issues/589



> Daniel U. Thibault
> Protection des syst=E8mes et contremesures (PSC) | Systems Protection &
> Countermeasures (SPC)
> Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critica=
l
> Cyber Security (MCCS)
> R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R=
&D
> Canada - Valcartier (DRDC Valcartier)
> 2459 route de la Bravoure
> Qu=E9bec QC  G3J 1X5
> CANADA
> Vox : (418) 844-4000 x4245
> Fax : (418) 844-4538
> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada | Government of Canada
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

--089e0149cd3a484eb804ea7849d9
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>On Tue, Nov 5, 2013 at 8:38 AM, Thibault, Daniel <spa=
n dir=3D"ltr">&lt;<a href=3D"mailto:Daniel.Thibault@drdc-rddc.gc.ca" target=
=3D"_blank">Daniel.Thibault@drdc-rddc.gc.ca</a>&gt;</span> wrote:<br></div>=
<div class=3D"gmail_extra">
<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204=
);border-left-style:solid;padding-left:1ex">------------------------------<=
br>

Date: Mon, 4 Nov 2013 14:32:02 +0100<br>
From: &quot;=3D?iso-8859-1?Q?David_Lindstr=3DF6m?=3D&quot;<br>
=A0 =A0 =A0 =A0 &lt;<a href=3D"mailto:david.lindstrom@percepio.se">david.li=
ndstrom@percepio.se</a>&gt;<br>
<div class=3D"im"><br>
&gt; If I encounter a trace where a packet contains the events_discarded fi=
eld<br>
&gt; with a non-zero value, I want to warn/notify the user. Were the events=
<br>
&gt; discarded before the timestamp_begin of the packet, after timestamp_en=
d or<br>
&gt; in between? I basically want to plot some symbol on my timeline<br>
&gt; approximately where the user can expect bad/missing data.<br>
&gt;<br>
&gt; Mvh<br>
</div>&gt; David Lindstr?m<br>
<br>
=A0 =A0I do believe the events were lost in between the begin and end packe=
t timestamps.<br>
<br></blockquote><div><br></div><div>That&#39;s my interpretation too... wh=
ich gives me an opportunity to bump bug #589 [1].</div><div><div>It seems B=
abeltrace and TMF&#39;s interpretation of the specification differ on this =
point. Mathieu can probably settle the debate ;)</div>
<div><br></div><div>Cheers,</div><div>J=E9r=E9mie</div><div><br></div><div>=
[1]=A0<a href=3D"https://bugs.lttng.org/issues/589">https://bugs.lttng.org/=
issues/589</a><br></div></div><div><br></div><div>=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;b=
order-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex"=
>

Daniel U. Thibault<br>
Protection des syst=E8mes et contremesures (PSC) | Systems Protection &amp;=
 Countermeasures (SPC)<br>
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)<br>
R &amp; D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence=
 R&amp;D Canada - Valcartier (DRDC Valcartier)<br>
2459 route de la Bravoure<br>
Qu=E9bec QC =A0G3J 1X5<br>
CANADA<br>
Vox : <a href=3D"tel:%28418%29%20844-4000%20x4245" value=3D"+14188444000">(=
418) 844-4000 x4245</a><br>
Fax : <a href=3D"tel:%28418%29%20844-4538" value=3D"+14188444538">(418) 844=
-4538</a><br>
NAC : 918V QSDJ &lt;<a href=3D"http://www.travelgis.com/map.asp?addr=3D918V=
%20QSDJ" target=3D"_blank">http://www.travelgis.com/map.asp?addr=3D918V%20Q=
SDJ</a>&gt;<br>
Gouvernement du Canada | Government of Canada<br>
&lt;<a href=3D"http://www.valcartier.drdc-rddc.gc.ca/" target=3D"_blank">ht=
tp://www.valcartier.drdc-rddc.gc.ca/</a>&gt;<br>
<div class=3D""><div class=3D"h5"><br>
_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
J=E9r=E9mie Galarneau<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.co=
m" target=3D"_blank">http://www.efficios.com</a>
</div></div>

--089e0149cd3a484eb804ea7849d9--


--===============0663373759==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0663373759==--
