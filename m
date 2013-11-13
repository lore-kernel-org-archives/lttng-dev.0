From: =?UTF-8?q?Rapha=C3=ABl=20Beamonte?= <raphael.beamonte@gmail.com>
Subject: [PATCH] checkpatch: change status of warning from
	"BRACES" to "BRACES_SINGLE_STMT"
Date: Wed, 13 Nov 2013 00:44:28 -0500
Message-ID: <1384321468-29220-1-git-send-email-raphael.beamonte__25080.2735369236$1384321529$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <raphael.beamonte@gmail.com>) id 1VgTG2-0007AW-5B
	for lttng-dev@lists.lttng.org; Wed, 13 Nov 2013 00:44:55 -0500
Received: by mail-ie0-f181.google.com with SMTP id tp5so4742196ieb.26
	for <lttng-dev@lists.lttng.org>; Tue, 12 Nov 2013 21:44:48 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: =?UTF-8?q?Rapha=C3=ABl=20Beamonte?= <raphael.beamonte@gmail.com>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

VGhlIHdhcm5pbmcgYWJvdXQgYnJhY2VzIHRoYXQgYXJlIG5vdCBuZWNlc3NhcnkgZm9yIGFueSBh
cm0gb2YgYSBzdGF0ZW1lbnQKc2hvdWxkIGJlIGludGVycHJldGVkIGFzIGEgd2FybmluZyBhYm91
dCBicmFjZXMgYXJvdW5kIHNpbmdsZSBzdGF0ZW1lbnRzLgoKU2lnbmVkLW9mZi1ieTogUmFwaGHD
q2wgQmVhbW9udGUgPHJhcGhhZWwuYmVhbW9udGVAZ21haWwuY29tPgotLS0KIGV4dHJhcy9jaGVj
a3BhdGNoLnBsIHwgICAgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZXh0cmFzL2NoZWNrcGF0Y2gucGwgYi9leHRyYXMvY2hl
Y2twYXRjaC5wbAppbmRleCBmZGQ4NDg0Li41YTY3NzA0IDEwMDc1NQotLS0gYS9leHRyYXMvY2hl
Y2twYXRjaC5wbAorKysgYi9leHRyYXMvY2hlY2twYXRjaC5wbApAQCAtMzEzOCw3ICszMTM4LDcg
QEAgc3ViIHByb2Nlc3MgewogCQkJCQkJJHN1bV9hbGxvd2VkICs9ICRfOwogCQkJCQl9CiAJCQkJ
CWlmICgkc3VtX2FsbG93ZWQgPT0gMCkgewotCQkJCQkJV0FSTigiQlJBQ0VTIiwKKwkJCQkJCVdB
Uk4oIkJSQUNFU19TSU5HTEVfU1RNVCIsCiAJCQkJCQkgICAgICJicmFjZXMge30gYXJlIG5vdCBu
ZWNlc3NhcnkgZm9yIGFueSBhcm0gb2YgdGhpcyBzdGF0ZW1lbnRcbiIgLiAkaGVyZWN0eCk7CiAJ
CQkJCX0gZWxzaWYgKCRzdW1fYWxsb3dlZCAhPSAkYWxsb3cgJiYKIAkJCQkJCSAkc2VlbiAhPSAk
YWxsb3cpIHsKLS0gCjEuNy4xMC40CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0
bmcub3JnCmh0dHA6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0
dG5nLWRldgo=
