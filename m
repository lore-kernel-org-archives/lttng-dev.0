From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Odd dependency for lttng-ust
Date: Mon, 21 Jan 2013 12:06:55 -0500
Message-ID: <20130121170655.GA4268__21664.4498556436$1358788067$gmane$org@Krystal>
References: <3CA1A65C03C1A34C81BBC6272782E696987880@valcartierex01.valcartier.drdc-rddc.gc.ca>
	<20130121145954.GA1472@Krystal>
	<3CA1A65C03C1A34C81BBC6272782E696987887@valcartierex01.valcartier.drdc-rddc.gc.ca>
	<20130121152949.GB1912@Krystal>
	<3CA1A65C03C1A34C81BBC6272782E69698788F@valcartierex01.valcartier.drdc-rddc.gc.ca>
	<50FD6474.6070207@efficios.com>
	<3CA1A65C03C1A34C81BBC6272782E6969878A7@valcartierex01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TxKpl-00040F-IV
	for lttng-dev@lists.lttng.org; Mon, 21 Jan 2013 12:06:57 -0500
Content-Disposition: inline
In-Reply-To: <3CA1A65C03C1A34C81BBC6272782E6969878A7@valcartierex01.valcartier.drdc-rddc.gc.ca>
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
> De=A0: David Goulet [mailto:dgoulet@efficios.com] =

> Envoy=E9=A0: 21 janvier 2013 10:53
> =

> Also, I do still forget it still today but after installing URCU and UST:
> =

> $ sudo ldconfig
> =

> David
> -----Fin du message d'origine-----
> =

>    But 'sudo make install' invokes 'ldconfig -n /usr/local/lib'...
> =

>    Tried again, without fetching liburcu-dev from the LTTng PPA.  The pac=
kages added to the basic Ubuntu 12.04 install are:
> =

> automake        1:1.11.3-1ubuntu2
> binutils-gold    2.22-6ubuntu1
> bison                  1:2.5.dsfg-2.1
> flex                     2.5.35-10ubuntu3
> libpopt-dev     1.16-3ubuntu1
> libtool                2.4.2-1ubuntu1
> libuuid1             2.20.1-1ubuntu3
> python-dev     2.7.3-0ubuntu2
> swig2.0              2.0.4+really2.0.4-4ubuntu2
> linux-headers-3.2.0-36-virtual
> texinfo               4.13a.dfsg.1-8ubuntu2
> g++                      4:4.6.3-1ubuntu5
> =

> This time I did sudo ldconfig after each install (both commands had nothi=
ng to say).  After making and installing lttng-modules and userspace-rcu su=
ccessfully, lttng-ust's configure fails about a dozen checks earlier than t=
he liburcu-cds check with:
> =

> checking for uuid_generate in -luuid... no
> checking for uuid_create in -lc... no
> configure: error: Cannot find libuuid uuid_generate nor libc uuid_create.=
 Use LDFLAGS=3D-Ldir to specify their location.
> =

> Even though libuuid1 (includes libuuid-perl, uuid-dev, uuid-runtime) is i=
nstalled.  I need to fix this new stumbling block before we can address the=
 liburcu-cds problem.

Please provide the complete output of:

dpkg -l

on your system. (it is rather long, please attach it to an email)

Thanks,

Mathieu

> =

> Logs available.
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
