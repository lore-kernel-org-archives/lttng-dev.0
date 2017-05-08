From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools 2/2] Assert on null index_file
Date: Mon,  8 May 2017 11:22:54 -0400
Message-ID: <20170508152254.13846-2-jonathan.rajotte-julien__42880.9978919618$1494257138$gmane$org@efficios.com>
References: <20170508152254.13846-1-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3wM5sM3lZBzCJH
 for <lttng-dev@lists.lttng.org>; Mon,  8 May 2017 15:24:55 +0000 (UTC)
In-Reply-To: <20170508152254.13846-1-jonathan.rajotte-julien@efficios.com>
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

U2lnbmVkLW9mZi1ieTogSm9uYXRoYW4gUmFqb3R0ZSA8am9uYXRoYW4ucmFqb3R0ZS1qdWxpZW5A
ZWZmaWNpb3MuY29tPgotLS0KIHNyYy9jb21tb24vaW5kZXgvaW5kZXguYyB8IDggKysrKysrLS0K
IDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvc3JjL2NvbW1vbi9pbmRleC9pbmRleC5jIGIvc3JjL2NvbW1vbi9pbmRleC9pbmRleC5j
CmluZGV4IGI0ODFiYWRiLi5jOTRlYzcwMSAxMDA2NDQKLS0tIGEvc3JjL2NvbW1vbi9pbmRleC9p
bmRleC5jCisrKyBiL3NyYy9jb21tb24vaW5kZXgvaW5kZXguYwpAQCAtMTI4LDEyICsxMjgsMTYg
QEAgZXJyb3I6CiBpbnQgbHR0bmdfaW5kZXhfZmlsZV93cml0ZShjb25zdCBzdHJ1Y3QgbHR0bmdf
aW5kZXhfZmlsZSAqaW5kZXhfZmlsZSwKIAkJY29uc3Qgc3RydWN0IGN0Zl9wYWNrZXRfaW5kZXgg
KmVsZW1lbnQpCiB7CisJaW50IGZkOworCXNpemVfdCBsZW47CiAJc3NpemVfdCByZXQ7Ci0JaW50
IGZkID0gaW5kZXhfZmlsZS0+ZmQ7Ci0Jc2l6ZV90IGxlbiA9IGluZGV4X2ZpbGUtPmVsZW1lbnRf
bGVuOwogCisJYXNzZXJ0KGluZGV4X2ZpbGUpOwogCWFzc2VydChlbGVtZW50KTsKIAorCWZkID0g
aW5kZXhfZmlsZS0+ZmQ7CisJbGVuID0gaW5kZXhfZmlsZS0+ZWxlbWVudF9sZW47CisKIAlpZiAo
ZmQgPCAwKSB7CiAJCWdvdG8gZXJyb3I7CiAJfQotLSAKMi4xMS4wCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0
dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9t
YWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
