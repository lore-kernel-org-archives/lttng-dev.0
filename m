Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14311C6FD1F
	for <lttng-dev@archiver.kernel.org>; Wed, 22 Mar 2023 08:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1679473527;
	bh=ldB2RLiX1CFAVbJjs80aOmDbT2W30RXVq7ta6sW1aUc=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=wnVur2nPhPHWywv4HdHRdMxZY18Ugj3NEKv1JQZuE9L88080qzRo41zwy0WP4cbr0
	 bcMFZkpJR24+3Bh9LbuGSPq0LautJZj5VqaOv4KR7Va0N1FB/cNIvTE6d9ToOuqUzX
	 NFtXNzfk7nN099nLcd3SXhfrw6YLcz+yy/GqgJo+eLBLDzBcv6BElnZ/DqDShkDWmh
	 1732jfSTs1F1kSmvZloHfvksOai9ZYoaHvkKWaExQfnq32SWtgx5NcpyJHnAxgmjnN
	 ROUKe+riZ5W3K0hsIQMsjVtKZQU2fzU0TZzO6Ua6mpBk/0fNmmhxqX36J9kqDYmDR9
	 VpHra4JKoKoWA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4PhM3p2Y5Hz2HQb;
	Wed, 22 Mar 2023 04:25:26 -0400 (EDT)
Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
 by lists.lttng.org (Postfix) with ESMTP id 4PhM3m0Ztmz2H8g
 for <lttng-dev@lists.lttng.org>; Wed, 22 Mar 2023 04:25:22 -0400 (EDT)
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
 by smtpfb1-g21.free.fr (Postfix) with ESMTP id 4F9C2DF89E9
 for <lttng-dev@lists.lttng.org>; Wed, 22 Mar 2023 09:25:15 +0100 (CET)
Received: from [IPV6:2a01:e0a:255:1000:2b2b:8e2e:f4f3:a8a] (unknown
 [IPv6:2a01:e0a:255:1000:2b2b:8e2e:f4f3:a8a])
 (Authenticated sender: duncan.sands@free.fr)
 by smtp3-g21.free.fr (Postfix) with ESMTPSA id 28C0213F88E;
 Wed, 22 Mar 2023 09:24:35 +0100 (CET)
Message-ID: <2baf2296-2be2-a4ed-60a5-b87335acd0f8@free.fr>
Date: Wed, 22 Mar 2023 09:24:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 lttng-dev@lists.lttng.org
References: <20230317213755.455957-1-ondrej@sury.org>
 <20230317213755.455957-3-ondrej@sury.org>
 <6d73ed33-f3fc-2459-a7e9-142b8908ad4f@efficios.com>
 <dbe6e604-6ae9-1790-718f-bc69686442d1@free.fr>
 <86858b96-5b88-7e1c-2be2-6157e864c8db@efficios.com>
Content-Language: en-GB
In-Reply-To: <86858b96-5b88-7e1c-2be2-6157e864c8db@efficios.com>
Subject: Re: [lttng-dev] [PATCH 2/7] Use gcc __atomic builtis for
 <urcu/uatomic.h> implementation
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
From: Duncan Sands via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Duncan Sands <baldrick@free.fr>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

SGkgTWF0aGlldSwKCj4gVGVzdGVkIG9uIGdvZGJvbHQub3JnIHdpdGg6Cj4gCj4gaW50IGE7Cj4g
Cj4gdm9pZCBmY3Qodm9pZCkKPiB7Cj4gIMKgwqDCoCAodm9pZCkgX19hdG9taWNfYWRkX2ZldGNo
KCZhLCAxLCBfX0FUT01JQ19SRUxBWEVEKTsKPiAgwqDCoMKgIF9fYXRvbWljX3RocmVhZF9mZW5j
ZShfX0FUT01JQ19TRVFfQ1NUKTsKPiB9Cj4gCj4geDg2LTY0IGdjYyAxMi4yIC1PMiAtc3RkPWMx
MToKPiAKPiBmY3Q6Cj4gIMKgwqDCoMKgwqDCoMKgIGxvY2sgYWRkwqDCoMKgwqDCoMKgwqAgRFdP
UkQgUFRSIGFbcmlwXSwgMQo+ICDCoMKgwqDCoMKgwqDCoCBsb2NrIG9yIFFXT1JEIFBUUiBbcnNw
XSwgMAo+ICDCoMKgwqDCoMKgwqDCoCByZXQKPiBhOgo+ICDCoMKgwqDCoMKgwqDCoCAuemVyb8Kg
wqAgNAoKdGhhdCdzIGRpc2FwcG9pbnRpbmcuICBJdCdzIHRoZSBzYW1lIGlmIGJvdGggdXNlIF9f
QVRPTUlDX1NFUV9DU1Q6CgppbnQgYTsKCnZvaWQgZmN0KHZvaWQpCnsKICAgICAodm9pZCkgX19h
dG9taWNfYWRkX2ZldGNoKCZhLCAxLCBfX0FUT01JQ19TRVFfQ1NUKTsKICAgICBfX2F0b21pY190
aHJlYWRfZmVuY2UoX19BVE9NSUNfU0VRX0NTVCk7Cn0KCi0+CgpmY3QoKToKICAgICAgICAgbG9j
ayBhZGQgICAgICAgIERXT1JEIFBUUiBhW3JpcF0sIDEKICAgICAgICAgbG9jayBvciBRV09SRCBQ
VFIgW3JzcF0sIDAKICAgICAgICAgcmV0CmE6CiAgICAgICAgIC56ZXJvICAgNAoKb24geDg2LTY0
IGdjYyAxMi4yIC1PMiAtc3RkPWMxMS4gIENsYW5nIGFsc28gZG9lc24ndCBvcHRpbWl6ZSB0aGUg
ZmVuY2UgYXdheS4KCkJlc3Qgd2lzaGVzLCBEdW5jYW4uCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2
QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4v
bGlzdGluZm8vbHR0bmctZGV2Cg==
