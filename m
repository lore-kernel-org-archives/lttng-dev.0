From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [PATCH lttng-modules v3 0/5] Extract payload from
	polling syscalls
Date: Fri, 15 Apr 2016 15:31:08 -0400
Message-ID: <1460748673-13183-1-git-send-email-jdesfossez__45754.1969525211$1460748709$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com (albert.ini-tech.com [192.99.35.19])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 7B572A0117
 for <lttng-dev@lists.lttng.org>; Fri, 15 Apr 2016 19:31:22 +0000 (UTC)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

UGF0Y2ggc2VyaWUgdG8gZXh0cmFjdCB0aGUgcGF5bG9hZCBvZiB0aGUgcG9sbGluZyBzeXN0ZW0g
Y2FsbHMgb24geDg2IGFuZCBBUk0KKDMyIGFuZCA2NC1iaXQpLiBUaGUgY29uY2VybmVkIHN5c3Rl
bSBjYWxscyBhcmUgc2VsZWN0LCBwc2VsZWN0NiwgcG9sbCwgcHBvbGwsCmVwb2xsX2N0bCwgZXBv
bGxfd2FpdCwgZXBvbGxfcHdhaXQuCgpDaGFuZ2VzIGZyb20gdjI6CiAtIE1ha2Ugc3VyZSBhbGwg
dXNlci1jb250cm9sbGVkIGRhdGEgaXMgaGFuZGxlZCBzYWZlbHkgaW4gdGhlIGtlcm5lbAogLSBB
bGxvY2F0ZSBtZW1vcnkgaW5zdGVhZCBvZiB1c2luZyB0aGUgc3RhY2sgZm9yIGFyYml0cmFyaWx5
IGxhcmdlIGRhdGEKIC0gT25seSBleHRyYWN0IHRoZSBzdGFuZGFyZCBldmVudCBmbGFncyBhbmQg
b3V0cHV0IHRoZSByYXcgZXZlbnQgdmFsdWUgYXMgaGV4CiAtIFZhcmlvdXMgYnVnZml4ZXMgZnJv
bSB2MgoKVGhpcyBjb2RlIGlzIGhhbmRsZWQgaW4gdGhlIGtlcm5lbCB3aXRoIGlucHV0IGNvbWlu
ZyBmcm9tIHVzZXItc3BhY2UsIG1ha2Ugc3VyZQp0byByZXZpZXcgaXQgYXMgaWYgaXQgd2FzIGFj
dHVhbCBzeXN0ZW0gY2FsbHMuCgpKdWxpZW4gRGVzZm9zc2V6ICg1KToKICBBZGQgY3RmX2ludGVn
ZXJfYml0ZmllbGRfdHlwZQogIEV4dHJhY3QgdGhlIEZEIHNldHMgaW4gc2VsZWN0IGFuZCBwc2Vs
ZWN0NgogIEV4dHJhY3QgdGhlIEZEcyBhbmQgZmxhZ3MgZnJvbSBwb2xsIGFuZCBwcG9sbAogIEV4
dHJhY3QgdGhlIHBheWxvYWQgZm9yIGVwb2xsX2N0bAogIEV4dHJhY3QgdGhlIHBheWxvYWQgb2Yg
ZXBvbGxfd2FpdC9lcG9sbF9wd2FpdAoKIC4uLi9zeXNjYWxscy9oZWFkZXJzL3N5c2NhbGxzX3Bv
aW50ZXJzX292ZXJyaWRlLmggIHwgODYyICsrKysrKysrKysrKysrKysrKysrKwogcHJvYmVzL2x0
dG5nLWV2ZW50cy13cml0ZS5oICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDggKwogMiBmaWxl
cyBjaGFuZ2VkLCA4NzAgaW5zZXJ0aW9ucygrKQoKLS0gCjEuOS4xCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0
dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9t
YWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
