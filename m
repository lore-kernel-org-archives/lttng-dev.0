From: Norbert Lange <nolange79@gmail.com>
Subject: Re: Using lttng for traces and (in-process) logging
Date: Fri, 10 Aug 2018 22:16:10 +0200
Message-ID: <CADYdroNCB70Jif97rgrjjzRYZi5Hod43PZ5ur4_GW6jZHhiEGA__7970.10964383862$1533932313$gmane$org@mail.gmail.com>
References: <CADYdroNy37NmavhVhMaUkR+k9+rJLc_6C3PoXq1rx_ZMwX=VtQ@mail.gmail.com>
 <CA+jJMxuvkd2=OM8G_NGjgGzeZTL6dEzq=DcH-XLWx8rQfesQYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-it0-x232.google.com (mail-it0-x232.google.com
 [IPv6:2607:f8b0:4001:c0b::232])
 by lists.lttng.org (Postfix) with ESMTPS id 41nGbp57t2z14k5
 for <lttng-dev@lists.lttng.org>; Fri, 10 Aug 2018 16:16:22 -0400 (EDT)
Received: by mail-it0-x232.google.com with SMTP id h20-v6so4361228itf.2
 for <lttng-dev@lists.lttng.org>; Fri, 10 Aug 2018 13:16:22 -0700 (PDT)
In-Reply-To: <CA+jJMxuvkd2=OM8G_NGjgGzeZTL6dEzq=DcH-XLWx8rQfesQYw@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: jeremie.galarneau@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

SSB0aGluayB5b3UgdW5kZXJzdG9vZCwgSSB3b3VsZCB3YW50IHRvIHVzZSBsdHRuZyBmb3IgdHJh
Y2luZyBhcy1pcywKYnV0IGhhdmUgYW5vdGhlciAiY29uc3VtZXIgZGFlbW9uIiByZWFkaW5nIHRo
ZSBidWZmZXIgZnJvbSB0aGUgcHJvY2VzcwphbmQgcGlwaW5nICh0aGUgZmlsdGVyZWQgbG9nLSkg
ZXZlbnRzIGJhY2suCkFmdGVyIHNwZW5kaW5nIHNvbWUgbW9yZSB0aW1lLCBJIHRoaW5rIGx0dG5n
IGhhcyB0b28gYmlnIG9mIGEgc2NvcGUKKHN5c3RlbSBsZXZlbCB0cmFjaW5nKSB0byBhZGQgdGhp
cyBwZXItcHJvY2VzcyBmZWF0dXJlIHBhaW5sZXNzLgpBbSBGci4sIDEwLiBBdWcuIDIwMTggdW0g
MTg6MjQgVWhyIHNjaHJpZWIgSsOpcsOpbWllIEdhbGFybmVhdQo8amVyZW1pZS5nYWxhcm5lYXVA
ZWZmaWNpb3MuY29tPjoKPgo+IEhpLAo+Cj4gSSBjYW4gc2VlIGhvdyB0aGlzIGNvdWxkIGJlIGFw
cHJveGltYXRlZCBieSBjb25maWd1cmluZyBhICJsaXZlIiB0cmFjaW5nCj4gc2Vzc2lvbiAoaS5l
LiB5b3Ugd291bGQgc2VlIHRoZSBsb2cgYXMgdGhleSBhcmUgcHJvZHVjZWQpLCBidXQgdGhlcmUg
aXMKPiBubyB3YXksIGN1cnJlbnRseSwgdG8gc2VyaWFsaXplIHRoZSBldmVudHMgdG8gc3Rkb3V0
L3N0ZGVyciBmcm9tIHRoZQo+IGFwcGxpY2F0aW9uIGl0c2VsZi4KPgo+IE1heWJlIEkgbWlzdW5k
ZXJzdG9vZCB5b3VyIHF1ZXN0aW9uLiBMZXQgbWUga25vdy4KPgo+IErDqXLDqW1pZQo+Cj4gT24g
NiBBdWd1c3QgMjAxOCBhdCAxODo0MiwgTm9yYmVydCBMYW5nZSA8bm9sYW5nZTc5QGdtYWlsLmNv
bT4gd3JvdGU6Cj4gPiBIZWxsbywKPiA+Cj4gPiBzaW5jZSBsdHRuZyB3b3VsZCBtYWtlIGZvciBh
IGRlY2VudCBsb2dnZXIsIGlzIGl0IHBvc3NpYmxlIHRvIGNyZWF0ZSBhCj4gPiBvd24gdHJhY2Vw
b2ludCBwcm92aWRlciBhbmQgY2hhbm5lbCBhbmQgYWNlc3MgaXQgaW4gdGhlIHZlcnkgc2FtZQo+
ID4gcHJvY2VzcyB0aGF0cyB0cmFjZWQ/Cj4gPiB0aGUgbG9nIGVudHJpZXMgd291bGQgbmVlZCB0
byBiZSBhY2Nlc3NpYmxlIGRpcmVjdGx5IHRvIHN1cHBvcnQgc29tZQo+ID4gZXhpc3Rpbmcgc2No
ZW1lcyBmb3IgbWFuaXB1bGF0aW5nIChpbnRlcnBvbGF0aW5nIHRvIGEgZGlmZmVyZW50Cj4gPiBj
bG9jay1zb3VyY2UpLCBmb3J3YXJkaW5nIGFuZCBzdG9yaW5nIHRoZW0uCj4gPgo+ID4gZWcuIEkg
d291bGQgbGlrZSB0byBhY2Nlc3MgdGhlIGxvZ3MgYW5kIG90aGVyIHRyYWNlcyB3aXRoIHRoZSBu
b3JtYWwKPiA+IGx0dG5nIHRvb2xzLCBidXQgYWxzbyBiZSBhYmxlIHRvIGdldCBhIGNvcHkgb2Yg
dGhlIGxvZ3MgZGlyZWN0bHkgZnJvbQo+ID4gdGhlIHByb2Nlc3MgZ2VuZXJhdGluZyB0aGVtLgo+
ID4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiA+IGx0
dG5nLWRldiBtYWlsaW5nIGxpc3QKPiA+IGx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKPiA+IGh0
dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
Pgo+Cj4KPiAtLQo+IErDqXLDqW1pZSBHYWxhcm5lYXUKPiBFZmZpY2lPUyBJbmMuCj4gaHR0cDov
L3d3dy5lZmZpY2lvcy5jb20KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3Jn
Cmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1k
ZXYK
