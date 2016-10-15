From: Anders Wallin <wallinux@gmail.com>
Subject: [PATCH lttng-tools] Add version info to lttng-relayd
	help
Date: Sat, 15 Oct 2016 08:38:23 +0200
Message-ID: <20161015063823.16638-1-wallinux__22557.8277292245$1476513540$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lf0-f65.google.com (mail-lf0-f65.google.com
 [209.85.215.65])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 5940EA3BEC
 for <lttng-dev@lists.lttng.org>; Sat, 15 Oct 2016 06:40:20 +0000 (UTC)
Received: by mail-lf0-f65.google.com with SMTP id b75so19198408lfg.3
 for <lttng-dev@lists.lttng.org>; Fri, 14 Oct 2016 23:38:26 -0700 (PDT)
Received: from localhost.localdomain (h-94-254-57-193.na.cust.bahnhof.se.
 [94.254.57.193])
 by smtp.gmail.com with ESMTPSA id s20sm4130007lfi.12.2016.10.14.23.38.24
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 14 Oct 2016 23:38:24 -0700 (PDT)
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

bHR0bmctcmVsYXlkIG1hbiBwYWdlcyBzdGF0ZXMgdGhhdCB0aGUgb3B0aW9uCi1WIC0tdmVyc2lv
biBpcyBhdmFpbGFibGUsIGJ1dCBpdCBpdCdzIG1pc3NpbmcgaW4gdGhlIGNvZGUKClNpZ25lZC1v
ZmYtYnk6IEFuZGVycyBXYWxsaW4gPHdhbGxpbnV4QGdtYWlsLmNvbT4KLS0tCiBzcmMvYmluL2x0
dG5nLXJlbGF5ZC9tYWluLmMgfCAxNSArKysrKysrKysrKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCAx
NCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvc3JjL2Jpbi9sdHRu
Zy1yZWxheWQvbWFpbi5jIGIvc3JjL2Jpbi9sdHRuZy1yZWxheWQvbWFpbi5jCmluZGV4IGVhNDZl
YzcuLjM0YTliYTEgMTAwNjQ0Ci0tLSBhL3NyYy9iaW4vbHR0bmctcmVsYXlkL21haW4uYworKysg
Yi9zcmMvYmluL2x0dG5nLXJlbGF5ZC9tYWluLmMKQEAgLTE2MSwxMCArMTYxLDIwIEBAIHN0YXRp
YyBzdHJ1Y3Qgb3B0aW9uIGxvbmdfb3B0aW9uc1tdID0gewogCXsgIm91dHB1dCIsIDEsIDAsICdv
JywgfSwKIAl7ICJ2ZXJib3NlIiwgMCwgMCwgJ3YnLCB9LAogCXsgImNvbmZpZyIsIDEsIDAsICdm
JyB9LAorCXsgInZlcnNpb24iLCAwLCAwLCAnVicgfSwKIAl7IE5VTEwsIDAsIDAsIDAsIH0sCiB9
OwogCi1zdGF0aWMgY29uc3QgY2hhciAqY29uZmlnX2lnbm9yZV9vcHRpb25zW10gPSB7ICJoZWxw
IiwgImNvbmZpZyIgfTsKK3N0YXRpYyBjb25zdCBjaGFyICpjb25maWdfaWdub3JlX29wdGlvbnNb
XSA9IHsgImhlbHAiLCAiY29uZmlnIiwgInZlcnNpb24iIH07CisKKy8qCisgKiBWZXJzaW9uIGlu
Zm8gb24gc3RkZXJyCisgKi8KK3N0YXRpYyB2b2lkIHZlcnNpb24odm9pZCkKK3sKKwlmcHJpbnRm
KHN0ZGVyciwgIiVzIChMVFRuZyBUcmFjZSBDb250cm9sKSAiIFZFUlNJT04iIC0gIiBWRVJTSU9O
X05BTUUgIlxuIiwKKwkJcHJvZ25hbWUpOworfQogCiAvKgogICogVGFrZSBhbiBvcHRpb24gZnJv
bSB0aGUgZ2V0b3B0IG91dHB1dCBhbmQgc2V0IGl0IGluIHRoZSByaWdodCB2YXJpYWJsZSB0byBi
ZQpAQCAtMjU1LDYgKzI2NSw5IEBAIHN0YXRpYyBpbnQgc2V0X29wdGlvbihpbnQgb3B0LCBjb25z
dCBjaGFyICphcmcsIGNvbnN0IGNoYXIgKm9wdG5hbWUpCiAJCQlwZXJyb3IoImV4ZWMiKTsKIAkJ
fQogCQlleGl0KEVYSVRfRkFJTFVSRSk7CisJY2FzZSAnVic6CisJCXZlcnNpb24oKTsKKwkJZXhp
dChFWElUX0ZBSUxVUkUpOwogCWNhc2UgJ28nOgogCQlpZiAobHR0bmdfaXNfc2V0dWlkX3NldGdp
ZCgpKSB7CiAJCQlXQVJOKCJHZXR0aW5nICclcycgYXJndW1lbnQgZnJvbSBzZXR1aWQvc2V0Z2lk
IGJpbmFyeSByZWZ1c2VkIGZvciBzZWN1cml0eSByZWFzb25zLiIsCi0tIAoyLjEwLjAKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWls
aW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9y
Zy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
