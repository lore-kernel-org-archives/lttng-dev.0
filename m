From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Fix: specify SONAME in
 python-lttngust LoadLibrary
Date: Tue, 21 Nov 2017 16:47:13 +0000 (UTC)
Message-ID: <752647985.19366.1511282833086.JavaMail.zimbra__10079.5519342229$1511282780$gmane$org@efficios.com>
References: <1511280675-28375-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3yhBLH0v3szhm0
 for <lttng-dev@lists.lttng.org>; Tue, 21 Nov 2017 16:46:14 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 9C165340321
 for <lttng-dev@lists.lttng.org>; Tue, 21 Nov 2017 16:47:13 +0000 (UTC)
In-Reply-To: <1511280675-28375-1-git-send-email-mjeanson@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

bWVyZ2VkIGludG8gbWFzdGVyLCAyLjksIDIuMTAsIHRoYW5rcyEKCk1hdGhpZXUKCi0tLS0tIE9u
IE5vdiAyMSwgMjAxNywgYXQgMTE6MTEgQU0sIE1pY2hhZWwgSmVhbnNvbiBtamVhbnNvbkBlZmZp
Y2lvcy5jb20gd3JvdGU6Cgo+IFdoZW4gbG9hZGluZyB0aGUgcHl0aG9uIGFnZW50IGxpYnJhcnkg
d2l0aCBjdHlwZXMgaW4gdGhlIHB5dGhvbgo+IGJpbmRpbmdzLCBzcGVjaWZ5IHRoZSBTT05BTUUu
IFRoaXMgd2lsbCBtYWtlIHN1cmUgd2UgbG9hZCB0aGUgcHJvcGVyCj4gbGlicmFyeSBpbiB0aGUg
ZXZlbnQgb2YgYSBTT05BTUUgYnVtcCBhbmQgdGhlIGJpbmRpbmdzIHdpbGwgd29yayB3aXRob3V0
Cj4gaGF2aW5nIHRvIGluc3RhbGwgdGhlICJkZXYiIHBhY2thZ2Ugd2hpY2ggaW4gbW9zdCBkaXN0
cm9zIGNvbnRhaW5zIHRoZQo+IG5vbi12ZXJzaW9ubmVkICIuc28iLgo+IAo+IFNpZ25lZC1vZmYt
Ynk6IE1pY2hhZWwgSmVhbnNvbiA8bWplYW5zb25AZWZmaWNpb3MuY29tPgo+IC0tLQo+IHB5dGhv
bi1sdHRuZ3VzdC9sdHRuZ3VzdC9sb2doYW5kbGVyLnB5IHwgMiArLQo+IDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS9weXRob24t
bHR0bmd1c3QvbHR0bmd1c3QvbG9naGFuZGxlci5weQo+IGIvcHl0aG9uLWx0dG5ndXN0L2x0dG5n
dXN0L2xvZ2hhbmRsZXIucHkKPiBpbmRleCBlODJjZjVjLi42ZjE0NGNhIDEwMDY0NAo+IC0tLSBh
L3B5dGhvbi1sdHRuZ3VzdC9sdHRuZ3VzdC9sb2doYW5kbGVyLnB5Cj4gKysrIGIvcHl0aG9uLWx0
dG5ndXN0L2x0dG5ndXN0L2xvZ2hhbmRsZXIucHkKPiBAQCAtMjIsNyArMjIsNyBAQCBpbXBvcnQg
Y3R5cGVzCj4gCj4gCj4gY2xhc3MgX0hhbmRsZXIobG9nZ2luZy5IYW5kbGVyKToKPiAtICAgIF9M
SUJfTkFNRSA9ICdsaWJsdHRuZy11c3QtcHl0aG9uLWFnZW50LnNvJwo+ICsgICAgX0xJQl9OQU1F
ID0gJ2xpYmx0dG5nLXVzdC1weXRob24tYWdlbnQuc28uMCcKPiAKPiAgICAgZGVmIF9faW5pdF9f
KHNlbGYpOgo+ICAgICAgICAgc3VwZXIoc2VsZi5fX2NsYXNzX18sIHNlbGYpLl9faW5pdF9fKGxl
dmVsPWxvZ2dpbmcuTk9UU0VUKQo+IC0tCj4gMi43LjQKCi0tIApNYXRoaWV1IERlc25veWVycwpF
ZmZpY2lPUyBJbmMuCmh0dHA6Ly93d3cuZWZmaWNpb3MuY29tCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmct
ZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxt
YW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
