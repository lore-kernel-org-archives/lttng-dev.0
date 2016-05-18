From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: Wrong sizeof argument in
	pid tracker
Date: Wed, 18 May 2016 14:24:44 -0400
Message-ID: <CA+jJMxs_jbroWV+63Tqx7z_9do4ffJ4QxV_Y9+d+debQorDdMA__48593.3160678998$1463595899$gmane$org@mail.gmail.com>
References: <1463491430-21099-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f65.google.com (mail-qg0-f65.google.com
 [209.85.192.65])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id E9EFFA35A3
 for <lttng-dev@lists.lttng.org>; Wed, 18 May 2016 18:24:45 +0000 (UTC)
Received: by mail-qg0-f65.google.com with SMTP id b14so4892698qge.2
 for <lttng-dev@lists.lttng.org>; Wed, 18 May 2016 11:24:45 -0700 (PDT)
In-Reply-To: <1463491430-21099-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkLCB0aGFua3MhCgpKw6lyw6ltaWUKCk9uIFR1ZSwgTWF5IDE3LCAyMDE2IGF0IDk6MjMg
QU0sIE1hdGhpZXUgRGVzbm95ZXJzCjxtYXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20+IHdy
b3RlOgo+IEZvdW5kIGJ5IENvdmVyaXR5Ogo+Cj4gQ0lEIDEyOTI1NTcgKCMxIG9mIDEpOiBXcm9u
ZyBzaXplb2YgYXJndW1lbnQKPiAoU0laRU9GX01JU01BVENIKXN1c3BpY2lvdXNfc2l6ZW9mOiBQ
YXNzaW5nIGFyZ3VtZW50IDhVTCAvKiBzaXplb2YKPiAoKl9waWRfbGlzdCkgKi8gdG8gZnVuY3Rp
b24gem1hbGxvYyBhbmQgdGhlbiBjYXN0aW5nIHRoZSByZXR1cm4gdmFsdWUgdG8KPiBpbnQgKiBp
cyBzdXNwaWNpb3VzLgo+Cj4gU2lnbmVkLW9mZi1ieTogTWF0aGlldSBEZXNub3llcnMgPG1hdGhp
ZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbT4KPiAtLS0KPiAgc3JjL2Jpbi9sdHRuZy9jb21tYW5k
cy90cmFjay11bnRyYWNrLmMgfCAyICstCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL3NyYy9iaW4vbHR0bmcvY29tbWFuZHMv
dHJhY2stdW50cmFjay5jIGIvc3JjL2Jpbi9sdHRuZy9jb21tYW5kcy90cmFjay11bnRyYWNrLmMK
PiBpbmRleCAzNzcxZGU1Li5kOWUxOGMxIDEwMDY0NAo+IC0tLSBhL3NyYy9iaW4vbHR0bmcvY29t
bWFuZHMvdHJhY2stdW50cmFjay5jCj4gKysrIGIvc3JjL2Jpbi9sdHRuZy9jb21tYW5kcy90cmFj
ay11bnRyYWNrLmMKPiBAQCAtODcsNyArODcsNyBAQCBpbnQgcGFyc2VfcGlkX3N0cmluZyhjb25z
dCBjaGFyICpfcGlkX3N0cmluZywKPiAgICAgICAgICAgICAgICAgZ290byBlcnJvcjsKPiAgICAg
ICAgIH0KPiAgICAgICAgIGlmIChhbGwpIHsKPiAtICAgICAgICAgICAgICAgcGlkX2xpc3QgPSB6
bWFsbG9jKHNpemVvZigqX3BpZF9saXN0KSk7Cj4gKyAgICAgICAgICAgICAgIHBpZF9saXN0ID0g
em1hbGxvYyhzaXplb2YoKnBpZF9saXN0KSk7Cj4gICAgICAgICAgICAgICAgIGlmICghcGlkX2xp
c3QpIHsKPiAgICAgICAgICAgICAgICAgICAgICAgICBFUlIoIk91dCBvZiBtZW1vcnkiKTsKPiAg
ICAgICAgICAgICAgICAgICAgICAgICByZXR2YWwgPSBDTURfRVJST1I7Cj4gLS0KPiAyLjEuNAo+
CgoKCi0tIApKw6lyw6ltaWUgR2FsYXJuZWF1CkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZp
Y2lvcy5jb20KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8v
bGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
