From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Enabling and disabling events
Date: Fri, 6 Sep 2013 21:11:50 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD2678D70B__46023.6784340397$1378502076$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1VI3LS-0004C7-WA
	for lttng-dev@lists.lttng.org; Fri, 06 Sep 2013 17:13:40 -0400
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

   Suppose we do something like this (edited for brevity):

$ lttng enable-event -u sample:message --loglevel notice
$ lttng list session
Events:
  sample:message (loglevel: TRACE_NOTICE (5)) [enabled]
$ lttng disable-event -u sample:message
$ lttng list session
Events:
  sample:message (loglevel: TRACE_NOTICE (5)) [disabled]
$ lttng enable-event -u sample:message
$ lttng list session
Events:
  sample:message [enabled]
  sample:message (loglevel: TRACE_NOTICE (5)) [disabled]
$ lttng enable-event -u sample:message --loglevel err
$ lttng list session
Events:
  sample:message [enabled]
  sample:message (loglevel: TRACE_NOTICE (5)) [disabled]
  sample:message (loglevel: TRACE_ERR (3)) [enabled]

This could be understood to mean that sample:message will be logged unless =
its loglevel lies in the TRACE_WARNING (4) to TRACE_NOTICE (5) range.  But =
that is not what lttng is doing: it looks up all the rules which match the =
candidate event, then ORs the results together.  (Two rules are different i=
f their string key or loglevel setting are different; currently lttng treat=
s a loglevel-only setting as it it matched the corresponding loglevel setti=
ng)  So in this case there is no way that sample:message could not be logge=
d, since the first "rule" (i.e. sample:message [enabled]) trumps the others.

Wouldn't it be much clearer if the enable-event command did some clean up i=
n the list of rules?  The previous use case would then become:

$ lttng enable-event -u sample:message --loglevel notice
$ lttng list session
Events:
  sample:message (loglevel: TRACE_NOTICE (5)) [enabled]
$ lttng disable-event -u sample:message
$ lttng list session
Events:
  sample:message (loglevel: TRACE_NOTICE (5)) [disabled]
$ lttng enable-event -u sample:message
$ lttng list session
Events:
  sample:message [enabled]
$ lttng enable-event -u sample:message --loglevel err
$ lttng list session
Events:
  sample:message [enabled]

In other words, we have a partial ordering on the loglevel key that goes:
LTTNG_EVENT_LOGLEVEL_ALL > LTTNG_EVENT_LOGLEVEL_RANGE(m),
LTTNG_EVENT_LOGLEVEL_ALL > LTTNG_EVENT_LOGLEVEL_SINGLE(n),
LTTNG_EVENT_LOGLEVEL_RANGE(m) > LTTNG_EVENT_LOGLEVEL_SINGLE(n) if m>=3Dn

It is tempting to extend the partial ordering to the text key, but I think =
we then need to change the interpretation of the rules from a simple "OR":

$ lttng enable-event -u "sample:mes*"
$ lttng list session
Events:
  sample:mes* [enabled]
$ lttng enable-event -u sample:message
$ lttng list session
Events:
  sample:mes* [enabled]
$ lttng disable-event -u sample:message
$ lttng list session
Events:
  sample:mes* [enabled]
  sample:message [disabled]

The user's wish of "enabling sample:mes* except for sample:message" would b=
e achieved if the daemon treated the disabling rules as having priority ove=
r the enabling ones.  Instead of having a single list with each list entry =
having an enabled/disabled attribute, the daemon would need to maintain two=
 lists, one for enabling rules, the other for disabling rules (and the list=
 entries of both lists would be attribute-less).

This approach would dovetail nicely with the proposed exclusion special cha=
racter (!).  A command like:

$ lttng enable-event -u "sample:mes*" "!sample:message"

Would readily be resolved as an entry in each list.

But then how could we deal with:

$ lttng disable-event -u "sample:mes*" "!sample:message"

(In other words, "disabling sample:mes* except for sample:message")  Maybe =
we'd need two sets of disabling rules: a weak one (enabling rules have prio=
rity) and a strong one (enabling rules don't have priority).  Although that=
 could still be reasonably understandable when displayed with 'lttng list s=
ession' if the rules were presented in three ordered blocks (strong disabli=
ng rules, enabling rules, weak disabling rules), I suspect the scheme is ge=
tting too complex.

This needs more thought.   :-)

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC)
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
2459 route de la Bravoure
Qu=E9bec QC=A0 G3J 1X5
CANADA
Vox=A0: (418) 844-4000 x4245
Fax=A0: (418) 844-4538
NAC=A0: 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada=A0| Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
