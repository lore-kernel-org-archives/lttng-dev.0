Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC33C6FD1C
	for <lttng-dev@archiver.kernel.org>; Wed, 22 Mar 2023 13:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1679491546;
	bh=VaePlXaU80rLCqXXkI/3WtqC0tEERS+Uyj4AYDV6t1c=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=AaJVTOq1orJfNxkKyeRRWmlxg7dEP+HTMKTR6G/kVcWq69+/LFeqQOpWdvW0k9+Tv
	 IQwZZCS1SX1te4IGKIE/3PaN365+h/Jrs9JWFcX7w1ZsokSq4U/7/HpCCRlL/brW6d
	 3LQngSS1rXHzJGCM6Z5nBgNdEybwapGUmERc8D3f9uEBERPACM6KZTqpFcAzTRNVKe
	 wkwQp6CC61aieZ1Kqli1MqSQZZSnk/W09X0xHIUFLjpWUyTam94yFSW2VflQQE5O2Q
	 6O/LG6jxVLZlCiJs6v6rtQizrh6vybmutr/WC3D9gb2HU7KPAB8ptaGi0NdjATPPyu
	 f2jaQ0wDfF+3Q==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4PhTkL2g2dz2HN5;
	Wed, 22 Mar 2023 09:25:46 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4PhTkK06kqz2HnX
 for <lttng-dev@lists.lttng.org>; Wed, 22 Mar 2023 09:25:44 -0400 (EDT)
Received: from [172.16.0.188] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4PhTjk2Sy5zsdY;
 Wed, 22 Mar 2023 09:25:14 -0400 (EDT)
Message-ID: <799cf4da-5f0b-f280-cf79-2b17e644e78d@efficios.com>
Date: Wed, 22 Mar 2023 09:25:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To: Yuan Bin <elf.ggle@gmail.com>, lttng-dev@lists.lttng.org
References: <CAL_9pdTicspLuNH8UJ6=sSXuhHKLQOcq7GQC-NA0nmqSYENDzA@mail.gmail.com>
 <CAL_9pdS6dGZ6idu1wAeWrcPrKWdErJ3Rmx5HhdCxNdyy23WAMQ@mail.gmail.com>
In-Reply-To: <CAL_9pdS6dGZ6idu1wAeWrcPrKWdErJ3Rmx5HhdCxNdyy23WAMQ@mail.gmail.com>
Subject: Re: [lttng-dev] Fwd: how to disable local file writing in relayd?
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
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

T24gMjAyMy0wMy0yMiAwMjozOSwgWXVhbiBCaW4gdmlhIGx0dG5nLWRldiB3cm90ZToKPiAKPiAK
PiAgwqBDYW4gSSBkaXNhYmxlIGxvY2FsLWZpbGUtd3JpdGluZyBpbiBsdHRuZy1yZWxheWQgdG8g
YXZvaWQgdGhlIGRpc2sgCj4gc3BhY2Ugb3ZlcmhlYWQsIG9ubHkgdXNpbmcgaXQgYXMgYSBsaXZl
IHZpZXdlcj8KPiAKCkkgYW0gbm90IHN1cmUgd2h5IHlvdSBidW1wIHRoaXMgZW1haWwgdGhyZWFk
LiBJIGFscmVhZHkgYW5zd2VyZWQgaGVyZS4gClBlcmhhcHMgeW91IGRpZCBub3QgcmVjZWl2ZSBt
eSByZXBseSA/CgpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9waXBlcm1haWwvbHR0bmctZGV2LzIw
MjMtTWFyY2gvMDMwMzU4Lmh0bWwKClRoYW5rcywKCk1hdGhpZXUKCgotLSAKTWF0aGlldSBEZXNu
b3llcnMKRWZmaWNpT1MgSW5jLgpodHRwczovL3d3dy5lZmZpY2lvcy5jb20KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxp
c3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2kt
YmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
