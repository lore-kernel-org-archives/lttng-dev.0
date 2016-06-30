From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [PATCH lttng-tools 3/6] Kernel ioctl to regenerate the
	statedump
Date: Thu, 30 Jun 2016 12:36:31 -0400
Message-ID: <1467304594-30100-3-git-send-email-jdesfossez__301.624058238481$1467304634$gmane$org@efficios.com>
References: <1467304594-30100-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com (unknown [192.99.35.19])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 12FF9A2B77
 for <lttng-dev@lists.lttng.org>; Thu, 30 Jun 2016 16:36:44 +0000 (UTC)
In-Reply-To: <1467304594-30100-1-git-send-email-jdesfossez@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: jgalar@efficios.com, mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

RnJvbTogTWF0aGlldSBEZXNub3llcnMgPG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbT4K
Ci0tLQogc3JjL2NvbW1vbi9rZXJuZWwtY3RsL2tlcm5lbC1pb2N0bC5oIHwgMiArKwogMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3NyYy9jb21tb24va2VybmVs
LWN0bC9rZXJuZWwtaW9jdGwuaCBiL3NyYy9jb21tb24va2VybmVsLWN0bC9rZXJuZWwtaW9jdGwu
aAppbmRleCA2ODA1NmRjLi44MDVkZTAyIDEwMDY0NAotLS0gYS9zcmMvY29tbW9uL2tlcm5lbC1j
dGwva2VybmVsLWlvY3RsLmgKKysrIGIvc3JjL2NvbW1vbi9rZXJuZWwtY3RsL2tlcm5lbC1pb2N0
bC5oCkBAIC0xMzQsNiArMTM0LDggQEAKICAqLwogI2RlZmluZSBMVFROR19LRVJORUxfU0VTU0lP
Tl9MSVNUX1RSQUNLRVJfUElEUwlfSU8oMHhGNiwgMHg1OCkKICNkZWZpbmUgTFRUTkdfS0VSTkVM
X1NFU1NJT05fTUVUQURBVEFfUkVHRU4JX0lPKDB4RjYsIDB4NTkpCisvKiAweDVBIGFuZCAweDVC
IGFyZSByZXNlcnZlZCBmb3IgYSBmdXR1cmUgQUJJLWJyZWFraW5nIGNsZWFudXAuICovCisjZGVm
aW5lIExUVE5HX0tFUk5FTF9TRVNTSU9OX1NUQVRFRFVNUAkJX0lPKDB4RjYsIDB4NUMpCiAKIC8q
IENoYW5uZWwgRkQgaW9jdGwgKi8KICNkZWZpbmUgTFRUTkdfS0VSTkVMX1NUUkVBTQkJCV9JTygw
eEY2LCAweDYyKQotLSAKMS45LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5n
Lm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0
bmctZGV2Cg==
