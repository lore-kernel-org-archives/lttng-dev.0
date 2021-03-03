Return-Path: <SRS0=0Acq=IB=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85622C433E0
	for <lttng-dev@archiver.kernel.org>; Wed,  3 Mar 2021 16:25:32 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BB0F601FD
	for <lttng-dev@archiver.kernel.org>; Wed,  3 Mar 2021 16:25:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BB0F601FD
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4DrK9P457XzBBP;
	Wed,  3 Mar 2021 11:25:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1614788730;
	bh=BL0BX3At1yqdmKLhTxnFlqKMwIgH3PSM26ny6uctCSg=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Ytb2xDu8NWiX20qjjM98BOL6UFKaYRtuSyZ0Q83ff2jz4syiZJ609cfMC/blVCpjs
	 CoCfEZbUMhx1im8id7QrGuA+KxstSpgiwsHNyHOYeRYtpxfKSdTS6vLIwE4GnLW1ZA
	 G/idc061lYgXgQceo/5DB1p2d5b1ONwK6Cjq4zeTakd8y9w55IPrE+uUhzTIwvyviq
	 y1LRuXfJTQU0sMRlsTPzuKBOhMzWRDH6dd1A9A3hVcTW2kGhWITI//5SDRvWzme3DN
	 94JMK7+I6M0OuGRkDMkRLGLvl6dTSGBtIaaBifDodK0Dhr9gJWfb/vYMlSM/GMbGdu
	 7DxD9K9RXFWEw==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4DrK9L3cftzB8f
 for <lttng-dev@lists.lttng.org>; Wed,  3 Mar 2021 11:25:26 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 29C67321691
 for <lttng-dev@lists.lttng.org>; Wed,  3 Mar 2021 11:25:20 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id m9z4_unvMQeo; Wed,  3 Mar 2021 11:25:19 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id C4BEC321752;
 Wed,  3 Mar 2021 11:25:19 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com C4BEC321752
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id pP7tvCOEhxFm; Wed,  3 Mar 2021 11:25:19 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id BAECD321523;
 Wed,  3 Mar 2021 11:25:19 -0500 (EST)
Date: Wed, 3 Mar 2021 11:25:19 -0500 (EST)
To: Anders Wallin <wallinux@gmail.com>
Cc: lttng-dev@lists.lttng.org
Message-ID: <1696081657.9182.1614788719738.JavaMail.zimbra@efficios.com>
In-Reply-To: <20210303083801.1771117-1-wallinux@gmail.com>
References: <20210303083801.1771117-1-wallinux@gmail.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF86 (Linux)/8.8.15_GA_4007)
Thread-Topic: include lttng-list-trigger missing an 's'
Thread-Index: eZekkSoyXp9MAPgGx2ApDrAbt1CfzA==
Subject: Re: [lttng-dev] [PATCH lttng-tools] fix: include lttng-list-trigger
 missing an 's'
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Galarneau_via_lttng-dev?=
 <lttng-dev@lists.lttng.org>
Reply-To: =?utf-8?B?SsOpcsOpbWll?= Galarneau <jeremie.galarneau@efficios.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

TWVyZ2VkIGluIG1hc3RlciwgdGhhbmtzIQoKSsOpcsOpbWllCgotLS0tLSBPcmlnaW5hbCBNZXNz
YWdlIC0tLS0tCkZyb206ICJBbmRlcnMgV2FsbGluIHZpYSBsdHRuZy1kZXYiIDxsdHRuZy1kZXZA
bGlzdHMubHR0bmcub3JnPgpUbzogbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpTZW50OiBXZWRu
ZXNkYXksIE1hcmNoIDMsIDIwMjEgMzozODowMSBBTQpTdWJqZWN0OiBbbHR0bmctZGV2XSBbUEFU
Q0ggbHR0bmctdG9vbHNdIGZpeDogaW5jbHVkZSBsdHRuZy1saXN0LXRyaWdnZXIgbWlzc2luZyBh
biAncycKClNpZ25lZC1vZmYtYnk6IEFuZGVycyBXYWxsaW4gPHdhbGxpbnV4QGdtYWlsLmNvbT4K
LS0tCiBzcmMvYmluL2x0dG5nL2NvbW1hbmRzL2xpc3RfdHJpZ2dlcnMuYyB8IDIgKy0KIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3Ny
Yy9iaW4vbHR0bmcvY29tbWFuZHMvbGlzdF90cmlnZ2Vycy5jIGIvc3JjL2Jpbi9sdHRuZy9jb21t
YW5kcy9saXN0X3RyaWdnZXJzLmMKaW5kZXggYWM2ZTFiYTMuLmE2ZjAyMTE5IDEwMDY0NAotLS0g
YS9zcmMvYmluL2x0dG5nL2NvbW1hbmRzL2xpc3RfdHJpZ2dlcnMuYworKysgYi9zcmMvYmluL2x0
dG5nL2NvbW1hbmRzL2xpc3RfdHJpZ2dlcnMuYwpAQCAtMTksNyArMTksNyBAQAogCiAjaWZkZWYg
TFRUTkdfRU1CRURfSEVMUAogc3RhdGljIGNvbnN0IGNoYXIgaGVscF9tc2dbXSA9Ci0jaW5jbHVk
ZSA8bHR0bmctbGlzdC10cmlnZ2VyLjEuaD4KKyNpbmNsdWRlIDxsdHRuZy1saXN0LXRyaWdnZXJz
LjEuaD4KIDsKICNlbmRpZgogCi0tIAoyLjMwLjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxp
c3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlz
dGluZm8vbHR0bmctZGV2Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpo
dHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2
Cg==
