From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: multiple tracing sessions using relayd
Date: Wed, 12 Nov 2014 14:43:46 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD6FBC587C__39482.6362412006$1415803480$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1XoZ9L-0006Xq-6u
 for lttng-dev@lists.lttng.org; Wed, 12 Nov 2014 09:44:00 -0500
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Cc: Anand Neeli <anand.neeli@gmail.com>
List-Id: lttng-dev@lists.lttng.org

> Date: Mon, 10 Nov 2014 13:02:58 -0500
> From: J?r?mie Galarneau <jeremie.galarneau@efficios.com>
> To: Anand Neeli <anand.neeli@gmail.com>
>
> > I tried to create same without relayd and it works. Am i missing =

> > anything here?
> >
> > Although in the above example i'm enabling same/all events in session1 =

> > and session2, but i think this should work and capture same events in =

> > both the sessions.
>
> That's the expected behaviour.
>
> J=E9r=E9mie

   With one very important caveat: the copies of the events in each session=
 will most likely bear different timestamps.  That's because the timestamps=
 capture the moments at which the event data slots are reserved in the cons=
umer buffers.

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC)
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)
RDDC - Centre de recherches de Valcartier | DRDC - Valcartier Research Cent=
re
2459 route de la Bravoure
Qu=E9bec QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada | Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
 LinkedIn: <http://ca.linkedin.com/in/daniel-u-thibault/>
 Research Gate: <https://www.researchgate.net/profile/Daniel_Thibault/>
