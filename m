From: Francis Deslauriers <francis.deslauriers@efficios.com>
Subject: [PATCH lttng-tools v2 3/5] Tests: allow the use of
	regular expressions to match events
Date: Fri,  9 Feb 2018 16:56:50 -0500
Message-ID: <1518213412-16593-4-git-send-email-francis.deslauriers__20866.3303674713$1518213349$gmane$org@efficios.com>
References: <1518032219-28072-1-git-send-email-francis.deslauriers@efficios.com>
 <1518213412-16593-1-git-send-email-francis.deslauriers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3zdTRw35fxzpTQ
 for <lttng-dev@lists.lttng.org>; Fri,  9 Feb 2018 21:56:59 +0000 (UTC)
In-Reply-To: <1518213412-16593-1-git-send-email-francis.deslauriers@efficios.com>
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

U2lnbmVkLW9mZi1ieTogRnJhbmNpcyBEZXNsYXVyaWVycyA8ZnJhbmNpcy5kZXNsYXVyaWVyc0Bl
ZmZpY2lvcy5jb20+Ci0tLQogdGVzdHMvdXRpbHMvdXRpbHMuc2ggfCA0ICsrLS0KIDEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGVz
dHMvdXRpbHMvdXRpbHMuc2ggYi90ZXN0cy91dGlscy91dGlscy5zaAppbmRleCBlOGRmY2RhLi45
YmYxZmNjIDEwMDY0NAotLS0gYS90ZXN0cy91dGlscy91dGlscy5zaAorKysgYi90ZXN0cy91dGls
cy91dGlscy5zaApAQCAtMTQ1Nyw3ICsxNDU3LDcgQEAgZnVuY3Rpb24gdmFsaWRhdGVfdHJhY2Vf
ZXhwKCkKIAl3aGljaCAkQkFCRUxUUkFDRV9CSU4gPi9kZXYvbnVsbAogCXNraXAgJD8gLW5lIDAg
IkJhYmVsdHJhY2UgYmluYXJ5IG5vdCBmb3VuZC4gU2tpcHBpbmcgdHJhY2UgdmFsaWRhdGlvbiIK
IAotCXRyYWNlZD0kKCRCQUJFTFRSQUNFX0JJTiAkdHJhY2VfcGF0aCAyPi9kZXYvbnVsbCB8IGdy
ZXAgJHtldmVudF9leHB9IHwgd2MgLWwpCisJdHJhY2VkPSQoJEJBQkVMVFJBQ0VfQklOICR0cmFj
ZV9wYXRoIDI+L2Rldi9udWxsIHwgZ3JlcCAtLWV4dGVuZGVkLXJlZ2V4cCAke2V2ZW50X2V4cH0g
fCB3YyAtbCkKIAlpZiBbICIkdHJhY2VkIiAtbmUgMCBdOyB0aGVuCiAJCXBhc3MgIlZhbGlkYXRl
IHRyYWNlIGZvciBleHByZXNzaW9uICcke2V2ZW50X2V4cH0nLCAkdHJhY2VkIGV2ZW50cyIKIAll
bHNlCkBAIC0xNDc2LDcgKzE0NzYsNyBAQCBmdW5jdGlvbiB2YWxpZGF0ZV90cmFjZV9vbmx5X2V4
cCgpCiAJd2hpY2ggJEJBQkVMVFJBQ0VfQklOID4vZGV2L251bGwKIAlza2lwICQ/IC1uZSAwICJC
YWJlbHRyYWNlIGJpbmFyeSBub3QgZm91bmQuIFNraXBwaW5nIHRyYWNlIG1hdGNoZXMiCiAKLQls
b2NhbCBjb3VudD0kKCRCQUJFTFRSQUNFX0JJTiAkdHJhY2VfcGF0aCB8IGdyZXAgJHtldmVudF9l
eHB9IHwgd2MgLWwpCisJbG9jYWwgY291bnQ9JCgkQkFCRUxUUkFDRV9CSU4gJHRyYWNlX3BhdGgg
fCBncmVwIC0tZXh0ZW5kZWQtcmVnZXhwICR7ZXZlbnRfZXhwfSB8IHdjIC1sKQogCWxvY2FsIHRv
dGFsPSQoJEJBQkVMVFJBQ0VfQklOICR0cmFjZV9wYXRoIHwgd2MgLWwpCiAKIAlpZiBbICIkY291
bnQiIC1uZSAwIF0gJiYgWyAiJHRvdGFsIiAtZXEgIiRjb3VudCIgXTsgdGhlbgotLSAKMi43LjQK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRl
diBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0
dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
