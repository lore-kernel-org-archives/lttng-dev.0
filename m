Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B88CAC7618A
	for <lttng-dev@archiver.kernel.org>; Mon, 20 Mar 2023 18:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1679335598;
	bh=7mvogJmP0pG73NdWPt/ejQWZEFTM9FAkX3IMSw8pIrk=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=U2k7wb3RGuUVn8Ig2xxfr6f4Yblhpa1Gk/vLNp68IFlcyD5jacXqnLG/vEorQCih6
	 /dRcTrtpjn0Vai9bH/eH6Fk0Qxl9bzOrNHPibXvFsxbBPefmRYLy/vI85HomM3hTBV
	 4Z1CEDI6i73DdwwXVzK8ANgFj0v3xVgga0fZ9xP/E0BS9B6F5ttIHbeAt/zbAcVvv3
	 dRNxVljEjdJdghWYnqgPlX5DvQkMPX1diQcFlNIqReC29UQopibKh9OhcFGVDafGSZ
	 Repygby2kBLzxm9/6iR9prlX3iVIDQ+TkF+8E5XhaKgJj76PY2s9I/Vyr9XSYgyJxb
	 3zHwxJiPbIAPQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4PgN3L04P9z2GbX;
	Mon, 20 Mar 2023 14:06:37 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4PgN3J3phXz2GVc
 for <lttng-dev@lists.lttng.org>; Mon, 20 Mar 2023 14:06:36 -0400 (EDT)
Received: from [172.16.0.188] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4PgN2j09cwzrHD;
 Mon, 20 Mar 2023 14:06:05 -0400 (EDT)
Message-ID: <046ee03d-6257-7424-e8ef-a0e92ab54018@efficios.com>
Date: Mon, 20 Mar 2023 14:06:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To: =?UTF-8?B?T25kxZllaiBTdXLDvQ==?= <ondrej@sury.org>,
 lttng-dev@lists.lttng.org, paulmck <paulmck@kernel.org>
References: <20230317213755.455957-1-ondrej@sury.org>
 <20230317213755.455957-4-ondrej@sury.org>
In-Reply-To: <20230317213755.455957-4-ondrej@sury.org>
Subject: Re: [lttng-dev] [PATCH 3/7] Use __atomic_thread_fence() for
 cmm_barrier()
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

T24gMjAyMy0wMy0xNyAxNzozNywgT25kxZllaiBTdXLDvSB2aWEgbHR0bmctZGV2IHdyb3RlOgo+
IFVzZSBfX2F0b21pY190aHJlYWRfZmVuY2UoX19BVE9NSUNfQUNRX1JFTCkgZm9yIGNtbV9iYXJy
aWVyKCksIHNvCj4gVGhyZWFkU2FuaXRpemVyIGNhbiB1bmRlcnN0YW5kIHRoZSBtZW1vcnkgc3lu
Y2hyb25pemF0aW9uLgoKWW91IHNob3VsZCB1cGRhdGUgdGhlIHBhdGNoIHN1YmplY3QgYW5kIGNv
bW1pdCBtZXNzYWdlIHRvIHJlcGxhY2UgCiJ0aHJlYWQiIGJ5ICJzaWduYWwiLgoKPiAKPiBGSVhN
RTogV2hhdCBzaG91bGQgYmUgdGhlIGNvcnJlY3QgbWVtb3J5IG9yZGVyaW5nIGhlcmU/CgpBQ1Ff
UkVMIGlzIHdoYXQgd2Ugd2FudCBoZXJlLCBJIHRoaW5rIHRoaXMgaXMgZmluZS4gV2Ugd2FudCB0
byBwcmV2ZW50CnRoZSBjb21waWxlciBmcm9tIHJlb3JkZXJpbmcgbG9hZHMvc3RvcmVzIGFjcm9z
cyB0aGUgZmVuY2UsIGJ1dCBkb24ndAp3YW50IGFueSBiYXJyaWVyIGluc3RydWN0aW9ucyBpc3N1
ZWQuCgpUaGFua3MsCgpNYXRoaWV1Cgo+IAo+IFNpZ25lZC1vZmYtYnk6IE9uZMWZZWogU3Vyw70g
PG9uZHJlakBzdXJ5Lm9yZz4KPiAtLS0KPiAgIGluY2x1ZGUvdXJjdS9jb21waWxlci5oIHwgMyAr
Ky0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiAK
PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91cmN1L2NvbXBpbGVyLmggYi9pbmNsdWRlL3VyY3UvY29t
cGlsZXIuaAo+IGluZGV4IDJmMzJiMzguLmVkZTkwOWYgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS91
cmN1L2NvbXBpbGVyLmgKPiArKysgYi9pbmNsdWRlL3VyY3UvY29tcGlsZXIuaAo+IEBAIC0yOCw3
ICsyOCw4IEBACj4gICAjZGVmaW5lIGNhYV9saWtlbHkoeCkJX19idWlsdGluX2V4cGVjdCghISh4
KSwgMSkKPiAgICNkZWZpbmUgY2FhX3VubGlrZWx5KHgpCV9fYnVpbHRpbl9leHBlY3QoISEoeCks
IDApCj4gICAKPiAtI2RlZmluZQljbW1fYmFycmllcigpCV9fYXNtX18gX192b2xhdGlsZV9fICgi
IiA6IDogOiAibWVtb3J5IikKPiArLyogRklYTUU6IFdoYXQgd291bGQgYmUgYSBjb3JyZWN0IG1l
bW9yeSBvcmRlcmluZyBoZXJlPyAqLwo+ICsjZGVmaW5lCWNtbV9iYXJyaWVyKCkJX19hdG9taWNf
c2lnbmFsX2ZlbmNlKF9fQVRPTUlDX0FDUV9SRUwpCj4gICAKPiAgIC8qCj4gICAgKiBJbnN0cnVj
dCB0aGUgY29tcGlsZXIgdG8gcGVyZm9ybSBvbmx5IGEgc2luZ2xlIGFjY2VzcyB0byBhIHZhcmlh
YmxlCgotLSAKTWF0aGlldSBEZXNub3llcnMKRWZmaWNpT1MgSW5jLgpodHRwczovL3d3dy5lZmZp
Y2lvcy5jb20KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Cmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczov
L2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
