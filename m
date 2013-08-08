From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools]
	Fix:	LTTNG_ERR_NEED_ROOT_SESSIOND error message
Date: Thu, 8 Aug 2013 11:21:35 -0400
Message-ID: <20130808152135.GA26526__21224.1138717674$1375975368$gmane$org@Krystal>
References: <48CF5AC71E61DB46B70D0F388054EFFD26661377@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1V7S1w-0001Mu-Qf
	for lttng-dev@lists.lttng.org; Thu, 08 Aug 2013 11:21:42 -0400
Content-Disposition: inline
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD26661377@VAL-E-01.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* Thibault, Daniel (Daniel.Thibault@drdc-rddc.gc.ca) wrote:
> ------------------------------
> Date: Wed,  7 Aug 2013 14:58:05 -0400
> From: J?r?mie Galarneau 	<jeremie.galarneau@efficios.com>
> =

> A root session daemon _and_ "tracing" group user membership are required =
to trace the kernel.
> =

> ---
>  src/common/error.c | 2 +-
> =

> -	[ ERROR_INDEX(LTTNG_ERR_NEED_ROOT_SESSIOND) ] =3D "Tracing the kernel r=
equires a root lttng-sessiond daemon or \"tracing\" group user membership",
> +	[ ERROR_INDEX(LTTNG_ERR_NEED_ROOT_SESSIOND) ] =3D "Tracing the kernel r=
equires a root lttng-sessiond daemon and \"tracing\" group user membership",
> =

>    Unless there's been a change in the code, that is just not true.  You =
can trace the kernel just fine without 'tracing' group membership, as long =
as you have sudo privileges (and can thus call 'sudo -H lttng').  The root =
daemon is necessary either way: the text should just read "Tracing the kern=
el requires a root lttng-sessiond daemon".

The actual right way to word it would be:

Tracing the kernel requires a root lttng-sessiond daemon, as well as \"trac=
ing\"
group membership or root user ID for the lttng client.

Makes sense ?

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
