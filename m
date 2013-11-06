From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: Some corrections to the
 lttng man page
Date: Tue, 5 Nov 2013 20:25:12 -0500
Message-ID: <CA+jJMxsfyhffdEVEybjWA-5arfetSNbM9XuZXZN5r7mKX2xEEg__35508.6497882896$1383701181$gmane$org@mail.gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD2679FA2C@VAL-E-01.valcartier.drdc-rddc.gc.ca>
	<CA+jJMxu4WNTRny2x6C3H96_wLQaYeBEPk+HX1pXVvhHjT3X8Uw@mail.gmail.com>
	<48CF5AC71E61DB46B70D0F388054EFFD267A10D1@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0228872458=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f51.google.com ([209.85.216.51])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1Vdrry-0005oL-2S
	for lttng-dev@lists.lttng.org; Tue, 05 Nov 2013 20:25:26 -0500
Received: by mail-qa0-f51.google.com with SMTP id hu16so1466916qab.17
	for <lttng-dev@lists.lttng.org>; Tue, 05 Nov 2013 17:25:12 -0800 (PST)
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD267A10D1@VAL-E-01.valcartier.drdc-rddc.gc.ca>
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

--===============0228872458==
Content-Type: multipart/alternative; boundary=001a1132ec7049609804ea78051e

--001a1132ec7049609804ea78051e
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2013 at 4:34 PM, Thibault, Daniel <
Daniel.Thibault@drdc-rddc.gc.ca> wrote:

>  *De :* jeremie.galarneau@gmail.com
> *Envoy=E9 :* 5 novembre 2013 15:51
>
>  On Thu, Oct 24, 2013 at 12:09 PM, Thibault, Daniel <
> Daniel.Thibault@drdc-rddc.gc.ca> wrote:
>
> -----Message d'origine-----
> Date: Wed, 23 Oct 2013 12:08:47 -0400
> From: J?r?mie Galarneau <jeremie.galarneau@efficios.com>
>
> > diff --git a/doc/man/lttng.1 b/doc/man/lttng.1
> > [...]
>
> > +All user-space applications instrumented with lttng-ust(3) will
> > automatically register to the session daemon. This feature gives you th=
e
> > ability to list available traceable applications and tracepoints on a
> per user
> > basis. (See \fBlist\fP command).
>
>    Is this a statement of intent?  LTTng 2.3.0's list command identifies
> user-space events by trace provider name, event name, and process ID, but
> not by user ID (in fact it doesn't even yet filter the kernel events out
> when one asks for 'list -u session'; see bug #654).  And there is as yet =
no
> way to filter the 'lttng list' output by user ID (an optional argument fo=
r
> the -u option could do the trick).
>
>     Of course, listing available tracepoints is automatically per-user
> when using a local session daemon.  But if you're a member of the
> 'tracing' group, you'll deal exclusively with the root daemon and won't
> have that choice.
>
>  > I didn't change the meaning of the original sentence. It just means
> that "lttng list" will output the events registered to the user's
> corresponding session daemon.
>
> > Perhaps you can suggest a better phrasing?
>
> >
>
> > J=E9r=E9mie
>
>
>
>    How about this?
>
>
>
> Each user-space application instrumented with lttng-ust(3) will
> automatically
>
> register with the root session daemon and its user session daemon. This
> allows
>
> each daemon to list the available traceable applications and tracepoints
> at
>
> any given moment (See the \fBlist\fP command).
>
>
>

Looks good to me.

Cheers,
J=E9r=E9mie


>  (There is no need to explain further the diff between the two daemons
> since the preceding paragraph in the man page already talks about
> co-existing session daemons)
>
>
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
> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ> <*h=
ttp://www.travelgis.com/map.asp?addr=3D918V%20QSDJ
> <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>*>
> Gouvernement du Canada | Government of Canada
> <http://www.valcartier.drdc-rddc.gc.ca/>
>



--=20
J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--001a1132ec7049609804ea78051e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><br><div class=3D"gmail=
_quote">On Tue, Nov 5, 2013 at 4:34 PM, Thibault, Daniel <span dir=3D"ltr">=
&lt;<a href=3D"mailto:Daniel.Thibault@drdc-rddc.gc.ca" target=3D"_blank">Da=
niel.Thibault@drdc-rddc.gc.ca</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">





<div lang=3D"FR-CA" link=3D"blue" vlink=3D"purple">
<div>
<p class=3D"MsoNormal"><b><span lang=3D"EN-CA" style=3D"font-size:10.0pt;fo=
nt-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;">De=A0:</span></b><span=
 lang=3D"EN-CA" style=3D"font-size:10.0pt;font-family:&quot;Tahoma&quot;,&q=
uot;sans-serif&quot;"> <a href=3D"mailto:jeremie.galarneau@gmail.com" targe=
t=3D"_blank">jeremie.galarneau@gmail.com</a><br>

<b>Envoy=E9=A0:</b> 5 novembre 2013 15:51<br>
<br>
<u></u><u></u></span></p>
<div><div class=3D"im">
<p class=3D"MsoNormal"><span lang=3D"EN-CA">On Thu, Oct 24, 2013 at 12:09 P=
M, Thibault, Daniel &lt;</span><a href=3D"mailto:Daniel.Thibault@drdc-rddc.=
gc.ca" target=3D"_blank"><span lang=3D"EN-CA">Daniel.Thibault@drdc-rddc.gc.=
ca</span></a><span lang=3D"EN-CA">&gt; wrote:<u></u><u></u></span></p>

</div><div>
<div><div class=3D"im">
<blockquote style=3D"border:none;border-left:solid #cccccc 1.0pt;padding:0c=
m 0cm 0cm 6.0pt;margin-left:4.8pt;margin-right:0cm">
<p class=3D"MsoNormal">-----Message d&#39;origine-----<br>
Date: Wed, 23 Oct 2013 12:08:47 -0400<br>
From: J?r?mie Galarneau &lt;<a href=3D"mailto:jeremie.galarneau@efficios.co=
m" target=3D"_blank">jeremie.galarneau@efficios.com</a>&gt;<br>
<br>
&gt; diff --git a/doc/man/lttng.1 b/doc/man/lttng.1<br>
&gt; [...]<u></u><u></u></p>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">&gt; +All user-space =
applications instrumented with lttng-ust(3) will<br>
&gt; automatically register to the session daemon. This feature gives you t=
he<br>
&gt; ability to list available traceable applications and tracepoints on a =
per user<br>
&gt; basis. (See \fBlist\fP command).<u></u><u></u></p>
</div>
<p class=3D"MsoNormal" style=3D"margin-right:0cm;margin-bottom:12.0pt;margi=
n-left:11.55pt">
=A0 =A0Is this a statement of intent? =A0LTTng 2.3.0&#39;s list command ide=
ntifies user-space events by trace provider name, event name, and process I=
D, but not by user ID (in fact it doesn&#39;t even yet filter the kernel ev=
ents out when one asks for &#39;list -u session&#39;;
 see bug #654). =A0And there is as yet no way to filter the &#39;lttng list=
&#39; output by user ID (an optional argument for the -u option could do th=
e trick).<span style=3D"color:#1f497d"><u></u><u></u></span></p>
</blockquote>
</div><blockquote style=3D"border:none;border-left:solid #cccccc 1.0pt;padd=
ing:0cm 0cm 0cm 6.0pt;margin-left:4.8pt;margin-right:0cm">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span lang=3D"EN-CA">=
=A0 =A0Of course, listing available tracepoints is automatically per-user w=
hen using a local session daemon. =A0</span>But if you&#39;re a member of t=
he &#39;tracing&#39; group, you&#39;ll deal exclusively with
 the root daemon and won&#39;t have that choice.<u></u><u></u></p>
</blockquote>
</div><div class=3D"im">
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1f497d">&gt; </=
span><span lang=3D"EN-CA">I didn&#39;t change the meaning of the original s=
entence. It just means that &quot;lttng list&quot; will output the events r=
egistered to the user&#39;s corresponding session daemon.<span style=3D"col=
or:#1f497d"><u></u><u></u></span></span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1f497d">&gt;</s=
pan><span lang=3D"EN-CA"> Perhaps you can suggest a better phrasing?<u></u>=
<u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1f497d">&gt;</span><u></u>=A0<=
u></u></p>
<p class=3D"MsoNormal"><span style=3D"color:#1f497d">&gt; </span>J=E9r=E9mi=
e<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=A0<u></u></p>
</div><p class=3D"MsoNormal"><span lang=3D"EN-CA">=A0=A0 How about this?<u>=
</u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA"><u></u>=A0<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">Each user-space application ins=
trumented with lttng-ust(3) will automatically
<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">register with the root session =
daemon and its user session daemon. This allows
<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">each daemon to list the availab=
le traceable applications and tracepoints at
<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">any given moment (See the \fBli=
st\fP command).<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA"><u></u>=A0</span></p></div></di=
v></div></div></blockquote><div><br></div><div>Looks good to me.</div><div>=
<br></div><div>Cheers,</div><div>J=E9r=E9mie</div><div>=A0</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc soli=
d;padding-left:1ex">
<div lang=3D"FR-CA" link=3D"blue" vlink=3D"purple"><div><div><div><p class=
=3D"MsoNormal"><span lang=3D"EN-CA"><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">(There is no need to explain fu=
rther the diff between the two daemons since the preceding paragraph in the=
 man page already talks about co-existing session daemons)<u></u><u></u></s=
pan></p>
<div class=3D"im">
<p class=3D"MsoNormal"><span lang=3D"EN-CA"><u></u>=A0<u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:Consolas=
;color:#1f497d">Daniel U. Thibault<br>
Protection des syst=E8mes et contremesures (PSC) | Systems Protection &amp;=
 Countermeasures (SPC)<br>
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)<br>
R &amp; D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence=
 R&amp;D Canada - Valcartier (DRDC Valcartier)<br>
2459 route de la Bravoure<br>
Qu=E9bec QC=A0 G3J 1X5<br>
CANADA<br>
Vox</span><span style=3D"font-size:10.5pt;font-family:Consolas;color:#1f497=
d">=A0</span><span style=3D"font-size:11.0pt;font-family:Consolas;color:#1f=
497d">: <a href=3D"tel:%28418%29%20844-4000%20x4245" value=3D"+14188444000"=
 target=3D"_blank">(418) 844-4000 x4245</a><br>

Fax</span><span style=3D"font-size:10.5pt;font-family:Consolas;color:#1f497=
d">=A0</span><span style=3D"font-size:11.0pt;font-family:Consolas;color:#1f=
497d">: <a href=3D"tel:%28418%29%20844-4538" value=3D"+14188444538" target=
=3D"_blank">(418) 844-4538</a><br>

</span><span style=3D"font-size:11.0pt;font-family:Consolas;color:#1f497d">=
NAC=A0: </span>
<span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-family:&quot;Calibri&qu=
ot;,&quot;sans-serif&quot;;color:#1f497d"><a href=3D"http://www.travelgis.c=
om/map.asp?addr=3D918V%20QSDJ" target=3D"_blank"><span lang=3D"FR-CA" style=
=3D"font-size:10.0pt;font-family:&quot;Courier New&quot;">918V QSDJ</span><=
/a></span><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-family:&quot;=
Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">
</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;;color:#1f497d">&lt;</span><u><span style=3D"font-size:10=
.0pt;font-family:&quot;Courier New&quot;;color:blue"><a href=3D"http://www.=
travelgis.com/map.asp?addr=3D918V%20QSDJ" target=3D"_blank">http://www.trav=
elgis.com/map.asp?addr=3D918V%20QSDJ</a></span></u><span style=3D"font-size=
:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497=
d">&gt;</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quo=
t;,&quot;sans-serif&quot;;color:#1f497d"><br>

</span><span style=3D"font-size:11.0pt;font-family:Consolas;color:#1f497d">=
Gouvernement du Canada=A0| Government of Canada<br>
</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;;color:#1f497d">&lt;</span><span lang=3D"EN-CA" style=3D"=
font-size:10.0pt;font-family:&quot;Courier New&quot;;color:blue"><a href=3D=
"http://www.valcartier.drdc-rddc.gc.ca/" target=3D"_blank"><span lang=3D"FR=
-CA">http://www.valcartier.drdc-rddc.gc.ca/</span></a></span><span style=3D=
"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:#1f497d">&gt;</span><span style=3D"font-size:10.5pt;font-family:Consola=
s;color:#1f497d"><u></u><u></u></span></p>

</div></div>
</div>
</div>
</div>

</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>J=E9r=E9mie =
Galarneau<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com" target=3D=
"_blank">http://www.efficios.com</a>
</div></div>

--001a1132ec7049609804ea78051e--


--===============0228872458==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0228872458==--
