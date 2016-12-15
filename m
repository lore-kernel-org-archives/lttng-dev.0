From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: add element length check in
	lttng_index_file_open
Date: Thu, 15 Dec 2016 12:13:19 +0100
Message-ID: <1481800399-10077-1-git-send-email-mathieu.desnoyers__24562.1462855071$1481800421$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3tfW8G2xMQzv88
 for <lttng-dev@lists.lttng.org>; Thu, 15 Dec 2016 11:15:42 +0000 (UTC)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

SGFuZGxlIGNhc2VzIHdoZXJlIHRoZSBpbmRleCBmaWxlIGhlYWRlciB3b3VsZCBjb250YWluIGEg
Y29ycnVwdGVkCnZhbHVlLgoKU2lnbmVkLW9mZi1ieTogTWF0aGlldSBEZXNub3llcnMgPG1hdGhp
ZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbT4KLS0tCiBzcmMvY29tbW9uL2luZGV4L2luZGV4LmMg
fCA0ICsrKysKIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9z
cmMvY29tbW9uL2luZGV4L2luZGV4LmMgYi9zcmMvY29tbW9uL2luZGV4L2luZGV4LmMKaW5kZXgg
YmE2OWNkYy4uZWNkNGQ0NSAxMDA2NDQKLS0tIGEvc3JjL2NvbW1vbi9pbmRleC9pbmRleC5jCisr
KyBiL3NyYy9jb21tb24vaW5kZXgvaW5kZXguYwpAQCAtMjQ2LDYgKzI0NiwxMCBAQCBzdHJ1Y3Qg
bHR0bmdfaW5kZXhfZmlsZSAqbHR0bmdfaW5kZXhfZmlsZV9vcGVuKGNvbnN0IGNoYXIgKnBhdGhf
bmFtZSwKIAkJRVJSKCJJbnZhbGlkIGhlYWRlciB2ZXJzaW9uIik7CiAJCWdvdG8gZXJyb3JfY2xv
c2U7CiAJfQorCWlmIChlbGVtZW50X2xlbiA+IHNpemVvZihzdHJ1Y3QgY3RmX3BhY2tldF9pbmRl
eCkpIHsKKwkJRVJSKCJJbmRleCBlbGVtZW50IGxlbmd0aCB0b28gbG9uZyIpOworCQlnb3RvIGVy
cm9yX2Nsb3NlOworCX0KIAogCWluZGV4X2ZpbGUtPmZkID0gcmVhZF9mZDsKIAlpbmRleF9maWxl
LT5tYWpvciA9IG1ham9yOwotLSAKMi4xLjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3Rz
Lmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGlu
Zm8vbHR0bmctZGV2Cg==
