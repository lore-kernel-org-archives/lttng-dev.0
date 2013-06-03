From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?=
	<jeremie.galarneau@efficios.com>
Subject: [PATCH lttng-ust] Fix: Check for invalid commands in
	print_cmd
Date: Mon,  3 Jun 2013 16:59:20 -0400
Message-ID: <1370293160-22212-1-git-send-email-jeremie.galarneau__44021.3774833412$1370293207$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vb0-f50.google.com ([209.85.212.50])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1Ujbqk-0001GK-Cj
	for lttng-dev@lists.lttng.org; Mon, 03 Jun 2013 16:59:30 -0400
Received: by mail-vb0-f50.google.com with SMTP id w16so896725vbb.37
	for <lttng-dev@lists.lttng.org>; Mon, 03 Jun 2013 13:59:24 -0700 (PDT)
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

Q29ycnVwdGVkICJ1c3Rjb21tX3VzdF9tc2ciIHJlY2VpdmVkIGJ5IHRoZSBsaXN0ZW5lciB0aHJl
YWQgY291bGQgY2F1c2UgYW4gb3V0Cm9mIGJvdW5kcyBhY2Nlc3MgdG8gdGhlIGNtZF9uYW1lX21h
cHBpbmcgYXJyYXkgaW4gdGhlIHRyYWNlZCBhcHBsaWNhdGlvbi4KCldoaWxlIHRoaXMgZG9lc24n
dCBmaXggdGhlIHJvb3QgY2F1c2Ugb2YgdGhlIHByb2JsZW0sIHRoaXMgY2hlY2sgc2hvdWxkIGJl
IHB1dAppbiBwbGFjZSBhbnl3YXkgc2luY2UgY29ycnVwdGVkIG1lc3NhZ2VzIGFyZSBub3QgY2hl
Y2tlZCBmb3IgYW5kIG1heSBicmluZyBkb3duCnRoZSB0cmFjZWUuCgpGaXhlcyAjNTU2CgpTaWdu
ZWQtb2ZmLWJ5OiBKw6lyw6ltaWUgR2FsYXJuZWF1IDxqZXJlbWllLmdhbGFybmVhdUBlZmZpY2lv
cy5jb20+Ci0tLQogbGlibHR0bmctdXN0L2x0dG5nLXVzdC1jb21tLmMgfCAzICsrLQogMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2xp
Ymx0dG5nLXVzdC9sdHRuZy11c3QtY29tbS5jIGIvbGlibHR0bmctdXN0L2x0dG5nLXVzdC1jb21t
LmMKaW5kZXggYWUyZTUxOC4uMWJlNjkzZiAxMDA2NDQKLS0tIGEvbGlibHR0bmctdXN0L2x0dG5n
LXVzdC1jb21tLmMKKysrIGIvbGlibHR0bmctdXN0L2x0dG5nLXVzdC1jb21tLmMKQEAgLTIwOCw4
ICsyMDgsOSBAQCBzdGF0aWMKIHZvaWQgcHJpbnRfY21kKGludCBjbWQsIGludCBoYW5kbGUpCiB7
CiAJY29uc3QgY2hhciAqY21kX25hbWUgPSAiVW5rbm93biI7CisJaW50IGNtZF9uYW1lX21hcHBp
bmdfbGVuID0gc2l6ZW9mKGNtZF9uYW1lX21hcHBpbmcpIC8gc2l6ZW9mKGNoYXIgKik7CiAKLQlp
ZiAoY21kX25hbWVfbWFwcGluZ1tjbWRdKSB7CisJaWYgKGNtZCA8IGNtZF9uYW1lX21hcHBpbmdf
bGVuICYmIGNtZF9uYW1lX21hcHBpbmdbY21kXSkgewogCQljbWRfbmFtZSA9IGNtZF9uYW1lX21h
cHBpbmdbY21kXTsKIAl9CiAJREJHKCJNZXNzYWdlIFJlY2VpdmVkIFwiJXNcIiwgSGFuZGxlIFwi
JXNcIiAoJWQpIiwgY21kX25hbWUsCi0tIAoxLjguMi4zCgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1k
ZXZAbGlzdHMubHR0bmcub3JnCmh0dHA6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFu
L2xpc3RpbmZvL2x0dG5nLWRldgo=
