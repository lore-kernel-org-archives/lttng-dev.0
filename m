From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: User-space tracing by the root lttng-sessiond
Date: Tue, 14 May 2013 13:21:03 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD12D1210D__5543.0031884045$1368537762$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
References: <48CF5AC71E61DB46B70D0F388054EFFD12D1201A@VAL-E-02.valcartier.drdc-rddc.gc.ca>
	<20130514070545.GA5213@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1UcFBA-0001eh-HH
	for lttng-dev@lists.lttng.org; Tue, 14 May 2013 09:22:08 -0400
In-Reply-To: <20130514070545.GA5213@Krystal>
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "Couture,
	Mario" <Mario.Couture@drdc-rddc.gc.ca>, "Painchaud,
	Frederic" <Frederic.Painchaud@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

> >  (Question: If there were several users active at once, would there be =

> > several root user-space lttng-consumerd daemons or still just one?)
>
> no

   Please clarify: no, there will be several root user-space lttng-consumer=
d daemons or no, there will be just one root user-space lttng-consumerd dae=
mon?

> >    This seems problematic to me, since multiple traces capturing the sa=
me event won't be able to reconcile their copies with each other.
>
> since timestamps have to match the event physical order in the streams, w=
e need to assign one timestamp for each buffer. no way around this.

   Are the time-stamps issued by the tracepoint provider or by the "buffer =
registrar" (i.e. the time-stamp is looked up when the event is written to t=
he buffer)?

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
