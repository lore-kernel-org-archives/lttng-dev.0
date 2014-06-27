From: Dmitri Shubin <sbn@tbricks.com>
Subject: Re: How to check is tracepoint is currently enabled
	(UST)
Date: Fri, 27 Jun 2014 14:32:51 +0400
Message-ID: <CADmgc-s=PgWT6ayhyg3YyxA80G9FwfKRuf5O21WBL9EO_WK1RQ__27555.8068104603$1403865227$gmane$org@mail.gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD359C62DE@VAL-E-02.valcartier.drdc-rddc.gc.ca>
 <53AAE15C.3040100@ericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2012426086=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <sbn@tbricks.com>) id 1X0TSj-0006cF-M2
 for lttng-dev@lists.lttng.org; Fri, 27 Jun 2014 06:33:01 -0400
Received: by mail-ie0-f179.google.com with SMTP id tr6so4240348ieb.38
 for <lttng-dev@lists.lttng.org>; Fri, 27 Jun 2014 03:32:52 -0700 (PDT)
In-Reply-To: <53AAE15C.3040100@ericsson.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@ericsson.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============2012426086==
Content-Type: multipart/alternative; boundary=001a11c2f942e42e8c04fcced4f1

--001a11c2f942e42e8c04fcced4f1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Daniel and Jonathan,

Thanks for your replies!

Sorry I wasn't clear enough -- I want to check it in my application to
avoid 'heavy' calculation of probe arguments when the probe is actually
disabled.
Please see this blog entry for description of dtrace feature in question --
http://dtrace.org/blogs/ahl/2006/05/08/user-land-tracing-gets-better-and-be=
tter/


On Wed, Jun 25, 2014 at 6:49 PM, Jonathan Rajotte-Julien <
jonathan.rajotte-julien@ericsson.com> wrote:

> You can also list all ust events available for tracing via the command
> "lttng list -u".
>
> Make sure that the application you want to trace is running.
>
> On 06/25/2014 10:40 AM, Thibault, Daniel wrote:
> > ----------------------------------------------------------------------
> > Date: Sun, 22 Jun 2014 19:27:31 +0400
> > From: Dmitri Shubin <sbn@tbricks.com>
> >
> >> In dtrace it's possible to check if some probe is currently enabled or
> not (to avoid argument preparation for disabled probes).
> >> But I'm unable to find similar feature in lttng-ust (at least it's not
> mentioned in lttng-ust man page).
> >>
> >> Am I missed it or it's not implemented on purpose?
> >
> >    Use the list command.  A command such as 'lttng list <session_name>'
> will list the known events and their enabled/disabled status.  You can
> filter the command's output by specifying a domain (--userspace) and/or a
> channel (--channel <channel_name>).  For example:
> >
> > (begin example)
> > $ lttng create some_session
> > Session some_session created.
> > Traces will be written in /home/username/lttng-traces/
> some_session-20140625-102709
> > $ lttng enable-event -u some_event
> > UST event some_event created in channel channel0
> > $ lttng list some_session -u --channel channel0
> > Tracing session some_session: [inactive]
> >     Trace path: /home/username/lttng-traces/ some_session-20140625-1027=
09
> >
> > =3D=3D=3D Domain: UST global =3D=3D=3D
> >
> > Buffer type: per UID
> >
> > - channel0: [enabled]
> >
> >     Attributes:
> >       overwrite mode: 0
> >       subbuffers size: 131072
> >       number of subbufers: 4
> >       switch time interval: 0
> >       read time interval: 0
> >       output: mmap()
> >
> >     Events:
> >       some_event (type: tracepoint) [enabled]
> > (end example)
> >
> >    You can take a look at
> /usr/src/lttng-tools/src/bin/lttng/commands/list.c to see how the
> information is obtained.
> >
> > Daniel U. Thibault
> > Protection des syst=C3=A8mes et contremesures (PSC) | Systems Protectio=
n &
> Countermeasures (SPC)
> > Cyber s=C3=A9curit=C3=A9 pour les missions essentielles (CME) | Mission=
 Critical
> Cyber Security (MCCS)
> > RDDC - Centre de recherches de Valcartier | DRDC - Valcartier Research
> Centre
> > 2459 route de la Bravoure
> > Qu=C3=A9bec QC  G3J 1X5
> > CANADA
> > Vox : (418) 844-4000 x4245
> > Fax : (418) 844-4538
> > NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> > Gouvernement du Canada | Government of Canada
> > <http://www.valcartier.drdc-rddc.gc.ca/>
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>

--001a11c2f942e42e8c04fcced4f1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Daniel and Jonathan,<div><br></div><div>Thanks for your re=
plies!</div><div><br></div><div>Sorry I wasn&#39;t clear enough -- I want t=
o check it in my application to avoid &#39;heavy&#39; calculation of probe =
arguments when the probe is actually disabled.</div>

<div>Please see this blog entry for description of dtrace feature in questi=
on -- <a href=3D"http://dtrace.org/blogs/ahl/2006/05/08/user-land-tracing-g=
ets-better-and-better/" target=3D"_blank">http://dtrace.org/blogs/ahl/2006/=
05/08/user-land-tracing-gets-better-and-better/</a></div>

</div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Wed,=
 Jun 25, 2014 at 6:49 PM, Jonathan Rajotte-Julien <span dir=3D"ltr">&lt;<a =
href=3D"mailto:jonathan.rajotte-julien@ericsson.com" target=3D"_blank">jona=
than.rajotte-julien@ericsson.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">You can also list all ust events available f=
or tracing via the command &quot;lttng list -u&quot;.<br>
<br>
Make sure that the application you want to trace is running.<br>
<br>
On 06/25/2014 10:40 AM, Thibault, Daniel wrote:<br>
&gt; ----------------------------------------------------------------------=
<br>
&gt; Date: Sun, 22 Jun 2014 19:27:31 +0400<br>
&gt; From: Dmitri Shubin &lt;<a href=3D"mailto:sbn@tbricks.com">sbn@tbricks=
.com</a>&gt;<br>
&gt;<br>
&gt;&gt; In dtrace it&#39;s possible to check if some probe is currently en=
abled or not (to avoid argument preparation for disabled probes).<br>
&gt;&gt; But I&#39;m unable to find similar feature in lttng-ust (at least =
it&#39;s not mentioned in lttng-ust man page).<br>
&gt;&gt;<br>
&gt;&gt; Am I missed it or it&#39;s not implemented on purpose?<br>
&gt;<br>
&gt; =C2=A0 =C2=A0Use the list command. =C2=A0A command such as &#39;lttng =
list &lt;session_name&gt;&#39; will list the known events and their enabled=
/disabled status. =C2=A0You can filter the command&#39;s output by specifyi=
ng a domain (--userspace) and/or a channel (--channel &lt;channel_name&gt;)=
. =C2=A0For example:<br>

&gt;<br>
&gt; (begin example)<br>
&gt; $ lttng create some_session<br>
&gt; Session some_session created.<br>
&gt; Traces will be written in /home/username/lttng-traces/ some_session-20=
140625-102709<br>
&gt; $ lttng enable-event -u some_event<br>
&gt; UST event some_event created in channel channel0<br>
&gt; $ lttng list some_session -u --channel channel0<br>
&gt; Tracing session some_session: [inactive]<br>
&gt; =C2=A0 =C2=A0 Trace path: /home/username/lttng-traces/ some_session-20=
140625-102709<br>
&gt;<br>
&gt; =3D=3D=3D Domain: UST global =3D=3D=3D<br>
&gt;<br>
&gt; Buffer type: per UID<br>
&gt;<br>
&gt; - channel0: [enabled]<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 Attributes:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 overwrite mode: 0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 subbuffers size: 131072<br>
&gt; =C2=A0 =C2=A0 =C2=A0 number of subbufers: 4<br>
&gt; =C2=A0 =C2=A0 =C2=A0 switch time interval: 0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 read time interval: 0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 output: mmap()<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 Events:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 some_event (type: tracepoint) [enabled]<br>
&gt; (end example)<br>
&gt;<br>
&gt; =C2=A0 =C2=A0You can take a look at /usr/src/lttng-tools/src/bin/lttng=
/commands/list.c to see how the information is obtained.<br>
&gt;<br>
&gt; Daniel U. Thibault<br>
&gt; Protection des syst=C3=A8mes et contremesures (PSC) | Systems Protecti=
on &amp; Countermeasures (SPC)<br>
&gt; Cyber s=C3=A9curit=C3=A9 pour les missions essentielles (CME) | Missio=
n Critical Cyber Security (MCCS)<br>
&gt; RDDC - Centre de recherches de Valcartier | DRDC - Valcartier Research=
 Centre<br>
&gt; 2459 route de la Bravoure<br>
&gt; Qu=C3=A9bec QC =C2=A0G3J 1X5<br>
&gt; CANADA<br>
&gt; Vox : (418) 844-4000 x4245<br>
&gt; Fax : (418) 844-4538<br>
&gt; NAC : 918V QSDJ &lt;<a href=3D"http://www.travelgis.com/map.asp?addr=
=3D918V%20QSDJ" target=3D"_blank">http://www.travelgis.com/map.asp?addr=3D9=
18V%20QSDJ</a>&gt;<br>
&gt; Gouvernement du Canada | Government of Canada<br>
&gt; &lt;<a href=3D"http://www.valcartier.drdc-rddc.gc.ca/" target=3D"_blan=
k">http://www.valcartier.drdc-rddc.gc.ca/</a>&gt;<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org=
</a><br>
&gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" =
target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev=
</a><br>
&gt;<br>
<br>
<br>
_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
</blockquote></div><br></div>

--001a11c2f942e42e8c04fcced4f1--


--===============2012426086==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2012426086==--
