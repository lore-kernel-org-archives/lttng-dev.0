From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [PATCH babeltrace] Fix: text output missing separator
	when printing the domain
Date: Fri, 17 Mar 2017 16:15:23 -0400
Message-ID: <1489781723-23942-1-git-send-email-jdesfossez__32195.9384171807$1489782232$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com (albert.ini-tech.com [192.99.4.57])
 by lists.lttng.org (Postfix) with ESMTPS id 3vlGyC4yf6zwD7
 for <lttng-dev@lists.lttng.org>; Fri, 17 Mar 2017 20:23:47 +0000 (UTC)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

V2l0aCB0aGUgIi1mIGFsbCIgb3B0aW9uLCB3ZSBleHBlY3QgdG8gc2VlCjxob3N0bmFtZT46PGRv
bWFpbj46PGxvZ2xldmVsPiwgYnV0IGluc3RlYWQgd2Ugc2VlCjxob3N0bmFtZT48ZG9tYWluPjo8
bG9nbGV2ZWw+LgoKSnVkZ2luZyBmcm9tIHRoZSBwYXR0ZXJuIG9mIHRoZSBvdGhlciBwcmludGVk
IGZpZWxkcywgdGhlIGNoZWNrIGZvcgoiZG9tX3ByaW50IiB2YXJpYWJsZSBzZWVtcyB0byBiZSBt
aXNzaW5nIHdoZW4gcHJpbnRpbmcgdGhlIGRvbWFpbi4KClNpZ25lZC1vZmYtYnk6IEp1bGllbiBE
ZXNmb3NzZXogPGpkZXNmb3NzZXpAZWZmaWNpb3MuY29tPgotLS0KIGZvcm1hdHMvY3RmLXRleHQv
Y3RmLXRleHQuYyB8IDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKCmRpZmYg
LS1naXQgYS9mb3JtYXRzL2N0Zi10ZXh0L2N0Zi10ZXh0LmMgYi9mb3JtYXRzL2N0Zi10ZXh0L2N0
Zi10ZXh0LmMKaW5kZXggZjYxNTE2MS4uNjk0NTBjZiAxMDA2NDQKLS0tIGEvZm9ybWF0cy9jdGYt
dGV4dC9jdGYtdGV4dC5jCisrKyBiL2Zvcm1hdHMvY3RmLXRleHQvY3RmLXRleHQuYwpAQCAtMzUw
LDYgKzM1MCw4IEBAIGludCBjdGZfdGV4dF93cml0ZV9ldmVudChzdHJ1Y3QgYnRfc3RyZWFtX3Bv
cyAqcHBvcywgc3RydWN0IGN0Zl9zdHJlYW1fZGVmaW5pdGlvCiAJCXNldF9maWVsZF9uYW1lc19w
cmludChwb3MsIElURU1fSEVBREVSKTsKIAkJaWYgKHBvcy0+cHJpbnRfbmFtZXMpIHsKIAkJCWZw
cmludGYocG9zLT5mcCwgInRyYWNlOmRvbWFpbiA9ICIpOworCQl9IGVsc2UgaWYgKGRvbV9wcmlu
dCkgeworCQkJZnByaW50Zihwb3MtPmZwLCAiOiIpOwogCQl9CiAJCWZwcmludGYocG9zLT5mcCwg
IiVzIiwgc3RyZWFtX2NsYXNzLT50cmFjZS0+ZW52LmRvbWFpbik7CiAJCWlmIChwb3MtPnByaW50
X25hbWVzKQotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9y
ZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmct
ZGV2Cg==
