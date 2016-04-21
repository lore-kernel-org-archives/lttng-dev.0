From: =?UTF-8?q?Rapha=C3=ABl=20Beamonte?= <raphael.beamonte@gmail.com>
Subject: [RFC PATCH 1/2] Add -ust to the name of UST threads of
	the application
Date: Thu, 21 Apr 2016 16:50:32 -0400
Message-ID: <0b9164b53c42d51798ee886f33479cee6d6576bd.1461269886.git.raphael.beamonte__16375.787187326$1461271871$gmane$org@gmail.com>
References: <cover.1461269886.git.raphael.beamonte@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f65.google.com (mail-qg0-f65.google.com
 [209.85.192.65])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 0D585A325F
 for <lttng-dev@lists.lttng.org>; Thu, 21 Apr 2016 20:50:42 +0000 (UTC)
Received: by mail-qg0-f65.google.com with SMTP id 7so8236383qgj.0
 for <lttng-dev@lists.lttng.org>; Thu, 21 Apr 2016 13:50:41 -0700 (PDT)
In-Reply-To: <cover.1461269886.git.raphael.beamonte@gmail.com>
In-Reply-To: <cover.1461269886.git.raphael.beamonte@gmail.com>
References: <cover.1461269886.git.raphael.beamonte@gmail.com>
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
Cc: =?UTF-8?q?Rapha=C3=ABl=20Beamonte?= <raphael.beamonte@gmail.com>
List-Id: lttng-dev@lists.lttng.org

QWRkIHRoZSByZXF1aXJlZCBmdW5jdGlvbnMgdG8gY2hhbmdlIHRoZSB0aHJlYWQgbmFtZSBvZiB0
aGUgVVNUCnRocmVhZHMgYW5kIGFkZCB0aGUgLXVzdCBzdHJpbmcgYXQgaXRzIGVuZC4gVGhpcyB3
aWxsIGhlbHAgdG8KaWRlbnRpZnkgTFRUbmctVVNUIHByb2Nlc3NlcyB3aGVuIGFuYWx5emluZyB0
aGUgdHJhY2Ugb2YgYSBwcm9jZXNzLgoKU2lnbmVkLW9mZi1ieTogUmFwaGHDq2wgQmVhbW9udGUg
PHJhcGhhZWwuYmVhbW9udGVAZ21haWwuY29tPgotLS0KIGxpYmx0dG5nLXVzdC9jb21wYXQuaCAg
ICAgICAgIHwgMjIgKysrKysrKysrKysrKysrKysrKysrKwogbGlibHR0bmctdXN0L2x0dG5nLXVz
dC1jb21tLmMgfCAgMiArKwogMiBmaWxlcyBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspCgpkaWZm
IC0tZ2l0IGEvbGlibHR0bmctdXN0L2NvbXBhdC5oIGIvbGlibHR0bmctdXN0L2NvbXBhdC5oCmlu
ZGV4IDQzYjIyMjMuLjhkNWZjNzcgMTAwNjQ0Ci0tLSBhL2xpYmx0dG5nLXVzdC9jb21wYXQuaAor
KysgYi9saWJsdHRuZy11c3QvY29tcGF0LmgKQEAgLTM0LDYgKzM0LDIzIEBAIHZvaWQgbHR0bmdf
dXN0X2dldHByb2NuYW1lKGNoYXIgKm5hbWUpCiAJKHZvaWQpIHByY3RsKFBSX0dFVF9OQU1FLCAo
dW5zaWduZWQgbG9uZykgbmFtZSwgMCwgMCwgMCk7CiB9CiAKK3N0YXRpYyBpbmxpbmUKK3ZvaWQg
bHR0bmdfdXN0X3NldHVzdHByb2NuYW1lKCkKK3sKKwljaGFyIG5hbWVbTFRUTkdfVVNUX1BST0NO
QU1FX0xFTl07CisJaW50IGxpbWl0ID0gTFRUTkdfVVNUX1BST0NOQU1FX0xFTiAtIDQ7CisKKwls
dHRuZ191c3RfZ2V0cHJvY25hbWUobmFtZSk7CisKKwlpZiAoc3RybGVuKG5hbWUpID49IGxpbWl0
KSB7CisJCW5hbWVbbGltaXRdID0gMDsKKwl9CisKKwlzcHJpbnRmKG5hbWUsICIlcyVzIiwgbmFt
ZSwgIi11c3QiKTsKKworCSh2b2lkKSBwcmN0bChQUl9TRVRfTkFNRSwgbmFtZSwgMCwgMCwgMCk7
Cit9CisKICNlbGlmIGRlZmluZWQoX19GcmVlQlNEX18pCiAjaW5jbHVkZSA8c3RkbGliLmg+CiAj
aW5jbHVkZSA8c3RyaW5nLmg+CkBAIC01OSw2ICs3NiwxMSBAQCB2b2lkIGx0dG5nX3VzdF9nZXRw
cm9jbmFtZShjaGFyICpuYW1lKQogCQlzdHJuY3B5KG5hbWUsIGJzZF9uYW1lLCBMVFROR19VU1Rf
UFJPQ05BTUVfTEVOIC0gMSk7CiB9CiAKK3N0YXRpYyBpbmxpbmUKK3ZvaWQgbHR0bmdfdXN0X3Nl
dHVzdHByb2NuYW1lKCkKK3sKK30KKwogI2VuZGlmCiAKICNpbmNsdWRlIDxlcnJuby5oPgpkaWZm
IC0tZ2l0IGEvbGlibHR0bmctdXN0L2x0dG5nLXVzdC1jb21tLmMgYi9saWJsdHRuZy11c3QvbHR0
bmctdXN0LWNvbW0uYwppbmRleCBlMDBhMjJjLi5hODVjYjIxIDEwMDY0NAotLS0gYS9saWJsdHRu
Zy11c3QvbHR0bmctdXN0LWNvbW0uYworKysgYi9saWJsdHRuZy11c3QvbHR0bmctdXN0LWNvbW0u
YwpAQCAtMTI5NSw2ICsxMjk1LDggQEAgdm9pZCAqdXN0X2xpc3RlbmVyX3RocmVhZCh2b2lkICph
cmcpCiAJaW50IHNvY2ssIHJldCwgcHJldl9jb25uZWN0X2ZhaWxlZCA9IDAsIGhhc193YWl0ZWQg
PSAwOwogCWxvbmcgdGltZW91dDsKIAorCWx0dG5nX3VzdF9zZXR1c3Rwcm9jbmFtZSgpOworCiAJ
LyogUmVzdGFydCB0cnlpbmcgdG8gY29ubmVjdCB0byB0aGUgc2Vzc2lvbiBkYWVtb24gKi8KIHJl
c3RhcnQ6CiAJaWYgKHByZXZfY29ubmVjdF9mYWlsZWQpIHsKLS0gCjIuMS40CgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBs
aXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dp
LWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
