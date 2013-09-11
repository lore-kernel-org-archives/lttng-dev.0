From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: Enabling and disabling events
Date: Wed, 11 Sep 2013 14:04:22 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD2678EF0E__8153.92913432351$1378908324$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1VJl1q-0005lj-UL
	for lttng-dev@lists.lttng.org; Wed, 11 Sep 2013 10:04:28 -0400
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

> We keep the enable-event command as it is. However, we enhance the event =
name
> specification syntax somewhat. We could of course do a full regex matchin=
g, but I
> fear that would get too slow.  Instead we'd have something like
> =

> $ lttng enable-event -u "*!mine*!alsomine"
>
> This would enable any event ('*'), except those who match with mine* or a=
lsomine.
>
> The matching logic would separate the name specification into parts, usin=
g the
> ! character as a separator. If the new event name matches the first part =
but does
> not match any of the latter parts, then the event gets enabled.

   Simple enough.

> I don't like collating the event enablers into unified specifications. I'=
d like to have
> each enable-event command create its own entries into the enabler list. I=
 feel a
> bit uneasy if the event enabler code gets too sophisticated.
>
> I'm still unsure how the disable-event command should work. I'm playing a=
round
> with the idea that the event specification in the disable-event command s=
hould
> exactly match the event specification given in the enable-event command. =
It
> does not feel good, but any solution around it seems to bring about the i=
deas
> about disable-lists which I would like to avoid.
>
> JP Ikaheimonen | SW Development Engineer http://go.mentor.com/sourceryana=
lyzer

   We could do without a separate disabling list if you stick to the ! nota=
tion.  But some unification processing would need to be done.  For example =
(showing desirable user feedback):

$ lttng enable-event -u --all
All UST events are enabled (channel channel0, session session)
$ lttng list session
    Enabled Events:
      * (type: tracepoint)
$ lttng disable-event -u "mine*"
UST event mine* disabled (channel channel0, session session)
$ lttng list session
    Enabled Events:
      *!mine* (type: tracepoint)
$ lttng enable-event -u "min*"
UST event min* enabled (channel channel0, session session)
Exception removed from UST event * (channel channel0, session session)
$ lttng list session
    Enabled Events:
      * (type: tracepoint)
$ lttng disable-event -u "mine*"
UST event mine* disabled (channel channel0, session session)
Exception added to UST events (channel channel0, session session)
$ lttng list session
    Enabled Events:
      *!mine* (type: tracepoint)
$ lttng enable-event -u "miner*"
UST event miner* enabled (channel channel0, session session)
$ lttng list session
    Enabled Events:
      *!mine* (type: tracepoint)
      miner* (type: tracepoint)

   Note that the display uses "Enabled Events:" and drops the per-line "[en=
abled]" since "[disabled]" can never happen in this scheme.  (So-called Pru=
ssian approach: everything not expressly permitted is forbidden)

   The feedback for '$ lttng disable-event -u "mine*"' reads 'Exception add=
ed to UST events ...' because multiple exceptions could be added and we don=
't want the feedback to get too cluttered.

   In the last case ($ lttng enable-event -u "miner*"), assuming identifier=
s can use a..z, A..Z, 0..9 and _, we could have unified into something like:

$ lttng list session
    Enabled Events:
      *!mina*!minb*!minc*!mind*!minf*!ming*!minh*... (type: tracepoint) [en=
abled]

   But that would generate a huge enabling specification line (1+6*(25+26+1=
0+1) =3D 373 characters) which is not very user-friendly.  Keeping two rule=
s (ORed together, remember) is cleaner (and would be processed faster).

   Further use-case:

$ lttng list session
    Enabled Events:
      (none)
$ lttng disable-event -u "mine*"
Error: Event mine*: UST event not enabled (channel channel0, session sessio=
n), nothing to disable
Warning: Some command(s) went wrong
$ lttng list session
    Enabled Events:
      (none)

   And using ! with disable-event:

$ lttng enable-event -u --all
All UST events are enabled (channel channel0, session session)
$ lttng list session
    Enabled Events:
      * (type: tracepoint)
$ lttng disable-event -u "mine*!miner*"
UST event mine* disabled (channel channel0, session session)
UST event miner* enabled (channel channel0, session session)
$ lttng list session
    Enabled Events:
      *!mine* (type: tracepoint)
      miner* (type: tracepoint)

$ lttng enable-event -u "miners*"
UST event miners* is enabled (channel channel0, session session)
$ lttng list session
    Enabled Events:
      miners* (type: tracepoint)
$ lttng disable-event -u "mine*!miner*"
Error: Event mine*!miner*: UST event to disable matches exception, nothing =
to disable (channel channel0, session session)
Warning: Some command(s) went wrong
$ lttng list session
    Enabled Events:
      miners* (type: tracepoint)

   Note that exceptions to the disable-event argument serve only to maintai=
n existing enablements: disable-event a!b is not the same as disable-event =
a followed by enable-event b.  It should be read as "disable event a but do=
 not disable event b" (not disabling an event is not the same as enabling i=
t).

$ lttng list session
    Enabled Events:
      miners* (type: tracepoint)
$ lttng disable-event -u "mine*!min*"
Error: Event mine*!min*: Exception matches condition, nothing to disable (c=
hannel channel0, session session)
Warning: Some command(s) went wrong

   With filters, the filter field would remain attached to the rule and not=
hing else would change.  (Note that currently 'lttng list' cannot display t=
he filters that have been set so far)  Filters are also Prussian: of their =
three logical states (true, false, unknown), only the true state allows the=
 event to pass (unknown occurs if any part of the filter fails to bind to t=
he event's fields and context).

$ lttng enable-event -u provider:event --filter "intfield > 500"
Filter 'intfield > 500' successfully set for UST event provider:event (chan=
nel channel0, session session)
$ lttng list session
    Enabled Events:
      provider:event (type: tracepoint) [with filter 'intfield > 500']
$ lttng enable-event -u --all
All UST events are enabled (channel channel0, session session)
$ lttng list session
    Enabled Events:
      * (type: tracepoint)

   I think processing the list of rules is a must because it shows the user=
 precisely and concisely what is going to happen during his session.  Right=
 now, you can get a messy listing like this:

$ lttng list session
    Events:
      sample:event (type: tracepoint) [disabled]
      sample:event (type: tracepoint) [disabled] [with filter]
      sample:ev* (type: tracepoint) [enabled] [with filter]
      * (type: tracepoint) [enabled]

   The user can't figure out what is enabled and what is disabled unless he=
 remembers the rules are all ORed together.  He'll mentally boil the set of=
 rules down to just "* [enabled]", but a nasty suspicion will remain regard=
ing all those remaining disregarded rules.  Processing the list of rules to=
 its simplest expression at the time enable-event/disable-event is issued a=
lso saves processing later -whenever the daemon needs to figure out whether=
 a newly registered event should be traced or not- because it'll have fewer=
 rules to try out.

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
