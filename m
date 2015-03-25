From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: relayd TCP reconnect?
Date: Wed, 25 Mar 2015 14:14:27 -0400
Message-ID: <CA+jJMxvqgcwouaAyAEty9Ghd3hkd5N0PdFZOuR1s9j-d0RCO-A__5292.56547238237$1427307354$gmane$org@mail.gmail.com>
References: <DUB123-W281E1610272EFEB7FEBDA2DD0B0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1Yapp4-0006oo-Ek
 for lttng-dev@lists.lttng.org; Wed, 25 Mar 2015 14:14:42 -0400
Received: by qgh3 with SMTP id 3so44008474qgh.2
 for <lttng-dev@lists.lttng.org>; Wed, 25 Mar 2015 11:14:29 -0700 (PDT)
In-Reply-To: <DUB123-W281E1610272EFEB7FEBDA2DD0B0@phx.gbl>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jesper Derehag <jderehag@hotmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

T24gV2VkLCBNYXIgMjUsIDIwMTUgYXQgMTE6MTYgQU0sIEplc3BlciBEZXJlaGFnIDxqZGVyZWhh
Z0Bob3RtYWlsLmNvbT4gd3JvdGU6Cj4gSGkgQWxsLAo+Cj4gSSBrbm93IHRoZSBpc3N1ZSB3aXRo
IHJlbGF5ZCByZWNvbm5lY3RzIGhhdmUgYmVlbiBkaXNjdXNzZWQgZWFybGllciBoZXJlOgo+IGh0
dHA6Ly9saXN0cy5sdHRuZy5vcmcvcGlwZXJtYWlsL2x0dG5nLWRldi8yMDE0LU9jdG9iZXIvMDIz
NjUwLmh0bWwKPgo+IEJ1dCBoYXMgdGhlcmUgYmVlbiBhbnkgZnVydGhlciBkZXZlbG9wbWVudCBv
biB0aGlzPwo+IEkgd291bGQgYWN0dWFsbHkgZ28gYXMgZmFyIGFzIGNhbGxpbmcgaXQgYSBidWcg
YW5kIHN1Ym1pdHRpbmcgaXQgdG8gcmVkbWluZSB0cmFja2VyLCBidXQgd2FudCB0byBnZXQgYXBw
cm92YWwgaGVyZSBmaXJzdC4KPgoKSGkgSmVzcGVyLAoKVGhlcmUgaGFzIGJlZW4gbm8gd29yayBk
b25lIG9uIHRoaXMgeWV0LgoKPiBJIHdvdWxkIGFyZ3VlIHRoYXQgaXRzICphbHdheXMqIGEgZ29v
ZCBpZGVhIHRvIGRvIHJlY29ubmVjdHMgZHVlIHRvIHRoYXQgeW91IHJlYWxseSBkb250IGhhdmUg
YW55IGVuZC10by1lbmQgY29udHJvbCBvZiB0aGUgVENQIGZsb3cuCj4gU29tZSByYW5kb20gcm91
dGVyIG1pZ2h0IGRlY2lkZSB0byBzcHVyaW91c2x5IGRyb3AgeW91ciBjb25uZWN0aW9uLCBub3Qg
dG8gbWVudGlvbiBtb3JlIG1vZGVybiBxdWV1aW5nIGRpc2NpcGxpbmVzIHdoaWNoIG1pZ2h0IHJh
bmRvbWx5IHRocm93IGF3YXkgcGFja2V0cy4KPgo+IE9uIGF1dG9tYXRlZCBzeXN0ZW1zLCB0aGF0
IHdvdWxkIG1lYW4gdGhhdCB5b3UgaGF2ZSB0byBzb21laG93IGF1dG9tYWdpY2FsbHkgZGV0ZWN0
IHRoYXQgeW91IGdvdCBhIGRpc2Nvbm5lY3QsIGFuZCB0aGVuIGV4dGVybmFsbHkgcmVzdGFydCB0
aGUgc2Vzc2lvbiwgd2hpY2ggc2VlbXMgbGlrZSBhIHZlcnkgd2VpcmQgd29ya2Fyb3VuZC4uLgo+
Cj4gSSB3b3VsZCBiZSBoYXBweSB0byBmaWxlIHN1Y2ggYSBpc3N1ZSB0byB0aGUgdHJhY2tlciBp
ZiBwZW9wbGUgdGhpbmtzIGl0cyBhIGdvb2QgaWRlYSwgKGFuZCBkZXBlbmRpbmcgb24gaWYgSSBo
YXZlIHRoZSB0aW1lIEkgKm1pZ2h0KiBsb29rIGludG8gc29sdmluZyBpdCBteXNlbGYpLgo+IEJ1
dCBpdCBtaWdodCBiZSBzb21lIHRpbWUgYXdheSBpbiB0aGF0IGNhc2UuLgoKU3VyZSwgZmVlbCBm
cmVlIHRvIG9wZW4gYSB0aWNrZXQuIFdlJ2xsIGRlZmluaXRpdmVseSBoYXZlIHRvIGxvb2sgaW50
bwpyZWNvdmVyaW5nIGdyYWNlZnVsbHkgYXQgc29tZSBwb2ludC4KCkrDqXLDqW1pZQoKPgo+IFJl
Z2FyZHMsCj4gSmVzcGVyCj4KPgo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KPiBsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cj4gbHR0bmctZGV2QGxpc3Rz
Lmx0dG5nLm9yZwo+IGh0dHA6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3Rp
bmZvL2x0dG5nLWRldgoKCgotLSAKSsOpcsOpbWllIEdhbGFybmVhdQpFZmZpY2lPUyBJbmMuCmh0
dHA6Ly93d3cuZWZmaWNpb3MuY29tCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRu
Zy5vcmcKaHR0cDovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0
bmctZGV2Cg==
