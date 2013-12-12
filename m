From: Anand Neeli <anand.neeli@gmail.com>
Subject: Re: auto generation of .c and .h files for a userspace
	app
Date: Thu, 12 Dec 2013 11:28:35 +0530
Message-ID: <CAM5kDqx-+8aZ43XyqRDs=bwEGB4WOXtD0i-0CQghVPTgWe_mGA__1425.56804135001$1386828011$gmane$org@mail.gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD267B3658@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1542447590=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <anand.neeli@gmail.com>) id 1VqzIH-0007iw-7Q
	for lttng-dev@lists.lttng.org; Thu, 12 Dec 2013 00:58:46 -0500
Received: by mail-pb0-f53.google.com with SMTP id ma3so11356984pbc.26
	for <lttng-dev@lists.lttng.org>; Wed, 11 Dec 2013 21:58:35 -0800 (PST)
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD267B3658@VAL-E-02.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1542447590==
Content-Type: multipart/alternative; boundary=bcaec5215aaf407b0b04ed500924

--bcaec5215aaf407b0b04ed500924
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Daniel,
yes, this is what i was looking for.
Missed to check lttng_gen_tp. Thanks for the info.

Anand Neeli



On Wed, Dec 11, 2013 at 7:53 PM, Thibault, Daniel <
Daniel.Thibault@drdc-rddc.gc.ca> wrote:

> > Date: Wed, 11 Dec 2013 11:02:57 +0530
> >
> > Is there a script/program which can be used to auto-generate the
> required .c and .h files required for lttng-ust.
> > The script/program should parse all the .c files in a directory and
> generate corresponding .c and .h files. And this should be run before the
> build of app.
> >
> > This would make app developers life easy and will be very useful for on
> the fly changes.
> >
> > Will be great if someone can all add more details related to this topic
> or give me pointers if this is already discussed.
>
>    Do you mean lttng_gen_tp?
>
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

--bcaec5215aaf407b0b04ed500924
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span style=3D"font-family:arial,sans-serif;font-size:13px=
">Daniel,</span><div><span style=3D"font-family:arial,sans-serif;font-size:=
13px">yes, this is what i was looking for.</span></div><div><font face=3D"a=
rial, sans-serif">Missed to check=A0</font><span style=3D"font-family:arial=
,sans-serif;font-size:13px">lttng_gen_tp. Thanks for the info.</span></div>
<div><span style=3D"font-family:arial,sans-serif;font-size:13px"><br></span=
></div><div><span style=3D"font-family:arial,sans-serif;font-size:13px">Ana=
nd Neeli</span></div><div><span style=3D"font-family:arial,sans-serif;font-=
size:13px"><br>
</span></div></div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_q=
uote">On Wed, Dec 11, 2013 at 7:53 PM, Thibault, Daniel <span dir=3D"ltr">&=
lt;<a href=3D"mailto:Daniel.Thibault@drdc-rddc.gc.ca" target=3D"_blank">Dan=
iel.Thibault@drdc-rddc.gc.ca</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">&gt; Date: Wed, 11 Dec 2013 11:02:57 +0530<b=
r>
<div class=3D"im">&gt;<br>
&gt; Is there a script/program which can be used to auto-generate the requi=
red .c and .h files required for lttng-ust.<br>
&gt; The script/program should parse all the .c files in a directory and ge=
nerate corresponding .c and .h files. And this should be run before the bui=
ld of app.<br>
&gt;<br>
&gt; This would make app developers life easy and will be very useful for o=
n the fly changes.<br>
&gt;<br>
&gt; Will be great if someone can all add more details related to this topi=
c or give me pointers if this is already discussed.<br>
<br>
</div>=A0 =A0Do you mean lttng_gen_tp?<br>
<br>
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
Vox : (418) 844-4000 x4245<br>
Fax : (418) 844-4538<br>
NAC : 918V QSDJ &lt;<a href=3D"http://www.travelgis.com/map.asp?addr=3D918V=
%20QSDJ" target=3D"_blank">http://www.travelgis.com/map.asp?addr=3D918V%20Q=
SDJ</a>&gt;<br>
Gouvernement du Canada | Government of Canada<br>
&lt;<a href=3D"http://www.valcartier.drdc-rddc.gc.ca/" target=3D"_blank">ht=
tp://www.valcartier.drdc-rddc.gc.ca/</a>&gt;<br>
</blockquote></div><br></div>

--bcaec5215aaf407b0b04ed500924--


--===============1542447590==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1542447590==--
