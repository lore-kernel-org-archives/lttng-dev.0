From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools] Fix: Hold consumer socket lock for
	consumer_send_msg
Date: Tue, 10 Apr 2018 13:56:47 -0400
Message-ID: <1523383007-9943-1-git-send-email-jonathan.rajotte-julien__25992.8579828285$1523384277$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 40LFHN4XLkzxts
 for <lttng-dev@lists.lttng.org>; Tue, 10 Apr 2018 13:57:04 -0400 (EDT)
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

VGhlIGxvY2sgaXMgaGVsZCBhbmQgcmVsZWFzZWQgZHVyaW5nIHRoZSByZWN2IHNlY3Rpb24gYnV0
IG5vdApkdXJpbmcgdGhlIHNlbmQgc2VjdGlvbiBmb3IgYSBmYWlsdXJlIHRvIGxvb2t1cCB0aGUg
UElEIHJlZ2lzdHJ5LgoKU2lnbmVkLW9mZi1ieTogSm9uYXRoYW4gUmFqb3R0ZSA8am9uYXRoYW4u
cmFqb3R0ZS1qdWxpZW5AZWZmaWNpb3MuY29tPgotLS0KIHNyYy9iaW4vbHR0bmctc2Vzc2lvbmQv
dXN0LWNvbnN1bWVyLmMgfCAyICsrCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCgpk
aWZmIC0tZ2l0IGEvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC91c3QtY29uc3VtZXIuYyBiL3NyYy9i
aW4vbHR0bmctc2Vzc2lvbmQvdXN0LWNvbnN1bWVyLmMKaW5kZXggZDhkNmMzMi4uYjk4NjVhMCAx
MDA2NDQKLS0tIGEvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC91c3QtY29uc3VtZXIuYworKysgYi9z
cmMvYmluL2x0dG5nLXNlc3Npb25kL3VzdC1jb25zdW1lci5jCkBAIC01MTMsNyArNTEzLDkgQEAg
aW50IHVzdF9jb25zdW1lcl9tZXRhZGF0YV9yZXF1ZXN0KHN0cnVjdCBjb25zdW1lcl9zb2NrZXQg
KnNvY2tldCkKIAogCQkJbWVtc2V0KCZtc2csIDAsIHNpemVvZihtc2cpKTsKIAkJCW1zZy5jbWRf
dHlwZSA9IExUVE5HX0VSUl9VTkQ7CisJCQlwdGhyZWFkX211dGV4X2xvY2soc29ja2V0LT5sb2Nr
KTsKIAkJCSh2b2lkKSBjb25zdW1lcl9zZW5kX21zZyhzb2NrZXQsICZtc2cpOworCQkJcHRocmVh
ZF9tdXRleF91bmxvY2soc29ja2V0LT5sb2NrKTsKIAkJCS8qCiAJCQkgKiBUaGlzIGlzIHBvc3Np
YmxlIHNpbmNlIHRoZSBzZXNzaW9uIG1pZ2h0IGhhdmUgYmVlbiBkZXN0cm95ZWQKIAkJCSAqIGR1
cmluZyBhIGNvbnN1bWVyIG1ldGFkYXRhIHJlcXVlc3QuIFNvIGhlcmUsIHJldHVybiBncmFjZWZ1
bGx5Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0
dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
