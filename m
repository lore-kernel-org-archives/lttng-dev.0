From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Odd dependency for lttng-ust
Date: Mon, 21 Jan 2013 13:38:46 -0500
Message-ID: <20130121183846.GA6838__48687.1399255053$1358793577$gmane$org@Krystal>
References: <3CA1A65C03C1A34C81BBC6272782E696987880@valcartierex01.valcartier.drdc-rddc.gc.ca>
	<20130121145954.GA1472@Krystal>
	<3CA1A65C03C1A34C81BBC6272782E696987887@valcartierex01.valcartier.drdc-rddc.gc.ca>
	<20130121152949.GB1912@Krystal>
	<3CA1A65C03C1A34C81BBC6272782E69698788F@valcartierex01.valcartier.drdc-rddc.gc.ca>
	<50FD6474.6070207@efficios.com>
	<3CA1A65C03C1A34C81BBC6272782E6969878A7@valcartierex01.valcartier.drdc-rddc.gc.ca>
	<20130121170655.GA4268@Krystal>
	<3CA1A65C03C1A34C81BBC6272782E6969878AE@valcartierex01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TxMGg-0004jA-0V
	for lttng-dev@lists.lttng.org; Mon, 21 Jan 2013 13:38:50 -0500
Content-Disposition: inline
In-Reply-To: <3CA1A65C03C1A34C81BBC6272782E6969878AE@valcartierex01.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: lttng-dev@lists.lttng.org, "Couture, Mario" <Mario.Couture@drdc-rddc.gc.ca>, "Painchaud, Frederic" <Frederic.Painchaud@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

* Thibault, Daniel (Daniel.Thibault@drdc-rddc.gc.ca) wrote:
> -----Message d'origine-----
> De=A0: Mathieu Desnoyers [mailto:mathieu.desnoyers@efficios.com] =

> Envoy=E9=A0: 21 janvier 2013 12:07
> =

> > Even though libuuid1 (includes libuuid-perl, uuid-dev, uuid-runtime) is=
 installed.  I need to fix this new stumbling block before we can address t=
he liburcu-cds problem.
> =

> Please provide the complete output of:
> dpkg -l
> on your system. (it is rather long, please attach it to an email)
> =

> Mathieu
> -----Fin du message d'origine-----
> =

>    Concerning the uuid problem, uuid-dev had not been installed; it needs=
 to be specified separately from libuuid1.  Now lttng-ust's configure ends =
with:
> =

> checking for uuid_generate in -luuid... yes
> checking for inline... inline
> checking for stdlib.h... (cached) yes
> checking for GNU libc compatible malloc... yes
> checking for gettimeofday... yes
> checking for munmap... yes
> checking for socket... yes
> checking for strerror... yes
> checking for strtol... yes
> checking for sched_getcpu... yes
> checking for sysconf... yes
> checking urcu-bp.h usability... yes
> checking urcu-bp.h presence... yes
> checking for urcu-bp.h... yes
> checking for _cds_lfht_new in -lurcu-cds... no
> configure: error: Cannot find
> liburcu-cds lib, part of Userspace RCU 0.7 or better. Use LDFLAGS=3D-Ldir=
 to specify its location.

As the error messages suggests, please try:

LDFLAGS=3D-L/usr/local/lib ./configure

instead of "./configure"

Thanks,

Mathieu

> =

>    dpkg -l output attached.
> =

> Daniel U. Thibault
> R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) / Defence R=
&D Canada - Valcartier (DRDC Valcartier)
> Cyber s=E9curit=E9 pour les missions essentielles (CME) / Mission Critica=
l Cyber Security (MCCS)
> Protection des syst=E8mes et contremesures (PSC) / Systems Protection & C=
ountermeasures (SPC)
> 2459 route de la Bravoure
> Qu=E9bec, QC  G3J 1X5
> CANADA
> Vox : (418) 844-4000 x4245
> Fax : (418) 844-4538
> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada / Government of Canada
> <http://www.valcartier.drdc-rddc.gc.ca/>


> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- =

Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
