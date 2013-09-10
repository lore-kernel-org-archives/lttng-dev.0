From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: Enabling and disabling events
Date: Tue, 10 Sep 2013 13:14:47 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD2678DB8E__47287.6027030454$1378818934$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
References: <48CF5AC71E61DB46B70D0F388054EFFD2678D70B@VAL-E-02.valcartier.drdc-rddc.gc.ca>
	<009B25148989C6458484484699278506E5388E0E@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1VJNmL-0002Vc-8b
	for lttng-dev@lists.lttng.org; Tue, 10 Sep 2013 09:14:52 -0400
In-Reply-To: <009B25148989C6458484484699278506E5388E0E@EU-MBX-01.mgc.mentorg.com>
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

> De=A0: Ikaheimonen, JP [mailto:jp_ikaheimonen@mentor.com] =

> Envoy=E9=A0: 10 septembre 2013 07:41
>
> As you can see, things easily get too complicated.
>
> Currently in LTTng you can only disable events that are enabled in the fi=
rst place. In other words, an event is born disabled, as if 'lttng disable-=
event "*"' had been issued whenever a > channel is created. We already have=
 a mechanism to un-disable events - this is the enable-event command. I do =
not see any reason to add another command to do exactly what
> enable-event already does. If we want to 'disable all events except 'a'' =
we can call lttng enable-event 'a'. Symmetrically, I would like to have 'en=
able all events except 'a'', but
> currently this is impossible.

   I disagree with the perception that "an event is born disabled".  I perc=
eive quite the opposite, in fact.  The problem, as I've mentioned elsewhere=
 before, is that enable-events is a double-duty command, which serves to bo=
th *create* (i.e define) events and to toggle their enablement.  I would mu=
ch rather have a separate define-event command.  Right now you can define, =
enable, disable until the trace is started, and once that has happened you =
can only enable and disable.  With separate define-event and enable-event c=
ommands the code would be simpler (and thus less bug-prone), and so would t=
he user experience.

   Getting back to event birth, events are initially non-existent, then the=
y transition to defined (and enabled), and can later toggle between enabled=
 and disabled (but cannot be undefined).  It is in that sense that they are=
 born enabled.

> I still propose keeping the disable-event and enable-event commands asymm=
etrical. Based on your thoughts below, I also suggest keeping two lists for=
 the enabled events: one for > the enablements, and one for the exceptions =
to the enablements. The items in the latter list would point to specific it=
ems in the former list, so that the exceptions would be tied to > certain e=
nablements.
>
> So for instance,
>
> $ lttng enable-event -u 'x'
> $ lttng list session
> Events:
>   x [enabled]
> $ lttng enable-event -u "x*" --except "xa*"
> $ lttng list session
> Events:
>   x [enabled]
>   x* [enabled, exception xa*]

   I think the exception should be in the event_name string (recall that en=
able-event accepts a *list* of event_names), something like:
$ lttng enable-event -u "x*!xa*"
$ lttng enable-event -u "x*!xa*","y*!yy*"
   (Presumably, if an '!' appears in an actual event name, it would need to=
 be escaped in the event_name argument of enable-event)

> $ lttng enable-event -u "x*" --except "xb*"
> $ lttng list session
>   x [enabled]
>   x* [enabled, exception xa*]
>   x* [enabled, exception xb*]
>
> Again, all the enablements would be checked, and the event would be enabl=
ed if any of the enablements match.

   What if the user types lttng enable-event -u "xa*!x*"?  Clearly the argu=
ment collapses to an empty string (it does not enable anything), so the int=
erface should leave the current list of enablements and disablements alone,=
 and issue a warning to the user.

> If an event enablement has an exception, it must be used in the disable-e=
vent command also:
> $ lttng disable-event -u "x*" --except "xb*"
> $ lttng list session
>   x [enabled]
>   x* [enabled, exception xa*]
>   x* [disabled, exception xb*]

   I don't like that restriction at all.  You should be able to use any arg=
ument for either enable-event or disable-event.

> Comments are very welcome.
>
> JP Ikaheimonen | SW Development Engineer http://go.mentor.com/sourceryana=
lyzer

   I still say the lttng daemon should process the resulting enablement/dis=
ablement sets to simplify them whenever possible.  Thus:

$ lttng enable-event -u 'x'
$ lttng list session
Events:
   x [enabled]
$ lttng enable-event -u "x*!xa*"
$ lttng list session
Events:
   x* [enabled, exception xa*]

   The 'x [enabled]' rule is removed because it is subsumed by the 'x* [ena=
bled, exception xa*]' rule.

$ lttng enable-event -u "x*!xb*"
$ lttng list session
  x* [enabled]

   In this case the union of "x*!xa*" and "x*!xb*" results in "x*".

   If the user wants to do "all events beginning with x except for those be=
ginning with xa or xb", we would have to accept the '[]' regular expression=
 operator (e.g. enable-event "x*!x[ab]*) (but note that the '*' is a wildca=
rd here, not the regular expression repetition operator).  It may be easier=
 to go to full-blown regular expressions.

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC)
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
2459 route de la Bravoure
Qu=E9bec QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada | Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
