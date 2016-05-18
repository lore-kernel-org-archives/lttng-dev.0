From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: pointer dereference after
 NULL check in test_create_ust_event_exclusion
Date: Wed, 18 May 2016 15:22:06 -0400
Message-ID: <CA+jJMxubJnLoJ0pG4QE1M5tpLeQg5k3PDuD6SJJvw+YUQvL5rA__1692.74786389924$1463599349$gmane$org@mail.gmail.com>
References: <1463496519-29497-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f65.google.com (mail-qg0-f65.google.com
 [209.85.192.65])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id E3486A35A4
 for <lttng-dev@lists.lttng.org>; Wed, 18 May 2016 19:22:07 +0000 (UTC)
Received: by mail-qg0-f65.google.com with SMTP id e35so5022761qge.1
 for <lttng-dev@lists.lttng.org>; Wed, 18 May 2016 12:22:07 -0700 (PDT)
In-Reply-To: <1463496519-29497-1-git-send-email-mathieu.desnoyers@efficios.com>
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

TWVyZ2VkLCB0aGFua3MhCgpJIGFsc28gc2tpcHBlZCB0aGUgcmVzdCBvZiB0aGUgdGVzdCBzaW5j
ZSB3ZSdkIGJlIHVzaW5nIGEgTlVMTCAiZXhjbHVzaW9uIi4KCkrDqXLDqW1pZQoKT24gVHVlLCBN
YXkgMTcsIDIwMTYgYXQgMTA6NDggQU0sIE1hdGhpZXUgRGVzbm95ZXJzCjxtYXRoaWV1LmRlc25v
eWVyc0BlZmZpY2lvcy5jb20+IHdyb3RlOgo+IENJRCAxMjU2MTgyICgjMiBvZiAyKTogRGVyZWZl
cmVuY2UgYWZ0ZXIgbnVsbCBjaGVjayAoRk9SV0FSRF9OVUxMKTE2Lgo+IHZhcl9kZXJlZl9vcDog
RGVyZWZlcmVuY2luZyBudWxsIHBvaW50ZXIgZXhjbHVzaW9uLgo+Cj4gU2lnbmVkLW9mZi1ieTog
TWF0aGlldSBEZXNub3llcnMgPG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbT4KPiAtLS0K
PiAgdGVzdHMvdW5pdC90ZXN0X3VzdF9kYXRhLmMgfCA0ICsrKy0KPiAgMSBmaWxlIGNoYW5nZWQs
IDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3Vu
aXQvdGVzdF91c3RfZGF0YS5jIGIvdGVzdHMvdW5pdC90ZXN0X3VzdF9kYXRhLmMKPiBpbmRleCBk
ODExNjk1Li4yMzZmNTA3IDEwMDY0NAo+IC0tLSBhL3Rlc3RzL3VuaXQvdGVzdF91c3RfZGF0YS5j
Cj4gKysrIGIvdGVzdHMvdW5pdC90ZXN0X3VzdF9kYXRhLmMKPiBAQCAtMzgsNyArMzgsNyBAQAo+
ICAjZGVmaW5lIFJBTkRPTV9TVFJJTkdfTEVOICAgICAgMTEKPgo+ICAvKiBOdW1iZXIgb2YgVEFQ
IHRlc3RzIGluIHRoaXMgZmlsZSAqLwo+IC0jZGVmaW5lIE5VTV9URVNUUyAxNQo+ICsjZGVmaW5l
IE5VTV9URVNUUyAxNgo+Cj4gIC8qIEZvciBlcnJvci5oICovCj4gIGludCBsdHRuZ19vcHRfcXVp
ZXQgPSAxOwo+IEBAIC0xODgsNiArMTg4LDggQEAgc3RhdGljIHZvaWQgdGVzdF9jcmVhdGVfdXN0
X2V2ZW50X2V4Y2x1c2lvbih2b2lkKQo+ICAgICAgICAgICAgICAgICBQRVJST1IoInptYWxsb2Mi
KTsKPiAgICAgICAgIH0KPgo+ICsgICAgICAgb2soZXhjbHVzaW9uICE9IE5VTEwsICJDcmVhdGUg
VVNUIGV4Y2x1c2lvbiIpOwo+ICsKPiAgICAgICAgIGV4Y2x1c2lvbi0+Y291bnQgPSBleGNsdXNp
b25fY291bnQ7Cj4gICAgICAgICBzdHJuY3B5KExUVE5HX0VWRU5UX0VYQ0xVU0lPTl9OQU1FX0FU
KGV4Y2x1c2lvbiwgMCksCj4gICAgICAgICAgICAgICAgIGdldF9yYW5kb21fc3RyaW5nKCksIExU
VE5HX1NZTUJPTF9OQU1FX0xFTik7Cj4gLS0KPiAyLjEuNAo+Cj4gX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cj4g
bHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwo+IGh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1i
aW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYKCgoKLS0gCkrDqXLDqW1pZSBHYWxhcm5lYXUK
RWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5n
LWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWls
bWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
