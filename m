From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH urcu 2/3] Fix: assignment from incompatible
	pointer type warnings
Date: Thu, 20 Jul 2017 17:33:46 -0400
Message-ID: <1500586427-30038-2-git-send-email-mjeanson__49741.4054385901$1500586511$gmane$org@efficios.com>
References: <1500586427-30038-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3xD6fJ6bN1z13fS
 for <lttng-dev@lists.lttng.org>; Thu, 20 Jul 2017 21:36:24 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 10AB3340302
 for <lttng-dev@lists.lttng.org>; Thu, 20 Jul 2017 21:35:44 +0000 (UTC)
In-Reply-To: <1500586427-30038-1-git-send-email-mjeanson@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org, mathieu.desnoyers@efficios.com
List-Id: lttng-dev@lists.lttng.org

T24gc29tZSBwbGF0Zm9ybXMsIG1tYXAgcmV0dXJucyBhIGNhZGRyX3QgcG9pbnRlciB3aGljaCBn
ZW5lcmF0ZXMKY29tcGlsZXIgd2FybmluZ3MsIGNhc3QgdG8gdGhlIHByb3BlciBwb2ludGVyIHR5
cGUgdG8gZWxpbWluYXRlIHRoZW0uCgpTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIEplYW5zb24gPG1q
ZWFuc29uQGVmZmljaW9zLmNvbT4KLS0tCiBzcmMvdXJjdS1icC5jIHwgOCArKysrKy0tLQogMSBm
aWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9zcmMvdXJjdS1icC5jIGIvc3JjL3VyY3UtYnAuYwppbmRleCA4MWJiOTFhLi5jMGZhYzgzIDEw
MDY0NAotLS0gYS9zcmMvdXJjdS1icC5jCisrKyBiL3NyYy91cmN1LWJwLmMKQEAgLTM3NCw3ICsz
NzQsOCBAQCB2b2lkIGV4cGFuZF9hcmVuYShzdHJ1Y3QgcmVnaXN0cnlfYXJlbmEgKmFyZW5hKQog
CQkJc2l6ZW9mKHN0cnVjdCByZWdpc3RyeV9jaHVuaykKIAkJCSsgc2l6ZW9mKHN0cnVjdCByY3Vf
cmVhZGVyKSk7CiAJCW5ld19jaHVua19sZW4gPSBBUkVOQV9JTklUX0FMTE9DOwotCQluZXdfY2h1
bmsgPSBtbWFwKE5VTEwsIG5ld19jaHVua19sZW4sCisJCW5ld19jaHVuayA9IChzdHJ1Y3QgcmVn
aXN0cnlfY2h1bmsgKikgbW1hcChOVUxMLAorCQkJbmV3X2NodW5rX2xlbiwKIAkJCVBST1RfUkVB
RCB8IFBST1RfV1JJVEUsCiAJCQlNQVBfQU5PTllNT1VTIHwgTUFQX1BSSVZBVEUsCiAJCQktMSwg
MCk7CkBAIC00MDgsNyArNDA5LDggQEAgdm9pZCBleHBhbmRfYXJlbmEoc3RydWN0IHJlZ2lzdHJ5
X2FyZW5hICphcmVuYSkKIAl9CiAKIAkvKiBSZW1hcCBkaWQgbm90IHN1Y2NlZWQsIHdlIG5lZWQg
dG8gYWRkIGEgbmV3IGNodW5rLiAqLwotCW5ld19jaHVuayA9IG1tYXAoTlVMTCwgbmV3X2NodW5r
X2xlbiwKKwluZXdfY2h1bmsgPSAoc3RydWN0IHJlZ2lzdHJ5X2NodW5rICopIG1tYXAoTlVMTCwK
KwkJbmV3X2NodW5rX2xlbiwKIAkJUFJPVF9SRUFEIHwgUFJPVF9XUklURSwKIAkJTUFQX0FOT05Z
TU9VUyB8IE1BUF9QUklWQVRFLAogCQktMSwgMCk7CkBAIC02MjUsNyArNjI3LDcgQEAgdm9pZCBy
Y3VfYnBfZXhpdCh2b2lkKQogCiAJCWNkc19saXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUoY2h1bmss
IHRtcCwKIAkJCQkmcmVnaXN0cnlfYXJlbmEuY2h1bmtfbGlzdCwgbm9kZSkgewotCQkJbXVubWFw
KGNodW5rLCBjaHVuay0+ZGF0YV9sZW4KKwkJCW11bm1hcCgodm9pZCAqKSBjaHVuaywgY2h1bmst
PmRhdGFfbGVuCiAJCQkJCSsgc2l6ZW9mKHN0cnVjdCByZWdpc3RyeV9jaHVuaykpOwogCQl9CiAJ
CUNEU19JTklUX0xJU1RfSEVBRCgmcmVnaXN0cnlfYXJlbmEuY2h1bmtfbGlzdCk7Ci0tIAoyLjcu
NAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmct
ZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMu
bHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
