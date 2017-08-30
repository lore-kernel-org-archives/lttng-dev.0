From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH babeltrace] Port: don't quote wc output in test
	scripts
Date: Wed, 30 Aug 2017 14:29:26 -0400
Message-ID: <1504117766-13198-1-git-send-email-mjeanson__38931.5913235352$1504117799$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3xjDYz6048zD67
 for <lttng-dev@lists.lttng.org>; Wed, 30 Aug 2017 18:29:43 +0000 (UTC)
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

VGhlICd3YycgY29tbWFuZCBvbiBtYWNPUyBwcmVmaXhlcyB0aGUgY291bnQgaXQgcmV0dXJucyB3
aXRoIHNwYWNlcywgaWYKd2UgcXVvdGUgdGhlIG91dHB1dCBpdCB3b24ndCBiZSBwcm9wZXJseSBj
b252ZXJ0ZWQgdG8gaW50ZWdlciBmb3IgdGhlCmNvbXBhcmlzb24uCgpTaWduZWQtb2ZmLWJ5OiBN
aWNoYWVsIEplYW5zb24gPG1qZWFuc29uQGVmZmljaW9zLmNvbT4KLS0tCiB0ZXN0cy9jbGkvaW50
ZXJzZWN0aW9uL3Rlc3RfaW50ZXJzZWN0aW9uLmluIHwgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rlc3RzL2NsaS9p
bnRlcnNlY3Rpb24vdGVzdF9pbnRlcnNlY3Rpb24uaW4gYi90ZXN0cy9jbGkvaW50ZXJzZWN0aW9u
L3Rlc3RfaW50ZXJzZWN0aW9uLmluCmluZGV4IDA3YTI2N2YuLjdjZWE5YmUgMTAwNjQ0Ci0tLSBh
L3Rlc3RzL2NsaS9pbnRlcnNlY3Rpb24vdGVzdF9pbnRlcnNlY3Rpb24uaW4KKysrIGIvdGVzdHMv
Y2xpL2ludGVyc2VjdGlvbi90ZXN0X2ludGVyc2VjdGlvbi5pbgpAQCAtMjYsOSArMjYsOSBAQCB0
ZXN0X2ludGVyc2VjdCgpIHsKIAl0b3RhbGV2ZW50cz0iJDIiCiAJaW50ZXJzZWN0PSIkMyIKIAot
CXRlc3QgIiQoIiR7QlRfQklOfSIgIiR0cmFjZSIgfCB3YyAtbCkiID0gIiR0b3RhbGV2ZW50cyIK
Kwl0ZXN0ICQoIiR7QlRfQklOfSIgIiR0cmFjZSIgfCB3YyAtbCkgPSAiJHRvdGFsZXZlbnRzIgog
CW9rICQ/ICIkdG90YWxldmVudHMgZXZlbnRzIGluIHRoZSB3aG9sZSB0cmFjZSIKLQl0ZXN0ICIk
KCIke0JUX0JJTn0iIC0tc3RyZWFtLWludGVyc2VjdGlvbiAiJHRyYWNlIiAyPi9kZXYvbnVsbHwg
d2MgLWwpIiA9ICIkaW50ZXJzZWN0IgorCXRlc3QgJCgiJHtCVF9CSU59IiAtLXN0cmVhbS1pbnRl
cnNlY3Rpb24gIiR0cmFjZSIgMj4vZGV2L251bGx8IHdjIC1sKSA9ICIkaW50ZXJzZWN0IgogCW9r
ICQ/ICIkaW50ZXJzZWN0IGV2ZW50cyBpbiBwYWNrZXRzIGludGVyc2VjdGluZyIKIH0KIAotLSAK
Mi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0
dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xp
c3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
