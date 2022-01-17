Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8250AC433EF
	for <lttng-dev@archiver.kernel.org>; Mon, 17 Jan 2022 15:03:17 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4JcwBr5cJfzJ00;
	Mon, 17 Jan 2022 10:03:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1642431796;
	bh=lM3kAUrv7MYgD8q3DWdvuL948F0qbECUwysTlvuzCB4=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=cp/p+z9OfT4zmvnAIFBcCSdEvY+TytQU4KXxACLmA/fWrprJGaLyQSKmhFctErPVD
	 rtULTyhZTkPg+QCdJA978RRQK5ENfktumm2Kx+FPulwssFpV9SSiv0j89OEaAd/dFr
	 LuDblLAD7mggCmxiqwOhh3JD+EcGfS3mTeOe4pMxupybEm10rWpOL0jL1UV5QQrhfQ
	 Z3DLP1wlMDSeSRP3B4zGYS7qAhmgXDq3zvqyms2D+7EhKSb1H7GXF0wd/PnAGaWb58
	 LTcMgL20SQ2o3YZw7SRfb5oJ8+3JaquJ/CTonBi62maYjV4Hgd6JRTfHv9sTfOS5tj
	 xned2YV9bUisQ==
Received: from albert.ini-tech.com (ns542098.ip-144-217-255.net
 [144.217.255.55])
 by lists.lttng.org (Postfix) with ESMTPS id 4JcwBp3RHKzHW8
 for <lttng-dev@lists.lttng.org>; Mon, 17 Jan 2022 10:03:14 -0500 (EST)
Received: from smtp.ev0ke.net (unknown [10.2.3.24])
 by albert.ini-tech.com (Postfix) with ESMTP id 70452D177;
 Mon, 17 Jan 2022 15:03:14 +0000 (UTC)
Date: Mon, 17 Jan 2022 10:03:00 -0500
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
Message-ID: <20220117150300.76yvbpqmnwil6idk@raoul>
References: <20220114201409.24705-1-mathieu.desnoyers@efficios.com>
In-Reply-To: <20220114201409.24705-1-mathieu.desnoyers@efficios.com>
Subject: Re: [lttng-dev] [PATCH lttng-ust] Copyright ownership transfer
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.35
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: David Goulet via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: David Goulet <dgoulet@ev0ke.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3459529183052897191=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>


--===============3459529183052897191==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="q5y3auqos4ko36ga"
Content-Disposition: inline


--q5y3auqos4ko36ga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 14 Jan (15:14:09), Mathieu Desnoyers wrote:
> Apply copyright ownership transfer from David Goulet and Julien Desfossez
> to EfficiOS Inc.
>=20
> Link: https://lists.lttng.org/pipermail/lttng-dev/2022-January/030087.html
> Link: https://lists.lttng.org/pipermail/lttng-dev/2022-January/030092.html
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: David Goulet <dgoulet@ev0ke.net>
> Cc: Julien Desfossez <ju@klipix.org>
> Change-Id: Ibc6bb52296406e68466d44ae991a7ab70134dd76
> ---
>  include/lttng/ust-ctl.h            | 2 +-
>  include/lttng/ust-error.h          | 3 +--
>  src/common/ustcomm.c               | 2 +-
>  src/common/ustcomm.h               | 3 +--
>  src/common/utils.c                 | 2 +-
>  src/lib/lttng-ust-ctl/ustctl.c     | 2 +-
>  src/lib/lttng-ust/lttng-ust-comm.c | 2 +-
>  src/lib/lttng-ust/strerror.c       | 2 +-
>  8 files changed, 8 insertions(+), 10 deletions(-)
>=20
> diff --git a/include/lttng/ust-ctl.h b/include/lttng/ust-ctl.h
> index 360bb09a..25e588b3 100644
> --- a/include/lttng/ust-ctl.h
> +++ b/include/lttng/ust-ctl.h
> @@ -1,7 +1,7 @@
>  /*
>   * SPDX-License-Identifier: GPL-2.0-only
>   *
> - * Copyright (C) 2011 Julien Desfossez <julien.desfossez@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2011-2013 Mathieu Desnoyers <mathieu.desnoyers@efficios=
=2Ecom>
>   */
> =20
> diff --git a/include/lttng/ust-error.h b/include/lttng/ust-error.h
> index 543c894a..49045bab 100644
> --- a/include/lttng/ust-error.h
> +++ b/include/lttng/ust-error.h
> @@ -1,8 +1,7 @@
>  /*
>   * SPDX-License-Identifier: LGPL-2.1-only
>   *
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> - * Copyright (C) 2011 Julien Desfossez <julien.desfossez@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   */
> =20
> diff --git a/src/common/ustcomm.c b/src/common/ustcomm.c
> index 6dfec5ea..252ed4f2 100644
> --- a/src/common/ustcomm.c
> +++ b/src/common/ustcomm.c
> @@ -1,7 +1,7 @@
>  /*
>   * SPDX-License-Identifier: LGPL-2.1-only
>   *
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2011-2013 Mathieu Desnoyers <mathieu.desnoyers@efficios=
=2Ecom>
>   */
> =20
> diff --git a/src/common/ustcomm.h b/src/common/ustcomm.h
> index 734757c3..d1e9af13 100644
> --- a/src/common/ustcomm.h
> +++ b/src/common/ustcomm.h
> @@ -1,8 +1,7 @@
>  /*
>   * SPDX-License-Identifier: LGPL-2.1-only
>   *
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> - * Copyright (C) 2011 Julien Desfossez <julien.desfossez@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   */
> =20
> diff --git a/src/common/utils.c b/src/common/utils.c
> index 108f76db..0c95b06c 100644
> --- a/src/common/utils.c
> +++ b/src/common/utils.c
> @@ -1,7 +1,7 @@
>  /*
>   * SPDX-License-Identifier: LGPL-2.1-only
>   *
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   */
> =20
> diff --git a/src/lib/lttng-ust-ctl/ustctl.c b/src/lib/lttng-ust-ctl/ustct=
l.c
> index 8c60bdb2..94d84843 100644
> --- a/src/lib/lttng-ust-ctl/ustctl.c
> +++ b/src/lib/lttng-ust-ctl/ustctl.c
> @@ -1,7 +1,7 @@
>  /*
>   * SPDX-License-Identifier: GPL-2.0-only
>   *
> - * Copyright (C) 2011 Julien Desfossez <julien.desfossez@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2011-2013 Mathieu Desnoyers <mathieu.desnoyers@efficios=
=2Ecom>
>   */
> =20
> diff --git a/src/lib/lttng-ust/lttng-ust-comm.c b/src/lib/lttng-ust/lttng=
-ust-comm.c
> index d6755079..caba7452 100644
> --- a/src/lib/lttng-ust/lttng-ust-comm.c
> +++ b/src/lib/lttng-ust/lttng-ust-comm.c
> @@ -1,7 +1,7 @@
>  /*
>   * SPDX-License-Identifier: LGPL-2.1-only
>   *
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   */
> =20
> diff --git a/src/lib/lttng-ust/strerror.c b/src/lib/lttng-ust/strerror.c
> index 1fa7fc3a..5a671a07 100644
> --- a/src/lib/lttng-ust/strerror.c
> +++ b/src/lib/lttng-ust/strerror.c
> @@ -1,7 +1,7 @@
>  /*
>   * SPDX-License-Identifier: LGPL-2.1-only
>   *
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2011-2013 Mathieu Desnoyers <mathieu.desnoyers@efficios=
=2Ecom>
>   */
> =20
> --=20
> 2.20.1
>=20

Signed-off-by: David Goulet <dgoulet@ev0ke.net>

--=20
s/rLfO0seSQ8fjaS+EqS675BgaLmFqhHovawELv2uZE=3D

--q5y3auqos4ko36ga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEt0QX7d8irJ+ekPSRQuhqKhH0jTYFAmHlhSMACgkQQuhqKhH0
jTYRhgf/YP8rqoYhdJBc44UwMkKSsGshHcbR2UcFg9Rag6Q6Xh1jr7KCGmk61iI3
w7peOUMZeN+znmiciyUIfqIcUi1InHbIXfTxLfMdqExO6IYjWWNjWoLnPUHQe8o7
k4B9V0WOOAU5QyyVl//08auZWIAUL0g+ku6Bylh0wrgbX90hk6mFAFPtoq8ep+oj
aE0NEWxR8W4fUsiSlO1cwhVzBRMVyogG088jvCpVLdwjeZbA+lrY7Adg53q5lAn0
MAhDXgyXxiDhQmNxoORBoMdFmPElNFKZlcRM4h5kIGXNE9DqwaxvmH93Xp07stnb
fz2jkOXyPkgcF/FfOIsXUp5nj46D6Q==
=3cFe
-----END PGP SIGNATURE-----

--q5y3auqos4ko36ga--

--===============3459529183052897191==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============3459529183052897191==--
