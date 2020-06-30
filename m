Return-Path: <SRS0=mcdi=AL=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC359C433DF
	for <lttng-dev@archiver.kernel.org>; Tue, 30 Jun 2020 09:05:29 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CC5420781
	for <lttng-dev@archiver.kernel.org>; Tue, 30 Jun 2020 09:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="YAzdilsA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CC5420781
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 49wz3C4Lbyz17X1;
	Tue, 30 Jun 2020 05:05:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1593507928;
	bh=LkDtR4PuQEBOKk6t/1C0NJRKDS0afrVbkCYB4JIMiLA=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=YAzdilsAGa0vQScw3phc/xjyL6bebEPdQFsoVJAOY95fixJBnUD/CMK5A5LQteAZX
	 zvrrRcnxA/ZJ52rXjn8+rhS8PBa9NHfujO6/NYYHhS6xfvp1ZMtrTsWdqLN3GXvxoi
	 VPbQSaJU+heqgawLblw8zVsnq/KX0mEe3KrNOWvRxCOEQkVgCv23ooekEuPkhwvvXY
	 iCiq8lhjtvS+5AGjTsV2XtK9jYH+/BbYdvt5SUgd5W2/DsHRmk1iJmoWxrOZcqPPuZ
	 DnwbCS+wogFMUVxaffEAAEvPuR1DSttIs/gz4hmY3skxR158SZhXU+DD0+ociV2H72
	 yzc+qmXnYFihg==
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 by lists.lttng.org (Postfix) with ESMTPS id 49wz3961BZz17FR
 for <lttng-dev@lists.lttng.org>; Tue, 30 Jun 2020 05:05:25 -0400 (EDT)
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-i_RnGXPzNqiuj7_NsNgAOg-1; Tue, 30 Jun 2020 05:05:17 -0400
X-MC-Unique: i_RnGXPzNqiuj7_NsNgAOg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34A1B464;
 Tue, 30 Jun 2020 09:05:16 +0000 (UTC)
Received: from localhost (ovpn-115-106.ams2.redhat.com [10.36.115.106])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 983761001B0B;
 Tue, 30 Jun 2020 09:05:14 +0000 (UTC)
Date: Tue, 30 Jun 2020 10:05:14 +0100
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <20200630090514.GF81930@stefanha-x1.localdomain>
References: <20200624160934.205881-1-stefanha@redhat.com>
 <1673641132.14590.1593205320791.JavaMail.zimbra@efficios.com>
 <20200629162600.GA54368@stefanha-x1.localdomain>
 <1076462414.15458.1593448617213.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
In-Reply-To: <1076462414.15458.1593448617213.JavaMail.zimbra@efficios.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
Content-Type: multipart/mixed; boundary="===============5346269065248382552=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200630090514.RzfXWMtkxVJPiyYPU72rCoN3lU1WKrByBhCz_cA00sY@z>

--===============5346269065248382552==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eDB11BtaWSyaBkpc"
Content-Disposition: inline

--eDB11BtaWSyaBkpc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2020 at 12:36:57PM -0400, Michael Jeanson wrote:
> ----- On 29 Jun, 2020, at 12:26, Stefan Hajnoczi stefanha@redhat.com wrot=
e:
>=20
> > On Fri, Jun 26, 2020 at 05:02:00PM -0400, Michael Jeanson wrote:
> >> I proposed a patch here[1] that addresses this problem in a generic wa=
y by
> >> duplicating the macro and namespacing it under LTTNG_. Honestly this i=
s more
> >> of an sdt bug, the STAP_PROBEV should be in it's own include guard out=
side
> >> of _SYS_SDT_H or in it's own header file but we have to work with what=
's there.
> >>=20
> >> Can you have a look at the patch and confirm that it fixes your proble=
m?
> >=20
> > Great, glad there is already a fix under review.
> >=20
> > When I try out the patch the application does not compile. The error
> > messages are the same as without the patch because _LTTNG_SDT_PROBE() i=
s
> > not defined. Was that supposed to be _SDT_PROBE() instead?
> >=20
> > The application compiles successfully after replacing _LTTNG_SDT_PROBE(=
)
> > with _SDT_PROBE().
> >=20
> > Stefan
>=20
> Yes indeed, I reworked the patch after testing it and didn't catch this, =
I've
> just pushed an updated patch. Thanks for testing it and catching this.

Nice! Thanks for the fix.

Stefan

--eDB11BtaWSyaBkpc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl77AEkACgkQnKSrs4Gr
c8h+3wf/fYSxd59E8rXAFfUn+xu4ZZHLgQk+fTBRO5avjH09rumgOZgyIiBPr5Ou
OV+ShA7uR7FcAAkV0holuMwLzh9ypxrb9/9pSWE7QPKtf/aCS7fQklXf1eFQF2BE
UIeE98wTSVDp8sCZqH/UvhA94756lAWXuaQxMWCLcqXpi/JGZBJY5+4OOy9E4evF
8XBYqaBXVfVQfQnM8rBgFuVEEiTiiCOwT2UTsTkD99PmJx9AhzvLU0J98jyDUVl/
MX6kNkDYksvvZiSWiNeBfxqqFexGlNdgr1nHm28+mBs2NiqzWmPfU4oV7T7UU56H
Vcd/+qzzNvpcKXMdXbxodIKsOKE7vw==
=rGB6
-----END PGP SIGNATURE-----

--eDB11BtaWSyaBkpc--


--===============5346269065248382552==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============5346269065248382552==--

