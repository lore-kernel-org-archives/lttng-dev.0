From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules] Fix: update ringbuffer for
	kernel 4.12
Date: Wed, 24 May 2017 16:13:00 +0000 (UTC)
Message-ID: <1735213547.24136.1495642380183.JavaMail.zimbra__25150.7131419659$1495642747$gmane$org@efficios.com>
References: <1495568747-29103-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3wXy9W2x0Bz1144
 for <lttng-dev@lists.lttng.org>; Wed, 24 May 2017 16:13:02 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id D153C340378
 for <lttng-dev@lists.lttng.org>; Wed, 24 May 2017 16:13:02 +0000 (UTC)
In-Reply-To: <1495568747-29103-1-git-send-email-mjeanson@efficios.com>
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

TWVyZ2VkIGludG8gbWFzdGVyLCAyLjEwLCAyLjksIDIuOCwgdGhhbmtzIQoKLS0tLS0gT24gTWF5
IDIzLCAyMDE3LCBhdCA5OjQ1IFBNLCBNaWNoYWVsIEplYW5zb24gbWplYW5zb25AZWZmaWNpb3Mu
Y29tIHdyb3RlOgoKPiBmbGFncyByZW1vdmVkIGZyb20gc3BsaWNlX3BpcGVfZGVzYyBpbiA0LjEy
Lgo+IAo+IFNlZSB1cHN0cmVhbSBjb21taXQgZjgxZGM3ZDdkNWEyNTI4Zjk4ZjI2YTBiOTQwNmU4
MjJkMGIzNTAxMQo+IAo+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgSmVhbnNvbiA8bWplYW5zb25A
ZWZmaWNpb3MuY29tPgo+IC0tLQo+IGxpYi9yaW5nYnVmZmVyL3JpbmdfYnVmZmVyX3NwbGljZS5j
IHwgMiArKwo+IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0
IGEvbGliL3JpbmdidWZmZXIvcmluZ19idWZmZXJfc3BsaWNlLmMKPiBiL2xpYi9yaW5nYnVmZmVy
L3JpbmdfYnVmZmVyX3NwbGljZS5jCj4gaW5kZXggMDYxMGNhYS4uOGQxNDY2NiAxMDA2NDQKPiAt
LS0gYS9saWIvcmluZ2J1ZmZlci9yaW5nX2J1ZmZlcl9zcGxpY2UuYwo+ICsrKyBiL2xpYi9yaW5n
YnVmZmVyL3JpbmdfYnVmZmVyX3NwbGljZS5jCj4gQEAgLTk1LDcgKzk1LDkgQEAgc3RhdGljIGlu
dCBzdWJidWZfc3BsaWNlX2FjdG9yKHN0cnVjdCBmaWxlICppbiwKPiAJCS5wYWdlcyA9IHBhZ2Vz
LAo+IAkJLm5yX3BhZ2VzID0gMCwKPiAJCS5wYXJ0aWFsID0gcGFydGlhbCwKPiArI2lmIChMSU5V
WF9WRVJTSU9OX0NPREUgPCBLRVJORUxfVkVSU0lPTig0LDEyLDApKQo+IAkJLmZsYWdzID0gZmxh
Z3MsCj4gKyNlbmRpZgo+IAkJLm9wcyA9ICZyaW5nX2J1ZmZlcl9waXBlX2J1Zl9vcHMsCj4gCQku
c3BkX3JlbGVhc2UgPSBsaWJfcmluZ19idWZmZXJfcGFnZV9yZWxlYXNlLAo+IAl9Owo+IC0tCj4g
Mi43LjQKCi0tIApNYXRoaWV1IERlc25veWVycwpFZmZpY2lPUyBJbmMuCmh0dHA6Ly93d3cuZWZm
aWNpb3MuY29tCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Cmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczov
L2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
