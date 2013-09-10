From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: Request information on "Live" view of traces
Date: Tue, 10 Sep 2013 16:39:24 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD2678EC98__13844.6661913351$1378831224$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1VJQyK-00059m-Uw
	for lttng-dev@lists.lttng.org; Tue, 10 Sep 2013 12:39:30 -0400
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

Date: Tue, 10 Sep 2013 11:28:53 -0400
From: Julien Desfossez <jdesfossez@efficios.com>

> > -----Message d'origine-----
> > The live trace reading mechanism offers guarantees that the viewer can =
never be in a position where it has to assume that it can read the trace sa=
fely. =

> > ------------------------------
>
> There are two risks when reading an active trace : reading a trace withou=
t the complete metadata, and assuming a stream is inactive.
>
> If the viewer tries to read a trace for which it does not have the full m=
etadata (which is not known during normal tracing), it risks to crash readi=
ng the trace. The live trace reading
> feature prevents the viewer from getting trace packets if there is new me=
tadata appended between two packets read.
>
> Also, if a stream is inactive, usually the viewer would have to wait unti=
l it is active again to continue processing the trace. The live trace readi=
ng feature informs the viewer that it can
> safely consider a stream inactive up to a certain point in time. That way=
, it can continue to process the trace without waiting indefinitely for an =
inactive stream. The live-timer
> parameter, configured during the session creation by the user, defines th=
e sending rate of these inactivity beacons.
>
> I hope it clarifies the situation.
>
> Julien

   Then maybe what should have been said is:

The live trace reading mechanism offers guarantees that the viewer can neve=
r be in a position where it cannot read the trace safely.

   Right?

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
