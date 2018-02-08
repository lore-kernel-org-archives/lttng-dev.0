From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust 5/8] Fix: missing enum removal
 from the enum hashtable
Date: Thu, 8 Feb 2018 20:52:55 +0000 (UTC)
Message-ID: <1238547764.18655.1518123175515.JavaMail.zimbra__18013.9865180992$1518123036$gmane$org@efficios.com>
References: <1517600891-23632-1-git-send-email-francis.deslauriers@efficios.com>
 <1517600891-23632-6-git-send-email-francis.deslauriers@efficios.com>
 <271937624.17827.1518036900541.JavaMail.zimbra@efficios.com>
 <CADcCL0h7joW64uTw3A6788smGTWrexGYdntF2TWQ_D32JSNZrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3zcr3V5V4vzDSm
 for <lttng-dev@lists.lttng.org>; Thu,  8 Feb 2018 20:52:06 +0000 (UTC)
In-Reply-To: <CADcCL0h7joW64uTw3A6788smGTWrexGYdntF2TWQ_D32JSNZrA@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Francis Deslauriers <francis.deslauriers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

LS0tLS0gT24gRmViIDgsIDIwMTgsIGF0IDM6NDUgUE0sIEZyYW5jaXMgRGVzbGF1cmllcnMgZnJh
bmNpcy5kZXNsYXVyaWVyc0BlZmZpY2lvcy5jb20gd3JvdGU6Cgo+IDIwMTgtMDItMDcgMTU6NTUg
R01ULTA1OjAwIE1hdGhpZXUgRGVzbm95ZXJzIDxtYXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5j
b20+Ogo+PiAtLS0tLSBPbiBGZWIgMiwgMjAxOCwgYXQgMjo0OCBQTSwgRnJhbmNpcyBEZXNsYXVy
aWVycwo+PiBmcmFuY2lzLmRlc2xhdXJpZXJzQGVmZmljaW9zLmNvbSB3cm90ZToKPj4KPj4gSXMg
aXQgYSBmaXggb3IgYSBwcmVwYXJhdGlvbiBzdGVwIGZvciBhIG5ldyBmZWF0dXJlID8KPiBTYW1l
IHRob3VnaHQgcHJvY2VzcyB0aGF0IHdpdGg6IGNkc19obGlzdF9kZWwoJmV2ZW50LT5obGlzdCk7
CgpOb3QgYSBmaXggdGhlbi4KClRoYW5rcywKCk1hdGhpZXUKCj4gCj4gVGhhbmtzLAo+IEZyYW5j
aXMKPj4KPj4gVGhhbmtzLAo+Pgo+PiBNYXRoaWV1Cj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBGcmFu
Y2lzIERlc2xhdXJpZXJzIDxmcmFuY2lzLmRlc2xhdXJpZXJzQGVmZmljaW9zLmNvbT4KPj4+IC0t
LQo+Pj4gbGlibHR0bmctdXN0L2x0dG5nLWV2ZW50cy5jIHwgMSArCj4+PiAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKykKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvbGlibHR0bmctdXN0L2x0dG5n
LWV2ZW50cy5jIGIvbGlibHR0bmctdXN0L2x0dG5nLWV2ZW50cy5jCj4+PiBpbmRleCBlOGQ0ODU3
Li4yYjY3OWI1IDEwMDY0NAo+Pj4gLS0tIGEvbGlibHR0bmctdXN0L2x0dG5nLWV2ZW50cy5jCj4+
PiArKysgYi9saWJsdHRuZy11c3QvbHR0bmctZXZlbnRzLmMKPj4+IEBAIC05OTAsNiArOTkwLDcg
QEAgc3RhdGljCj4+PiB2b2lkIF9sdHRuZ19lbnVtX2Rlc3Ryb3koc3RydWN0IGx0dG5nX2VudW0g
Kl9lbnVtKQo+Pj4gewo+Pj4gICAgICAgY2RzX2xpc3RfZGVsKCZfZW51bS0+bm9kZSk7Cj4+PiAr
ICAgICBjZHNfaGxpc3RfZGVsKCZfZW51bS0+aGxpc3QpOwo+Pj4gICAgICAgZnJlZShfZW51bSk7
Cj4+PiB9Cj4+Pgo+Pj4gLS0KPj4+IDIuNy40Cj4+Cj4+IC0tCj4+IE1hdGhpZXUgRGVzbm95ZXJz
Cj4+IEVmZmljaU9TIEluYy4KPj4gaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KPiAKPiAKPiAKPiAt
LQo+IEZyYW5jaXMgRGVzbGF1cmllcnMKPiBTb2Z0d2FyZSBkZXZlbG9wZXIKPiBFZmZpY2lPUyBp
bmMuCgotLSAKTWF0aGlldSBEZXNub3llcnMKRWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3LmVmZmlj
aW9zLmNvbQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwps
dHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9s
aXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
