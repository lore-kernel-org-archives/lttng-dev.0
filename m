From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools] Test: use output_path instead of
	argument position
Date: Wed,  5 Apr 2017 10:53:41 -0400
Message-ID: <1491404021-2026-1-git-send-email-jonathan.rajotte-julien__10262.4487634332$1491404085$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3vyplG3QB1zkpF
 for <lttng-dev@lists.lttng.org>; Wed,  5 Apr 2017 14:54:17 +0000 (UTC)
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

U2lnbmVkLW9mZi1ieTogSm9uYXRoYW4gUmFqb3R0ZSA8am9uYXRoYW4ucmFqb3R0ZS1qdWxpZW5A
ZWZmaWNpb3MuY29tPgotLS0KIHRlc3RzL3JlZ3Jlc3Npb24vdG9vbHMvbWkvdGVzdF9taSB8IDQg
KystLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS90ZXN0cy9yZWdyZXNzaW9uL3Rvb2xzL21pL3Rlc3RfbWkgYi90ZXN0cy9yZWdy
ZXNzaW9uL3Rvb2xzL21pL3Rlc3RfbWkKaW5kZXggMzgwMzg1Zi4uMGQzYmQ0ZiAxMDA3NTUKLS0t
IGEvdGVzdHMvcmVncmVzc2lvbi90b29scy9taS90ZXN0X21pCisrKyBiL3Rlc3RzL3JlZ3Jlc3Np
b24vdG9vbHMvbWkvdGVzdF9taQpAQCAtMTMyLDEwICsxMzIsMTAgQEAgZnVuY3Rpb24gaXNfY29t
bWFuZF9zdWNjZXNzICgpCiAKIGZ1bmN0aW9uIG1pX3ByaW50X3ZlcnNpb24gKCkKIHsKLQlsb2Nh
bCBvcHQ9JDIKIAlsb2NhbCBvdXRwdXRfcGF0aD0kMQorCWxvY2FsIG9wdD0kMgogCi0JJExUVE5H
IHZlcnNpb24gJG9wdCA+ICQxCisJJExUVE5HIHZlcnNpb24gJG9wdCA+ICRvdXRwdXRfcGF0aAog
CW9rICQ/ICJNSSB0ZXN0OiBMdHRuZyB2ZXJzaW9uIgogCiB9Ci0tIAoyLjcuNAoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcg
bGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2Nn
aS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
