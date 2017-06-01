From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools] Fix: test: proper redirection of
	stderr to stdout
Date: Thu,  1 Jun 2017 18:16:46 -0400
Message-ID: <20170601221646.9005-1-jonathan.rajotte-julien__14682.7753437266$1496355581$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3wf1vD4gwdz12Q2
 for <lttng-dev@lists.lttng.org>; Thu,  1 Jun 2017 22:18:16 +0000 (UTC)
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
ZWZmaWNpb3MuY29tPgotLS0KIHRlc3RzL3JlZ3Jlc3Npb24vdG9vbHMvZXhjbHVzaW9uL3Rlc3Rf
ZXhjbHVzaW9uIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pCgpkaWZmIC0tZ2l0IGEvdGVzdHMvcmVncmVzc2lvbi90b29scy9leGNsdXNpb24vdGVz
dF9leGNsdXNpb24gYi90ZXN0cy9yZWdyZXNzaW9uL3Rvb2xzL2V4Y2x1c2lvbi90ZXN0X2V4Y2x1
c2lvbgppbmRleCAyYWY5YTkzYi4uYzE1NWMyNWYgMTAwNzU1Ci0tLSBhL3Rlc3RzL3JlZ3Jlc3Np
b24vdG9vbHMvZXhjbHVzaW9uL3Rlc3RfZXhjbHVzaW9uCisrKyBiL3Rlc3RzL3JlZ3Jlc3Npb24v
dG9vbHMvZXhjbHVzaW9uL3Rlc3RfZXhjbHVzaW9uCkBAIC03OSw3ICs3OSw3IEBAIGZ1bmN0aW9u
IHRlc3RfZXhjbHVzaW9uX2ZhaWwKIAlleGNsdXNpb25zPSIkMiIKIAogCWNyZWF0ZV9sdHRuZ19z
ZXNzaW9uX29rICRTRVNTSU9OX05BTUUgJHRyYWNlX3BhdGgKLQkkVEVTVERJUi8uLi9zcmMvYmlu
L2x0dG5nLyRMVFROR19CSU4gZW5hYmxlLWV2ZW50IC11ICIkZXZlbnRfbmFtZSIgLXMgJHNlc3Nf
bmFtZSAteCAiJGV4Y2x1c2lvbnMiIDImPjEgPi9kZXYvbnVsbAorCSRURVNURElSLy4uL3NyYy9i
aW4vbHR0bmcvJExUVE5HX0JJTiBlbmFibGUtZXZlbnQgLXUgIiRldmVudF9uYW1lIiAtcyAkc2Vz
c19uYW1lIC14ICIkZXhjbHVzaW9ucyIgPi9kZXYvbnVsbCAyPiYxCiAJcmVzPSQ/CiAJZGVzdHJv
eV9sdHRuZ19zZXNzaW9uX29rICRTRVNTSU9OX05BTUUKIAotLSAKMi4xMS4wCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBs
aXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dp
LWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
