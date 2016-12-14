From: Douglas Graham <douglas.graham@ericsson.com>
Subject: Fast way to clear trace logs and continue tracing?
Date: Wed, 14 Dec 2016 02:41:38 +0000
Message-ID: <DB5PR07MB0949E65A3F1EEFBEDD89CD79F09A0__49093.2830529802$1481683320$gmane$org@DB5PR07MB0949.eurprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from sesbmg22.ericsson.net (sesbmg22.ericsson.net [193.180.251.48])
 by lists.lttng.org (Postfix) with ESMTPS id 3tdgrB2bV1zss3
 for <lttng-dev@lists.lttng.org>; Wed, 14 Dec 2016 02:43:53 +0000 (UTC)
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
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

SGksCgpJIGp1c3Qgc3RhcnRlZCB3b3JraW5nIHdpdGggbHR0bmcgcmVjZW50bHksIHNvIGFwb2xv
Z2llcyBpZiB0aGlzIGlzIGEgZHVtYiBxdWVzdGlvbi4KClN1cHBvc2UgSSBoYXZlIGNvbmZpZ3Vy
ZWQgYW5kIHN0YXJ0ZWQgYSBzZXNzaW9uIGFuZCBoYXZlIGNvbGxlY3RlZCBhIGJ1bmNoIG9mIHRy
YWNlcyBpbiBhIHRyYWNlIGZpbGUuICBOb3cgSSB3YW50IHRvIGNsZWFyIHRob3NlIHRyYWNlcyBi
dXQgdGhlbiBjb250aW51ZSBzYXZpbmcgbmV3IHRyYWNlcyB1c2luZyB0aGUgc2FtZSBzZXNzaW9u
LiAgSXMgdGhlcmUgYSByZWFzb25hYmx5IGZhc3Qgd2F5IHRvIGRvIHRoYXQ/CgpXaGF0IHdlIGN1
cnJlbnRseSBkbyBpcyAibHR0bmcgc2F2ZSAtLW91dHB1dC1wYXRoPXguY2ZnOyBsdHRuZyBzdG9w
OyBsdHRuZyBkZXN0cm95OyBybSAtcmYgPHRyYWNlZGlyPjsgbHR0bmcgbG9hZCAtLWlucHV0LXBh
dGg9eC5jZmcKCkJ1dCB0aGlzIGlzIHZlcnkgc2xvdyBpbiBzb21lIGNhc2VzLiAgVGhlIGx0dG5n
IGxvYWQgaW4gcGFydGljdWxhciBpcyBleHRyZW1lbHkgc2xvdyB3aGVuIExpbnV4IGlzIHJ1bm5p
bmcgaW5zaWRlIGEgdmlydHVhbCBtYWNoaW5lLiAgSSB3YXMgaG9waW5nIHRoYXQgbHR0bmcgbWln
aHQgc3VwcG9ydCBhICJsdHRuZyBjbGVhciIgdGhhdCBjb3VsZCBiZSB1c2VkIHRvIHJlbW92ZSBh
bGwgdHJhY2VzIGZyb20gdGhlIHRyYWNlIGZpbGUsIGJ1dCBJIGNhbid0IGZpbmQgYW55IHN1Y2gg
Y29tbWFuZC4KCkkgbm90ZSB0aGF0IGx0dG5nIGRvZXMgc3VwcG9ydCB0aGUgcm90YXRpbmcgb2Yg
dHJhY2UgZmlsZXMgd2hlbiB0aGV5IHJlYWNoIGEgc2l6ZSBsaW1pdC4gIEkgdGhpbmsgdGhhdCdz
IGZhaXJseSBjbG9zZSB0byB3aGF0IEkgd2FudC4gIElmIEkgY291bGQgZm9yY2UgYSB0cmFjZSBm
aWxlIHJvdGF0aW9uIGF0IGFuIGFyYml0cmFyeSB0aW1lIGFuZCB0aGVuIHNpbXBsZSByZW1vdmUg
dGhlIG9sZCByb3RhdGVkIGxvZywgbGVhdmluZyB0aGUgbmV3IG9uZSwgdGhhdCBzZWVtcyBsaWtl
IGl0IHNob3VsZCBkbyB0aGUgam9iLiAgRXhjZXB0IEkgZG9uJ3Qgc2VlIGFueSB3YXkgdG8gZm9y
Y2UgYSByb3RhdGlvbi4KCkFueSBpZGVhcz8KClRoYW5rcywKRG91ZwpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0
dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9t
YWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
