Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA2EDCD1292
	for <lttng-dev@archiver.kernel.org>; Mon,  1 Apr 2024 14:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1711980208;
	bh=bZsBLkQmkNR7URWUhokfe0rZtIBs7pssPySm4NsMeMg=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=IQhJ2gaX7ctS/cfhgHgVkccqBWNTFhMfg9GrxPu6W4CMfh2slbpqQ+FMgg3RhyRzI
	 VunZveVDWt4DkouA4ueer0LtyJiuxmFkyJk0hkZAgeEBNf35JxnCXb7h7oYIoSUeKx
	 yc+RD+HKHwyG5dwNHg+BrCVerJxKiKHWMdegZbyIkeaR2EbOCrUo0HOKHDtkUhN+o5
	 46FLsjACJgavLSnpHpZDCGtKqGHtQCmaUC5o3t0CJCKtkQIL9Nzd43QcLrdB7Wvq4m
	 AanbfPdn2gDpgM32lwYIhQzpFs//oVkruwieRfaGiKYnBffFBk0YhPlss+5RmGtzk2
	 cMB5G2cU8AbwQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4V7XmJ0HnVz2YxX;
	Mon,  1 Apr 2024 10:03:27 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4V7XmF1nqtz2Z86
 for <lttng-dev@lists.lttng.org>; Mon,  1 Apr 2024 10:03:25 -0400 (EDT)
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown
 [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4V7XmC1spmzpCQ;
 Mon,  1 Apr 2024 10:03:23 -0400 (EDT)
Message-ID: <cb341ad4-1888-4d34-9da3-636d6d8036bd@efficios.com>
Date: Mon, 1 Apr 2024 10:03:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Duncan Sands <baldrick@free.fr>, lttng-dev <lttng-dev@lists.lttng.org>
References: <c0fa14f8-2771-4597-9232-0438a67badca@free.fr>
Content-Language: en-US
In-Reply-To: <c0fa14f8-2771-4597-9232-0438a67badca@free.fr>
Subject: Re: [lttng-dev] Compile fix for urcu-bp.c
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

SGksCgpUaGVyZSBhcmUgYSBmZXcgdGhpbmdzIG1pc3NpbmcgYmVmb3JlIEkgY2FuIHRha2UgdGhp
cyBwYXRjaDoKCi0gTWlzc2luZyBjb21taXQgbWVzc2FnZSBkZXNjcmliaW5nIHRoZSBpc3N1ZSwK
LSBNaXNzaW5nICJTaWduZWQtb2ZmLWJ5IiB0YWcuCgpUaGFua3MhCgpNYXRoaWV1CgpPbiAyMDI0
LTAzLTI5IDEwOjA2LCBEdW5jYW4gU2FuZHMgdmlhIGx0dG5nLWRldiB3cm90ZToKPiAtLS0gc3Jj
L3VyY3UtYnAuYwo+ICsrKyBzcmMvdXJjdS1icC5jCj4gQEAgLTQwOSw3ICs0MDksNyBAQCB2b2lk
IGV4cGFuZF9hcmVuYShzdHJ1Y3QgcmVnaXN0cnlfYXJlbmEgKmFyZW5hKQo+ICDCoMKgwqDCoMKg
wqDCoMKgIG5ld19jaHVua19zaXplX2J5dGVzLCAwKTsKPiAgwqDCoMKgwqAgaWYgKG5ld19jaHVu
ayAhPSBNQVBfRkFJTEVEKSB7Cj4gIMKgwqDCoMKgwqDCoMKgwqAgLyogU2hvdWxkIG5vdCBoYXZl
IG1vdmVkLiAqLwo+IC3CoMKgwqDCoMKgwqDCoCBhc3NlcnQobmV3X2NodW5rID09IGxhc3RfY2h1
bmspOwo+ICvCoMKgwqDCoMKgwqDCoCB1cmN1X3Bvc2l4X2Fzc2VydChuZXdfY2h1bmsgPT0gbGFz
dF9jaHVuayk7Cj4gIMKgwqDCoMKgwqDCoMKgwqAgbWVtc2V0KChjaGFyICopIGxhc3RfY2h1bmsg
KyBvbGRfY2h1bmtfc2l6ZV9ieXRlcywgMCwKPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG5l
d19jaHVua19zaXplX2J5dGVzIC0gb2xkX2NodW5rX3NpemVfYnl0ZXMpOwo+ICDCoMKgwqDCoMKg
wqDCoMKgIGxhc3RfY2h1bmstPmNhcGFjaXR5ID0gbmV3X2NhcGFjaXR5Owo+IF9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gbHR0bmctZGV2IG1haWxpbmcg
bGlzdAo+IGx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKPiBodHRwczovL2xpc3RzLmx0dG5nLm9y
Zy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2CgotLSAKTWF0aGlldSBEZXNub3ll
cnMKRWZmaWNpT1MgSW5jLgpodHRwczovL3d3dy5lZmZpY2lvcy5jb20KCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QK
bHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmlu
L21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
