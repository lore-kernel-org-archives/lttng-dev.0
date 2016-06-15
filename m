From: Janine Sutto <janinesutto@gmail.com>
Subject: [PATCH lttng-tools] Fix: sessiond: ht_match_event():
	check if filter is NULL
Date: Wed, 15 Jun 2016 17:34:17 -0400
Message-ID: <20160615213417.2946-1-janinesutto__4010.19335627115$1466201697$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk0-f193.google.com (mail-qk0-f193.google.com
 [209.85.220.193])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id C2E2BA3806
 for <lttng-dev@lists.lttng.org>; Wed, 15 Jun 2016 21:34:26 +0000 (UTC)
Received: by mail-qk0-f193.google.com with SMTP id b136so4997786qkg.2
 for <lttng-dev@lists.lttng.org>; Wed, 15 Jun 2016 14:34:26 -0700 (PDT)
Received: from jsutto (cable-192.222.213.99.electronicbox.net.
 [192.222.213.99])
 by smtp.gmail.com with ESMTPSA id p62sm10066506qkb.38.2016.06.15.14.34.25
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Jun 2016 14:34:25 -0700 (PDT)
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

SXQgbG9va3MgbGlrZSBhbiBhZ2VudCBldmVudCdzIGZpbHRlciBleHByZXNzaW9uIGlzIE5VTEwg
d2hlbgppdCdzIGNyZWF0ZWQgd2l0aCAtYSwgZm9yIGV4YW1wbGU6CgogICAgbHR0bmcgZW5hYmxl
LWV2ZW50IC1qIC1hCgpTaW5jZSB0aGVyZSdzIG5vIGNoZWNrIGZvciB0aGlzIGluIGh0X21hdGNo
X2V2ZW50KCksIHN0cmxlbigpCm1ha2VzIHRoZSBzZXNzaW9uIGRhZW1vbiBzZWdmYXVsdCB3aXRo
IHRoaXMgc2NlbmFyaW86CgogICAgbHR0bmcgY3JlYXRlCiAgICBsdHRuZyBlbmFibGUtZXZlbnQg
LWogLWEKICAgIGx0dG5nIGRpc2FibGUtZXZlbnQgLWogLWEKClNpZ25lZC1vZmYtYnk6IEphbmlu
ZSBTdXR0byA8amFuaW5lc3V0dG9AZ21haWwuY29tPgotLS0KIHNyYy9iaW4vbHR0bmctc2Vzc2lv
bmQvYWdlbnQuYyB8IDExICsrKysrKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQv
YWdlbnQuYyBiL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvYWdlbnQuYwppbmRleCA4ZTFlZjA4Li43
Y2JiYmRlIDEwMDY0NAotLS0gYS9zcmMvYmluL2x0dG5nLXNlc3Npb25kL2FnZW50LmMKKysrIGIv
c3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9hZ2VudC5jCkBAIC0xNDMsMTEgKzE0MywxOCBAQCBzdGF0
aWMgaW50IGh0X21hdGNoX2V2ZW50KHN0cnVjdCBjZHNfbGZodF9ub2RlICpub2RlLAogCX0KCiAJ
LyogRmlsdGVyIGV4cHJlc3Npb24gKi8KLQlpZiAoc3RybmNtcChldmVudC0+ZmlsdGVyX2V4cHJl
c3Npb24sIGtleS0+ZmlsdGVyX2V4cHJlc3Npb24sCi0JCQlzdHJsZW4oZXZlbnQtPmZpbHRlcl9l
eHByZXNzaW9uKSkgIT0gMCkgeworCWlmICghIWV2ZW50LT5maWx0ZXJfZXhwcmVzc2lvbiBeICEh
a2V5LT5maWx0ZXJfZXhwcmVzc2lvbikgeworCQkvKiBPbmUgaGFzIGEgZmlsdGVyIGV4cHJlc3Np
b24sIHRoZSBvdGhlciBkb2VzIG5vdCAqLwogCQlnb3RvIG5vX21hdGNoOwogCX0KCisJaWYgKGV2
ZW50LT5maWx0ZXJfZXhwcmVzc2lvbikgeworCQlpZiAoc3RybmNtcChldmVudC0+ZmlsdGVyX2V4
cHJlc3Npb24sIGtleS0+ZmlsdGVyX2V4cHJlc3Npb24sCisJCQkJc3RybGVuKGV2ZW50LT5maWx0
ZXJfZXhwcmVzc2lvbikpICE9IDApIHsKKwkJCWdvdG8gbm9fbWF0Y2g7CisJCX0KKwl9CisKIAly
ZXR1cm4gMTsKCiBub19tYXRjaDoKLS0KMi44LjMKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxp
c3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlz
dGluZm8vbHR0bmctZGV2Cg==
