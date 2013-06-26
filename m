From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: [RELEASE] LTTng Tools 2.2.0 - Cuda (STABLE)
Date: Wed, 26 Jun 2013 20:33:30 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD131437FB__48319.7868489244$1372278848$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
References: <48CF5AC71E61DB46B70D0F388054EFFD131436D4@VAL-E-02.valcartier.drdc-rddc.gc.ca>
	<20130626124914.GA28225@Krystal> <20130626145505.GB30675@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1UrwPD-0001XU-W8
	for lttng-dev@lists.lttng.org; Wed, 26 Jun 2013 16:33:32 -0400
In-Reply-To: <20130626145505.GB30675@Krystal>
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

-----Message d'origine-----
Per UID buffers makes every application sharing the same UID to use the sam=
e buffers.
[...]
Also, the buffers for UST application are now created in the consumer and p=
assed to the application. Thus, the buffer ownership has been transfered fr=
om the UST tracer to the consumer.
-----Fin du message d'origine-----

   So what David really meant was:

Also, the per-PID buffers for UST application are now created in the consum=
er and passed to the application. Thus, the buffer ownership has been trans=
ferred from the UST tracer to the consumer in the per-PID case.

   And I presume the per-UID buffers remain owned by the user-space-servici=
ng root consumer daemon?

   When lttng is being run as an unprivileged user (and can thus trace only=
 user-space), setting the buffering scheme to per-UID would mean the trace =
uid folder would have just one subfolder, the unprivileged user's uid (e.g.=
 $HOME/lttng-traces/session-20130611-1223344/ust/uid/1000/64-bit), right?  =
I also presume the uid used is the real uid (ruid)?

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
[Valcartier]\\vsi-wdut-o980, [Valcartier]\\edge
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada | Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
