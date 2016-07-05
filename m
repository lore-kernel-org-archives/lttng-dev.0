From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [PATCH lttng-tools v3 2/6] UST command to regenerate
	the statedump
Date: Tue,  5 Jul 2016 10:54:34 -0400
Message-ID: <1467730478-9524-2-git-send-email-jdesfossez__167.504759929393$1467730518$gmane$org@efficios.com>
References: <1467730478-9524-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com (unknown [192.99.35.19])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 88CE1A2C52
 for <lttng-dev@lists.lttng.org>; Tue,  5 Jul 2016 14:54:48 +0000 (UTC)
In-Reply-To: <1467730478-9524-1-git-send-email-jdesfossez@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: jgalar@efficios.com, mathieu.desnoyers@efficios.com, philippe.proulx@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

RnJvbTogTWF0aGlldSBEZXNub3llcnMgPG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbT4K
ClNpZ25lZC1vZmYtYnk6IE1hdGhpZXUgRGVzbm95ZXJzIDxtYXRoaWV1LmRlc25veWVyc0BlZmZp
Y2lvcy5jb20+Ci0tLQogc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9sdHRuZy11c3QtYWJpLmggfCAx
ICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL3NyYy9iaW4v
bHR0bmctc2Vzc2lvbmQvbHR0bmctdXN0LWFiaS5oIGIvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9s
dHRuZy11c3QtYWJpLmgKaW5kZXggN2JlYzBjOS4uOWVmN2I5YSAxMDA2NDQKLS0tIGEvc3JjL2Jp
bi9sdHRuZy1zZXNzaW9uZC9sdHRuZy11c3QtYWJpLmgKKysrIGIvc3JjL2Jpbi9sdHRuZy1zZXNz
aW9uZC9sdHRuZy11c3QtYWJpLmgKQEAgLTI3NSw2ICsyNzUsNyBAQCBzdHJ1Y3QgbHR0bmdfdXN0
X2V2ZW50X2V4Y2x1c2lvbiB7CiAJX1VTVF9DTURXKDB4NTEsIHN0cnVjdCBsdHRuZ191c3RfY2hh
bm5lbCkKICNkZWZpbmUgTFRUTkdfVVNUX1NFU1NJT05fU1RBUlQJCQlfVVNUX0NNRCgweDUyKQog
I2RlZmluZSBMVFROR19VU1RfU0VTU0lPTl9TVE9QCQkJX1VTVF9DTUQoMHg1MykKKyNkZWZpbmUg
TFRUTkdfVVNUX1NFU1NJT05fU1RBVEVEVU1QCQlfVVNUX0NNRCgweDU0KQogCiAvKiBDaGFubmVs
IEZEIGNvbW1hbmRzICovCiAjZGVmaW5lIExUVE5HX1VTVF9TVFJFQU0JCQlfVVNUX0NNRCgweDYw
KQotLSAKMS45LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRw
czovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
