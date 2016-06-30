From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [PATCH lttng-tools 2/6] UST command to regenerate the
	statedump
Date: Thu, 30 Jun 2016 12:36:30 -0400
Message-ID: <1467304594-30100-2-git-send-email-jdesfossez__34750.5197780722$1467304631$gmane$org@efficios.com>
References: <1467304594-30100-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com (unknown [192.99.35.19])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id C84C1A1F8D
 for <lttng-dev@lists.lttng.org>; Thu, 30 Jun 2016 16:36:43 +0000 (UTC)
In-Reply-To: <1467304594-30100-1-git-send-email-jdesfossez@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: jgalar@efficios.com, mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

RnJvbTogTWF0aGlldSBEZXNub3llcnMgPG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbT4K
Ci0tLQogc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9sdHRuZy11c3QtYWJpLmggfCAxICsKIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL3NyYy9iaW4vbHR0bmctc2Vz
c2lvbmQvbHR0bmctdXN0LWFiaS5oIGIvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9sdHRuZy11c3Qt
YWJpLmgKaW5kZXggN2JlYzBjOS4uOWVmN2I5YSAxMDA2NDQKLS0tIGEvc3JjL2Jpbi9sdHRuZy1z
ZXNzaW9uZC9sdHRuZy11c3QtYWJpLmgKKysrIGIvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9sdHRu
Zy11c3QtYWJpLmgKQEAgLTI3NSw2ICsyNzUsNyBAQCBzdHJ1Y3QgbHR0bmdfdXN0X2V2ZW50X2V4
Y2x1c2lvbiB7CiAJX1VTVF9DTURXKDB4NTEsIHN0cnVjdCBsdHRuZ191c3RfY2hhbm5lbCkKICNk
ZWZpbmUgTFRUTkdfVVNUX1NFU1NJT05fU1RBUlQJCQlfVVNUX0NNRCgweDUyKQogI2RlZmluZSBM
VFROR19VU1RfU0VTU0lPTl9TVE9QCQkJX1VTVF9DTUQoMHg1MykKKyNkZWZpbmUgTFRUTkdfVVNU
X1NFU1NJT05fU1RBVEVEVU1QCQlfVVNUX0NNRCgweDU0KQogCiAvKiBDaGFubmVsIEZEIGNvbW1h
bmRzICovCiAjZGVmaW5lIExUVE5HX1VTVF9TVFJFQU0JCQlfVVNUX0NNRCgweDYwKQotLSAKMS45
LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5n
LWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3Rz
Lmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
