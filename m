From: Simon Marchi <simon.marchi@efficios.com>
Subject: Re: [PATCH lttng-tools] configure.ac: Remove duplicated
 CMD_DESCR_ROTATE definition
Date: Mon, 19 Aug 2019 21:47:02 -0400
Message-ID: <5e19a746-9270-11c1-dd26-24e13a95c359__3200.59686653025$1566265652$gmane$org@efficios.com>
References: <20190527155246.24102-1-simon.marchi@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 46CDDv7322zsXr
 for <lttng-dev@lists.lttng.org>; Mon, 19 Aug 2019 21:47:11 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 403A32C97AF
 for <lttng-dev@lists.lttng.org>; Mon, 19 Aug 2019 21:47:05 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
 with ESMTP id maAO_zXCG5dq for <lttng-dev@lists.lttng.org>;
 Mon, 19 Aug 2019 21:47:04 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id F32852C97A5
 for <lttng-dev@lists.lttng.org>; Mon, 19 Aug 2019 21:47:03 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
 with ESMTP id gHYnJHt8kEho for <lttng-dev@lists.lttng.org>;
 Mon, 19 Aug 2019 21:47:03 -0400 (EDT)
Received: from [192.168.86.149] (ip98-176-129-60.sd.sd.cox.net [98.176.129.60])
 by mail.efficios.com (Postfix) with ESMTPSA id 924B92C97A0
 for <lttng-dev@lists.lttng.org>; Mon, 19 Aug 2019 21:47:03 -0400 (EDT)
In-Reply-To: <20190527155246.24102-1-simon.marchi@efficios.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

T24gMjAxOS0wNS0yNyAxMTo1MiBhLm0uLCBTaW1vbiBNYXJjaGkgd3JvdGU6Cj4gQ01EX0RFU0NS
X1JPVEFURSBpcyBkZWZpbmVkIHR3aWNlIGJ5IGNvbmZpZ3VyZS4gIFRoaXMgYnJlYWtzIGNvbmZp
Z3VyaW5nCj4gd2l0aCAiLVdlcnJvciAtV2FsbCIsIGFzIHNvbWUgdGVzdCBwcm9ncmFtcyBkb24n
dCBjb21waWxlIGR1ZSB0bzoKPiAKPiAgIGNvbmZpZ3VyZToxNjk5MDogZ2NjIC1vIGNvbmZ0ZXN0
IC1XYWxsIC1XZXJyb3IgICBjb25mdGVzdC5jICA+JjUKPiAgIGNvbmZ0ZXN0LmM6MTYzOiBlcnJv
cjogIkNPTkZJR19DTURfREVTQ1JfUk9UQVRFIiByZWRlZmluZWQgWy1XZXJyb3JdCj4gICAgI2Rl
ZmluZSBDT05GSUdfQ01EX0RFU0NSX1JPVEFURSAiQXJjaGl2ZSBhIHRyYWNpbmcgc2Vzc2lvbuKA
mXMgY3VycmVudCB0cmFjZSBjaHVuayIKPiAKPiAgIGNvbmZ0ZXN0LmM6MTU0OiBub3RlOiB0aGlz
IGlzIHRoZSBsb2NhdGlvbiBvZiB0aGUgcHJldmlvdXMgZGVmaW5pdGlvbgo+ICAgICNkZWZpbmUg
Q09ORklHX0NNRF9ERVNDUl9ST1RBVEUgIkFyY2hpdmUgYSB0cmFjaW5nIHNlc3Npb24ncyBjdXJy
ZW50IHRyYWNlIGNodW5rIgo+IAo+ICAgY2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBh
cyBlcnJvcnMKPiAKPiBTaWduZWQtb2ZmLWJ5OiBTaW1vbiBNYXJjaGkgPHNpbW9uLm1hcmNoaUBl
ZmZpY2lvcy5jb20+Cj4gLS0tCj4gIGNvbmZpZ3VyZS5hYyB8IDEgLQo+ICAxIGZpbGUgY2hhbmdl
ZCwgMSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS9jb25maWd1cmUuYWMgYi9jb25maWd1
cmUuYWMKPiBpbmRleCAyMTRkNThhYzg4NTYuLmU4ODg3NTg1NjExNSAxMDA2NDQKPiAtLS0gYS9j
b25maWd1cmUuYWMKPiArKysgYi9jb25maWd1cmUuYWMKPiBAQCAtNDEyLDcgKzQxMiw2IEBAIF9B
Q19ERUZJTkVfUVVPVEVEX0FORF9TVUJTVChbQ01EX0RFU0NSX1NUQVRVU10sIFtHZXQgdGhlIHN0
YXR1cyBvZiB0aGUgY3VycmVudCB0Cj4gIF9BQ19ERUZJTkVfUVVPVEVEX0FORF9TVUJTVChbQ01E
X0RFU0NSX1NUT1BdLCBbU3RvcCB0cmFjaW5nXSkKPiAgX0FDX0RFRklORV9RVU9URURfQU5EX1NV
QlNUKFtDTURfREVTQ1JfRElTQUJMRV9ST1RBVElPTl0sIFtVbnNldCBhIHJvdGF0aW9uIHNjaGVk
dWxlXSkKPiAgX0FDX0RFRklORV9RVU9URURfQU5EX1NVQlNUKFtDTURfREVTQ1JfRU5BQkxFX1JP
VEFUSU9OXSwgW1NldCBhIHJvdGF0aW9uIHNjaGVkdWxlXSkKPiAtX0FDX0RFRklORV9RVU9URURf
QU5EX1NVQlNUKFtDTURfREVTQ1JfUk9UQVRFXSwgW0FyY2hpdmUgYSB0cmFjaW5nIHNlc3Npb27i
gJlzIGN1cnJlbnQgdHJhY2UgY2h1bmtdKQo+ICBfQUNfREVGSU5FX1FVT1RFRF9BTkRfU1VCU1Qo
W0NNRF9ERVNDUl9UUkFDS10sIFtUcmFjayBzcGVjaWZpYyBzeXN0ZW0gcmVzb3VyY2VzXSkKPiAg
X0FDX0RFRklORV9RVU9URURfQU5EX1NVQlNUKFtDTURfREVTQ1JfVU5UUkFDS10sIFtVbnRyYWNr
IHNwZWNpZmljIHN5c3RlbSByZXNvdXJjZXNdKQo+ICBfQUNfREVGSU5FX1FVT1RFRF9BTkRfU1VC
U1QoW0NNRF9ERVNDUl9WRVJTSU9OXSwgW1Nob3cgdmVyc2lvbiBpbmZvcm1hdGlvbl0pCj4gCgpQ
aW5nLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRu
Zy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0
cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
