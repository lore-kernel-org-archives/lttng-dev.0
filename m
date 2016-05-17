From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: pointer dereference after NULL
	check in test_create_ust_event_exclusion
Date: Tue, 17 May 2016 10:48:39 -0400
Message-ID: <1463496519-29497-1-git-send-email-mathieu.desnoyers__22063.6931284846$1463496553$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 62B9CA352C
 for <lttng-dev@lists.lttng.org>; Tue, 17 May 2016 14:48:47 +0000 (UTC)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Q0lEIDEyNTYxODIgKCMyIG9mIDIpOiBEZXJlZmVyZW5jZSBhZnRlciBudWxsIGNoZWNrIChGT1JX
QVJEX05VTEwpMTYuCnZhcl9kZXJlZl9vcDogRGVyZWZlcmVuY2luZyBudWxsIHBvaW50ZXIgZXhj
bHVzaW9uLgoKU2lnbmVkLW9mZi1ieTogTWF0aGlldSBEZXNub3llcnMgPG1hdGhpZXUuZGVzbm95
ZXJzQGVmZmljaW9zLmNvbT4KLS0tCiB0ZXN0cy91bml0L3Rlc3RfdXN0X2RhdGEuYyB8IDQgKysr
LQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAt
LWdpdCBhL3Rlc3RzL3VuaXQvdGVzdF91c3RfZGF0YS5jIGIvdGVzdHMvdW5pdC90ZXN0X3VzdF9k
YXRhLmMKaW5kZXggZDgxMTY5NS4uMjM2ZjUwNyAxMDA2NDQKLS0tIGEvdGVzdHMvdW5pdC90ZXN0
X3VzdF9kYXRhLmMKKysrIGIvdGVzdHMvdW5pdC90ZXN0X3VzdF9kYXRhLmMKQEAgLTM4LDcgKzM4
LDcgQEAKICNkZWZpbmUgUkFORE9NX1NUUklOR19MRU4JMTEKIAogLyogTnVtYmVyIG9mIFRBUCB0
ZXN0cyBpbiB0aGlzIGZpbGUgKi8KLSNkZWZpbmUgTlVNX1RFU1RTIDE1CisjZGVmaW5lIE5VTV9U
RVNUUyAxNgogCiAvKiBGb3IgZXJyb3IuaCAqLwogaW50IGx0dG5nX29wdF9xdWlldCA9IDE7CkBA
IC0xODgsNiArMTg4LDggQEAgc3RhdGljIHZvaWQgdGVzdF9jcmVhdGVfdXN0X2V2ZW50X2V4Y2x1
c2lvbih2b2lkKQogCQlQRVJST1IoInptYWxsb2MiKTsKIAl9CiAKKwlvayhleGNsdXNpb24gIT0g
TlVMTCwgIkNyZWF0ZSBVU1QgZXhjbHVzaW9uIik7CisKIAlleGNsdXNpb24tPmNvdW50ID0gZXhj
bHVzaW9uX2NvdW50OwogCXN0cm5jcHkoTFRUTkdfRVZFTlRfRVhDTFVTSU9OX05BTUVfQVQoZXhj
bHVzaW9uLCAwKSwKIAkJZ2V0X3JhbmRvbV9zdHJpbmcoKSwgTFRUTkdfU1lNQk9MX05BTUVfTEVO
KTsKLS0gCjIuMS40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0
cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
