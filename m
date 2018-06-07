From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules] Fix: dyntick field added to
	trace_rcu_dyntick in v4.16
Date: Thu,  7 Jun 2018 15:32:49 -0400
Message-ID: <20180607193249.19439-1-mjeanson__47246.1993959316$1528399869$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 411wgQ6T94znH1
 for <lttng-dev@lists.lttng.org>; Thu,  7 Jun 2018 15:33:06 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 4F0092274E0
 for <lttng-dev@lists.lttng.org>; Thu,  7 Jun 2018 15:33:00 -0400 (EDT)
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

U2VlIHVwc3RyZWFtIGNvbW1pdDoKCiAgY29tbWl0IGRlYzk4OTAwZWFlMWUyMjQ2NzE4MmU1ODY4
OGFiZTVmYWU5OGJkNWYKICBBdXRob3I6IFBhdWwgRS4gTWNLZW5uZXkgPHBhdWxtY2tAbGludXgu
dm5ldC5pYm0uY29tPgogIERhdGU6ICAgV2VkIE9jdCA0IDE2OjI0OjI5IDIwMTcgLTA3MDAKCiAg
ICByY3U6IEFkZCAtPmR5bnRpY2tzIGZpZWxkIHRvIHJjdV9keW50aWNrIHRyYWNlIGV2ZW50CgpT
aWduZWQtb2ZmLWJ5OiBNaWNoYWVsIEplYW5zb24gPG1qZWFuc29uQGVmZmljaW9zLmNvbT4KLS0t
CiBpbnN0cnVtZW50YXRpb24vZXZlbnRzL2x0dG5nLW1vZHVsZS9yY3UuaCB8IDIgKy0KIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2lu
c3RydW1lbnRhdGlvbi9ldmVudHMvbHR0bmctbW9kdWxlL3JjdS5oIGIvaW5zdHJ1bWVudGF0aW9u
L2V2ZW50cy9sdHRuZy1tb2R1bGUvcmN1LmgKaW5kZXggNzc2MGJkNi4uNThhMjMwNiAxMDA2NDQK
LS0tIGEvaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUvcmN1LmgKKysrIGIvaW5z
dHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUvcmN1LmgKQEAgLTYxMiw3ICs2MTIsNyBA
QCBMVFROR19UUkFDRVBPSU5UX0VWRU5UKHJjdV9iYXJyaWVyLAogCQkJCQkgZ3JwbG8sIGdycGhp
LCBncF90YXNrcykgZG8geyB9IFwKIAl3aGlsZSAoMCkKICNkZWZpbmUgdHJhY2VfcmN1X2Zxcyhy
Y3VuYW1lLCBncG51bSwgY3B1LCBxc2V2ZW50KSBkbyB7IH0gd2hpbGUgKDApCi0jaWYgKExJTlVY
X1ZFUlNJT05fQ09ERSA+PSBLRVJORUxfVkVSU0lPTig0LDE3LDApKQorI2lmIChMSU5VWF9WRVJT
SU9OX0NPREUgPj0gS0VSTkVMX1ZFUlNJT04oNCwxNiwwKSkKICNkZWZpbmUgdHJhY2VfcmN1X2R5
bnRpY2socG9sYXJpdHksIG9sZG5lc3RpbmcsIG5ld25lc3RpbmcsIGR5bnRpY2spIGRvIHsgfSB3
aGlsZSAoMCkKICNlbGlmIChMSU5VWF9WRVJTSU9OX0NPREUgPj0gS0VSTkVMX1ZFUlNJT04oMywz
LDApKQogI2RlZmluZSB0cmFjZV9yY3VfZHludGljayhwb2xhcml0eSwgb2xkbmVzdGluZywgbmV3
bmVzdGluZykgZG8geyB9IHdoaWxlICgwKQotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5n
LWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWls
bWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
