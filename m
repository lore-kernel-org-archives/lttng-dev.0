From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?=
	<jeremie.galarneau@efficios.com>
Subject: [PATCH babeltrace] Fix ctf-writer: possible use after
	free
Date: Fri, 29 Nov 2013 13:26:42 -0500
Message-ID: <1385749602-13426-1-git-send-email-jeremie.galarneau__28088.8244430118$1385749668$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qe0-f53.google.com ([209.85.128.53])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1VmSm9-0002aP-WA
	for lttng-dev@lists.lttng.org; Fri, 29 Nov 2013 13:26:56 -0500
Received: by mail-qe0-f53.google.com with SMTP id nc12so9061048qeb.40
	for <lttng-dev@lists.lttng.org>; Fri, 29 Nov 2013 10:26:44 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Y3RmX3N0cmVhbV9wb3MnIGJhc2VfbW1hIG1lbWJlciBtdXN0IGJlIGNvcGllZCBmcm9tIHN0cmVh
bS0+cG9zIGJlZm9yZQp1cGRhdGluZyB0aGUgZmluYWwgcGFja2V0IGFuZCBjb250ZW50IHNpemVz
LiBUaGUgb3JpZ2luYWwgYmFzZV9tbWEKc3RydWN0dXJlIHdpbGwgYmUgcmVhbGxvY2F0ZWQgaWYg
dGhlIHBhY2tldCBpcyByZXNpemVkLgoKU2lnbmVkLW9mZi1ieTogSsOpcsOpbWllIEdhbGFybmVh
dSA8amVyZW1pZS5nYWxhcm5lYXVAZWZmaWNpb3MuY29tPgotLS0KIGZvcm1hdHMvY3RmL3dyaXRl
ci9zdHJlYW0uYyB8IDMgKysrCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCgpkaWZm
IC0tZ2l0IGEvZm9ybWF0cy9jdGYvd3JpdGVyL3N0cmVhbS5jIGIvZm9ybWF0cy9jdGYvd3JpdGVy
L3N0cmVhbS5jCmluZGV4IGFjODk0MjkuLjRlZmIzNjkgMTAwNjQ0Ci0tLSBhL2Zvcm1hdHMvY3Rm
L3dyaXRlci9zdHJlYW0uYworKysgYi9mb3JtYXRzL2N0Zi93cml0ZXIvc3RyZWFtLmMKQEAgLTQ2
NCw3ICs0NjQsMTAgQEAgaW50IGJ0X2N0Zl9zdHJlYW1fZmx1c2goc3RydWN0IGJ0X2N0Zl9zdHJl
YW0gKnN0cmVhbSkKIAkvKgogCSAqIFVwZGF0ZSB0aGUgcGFja2V0IHRvdGFsIHNpemUgYW5kIGNv
bnRlbnQgc2l6ZSBhbmQgb3ZlcndyaXRlIHRoZQogCSAqIHBhY2tldCBjb250ZXh0LgorCSAqIENv
cHkgYmFzZV9tbWEgYXMgdGhlIHBhY2tldCBtYXkgaGF2ZSBiZWVuIHJlbWFwcGVkIChlLmcuIHdo
ZW4gYQorCSAqIHBhY2tldCBpcyByZXNpemVkKS4KIAkgKi8KKwlwYWNrZXRfY29udGV4dF9wb3Mu
YmFzZV9tbWEgPSBzdHJlYW0tPnBvcy5iYXNlX21tYTsKIAlyZXQgPSBzZXRfc3RydWN0dXJlX2Zp
ZWxkX2ludGVnZXIoc3RyZWFtX2NsYXNzLT5wYWNrZXRfY29udGV4dCwKIAkJImNvbnRlbnRfc2l6
ZSIsIHN0cmVhbS0+cG9zLm9mZnNldCk7CiAJaWYgKHJldCkgewotLSAKMS44LjQuMgoKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWls
aW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwOi8vbGlzdHMubHR0bmcub3Jn
L2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
