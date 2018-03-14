From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools] Fix: double similar condition
Date: Wed, 14 Mar 2018 17:35:05 -0400
Message-ID: <1521063305-14511-1-git-send-email-jonathan.rajotte-julien__32626.6904281967$1521063201$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 401lPY5sK7z17r
 for <lttng-dev@lists.lttng.org>; Wed, 14 Mar 2018 17:35:13 -0400 (EDT)
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

QmFzZWQgb24gdGhlIHBhdHRlcm4gb2YgdGhlIGZ1bmN0aW9uLCB0aHJlc2hvbGRfYnl0ZXMgc2hv
dWxkIGJlIHVzZWQKaW5zaWRlIHRoZSAiZWxzZSBpZiIgY29uZGl0aW9uLgoKU2lnbmVkLW9mZi1i
eTogSm9uYXRoYW4gUmFqb3R0ZSA8am9uYXRoYW4ucmFqb3R0ZS1qdWxpZW5AZWZmaWNpb3MuY29t
PgotLS0KIHNyYy9iaW4vbHR0bmctc2Vzc2lvbmQvbm90aWZpY2F0aW9uLXRocmVhZC1ldmVudHMu
YyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoK
ZGlmZiAtLWdpdCBhL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvbm90aWZpY2F0aW9uLXRocmVhZC1l
dmVudHMuYyBiL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvbm90aWZpY2F0aW9uLXRocmVhZC1ldmVu
dHMuYwppbmRleCAzOTQ2MmI1Li42ZDVlNjI1IDEwMDY0NAotLS0gYS9zcmMvYmluL2x0dG5nLXNl
c3Npb25kL25vdGlmaWNhdGlvbi10aHJlYWQtZXZlbnRzLmMKKysrIGIvc3JjL2Jpbi9sdHRuZy1z
ZXNzaW9uZC9ub3RpZmljYXRpb24tdGhyZWFkLWV2ZW50cy5jCkBAIC0yOTUsNyArMjk1LDcgQEAg
dW5zaWduZWQgbG9uZyBsdHRuZ19jb25kaXRpb25fYnVmZmVyX3VzYWdlX2hhc2goCiAKIAkJdmFs
ID0gY29uZGl0aW9uLT50aHJlc2hvbGRfcmF0aW8udmFsdWUgKiAoZG91YmxlKSBVSU5UMzJfTUFY
OwogCQloYXNoIF49IGhhc2hfa2V5X3U2NCgmdmFsLCBsdHRuZ19odF9zZWVkKTsKLQl9IGVsc2Ug
aWYgKGNvbmRpdGlvbi0+dGhyZXNob2xkX3JhdGlvLnNldCkgeworCX0gZWxzZSBpZiAoY29uZGl0
aW9uLT50aHJlc2hvbGRfYnl0ZXMuc2V0KSB7CiAJCXVpbnQ2NF90IHZhbDsKIAogCQl2YWwgPSBj
b25kaXRpb24tPnRocmVzaG9sZF9ieXRlcy52YWx1ZTsKLS0gCjIuNy40CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0
Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJp
bi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
