Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D3E3C4345F
	for <lttng-dev@archiver.kernel.org>; Thu,  2 May 2024 14:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1714660433;
	bh=fHbLcGKpif635dhx7foqOhFIeMyg8ayvugnFagEznZM=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=pGAzJCKvfAJpwJnQa5ba4UcOd/znQhnU8nGneSHGrQ1ltTRECmivWKfgHvDCaDdIS
	 Xfxj8qFdqdt+S8pUnDO0FyCYkGXws0M1X9Yb3fpmOdwoZ3POtIR1LRs385fTitzoua
	 gMu6b/G6Ho/inGbQlM6iS3d5QCzlNip9SqWprQx73oW2KfmX04zjh/R47jxEsN15gu
	 +sKjemvjVVcOB3QAIJVQgpKVYfMqs0SSY4uqLjMMTigP9egoLyg4fudgdLsOa/u2Sp
	 o8D/XNL5606zS8MagfaYsh3LoDjj+BL2lQ3ZUFkIM7/ROOzprqXhIZfcgKyCOjb9jv
	 Xw/fj5noM/rAw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4VVbz54Pfbz2l07;
	Thu,  2 May 2024 10:33:53 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com
 [IPv6:2607:5300:203:b2ee::31e5])
 by lists.lttng.org (Postfix) with ESMTPS id 4VVbz46ZD7z2l9t
 for <lttng-dev@lists.lttng.org>; Thu,  2 May 2024 10:33:52 -0400 (EDT)
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4VVbz33WqhzxRH;
 Thu,  2 May 2024 10:33:51 -0400 (EDT)
Message-ID: <eb5009ae-c04b-428b-9650-199c6ec5b66a@efficios.com>
Date: Thu, 2 May 2024 10:34:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Michael Jeanson <mjeanson@efficios.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, lttng-dev@lists.lttng.org
References: <20240501234242.2395659-1-bmarzins@redhat.com>
 <2a7f6659-4332-47ed-adbf-45e88915ac6b@efficios.com>
 <1e62350b-a6fc-4581-b386-2c4e6e182433@efficios.com>
Content-Language: en-US
In-Reply-To: <1e62350b-a6fc-4581-b386-2c4e6e182433@efficios.com>
Subject: Re: [lttng-dev] [PATCH urcu] fix: handle EINTR correctly in
 get_cpu_mask_from_sysfs
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

T24gMjAyNC0wNS0wMiAxMDozMiwgTWljaGFlbCBKZWFuc29uIHdyb3RlOgo+IE9uIDIwMjQtMDUt
MDIgMDk6NTQsIE1hdGhpZXUgRGVzbm95ZXJzIHdyb3RlOgo+PiBPbiAyMDI0LTA1LTAxIDE5OjQy
LCBCZW5qYW1pbiBNYXJ6aW5za2kgdmlhIGx0dG5nLWRldiB3cm90ZToKPj4+IElmIHRoZSByZWFk
KCkgaW4gZ2V0X2NwdV9tYXNrX2Zyb21fc3lzZnMoKSBmYWlscyB3aXRoIEVJTlRSLCB0aGUgY29k
ZSBpcwo+Pj4gc3VwcG9zZWQgdG8gcmV0cnksIGJ1dCB0aGUgd2hpbGUgbG9vcCBjb25kaXRpb24g
aGFzIChieXRlc19yZWFkID4gMCksCj4+PiB3aGljaCBpcyBmYWxzZSB3aGVuIHJlYWQoKSBmYWls
cyB3aXRoIEVJTlRSLiBUaGUgcmVzdWx0IGlzIHRoYXQgdGhlIGNvZGUKPj4+IGV4aXRzIHRoZSBs
b29wLCBoYXZpbmcgb25seSByZWFkIHBhcnQgb2YgdGhlIHN0cmluZy4KPj4+Cj4+PiBVc2UgKGJ5
dGVzX3JlYWQgIT0gMCkgaW4gdGhlIHdoaWxlIGxvb3AgY29uZGl0aW9uIGluc3RlYWQsIHNpbmNl
IHRoZQo+Pj4gKGJ5dGVzX3JlYWQgPCAwKSBjYXNlIGlzIGFscmVhZHkgaGFuZGxlZCBpbiB0aGUg
bG9vcC4KPj4KPj4gVGhhbmtzIGZvciB0aGUgZml4ICEgSXQgaXMgaW5kZWVkIHRoZSByaWdodCB0
aGluZyB0byBkby4KPj4KPj4gSSB3b3VsZCBsaWtlIHRvIGludGVncmF0ZSB0aGlzIGZpeCBpbnRv
IHRoZSBsaWJyc2VxIGFuZCBsaWJzaWRlCj4+IHByb2plY3RzIGFzIHdlbGwgdGhvdWdoLCBidXQg
SSBub3RpY2UgdGhlIHRoZSBjb3B5IGluIGxpYnVyY3UKPj4gaXMgTEdQTHYyLjEgd2hlcmVhcyB0
aGUgY29weSBpbiBsaWJyc2VxIGFuZCBsaWJzaWRlIGFyZQo+PiBNSVQuCj4+Cj4+IE1pY2hhZWws
IHNob3VsZCB3ZSBmaXJzdCByZWxpY2Vuc2UgdGhlIGxpYnVyY3Ugc3JjL2NvbXBhdC1zbXAuaAo+
PiBpbXBsZW1lbnRhdGlvbiB0byBNSVQgc28gaXQgbWF0Y2hlcyB0aGUgbGljZW5zZSBvZiB0aGUg
Y29waWVzCj4+IGluIGxpYnJzZXEgYW5kIGxpYnNpZGUgPwo+IAo+IFN1cmUsIHBsZWFzZSBnbyBh
aGVhZC4KCkZvciB0aGUgcmVjb3Jkcywgd2UgYWxzbyBoYXZlIGEgY29weSBvZiB0aGlzIGNvZGUg
aW4gbHR0bmctdXN0LAphbHNvIHVuZGVyIE1JVCBsaWNlbnNlLiBTbyBsaWJ1cmN1J3MgY29weSBp
cyB0aGUgb25seSBvdXRsaWVyCnRoZXJlLgoKVGhhbmtzLAoKTWF0aGlldQoKPiAKPj4gVGhhbmtz
LAo+Pgo+PiBNYXRoaWV1Cj4+Cj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogQmVuamFtaW4gTWFyemlu
c2tpIDxibWFyemluc0ByZWRoYXQuY29tPgo+Pj4gLS0tCj4+PiDCoCBzcmMvY29tcGF0LXNtcC5o
IHwgMiArLQo+Pj4gwqAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL3NyYy9jb21wYXQtc21wLmggYi9zcmMvY29tcGF0LXNt
cC5oCj4+PiBpbmRleCAzMWZhOTc5Li4wNzVhMzMyIDEwMDY0NAo+Pj4gLS0tIGEvc3JjL2NvbXBh
dC1zbXAuaAo+Pj4gKysrIGIvc3JjL2NvbXBhdC1zbXAuaAo+Pj4gQEAgLTE2NCw3ICsxNjQsNyBA
QCBzdGF0aWMgaW5saW5lIGludCBnZXRfY3B1X21hc2tfZnJvbV9zeXNmcyhjaGFyIAo+Pj4gKmJ1
Ziwgc2l6ZV90IG1heF9ieXRlcywgY29uc3QgY2hhCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgdG90
YWxfYnl0ZXNfcmVhZCArPSBieXRlc19yZWFkOwo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGFzc2Vy
dCh0b3RhbF9ieXRlc19yZWFkIDw9IG1heF9ieXRlcyk7Cj4+PiAtwqDCoMKgIH0gd2hpbGUgKG1h
eF9ieXRlcyA+IHRvdGFsX2J5dGVzX3JlYWQgJiYgYnl0ZXNfcmVhZCA+IDApOwo+Pj4gK8KgwqDC
oCB9IHdoaWxlIChtYXhfYnl0ZXMgPiB0b3RhbF9ieXRlc19yZWFkICYmIGJ5dGVzX3JlYWQgIT0g
MCk7Cj4+PiDCoMKgwqDCoMKgIC8qCj4+PiDCoMKgwqDCoMKgwqAgKiBNYWtlIHN1cmUgdGhlIG1h
c2sgcmVhZCBpcyBhIG51bGwgdGVybWluYXRlZCBzdHJpbmcuCj4+Cj4gCgotLSAKTWF0aGlldSBE
ZXNub3llcnMKRWZmaWNpT1MgSW5jLgpodHRwczovL3d3dy5lZmZpY2lvcy5jb20KCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5n
IGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9j
Z2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
