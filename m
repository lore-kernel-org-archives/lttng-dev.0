From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [PATCH lttng-tools v3 3/6] Kernel ioctl to regenerate
	the statedump
Date: Tue,  5 Jul 2016 10:54:35 -0400
Message-ID: <1467730478-9524-3-git-send-email-jdesfossez__10906.7876161591$1467730513$gmane$org@efficios.com>
References: <1467730478-9524-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com (unknown [192.99.35.19])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 74B28A2C26
 for <lttng-dev@lists.lttng.org>; Tue,  5 Jul 2016 14:54:48 +0000 (UTC)
In-Reply-To: <1467730478-9524-1-git-send-email-jdesfossez@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: jgalar@efficios.com, mathieu.desnoyers@efficios.com, philippe.proulx@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

RnJvbTogTWF0aGlldSBEZXNub3llcnMgPG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbT4K
ClNpZ25lZC1vZmYtYnk6IE1hdGhpZXUgRGVzbm95ZXJzIDxtYXRoaWV1LmRlc25veWVyc0BlZmZp
Y2lvcy5jb20+Ci0tLQogc3JjL2NvbW1vbi9rZXJuZWwtY3RsL2tlcm5lbC1pb2N0bC5oIHwgMiAr
KwogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3NyYy9jb21t
b24va2VybmVsLWN0bC9rZXJuZWwtaW9jdGwuaCBiL3NyYy9jb21tb24va2VybmVsLWN0bC9rZXJu
ZWwtaW9jdGwuaAppbmRleCA2ODA1NmRjLi44MDVkZTAyIDEwMDY0NAotLS0gYS9zcmMvY29tbW9u
L2tlcm5lbC1jdGwva2VybmVsLWlvY3RsLmgKKysrIGIvc3JjL2NvbW1vbi9rZXJuZWwtY3RsL2tl
cm5lbC1pb2N0bC5oCkBAIC0xMzQsNiArMTM0LDggQEAKICAqLwogI2RlZmluZSBMVFROR19LRVJO
RUxfU0VTU0lPTl9MSVNUX1RSQUNLRVJfUElEUwlfSU8oMHhGNiwgMHg1OCkKICNkZWZpbmUgTFRU
TkdfS0VSTkVMX1NFU1NJT05fTUVUQURBVEFfUkVHRU4JX0lPKDB4RjYsIDB4NTkpCisvKiAweDVB
IGFuZCAweDVCIGFyZSByZXNlcnZlZCBmb3IgYSBmdXR1cmUgQUJJLWJyZWFraW5nIGNsZWFudXAu
ICovCisjZGVmaW5lIExUVE5HX0tFUk5FTF9TRVNTSU9OX1NUQVRFRFVNUAkJX0lPKDB4RjYsIDB4
NUMpCiAKIC8qIENoYW5uZWwgRkQgaW9jdGwgKi8KICNkZWZpbmUgTFRUTkdfS0VSTkVMX1NUUkVB
TQkJCV9JTygweEY2LCAweDYyKQotLSAKMS45LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxp
c3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlz
dGluZm8vbHR0bmctZGV2Cg==
