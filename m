From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-ust 1/2] Fix: lttng-gen-tp: only replace
	file extension
Date: Tue, 19 Sep 2017 12:08:33 -0400
Message-ID: <20170919160834.23713-1-jonathan.rajotte-julien__27050.4670370885$1505837360$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3xxSVG3YvCzDTL
 for <lttng-dev@lists.lttng.org>; Tue, 19 Sep 2017 16:08:54 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 3D6C1340224
 for <lttng-dev@lists.lttng.org>; Tue, 19 Sep 2017 16:09:37 +0000 (UTC)
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

UHJldmlvdXMgcmVwbGFjZSB3YXMgZG9uZSBvbiB0aGUgY29tcGxldGUgcGF0aC4gQSBwYXRoIGNv
bnRhaW5pbmcKLmMgb3IgLm8gd291bGQgcmVzdWx0IGluIGEgY29ycnVwdGVkIGZpbGUgcGF0aC4K
ClJlcG9ydGVkLWJ5OiBHdW5uYXIgU3RyYW5kIDxHdW5uYXIuU3RyYW5kQGVyaWNzc29uLmNvbT4K
U2lnbmVkLW9mZi1ieTogSm9uYXRoYW4gUmFqb3R0ZSA8am9uYXRoYW4ucmFqb3R0ZS1qdWxpZW5A
ZWZmaWNpb3MuY29tPgotLS0KIHRvb2xzL2x0dG5nLWdlbi10cCB8IDkgKysrKysrKy0tCiAxIGZp
bGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L3Rvb2xzL2x0dG5nLWdlbi10cCBiL3Rvb2xzL2x0dG5nLWdlbi10cAppbmRleCBiNjJjZDk5MC4u
NmFhMWJiYTEgMTAwNzU1Ci0tLSBhL3Rvb2xzL2x0dG5nLWdlbi10cAorKysgYi90b29scy9sdHRu
Zy1nZW4tdHAKQEAgLTc5LDcgKzc5LDkgQEAgY2xhc3MgQ0ZpbGU6CiAgICAgZGVmIHdyaXRlKHNl
bGYpOgogICAgICAgICBvdXRwdXRGaWxlID0gb3BlbihzZWxmLm91dHB1dEZpbGVuYW1lLCJ3IikK
IAotICAgICAgICBoZWFkZXJGaWxlbmFtZSA9IHNlbGYub3V0cHV0RmlsZW5hbWUucmVwbGFjZSgi
LmMiLCIuaCIpCisgICAgICAgIGhlYWRlckZpbGVuYW1lID0gc2VsZi5vdXRwdXRGaWxlbmFtZQor
ICAgICAgICBpZiBoZWFkZXJGaWxlbmFtZS5lbmRzd2l0aCgiLmMiKToKKyAgICAgICAgICAgIGhl
YWRlckZpbGVuYW1lID0gaGVhZGVyRmlsZW5hbWVbOi0yXSArICIuaCIKIAogICAgICAgICBvdXRw
dXRGaWxlLndyaXRlKENGaWxlLkZJTEVfVFBMLmZvcm1hdCgKICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBoZWFkZXJGaWxlbmFtZSA9IGhlYWRlckZpbGVuYW1lKSkK
QEAgLTEyNiw3ICsxMjgsMTAgQEAgY2xhc3MgT2JqRmlsZToKICAgICAgICAgcmV0dXJuIGNjCiAK
ICAgICBkZWYgd3JpdGUoc2VsZik6Ci0gICAgICAgIGNGaWxlbmFtZSA9IHNlbGYub3V0cHV0Rmls
ZW5hbWUucmVwbGFjZSgiLm8iLCIuYyIpCisgICAgICAgIGNGaWxlbmFtZSA9IHNlbGYub3V0cHV0
RmlsZW5hbWUKKyAgICAgICAgaWYgY0ZpbGVuYW1lLmVuZHN3aXRoKCIubyIpOgorICAgICAgICAg
ICAgY0ZpbGVuYW1lID0gY0ZpbGVuYW1lWzotMl0gKyAiLmMiCisKICAgICAgICAgY2MgPSBzZWxm
Ll9kZXRlY3RDQygpCiAgICAgICAgIGlmIGNjID09ICIiOgogICAgICAgICAgICAgcmFpc2UgUnVu
dGltZUVycm9yKCJObyBDIENvbXBpbGVyIGRldGVjdGVkIikKLS0gCjIuMTEuMAoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcg
bGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2Nn
aS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
