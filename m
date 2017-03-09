From: Liguang Li <liguang.li@windriver.com>
Subject: Babeltrace bug in lttng-live mode
Date: Thu, 9 Mar 2017 15:44:43 +0800
Message-ID: <3fa59051-3a0c-9cd8-61f3-831a5023a087__45148.2179960751$1489046424$gmane$org@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 by lists.lttng.org (Postfix) with ESMTPS id 3vf2qm578JzwX0
 for <lttng-dev@lists.lttng.org>; Thu,  9 Mar 2017 08:00:03 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
 [147.11.189.40])
 by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id v297ikah012845
 (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
 for <lttng-dev@lists.lttng.org>; Wed, 8 Mar 2017 23:44:46 -0800 (PST)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

SGksCgpBIGJhYmVsdHJhY2UgQlVHIGlzIGZvdW5kIGluIHRoZSBsdHRuZy1saXZlIG1vZGUsIGFm
dGVyIGFuYWx5emUgdGhlCmJhY2t0cmFjZSBhbmQgdGhlIHNvdXJjZSBjb2RlLCBpIGZvdW5kIHRo
aXMgaXNzdWUgbWF5YmUgYSBkZWZlY3Qgb2YgZGVzaWduLgoKVGhlIHJlcHJvZHVjZSBzdGVwcyBp
cyBhcyBmb2xsb3dpbmc6CgojY2F0IHRlc3Quc2gKIyEvYmluL3NoCgpsdHRuZyAtbiBjcmVhdGUg
c2Vzc2lvbiAtLWxpdmUgMTAwMDAwMCAtVSBuZXQ6Ly9sb2NhbGhvc3QvCmx0dG5nIGVuYWJsZS1j
aGFubmVsIGNoYW5uZWwwIC11IC0tYnVmZmVycy11aWQgLUMgMTAyNGsgLVcgMQpsdHRuZyBlbmFi
bGUtZXZlbnQgLXUgLS1jaGFubmVsIGNoYW5uZWwwIC1hCgpiYWJlbHRyYWNlIC0tY2xvY2stZGF0
ZSAtLW5vLWRlbHRhIC1pIGx0dG5nLWxpdmUKbmV0Oi8vbG9jYWxob3N0L2hvc3QvbG9jYWxob3N0
L3Nlc3Npb24gJgoKc2xlZXAgMgpsdHRuZyBzdGFydApzbGVlcCAyCgpzYW1wbGVfMSAmICAjIEZp
cnN0IGFwcGxpY2F0aW9uCnNsZWVwIDAuNQpzYW1wbGVfMiAmICAjIFNlY29uZCBhcHBsaWNhdGlv
bgoKCkkgY2hlY2tlZCB0aGUgc291cmNlIGNvZGUgYW5kIGZvdW5kIHRoZSBpc3N1ZSBoYXBwZW5z
IGluIHRoZSBmb2xsb3dpbmcKd29ya2Zsb3cuCgpsdHRuZ19saXZlX3JlYWQKICAgYWRkX3RyYWNl
cwogICAgICAgYWRkX29uZV90cmFjZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgLS0tICgyKQogICAgICAgICAgYnRfY29udGV4dF9hZGRfdHJhY2UKCSAgICAgY3Rm
X29wZW5fbW1hcF90cmFjZQoJCWN0Zl9vcGVuX21tYXBfdHJhY2VfcmVhZAoJCSAgIGN0Zl9vcGVu
X21tYXBfc3RyZWFtX3JlYWQKCQkgICAgICBwcmVwYXJlX21tYXBfc3RyZWFtX2RlZmluaXRpb24K
CQkJIHBhY2tldF9zZWVrKGN0Zl9saXZlX3BhY2tldF9zZWVrKQoJCQkgICAgZ2V0X25leHRfaW5k
ZXgKCQkJICAgICAgIGFwcGVuZF9tZXRhZGF0YQoJCQkgCSAgY3RmX2FwcGVuZF90cmFjZV9tZXRh
ZGF0YSAgICAgLS0tICgxKQoKSW4gKDEpLCB0aGUgZmlyc3QgYXJndW1lbnQgb2YgdGhlIGZ1bmN0
aW9uIGN0Zl9hcHBlbmRfdHJhY2VfbWV0YWRhdGEgaXMKaW52YWxpZCwgYmVjYXVzZSB0aGUgdmll
d2VyX3N0cmVhbS0+Y3RmX3RyYWNlLT5oYW5kbGUgaXMgTlVMTCBub3cuCgpUaGUgY3RmX3RyYWNl
LT5oYW5kbGUgdmFyaWFibGUgaXMgYXNzaWduZWQgaW4gKDIpIGFmdGVyIHRoZSBmb2xsb3dpbmcK
d29yayBpcyBkb25lLgoKQSBmaXggcGF0Y2ggaXMgZm91bmQgaW4gdGhlIG1haWwgbGlzdCwgYnV0
IGFmdGVyIGFwcGxpZWQgdGhpcyBwYXRjaCwgd2UKZm91bmQgdGhlIG5ldyBtZXRhZGF0YSBpbmZv
IGNhbid0IGJlIHVwZGF0ZWQsIHRoZSBldmVudCBpZCBjYW4gbm90IGJlCmZvdW5kIGluIGFycmF5
LgoKVGhlIHBhdGNoIGxpbms6Cmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL3BpcGVybWFpbC9sdHRu
Zy1kZXYvMjAxNS1BdWd1c3QvMDI0ODkxLmh0bWwKCkhvdyB0byBmaXggdGhpcyBpc3N1ZSwgYW55
IGlkZWFzPwoKUmVnYXJkcyAmIFRoYW5rcwpMaWd1YW5nCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2
QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4v
bGlzdGluZm8vbHR0bmctZGV2Cg==
