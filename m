From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [PATCH lttng-tools] Fix: wrong use of the
	relay_streams_sent in snapshot
Date: Wed, 23 Aug 2017 16:43:54 -0400
Message-ID: <1503521034-3939-1-git-send-email-jdesfossez__31286.1164952212$1503521070$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com (albert.ini-tech.com [192.99.4.57])
 by lists.lttng.org (Postfix) with ESMTPS id 3xcztP0FRDzvD8
 for <lttng-dev@lists.lttng.org>; Wed, 23 Aug 2017 20:44:12 +0000 (UTC)
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

VGhlIHJlbGF5X3N0cmVhbXNfc2VudCBtZXNzYWdlIGlzIG9ubHkgdXNlZnVsIGluIGxpdmUgc2Vz
c2lvbnMgYW5kCnNob3VsZCBvbmx5IGJlIHNlbnQgYWZ0ZXIgYWxsIHRoZSBzdHJlYW1zIG9mIGEg
Y2hhbm5lbCBoYXZlIGJlZW4gc2VudC4KCkhlcmUgd2Ugd2VyZSBzZW5kaW5nIHRoaXMgbWVzc2Fn
ZSBldmVyeSB0aW1lIHdlIHNlbnQgYSBzdHJlYW0gdG8gdGhlCnJlbGF5IGR1cmluZyBhIHNuYXBz
aG90IHdoaWNoIG1ha2VzIG5vIHNlbnNlLgoKU2lnbmVkLW9mZi1ieTogSnVsaWVuIERlc2Zvc3Nl
eiA8amRlc2Zvc3NlekBlZmZpY2lvcy5jb20+Ci0tLQogc3JjL2NvbW1vbi9rZXJuZWwtY29uc3Vt
ZXIva2VybmVsLWNvbnN1bWVyLmMgfCA4IC0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgOCBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zcmMvY29tbW9uL2tlcm5lbC1jb25zdW1lci9rZXJuZWwt
Y29uc3VtZXIuYyBiL3NyYy9jb21tb24va2VybmVsLWNvbnN1bWVyL2tlcm5lbC1jb25zdW1lci5j
CmluZGV4IGE1ZGNjNjYuLjFjMjc1MWIgMTAwNjQ0Ci0tLSBhL3NyYy9jb21tb24va2VybmVsLWNv
bnN1bWVyL2tlcm5lbC1jb25zdW1lci5jCisrKyBiL3NyYy9jb21tb24va2VybmVsLWNvbnN1bWVy
L2tlcm5lbC1jb25zdW1lci5jCkBAIC0xODcsMTQgKzE4Nyw2IEBAIGludCBsdHRuZ19rY29uc3Vt
ZXJfc25hcHNob3RfY2hhbm5lbCh1aW50NjRfdCBrZXksIGNoYXIgKnBhdGgsCiAJCQlEQkcoIktl
cm5lbCBjb25zdW1lciBzbmFwc2hvdCBzdHJlYW0gJXMvJXMgKCUiIFBSSXU2NCAiKSIsCiAJCQkJ
CXBhdGgsIHN0cmVhbS0+bmFtZSwgc3RyZWFtLT5rZXkpOwogCQl9Ci0JCWlmIChyZWxheWRfaWQg
IT0gLTFVTEwpIHsKLQkJCXJldCA9IGNvbnN1bWVyX3NlbmRfcmVsYXlkX3N0cmVhbXNfc2VudChy
ZWxheWRfaWQpOwotCQkJaWYgKHJldCA8IDApIHsKLQkJCQlFUlIoInNlbmRpbmcgc3RyZWFtcyBz
ZW50IHRvIHJlbGF5ZCIpOwotCQkJCWdvdG8gZW5kX3VubG9jazsKLQkJCX0KLQkJCWNoYW5uZWwt
PnN0cmVhbXNfc2VudF90b19yZWxheWQgPSB0cnVlOwotCQl9CiAKIAkJcmV0ID0ga2VybmN0bF9i
dWZmZXJfZmx1c2hfZW1wdHkoc3RyZWFtLT53YWl0X2ZkKTsKIAkJaWYgKHJldCA8IDApIHsKLS0g
CjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwps
dHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9s
aXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
