From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Odd dependency for lttng-ust
Date: Mon, 21 Jan 2013 10:29:49 -0500
Message-ID: <20130121152949.GB1912__28055.5991492749$1358782719$gmane$org@Krystal>
References: <3CA1A65C03C1A34C81BBC6272782E696987880@valcartierex01.valcartier.drdc-rddc.gc.ca>
	<20130121145954.GA1472@Krystal>
	<3CA1A65C03C1A34C81BBC6272782E696987887@valcartierex01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TxJJm-00034A-Ua
	for lttng-dev@lists.lttng.org; Mon, 21 Jan 2013 10:29:51 -0500
Content-Disposition: inline
In-Reply-To: <3CA1A65C03C1A34C81BBC6272782E696987887@valcartierex01.valcartier.drdc-rddc.gc.ca>
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
> Quoting the lttng-tools README file:
> "    - liburcu
>       Userspace RCU library, by Mathieu Desnoyers and Paul E. McKenney
>       -> Tested with liburcu >=3D v0.7.2"
> =

> Therefore you need to install Userspace RCU 0.7.2 or later.
> A dependency is not only on a package, but also on a range of versions.
> =

> Mathieu
> -----Fin du message d'origine-----
> =

>    But shouldn't the userspace RCU library be installed by the
>    userspace-rcu package?  That's the gist of my puzzlement.  By the
>    time I get to lttng-ust's configure, I've installed lttng-modules
>    and userspace-rcu.  Doing an install of git.lttng.org's
>    userspace-rcu should be equivalent to installing the liburcu-dev
>    package from repository, no?

No. Distribution packages usually lag behind the project upstream.
Ubuntu 12.04 has been released last year, and their policy don't allow
them to update the packages within this specific distribution version.

This is why you run into trouble when you try to mix distribution
packages (from last year) with the current development head.

Don't mix packages from distributions with packages built from sources
when version dependencies don't match. All the required dependency
information is found in the README files of each project.

Thanks,

Mathieu

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

-- =

Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
