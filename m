From: Julien Desfossez <jdesfossez@efficios.com>
Subject: Re: Problem in Tracing C Program
Date: Thu, 30 Nov 2017 10:45:19 -0500
Message-ID: <78c5dc0c-f6d4-448e-2562-5c282e5ac538__24844.525245908$1512056738$gmane$org@efficios.com>
References: <1968389067.5193789.1512054837510.ref@mail.yahoo.com>
 <1968389067.5193789.1512054837510@mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3ynhYr4Jlgzj38
 for <lttng-dev@lists.lttng.org>; Thu, 30 Nov 2017 15:45:20 +0000 (UTC)
In-Reply-To: <1968389067.5193789.1512054837510@mail.yahoo.com>
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
To: MMM <e.morovati@yahoo.com>, Lttng-dev <lttng-dev@lists.lttng.org>, Houssem Daoud <houssemmh@gmail.com>
List-Id: lttng-dev@lists.lttng.org

T24gMjAxNy0xMS0zMCAxMDoxMyBBTSwgTU1NIHZpYSBsdHRuZy1kZXYgd3JvdGU6Cj4gRGVhciBV
c2VycywKPiAKPiBJIGhhdmUgcG9zdGVkIGEgY291cGxlIG9mIGVtYWlsIGFib3V0IG15IHByb2Js
ZW0gaW4gdGhlIHBhc3QsIHdoaWxlCj4gbm9ib2R5IHJlc3BvbnNlIHRob3NlLiBJdCBtYXkgYmUg
dHJ1ZSB0aGF0IG15IHF1ZXN0aW9uIGlzIGFtYXRldXJpc2gsCj4gYnV0IGR1ZSB0byB0aGUgZmFj
dCB0aGF0IEkgYW0gYSBiZWdpbm5lciwgSSBjYW4gbm90IGZpbmQgdGhlIHN1ZmZpY2llbnQKPiBk
b2N1bWVudCBmb3Igc29sdmluZyBteSBwcm9ibGVtLiBJIGFtIGdvaW5nIHRvIHRyYWNlIGEgQyBw
cm9ncmFtIHRoYXQKPiByZWFkIGZyb20gYSBmaWxlIGFuZCBzaG93IHRoZcKgcmF0aW8gb2YgcmVh
ZHMgZnJvbSBwYWdlIGNhY2hlIHZzIHJlYWRzCj4gZnJvbSBkaXNrLiBJIHJlYWQgZG9jdW1lbnQg
b2YgTFRUbmcgd2Vic2l0ZSwgYnV0IEkgY2FuIG5vdCBmaW5kCj4gYXBwcm9wcmlhdGUgZXhwbGFu
YXRpb24gZm9yIHRoaXMgdGFzay4gSSBqdXN0IG5lZWQgYSBzaW1wbGUgZ3VpZGFuY2UgdG8KPiBz
aG93IG1lIHRoZSByaWdodCB3YXkgZm9yIGRvaW5nIGl0LiBDb3VsZCB5b3UgcGxlYXNlIGhlbHAg
bWUuCj4gCj4gUmVnYXJkcywKPiBNZWhkaS4KCkhpLAoKVGhpcyBpcyBhIHJlYWxseSBub24tdHJp
dmlhbCB0YXNrIHRvIGRvLiBCYXNpY2FsbHksIHlvdSBuZWVkIHRvCmRpc3Rpbmd1aXNoIHRoZSBy
ZWFkKCkgc3lzY2FsbHMgdGhhdCBsZWFkIHRvIEZTL2Rpc2sgYWNjZXNzIHdpdGggdGhlCm9uZXMg
dGhhdCBkb24ndCAoZm9yIHRoZSBzYW1lIEZEKS4KVGhlIG1haW4gZGlmZmljdWx0eSBpcyB0byBt
YWtlIHRoZSBsaW5rIGJldHdlZW4gdGhlIHN5c2NhbGwgYW5kIHRoZQpsb3dlci1sZXZlbCBldmVu
dHMgYW5kIEkgYW0gbm90IHN1cmUgd2UgaGF2ZSBhbGwgdGhlIGRhdGEgbmVlZGVkIHRvCmVzdGFi
bGlzaCB0aGlzIGxpbmsgZnJvbSB0aGUgcGF5bG9hZCBvZiB0aGUgZXZlbnRzIHdlIGhhdmUgKHNv
bWV0aGluZwpsaWtlIEZEIC0+IEZTIGlub2RlIC0+IGJsb2NrKS4KCkkgYWRkZWQgSG91c3NlbSB0
byB0aGlzIHRocmVhZCBiZWNhdXNlIEkgdGhpbmsgSSByZW1lbWJlciBoZSBkaWQgc29tZQp3b3Jr
IGFyb3VuZCB0aGF0LCBoZSBtYXkgaGF2ZSBtb3JlIGluZm9ybWF0aW9uLgoKSnVsaWVuCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWls
aW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9y
Zy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
