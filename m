From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Automating lttng-sessiond startup
Date: Tue, 22 Jan 2013 16:51:14 -0500
Message-ID: <20130122215114.GA30918__46041.1175540232$1358891525$gmane$org@Krystal>
References: <3CA1A65C03C1A34C81BBC6272782E69698797F@valcartierex01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TxlkU-000147-V6
	for lttng-dev@lists.lttng.org; Tue, 22 Jan 2013 16:51:19 -0500
Content-Disposition: inline
In-Reply-To: <3CA1A65C03C1A34C81BBC6272782E69698797F@valcartierex01.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: lttng-dev@lists.lttng.org, "Couture, Mario" <Mario.Couture@drdc-rddc.gc.ca>, =?iso-8859-1?Q?Painchaud=2C_Fr=E9d=E9ric?= <Frederic.Painchaud@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

We plan to put these init scripts into extras/ within lttng-tools at
some point, with appropriate documentation.

This part of the install process is rather hard to automate nowadays,
since every distribution has its own init system (upstrart, initrd,
others).

Thanks,

Mathieu

* Thibault, Daniel (Daniel.Thibault@drdc-rddc.gc.ca) wrote:
>    To answer my own earlier question, the Ubuntu lttng packages (but not =
the git.lttng.org packages) automate the launch of the lttng-sessiond daemo=
n through the Upstart service, by adding /etc/init/lttng-sessiond.conf:
> =

> description "LTTng 2.0 central tracing registry session daemon"
> author "St=E9phane Graber <stgraber@ubuntu.com>"
> start on local-filesystems
> stop on runlevel [06]
> respawn
> exec lttng-sessiond
> =

>    You need only create this file (as root) to have the git.lttng.org LTT=
ng installation on a par with the Ubuntu packages'.
> =

> Daniel U. Thibault
> R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) / Defence R=
&D Canada - Valcartier (DRDC Valcartier)
> Cyber s=E9curit=E9 pour les missions essentielles (CME) / Mission Critica=
l Cyber Security (MCCS)
> Protection des syst=E8mes et contremesures (PSC) / Systems Protection & C=
ountermeasures (SPC)
> 2459 route de la Bravoure
> Qu=E9bec, QC=A0 G3J 1X5
> CANADA
> Vox=A0: (418) 844-4000 x4245
> Fax=A0: (418) 844-4538
> NAC=A0: 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada=A0/ Government of Canada
> <http://www.valcartier.drdc-rddc.gc.ca/>
> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- =

Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
