From: Liguang Li <liguang.li@windriver.com>
Subject: [PATCH] Fix: truncate the metadata file in shm-path
Date: Mon, 28 Nov 2016 16:37:47 +0800
Message-ID: <1480322267-12997-1-git-send-email-liguang.li__25997.3105778501$1480334640$gmane$org@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 by lists.lttng.org (Postfix) with ESMTPS id 3tS53R1mwDzlxw
 for <lttng-dev@lists.lttng.org>; Mon, 28 Nov 2016 12:05:22 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
 [147.11.189.40])
 by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id uAS8bnEZ020057
 (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
 for <lttng-dev@lists.lttng.org>; Mon, 28 Nov 2016 00:37:49 -0800 (PST)
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

SW4gdGhlIHNobS1wYXRoIG1vZGUsIHRoZSBtZXRhZGF0YSB3aWxsIGJlIGJhY2t1cGVkIHRvIGEg
bWV0YWRhdGEgZmlsZSwKd2hlbiBydW4gdGhlIGx0dG5nIGNvbW1hbmQgImx0dG5nIG1ldGFkYXRh
IHJlZ2VuZXJhdGUiIHRvIHJlc2FtcGxlIHRoZQp3YWxsIHRpbWUgZm9sbG93aW5nIGEgbWFqb3Ig
TlRQIGNvcnJlY3Rpb24sIHRoZSBtZXRhZGF0YSBmaWxlIHdpbGwgbm90CmJlIHRydW5jYXRlZCBh
bmQgcmVnZW5lcmF0ZWQuCgpBZGQgdGhlIGZ1bmN0aW9uIHVzdF9tZXRhZGF0YV90cnVuY2F0ZSgp
IHRvIHRydW5jYXRlIGFuZCByZWdlbmVyYXRlIHRoZQptZXRhZGF0YSBmaWxlLgoKU2lnbmVkLW9m
Zi1ieTogTGlndWFuZyBMaSA8bGlndWFuZy5saUB3aW5kcml2ZXIuY29tPgotLS0KIHNyYy9iaW4v
bHR0bmctc2Vzc2lvbmQvY21kLmMgfCAyOCArKysrKysrKysrKysrKysrKysrKysrKysrKysrCiAx
IGZpbGUgY2hhbmdlZCwgMjggaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3NyYy9iaW4vbHR0
bmctc2Vzc2lvbmQvY21kLmMgYi9zcmMvYmluL2x0dG5nLXNlc3Npb25kL2NtZC5jCmluZGV4IDMy
NWZmZDIuLmJhODMyMjYgMTAwNjQ0Ci0tLSBhL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvY21kLmMK
KysrIGIvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9jbWQuYwpAQCAtMzM3OCw2ICszMzc4LDI1IEBA
IGVuZDoKIH0KIAogc3RhdGljCitpbnQgdXN0X21ldGFkYXRhX3RydW5jYXRlKGludCBmZCwgc2l6
ZV90IGxlbmd0aCkKK3sKKwlpbnQgcmV0OworCisJcmV0ID0gbHNlZWsoZmQsIGxlbmd0aCwgU0VF
S19TRVQpOworCWlmIChyZXQgPCAwKSB7CisJCVBFUlJPUigibHNlZWsiKTsKKwkJZ290byBvdXQ7
CisJfQorCisJcmV0ID0gZnRydW5jYXRlKGZkLCBsZW5ndGgpOworCWlmIChyZXQgPCAwKQorCQlQ
RVJST1IoImZ0cnVuY2F0ZSIpOworCitvdXQ6CisJcmV0dXJuIHJldDsKK30KKworc3RhdGljCiBp
bnQgdXN0X3JlZ2VuZXJhdGVfbWV0YWRhdGEoc3RydWN0IGx0dF91c3Rfc2Vzc2lvbiAqdXNlc3Mp
CiB7CiAJaW50IHJldCA9IDA7CkBAIC0zMzk4LDYgKzM0MTcsMTUgQEAgaW50IHVzdF9yZWdlbmVy
YXRlX21ldGFkYXRhKHN0cnVjdCBsdHRfdXN0X3Nlc3Npb24gKnVzZXNzKQogCQltZW1zZXQocmVn
aXN0cnktPm1ldGFkYXRhLCAwLCByZWdpc3RyeS0+bWV0YWRhdGFfYWxsb2NfbGVuKTsKIAkJcmVn
aXN0cnktPm1ldGFkYXRhX2xlbiA9IDA7CiAJCXJlZ2lzdHJ5LT5tZXRhZGF0YV92ZXJzaW9uKys7
CisJCS8qdHJ1bmNhdGUgdGhlIG1ldGFkYXRhIGZpbGUqLworCQlpZiAocmVnaXN0cnktPm1ldGFk
YXRhX2ZkID4gMCkgeworCQkJcmV0ID0gdXN0X21ldGFkYXRhX3RydW5jYXRlKHJlZ2lzdHJ5LT5t
ZXRhZGF0YV9mZCwgMCk7CisJCQlpZiAocmV0KSB7CisJCQkJcHRocmVhZF9tdXRleF91bmxvY2so
JnJlZ2lzdHJ5LT5sb2NrKTsKKwkJCQlnb3RvIGVuZDsKKwkJCX0KKwkJfQorCiAJCXJldCA9IHVz
dF9tZXRhZGF0YV9zZXNzaW9uX3N0YXRlZHVtcChyZWdpc3RyeSwgTlVMTCwKIAkJCQlyZWdpc3Ry
eS0+bWFqb3IsIHJlZ2lzdHJ5LT5taW5vcik7CiAJCWlmIChyZXQpIHsKLS0gCjIuNy40CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFp
bGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5v
cmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
