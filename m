From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools] Fix: initialize the cur_event
	variable before using it
Date: Tue, 17 May 2016 11:52:47 -0400
Message-ID: <1463500367-23547-1-git-send-email-jonathan.rajotte-julien__7433.18807003579$1463500407$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 63BC8A00AA
 for <lttng-dev@lists.lttng.org>; Tue, 17 May 2016 15:53:05 +0000 (UTC)
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

Q0lEIDEyNDMwNDEgKCMxIG9mIDEpOiBVbmluaXRpYWxpemVkIHNjYWxhciB2YXJpYWJsZSAoVU5J
TklUKQp1bmluaXRfdXNlX2luX2NhbGw6IFVzaW5nIHVuaW5pdGlhbGl6ZWQgZWxlbWVudCBvZiBh
cnJheSAqY3VyX2V2ZW50Lm5hbWUgd2hlbgpjYWxsaW5nIHN0cmNtcC4KClNpZ25lZC1vZmYtYnk6
IEpvbmF0aGFuIFJham90dGUgPGpvbmF0aGFuLnJham90dGUtanVsaWVuQGVmZmljaW9zLmNvbT4K
LS0tCiBzcmMvYmluL2x0dG5nL2NvbW1hbmRzL2xpc3QuYyB8IDIgKysKIDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9zcmMvYmluL2x0dG5nL2NvbW1hbmRzL2xp
c3QuYyBiL3NyYy9iaW4vbHR0bmcvY29tbWFuZHMvbGlzdC5jCmluZGV4IDBkZDc0ZTUuLjQxOGZj
Y2YgMTAwNjQ0Ci0tLSBhL3NyYy9iaW4vbHR0bmcvY29tbWFuZHMvbGlzdC5jCisrKyBiL3NyYy9i
aW4vbHR0bmcvY29tbWFuZHMvbGlzdC5jCkBAIC02MjEsNiArNjIxLDggQEAgc3RhdGljIGludCBt
aV9saXN0X3VzdF9ldmVudF9maWVsZHMoc3RydWN0IGx0dG5nX2V2ZW50X2ZpZWxkICpmaWVsZHMs
IGludCBjb3VudCwKIAlpbnQgZXZlbnRfZWxlbWVudF9vcGVuID0gMDsKIAlzdHJ1Y3QgbHR0bmdf
ZXZlbnQgY3VyX2V2ZW50OwogCisJbWVtc2V0KCZjdXJfZXZlbnQsIDAsIHNpemVvZihjdXJfZXZl
bnQpKTsKKwogCS8qIE9wZW4gZG9tYWlucyBlbGVtZW50ICovCiAJcmV0ID0gbWlfbHR0bmdfZG9t
YWluc19vcGVuKHdyaXRlcik7CiAJaWYgKHJldCkgewotLSAKMi43LjQKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QK
bHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmlu
L21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
