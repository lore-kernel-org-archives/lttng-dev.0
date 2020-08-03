Return-Path: <SRS0=QQXS=BN=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083A9C433E0
	for <lttng-dev@archiver.kernel.org>; Mon,  3 Aug 2020 15:32:06 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FDF520678
	for <lttng-dev@archiver.kernel.org>; Mon,  3 Aug 2020 15:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="p6Mu3d54"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FDF520678
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4BL21c0Vtwz1nKy;
	Mon,  3 Aug 2020 11:32:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1596468724;
	bh=GCb+OlkcGzhAZY7RPMgu259hjucov8Ilqnh8wd8AyjA=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=p6Mu3d54jZLQyQPmH9yL7N9F4s7bw7NDNDfsclkSR0F0JotZlD8Jxb2bkYmAwTY9a
	 vHmckPXgXberhNH27LaBr1FSuHfvhyGqV0mUBzFMjjEdnm2ozuQAOys8uyctEC8gAt
	 H4GmSEeUy5JRs/kiq3e2YgBGvZiACdabVTlh7g/ghh87oXBQh0IQcO8nJT9Qik/kW4
	 t9ihe+K5Eo6OSnHEVGDa9kxJQ+96MSidvtWy5jaq2rU4jkLwiLMgbQ+/9OJDeA6LH0
	 ZnVCc6x4EHZiI/nAmE2ZOS6fHmEWcjCZ6A4m3ee5yCWoi/Wm8fRvtyNOaBl1w3Vg5P
	 bkYEEQ87JVe4w==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4BL21Z4WqJz1nHJ
 for <lttng-dev@lists.lttng.org>; Mon,  3 Aug 2020 11:32:02 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 4C1CC2CF215
 for <lttng-dev@lists.lttng.org>; Mon,  3 Aug 2020 11:31:56 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id IqgN5qcZyhsb; Mon,  3 Aug 2020 11:31:56 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 043E42CF210;
 Mon,  3 Aug 2020 11:31:56 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 043E42CF210
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id Ao_ibG6kNo1W; Mon,  3 Aug 2020 11:31:55 -0400 (EDT)
Received: from joraj-alpa (unknown [107.159.43.215])
 by mail.efficios.com (Postfix) with ESMTPSA id C7E0E2CF325;
 Mon,  3 Aug 2020 11:31:55 -0400 (EDT)
Date: Mon, 3 Aug 2020 11:31:55 -0400
To: PFLANZER Moritz <moritz.pflanzer@hexagon.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Message-ID: <20200803153155.GA207972@joraj-alpa>
References: <AM0PR06MB40030B857FF08F8B7685563FE64D0@AM0PR06MB4003.eurprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AM0PR06MB40030B857FF08F8B7685563FE64D0@AM0PR06MB4003.eurprd06.prod.outlook.com>
Subject: Re: [lttng-dev] Help needed: No UST events recorded
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
From: Jonathan Rajotte-Julien via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi Moritz

What is your version of lttng-tools?

  lttng --version

Please run the `hello` executable using the LTTNG_UST_DEBUG env variable, w=
hile
tracing, and provide the output.

  pkill lttng-sessiond
  lttng-sessiond -b -vvv --verbose-consumer 2> /tmp/lttng-sessiond.log
  lttng create
  lttng enable-event -u -a
  lttng start
  LTTNG_UST_DEBUG=3Dy ./hello
  lttng stop
  lttng destroy
  pkill lttng-sessiond

Please also provide the /tmp/lttng-sessiond.log file via pastebin.

I suspect that if you cross-compiled lttng-ust from the master branch that
lttng-tools is not using the same version, resulting in the application not
being able to register to the lttng-sessiond.

Cheers

On Mon, Aug 03, 2020 at 09:35:25AM +0000, PFLANZER Moritz via lttng-dev wro=
te:
> Hi all!
> =

> I'm struggling to get userspace tracing working on an aarch64 platform (b=
usybox on top of Linux 5.4.24 kernel). I followed the guidelines in the doc=
s and am currently using this example program for testing: https://github.c=
om/lttng/lttng-ust/tree/master/doc/examples/hello-static-lib
> I cross-compiled lttng-ust and that example, but when I run the following=
 commands on the platform no traces are recorded. If I use the same example=
 on my x86 machine everything works as expected. (And kernelspace tracing i=
s working on that aarch64 system.)
> =

> Any hints where I could start investigating the issue are welcome.
> =

> Regards,
> Moritz
> =

> ~ # pwd
> /root
> ~ # lttng create
> Spawning a session daemon
> Session auto-20200720-174509 created.
> Traces will be written in /root/lttng-traces/auto-20200720-174509
> ~ # lttng enable-event -au
> All UST events are enabled in channel channel0
> ~ # lttng start
> Tracing started for session auto-20200720-174509
> ~ # ./hello
> Hello, World!
> Tracing...  done.
> ~ # lttng destroy
> Session auto-20200720-174509 destroyed
> ~ # ll
> total 40
> -rwxr-xr-x    1 root     root         39280 Jul 20 17:44 hello*
> =

> =

> =

> Moritz Pflanzer
> Software Development Engineer
> =

> [cid:image001.png@01D3BF6E.185110B0]
> =

> R=E4ffelstrasse 28
> =

> 8045 Z=FCrich
> E: moritz.pflanzer@hexagon.com<mailto:moritz.pflanzer@hexagon.com><mailto=
:carolin.siebert@hexagon.com>
> W: http://www.hexagongeosystems.com



> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- =

Jonathan Rajotte-Julien
EfficiOS
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
