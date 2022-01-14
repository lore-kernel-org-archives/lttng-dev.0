Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED7CC433F5
	for <lttng-dev@archiver.kernel.org>; Fri, 14 Jan 2022 19:44:52 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4JbBb73ZDyzFgF;
	Fri, 14 Jan 2022 14:44:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1642189492;
	bh=65BWuwPRKGsQMabA2VHH6ot3CABfTl1EtM40q7CtmfQ=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=c8ifT/jLLfytnpG6jtNwoGTpyJs11Y82NmfGH/YzOt8FoYRqJLyFJxQ+cIGgAxuFv
	 JhFN/6SyJZfxB9k5g8NmKTdhV6WgjC9NVQCxeacLs0P6rfVpM2zc9PcRJdAqnvK1p6
	 qSGXAky6MBXpfsE/uowGGjPZRdfGlxehjFqHbF5oF5PxDamEM6j7M85ViRrfC1cpux
	 ejHWPNo/sDWS+lv03TSBj6YhZl2hdOQvO/ErvQBrn9TIvkb23bdr1pwdzjbx92Yk+m
	 jWMnYLB+LUYIs9G3uGPycU13YPMsWYvouUZd36Z/RmI13rR5pSst/VvFRYT70+WbDi
	 9yapcERdGiqNQ==
Received: from albert.ini-tech.com (ns542098.ip-144-217-255.net
 [144.217.255.55])
 by lists.lttng.org (Postfix) with ESMTPS id 4JbBb53rfdzFg7
 for <lttng-dev@lists.lttng.org>; Fri, 14 Jan 2022 14:44:49 -0500 (EST)
Received: from smtp.ev0ke.net (unknown [10.2.3.24])
 by albert.ini-tech.com (Postfix) with ESMTP id 43FF1CF90;
 Fri, 14 Jan 2022 19:35:18 +0000 (UTC)
Date: Fri, 14 Jan 2022 14:34:58 -0500
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Jeremie Galarneau <jgalar@efficios.com>,
 lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <20220114193458.xkbuemzdpdxnk5sz@raoul>
References: <1116808546.33968.1642188662159.JavaMail.zimbra@efficios.com>
In-Reply-To: <1116808546.33968.1642188662159.JavaMail.zimbra@efficios.com>
Subject: Re: [lttng-dev] Transfer of LTTng copyright ownership: David Goulet
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
Content-Type: multipart/mixed; boundary="===============6337292496166181503=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>


--===============6337292496166181503==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="b2jnfu56pmhmq6km"
Content-Disposition: inline


--b2jnfu56pmhmq6km
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 14 Jan (14:31:02), Mathieu Desnoyers wrote:
> Hi David,
>=20
> In order to facilitate maintenance of the LTTng project, would you agree =
to
> transfer your copyright ownership for code authored outside of your emplo=
yment
> at EfficiOS to EfficiOS Inc. ?
>=20
> This particularly affects the lttng-tools and lttng-ust files with copyri=
ght:
>=20
> Copyright (C) 201N David Goulet <david.goulet@polymtl.ca>

No problem.

I agree and this email is GPG signed :).

Cheers!
David

--=20
xtN36bqNuwFHhNp1j45nwcCwE5HeLkdFZT9naRvLgG0=3D

--b2jnfu56pmhmq6km
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEt0QX7d8irJ+ekPSRQuhqKhH0jTYFAmHh0F8ACgkQQuhqKhH0
jTaZ3wf/fsp1OUageP8LC8nQGCYIknL8wON5k1eR+enZqKQxp0kxjg4SCijS609l
SRU5q9zYn9oJEo81L2ueiHrnZwCyJ8CUHEbjbX4WOFByDFz85enaPjJLVvkcInQF
oeVTWtA38LId/z9+CbKfxQaBlaH+AWXAIKg/70WWQw2OBS82T3RqvEEFnK1dJYEA
fW0QQ7ys/nbBBM3M/RDLzgIjPY2kZ4syMHAkjvQnxcMbQsANBJNR25ycvfnIKk0V
5IRuGkqZQjzVrO1cJcWVu8KxoyioFJKooWJukqjPPj/7nCqzJFA0vs7XIFVPbdl1
eNqdwCF7bNDZfFJQY3c31/QnAAbHiA==
=Unug
-----END PGP SIGNATURE-----

--b2jnfu56pmhmq6km--

--===============6337292496166181503==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============6337292496166181503==--
