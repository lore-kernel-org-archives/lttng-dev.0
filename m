From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH babeltrace stable-1.5] Fix: ctf writer test on
	Cygwin
Date: Thu,  6 Apr 2017 15:00:44 -0400
Message-ID: <1491505244-340-1-git-send-email-mjeanson__18126.5592728325$1491505268$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3vzX9s3Y4mzlGy
 for <lttng-dev@lists.lttng.org>; Thu,  6 Apr 2017 19:01:21 +0000 (UTC)
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

SW4gdGhlIGN0ZiB3cml0ZXIgdGVzdCB3ZSBleGVjbCgpIHNvbWUgbGlidG9vbCB3cmFwcGVycyB0
aGF0IGdldCBjb25mdXNlZAp3aGVuIGFyZ1swXSBpcyBub3QgdGhlIGZ1bGwgcGF0aCB0byB0aGUg
YmluYXJ5LgoKU2lnbmVkLW9mZi1ieTogTWljaGFlbCBKZWFuc29uIDxtamVhbnNvbkBlZmZpY2lv
cy5jb20+Ci0tLQogdGVzdHMvbGliL3Rlc3RfY3RmX3dyaXRlci5jIHwgNCArKy0tCiAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rl
c3RzL2xpYi90ZXN0X2N0Zl93cml0ZXIuYyBiL3Rlc3RzL2xpYi90ZXN0X2N0Zl93cml0ZXIuYwpp
bmRleCA5NjFkZjc5Li41MzYxM2M5IDEwMDY0NAotLS0gYS90ZXN0cy9saWIvdGVzdF9jdGZfd3Jp
dGVyLmMKKysrIGIvdGVzdHMvbGliL3Rlc3RfY3RmX3dyaXRlci5jCkBAIC05NCw3ICs5NCw3IEBA
IHZvaWQgdmFsaWRhdGVfbWV0YWRhdGEoY2hhciAqcGFyc2VyX3BhdGgsIGNoYXIgKm1ldGFkYXRh
X3BhdGgpCiAJCQlnb3RvIHJlc3VsdDsKIAkJfQogCi0JCWV4ZWNsKHBhcnNlcl9wYXRoLCAiY3Rm
LXBhcnNlci10ZXN0IiwgKGNoYXIgKikgTlVMTCk7CisJCWV4ZWNsKHBhcnNlcl9wYXRoLCBwYXJz
ZXJfcGF0aCwgKGNoYXIgKikgTlVMTCk7CiAJCXBlcnJvcigiIyBDb3VsZCBub3QgbGF1bmNoIHRo
ZSBjdGYgbWV0YWRhdGEgcGFyc2VyIHByb2Nlc3MiKTsKIAkJZXhpdCgtMSk7CiAJfQpAQCAtMjAx
LDcgKzIwMSw3IEBAIHZvaWQgdmFsaWRhdGVfdHJhY2UoY2hhciAqcGFyc2VyX3BhdGgsIGNoYXIg
KnRyYWNlX3BhdGgpCiAJCQlnb3RvIHJlc3VsdDsKIAkJfQogCi0JCWV4ZWNsKHBhcnNlcl9wYXRo
LCAiYmFiZWx0cmFjZSIsIHRyYWNlX3BhdGgsIChjaGFyICopIE5VTEwpOworCQlleGVjbChwYXJz
ZXJfcGF0aCwgcGFyc2VyX3BhdGgsIHRyYWNlX3BhdGgsIChjaGFyICopIE5VTEwpOwogCQlwZXJy
b3IoIiMgQ291bGQgbm90IGxhdW5jaCB0aGUgYmFiZWx0cmFjZSBwcm9jZXNzIik7CiAJCWV4aXQo
LTEpOwogCX0KLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5v
cmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5n
LWRldgo=
