Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD88EC6FD1D
	for <lttng-dev@archiver.kernel.org>; Tue, 21 Mar 2023 20:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1679430048;
	bh=Zsv7wUK9BjoF/YBe5EepFlAIpwQ8uexCvwSuY3EjUO0=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=hswauKvYRABJ8M93VyohmwlKQQTBTK40GAvT/jp1sAhtWoypooUHfe0UVSk5nx27t
	 PljBNETiAUYbr0ZRyX2c6HrFszEthyzTxP2FSxW4VepJswjSgKLE0baYhzf/Hg1noI
	 4XbwIBOj9/5q9dsrkSCMct/+/QOB3sboy4ffWtSIe5eN7NkAD5YLbCWhBZvn2szjc1
	 830n9x7lNXICJom5E5fZVNBcKnT4ElRO2NtmMqpXx5oSfzw4nhpyzzDNJ2nFz+yEP2
	 Sa/LtfHc2V9FKNArnItTe1IboXzg5bhONxb8c3opmVgu/JecMQS+a3SlH7z/RoRjmo
	 lyVrGWZLoiiqA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Ph2zh3Sssz2HCH;
	Tue, 21 Mar 2023 16:20:48 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4Ph2zg5LXFz2HBy
 for <lttng-dev@lists.lttng.org>; Tue, 21 Mar 2023 16:20:46 -0400 (EDT)
Received: from [172.16.0.188] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4Ph2z40GMQzsdP;
 Tue, 21 Mar 2023 16:20:16 -0400 (EDT)
Message-ID: <37b3c295-77a8-2341-2b26-f82005a26345@efficios.com>
Date: Tue, 21 Mar 2023 16:20:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To: =?UTF-8?B?T25kxZllaiBTdXLDvQ==?= <ondrej@sury.org>,
 lttng-dev@lists.lttng.org
References: <20230321145146.1095875-1-ondrej@sury.org>
In-Reply-To: <20230321145146.1095875-1-ondrej@sury.org>
Subject: Re: [lttng-dev] [PATCH 7/7] Fix: uatomic_or() need retyping to
 uintptr_t in rculfhash.c
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

T24gMjAyMy0wMy0yMSAxMDo1MSwgT25kxZllaiBTdXLDvSB2aWEgbHR0bmctZGV2IHdyb3RlOgo+
IFdoZW4gYWRkaW5nIFJFTU9WRURfRkxBRyB0byB0aGUgcG9pbnRlcnMgaW4gdGhlIHJjdWxmaGFz
aAo+IGltcGxlbWVudGF0aW9uLCByZXR5cGUgdGhlIGdlbmVyaWMgcG9pbnRlciB0byB1bnNpZ25l
ZCBsb25nIHRvIGZpeCB0aGUKPiBmb2xsb3dpbmcgY29tcGlsZXIgZXJyb3I6CgpZb3Ugd2lsbCBu
ZWVkIHRvIHVwZGF0ZSB0aGUgcGF0Y2ggc3ViamVjdCBhcyB3ZWxsLgoKVGhhbmtzLAoKTWF0aGll
dQoKPiAKPiByY3VsZmhhc2guYzoxMjAxOjI6IGVycm9yOiBhZGRyZXNzIGFyZ3VtZW50IHRvIGF0
b21pYyBvcGVyYXRpb24gbXVzdCBiZSBhIHBvaW50ZXIgdG8gaW50ZWdlciAoJ3N0cnVjdCBjZHNf
bGZodF9ub2RlICoqJyBpbnZhbGlkKQo+ICAgICAgICAgdWF0b21pY19vcigmbm9kZS0+bmV4dCwg
UkVNT1ZFRF9GTEFHKTsKPiAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn4KPiAuLi9pbmNsdWRlL3VyY3UvdWF0b21pYy5oOjYwOjg6IG5vdGU6IGV4cGFuZGVkIGZy
b20gbWFjcm8gJ3VhdG9taWNfb3InCj4gICAgICAgICAodm9pZClfX2F0b21pY19vcl9mZXRjaCgo
YWRkciksIChtYXNrKSwgX19BVE9NSUNfUkVMQVhFRCkKPiAgICAgICAgICAgICAgIF4gICAgICAg
ICAgICAgICAgIH5+fn5+fgo+IHJjdWxmaGFzaC5jOjE0NDQ6MzogZXJyb3I6IGFkZHJlc3MgYXJn
dW1lbnQgdG8gYXRvbWljIG9wZXJhdGlvbiBtdXN0IGJlIGEgcG9pbnRlciB0byBpbnRlZ2VyICgn
c3RydWN0IGNkc19sZmh0X25vZGUgKionIGludmFsaWQpCj4gICAgICAgICAgICAgICAgIHVhdG9t
aWNfb3IoJmZpbmlfYnVja2V0LT5uZXh0LCBSRU1PVkVEX0ZMQUcpOwo+ICAgICAgICAgICAgICAg
ICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgo+IC4uL2luY2x1
ZGUvdXJjdS91YXRvbWljLmg6NjA6ODogbm90ZTogZXhwYW5kZWQgZnJvbSBtYWNybyAndWF0b21p
Y19vcicKPiAgICAgICAgICh2b2lkKV9fYXRvbWljX29yX2ZldGNoKChhZGRyKSwgKG1hc2spLCBf
X0FUT01JQ19SRUxBWEVEKQo+ICAgICAgICAgICAgICAgXiAgICAgICAgICAgICAgICAgfn5+fn5+
Cj4gCj4gVGhpcyB3YXMgbm90IGEgcHJvYmxlbSBiZWZvcmUgYmVjYXVzZSB0aGUgd2F5IHRoZSB1
YXRvbWljX29yIHdhcwo+IGltcGxlbWVudGVkLCBidXQgbm93IHdlIGRpcmVjdGx5IHBhc3MgdGhl
IGFkZHIgdG8gX19hdG9taWNfb3JfZmV0Y2goKQo+IGFuZCB0aGUgY29tcGlsZXIgZG9lc24ndCBs
aWtlIHRoZSBpbXBsaWNpdCBjb252ZXJzaW9uIGZyb20gcG9pbnRlciB0bwo+IHBvaW50ZXIgdG8g
aW50ZWdlci4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBPbmTFmWVqIFN1csO9IDxvbmRyZWpAc3VyeS5v
cmc+Cj4gLS0tCj4gICBzcmMvcmN1bGZoYXNoLmMgfCA0ICsrLS0KPiAgIDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL3NyYy9y
Y3VsZmhhc2guYyBiL3NyYy9yY3VsZmhhc2guYwo+IGluZGV4IGI0NTY0MTUuLjUyOTI3MjUgMTAw
NjQ0Cj4gLS0tIGEvc3JjL3JjdWxmaGFzaC5jCj4gKysrIGIvc3JjL3JjdWxmaGFzaC5jCj4gQEAg
LTExOTgsNyArMTE5OCw3IEBAIGludCBfY2RzX2xmaHRfZGVsKHN0cnVjdCBjZHNfbGZodCAqaHQs
IHVuc2lnbmVkIGxvbmcgc2l6ZSwKPiAgIAkgKiBLbm93aW5nIHdoaWNoIHdpbnMgdGhlIHJhY2Ug
d2lsbCBiZSBrbm93biBhZnRlciB0aGUgZ2FyYmFnZQo+ICAgCSAqIGNvbGxlY3Rpb24gcGhhc2Us
IHN0YXkgdHVuZWQhCj4gICAJICovCj4gLQl1YXRvbWljX29yKCZub2RlLT5uZXh0LCBSRU1PVkVE
X0ZMQUcpOwo+ICsJdWF0b21pY19vcigodW5zaWduZWQgbG9uZyAqKSZub2RlLT5uZXh0LCBSRU1P
VkVEX0ZMQUcpOwo+ICAgCS8qIFdlIHBlcmZvcm1lZCB0aGUgKGxvZ2ljYWwpIGRlbGV0aW9uLiAq
Lwo+ICAgCj4gICAJLyoKPiBAQCAtMTQ0MSw3ICsxNDQxLDcgQEAgdm9pZCByZW1vdmVfdGFibGVf
cGFydGl0aW9uKHN0cnVjdCBjZHNfbGZodCAqaHQsIHVuc2lnbmVkIGxvbmcgaSwKPiAgIAkJZGJn
X3ByaW50ZigicmVtb3ZlIGVudHJ5OiBvcmRlciAlbHUgaW5kZXggJWx1IGhhc2ggJWx1XG4iLAo+
ICAgCQkJICAgaSwgaiwgaik7Cj4gICAJCS8qIFNldCB0aGUgUkVNT1ZFRF9GTEFHIHRvIGZyZWV6
ZSB0aGUgLT5uZXh0IGZvciBnYyAqLwo+IC0JCXVhdG9taWNfb3IoJmZpbmlfYnVja2V0LT5uZXh0
LCBSRU1PVkVEX0ZMQUcpOwo+ICsJCXVhdG9taWNfb3IoKHVuc2lnbmVkIGxvbmcgKikmZmluaV9i
dWNrZXQtPm5leHQsIFJFTU9WRURfRkxBRyk7Cj4gICAJCV9jZHNfbGZodF9nY19idWNrZXQocGFy
ZW50X2J1Y2tldCwgZmluaV9idWNrZXQpOwo+ICAgCX0KPiAgIAlodC0+Zmxhdm9yLT5yZWFkX3Vu
bG9jaygpOwoKLS0gCk1hdGhpZXUgRGVzbm95ZXJzCkVmZmljaU9TIEluYy4KaHR0cHM6Ly93d3cu
ZWZmaWNpb3MuY29tCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0
cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
