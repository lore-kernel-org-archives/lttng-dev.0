From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 03/24] Fix: illegal memory access in
	init_ust_event_from_agent_event
Date: Mon, 16 May 2016 21:42:42 -0400
Message-ID: <1463449383-6553-4-git-send-email-mathieu.desnoyers__17750.22670995$1463449420$gmane$org@efficios.com>
References: <1463449383-6553-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 6FC88A3514
 for <lttng-dev@lists.lttng.org>; Tue, 17 May 2016 01:43:11 +0000 (UTC)
In-Reply-To: <1463449383-6553-1-git-send-email-mathieu.desnoyers@efficios.com>
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

Rm91bmQgYnkgQ292ZXJpdHk6CkNJRCAxMzIxNzQxICgjMSBvZiAxKTogQnVmZmVyIG5vdCBudWxs
IHRlcm1pbmF0ZWQKKEJVRkZFUl9TSVpFX1dBUk5JTkcpMS4gYnVmZmVyX3NpemVfd2FybmluZzog
Q2FsbGluZyBzdHJuY3B5IHdpdGggYQptYXhpbXVtIHNpemUgYXJndW1lbnQgb2YgMjU2IGJ5dGVz
IG9uIGRlc3RpbmF0aW9uIGFycmF5CnVzdF9ldmVudC0+YXR0ci5uYW1lIG9mIHNpemUgMjU2IGJ5
dGVzIG1pZ2h0IGxlYXZlIHRoZSBkZXN0aW5hdGlvbgpzdHJpbmcgdW50ZXJtaW5hdGVkLgoKU2ln
bmVkLW9mZi1ieTogTWF0aGlldSBEZXNub3llcnMgPG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9z
LmNvbT4KLS0tCiBzcmMvYmluL2x0dG5nLXNlc3Npb25kL3NhdmUuYyB8IDYgKysrKystCiAxIGZp
bGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEv
c3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9zYXZlLmMgYi9zcmMvYmluL2x0dG5nLXNlc3Npb25kL3Nh
dmUuYwppbmRleCA0ODk0NDZkLi45YWM3NzEyIDEwMDY0NAotLS0gYS9zcmMvYmluL2x0dG5nLXNl
c3Npb25kL3NhdmUuYworKysgYi9zcmMvYmluL2x0dG5nLXNlc3Npb25kL3NhdmUuYwpAQCAtNzA4
LDcgKzcwOCwxMSBAQCBpbnQgaW5pdF91c3RfZXZlbnRfZnJvbV9hZ2VudF9ldmVudChzdHJ1Y3Qg
bHR0X3VzdF9ldmVudCAqdXN0X2V2ZW50LAogCiAJdXN0X2V2ZW50LT5lbmFibGVkID0gYWdlbnRf
ZXZlbnQtPmVuYWJsZWQ7CiAJdXN0X2V2ZW50LT5hdHRyLmluc3RydW1lbnRhdGlvbiA9IExUVE5H
X1VTVF9UUkFDRVBPSU5UOwotCXN0cm5jcHkodXN0X2V2ZW50LT5hdHRyLm5hbWUsIGFnZW50X2V2
ZW50LT5uYW1lLCBMVFROR19TWU1CT0xfTkFNRV9MRU4pOworCWlmIChsdHRuZ19zdHJuY3B5KHVz
dF9ldmVudC0+YXR0ci5uYW1lLCBhZ2VudF9ldmVudC0+bmFtZSwKKwkJCUxUVE5HX1NZTUJPTF9O
QU1FX0xFTikpIHsKKwkJcmV0ID0gLTE7CisJCWdvdG8gZW5kOworCX0KIAlzd2l0Y2ggKGFnZW50
X2V2ZW50LT5sb2dsZXZlbF90eXBlKSB7CiAJY2FzZSBMVFROR19FVkVOVF9MT0dMRVZFTF9BTEw6
CiAJCXVzdF9sb2dsZXZlbF90eXBlID0gTFRUTkdfVVNUX0xPR0xFVkVMX0FMTDsKLS0gCjIuMS40
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1k
ZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5s
dHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
