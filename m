Return-Path: <SRS0=jUQg=AK=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98A2C433E0
	for <lttng-dev@archiver.kernel.org>; Mon, 29 Jun 2020 16:27:30 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4559725598
	for <lttng-dev@archiver.kernel.org>; Mon, 29 Jun 2020 16:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="C7XzwHDC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4559725598
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 49wXvg61SSz16rV;
	Mon, 29 Jun 2020 12:27:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1593448048;
	bh=2g/R5bizimtswhe6Pm8VPCTIk0jPa2FCpE1lS5VgAhY=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=C7XzwHDCdN+7oU4vm4snLYKlRm8f1YS7X8dP97cD2s2K9iARo1WAPWoHM3AsBnKeK
	 FexsmnkjrB0pKRxkzDmgr7xDIkd1yYqYdnLttc4kMtrR/yKi+3Fx7f2xuGS5T1CjTu
	 5QDE9zVVihL/cNZvDCowFpfFPt+UlXOuRfi2CMoF81ppmOGBGPb+mocVmFYSIoe/li
	 w/eAxNwjzucL6C//bl//YQEFk7Kd8wrg6O2uWRaB3McAHySWYzQyybe5DGcEBvxrKC
	 TXkHlfL0AYCRRelYStr1e+FlOmVJ5GhDCC8jO5ma7x6WqvqggAqWhWOE62ZEq0/kEP
	 4DERGihfd8lmQ==
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by lists.lttng.org (Postfix) with ESMTPS id 49wXvf1Dxtz177q
 for <lttng-dev@lists.lttng.org>; Mon, 29 Jun 2020 12:27:26 -0400 (EDT)
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-s7ATo9WZMaefNri8Ad1P5g-1; Mon, 29 Jun 2020 12:26:03 -0400
X-MC-Unique: s7ATo9WZMaefNri8Ad1P5g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE0F8804002;
 Mon, 29 Jun 2020 16:26:02 +0000 (UTC)
Received: from localhost (ovpn-115-85.ams2.redhat.com [10.36.115.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2C7D75D9CC;
 Mon, 29 Jun 2020 16:26:01 +0000 (UTC)
Date: Mon, 29 Jun 2020 17:26:00 +0100
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <20200629162600.GA54368@stefanha-x1.localdomain>
References: <20200624160934.205881-1-stefanha@redhat.com>
 <1673641132.14590.1593205320791.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
In-Reply-To: <1673641132.14590.1593205320791.JavaMail.zimbra@efficios.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Subject: Re: [lttng-dev] [PATCH] Fix: tracepoint.h: define SDT_USE_VARIADIC
 in pkg-config CFLAGS
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.31
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Stefan Hajnoczi via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: multipart/mixed; boundary="===============1616598457040829311=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200629162600.D5EewI-Oxuu9Db269hAxYBz4FZOXOhgl5Z4Id88f33Q@z>

--===============1616598457040829311==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline

--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2020 at 05:02:00PM -0400, Michael Jeanson wrote:
> I proposed a patch here[1] that addresses this problem in a generic way b=
y
> duplicating the macro and namespacing it under LTTNG_. Honestly this is m=
ore
> of an sdt bug, the STAP_PROBEV should be in it's own include guard outsid=
e
> of _SYS_SDT_H or in it's own header file but we have to work with what's =
there.
>=20
> Can you have a look at the patch and confirm that it fixes your problem?

Great, glad there is already a fix under review.

When I try out the patch the application does not compile. The error
messages are the same as without the patch because _LTTNG_SDT_PROBE() is
not defined. Was that supposed to be _SDT_PROBE() instead?

The application compiles successfully after replacing _LTTNG_SDT_PROBE()
with _SDT_PROBE().

Stefan

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl76FhgACgkQnKSrs4Gr
c8gFkQgAg8trelUbnEi0DjxQuLTrnTjYUwxU9Jp5jM6mYe1qmRc4m3hmZJ//cLk8
PEdvQq+NOlOK0SLRVRr3NAsiDeBXSSBluwWS+OLqKEEU9JS5EZONhdItZMvNSEpM
3htfPRd4rARs0BJOVU3uclLZxwDVSf3JhuGb4eTMBIiYQjjeHRykMCWLqXINMzxg
YXtlI5orgyfhXv5ryKYcb+I2T7mN2a5hVTjrho05edvoecCTK/at/Heag0AVmNwe
DcOytPFQ2AQ0LHc7Kly2kLZcC8c0ELp2tmc2H2JRgxVn/33ZexSGRDc550dAV3ua
O+B6+gyPhoIIzCVegSydrO/YGnS34w==
=zTzy
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--


--===============1616598457040829311==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1616598457040829311==--

