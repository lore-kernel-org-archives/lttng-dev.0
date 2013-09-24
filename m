From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: [LTTng UST] [RFC] Event exclusion feature
Date: Tue, 24 Sep 2013 16:07:30 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD26792BAD__4562.73109089143$1380038944$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1VOV99-0005th-67
	for lttng-dev@lists.lttng.org; Tue, 24 Sep 2013 12:07:37 -0400
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Message: 4
Date: Mon, 23 Sep 2013 08:01:17 +0000
From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>

> 4) When using --exclude, the event name should be a wildcard specificatio=
n, and the excluded events should be a proper subset of the event specifica=
tion.
> Otherwise, a warning is given, and the excluder is discarded. If the excl=
uder fully covers the given event so that no events would be enabled, an er=
ror is given.
>
> $ lttng enable-event 'myap2*' --exclude 'myapp_comp1*'
> Warning: Event myap2*: myapp_comp1* does not exclude any events from myap=
2* =

> UST event myap2* created in channel mychan

"should" implies optional compliance. I think it should say "must".

> 5) When disabling an event that has been enabled with exclusions, the exc=
lusions do not need to be specified again. =

>
> $ lttng enable-event -u -c mychan 'myapp2*' --exclude 'myapp2_comp1*' =

> UST event myapp2* excluding myapp2_comp1* created in channel mychan =

> $ lttng disable-event -u -c mychan 'myapp2*' =

> UST event myapp2* disabled in channel mychan

   The feedback should make this clear.  Replace the above with:

> $ lttng enable-event -u -c mychan 'myapp2*' --exclude 'myapp2_comp1*'
> UST event myapp2* excluding myapp2_comp1* created in channel mychan
> $ lttng disable-event -u -c mychan 'myapp2*'
> UST event myapp2* excluding myapp2_comp1* disabled in channel mychan

   This is actually in keeping with the event-name matching philosophy of e=
nable-event.  For instance we can have:

> $ lttng enable-event -u -c mychan 'myapp2*' --exclude 'myapp2_comp1*'
> UST event myapp2* excluding myapp2_comp1* created in channel mychan
> $ lttng enable-event -u -c mychan 'myapp2_comp1*'
> UST event myapp2_comp1* disabled in channel mychan

   Allowing separate control of the two disjoint sets ("myapp2* excluding m=
yapp2_comp1*" and "myapp2_comp1*" can have no events in common).

   Currently one can set up parallel enable-event entries that share a name=
 key (and are distinguished only by their loglevel, loglevel-only, filter a=
nd/or exclude attributes).  They can only be disabled as a block (because d=
isable-event admits no such command options), whereas they can be enabled i=
ndividually.

   This is what I would like a session to look like (assuming that bugs 628=
 and 630 have been fixed, along with other feedback improvements):

$ lttng enable-event -u "ev1*" --loglevel wArNiNg
UST events ev1* are enabled in channel channel0 for loglevels up to TRACE_W=
ARNING (4)
$ lttng list abcd
Tracing session abcd: [active]
[...]
    Events:
      ev1* (loglevel <=3D TRACE_WARNING (4)) (type: tracepoint) [enabled]
$ lttng disable-event -u "ev1*"
UST events ev1* are disabled in channel channel0 for loglevels up to TRACE_=
WARNING (4)
$ lttng list abcd
Tracing session abcd: [active]
[...]
    Events:
      ev1* (loglevel <=3D TRACE_WARNING (4)) (type: tracepoint) [disabled]
$ lttng enable-event -u "ev1*" --loglevel-only notice
UST events ev1* are enabled in channel channel0 for loglevel TRACE_NOTICE (=
5)
$ lttng list abcd
Tracing session abcd: [active]
[...]
    Events:
      ev1* (loglevel <=3D TRACE_WARNING (4)) (type: tracepoint) [disabled]
      ev1* (loglevel =3D=3D TRACE_NOTICE (5)) (type: tracepoint) [enabled]
$ lttng disable-event -u "ev1*"
UST events ev1* are disabled in channel channel0 for loglevel TRACE_NOTICE =
(5)
$ lttng list abcd
Tracing session abcd: [active]
[...]
    Events:
      ev1* (loglevel <=3D TRACE_WARNING (4)) (type: tracepoint) [disabled]
      ev1* (loglevel =3D=3D TRACE_NOTICE (5)) (type: tracepoint) [disabled]
$ lttng enable-event -u "ev1*"
UST events ev1* are enabled in channel channel0
$ lttng list abcd
Tracing session abcd: [active]
[...]
    Events:
      ev1* (loglevel <=3D TRACE_WARNING (4)) (type: tracepoint) [disabled]
      ev1* (loglevel =3D=3D TRACE_NOTICE (5)) (type: tracepoint) [disabled]
      ev1* (type: tracepoint) [enabled]
$ lttng disable-event -u "ev1*"
UST events ev1* are disabled in channel channel0
$ lttng list abcd
Tracing session abcd: [active]
[...]
    Events:
      ev1* (loglevel <=3D TRACE_WARNING (4)) (type: tracepoint) [disabled]
      ev1* (loglevel =3D=3D TRACE_NOTICE (5)) (type: tracepoint) [disabled]
      ev1* (type: tracepoint) [disabled]
$ lttng enable-event -u "ev1*"
UST events ev1* are enabled in channel channel0
$ lttng enable-event -u "ev1*" --loglevel-only notice
UST events ev1* are enabled in channel channel0 for loglevel TRACE_NOTICE (=
5)
$ lttng list abcd
Tracing session abcd: [active]
[...]
    Events:
      ev1* (loglevel <=3D TRACE_WARNING (4)) (type: tracepoint) [disabled]
      ev1* (loglevel =3D=3D TRACE_NOTICE (5)) (type: tracepoint) [enabled]
      ev1* (type: tracepoint) [enabled]
$ lttng disable-event -u "ev1*"
UST events ev1* are disabled in channel channel0
UST events ev1* are disabled in channel channel0 for loglevel TRACE_NOTICE =
(5)
$ lttng list abcd
Tracing session abcd: [active]
[...]
    Events:
      ev1* (loglevel <=3D TRACE_WARNING (4)) (type: tracepoint) [disabled]
      ev1* (loglevel =3D=3D TRACE_NOTICE (5)) (type: tracepoint) [disabled]
      ev1* (type: tracepoint) [disabled]
$ lttng enable-event -u "ev1*" --filter "arg > 12"
UST events ev1* are enabled in channel channel0 with filter 'arg > 12'
$ lttng list abcd
Tracing session abcd: [active]
[...]
    Events:
      ev1* (loglevel <=3D TRACE_WARNING (4)) (type: tracepoint) [disabled]
      ev1* (loglevel =3D=3D TRACE_NOTICE (5)) (type: tracepoint) [disabled]
      ev1* (type: tracepoint) [enabled] [with filter 'arg > 12']
      ev1* (type: tracepoint) [disabled]
$ lttng enable-event -u "ev1*" --exclude "ev1_comp1*"
UST events ev1* excluding ev1_comp1* are enabled in channel channel0
$ lttng list abcd
Tracing session abcd: [active]
[...]
    Events:
      ev1* (loglevel <=3D TRACE_WARNING (4)) (type: tracepoint) [disabled]
      ev1* (loglevel =3D=3D TRACE_NOTICE (5)) (type: tracepoint) [disabled]
      ev1* (type: tracepoint) [enabled] [with filter 'arg > 12']
      ev1* excluding ev1_comp* (type: tracepoint) [enabled]
      ev1* (type: tracepoint) [disabled]
$ lttng enable-event -u "ev1*" --exclude "ev1_cx*" --loglevel-only warning =
--filter "arg < 13"
UST events ev1* excluding ev1_cx* are enabled in channel channel0 for logle=
vel TRACE_WARNING (4) with filter 'arg < 13'
$ lttng list abcd
Tracing session abcd: [active]
[...]
    Events:
      ev1* excluding ev1_cx* (loglevel =3D=3D TRACE_WARNING (4)) (type: tra=
cepoint) [enabled] [with filter 'arg < 13']
      ev1* (loglevel <=3D TRACE_WARNING (4)) (type: tracepoint) [disabled]
      ev1* (loglevel =3D=3D TRACE_NOTICE (5)) (type: tracepoint) [disabled]
      ev1* (type: tracepoint) [enabled] [with filter 'arg > 12']
      ev1* excluding ev1_comp* (type: tracepoint) [enabled]
      ev1* (type: tracepoint) [disabled]
$ lttng disable-event -u "ev1*"
UST events ev1* excluding ev1_cx* are disabled in channel channel0 for logl=
evel TRACE_WARNING (4) with filter 'arg < 13'
UST events ev1* are disabled in channel channel0 with filter 'arg > 12'
UST events ev1* excluding ev1_comp* are disabled in channel channel0
$ lttng list abcd
Tracing session abcd: [active]
[...]
    Events:
      ev1* excluding ev1_cx* (loglevel =3D=3D TRACE_WARNING (4)) (type: tra=
cepoint) [disabled] [with filter 'arg < 13']
      ev1* (loglevel <=3D TRACE_WARNING (4)) (type: tracepoint) [disabled]
      ev1* (loglevel =3D=3D TRACE_NOTICE (5)) (type: tracepoint) [disabled]
      ev1* (type: tracepoint) [disabled] [with filter 'arg > 12']
      ev1* excluding ev1_comp* (type: tracepoint) [disabled]
      ev1* (type: tracepoint) [disabled]

   Clearly a lot of work needs to be done with the list command's reporting=
 of events: it needs to use a consistent format that accommodates the optio=
nal loglevel, loglevel-only, filter and exclude attributes.  And disable-ev=
ent, as long as it does not accept the loglevel, loglevel-only, filter and =
exclude command options, needs to report each disablement it effects (there=
 would be a warning only if there is nothing to disable).

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
