From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: lttng-ust works
Date: Tue, 14 Jan 2014 20:10:33 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD267D75E0__41309.7963239581$1389730299$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1W3AJr-0008JK-59
	for lttng-dev@lists.lttng.org; Tue, 14 Jan 2014 15:10:44 -0500
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

> Trail 2:
> =3D=3D=3D=3D=3D=3D=3D=3D
> [...]
> lttng@/ # lttng -g lttng create as
> Session as created.
> Traces will be written in /home/lttng/lttng-traces/as-20131224-123811
> lttng@/ # lttng -g lttng enable-event -k -u -a
> All kernel events are enabled in channel channel0

   This is the culprit.  "lttng enable-event -k -u -a" will *only* enable t=
he kernel events (the -k switch pre-empts the -u switch).  To enable kernel=
 and user-space events, you must do two separate enable-event commands:

lttng@/ # lttng enable-event -k -a
lttng@/ # lttng enable-event -u -a

> Trail 3:
> =3D=3D=3D=3D=3D=3D=3D=3D
> [...]
> lttng@/ # lttng -g lttng create appses
> Session appses created.
> Traces will be written in /home/lttng/lttng-traces/appses-20131224-124354
> lttng@/ # lttng -g lttng enable-event -u -a
> All UST events are enabled in channel channel0
> lttng@/ # lttng -g lttng start
> Tracing started for session appses
> [...]
> The userspace trace files are generated
> No kernel traces are generated

   No kernel trace is generated because you did not enable any kernel event=
s.

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
