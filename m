Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1009AC678D5
	for <lttng-dev@archiver.kernel.org>; Wed,  8 Mar 2023 14:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1678286706;
	bh=eoUHc0VL17S+Z2Zakosa5q7RH97sdOwQvnTRtP0mexY=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=JNKqFqPTMmTcx3onEMassFhsp41L9K1wnan6OXJTxoan6djJRCA5ANSYFD5m+pc7Y
	 mUiWHyZupMld+V2EvS99Xfwhdpi/KQ2aQIw1uRL2eEnu0EA1zH30APJxKTh6egYThY
	 BItsmYeaYBKAetvxs3Dy2eOQd//BglGwS31bh8pmmNEMAsoysonJekJ6z3fZBe6RR9
	 qwj/v6BQwagA33NBfCzahnjfMs4Vw90rjgJvfUIndG5sa4eKkfJeeFyzBqHBha3wVe
	 5jNNqSfRKE96cepJv9o1MxvvpzbQS/XszisBsgvjzDYFp4kSQ++1dzJVXN/5mou9LR
	 xIoAqU1IWGTqg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4PWw8L1VmPz27cs;
	Wed,  8 Mar 2023 09:45:06 -0500 (EST)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4PWw8F74nMz27Tm
 for <lttng-dev@lists.lttng.org>; Wed,  8 Mar 2023 09:45:01 -0500 (EST)
Received: from [172.16.0.172] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4PWw871PzGzpDw;
 Wed,  8 Mar 2023 09:44:55 -0500 (EST)
Message-ID: <d3af6ef9-1f99-f29f-b933-2a5d39a5ed0f@efficios.com>
Date: Wed, 8 Mar 2023 09:45:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To: Yuan Bin <elf.ggle@gmail.com>, lttng-dev@lists.lttng.org
References: <CAL_9pdTicspLuNH8UJ6=sSXuhHKLQOcq7GQC-NA0nmqSYENDzA@mail.gmail.com>
In-Reply-To: <CAL_9pdTicspLuNH8UJ6=sSXuhHKLQOcq7GQC-NA0nmqSYENDzA@mail.gmail.com>
Subject: Re: [lttng-dev] how to disable local file writing in relayd?
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

T24gMjAyMy0wMy0wNiAwMDoxMiwgWXVhbiBCaW4gdmlhIGx0dG5nLWRldiB3cm90ZToKPiAgwqBD
YW4gSSBkaXNhYmxlIGxvY2FsLWZpbGUtd3JpdGluZyBpbiBsdHRuZy1yZWxheWQgdG8gYXZvaWQg
dGhlIGRpc2sgCj4gc3BhY2Ugb3ZlcmhlYWQsIG9ubHkgdXNpbmcgaXQgYXMgYSBsaXZlIHZpZXdl
cj8KCk5vdCBleHBsaWNpdGx5LCBidXQgeW91IGNhbiBzdG9yZSB5b3VyIHRlbXBvcmFyeSBmaWxl
cyBvbiBhIHRtcGZzIGZpbGUgCnN5c3RlbSAoc2VlIGx0dG5nLXJlbGF5ZCg4KSAtLW91dHB1dCBj
b21tYW5kIGxpbmUgcGFyYW1ldGVyKSwgd2hpY2ggd2lsbCAKb25seSBrZWVwIHRoZSByZWxheWQg
ZmlsZXMgaW4gbWVtb3J5LCBhbmQgdXNlIHRoZSB0cmFjZWZpbGUgcm90YXRpb24gCmZlYXR1cmUg
dG8gcHJldmVudCB0aGUgZmlsZXMgZnJvbSBncm93aW5nIGZvcmV2ZXIsIGUuZy46CgpodHRwczov
L2x0dG5nLm9yZy9kb2NzL3YyLjEzLyNkb2MtZW5hYmxpbmctZGlzYWJsaW5nLWNoYW5uZWxzCgpF
eGFtcGxlOkNyZWF0ZSBhIExpbnV4IGtlcm5lbCBjaGFubmVsIHdoaWNoIHJvdGF0ZXMgZWlnaHQg
dHJhY2UgZmlsZXMgb2YgCjQgTWlCIGVhY2ggZm9yIGVhY2ggc3RyZWFtLgoKbHR0bmcgZW5hYmxl
LWNoYW5uZWwgLS1rZXJuZWwgLS10cmFjZWZpbGUtY291bnQ9OCBcCiAgICAgICAgICAgICAgICAg
ICAgICAtLXRyYWNlZmlsZS1zaXplPTQxOTQzMDQgbXktY2hhbm5lbAoKU2VlIGx0dG5nLWVuYWJs
ZS1jaGFubmVsKDEpIGZvciBtb3JlIGluZm8uCgpJIGhvcGUgdGhpcyBoZWxwcyEKCk1hdGhpZXUK
CgotLSAKTWF0aGlldSBEZXNub3llcnMKRWZmaWNpT1MgSW5jLgpodHRwczovL3d3dy5lZmZpY2lv
cy5jb20KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0
dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xp
c3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
