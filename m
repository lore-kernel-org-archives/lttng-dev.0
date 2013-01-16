From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?=
	<jeremie.galarneau@efficios.com>
Subject: [PATCH babeltrace] Fix: Python bindings build fix.
	Reflects SEEK_END API change.
Date: Wed, 16 Jan 2013 17:53:01 +0000
Message-ID: <1358358781-26056-1-git-send-email-jeremie.galarneau__26579.6455824331$1358376871$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f52.google.com ([209.85.216.52])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1Tvbri-0000fd-EB
	for lttng-dev@lists.lttng.org; Wed, 16 Jan 2013 17:53:50 -0500
Received: by mail-qa0-f52.google.com with SMTP id d13so1626077qak.4
	for <lttng-dev@lists.lttng.org>; Wed, 16 Jan 2013 14:53:45 -0800 (PST)
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

ClNpZ25lZC1vZmYtYnk6IErDqXLDqW1pZSBHYWxhcm5lYXUgPGplcmVtaWUuZ2FsYXJuZWF1QGVm
ZmljaW9zLmNvbT4KLS0tCiBiaW5kaW5ncy9weXRob24vYmFiZWx0cmFjZS5pLmluIHwgNSArKy0t
LQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9iaW5kaW5ncy9weXRob24vYmFiZWx0cmFjZS5pLmluIGIvYmluZGluZ3MvcHl0aG9u
L2JhYmVsdHJhY2UuaS5pbgppbmRleCBjOGU0OTIzLi5iNjkzZjAyIDEwMDY0NAotLS0gYS9iaW5k
aW5ncy9weXRob24vYmFiZWx0cmFjZS5pLmluCisrKyBiL2JpbmRpbmdzL3B5dGhvbi9iYWJlbHRy
YWNlLmkuaW4KQEAgLTI0NSw4ICsyNDUsNyBAQCBzdHJ1Y3QgYnRfaXRlcl9wb3MgKmJ0X2l0ZXJf
Y3JlYXRlX3RpbWVfcG9zKHN0cnVjdCBidF9pdGVyICppdGVyLCB1aW50NjRfdCB0aW1lcwogJXJl
bmFtZSgiU0VFS19SRVNUT1JFIikgQlRfU0VFS19SRVNUT1JFOwogJXJlbmFtZSgiU0VFS19DVVIi
KSBCVF9TRUVLX0NVUjsKICVyZW5hbWUoIlNFRUtfQkVHSU4iKSBCVF9TRUVLX0JFR0lOOwotJXJl
bmFtZSgiU0VFS19FTkQiKSBCVF9TRUVLX0VORDsKLQorJXJlbmFtZSgiU0VFS19MQVNUIikgQlRf
U0VFS19MQVNUOwogCiAvLyBUaGlzIHN0cnVjdCBpcyB0YWtlbiBmcm9tIGl0ZXJhdG9yLmgKIC8v
IEFsbCBjaGFuZ2VzIHRvIHRoZSBzdHJ1Y3QgbXVzdCBhbHNvIGJlIG1hZGUgaGVyZQpAQCAtMjU2
LDcgKzI1NSw3IEBAIHN0cnVjdCBidF9pdGVyX3BvcyB7CiAJCUJUX1NFRUtfUkVTVE9SRSwJLyog
dXNlcyB1LnJlc3RvcmUgKi8KIAkJQlRfU0VFS19DVVIsCiAJCUJUX1NFRUtfQkVHSU4sCi0JCUJU
X1NFRUtfRU5ELAorCQlCVF9TRUVLX0xBU1QKIAl9IHR5cGU7CiAJdW5pb24gewogCQl1aW50NjRf
dCBzZWVrX3RpbWU7Ci0tIAoxLjguMS4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMu
bHR0bmcub3JnCmh0dHA6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZv
L2x0dG5nLWRldgo=
