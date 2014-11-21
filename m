From: Eugene Ivanov <eiva@tbricks.com>
Subject: Re: Question about TRACEPOINT_EVENT_CLASS and
	TRACEPOINT_EVENT_INSTANCE
Date: Fri, 21 Nov 2014 15:28:30 +0400
Message-ID: <CAF1eGnQ2_CTcifSqvLr5hb33tRdgqGK5+yMpGfWvbx=9TRr3Hw__36878.1731267974$1416569361$gmane$org@mail.gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD6FBC92BD@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0597138715=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <eiva@tbricks.com>) id 1XrmOC-0005sz-M9
 for lttng-dev@lists.lttng.org; Fri, 21 Nov 2014 06:28:39 -0500
Received: by mail-qc0-f169.google.com with SMTP id w7so3589890qcr.14
 for <lttng-dev@lists.lttng.org>; Fri, 21 Nov 2014 03:28:31 -0800 (PST)
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD6FBC92BD@VAL-E-02.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0597138715==
Content-Type: multipart/alternative; boundary=001a11c2be4295712705085cbe5b

--001a11c2be4295712705085cbe5b
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Thanks for the explanation, Daniel! Unfortunately using class defined in
another provider doesn't work. I get an error about undefined
__event_probe__instance_provider_name___class_name_from_another_provider=E2=
=80=99.
Connecting it with your description, I guess it's probably a feature and
 intended behavior. Though it would be a nice feature to be able to specify
provider of class separately from provider of instance.

On Wed, Nov 19, 2014 at 9:14 PM, Thibault, Daniel <
Daniel.Thibault@drdc-rddc.gc.ca> wrote:

> > Date: Wed, 19 Nov 2014 15:35:01 +0400
> > From: Eugene Ivanov <eiva@tbricks.com>
> >
> > I found description of TRACEPOINT_EVENT_CLASS on the website and in
> ust-tracepoint-event.h as well, but it is not documented in the lttng-ust
> man page.
> > According the header TRACEPOINT_EVENT_INSTANCE declares an instance of =
a
> tracepoint, with its own provider and name.
> > Does it mean that I can define classes for usage in different providers=
?
> Why do we need provider in _CLASS then?
> > According the code on the first glance it seems that it is required tha=
t
> CLASS and INSTANCE must share in same provider.
>
>    You will also have seen that the "default" macro TRACEPOINT_EVENT
> simply wraps both TRACEPOINT_EVENT_CLASS and TRACEPOINT_EVENT_INSTANCE
> together.  When used separately, the TRACEPOINT_EVENT_INSTANCE must match
> its template's params; the event class then takes care of the mapping of
> parameters to fields in the event output.  This allows you to declare a
> single event class somewhere, then declare various instances that vary by
> name only, typically because they're events of the same nature but
> occurring in varying contexts.  Having the trace label them under differe=
nt
> names makes the analyst's life easier.
>
>    Normally you use TRACEPOINT_EVENT_CLASS and _INSTANCE within the same
> provider, but you could theoretically have varying instances rely on
> different providers.  I guess this would allow you some flexibility in
> picking which sets of instances to enable/disable by picking which provid=
er
> shared objects (.so) to preload or not.
>
>    Kernel space has essentially the same macros under the names
> DECLARE_EVENT_CLASS and TRACE_EVENT, respectively.  You can see those at
> work in the lttng-modules package and in some kernel modules such as
> drivers/staging/android/binder_trace.h.  In the latter, for example, you
> see a binder_lock_class which is then instantiated as binder_lock,
> binder_locked, and binder_unlock.  These three events carry very differen=
t
> semantics, but they have precisely the same parameter signatures.  Groupi=
ng
> them under an event class avoids a lot of cutting-and-pasting and
> diminishes the risk of errors later on (e.g. if you had to modify the fie=
ld
> layout of binder_lock and forgot to copy it to binder_unlock).
>
>    "Why do we need provider in _CLASS then?"  Because the provider name i=
s
> part of the fully-qualified event class name.  This allows different even=
t
> classes (and event instances) to have the same short names within differe=
nt
> providers.  You would be bound to run into collisions if all the event
> class or event instance names were global.
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
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>



--=20
Eugene

--001a11c2be4295712705085cbe5b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks for the explanation, Daniel!=C2=A0Unfortunately usi=
ng class defined in another provider doesn&#39;t work. I get an error about=
 undefined __event_probe__instance_provider_name___class_name_from_another_=
provider=E2=80=99. Connecting it with your description, I guess it&#39;s pr=
obably a feature and =C2=A0intended behavior. Though it would be a nice fea=
ture to be able to specify provider of class separately from provider of in=
stance.<br></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Wed, Nov 19, 2014 at 9:14 PM, Thibault, Daniel <span dir=3D"ltr">&lt;<a =
href=3D"mailto:Daniel.Thibault@drdc-rddc.gc.ca" target=3D"_blank">Daniel.Th=
ibault@drdc-rddc.gc.ca</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex">&gt; Date: Wed, 19 Nov 2014 15:35:01 +0400<br>
&gt; From: Eugene Ivanov &lt;<a href=3D"mailto:eiva@tbricks.com">eiva@tbric=
ks.com</a>&gt;<br>
&gt;<br>
&gt; I found description of TRACEPOINT_EVENT_CLASS on the website and in us=
t-tracepoint-event.h as well, but it is not documented in the lttng-ust man=
 page.<br>
&gt; According the header TRACEPOINT_EVENT_INSTANCE declares an instance of=
 a tracepoint, with its own provider and name.<br>
&gt; Does it mean that I can define classes for usage in different provider=
s? Why do we need provider in _CLASS then?<br>
&gt; According the code on the first glance it seems that it is required th=
at CLASS and INSTANCE must share in same provider.<br>
<br>
=C2=A0 =C2=A0You will also have seen that the &quot;default&quot; macro TRA=
CEPOINT_EVENT simply wraps both TRACEPOINT_EVENT_CLASS and TRACEPOINT_EVENT=
_INSTANCE together.=C2=A0 When used separately, the TRACEPOINT_EVENT_INSTAN=
CE must match its template&#39;s params; the event class then takes care of=
 the mapping of parameters to fields in the event output.=C2=A0 This allows=
 you to declare a single event class somewhere, then declare various instan=
ces that vary by name only, typically because they&#39;re events of the sam=
e nature but occurring in varying contexts.=C2=A0 Having the trace label th=
em under different names makes the analyst&#39;s life easier.<br>
<br>
=C2=A0 =C2=A0Normally you use TRACEPOINT_EVENT_CLASS and _INSTANCE within t=
he same provider, but you could theoretically have varying instances rely o=
n different providers.=C2=A0 I guess this would allow you some flexibility =
in picking which sets of instances to enable/disable by picking which provi=
der shared objects (.so) to preload or not.<br>
<br>
=C2=A0 =C2=A0Kernel space has essentially the same macros under the names D=
ECLARE_EVENT_CLASS and TRACE_EVENT, respectively.=C2=A0 You can see those a=
t work in the lttng-modules package and in some kernel modules such as driv=
ers/staging/android/binder_trace.h.=C2=A0 In the latter, for example, you s=
ee a binder_lock_class which is then instantiated as binder_lock, binder_lo=
cked, and binder_unlock.=C2=A0 These three events carry very different sema=
ntics, but they have precisely the same parameter signatures.=C2=A0 Groupin=
g them under an event class avoids a lot of cutting-and-pasting and diminis=
hes the risk of errors later on (e.g. if you had to modify the field layout=
 of binder_lock and forgot to copy it to binder_unlock).<br>
<br>
=C2=A0 =C2=A0&quot;Why do we need provider in _CLASS then?&quot;=C2=A0 Beca=
use the provider name is part of the fully-qualified event class name.=C2=
=A0 This allows different event classes (and event instances) to have the s=
ame short names within different providers.=C2=A0 You would be bound to run=
 into collisions if all the event class or event instance names were global=
.<br>
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
<br>
_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature"><div dir=3D"ltr">Eugene</div></div>
</div>

--001a11c2be4295712705085cbe5b--


--===============0597138715==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0597138715==--
