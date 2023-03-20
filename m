Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C7CC6FD1D
	for <lttng-dev@archiver.kernel.org>; Mon, 20 Mar 2023 18:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1679337525;
	bh=rnjgTjYzCrbN7cQlzPfTSxCB/7yBo66FQK4mi4lOnok=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=XlPymoxdIPRi9nktds33nIr4qfqmIMlObW3jZP/rcYuIfr3njtLsRv95RcpPPPYB4
	 iExjqZzQSwMqOde+g8sHgqLy5jUv9nkvZUWmS+kdKXGnvwpVm3LZk2JJ/TG4PgvwEz
	 dOHY/Smj4enX3yMAvkCj2KkSIbYF/Ilvwwh+pO5vqXiokh+zYhFhvyGEbFX0mFqVWY
	 yRwahkBV30M5OggYucV2Fk298z92PQECFK2fwdwpVzt4tJwKAmduvTqyYBXtvfcV7e
	 NrOGco3zmAMPq4kDlprpTKPBiftZ9yzI3Z5XdHhl6b8IxgwiszRR5Aumlqt63MJWrU
	 igniTJJgQcu8w==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4PgNmN5d97z2Gkl;
	Mon, 20 Mar 2023 14:38:44 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4PgNmM3RSvz2Dkb
 for <lttng-dev@lists.lttng.org>; Mon, 20 Mar 2023 14:38:43 -0400 (EDT)
Received: from [172.16.0.188] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4PgNmM14RbzqxS;
 Mon, 20 Mar 2023 14:38:43 -0400 (EDT)
Message-ID: <912a8dd5-0451-1d11-7ffa-dd1094658c44@efficios.com>
Date: Mon, 20 Mar 2023 14:38:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To: =?UTF-8?B?T25kxZllaiBTdXLDvQ==?= <ondrej@sury.org>
Cc: lttng-dev@lists.lttng.org, paulmck <paulmck@kernel.org>
References: <20230317213755.455957-1-ondrej@sury.org>
 <20230317213755.455957-3-ondrej@sury.org>
 <6d73ed33-f3fc-2459-a7e9-142b8908ad4f@efficios.com>
 <5C9355A4-AE1B-45B5-915E-D41C45A488BE@sury.org>
In-Reply-To: <5C9355A4-AE1B-45B5-915E-D41C45A488BE@sury.org>
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
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

T24gMjAyMy0wMy0yMCAxNDoyOCwgT25kxZllaiBTdXLDvSB3cm90ZToKPiAKPj4gT24gMjAuIDMu
IDIwMjMsIGF0IDE5OjAzLCBNYXRoaWV1IERlc25veWVycyA8bWF0aGlldS5kZXNub3llcnNAZWZm
aWNpb3MuY29tPiB3cm90ZToKPj4KPj4gSW4gZG9jL3VhdG9taWMtYXBpLm1kLCB3ZSBkb2N1bWVu
dDoKPj4KPj4gImBgYGMKPj4gdHlwZSB1YXRvbWljX2NtcHhjaGcodHlwZSAqYWRkciwgdHlwZSBv
bGQsIHR5cGUgbmV3KTsKPj4gYGBgCj4+Cj4+IEFuIGF0b21pYyByZWFkLW1vZGlmeS13cml0ZSBv
cGVyYXRpb24gdGhhdCBwZXJmb3JtcyB0aGlzCj4+IHNlcXVlbmNlIG9mIG9wZXJhdGlvbnMgYXRv
bWljYWxseTogY2hlY2sgaWYgYGFkZHJgIGNvbnRhaW5zIGBvbGRgLgo+PiBJZiB0cnVlLCB0aGVu
IHJlcGxhY2UgdGhlIGNvbnRlbnQgb2YgYGFkZHJgIGJ5IGBuZXdgLiBSZXR1cm4gdGhlCj4+IHZh
bHVlIHByZXZpb3VzbHkgY29udGFpbmVkIGJ5IGBhZGRyYC4gVGhpcyBmdW5jdGlvbiBpbXBsaWVz
IGEgZnVsbAo+PiBtZW1vcnkgYmFycmllciBiZWZvcmUgYW5kIGFmdGVyIHRoZSBhdG9taWMgb3Bl
cmF0aW9uLiIKPj4KPj4gVGhpcyB3b3VsZCBtYXAgdG8gYSAiX19BVE9NSUNfQUNRX1JFTCIgc2Vt
YW50aWMgb24gY21weGNoZyBmYWlsdXJlCj4+IHJhdGhlciB0aGFuIF9fQVRPTUlDX0NPTlNVTUUi
Lgo+IAo+IAo+IEZyb206IGh0dHBzOi8vZ2NjLmdudS5vcmcvb25saW5lZG9jcy9nY2MvXzAwNWZf
MDA1ZmF0b21pYy1CdWlsdGlucy5odG1sCj4gCj4+IElmIGRlc2lyZWQgaXMgd3JpdHRlbiBpbnRv
ICpwdHIgdGhlbiB0cnVlIGlzIHJldHVybmVkIGFuZCBtZW1vcnkgaXMgYWZmZWN0ZWQgYWNjb3Jk
aW5nIHRvIHRoZSBtZW1vcnkgb3JkZXIgc3BlY2lmaWVkIGJ5IHN1Y2Nlc3NfbWVtb3JkZXIuIFRo
ZXJlIGFyZSBubyByZXN0cmljdGlvbnMgb24gd2hhdCBtZW1vcnkgb3JkZXIgY2FuIGJlIHVzZWQg
aGVyZS4KPj4KPj4gT3RoZXJ3aXNlLCBmYWxzZSBpcyByZXR1cm5lZCBhbmQgbWVtb3J5IGlzIGFm
ZmVjdGVkIGFjY29yZGluZyB0byBmYWlsdXJlX21lbW9yZGVyLiBUaGlzIG1lbW9yeSBvcmRlciBj
YW5ub3QgYmUgX19BVE9NSUNfUkVMRUFTRSBub3IgX19BVE9NSUNfQUNRX1JFTC4gSXQgYWxzbyBj
YW5ub3QgYmUgYSBzdHJvbmdlciBvcmRlciB0aGFuIHRoYXQgc3BlY2lmaWVkIGJ5IHN1Y2Nlc3Nf
bWVtb3JkZXIuCj4gCj4gSSB0aGluayBpdCBtYWtlcyBzZW5zZSB0aGF0IHRoZSBmYWlsdXJlX21l
bW9yZGVyIGhhcyB0aGUgc2FtZSBtZW1vcmRlciBhcyB1YXRvbWljX3JlYWQoKSwgYnV0IGl0IGRl
ZmluaXRlbGx5IGNhbm5vdCBiZSBfX0FUT01JQ19BQ1FfUkVMIC0gaXQncyBzYW1lIGFzIHdpdGgg
X19hdG9taWNfbG9hZF9uLCBvbmx5IGZvbGxvd2luZyBhcmUgcGVybWl0dGVkOgo+IAo+PiBUaGUg
dmFsaWQgbWVtb3J5IG9yZGVyIHZhcmlhbnRzIGFyZSBfX0FUT01JQ19SRUxBWEVELCBfX0FUT01J
Q19TRVFfQ1NULCBfX0FUT01JQ19BQ1FVSVJFLCBhbmQgX19BVE9NSUNfQ09OU1VNRS4KCkJhc2Vk
IG9uIG15IG90aGVyIHJlcGx5LCB3ZSB3YW50ICJTRVFfQ1NUIiByYXRoZXIgdGhhbiBBQ1FfUkVM
IGV2ZXJ5d2hlcmUuCgpUaGFua3MsCgpNYXRoaWV1Cgo+IAo+IE9uZHJlago+IC0tCj4gT25kxZll
aiBTdXLDvSAoSGUvSGltKQo+IG9uZHJlakBzdXJ5Lm9yZwo+IAoKLS0gCk1hdGhpZXUgRGVzbm95
ZXJzCkVmZmljaU9TIEluYy4KaHR0cHM6Ly93d3cuZWZmaWNpb3MuY29tCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0
Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJp
bi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
