Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF2BC6FD1D
	for <lttng-dev@archiver.kernel.org>; Mon, 20 Mar 2023 18:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1679336080;
	bh=KSeL3XWtBFdlqXesIVIKc8Zr6OBTw4xxhMT+jKRuugU=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=nBp5fUXdkBxjQsX+JmyAM84v65icp6LwmPCeFTwwHWTHkcGMwokVBURgbI8ocXpMF
	 3fRTwx8Ir6zBwrSc7x1S8khjF6+JpzEmgT7tBcNpP81YSthGsDX+wz6rLPSXJnfwmj
	 8zLlDikOi5O58BpQSjHdopcFO5o1OKh24ABAeWItD0kpUOB5FndSe4yG4Dl733nVeO
	 uxAtODp3V6zYMAkpohYExJiVHHIp+f5InVAlU3MPXJV6dPxeeo9ojhRu8GCBmgk28a
	 xzMum2Ga67sUs4Cpk5z9ncvIUk0TAz8IRdtXyHgcMyzFeOOR8T6qBfXBORZ8LIWGG0
	 1Puf/LRQhUNXA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4PgNDc1gMgz2Gbb;
	Mon, 20 Mar 2023 14:14:40 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4PgNDZ05YYz2GbY
 for <lttng-dev@lists.lttng.org>; Mon, 20 Mar 2023 14:14:38 -0400 (EDT)
Received: from [172.16.0.188] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4PgNDY5jVGzrF9;
 Mon, 20 Mar 2023 14:14:37 -0400 (EDT)
Message-ID: <2698470a-d694-9ad7-a479-e3da1ad690a3@efficios.com>
Date: Mon, 20 Mar 2023 14:14:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To: =?UTF-8?B?T25kxZllaiBTdXLDvQ==?= <ondrej@sury.org>,
 lttng-dev@lists.lttng.org, paulmck <paulmck@kernel.org>
References: <20230317213755.455957-1-ondrej@sury.org>
 <20230317213755.455957-4-ondrej@sury.org>
 <046ee03d-6257-7424-e8ef-a0e92ab54018@efficios.com>
In-Reply-To: <046ee03d-6257-7424-e8ef-a0e92ab54018@efficios.com>
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

T24gMjAyMy0wMy0yMCAxNDowNiwgTWF0aGlldSBEZXNub3llcnMgdmlhIGx0dG5nLWRldiB3cm90
ZToKPiBPbiAyMDIzLTAzLTE3IDE3OjM3LCBPbmTFmWVqIFN1csO9IHZpYSBsdHRuZy1kZXYgd3Jv
dGU6Cj4+IFVzZSBfX2F0b21pY190aHJlYWRfZmVuY2UoX19BVE9NSUNfQUNRX1JFTCkgZm9yIGNt
bV9iYXJyaWVyKCksIHNvCj4+IFRocmVhZFNhbml0aXplciBjYW4gdW5kZXJzdGFuZCB0aGUgbWVt
b3J5IHN5bmNocm9uaXphdGlvbi4KPiAKPiBZb3Ugc2hvdWxkIHVwZGF0ZSB0aGUgcGF0Y2ggc3Vi
amVjdCBhbmQgY29tbWl0IG1lc3NhZ2UgdG8gcmVwbGFjZSAKPiAidGhyZWFkIiBieSAic2lnbmFs
Ii4KPiAKPj4KPj4gRklYTUU6IFdoYXQgc2hvdWxkIGJlIHRoZSBjb3JyZWN0IG1lbW9yeSBvcmRl
cmluZyBoZXJlPwo+IAo+IEFDUV9SRUwgaXMgd2hhdCB3ZSB3YW50IGhlcmUsIEkgdGhpbmsgdGhp
cyBpcyBmaW5lLiBXZSB3YW50IHRvIHByZXZlbnQKPiB0aGUgY29tcGlsZXIgZnJvbSByZW9yZGVy
aW5nIGxvYWRzL3N0b3JlcyBhY3Jvc3MgdGhlIGZlbmNlLCBidXQgZG9uJ3QKPiB3YW50IGFueSBi
YXJyaWVyIGluc3RydWN0aW9ucyBpc3N1ZWQuCgpXZSBzaG91bGQgcHJvYmFibHkgbWFrZSBpdCBT
RVFfQ1NUIGhlcmUgYXMgd2VsbCwgZXZlbiB0aG91Z2ggSSBkb3VidCBpdCAKY2hhbmdlcyBhbnl0
aGluZyBpbiB0aGlzIHZlcnkgcGFydGljdWxhciBjYXNlIG9mIGF0b21pY19zaWduYWxfZmVuY2Uu
CgpUaGFua3MsCgpNYXRoaWV1Cgo+IAo+IFRoYW5rcywKPiAKPiBNYXRoaWV1Cj4gCj4+Cj4+IFNp
Z25lZC1vZmYtYnk6IE9uZMWZZWogU3Vyw70gPG9uZHJlakBzdXJ5Lm9yZz4KPj4gLS0tCj4+IMKg
IGluY2x1ZGUvdXJjdS9jb21waWxlci5oIHwgMyArKy0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91
cmN1L2NvbXBpbGVyLmggYi9pbmNsdWRlL3VyY3UvY29tcGlsZXIuaAo+PiBpbmRleCAyZjMyYjM4
Li5lZGU5MDlmIDEwMDY0NAo+PiAtLS0gYS9pbmNsdWRlL3VyY3UvY29tcGlsZXIuaAo+PiArKysg
Yi9pbmNsdWRlL3VyY3UvY29tcGlsZXIuaAo+PiBAQCAtMjgsNyArMjgsOCBAQAo+PiDCoCAjZGVm
aW5lIGNhYV9saWtlbHkoeCnCoMKgwqAgX19idWlsdGluX2V4cGVjdCghISh4KSwgMSkKPj4gwqAg
I2RlZmluZSBjYWFfdW5saWtlbHkoeCnCoMKgwqAgX19idWlsdGluX2V4cGVjdCghISh4KSwgMCkK
Pj4gLSNkZWZpbmXCoMKgwqAgY21tX2JhcnJpZXIoKcKgwqDCoCBfX2FzbV9fIF9fdm9sYXRpbGVf
XyAoIiIgOiA6IDogIm1lbW9yeSIpCj4+ICsvKiBGSVhNRTogV2hhdCB3b3VsZCBiZSBhIGNvcnJl
Y3QgbWVtb3J5IG9yZGVyaW5nIGhlcmU/ICovCj4+ICsjZGVmaW5lwqDCoMKgIGNtbV9iYXJyaWVy
KCnCoMKgwqAgX19hdG9taWNfc2lnbmFsX2ZlbmNlKF9fQVRPTUlDX0FDUV9SRUwpCj4+IMKgIC8q
Cj4+IMKgwqAgKiBJbnN0cnVjdCB0aGUgY29tcGlsZXIgdG8gcGVyZm9ybSBvbmx5IGEgc2luZ2xl
IGFjY2VzcyB0byBhIHZhcmlhYmxlCj4gCgotLSAKTWF0aGlldSBEZXNub3llcnMKRWZmaWNpT1Mg
SW5jLgpodHRwczovL3d3dy5lZmZpY2lvcy5jb20KCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxp
c3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlz
dGluZm8vbHR0bmctZGV2Cg==
