From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?=
	<jeremie.galarneau@efficios.com>
Subject: [PATCH lttng-tools] Fix: mark generated python bindings
	files as nodist
Date: Fri, 15 Feb 2013 20:46:45 -0500
Message-ID: <1360979205-20346-1-git-send-email-jeremie.galarneau__47268.8816058964$1360979302$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vb0-f50.google.com ([209.85.212.50])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1U6WsB-0007nY-LR
	for lttng-dev@lists.lttng.org; Fri, 15 Feb 2013 20:47:27 -0500
Received: by mail-vb0-f50.google.com with SMTP id ft2so2534345vbb.9
	for <lttng-dev@lists.lttng.org>; Fri, 15 Feb 2013 17:47:22 -0800 (PST)
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

bWFrZSBkaXN0IHdvdWxkIGZhaWwgaWYgLi9jb25maWd1cmUgaGFkIG5vdCBiZWVuIGludm9rZWQg
d2l0aAp0aGUgLS1lbmFibGUtcHl0aG9uLWJpbmRpbmdzIHN3aXRjaC4KClNpZ25lZC1vZmYtYnk6
IErDqXLDqW1pZSBHYWxhcm5lYXUgPGplcmVtaWUuZ2FsYXJuZWF1QGVmZmljaW9zLmNvbT4KLS0t
CiBleHRyYXMvYmluZGluZ3Mvc3dpZy9weXRob24vTWFrZWZpbGUuYW0gfCA4ICsrKy0tLS0tCiAx
IGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2V4dHJhcy9iaW5kaW5ncy9zd2lnL3B5dGhvbi9NYWtlZmlsZS5hbSBiL2V4dHJhcy9iaW5k
aW5ncy9zd2lnL3B5dGhvbi9NYWtlZmlsZS5hbQppbmRleCBjNmE2OTAxLi42ZTdiYWE2IDEwMDY0
NAotLS0gYS9leHRyYXMvYmluZGluZ3Mvc3dpZy9weXRob24vTWFrZWZpbGUuYW0KKysrIGIvZXh0
cmFzL2JpbmRpbmdzL3N3aWcvcHl0aG9uL01ha2VmaWxlLmFtCkBAIC00LDE2ICs0LDE0IEBAIGx0
dG5nLmk6IGx0dG5nLmkuaW4KIEFNX0NGTEFHUyA9IC1JJChQWVRIT05fSU5DTFVERSkgLUkkKHRv
cF9zcmNkaXIpL2xpYi9sdHRuZy1jdGwgLUkuLi9jb21tb24gXAogICAgICAgICAgICAgICAkKEJV
RERZX0NGTEFHUykKIAotRVhUUkFfRElTVCA9IGx0dG5nLmkKLXB5dGhvbl9QWVRIT04gPSBsdHRu
Zy5weQorRVhUUkFfRElTVCA9IGx0dG5nLmkuaW4KK25vZGlzdF9weXRob25fUFlUSE9OID0gbHR0
bmcucHkKIHB5ZXhlY19MVExJQlJBUklFUyA9IF9sdHRuZy5sYQogCiBNQUlOVEFJTkVSQ0xFQU5G
SUxFUyA9IGx0dG5nX3dyYXAuYyBsdHRuZy5weQogCi1fbHR0bmdfbGFfU09VUkNFUyA9IGx0dG5n
X3dyYXAuYwotCitub2Rpc3RfX2x0dG5nX2xhX1NPVVJDRVMgPSBsdHRuZ193cmFwLmMKIF9sdHRu
Z19sYV9MREZMQUdTID0gLW1vZHVsZQotCiBfbHR0bmdfbGFfTElCQUREID0gCSQodG9wX3NyY2Rp
cikvc3JjL2xpYi9sdHRuZy1jdGwvbGlibHR0bmctY3RsLmxhIAkJXAogCQkJJCh0b3Bfc3JjZGly
KS9zcmMvY29tbW9uL3Nlc3Npb25kLWNvbW0vbGlic2Vzc2lvbmQtY29tbS5sYQogCi0tIAoxLjgu
MS4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0
bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHA6Ly9saXN0
cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
