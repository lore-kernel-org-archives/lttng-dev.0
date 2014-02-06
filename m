From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?=
	<jeremie.galarneau@efficios.com>
Subject: [PATCH lttng-tools] Add extern C to the health-check
	header
Date: Thu,  6 Feb 2014 14:13:56 -0500
Message-ID: <1391714036-14376-1-git-send-email-jeremie.galarneau__3399.26553792811$1391714099$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f47.google.com ([209.85.216.47])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1WBUOi-00073z-9F
	for lttng-dev@lists.lttng.org; Thu, 06 Feb 2014 14:14:09 -0500
Received: by mail-qa0-f47.google.com with SMTP id j5so3476579qaq.20
	for <lttng-dev@lists.lttng.org>; Thu, 06 Feb 2014 11:13:58 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

VGhpcyBtYWtlcyBpdCBwb3NzaWJsZSB0byBpbmNsdWRlIGhlYWx0aC5oIGluIGEgQysrIHByb2dy
YW0uCgpTaWduZWQtb2ZmLWJ5OiBKw6lyw6ltaWUgR2FsYXJuZWF1IDxqZXJlbWllLmdhbGFybmVh
dUBlZmZpY2lvcy5jb20+Ci0tLQogaW5jbHVkZS9sdHRuZy9oZWFsdGguaCB8IDggKysrKysrKysK
IDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2x0
dG5nL2hlYWx0aC5oIGIvaW5jbHVkZS9sdHRuZy9oZWFsdGguaAppbmRleCA5OTYwOTI4Li45YTdh
N2ZjIDEwMDY0NAotLS0gYS9pbmNsdWRlL2x0dG5nL2hlYWx0aC5oCisrKyBiL2luY2x1ZGUvbHR0
bmcvaGVhbHRoLmgKQEAgLTE5LDYgKzE5LDEwIEBACiAgKiBJbmMuLCA1MSBGcmFua2xpbiBTdHJl
ZXQsIEZpZnRoIEZsb29yLCBCb3N0b24sIE1BIDAyMTEwLTEzMDEgVVNBCiAgKi8KIAorI2lmZGVm
IF9fY3BsdXNwbHVzCitleHRlcm4gIkMiIHsKKyNlbmRpZgorCiBzdHJ1Y3QgbHR0bmdfaGVhbHRo
Owogc3RydWN0IGx0dG5nX2hlYWx0aF90aHJlYWQ7CiAKQEAgLTEyNCw0ICsxMjgsOCBAQCBpbnQg
bHR0bmdfaGVhbHRoX3RocmVhZF9zdGF0ZShjb25zdCBzdHJ1Y3QgbHR0bmdfaGVhbHRoX3RocmVh
ZCAqdGhyZWFkKTsKICAqLwogY29uc3QgY2hhciAqbHR0bmdfaGVhbHRoX3RocmVhZF9uYW1lKGNv
bnN0IHN0cnVjdCBsdHRuZ19oZWFsdGhfdGhyZWFkICp0aHJlYWQpOwogCisjaWZkZWYgX19jcGx1
c3BsdXMKK30KKyNlbmRpZgorCiAjZW5kaWYgLyogTFRUTkdfSEVBTFRIX0ggKi8KLS0gCjEuOC41
LjIKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRu
Zy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cDovL2xpc3Rz
Lmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
