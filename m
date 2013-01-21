From: David Goulet <dgoulet@efficios.com>
Subject: Re: Odd dependency for lttng-ust
Date: Mon, 21 Jan 2013 10:53:24 -0500
Message-ID: <50FD6474.6070207__27894.3148012788$1358783649$gmane$org@efficios.com>
References: <3CA1A65C03C1A34C81BBC6272782E696987880@valcartierex01.valcartier.drdc-rddc.gc.ca>
	<20130121145954.GA1472@Krystal>
	<3CA1A65C03C1A34C81BBC6272782E696987887@valcartierex01.valcartier.drdc-rddc.gc.ca>
	<20130121152949.GB1912@Krystal>
	<3CA1A65C03C1A34C81BBC6272782E69698788F@valcartierex01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1TxJge-0003KD-J9
	for lttng-dev@lists.lttng.org; Mon, 21 Jan 2013 10:53:28 -0500
In-Reply-To: <3CA1A65C03C1A34C81BBC6272782E69698788F@valcartierex01.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: lttng-dev@lists.lttng.org, "Couture, Mario" <Mario.Couture@drdc-rddc.gc.ca>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Painchaud,
	Frederic" <Frederic.Painchaud@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

Also, I do still forget it still today but after installing URCU and UST:

$ sudo ldconfig

:)

David

Thibault, Daniel:
> -----Message d'origine-----
> De : Mathieu Desnoyers [mailto:mathieu.desnoyers@efficios.com] =

> Envoy=E9 : 21 janvier 2013 10:30
> =

> No. Distribution packages usually lag behind the project upstream.
> Ubuntu 12.04 has been released last year, and their policy don't allow th=
em to update the packages within this specific distribution version.
> =

> This is why you run into trouble when you try to mix distribution package=
s (from last year) with the current development head.
> =

> Don't mix packages from distributions with packages built from sources wh=
en version dependencies don't match. All the required dependency informatio=
n is found in the README files of each project.
> =

> Mathieu
> -----Fin du message d'origine-----
> =

> But I'm not mixing old packages with new: I tried fetching everything fro=
m git.lttng.org.  The README for lttng-ust reads in part:
> =

> PREREQUISITES:
>   - liburcu
>     Userspace RCU library, by Mathieu Desnoyers and Paul E. McKenney
>     -> This release depends on liburcu v0.7.2
>       * Debian/Ubuntu package: liburcu-dev
>       * Website:  http://lttng.org/urcu
>       * Releases: http://lttng.org/files/urcu
>       * GitWeb:   http://lttng.org/cgi-bin/gitweb.cgi?p=3Duserspace-rcu.g=
it;a=3Dsummary
>       * Git:      git://lttng.org/userspace-rcu.git
> =

> Doesn't this say that I can get the required liburcu from git.lttng.org's=
 userspace-rcu?  Could it be version 0.7.6 is not retro-compatible with 0.7=
.2 (that is to say, lttng-ust requires 0.7.2, and 0.7.2 only, not "0.7.2 or=
 later")?
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
> [Valcartier]\\vsi-wdut-o980, [Secteur-SI]\\edge
> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada / Government of Canada
> <http://www.valcartier.drdc-rddc.gc.ca/>
>  LinkedIn: <http://ca.linkedin.com/in/daniel-u-thibault/>
>  Research Gate: <https://www.researchgate.net/profile/Daniel_Thibault/>
> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
