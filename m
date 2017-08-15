From: Philippe Proulx <eeppeliteloop@gmail.com>
Subject: Re: Status of MinGW support for babeltrace (either 1.x
	or 2.x)
Date: Tue, 15 Aug 2017 12:38:32 -0400
Message-ID: <CAB4xu_3HM+5At3=opwrZuzz9G7tqbg1JLxxgL0-F86m_+Zqc+w__7490.74358395791$1502815173$gmane$org@mail.gmail.com>
References: <CAPmGMvh9C2E7y3uDkdHqTizkuPAd9nuPn4OvOjvjDyCqyxhCag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt0-x22e.google.com (mail-qt0-x22e.google.com
 [IPv6:2607:f8b0:400d:c0d::22e])
 by lists.lttng.org (Postfix) with ESMTPS id 3xWyqD1NNZzCjG
 for <lttng-dev@lists.lttng.org>; Tue, 15 Aug 2017 16:39:03 +0000 (UTC)
Received: by mail-qt0-x22e.google.com with SMTP id t37so7180914qtg.5
 for <lttng-dev@lists.lttng.org>; Tue, 15 Aug 2017 09:39:03 -0700 (PDT)
In-Reply-To: <CAPmGMvh9C2E7y3uDkdHqTizkuPAd9nuPn4OvOjvjDyCqyxhCag@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonah Graham <jonah@kichwacoders.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

T24gVHVlLCBBdWcgMTUsIDIwMTcgYXQgMTI6MTIgUE0sIEpvbmFoIEdyYWhhbSA8am9uYWhAa2lj
aHdhY29kZXJzLmNvbT4gd3JvdGU6Cj4KPiBIZWxsbywKPgo+IE92ZXIgdGhlIHllYXJzIEkgaGF2
ZSBzZWVuIHNvbWUgZGlzY3Vzc2lvbnMgYW5kIHBhdGNoZXMgYWJvdXQgZ2V0dGluZwo+IGZ1bGwg
TWluR1cgc3VwcG9ydCBmb3IgYmFiZWx0cmFjZS4gSSBhbSBpbnRlcmVzdGVkIGluIGlmIHNvbWVv
bmUgY2FuCj4gcHJvdmlkZSBhbiBvdmVydmlldyBvZiB0aGUgY3VycmVudCBzdGF0ZSBvZiBNaW5H
Vy4KPgo+IEkgaGF2ZSB0cmllZCB0byBidWlsZCAxLjUuMyBhbmQgKHByb2JhYmx5IGFzIGV4cGVj
dGVkKSB0aGVyZSBhcmUKPiBudW1lcm91cyBjb21waWxlIGlzc3VlcyAoZS5nLiBzeXMvbW1hbi5o
KQo+Cj4gSSBoYXZlIGdvdHRlbiBmdXJ0aGVyIHdpdGggY3VycmVudCBtYXN0ZXIgKG15IHByaW1h
cnkgaW50ZXJlc3QgaXMKPiBsaWJiYWJlbHRyYWNlIHNvIHRoZSBpc3N1ZXMgSSBoYXZlIHdpdGgg
Y2xpL2JhYmVsdHJhY2UuYyBhbmQKPiB0ZXN0cy90ZXN0X2N0Zl93cml0ZXIuYyBkb24ndCBjb25j
ZXJuIG1lIHRvbyBtdWNoIHlldCkuIEhvd2V2ZXIgd2hlbiBJCj4gdHJ5IHRvIHJ1biBhIHNpbXBs
ZSBleGFtcGxlICh0aGF0IHdvcmtzIG9uIExpbnV4KSBpdCBmYWlscyBvbgo+IGJ0X2N0Zl9zdHJl
YW1fZmx1c2guIEkgd2lsbCBkZWJ1ZyBmdXJ0aGVyIHRvIGlkZW50aWZ5IHRoZSBwcm9ibGVtLgo+
IEhvd2V2ZXIgSWYgc29tZW9uZSBkb2VzIGhhdmUgYSBtaW5ndyBwb3J0IHdvcmtpbmcgd2VsbCBh
bnkgZ3VpZGFuY2Ugb24KPiBidWlsZGluZyB3b3VsZCBiZSBtdWNoIGFwcHJlY2lhdGVkLgoKTWlu
R1cgc3VwcG9ydCBpcyBvbiBpdHMgd2F5IGZvciB0aGUgQmFiZWx0cmFjZSAyLjAgcmVsZWFzZSwg
YnV0IEknbQpjdXJpb3VzIGFzIHRvIHdoeSB5b3VyIHByaW1hcnkgaW50ZXJlc3QgaXMgbGliYmFi
ZWx0cmFjZT8gSXMgaXQgZm9yIENURgp3cml0ZXIgb3IgZm9yIHRoZSB0cmFjZSByZWFkaW5nIEFQ
ST8KClBoaWwKCj4KPiBUaGFua3MKPiBKb25haAo+Cj4KPiB+fn4KPiBKb25haCBHcmFoYW0KPiBL
aWNod2EgQ29kZXJzIEx0ZC4KPiB3d3cua2ljaHdhY29kZXJzLmNvbQo+IF9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gbHR0bmctZGV2IG1haWxpbmcgbGlz
dAo+IGx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKPiBodHRwczovL2xpc3RzLmx0dG5nLm9yZy9j
Z2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2
QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4v
bGlzdGluZm8vbHR0bmctZGV2Cg==
