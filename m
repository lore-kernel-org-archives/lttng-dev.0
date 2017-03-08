From: Francis Deslauriers <francis.deslauriers@efficios.com>
Subject: [PATCH lttng-modules] Fix: use of uninitialized ret
	value in lttng_abi_open_metadata_stream
Date: Wed,  8 Mar 2017 14:32:31 -0500
Message-ID: <1489001551-14259-1-git-send-email-francis.deslauriers__40014.7091052078$1489001577$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3vdkFQ3L3nzwP5
 for <lttng-dev@lists.lttng.org>; Wed,  8 Mar 2017 19:32:42 +0000 (UTC)
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
List-Id: lttng-dev@lists.lttng.org

Rml4ZXMgdGhlIGZvbGxvd2luZyBjb21waWxlciB3YXJuaW5nOgoKbHR0bmctYWJpLmM6IEluIGZ1
bmN0aW9uIOKAmGx0dG5nX21ldGFkYXRhX2lvY3Rs4oCZOgpsdHRuZy1hYmkuYzo5NzE6Njogd2Fy
bmluZzog4oCYcmV04oCZIG1heSBiZSB1c2VkIHVuaW5pdGlhbGl6ZWQgaW4gdGhpcyBmdW5jdGlv
biBbLVdtYXliZS11bmluaXRpYWxpemVkXQogIGludCByZXQ7CiAgICAgIF4KClNpZ25lZC1vZmYt
Ynk6IEZyYW5jaXMgRGVzbGF1cmllcnMgPGZyYW5jaXMuZGVzbGF1cmllcnNAZWZmaWNpb3MuY29t
PgotLS0KIGx0dG5nLWFiaS5jIHwgNSArKysrLQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2x0dG5nLWFiaS5jIGIvbHR0bmctYWJp
LmMKaW5kZXggZTE5M2Y0My4uNDc4YTU5MSAxMDA2NDQKLS0tIGEvbHR0bmctYWJpLmMKKysrIGIv
bHR0bmctYWJpLmMKQEAgLTk5OCw4ICs5OTgsMTEgQEAgaW50IGx0dG5nX2FiaV9vcGVuX21ldGFk
YXRhX3N0cmVhbShzdHJ1Y3QgZmlsZSAqY2hhbm5lbF9maWxlKQogCQlnb3RvIG5vdHJhbnNwb3J0
OwogCX0KIAotCWlmICghbHR0bmdfa3JlZl9nZXQoJnNlc3Npb24tPm1ldGFkYXRhX2NhY2hlLT5y
ZWZjb3VudCkpCisJaWYgKCFsdHRuZ19rcmVmX2dldCgmc2Vzc2lvbi0+bWV0YWRhdGFfY2FjaGUt
PnJlZmNvdW50KSkgeworCQlyZXQgPSAtRU9WRVJGTE9XOwogCQlnb3RvIGtyZWZfZXJyb3I7CisJ
fQorCiAJcmV0ID0gbHR0bmdfYWJpX2NyZWF0ZV9zdHJlYW1fZmQoY2hhbm5lbF9maWxlLCBzdHJl
YW1fcHJpdiwKIAkJCSZsdHRuZ19tZXRhZGF0YV9yaW5nX2J1ZmZlcl9maWxlX29wZXJhdGlvbnMp
OwogCWlmIChyZXQgPCAwKQotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3Rz
Lmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGlu
Zm8vbHR0bmctZGV2Cg==
