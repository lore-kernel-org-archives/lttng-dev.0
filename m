From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: Odd dependency for lttng-ust
Date: Mon, 21 Jan 2013 14:34:29 -0500
Message-ID: <3CA1A65C03C1A34C81BBC6272782E6969878C8__23052.7887856171$1358796935$gmane$org@valcartierex01.valcartier.drdc-rddc.gc.ca>
References: <3CA1A65C03C1A34C81BBC6272782E696987880@valcartierex01.valcartier.drdc-rddc.gc.ca>
	<20130121145954.GA1472@Krystal>
	<3CA1A65C03C1A34C81BBC6272782E696987887@valcartierex01.valcartier.drdc-rddc.gc.ca>
	<20130121152949.GB1912@Krystal>
	<3CA1A65C03C1A34C81BBC6272782E69698788F@valcartierex01.valcartier.drdc-rddc.gc.ca>
	<50FD6474.6070207@efficios.com>
	<3CA1A65C03C1A34C81BBC6272782E6969878A7@valcartierex01.valcartier.drdc-rddc.gc.ca>
	<20130121170655.GA4268@Krystal>
	<3CA1A65C03C1A34C81BBC6272782E6969878AE@valcartierex01.valcartier.drdc-rddc.gc.ca>
	<20130121183846.GA6838@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1TxN8p-0005Db-Sq
	for lttng-dev@lists.lttng.org; Mon, 21 Jan 2013 14:34:47 -0500
Content-class: urn:content-classes:message
In-Reply-To: <20130121183846.GA6838@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, "Couture, Mario" <Mario.Couture@drdc-rddc.gc.ca>, "Painchaud, Frederic" <Frederic.Painchaud@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

-----Message d'origine-----
De=A0: Mathieu Desnoyers [mailto:mathieu.desnoyers@efficios.com] =

Envoy=E9=A0: 21 janvier 2013 13:39

As the error messages suggests, please try:
LDFLAGS=3D-L/usr/local/lib ./configure
instead of "./configure"

Mathieu
-----Fin du message d'origine-----

   Interesting, that prefix does allow configure to complete successfully. =
 lttng-tools runs into the same problem as lttng-ust, and requires the same=
 LDFLAGS prefix for its configure.  No other problems arise.

   So how do we fix userspace-rcu so the bootstrap -configure - make - inst=
all sequence doesn't run into this problem?  I'm presuming here that usersp=
ace-rcu's install needs to be touched up.  Or maybe lttng-ust's (and lttng-=
tools's) bootstrap.

   (It's a problem because the ReadMe for the lttng-ust and lttng-tools pac=
kages stipulate a plain ./configure invocation: as they currently stand, th=
e instructions fail)

Daniel U. Thibault
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) / Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
Cyber s=E9curit=E9 pour les missions essentielles (CME) / Mission Critical =
Cyber Security (MCCS)
Protection des syst=E8mes et contremesures (PSC) / Systems Protection & Cou=
ntermeasures (SPC)
2459 route de la Bravoure
Qu=E9bec, QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada / Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
