From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: Questions about JUL (was: Re:  lttng-dev Digest,
 Vol 67, Issue 48)
Date: Tue, 4 Feb 2014 18:59:02 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD267DE218__39521.2919720963$1391540424$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1WAlDC-0000jO-F4
	for lttng-dev@lists.lttng.org; Tue, 04 Feb 2014 13:59:15 -0500
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
Date: Tue, 4 Feb 2014 12:17:36 -0500
From: David Goulet <dgoulet@efficios.com>
To: Jim Dumont <jim.dumont@ericsson.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>

>> 3) add-context: does --jul have the same possible context types as --use=
rspace (i.e. ip, pthread_id, procname, vpid, vtid)?
>
> Nope.

   What are the possible context types then?  Or is it just that you can't =
apply a filter to a jul event?

>> 4) enable-channel:
>> 4.1) Are the --jul --subbuf-size, --num-subbuf and --read-timer defaults=
 the same as with --userspace?
>
> Nope. JUL uses it's internal channel so basically enable channel does NOT=
 support the jul domain thus not having -j in the help/man.

   So you turn jul events on and off using enable/disable-event --all inste=
ad?  This is getting a tad confusing: jul events force you to use only enab=
le/disable-event but kernel syscalls force you to use only enable/disable-c=
hannel...

>> 4.4) If yes, won't they all degenerate to the virtual machine's user and=
 process IDs?
>
> Not sure I understand this one?

   A Java application is interpreted and runs in a Java virtual machine (JV=
M).  The userID and processID of any jul events are thus likely to be those=
 of the JVM process.  I would expect Java apps launched by separate users t=
o launch separate JVM instances, but I would also expect two separate Java =
apps launched by the same user to share a single JVM (the user's) and, ther=
efore, their process IDs.  This could get fun with multi-threaded Java apps.

> Now after answering all this, I feel like either creating a lttng-jul man=
 page or adding a special section in "lttng.1" for the JUL domain explainin=
g all this. Thoughts?

   We definitely need an additional section in "lttng.1".

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
