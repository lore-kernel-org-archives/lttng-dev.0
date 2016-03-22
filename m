From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools v2] Bug 1002
Date: Tue, 22 Mar 2016 14:12:03 -0400
Message-ID: <1458670328-17521-1-git-send-email-jonathan.rajotte-julien__37687.4662506909$1458670379$gmane$org@efficios.com>
References: <367304197.32343.1458596988829.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 3F884A07A3
 for <lttng-dev@lists.lttng.org>; Tue, 22 Mar 2016 18:12:23 +0000 (UTC)
In-Reply-To: <367304197.32343.1458596988829.JavaMail.zimbra@efficios.com>
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

SGkgTWF0aGlldSwKClRoZSBmb2xsb3dpbmcgcGF0Y2hlcyBzaG91bGQgbWFrZSB0aGVzZSBjaGFu
Z2VzIG1vcmUgZXhwbGljaXQuIFRoYW5rcyBmb3IKcG9pbnRpbmcgdGhhdCBvdXQuCgpUaGUgbWFp
biByZWFzb24gZm9yIHRoZSByZWZhY3RvcmluZyBpcyB0aGF0IGJ1ZyAxMDAyWzFdIGlzIGNhdXNl
ZCBieQp0aGUgcHJlc2VuY2Ugb2YgMiBjb2RlIHBhdGhzIGZvciBzbmFwc2hvdCByZWNvcmRpbmc6
IG9uZSBmb3IgbWkgYW5kIG9uZSBmb3IKbm9ybWFsIGV4ZWN1dGlvbi4gU2luY2UgTVNHIG1hY3Jv
IGFyZSBkaXNhYmxlZCB3aXRoIHRoZSBwcmVzZW5jZSBvZiAtLW1pIG9uIHRoZQpjb21tYW5kIGxp
bmUsIGl0IGlzIHNpbXBsZXIgdG8gZW1iZWQgdGhlIG1pIGNvZGUgYXMgZG9uZSBpbiBvdGhlciBj
b21tYW5kcy4KCkJ1ZyAxMDAyWzFdIGFsc28gbWVudGlvbiB0aGF0IGEgc2ltcGxlIHdhcm5pbmcg
d2hlbiBhdHRlbXB0aW5nIGFuIGVtcHR5IHNuYXBzaG90CnJlY29yZCBzaG91bGQgbm90IHJldHVy
biBhbiBlcnJvciB0byB0aGUgY29tbWFuZCBsaW5lLiBUaGlzIGlzIGZpeGVkIGluCiJGaXg6IGRv
IG5vdCByZXR1cm4gZXJyb3Igb24gTFRUTkdfRVJSX1NOQVBTSE9UX05PREFUQSIuCgpbMV0gaHR0
cHM6Ly9idWdzLmx0dG5nLm9yZy9pc3N1ZXMvMTAwMgoKQ2hlZXJzCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0
dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9t
YWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
