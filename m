From: Anand Neeli <anand.neeli@gmail.com>
Subject: Re: multiple tracing sessions using relayd
Date: Thu, 13 Nov 2014 19:27:11 +0530
Message-ID: <CAM5kDqzmvVtwzLRX6CadpZkQtGfbO2XjiBzerWteR154x+udAA__9407.49644437364$1415887085$gmane$org@mail.gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD6FBC587C@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1232704762=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <anand.neeli@gmail.com>) id 1Xouth-0005Xy-Kr
 for lttng-dev@lists.lttng.org; Thu, 13 Nov 2014 08:57:19 -0500
Received: by mail-wg0-f46.google.com with SMTP id x13so17066829wgg.33
 for <lttng-dev@lists.lttng.org>; Thu, 13 Nov 2014 05:57:12 -0800 (PST)
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD6FBC587C@VAL-E-02.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1232704762==
Content-Type: multipart/alternative; boundary=047d7b86cb689436d80507bde3b9

--047d7b86cb689436d80507bde3b9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Thanks for the info Daniel,

J=C3=A9r=C3=A9mie,
Have you tried multi-session with relayd on 2.4.1?
Also can you please give me the config you used for this?

For some reason my console is stuck when i try to enable channel for second
session.

Can same user run multiple session daemons? how does a channel
get associated with a particular sessiond (if a user can run multiple
sessiond)

Thanks,
Anand Neeli

On Wed, Nov 12, 2014 at 8:13 PM, Thibault, Daniel <
Daniel.Thibault@drdc-rddc.gc.ca> wrote:

> > Date: Mon, 10 Nov 2014 13:02:58 -0500
> > From: J?r?mie Galarneau <jeremie.galarneau@efficios.com>
> > To: Anand Neeli <anand.neeli@gmail.com>
> >
> > > I tried to create same without relayd and it works. Am i missing
> > > anything here?
> > >
> > > Although in the above example i'm enabling same/all events in session=
1
> > > and session2, but i think this should work and capture same events in
> > > both the sessions.
> >
> > That's the expected behaviour.
> >
> > J=C3=A9r=C3=A9mie
>
>    With one very important caveat: the copies of the events in each
> session will most likely bear different timestamps.  That's because the
> timestamps capture the moments at which the event data slots are reserved
> in the consumer buffers.
>
> Daniel U. Thibault
> Protection des syst=C3=A8mes et contremesures (PSC) | Systems Protection =
&
> Countermeasures (SPC)
> Cyber s=C3=A9curit=C3=A9 pour les missions essentielles (CME) | Mission C=
ritical
> Cyber Security (MCCS)
> RDDC - Centre de recherches de Valcartier | DRDC - Valcartier Research
> Centre
> 2459 route de la Bravoure
> Qu=C3=A9bec QC  G3J 1X5
> CANADA
> Vox : (418) 844-4000 x4245
> Fax : (418) 844-4538
> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada | Government of Canada
> <http://www.valcartier.drdc-rddc.gc.ca/>
>  LinkedIn: <http://ca.linkedin.com/in/daniel-u-thibault/>
>  Research Gate: <https://www.researchgate.net/profile/Daniel_Thibault/>
>

--047d7b86cb689436d80507bde3b9
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Thanks for the info Daniel,</div><div><br></div><span=
 style=3D"font-family:arial,sans-serif;font-size:13px">J=C3=A9r=C3=A9mie,</=
span><div><font face=3D"arial, sans-serif">Have you tried multi-session wit=
h relayd on 2.4.1?=C2=A0</font></div><div><font face=3D"arial, sans-serif">=
Also can you please give me the config you used for this?</font></div><div>=
<font face=3D"arial, sans-serif"><br></font></div><div><font face=3D"arial,=
 sans-serif">For some reason my console is stuck when i try to enable chann=
el for second session.</font></div><div><font face=3D"arial, sans-serif"><b=
r></font></div><div><font face=3D"arial, sans-serif">Can same user run mult=
iple session daemons? how does a channel get=C2=A0associated=C2=A0with a pa=
rticular sessiond (if a user can run multiple sessiond)</font></div><div><f=
ont face=3D"arial, sans-serif"><br></font></div><div><font face=3D"arial, s=
ans-serif">Thanks,</font></div><div><font face=3D"arial, sans-serif">Anand =
Neeli</font></div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_=
quote">On Wed, Nov 12, 2014 at 8:13 PM, Thibault, Daniel <span dir=3D"ltr">=
&lt;<a href=3D"mailto:Daniel.Thibault@drdc-rddc.gc.ca" target=3D"_blank">Da=
niel.Thibault@drdc-rddc.gc.ca</a>&gt;</span> wrote:<br><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex">&gt; Date: Mon, 10 Nov 2014 13:02:58 -0500<br>
&gt; From: J?r?mie Galarneau &lt;<a href=3D"mailto:jeremie.galarneau@effici=
os.com">jeremie.galarneau@efficios.com</a>&gt;<br>
&gt; To: Anand Neeli &lt;<a href=3D"mailto:anand.neeli@gmail.com">anand.nee=
li@gmail.com</a>&gt;<br>
<span class=3D"">&gt;<br>
&gt; &gt; I tried to create same without relayd and it works. Am i missing<=
br>
&gt; &gt; anything here?<br>
&gt; &gt;<br>
&gt; &gt; Although in the above example i&#39;m enabling same/all events in=
 session1<br>
&gt; &gt; and session2, but i think this should work and capture same event=
s in<br>
&gt; &gt; both the sessions.<br>
&gt;<br>
</span>&gt; That&#39;s the expected behaviour.<br>
&gt;<br>
&gt; J=C3=A9r=C3=A9mie<br>
<br>
=C2=A0 =C2=A0With one very important caveat: the copies of the events in ea=
ch session will most likely bear different timestamps.=C2=A0 That&#39;s bec=
ause the timestamps capture the moments at which the event data slots are r=
eserved in the consumer buffers.<br>
<br>
Daniel U. Thibault<br>
Protection des syst=C3=A8mes et contremesures (PSC) | Systems Protection &a=
mp; Countermeasures (SPC)<br>
Cyber s=C3=A9curit=C3=A9 pour les missions essentielles (CME) | Mission Cri=
tical Cyber Security (MCCS)<br>
RDDC - Centre de recherches de Valcartier | DRDC - Valcartier Research Cent=
re<br>
2459 route de la Bravoure<br>
Qu=C3=A9bec QC=C2=A0 G3J 1X5<br>
CANADA<br>
Vox : (418) 844-4000 x4245<br>
Fax : (418) 844-4538<br>
NAC : 918V QSDJ &lt;<a href=3D"http://www.travelgis.com/map.asp?addr=3D918V=
%20QSDJ" target=3D"_blank">http://www.travelgis.com/map.asp?addr=3D918V%20Q=
SDJ</a>&gt;<br>
Gouvernement du Canada | Government of Canada<br>
&lt;<a href=3D"http://www.valcartier.drdc-rddc.gc.ca/" target=3D"_blank">ht=
tp://www.valcartier.drdc-rddc.gc.ca/</a>&gt;<br>
=C2=A0LinkedIn: &lt;<a href=3D"http://ca.linkedin.com/in/daniel-u-thibault/=
" target=3D"_blank">http://ca.linkedin.com/in/daniel-u-thibault/</a>&gt;<br=
>
=C2=A0Research Gate: &lt;<a href=3D"https://www.researchgate.net/profile/Da=
niel_Thibault/" target=3D"_blank">https://www.researchgate.net/profile/Dani=
el_Thibault/</a>&gt;<br>
</blockquote></div><br></div>

--047d7b86cb689436d80507bde3b9--


--===============1232704762==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1232704762==--
