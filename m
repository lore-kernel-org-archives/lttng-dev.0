From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 1/2] Fix:
	thread_dispatch_ust_registration needs to be a RCU thread
Date: Wed, 18 Jan 2017 19:23:26 -0500
Message-ID: <1484785407-28923-1-git-send-email-mathieu.desnoyers__39440.0001307533$1484785460$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3v3l402XW3zjtC
 for <lttng-dev@lists.lttng.org>; Thu, 19 Jan 2017 00:25:36 +0000 (UTC)
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

SXQgdXNlcyBhIHJlYWQtc2lkZSBsb2NrLgoKU2lnbmVkLW9mZi1ieTogTWF0aGlldSBEZXNub3ll
cnMgPG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbT4KLS0tCiBzcmMvYmluL2x0dG5nLXNl
c3Npb25kL21haW4uYyB8IDMgKysrCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCgpk
aWZmIC0tZ2l0IGEvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9tYWluLmMgYi9zcmMvYmluL2x0dG5n
LXNlc3Npb25kL21haW4uYwppbmRleCA0MDY3MGRkLi4xNzJmOGMyIDEwMDY0NAotLS0gYS9zcmMv
YmluL2x0dG5nLXNlc3Npb25kL21haW4uYworKysgYi9zcmMvYmluL2x0dG5nLXNlc3Npb25kL21h
aW4uYwpAQCAtMTg1NSw2ICsxODU1LDggQEAgc3RhdGljIHZvaWQgKnRocmVhZF9kaXNwYXRjaF91
c3RfcmVnaXN0cmF0aW9uKHZvaWQgKmRhdGEpCiAJCS5jb3VudCA9IDAsCiAJfTsKIAorCXJjdV9y
ZWdpc3Rlcl90aHJlYWQoKTsKKwogCWhlYWx0aF9yZWdpc3RlcihoZWFsdGhfc2Vzc2lvbmQsIEhF
QUxUSF9TRVNTSU9ORF9UWVBFX0FQUF9SRUdfRElTUEFUQ0gpOwogCiAJaWYgKHRlc3Rwb2ludChz
ZXNzaW9uZF90aHJlYWRfYXBwX3JlZ19kaXNwYXRjaCkpIHsKQEAgLTIwODgsNiArMjA5MCw3IEBA
IGVycm9yX3Rlc3Rwb2ludDoKIAkJRVJSKCJIZWFsdGggZXJyb3Igb2NjdXJyZWQgaW4gJXMiLCBf
X2Z1bmNfXyk7CiAJfQogCWhlYWx0aF91bnJlZ2lzdGVyKGhlYWx0aF9zZXNzaW9uZCk7CisJcmN1
X3VucmVnaXN0ZXJfdGhyZWFkKCk7CiAJcmV0dXJuIE5VTEw7CiB9CiAKLS0gCjIuMS40CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFp
bGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5v
cmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
