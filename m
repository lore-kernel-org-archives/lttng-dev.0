From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-ust] build: check for CXX_WORKS for cmake
	example
Date: Mon,  3 Oct 2016 11:15:21 -0400
Message-ID: <1475507721-6550-1-git-send-email-jonathan.rajotte-julien__32903.547542128$1475507752$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 3D344A1DC1
 for <lttng-dev@lists.lttng.org>; Mon,  3 Oct 2016 15:17:00 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 600C0340237
 for <lttng-dev@lists.lttng.org>; Mon,  3 Oct 2016 15:16:32 +0000 (UTC)
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

VHJhY2Vwb2ludHMgYW5kIHRyYWNlcG9pbnQgcHJvdmlkZXIgY29tcGlsYXRpb24gbmVlZCBhIGZ1
bmN0aW9uYWwKYysrIGNvbXBpbGVyIChnKysgPiA0LjcpLgoKU2lnbmVkLW9mZi1ieTogSm9uYXRo
YW4gUmFqb3R0ZSA8am9uYXRoYW4ucmFqb3R0ZS1qdWxpZW5AZWZmaWNpb3MuY29tPgotLS0KIGNv
bmZpZ3VyZS5hYyAgICAgICAgICAgICB8IDEgLQogZG9jL2V4YW1wbGVzL01ha2VmaWxlLmFtIHwg
MiArLQogMiBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9jb25maWd1cmUuYWMgYi9jb25maWd1cmUuYWMKaW5kZXggNDI1NmY2Ni4uNDE1
Mzg4ZiAxMDA2NDQKLS0tIGEvY29uZmlndXJlLmFjCisrKyBiL2NvbmZpZ3VyZS5hYwpAQCAtODAs
NyArODAsNiBAQCBBTV9DT05ESVRJT05BTChbTk9fU0hBUkVEXSwgW3Rlc3QgIngkZW5hYmxlX3No
YXJlZCIgPSAieG5vIl0pCiAjIENoZWNrcyBmb3IgcHJvZ3JhbXMuCiBBQ19QUk9HX0NDCiBBQ19Q
Uk9HX0NYWAotQU1fQ09ORElUSU9OQUwoW0hBVkVfQ1hYXSwgW3Rlc3QgIngkQ1hYIiAhPSAieCJd
KQogQUNfQ0hFQ0tfUFJPRyhbSEFWRV9DTUFLRV0sIFtjbWFrZV0sIFsieWVzIl0pCiBBTV9DT05E
SVRJT05BTChbSEFWRV9DTUFLRV0sIFt0ZXN0ICJ4JEhBVkVfQ01BS0UiID0gInh5ZXMiXSkKIEFD
X1BST0dfTUFLRV9TRVQKZGlmZiAtLWdpdCBhL2RvYy9leGFtcGxlcy9NYWtlZmlsZS5hbSBiL2Rv
Yy9leGFtcGxlcy9NYWtlZmlsZS5hbQppbmRleCBjN2U1YjY4Li4wODkwYzUyIDEwMDY0NAotLS0g
YS9kb2MvZXhhbXBsZXMvTWFrZWZpbGUuYW0KKysrIGIvZG9jL2V4YW1wbGVzL01ha2VmaWxlLmFt
CkBAIC0zNCw3ICszNCw3IEBAIGRpc3RfZG9jX2V4YW1wbGVzX3B5dGhvbl9EQVRBID0gcHl0aG9u
L2hlbGxvLnB5CiBlbmRpZgogCiBpZiBIQVZFX0NNQUtFCi1pZiBIQVZFX0NYWAoraWYgQ1hYX1dP
UktTCiBTVUJESVJTX0NNQUtFID0gY21ha2UtbXVsdGlwbGUtc2hhcmVkLWxpYnJhcmllcwogZW5k
aWYKIGVuZGlmCi0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcu
b3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRu
Zy1kZXYK
