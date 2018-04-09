From: Stanislav Vovk <stanislav.vovk@ericsson.com>
Subject: [PATCH lttng-tools] Fix: sessiond '--quiet' option is
	no longer broken
Date: Mon, 9 Apr 2018 16:27:44 +0200
Message-ID: <1523284064-22313-1-git-send-email-stanislav.vovk__3170.26427151195$1523283951$gmane$org@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from sesbmg22.ericsson.net (sesbmg22.ericsson.net [193.180.251.48])
 by lists.lttng.org (Postfix) with ESMTPS id 40KXhM1VSQz14xm
 for <lttng-dev@lists.lttng.org>; Mon,  9 Apr 2018 10:27:46 -0400 (EDT)
Received: from esekilxv8651.rnd.ki.sw.ericsson.se
 (esekilxv8651.rnd.ki.sw.ericsson.se [147.214.15.224])	by
 esekilx6040.rnd.ericsson.se (Postfix) with ESMTP id A8990803E998	for
 <lttng-dev@lists.lttng.org>; Mon,  9 Apr 2018 16:27:44 +0200 (CEST)
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

U2lnbmVkLW9mZi1ieTogU3RhbmlzbGF2IFZvdmsgPHN0YW5pc2xhdi52b3ZrQGVyaWNzc29uLmNv
bT4KLS0tCiBzcmMvYmluL2x0dG5nLXNlc3Npb25kL21haW4uYyB8IDIgKy0KIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3NyYy9iaW4v
bHR0bmctc2Vzc2lvbmQvbWFpbi5jIGIvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9tYWluLmMKaW5k
ZXggZGI5MjE5MS4uNDk2OGVlMiAxMDA2NDQKLS0tIGEvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9t
YWluLmMKKysrIGIvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9tYWluLmMKQEAgLTQ5MjksNyArNDky
OSw3IEBAIHN0YXRpYyBpbnQgc2V0X29wdGlvbihpbnQgb3B0LCBjb25zdCBjaGFyICphcmcsIGNv
bnN0IGNoYXIgKm9wdG5hbWUpCiAJfSBlbHNlIGlmIChzdHJpbmdfbWF0Y2gob3B0bmFtZSwgIm5v
LWtlcm5lbCIpKSB7CiAJCWNvbmZpZy5ub19rZXJuZWwgPSB0cnVlOwogCX0gZWxzZSBpZiAoc3Ry
aW5nX21hdGNoKG9wdG5hbWUsICJxdWlldCIpIHx8IG9wdCA9PSAncScpIHsKLQkJbHR0bmdfb3B0
X3F1aWV0ID0gdHJ1ZTsKKwkJY29uZmlnLnF1aWV0ID0gdHJ1ZTsKIAl9IGVsc2UgaWYgKHN0cmlu
Z19tYXRjaChvcHRuYW1lLCAidmVyYm9zZSIpIHx8IG9wdCA9PSAndicpIHsKIAkJLyogVmVyYm9z
ZSBsZXZlbCBjYW4gaW5jcmVhc2UgdXNpbmcgbXVsdGlwbGUgLXYgKi8KIAkJaWYgKGFyZykgewot
LSAKMS43LjEyLjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRw
czovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
