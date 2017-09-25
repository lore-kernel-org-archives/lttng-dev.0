From: Philippe Proulx <eeppeliteloop@gmail.com>
Subject: Re: Are arrays allowed in event payload?
Date: Mon, 25 Sep 2017 15:56:21 -0400
Message-ID: <CAB4xu_3pd=NLVZgYyCXH5Hzr1dejUx9KR3OKp1MEOMdXpg7-KA__40475.6500422538$1506369420$gmane$org@mail.gmail.com>
References: <CAAuy2ASF_rf1a9iuo=XKKPriVgEPGues-sQ-HyMOdg7F+VjC7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt0-x229.google.com (mail-qt0-x229.google.com
 [IPv6:2607:f8b0:400d:c0d::229])
 by lists.lttng.org (Postfix) with ESMTPS id 3y1FGX6jJvzCbs
 for <lttng-dev@lists.lttng.org>; Mon, 25 Sep 2017 19:56:52 +0000 (UTC)
Received: by mail-qt0-x229.google.com with SMTP id 47so8144813qts.10
 for <lttng-dev@lists.lttng.org>; Mon, 25 Sep 2017 12:56:52 -0700 (PDT)
In-Reply-To: <CAAuy2ASF_rf1a9iuo=XKKPriVgEPGues-sQ-HyMOdg7F+VjC7g@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "Nwafor, Ebelechukwu" <ebelechukwu.nwafor@bison.howard.edu>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

T24gTW9uLCBTZXAgMjUsIDIwMTcgYXQgMzo0MSBQTSwgTndhZm9yLCBFYmVsZWNodWt3dQo8ZWJl
bGVjaHVrd3UubndhZm9yQGJpc29uLmhvd2FyZC5lZHU+IHdyb3RlOgo+IEhlbGxvIEFsbAo+Cj4g
SSBhbSBuZXcgdG8gYmFyZWN0Zi4gSSBhbSB0cnlpbmcgdG8gZGVmaW5lIG15IHlhbWwgY29uZmln
dXJhdGlvbiBhbmQgaSBrZWVwCj4gZ2V0dGluZyBhbiBlcnJvciB3aGVuZXZlciBpIHRyeSB0byBj
b21waWxlIG15IGNvbmZpZ3VyYXRpb24uIEkgd2FzIHdvbmRlcmluZwo+IGlmIGFycmF5cyBhcmUg
YWxsb3dlZCBpbiB0aGUgZXZlbnQgcGF5bG9hZCBzZWN0aW9uIGFuZCBpZiB5ZXMgaG93IGFyZSB0
aGV5Cj4gZGVmaW5lZD8KCldoYXQgaXMgdGhlIGVycm9yPwoKQXMgcGVyIHRoZSBwcm9qZWN0J3Mg
UkVBRE1FLm1kOgoKPiBDVEYgY29tcG91bmQgdHlwZXMgKGFycmF5LCBzZXF1ZW5jZSwgc3RydWN0
dXJlLCB2YXJpYW50KSBhcmUgbm90Cj4gc3VwcG9ydGVkIHlldCwgZXhjZXB0IGF0IHNvbWUgdmVy
eSBzcGVjaWZpYyBsb2NhdGlvbnMgaW4gdGhlIG1ldGFkYXRhLgoKSW4gZmFjdCwgdGhlIG9ubHkg
InZlcnkgc3BlY2lmaWMgbG9jYXRpb24iIGlzIHRoZSB0cmFjZSBwYWNrZXQgaGVhZGVyJ3MKYHV1
aWRgIGZpZWxkIHdoaWNoIG11c3QgYmUgYW4gYXJyYXkgb2YgMTYgOC1iaXQgaW50ZWdlcnMuIFRo
aXMgYHV1aWRgCmZpZWxkIGlzIGhhbmRsZWQgYXMgYSBzcGVjaWFsIGNhc2Ugd2hlbiBnZW5lcmF0
aW5nIHRoZSB0cmFjZXI6CjxodHRwczovL2dpdGh1Yi5jb20vZWZmaWNpb3MvYmFyZWN0Zi9ibG9i
L3YyLjIuMS9iYXJlY3RmL2dlbi5weSNMODUyPi4KVGhlcmUncyBjdXJyZW50bHkgbm8gZ2VuZXJp
YyB3YXkgaW4gYmFyZWN0ZiB0byBnZW5lcmF0ZSBDIGNvZGUgd2hpY2gKd3JpdGVzIGFuIGFycmF5
IG9mIGVsZW1lbnRzIHRvIHRoZSBjdXJyZW50IHBhY2tldCBidWZmZXIuCgpTdXBwb3J0aW5nIGNv
bXBvdW5kIHR5cGVzIGlzIGEgZmVhdHVyZSByZXF1ZXN0IHdoaWNoIG9mdGVuIGNvbWVzIHVwIChp
bgpMVFRuZy1VU1QgdG9vKS4KClBoaWwKCj4KPgo+IFRoYW5rcy4KPgo+Cj4KPiBfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGx0dG5nLWRldiBtYWlsaW5n
IGxpc3QKPiBsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCj4gaHR0cHM6Ly9saXN0cy5sdHRuZy5v
cmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo+Cl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0
bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21h
aWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
