From: Lars Persson <lars.persson@axis.com>
Subject: [PATCH] Fix: do not use CONFIG_HOTPLUG_CPU for the new
	hotplug API
Date: Sun, 11 Mar 2018 15:02:43 +0100
Message-ID: <20180311140243.4539-1-larper__23391.0835501321$1520776862$gmane$org@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by lists.lttng.org (Postfix) with ESMTPS id 3zzjW31VybzWc
 for <lttng-dev@lists.lttng.org>; Sun, 11 Mar 2018 10:02:54 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by bastet.se.axis.com (Postfix) with ESMTP id B399C182E7
 for <lttng-dev@lists.lttng.org>; Sun, 11 Mar 2018 15:02:52 +0100 (CET)
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
 by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id USLX5CnLqtTo for <lttng-dev@lists.lttng.org>;
 Sun, 11 Mar 2018 15:02:52 +0100 (CET)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
 by bastet.se.axis.com (Postfix) with ESMTPS id 421F0182D8
 for <lttng-dev@lists.lttng.org>; Sun, 11 Mar 2018 15:02:51 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C222D1E056
 for <lttng-dev@lists.lttng.org>; Sun, 11 Mar 2018 15:02:51 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B6C9D1E054
 for <lttng-dev@lists.lttng.org>; Sun, 11 Mar 2018 15:02:51 +0100 (CET)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
 by boulder03.se.axis.com (Postfix) with ESMTP
 for <lttng-dev@lists.lttng.org>; Sun, 11 Mar 2018 15:02:51 +0100 (CET)
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
Cc: Lars Persson <larper@axis.com>
List-Id: lttng-dev@lists.lttng.org

S2VybmVsIGNvbmZpZ3VyYXRpb25zIHdpdGhvdXQgQ09ORklHX0hPVFBMVUdfQ1BVIHRocm93IGFu
IHVua25vd24Kc3ltYm9sIGVycm9yIHdoZW4gYXR0ZW1wdGluZyB0byBpbnNlcnQgdGhlIGx0dG5n
LXRyYWNlIG1vZHVsZToKIGx0dG5nX3RyYWNlcjogVW5rbm93biBzeW1ib2wgbHR0bmdfaHBfcHJl
cGFyZSAoZXJyIDApCiBsdHRuZ190cmFjZXI6IFVua25vd24gc3ltYm9sIGx0dG5nX2hwX29ubGlu
ZSAoZXJyIDApCgpUaGlzIHdhcyBjYXVzZWQgYnkgbHR0bmctZXZlbnRzIGFuZCBsdHRuZy1jb250
ZXh0LXBlcmYtY291bnRlciBub3QKYWdyZWVpbmcgb24gd2hpY2ggcHJlcHJvY2Vzc29yIGNvbmRp
dGlvbiB0aGF0IHNob3VsZCBndWFyZCB0aGUgdXNlIG9mCnRoZSBob3RwbHVnIEFQSS4gSW4gZmFj
dCB0aGUgQVBJIGlzIGF2YWlsYWJsZSBhbHNvIG9uIGtlcm5lbHMgYnVpbHQKd2l0aG91dCBDT05G
SUdfSE9UUExVR19BUEkuCgpTaWduZWQtb2ZmLWJ5OiBMYXJzIFBlcnNzb24gPGxhcnBlckBheGlz
LmNvbT4KLS0tCiBsdHRuZy1ldmVudHMuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2x0dG5nLWV2ZW50cy5jIGIvbHR0
bmctZXZlbnRzLmMKaW5kZXggNmYxMjJkZC4uMmNkNjUwZiAxMDA2NDQKLS0tIGEvbHR0bmctZXZl
bnRzLmMKKysrIGIvbHR0bmctZXZlbnRzLmMKQEAgLTI2NDQsNyArMjY0NCw3IEBAIHZvaWQgbHR0
bmdfdHJhbnNwb3J0X3VucmVnaXN0ZXIoc3RydWN0IGx0dG5nX3RyYW5zcG9ydCAqdHJhbnNwb3J0
KQogfQogRVhQT1JUX1NZTUJPTF9HUEwobHR0bmdfdHJhbnNwb3J0X3VucmVnaXN0ZXIpOwogCi0j
aWYgKGRlZmluZWQoQ09ORklHX0hPVFBMVUdfQ1BVKSAmJiAoTElOVVhfVkVSU0lPTl9DT0RFID49
IEtFUk5FTF9WRVJTSU9OKDQsMTAsMCkpKQorI2lmIChMSU5VWF9WRVJTSU9OX0NPREUgPj0gS0VS
TkVMX1ZFUlNJT04oNCwxMCwwKSkKIAogZW51bSBjcHVocF9zdGF0ZSBsdHRuZ19ocF9wcmVwYXJl
OwogZW51bSBjcHVocF9zdGF0ZSBsdHRuZ19ocF9vbmxpbmU7Ci0tIAoyLjExLjAKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5n
IGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9j
Z2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
