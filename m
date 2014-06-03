From: =?UTF-8?q?Rapha=C3=ABl=20Beamonte?= <raphael.beamonte@gmail.com>
Subject: [PATCH] Add bzr revno to the version if in a bzr
	repository
Date: Tue,  3 Jun 2014 13:40:27 -0400
Message-ID: <edd264d153b5ab8dbb2cad9bbc63d05d1ae0cc09.1401817136.git.raphael.beamonte__32604.1386150338$1401817317$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <raphael.beamonte@gmail.com>) id 1WrshW-0000sN-8V
 for lttng-dev@lists.lttng.org; Tue, 03 Jun 2014 13:40:47 -0400
Received: by mail-ig0-f182.google.com with SMTP id a13so631872igq.9
 for <lttng-dev@lists.lttng.org>; Tue, 03 Jun 2014 10:40:36 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: =?UTF-8?q?Rapha=C3=ABl=20Beamonte?= <raphael.beamonte@gmail.com>
List-Id: lttng-dev@lists.lttng.org

U2lnbmVkLW9mZi1ieTogUmFwaGHDq2wgQmVhbW9udGUgPHJhcGhhZWwuYmVhbW9udGVAZ21haWwu
Y29tPgotLS0KIGluY2x1ZGUvTWFrZWZpbGUuYW0gfCA4ICsrKysrKystCiAxIGZpbGUgY2hhbmdl
ZCwgNyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9N
YWtlZmlsZS5hbSBiL2luY2x1ZGUvTWFrZWZpbGUuYW0KaW5kZXggMzg2YzViYS4uYTY3NzMzMSAx
MDA2NDQKLS0tIGEvaW5jbHVkZS9NYWtlZmlsZS5hbQorKysgYi9pbmNsdWRlL01ha2VmaWxlLmFt
CkBAIC0xOCw3ICsxOCwxMyBAQCB2ZXJzaW9uLmg6CiAJCSMjCiAJCWdpdF9icmFuY2g9IiQkKGdp
dCBkZXNjcmliZSAtLWFsbCAyPi9kZXYvbnVsbCkiOyBcCiAJCWlmIFsgLXogIiQke2dpdF9icmFu
Y2h9IiBdOyB0aGVuIFwKLQkJCWdpdF92ZXJzaW9uPSIiOyBcCisJCQkjIyBJZiB3ZSBhcmUgbm90
IGluIGEgZ2l0IHJlcG9zaXRvcnksIHdlIGNhbiB0cnkgYnpyCisJCQlienJfdmVyc2lvbj0iJCQo
YnpyIGxvZyAtUyAtbDEgMj4vZGV2L251bGwgfCBoZWFkIC1uMSB8IGN1dCAtZCcgJyAtZjIpIjsg
XAorCQkJaWYgWyAtbiAiJCR7YnpyX3ZlcnNpb259IiBdOyB0aGVuIFwKKwkJCQlnaXRfdmVyc2lv
bj0iXCIgVkVSU0lPTiBcIi1ienIkJHtienJfdmVyc2lvbn0iOyBcCisJCQllbHNlIFwKKwkJCQln
aXRfdmVyc2lvbj0iIjsgXAorCQkJZmk7IFwKIAkJZWxzZSBcCiAJCQlnaXRfZGVzY3JpYmU9IiQk
KGdpdCBkZXNjcmliZSkiOyBcCiAJCQlpZiBbICIkJHtnaXRfYnJhbmNofSIgPT0gIiQke2dpdF9k
ZXNjcmliZX0iIF0gfHwgXAotLSAKMi4wLjAucmMyCgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZA
bGlzdHMubHR0bmcub3JnCmh0dHA6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xp
c3RpbmZvL2x0dG5nLWRldgo=
