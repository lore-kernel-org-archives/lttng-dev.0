From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: Some corrections to the
 lttng man page
Date: Tue, 5 Nov 2013 15:50:43 -0500
Message-ID: <CA+jJMxu4WNTRny2x6C3H96_wLQaYeBEPk+HX1pXVvhHjT3X8Uw__18237.6658930027$1383684706$gmane$org@mail.gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD2679FA2C@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0610624964=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1VdnaK-00051a-OB
	for lttng-dev@lists.lttng.org; Tue, 05 Nov 2013 15:50:54 -0500
Received: by mail-qa0-f50.google.com with SMTP id f11so1391040qae.9
	for <lttng-dev@lists.lttng.org>; Tue, 05 Nov 2013 12:50:43 -0800 (PST)
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD2679FA2C@VAL-E-01.valcartier.drdc-rddc.gc.ca>
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

--===============0610624964==
Content-Type: multipart/alternative; boundary=047d7bdc1018a2304704ea742f35

--047d7bdc1018a2304704ea742f35
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2013 at 12:09 PM, Thibault, Daniel <
Daniel.Thibault@drdc-rddc.gc.ca> wrote:

> -----Message d'origine-----
> Date: Wed, 23 Oct 2013 12:08:47 -0400
> From: J?r?mie Galarneau <jeremie.galarneau@efficios.com>
>
> > diff --git a/doc/man/lttng.1 b/doc/man/lttng.1
> > [...]
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
>
I didn't change the meaning of the original sentence. It just means that
"lttng list" will output the events registered to the user's corresponding
session daemon. Perhaps you can suggest a better phrasing?

J=E9r=E9mie



>    Of course, listing available tracepoints is automatically per-user whe=
n
> using a local session daemon.  But if you're a member of the 'tracing'
> group, you'll deal exclusively with the root daemon and won't have that
> choice.
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



--=20
J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--047d7bdc1018a2304704ea742f35
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On Thu, Oct 24, 2013 at 12:09 PM, Thibault, Daniel <span d=
ir=3D"ltr">&lt;<a href=3D"mailto:Daniel.Thibault@drdc-rddc.gc.ca" target=3D=
"_blank">Daniel.Thibault@drdc-rddc.gc.ca</a>&gt;</span> wrote:<br><div clas=
s=3D"gmail_extra">
<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204=
);border-left-style:solid;padding-left:1ex">-----Message d&#39;origine-----=
<br>

Date: Wed, 23 Oct 2013 12:08:47 -0400<br>
From: J?r?mie Galarneau &lt;<a href=3D"mailto:jeremie.galarneau@efficios.co=
m">jeremie.galarneau@efficios.com</a>&gt;<br>
<br>
&gt; diff --git a/doc/man/lttng.1 b/doc/man/lttng.1<br>
&gt; [...]<br>
<div class=3D"im">&gt; +All user-space applications instrumented with lttng=
-ust(3) will<br>
&gt; automatically register to the session daemon. This feature gives you t=
he<br>
&gt; ability to list available traceable applications and tracepoints on a =
per user<br>
&gt; basis. (See \fBlist\fP command).<br>
<br>
</div>=A0 =A0Is this a statement of intent? =A0LTTng 2.3.0&#39;s list comma=
nd identifies user-space events by trace provider name, event name, and pro=
cess ID, but not by user ID (in fact it doesn&#39;t even yet filter the ker=
nel events out when one asks for &#39;list -u session&#39;; see bug #654). =
=A0And there is as yet no way to filter the &#39;lttng list&#39; output by =
user ID (an optional argument for the -u option could do the trick).<br>

<br></blockquote><div><br></div><div><div>I didn&#39;t change the meaning o=
f the original sentence. It just means that &quot;lttng list&quot; will out=
put the events registered to the user&#39;s corresponding session daemon. P=
erhaps you can suggest a better phrasing?</div>
<div><br></div><div>J=E9r=E9mie<br></div></div><div><br></div><div>=A0</div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;=
padding-left:1ex">

=A0 =A0Of course, listing available tracepoints is automatically per-user w=
hen using a local session daemon. =A0But if you&#39;re a member of the &#39=
;tracing&#39; group, you&#39;ll deal exclusively with the root daemon and w=
on&#39;t have that choice.<br>

<br></blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-l=
eft-style:solid;padding-left:1ex">Daniel U. Thibault<br>
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
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>J=E9r=E9mie =
Galarneau<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com" target=3D=
"_blank">http://www.efficios.com</a>
</div></div>

--047d7bdc1018a2304704ea742f35--


--===============0610624964==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0610624964==--
