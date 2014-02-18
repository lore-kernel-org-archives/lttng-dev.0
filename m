From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?=
	<jeremie.galarneau@efficios.com>
Subject: [PATCH lttng-ust] Fix: java-jul/Makefile should not be
	marked as a binary
Date: Tue, 18 Feb 2014 13:59:35 -0500
Message-ID: <1392749975-25136-1-git-send-email-jeremie.galarneau__36340.4875192375$1392750051$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1WFptP-0007Y5-CX
	for lttng-dev@lists.lttng.org; Tue, 18 Feb 2014 13:59:48 -0500
Received: by mail-qc0-f181.google.com with SMTP id e9so25762405qcy.26
	for <lttng-dev@lists.lttng.org>; Tue, 18 Feb 2014 10:59:37 -0800 (PST)
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

amF2YS1qdWwvTWFrZWZpbGUgaXMgcGFydCBvZiBiaW5fU0NSSVBUUyB3aGljaCBjYXVzZXMgaXQg
dG8gYmUKaW5zdGFsbGVkIHVuZGVyIC91c3IvbG9jYWwvYmluLgoKSXQgaXMgYWxyZWFkeSBpbnN0
YWxsZWQgYXMgYW4gZXhhbXBsZS4KClNpZ25lZC1vZmYtYnk6IErDqXLDqW1pZSBHYWxhcm5lYXUg
PGplcmVtaWUuZ2FsYXJuZWF1QGVmZmljaW9zLmNvbT4KLS0tCiBkb2MvZXhhbXBsZXMvTWFrZWZp
bGUuYW0gfCAxIC0KIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEv
ZG9jL2V4YW1wbGVzL01ha2VmaWxlLmFtIGIvZG9jL2V4YW1wbGVzL01ha2VmaWxlLmFtCmluZGV4
IGUxOWFmMzguLjk3MWVlYzMgMTAwNjQ0Ci0tLSBhL2RvYy9leGFtcGxlcy9NYWtlZmlsZS5hbQor
KysgYi9kb2MvZXhhbXBsZXMvTWFrZWZpbGUuYW0KQEAgLTEwLDcgKzEwLDYgQEAgZGlzdF9kb2Nf
ZXhhbXBsZXNfamF2YV9qdWxfREFUQSA9IGphdmEtanVsL01ha2VmaWxlIFwKIAkJCQkJCQkJICBq
YXZhLWp1bC9IZWxsby5qYXZhIFwKIAkJCQkJCQkJICBqYXZhLWp1bC9ydW4KIFNVQkRJUlNfSlVM
ID0gamF2YS1qdWwKLWJpbl9TQ1JJUFRTID0gamF2YS1qdWwvTWFrZWZpbGUKIGVuZGlmCiAKIGRp
c3RfZG9jX2V4YW1wbGVzX0RBVEEgPSBSRUFETUUKLS0gCjEuOS4wCgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdAps
dHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHA6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9t
YWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
