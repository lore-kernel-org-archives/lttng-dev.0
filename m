From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH liburcu 0/2] Remove RCU requirements on hash
	table destroy
Date: Tue, 30 May 2017 17:10:18 -0400
Message-ID: <1496178620-14755-1-git-send-email-mathieu.desnoyers__370.899102608924$1496179100$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3wcmWc2x78z11TY
 for <lttng-dev@lists.lttng.org>; Tue, 30 May 2017 21:11:55 +0000 (UTC)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: rp@svcs.cs.pdx.edu, "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>, Stephen Hemminger <shemminger@vyatta.com>, Alan Stern <stern@rowland.harvard.edu>, jiangshanlai@gmail.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

VGhlIFJDVSBsb2NrLWZyZWUgaGFzaCB0YWJsZSBjdXJyZW50bHkgcmVxdWlyZXMgdGhhdCB0aGUg
ZGVzdHJveQpmdW5jdGlvbiBzaG91bGQgbm90IGJlIGNhbGxlZCBmcm9tIHdpdGhpbiBSQ1UgcmVh
ZC1zaWRlIGNyaXRpY2FsCnNlY3Rpb25zLiBUaGlzIGlzIGNhdXNlZCBieSB0aGUgbGF6eSByZXNp
emUsIHdoaWNoIHVzZXMgdGhlIGNhbGxfcmN1CndvcmtlciB0aHJlYWQsIGV2ZW4gdGhvdWdoIGFs
bCBpdCByZWFsbHkgbmVlZHMgaXMgYSB3b3JrcXVldWUvd29ya2VyCnRocmVhZCBzY2hlbWUuCgpJ
bXBsZW1lbnQgYW4gaW50ZXJuYWwgd29ya3F1ZXVlIEFQSSBpbiBsaWJ1cmN1LCBhbmQgdXNlIGl0
IGluc3RlYWQgb2YKY2FsbF9yY3UgaW4gcmN1bGZoYXNoIHRvIG92ZXJjb21lIHRoaXMgbGltaXRh
dGlvbi4KCk1hdGhpZXUgRGVzbm95ZXJzICgyKToKICBJbXBsZW1lbnQgdXJjdSB3b3JrcXVldWVz
IGludGVybmFsIEFQSQogIFVzZSB3b3JrcXVldWUgaW4gcmN1bGZoYXNoCgogaW5jbHVkZS91cmN1
L3JjdWxmaGFzaC5oIHwgIDE1ICstCiBzcmMvTWFrZWZpbGUuYW0gICAgICAgICAgfCAgIDIgKy0K
IHNyYy9yY3VsZmhhc2gtaW50ZXJuYWwuaCB8ICAgMiArLQogc3JjL3JjdWxmaGFzaC5jICAgICAg
ICAgIHwgMTI0ICsrKysrKy0tLS0tLQogc3JjL3dvcmtxdWV1ZS5jICAgICAgICAgIHwgNTA3ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiBzcmMvd29ya3F1
ZXVlLmggICAgICAgICAgfCAxMDQgKysrKysrKysrKwogNiBmaWxlcyBjaGFuZ2VkLCA2ODYgaW5z
ZXJ0aW9ucygrKSwgNjggZGVsZXRpb25zKC0pCiBjcmVhdGUgbW9kZSAxMDA2NDQgc3JjL3dvcmtx
dWV1ZS5jCiBjcmVhdGUgbW9kZSAxMDA2NDQgc3JjL3dvcmtxdWV1ZS5oCgotLSAKMi4xLjQKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBt
YWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5n
Lm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
