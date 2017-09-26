From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules] Fix: vmalloc wrapper on
	kernel >= 4.12
Date: Tue, 26 Sep 2017 18:00:31 +0000 (UTC)
Message-ID: <1388224206.18998.1506448831312.JavaMail.zimbra__5759.11372802711$1506448771$gmane$org@efficios.com>
References: <1506447990-27525-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3y1pcX1L0lzvCr
 for <lttng-dev@lists.lttng.org>; Tue, 26 Sep 2017 17:59:24 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id EC6703403A8
 for <lttng-dev@lists.lttng.org>; Tue, 26 Sep 2017 18:00:31 +0000 (UTC)
In-Reply-To: <1506447990-27525-1-git-send-email-mjeanson@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

bWVyZ2VkLCB0aGFua3MhCgpNYXRoaWV1CgotLS0tLSBPbiBTZXAgMjYsIDIwMTcsIGF0IDE6NDYg
UE0sIE1pY2hhZWwgSmVhbnNvbiBtamVhbnNvbkBlZmZpY2lvcy5jb20gd3JvdGU6Cgo+IFNpZ25l
ZC1vZmYtYnk6IE1pY2hhZWwgSmVhbnNvbiA8bWplYW5zb25AZWZmaWNpb3MuY29tPgo+IC0tLQo+
IHdyYXBwZXIvdm1hbGxvYy5oIHwgMiArLQo+IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS93cmFwcGVyL3ZtYWxsb2MuaCBiL3dy
YXBwZXIvdm1hbGxvYy5oCj4gaW5kZXggMmRkMDZjYi4uZTExNzU4NCAxMDA2NDQKPiAtLS0gYS93
cmFwcGVyL3ZtYWxsb2MuaAo+ICsrKyBiL3dyYXBwZXIvdm1hbGxvYy5oCj4gQEAgLTI3LDYgKzI3
LDcgQEAKPiAKPiAjaW5jbHVkZSA8bGludXgvdmVyc2lvbi5oPgo+ICNpbmNsdWRlIDxsaW51eC92
bWFsbG9jLmg+Cj4gKyNpbmNsdWRlIDxsaW51eC9tbS5oPgo+IAo+ICNpZmRlZiBDT05GSUdfS0FM
TFNZTVMKPiAKPiBAQCAtMTA1LDcgKzEwNiw2IEBAIHZvaWQgbHR0bmdfa3ZmcmVlKGNvbnN0IHZv
aWQgKmFkZHIpCj4gI2Vsc2UKPiAKPiAjaW5jbHVkZSA8bGludXgvc2xhYi5oPgo+IC0jaW5jbHVk
ZSA8bGludXgvbW0uaD4KPiAKPiAvKgo+ICAqIGthbGxzeW1zIHdyYXBwZXIgb2YgX192bWFsbG9j
X25vZGUgd2l0aCBhIGZhbGxiYWNrIHRvIGttYWxsb2Nfbm9kZS4KPiAtLQo+IDIuNy40CgotLSAK
TWF0aGlldSBEZXNub3llcnMKRWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYg
bWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRu
Zy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
