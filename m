From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?=
 <jeremie.galarneau@efficios.com>
Subject: [PATCH lttng-tools] Test: Ensure wildcards may only
	appear last in a string literal
Date: Mon,  4 Aug 2014 14:10:28 -0400
Message-ID: <1407175829-23486-2-git-send-email-jeremie.galarneau__8953.79884536869$1407176024$gmane$org@efficios.com>
References: <1407175829-23486-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1XEMiZ-0002pn-4M
 for lttng-dev@lists.lttng.org; Mon, 04 Aug 2014 14:10:48 -0400
Received: by mail-qg0-f49.google.com with SMTP id j107so9206394qga.8
 for <lttng-dev@lists.lttng.org>; Mon, 04 Aug 2014 11:10:37 -0700 (PDT)
In-Reply-To: <1407175829-23486-1-git-send-email-jeremie.galarneau@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

U2lnbmVkLW9mZi1ieTogSsOpcsOpbWllIEdhbGFybmVhdSA8amVyZW1pZS5nYWxhcm5lYXVAZWZm
aWNpb3MuY29tPgotLS0KIHRlc3RzL3JlZ3Jlc3Npb24vdG9vbHMvZmlsdGVyaW5nL3Rlc3RfaW52
YWxpZF9maWx0ZXIgfCA0ICsrKy0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS90ZXN0cy9yZWdyZXNzaW9uL3Rvb2xzL2ZpbHRlcmlu
Zy90ZXN0X2ludmFsaWRfZmlsdGVyIGIvdGVzdHMvcmVncmVzc2lvbi90b29scy9maWx0ZXJpbmcv
dGVzdF9pbnZhbGlkX2ZpbHRlcgppbmRleCA1ZTA5NmE1Li5lNTY2YzhiIDEwMDc1NQotLS0gYS90
ZXN0cy9yZWdyZXNzaW9uL3Rvb2xzL2ZpbHRlcmluZy90ZXN0X2ludmFsaWRfZmlsdGVyCisrKyBi
L3Rlc3RzL3JlZ3Jlc3Npb24vdG9vbHMvZmlsdGVyaW5nL3Rlc3RfaW52YWxpZF9maWx0ZXIKQEAg
LTI0LDcgKzI0LDcgQEAgU0VTU0lPTl9OQU1FPSJmaWx0ZXItaW52YWxpZCIKIEVWRU5UX05BTUU9
ImJvZ3VzIgogRU5BQkxFX0VWRU5UX1NUREVSUj0iL3RtcC9pbnZhbGlkLWZpbHRlcnMtc3RkZXJy
IgogVFJBQ0VfUEFUSD0kKG1rdGVtcCAtZCkKLU5VTV9URVNUUz0xNDMKK05VTV9URVNUUz0xNDYK
IAogc291cmNlICRURVNURElSL3V0aWxzL3V0aWxzLnNoCiAKQEAgLTE0Myw2ICsxNDMsOCBAQCBJ
TlZBTElEX0ZJTFRFUlM9KAogCQkjIE9ubHkgXCRjdHggaXMgc3VwcG9ydGVkIGZvciBub3cKIAkJ
IlwkZ2xvYmFsLnZhbHVlID09IDAiCiAJCSIwID09IFwkZ2xvYmFsLnZhbHVlIgorCQkjIEEgd2ls
ZGNhcmQgc2hvdWxkIG9ubHkgYXBwZWFyIGFzIHRoZSBsYXN0IGNoYXJhY3RlciBpbiBhIHN0cmlu
ZyBsaXRlcmFsCisJCSJtc2cgPT0gXCJteV9ldmVudCpfYmxhaFwiIgogCQkpCiAKIHN0YXJ0X2x0
dG5nX3Nlc3Npb25kCi0tIAoyLjAuMwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0
dG5nLm9yZwpodHRwOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9s
dHRuZy1kZXYK
