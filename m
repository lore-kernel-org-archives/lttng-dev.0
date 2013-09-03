From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: How to disable an event that's been enabled by a
 wildcard selection or -a? (lttng-dev Digest, Vol 64, Issues 30, 38)
Date: Tue, 3 Sep 2013 15:05:45 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD2678BEB2__25470.3407561921$1378220823$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1VGsAs-0002PK-KQ
	for lttng-dev@lists.lttng.org; Tue, 03 Sep 2013 11:05:52 -0400
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

----------------------------------------------------------------------
> Date: Fri, 16 Aug 2013 12:08:56 +0000
>
> A question on the suggested feature below:
>
> If we do the following set of commands:
>
> lttng enable-event "a*" -u
> lttng enable-event "!ab" -u
>
> The intention is to enable all events starting with the letter 'a' except=
 the event 'ab'.
> However, if the event 'ab' is already registered in the session, the firs=
t command would enable the event 'ab'.
>
> Should the second command now disable the event 'ab', or should the comma=
nd only apply to future registrations of events ?
>
> JP Ikaheimonen
> Mentor Graphics
----------------------------------------------------------------------

   The second command should definitely disable event 'ab'.  Otherwise the =
effect of any given command sequence becomes undefined because the system i=
s 'too stateful'.

----------------------------------------------------------------------
> Date: Tue, 20 Aug 2013 11:27:46 +0200
>
> If that is the intention, then it would be better to specify the commands=
 in reverse order:
>
> # lttng enable-event "!ab" -u
> # lttng enable-event "a*" -u
>
> or even better:
>
> # lttng enable-event "!ab" "a*" -u
>
> > However, if the event 'ab' is already registered in the session, the fi=
rst command would enable the event 'ab'.
> > Should the second command now disable the event 'ab', or should the com=
mand only apply to future registrations of events ?
>
> That is exactly what would happen in an *active* *session* if you issue
> the commands in the order you originally suggested.
> Incoming events matching "a*" are recorded up to the point where 'lttng
> enable-event "!ab"' is executed. From then on,  'ab'-events are excluded
> from recording.
>
> Paul Woegerer, SW Development Engineer
----------------------------------------------------------------------

   It makes little sense to me that the sequence:

# lttng enable-event "!ab" -u
# lttng enable-event "a*" -u

should "enable all events except 'ab'"  (the original intent).  There would=
 be no way of ever turning 'ab' back on, unless the command treated the wil=
d card differently from its equivalent expansion.  To illustrate my point, =
assume the alphabet consists of just {a, b, c}; then "a*" expands to "aa", =
"ab", "ac", "aaa", "aab", etc.  Issuing the command with the "a*" argument =
or its equivalent expansion (which is possible here since event names are l=
ength-limited) should yield the same result.

I note that the "!" special character was not used in older versions of ena=
ble-event, leading to limited backward compatibility of this new interface =
convention.  Is the intent to remove the disable-event command entirely?

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
