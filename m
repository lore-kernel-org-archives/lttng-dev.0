From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttv] Add build instructions for git
	tree	pulls and use more standard formatting
Date: Thu, 8 Aug 2013 11:23:20 -0400
Message-ID: <20130808152320.GB26526__29594.1332624809$1375975468$gmane$org@Krystal>
References: <48CF5AC71E61DB46B70D0F388054EFFD26661385@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1V7S3e-0001VL-7H
	for lttng-dev@lists.lttng.org; Thu, 08 Aug 2013 11:23:27 -0400
Content-Disposition: inline
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD26661385@VAL-E-01.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, David Vomlehn <vomlehnd@amazon.com>
List-Id: lttng-dev@lists.lttng.org

* Thibault, Daniel (Daniel.Thibault@drdc-rddc.gc.ca) wrote:
> ------------------------------
> Date: Wed, 7 Aug 2013 12:48:53 -0700
> From: Vomlehn <vomlehnd@amazon.com>
> =

> -- ./configure
> -- make
> -- make install
> +  $ ./configure
> +  $ make
> +  $ make install
> +
> +To compile the source tree from a git checkout, use:
> +
> +  $ autoreconf
> +  $ automake --add-missing --gnu
> +  $ make
> +  $ make install
>  =

>  After running ./configure, you can also go in specific subdirectories and
>  use make, make install.
> ------------------------------
> =

>    Actually, in each instance of 'make install', you'll need to use 'sudo=
 make install'.

(as root)
# make install

would be the proper way to document this.

sudo is just one way to gain root privileges. "su" can be used on many
distributions for this too. Also, if a configure --prefix is used to
target a user-writeable directory, root is not required (but it's
generally not the case).

Thanks,

Mathieu


> =

> Daniel U. Thibault
> Protection des syst=E8mes et contremesures (PSC) | Systems Protection & C=
ountermeasures (SPC)
> Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critica=
l Cyber Security (MCCS)
> R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R=
&D Canada - Valcartier (DRDC Valcartier)
> 2459 route de la Bravoure
> Qu=E9bec QC  G3J 1X5
> CANADA
> Vox : (418) 844-4000 x4245
> Fax : (418) 844-4538
> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada | Government of Canada
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
