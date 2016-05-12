From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 4/5] Fix: configure: forbid Python
	bindings if shared libraries are disabled
Date: Thu, 12 May 2016 16:08:46 -0400
Message-ID: <1463083727-15190-5-git-send-email-mathieu.desnoyers__3381.75038709796$1463083757$gmane$org@efficios.com>
References: <1463083727-15190-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 23293A0639
 for <lttng-dev@lists.lttng.org>; Thu, 12 May 2016 20:08:54 +0000 (UTC)
In-Reply-To: <1463083727-15190-1-git-send-email-mathieu.desnoyers@efficios.com>
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

Rml4ZXM6ICM5NzcKClNpZ25lZC1vZmYtYnk6IE1hdGhpZXUgRGVzbm95ZXJzIDxtYXRoaWV1LmRl
c25veWVyc0BlZmZpY2lvcy5jb20+Ci0tLQogY29uZmlndXJlLmFjIHwgMSArCiAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9jb25maWd1cmUuYWMgYi9jb25maWd1
cmUuYWMKaW5kZXggNWY1ZjllNS4uNmEwNzliYyAxMDA2NDQKLS0tIGEvY29uZmlndXJlLmFjCisr
KyBiL2NvbmZpZ3VyZS5hYwpAQCAtNDE1LDYgKzQxNSw3IEBAIEFNX0NPTkRJVElPTkFMKFtQWVRI
T05fQklORElOR10sIFt0ZXN0ICJ4JHtlbmFibGVfcHl0aG9uX2JpbmRpbmc6LXllc30iID0geHll
c10pCiAKIGlmIHRlc3QgIngke2VuYWJsZV9weXRob25fYmluZGluZzoteWVzfSIgPSB4eWVzOyB0
aGVuCiAgIEFYX1BLR19TV0lHKCRzd2lnX3ZlcnNpb24sIFtdLCBbIEFDX01TR19FUlJPUihbU1dJ
RyAkc3dpZ192ZXJzaW9uIG9yIG5ld2VyIGlzIG5lZWRlZF0pIF0pCisgIEFTX0lGKFt0ZXN0IHgk
ZW5hYmxlX3NoYXJlZCA9IHhub10sIFsgQUNfTVNHX0VSUk9SKFtQeXRob24gYmluZGluZ3MgcmVx
dWlyZSBzaGFyZWQgbGlicmFyaWVzLl0pIF0pCiAgIEFNX1BBVEhfUFlUSE9OKFszLjBdKQogCiAg
IEFDX0FSR19WQVIoW1BZVEhPTl9JTkNMVURFXSwgW0luY2x1ZGUgZmxhZ3MgZm9yIHB5dGhvbiwg
YnlwYXNzaW5nIHB5dGhvbi1jb25maWddKQotLSAKMi4xLjQKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmct
ZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxt
YW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
