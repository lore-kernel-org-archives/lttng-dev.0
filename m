From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH] Fix: lttng-live use g_free rather than free
Date: Tue, 19 Apr 2016 11:01:21 -0400
Message-ID: <CA+jJMxvw0bN4Cem9S=_yFC=s1VLQGbWa3hWQfH56299ZbMSpWg__38438.3513978266$1461078106$gmane$org@mail.gmail.com>
References: <1461032800-19065-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f195.google.com (mail-ig0-f195.google.com
 [209.85.213.195])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 9FF62A062A
 for <lttng-dev@lists.lttng.org>; Tue, 19 Apr 2016 15:01:23 +0000 (UTC)
Received: by mail-ig0-f195.google.com with SMTP id g8so2717730igr.0
 for <lttng-dev@lists.lttng.org>; Tue, 19 Apr 2016 08:01:23 -0700 (PDT)
In-Reply-To: <1461032800-19065-1-git-send-email-mathieu.desnoyers@efficios.com>
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

TWVyZ2VkIGluIG1hc3RlciBhbmQgc3RhYmxlLTEuMy4KClRoYW5rcyEKSsOpcsOpbWllCgoKT24g
TW9uLCBBcHIgMTgsIDIwMTYgYXQgMTA6MjYgUE0sIE1hdGhpZXUgRGVzbm95ZXJzCjxtYXRoaWV1
LmRlc25veWVyc0BlZmZpY2lvcy5jb20+IHdyb3RlOgo+IGdfbmV3MCBzaG91bGQgYmUgcGFpcmVk
IHdpdGggZ19mcmVlLgo+Cj4gU2lnbmVkLW9mZi1ieTogTWF0aGlldSBEZXNub3llcnMgPG1hdGhp
ZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbT4KPiAtLS0KPiAgZm9ybWF0cy9sdHRuZy1saXZlL2x0
dG5nLWxpdmUtcGx1Z2luLmMgfCAyICstCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2Zvcm1hdHMvbHR0bmctbGl2ZS9sdHRu
Zy1saXZlLXBsdWdpbi5jIGIvZm9ybWF0cy9sdHRuZy1saXZlL2x0dG5nLWxpdmUtcGx1Z2luLmMK
PiBpbmRleCBhZGI3MjQ5Li5iZjcxYjJiIDEwMDY0NAo+IC0tLSBhL2Zvcm1hdHMvbHR0bmctbGl2
ZS9sdHRuZy1saXZlLXBsdWdpbi5jCj4gKysrIGIvZm9ybWF0cy9sdHRuZy1saXZlL2x0dG5nLWxp
dmUtcGx1Z2luLmMKPiBAQCAtMzA3LDcgKzMwNyw3IEBAIGludCBsdHRuZ19saXZlX2Nsb3NlX3Ry
YWNlKHN0cnVjdCBidF90cmFjZV9kZXNjcmlwdG9yICp0ZCkKPiAgICAgICAgIHN0cnVjdCBjdGZf
dGV4dF9zdHJlYW1fcG9zICpwb3MgPQo+ICAgICAgICAgICAgICAgICBjb250YWluZXJfb2YodGQs
IHN0cnVjdCBjdGZfdGV4dF9zdHJlYW1fcG9zLAo+ICAgICAgICAgICAgICAgICAgICAgICAgIHRy
YWNlX2Rlc2NyaXB0b3IpOwo+IC0gICAgICAgZnJlZShwb3MpOwo+ICsgICAgICAgZ19mcmVlKHBv
cyk7Cj4gICAgICAgICByZXR1cm4gMDsKPiAgfQo+Cj4gLS0KPiAyLjEuNAo+CgoKCi0tIApKw6ly
w6ltaWUgR2FsYXJuZWF1CkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1h
aWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcu
b3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
