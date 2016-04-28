From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: [PATCH 2/3] tests/lib/Makefile.am: use DISTCLEANFILES
	instead of CLEANFILES
Date: Wed, 27 Apr 2016 22:52:19 -0400
Message-ID: <1461811940-8336-2-git-send-email-simon.marchi__8220.20171112872$1461811976$gmane$org@polymtl.ca>
References: <1461811940-8336-1-git-send-email-simon.marchi@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.electronicbox.net (smtp.electronicbox.net [96.127.255.82])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 22E80A3314
 for <lttng-dev@lists.lttng.org>; Thu, 28 Apr 2016 02:52:29 +0000 (UTC)
In-Reply-To: <1461811940-8336-1-git-send-email-simon.marchi@polymtl.ca>
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

RmlsZXMgdGVzdF9zZWVrX2VtcHR5X3BhY2tldCBhbmQgdGVzdF9zZWVrX2JpZ190cmFjZSBhcmUg
Z2VuZXJhdGVkIGJ5CmNvbmZpZ3VyaW5nLCBub3QgYnkgbWFraW5nLiAgVGhlcmVmb3JlLCB3ZSBk
byBub3Qgd2FudCBhIG1ha2UgY2xlYW4gdG8KcmVtb3ZlIHRoZW0uICBPdGhlcndpc2UsIGRvaW5n
Li4uCgogICogbWFrZQogICogbWFrZSBjbGVhbgogICogbWFrZQogICogbWFrZSBjaGVjawoKLi4u
IGZhaWxzLgoKV2Ugd2FudCwgaG93ZXZlciwgdG8gZGVsZXRlIHRoZW0gd2hlbiBkb2luZyBtYWtl
IGRpc3RjbGVhbi4KClNpZ25lZC1vZmYtYnk6IFNpbW9uIE1hcmNoaSA8c2ltb24ubWFyY2hpQHBv
bHltdGwuY2E+Ci0tLQogdGVzdHMvbGliL01ha2VmaWxlLmFtIHwgMiArLQogMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvdGVzdHMvbGli
L01ha2VmaWxlLmFtIGIvdGVzdHMvbGliL01ha2VmaWxlLmFtCmluZGV4IGEwOGNiZjYuLmIzOWJk
MzQgMTAwNjQ0Ci0tLSBhL3Rlc3RzL2xpYi9NYWtlZmlsZS5hbQorKysgYi90ZXN0cy9saWIvTWFr
ZWZpbGUuYW0KQEAgLTQzLDcgKzQzLDcgQEAgdGVzdF9idF9jdGZfZmllbGRfdHlwZV92YWxpZGF0
aW9uX1NPVVJDRVMgPSB0ZXN0X2J0X2N0Zl9maWVsZF90eXBlX3ZhbGlkYXRpb24uYwogCiBTQ1JJ
UFRfTElTVCA9IHRlc3RfY3RmX3dyaXRlcl9jb21wbGV0ZQogRVhUUkFfRElTVCA9IHRlc3Rfc2Vl
a19iaWdfdHJhY2UuaW4gdGVzdF9zZWVrX2VtcHR5X3BhY2tldC5pbgotQ0xFQU5GSUxFUz0gdGVz
dF9zZWVrX2JpZ190cmFjZSB0ZXN0X3NlZWtfZW1wdHlfcGFja2V0CitESVNUQ0xFQU5GSUxFUyA9
IHRlc3Rfc2Vla19iaWdfdHJhY2UgdGVzdF9zZWVrX2VtcHR5X3BhY2tldAogCiBpZiBFTkFCTEVf
REVCVUdJTkZPCiB0ZXN0X2R3YXJmX0xERkxBR1MgPSAtc3RhdGljCi0tIAoyLjguMAoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxp
bmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3Jn
L2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
