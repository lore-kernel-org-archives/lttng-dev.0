From: Michael Jeanson <mjeanson@efficios.com>
Subject: Re: [PATCH babeltrace stable-1.5] Fix: ctf writer test
	on Cygwin
Date: Mon, 10 Apr 2017 18:18:29 -0400
Message-ID: <f2d9cd23-4bda-7c6e-9a45-d0fe53202278__6690.8257468187$1491862725$gmane$org@efficios.com>
References: <1491505244-340-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3w24N922LBzCBG
 for <lttng-dev@lists.lttng.org>; Mon, 10 Apr 2017 22:19:04 +0000 (UTC)
In-Reply-To: <1491505244-340-1-git-send-email-mjeanson@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

T24gMjAxNy0wNC0wNiAxNTowMCwgTWljaGFlbCBKZWFuc29uIHdyb3RlOgo+IEluIHRoZSBjdGYg
d3JpdGVyIHRlc3Qgd2UgZXhlY2woKSBzb21lIGxpYnRvb2wgd3JhcHBlcnMgdGhhdCBnZXQgY29u
ZnVzZWQKPiB3aGVuIGFyZ1swXSBpcyBub3QgdGhlIGZ1bGwgcGF0aCB0byB0aGUgYmluYXJ5Lgo+
IAo+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgSmVhbnNvbiA8bWplYW5zb25AZWZmaWNpb3MuY29t
Pgo+IC0tLQo+ICB0ZXN0cy9saWIvdGVzdF9jdGZfd3JpdGVyLmMgfCA0ICsrLS0KPiAgMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0
IGEvdGVzdHMvbGliL3Rlc3RfY3RmX3dyaXRlci5jIGIvdGVzdHMvbGliL3Rlc3RfY3RmX3dyaXRl
ci5jCj4gaW5kZXggOTYxZGY3OS4uNTM2MTNjOSAxMDA2NDQKPiAtLS0gYS90ZXN0cy9saWIvdGVz
dF9jdGZfd3JpdGVyLmMKPiArKysgYi90ZXN0cy9saWIvdGVzdF9jdGZfd3JpdGVyLmMKPiBAQCAt
OTQsNyArOTQsNyBAQCB2b2lkIHZhbGlkYXRlX21ldGFkYXRhKGNoYXIgKnBhcnNlcl9wYXRoLCBj
aGFyICptZXRhZGF0YV9wYXRoKQo+ICAJCQlnb3RvIHJlc3VsdDsKPiAgCQl9Cj4gIAo+IC0JCWV4
ZWNsKHBhcnNlcl9wYXRoLCAiY3RmLXBhcnNlci10ZXN0IiwgKGNoYXIgKikgTlVMTCk7Cj4gKwkJ
ZXhlY2wocGFyc2VyX3BhdGgsIHBhcnNlcl9wYXRoLCAoY2hhciAqKSBOVUxMKTsKPiAgCQlwZXJy
b3IoIiMgQ291bGQgbm90IGxhdW5jaCB0aGUgY3RmIG1ldGFkYXRhIHBhcnNlciBwcm9jZXNzIik7
Cj4gIAkJZXhpdCgtMSk7Cj4gIAl9Cj4gQEAgLTIwMSw3ICsyMDEsNyBAQCB2b2lkIHZhbGlkYXRl
X3RyYWNlKGNoYXIgKnBhcnNlcl9wYXRoLCBjaGFyICp0cmFjZV9wYXRoKQo+ICAJCQlnb3RvIHJl
c3VsdDsKPiAgCQl9Cj4gIAo+IC0JCWV4ZWNsKHBhcnNlcl9wYXRoLCAiYmFiZWx0cmFjZSIsIHRy
YWNlX3BhdGgsIChjaGFyICopIE5VTEwpOwo+ICsJCWV4ZWNsKHBhcnNlcl9wYXRoLCBwYXJzZXJf
cGF0aCwgdHJhY2VfcGF0aCwgKGNoYXIgKikgTlVMTCk7Cj4gIAkJcGVycm9yKCIjIENvdWxkIG5v
dCBsYXVuY2ggdGhlIGJhYmVsdHJhY2UgcHJvY2VzcyIpOwo+ICAJCWV4aXQoLTEpOwo+ICAJfQo+
IAoKWW91IGNhbiBob2xkIG9uIG1lcmdpbmcgdGhpcyBwYXRjaCBmb3Igbm93LCBJIHRoaW5rIGl0
J3Mgb25seSB1c2VmdWwgZm9yCmEgdmVyeSBzcGVjaWZpYyBlbnZpcm9ubWVudCB3aGljaCBtaWdo
dCBub3QgYmUgd29ydGggc3VwcG9ydGluZy4KCk1pY2hhZWwKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1k
ZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1h
bi9saXN0aW5mby9sdHRuZy1kZXYK
