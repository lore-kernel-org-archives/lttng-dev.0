Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B55C74A5B
	for <lttng-dev@archiver.kernel.org>; Tue, 21 Mar 2023 14:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1679410005;
	bh=gcG9ygj7PUIEuru+0pk+PEtRhjlV7AgfpFrcO3IwWCo=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Ay+PIRZuj6g8AJ1LJw5ZgwsIWJ/jAitU4w5+rK5NLTWWIKp+5Co1YoGYIEG9CkRVs
	 /vm7RnfQ781Q/imvo86ORAaAQW2NKHJ2xhE27NEk5JEBBGysI0x2IJk6zZhBU3/Xxj
	 9dh9P5eZLTHCEVQNEt3qJdnGTshputcNXN+fAWTSBvrFR7bq4xOD5hPb3i2Kzk4u6I
	 rzoKoZnU1vhgPB9dcJFdmdyYChBGVYCzzq1C6bYEVtwa6s2ePUeCE9UWyzP9t7J+aM
	 x5+AgvJobqRFoGX0qSG4xrW/LvibYXuCmp0Z1VVKjDeVlt9DVpdj0icURV6BkW5tE7
	 gLnRZjo0lzh8w==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4PgvZF3jSyz2GnF;
	Tue, 21 Mar 2023 10:46:45 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4PgvZC2nzLz2H9w
 for <lttng-dev@lists.lttng.org>; Tue, 21 Mar 2023 10:46:43 -0400 (EDT)
Received: from [172.16.0.188] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4PgvZB0BBdzr5C;
 Tue, 21 Mar 2023 10:46:42 -0400 (EDT)
Message-ID: <66635c75-b869-9704-edac-21026cce2b99@efficios.com>
Date: Tue, 21 Mar 2023 10:46:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To: =?UTF-8?B?T25kxZllaiBTdXLDvQ==?= <ondrej@sury.org>
Cc: lttng-dev@lists.lttng.org, paulmck <paulmck@kernel.org>
References: <20230317213755.455957-1-ondrej@sury.org>
 <20230317213755.455957-8-ondrej@sury.org>
 <e7384cff-06a6-6e1e-9abc-ce7932760964@efficios.com>
 <A012AAA8-7E40-40A3-A272-1703EFA26314@sury.org>
In-Reply-To: <A012AAA8-7E40-40A3-A272-1703EFA26314@sury.org>
Subject: Re: [lttng-dev] [PATCH 7/7] Experiment: Add explicit memory barrier
 in free_completion()
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

T24gMjAyMy0wMy0yMSAwNjoyMSwgT25kxZllaiBTdXLDvSB3cm90ZToKPj4gT24gMjAuIDMuIDIw
MjMsIGF0IDE5OjM3LCBNYXRoaWV1IERlc25veWVycyA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNp
b3MuY29tPiB3cm90ZToKPj4KPj4gT24gMjAyMy0wMy0xNyAxNzozNywgT25kxZllaiBTdXLDvSB2
aWEgbHR0bmctZGV2IHdyb3RlOgo+Pj4gRklYTUU6IFRoaXMgaXMgZXhwZXJpbWVudCB0aGF0IGFk
ZHMgZXhwbGljaXQgbWVtb3J5IGJhcnJpZXIgaW4gdGhlCj4+PiBmcmVlX2NvbXBsZXRpb24gaW4g
dGhlIHdvcmtxdWV1ZS5jLCBzbyBUaHJlYWRTYW5pdGl6ZXIga25vd3MgaXQncyBvayB0bwo+Pj4g
ZnJlZSB0aGUgcmVzb3VyY2VzLgo+Pj4gU2lnbmVkLW9mZi1ieTogT25kxZllaiBTdXLDvSA8b25k
cmVqQHN1cnkub3JnPgo+Pj4gLS0tCj4+PiAgIHNyYy93b3JrcXVldWUuYyB8IDEgKwo+Pj4gICAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPj4+IGRpZmYgLS1naXQgYS9zcmMvd29ya3F1
ZXVlLmMgYi9zcmMvd29ya3F1ZXVlLmMKPj4+IGluZGV4IDEwMzlkNzIuLmYyMTkwN2YgMTAwNjQ0
Cj4+PiAtLS0gYS9zcmMvd29ya3F1ZXVlLmMKPj4+ICsrKyBiL3NyYy93b3JrcXVldWUuYwo+Pj4g
QEAgLTM3Nyw2ICszNzcsNyBAQCB2b2lkIGZyZWVfY29tcGxldGlvbihzdHJ1Y3QgdXJjdV9yZWYg
KnJlZikKPj4+ICAgIHN0cnVjdCB1cmN1X3dvcmtxdWV1ZV9jb21wbGV0aW9uICpjb21wbGV0aW9u
Owo+Pj4gICAgICBjb21wbGV0aW9uID0gY2FhX2NvbnRhaW5lcl9vZihyZWYsIHN0cnVjdCB1cmN1
X3dvcmtxdWV1ZV9jb21wbGV0aW9uLCByZWYpOwo+Pj4gKyBhc3NlcnQoIXVyY3VfcmVmX2dldF91
bmxlc3NfemVybygmY29tcGxldGlvbi0+cmVmKSk7Cj4+Cj4+IFBlcmhhcHMgd2hhdCB3ZSByZWFs
bHkgd2FudCBoZXJlIGlzIGFuIEFOTk9UQVRFX1VOUFVCTElTSF9NRU1PUllfUkFOR0UoKSBvZiBz
b21lIHNvcnQgPwo+IAo+IEkgZ3Vlc3M/Cj4gCj4gTXkgZXhwZXJpZW5jZSB3aXRoIFRTQU4gdGVs
bHMgbWUsIHRoYXQgeW91IG5lZWQgc29tZSBraW5kIG9mIG1lbW9yeSBiYXJyaWVyIHdoZW4gdXNp
bmcgYWNxdWlyZS1yZWxlYXNlCj4gc2VtYW50aWNzIGFuZCB5b3UgZG86Cj4gCj4gaWYgKF9fYXRv
bWljX3N1Yl9mZXRjaChvYmotPnJlZiwgX19BVE9NSUNfUkVMRUFTRSkgPT0gMCkgewo+ICAgIC8q
IF9fQVRPTUlDX0FDUVVJUkUgbmVlZGVkIGhlcmUgKi8KPiAgICAgZnJlZShvYmopOwo+IH0KPiAK
PiB3ZSBlbmQgdXAgdXNpbmcgZm9sbG93aW5nIGNvZGUgaW4gQklORCA5Ogo+IAo+IGlmIChfX2F0
b21pY19zdWJfZmV0Y2gob2JqLT5yZWYsIF9fQVRPTUlDX0FDUV9SRUwpID09IDApIHsKPiAgICAg
ZnJlZShvYmopOwo+IH0KPiAKPiBTbywgSSBhbSBndWVzc2luZyBhZnRlciB0aGUgY2hhbmdlIG9m
IHVhdG9taWNfc3ViX3JldHVybigpIHRvIF9fQVRPTUlDX0FDUV9SRUwsCj4gdGhpcyBwYXRjaCBz
aG91bGQgbm8gbG9uZ2VyIGJlIG5lZWRlZC4KCkFjdHVhbGx5IHdlIHdhbnQgX19BVE9NSUNfU0VR
X0NTVCwgd2hpY2ggaXMgZXZlbiBzdHJvbmdlciB0aGFuIEFDUV9SRUwuCgpUaGFua3MsCgpNYXRo
aWV1Cgo+IAo+IE9uZHJlago+IC0tCj4gT25kxZllaiBTdXLDvSAoSGUvSGltKQo+IG9uZHJlakBz
dXJ5Lm9yZwo+IAoKLS0gCk1hdGhpZXUgRGVzbm95ZXJzCkVmZmljaU9TIEluYy4KaHR0cHM6Ly93
d3cuZWZmaWNpb3MuY29tCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcK
aHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRl
dgo=
