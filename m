Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A84D4C77B7A
	for <lttng-dev@archiver.kernel.org>; Wed,  7 Jun 2023 19:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1686165623;
	bh=heNwm+uOJsYjuIobiNZT0W+GalOnlOv3ehf+djLZgkQ=;
	h=To:Cc:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=0wetAUi3uuUInGfmJV8OXOeVTU9dVydwfv8N5K18EDYB+rKT/4wL57z7jBNysuFu2
	 8pIWRztRdRQUga1sN+EOaRv+rM6IVEwcM8HZhXpZHSQSgqLELdUNJx1d4VLRB7Sj32
	 +fW2C6/fxg7ZZzT1znAVee8vyIa6iP+jYT7yHBI2oQnRQgnYsUmAbAYKNCzXC0dJiS
	 sh9p57fY8gaZDLLQwFwdiBv4QNkhXWSyQrW/0qNH4a4DTF1bJCF49HprKia+A+T3z8
	 Prs+Ll4VjQixxZfZJwWLfKQif5WntDl7BbVQ26EWXmTp8ZLpWWmErvSrOMVjCbNYm0
	 /n2viouGLDjPQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Qbxxz4K2wz1Xr8;
	Wed,  7 Jun 2023 15:20:23 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4Qbxxx5Z3tz1Xyj
 for <lttng-dev@lists.lttng.org>; Wed,  7 Jun 2023 15:20:20 -0400 (EDT)
Received: from localhost (modemcable094.169-200-24.mc.videotron.ca
 [24.200.169.94])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4Qbxxv5D01z177L;
 Wed,  7 Jun 2023 15:20:19 -0400 (EDT)
To: =?utf-8?B?T25kxZllaiBTdXLDvQ==?= <ondrej@sury.org>
Cc: lttng-dev@lists.lttng.org, Tony Finch <dot@dotat.at>
In-Reply-To: <A4AC07B9-DAE5-4063-89D5-C70BFF3A03C9@sury.org>
Organization: EfficiOS
References: <20230607185359.8125-1-odion@efficios.com>
 <A4AC07B9-DAE5-4063-89D5-C70BFF3A03C9@sury.org>
Date: Wed, 07 Jun 2023 15:20:19 -0400
Message-ID: <87wn0fdqq4.fsf@laura>
MIME-Version: 1.0
Subject: Re: [lttng-dev] [PATCH v2 00/12] Add support for TSAN to liburcu
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Olivier Dion via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Olivier Dion <odion@efficios.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

T24gV2VkLCAwNyBKdW4gMjAyMywgT25kxZllaiBTdXLDvSA8b25kcmVqQHN1cnkub3JnPiB3cm90
ZToKPiBPbGl2aWVyLAo+Cj4gaXMgdGhpcyBzb21ld2hlcmUgaW4gR2Vycml0IGFnYWluLCBwbGVh
c2U/IEl04oCZcyBtdWNoIGVhc2llciBmb3IgdXMgdG8KPiBwdWxsIHRoZSBjaGFuZ2VzIGZyb20g
Z2l0IHRoYW4gY2hlcnJ5LXBpY2sgcGF0Y2hlcyBmcm9tIHRoZSBtYWlsaW5nCj4gbGlzdC4KCkhl
cmUgaHR0cHM6Ly9yZXZpZXcubHR0bmcub3JnL2MvdXNlcnNwYWNlLXJjdS8rLzEwMTE4LzYuCgot
LSAKT2xpdmllciBEaW9uCkVmZmljaU9TIEluYy4KaHR0cHM6Ly93d3cuZWZmaWNpb3MuY29tCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBt
YWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5n
Lm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
