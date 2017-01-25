From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules stable-2.8] Documentation:
	lttng-modules 2.8 supports Linux < 4.10
Date: Wed, 25 Jan 2017 15:26:47 -0500
Message-ID: <1485376007-27299-1-git-send-email-mjeanson__49683.4265687086$1485376058$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3v7xVT6kbKzjxC
 for <lttng-dev@lists.lttng.org>; Wed, 25 Jan 2017 20:29:37 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id D943A34026D
 for <lttng-dev@lists.lttng.org>; Wed, 25 Jan 2017 20:28:19 +0000 (UTC)
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

U2lnbmVkLW9mZi1ieTogTWljaGFlbCBKZWFuc29uIDxtamVhbnNvbkBlZmZpY2lvcy5jb20+Ci0t
LQogTWFrZWZpbGUgIHwgNyArKysrKysrCiBSRUFETUUubWQgfCAzICsrLQogMiBmaWxlcyBjaGFu
Z2VkLCA5IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9NYWtlZmls
ZSBiL01ha2VmaWxlCmluZGV4IDg2MDI2NDkuLjkzYWQ5ZTcgMTAwNjQ0Ci0tLSBhL01ha2VmaWxl
CisrKyBiL01ha2VmaWxlCkBAIC0yOSw2ICsyOSwxMyBAQCBpZm5lcSAoJChLRVJORUxSRUxFQVNF
KSwpCiAgICAgZW5kaWYKICAgZW5kaWYKIAorICBpZm5lcSAoJChzaGVsbCBcCisgICAgaWYgWyAk
KFZFUlNJT04pIC1nZSA1IFwKKyAgICAgIC1vIFwoICQoVkVSU0lPTikgLWVxIDQgLWEgJChQQVRD
SExFVkVMKSAtZ2UgMTAgXCkgXSA7IHRoZW4gXAorICAgICAgZWNobyAidHJ1ZSIgOyBmaTspLCkK
KyAgICAkKHdhcm5pbmcgWW91IGFyZSBlbnRlcmluZyB1bmNoYXJ0ZWQgdGVycml0b3JpZXMgYWR2
ZW50dXJlciEgUHJvY2VlZCB3aXRoIHV0bW9zdCBjYXV0aW9uIChhbHNvLCBsdHRuZy1tb2R1bGVz
IDIuOCBkb2VzIG5vdCBzdXBwb3J0IExpbnV4ID49IDQuMTAuIFlvdSBzaG91bGQgdXBncmFkZSB0
byBhIG5ld2VyIGx0dG5nLW1vZHVsZXMgdmVyc2lvbi4pKQorICBlbmRpZgorCiAgIGluY2x1ZGUg
JChUT1BfTFRUTkdfTU9EVUxFU19ESVIpL01ha2VmaWxlLkFCSS53b3JrYXJvdW5kcwogCiAgIGNj
ZmxhZ3MteSArPSAtSSQoVE9QX0xUVE5HX01PRFVMRVNfRElSKQpkaWZmIC0tZ2l0IGEvUkVBRE1F
Lm1kIGIvUkVBRE1FLm1kCmluZGV4IDkzZTJkZDMuLmQzYTY0M2IgMTAwNjQ0Ci0tLSBhL1JFQURN
RS5tZAorKysgYi9SRUFETUUubWQKQEAgLTEwNiw3ICsxMDYsOCBAQCB0byBwcmludCB0cmFjZXMg
YXMgYSBodW1hbi1yZWFkYWJsZSB0ZXh0IGxvZy4KIFN1cHBvcnQKIC0tLS0tLS0KIAotTGludXgg
a2VybmVscyA+PSAyLjYuMzYgYXJlIHN1cHBvcnRlZC4KK0xpbnV4IGtlcm5lbHMgPj0gMi42LjM2
IGFuZCA8IDQuMTAgYXJlIHN1cHBvcnRlZCBieSBMVFRuZyBtb2R1bGVzIDIuOC4KK1VwZ3JhZGUg
dG8gYSBuZXdlciBMVFRuZyBtb2R1bGVzIGZvciBtb3JlIHJlY2VudCBrZXJuZWxzLgogCiAKIE5v
dGVzCi0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0
dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
