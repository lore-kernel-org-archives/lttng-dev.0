From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?=
 <jeremie.galarneau@efficios.com>
Subject: [RFC PATCH lttng-tools] Fix: Propagate socket timeouts
	on lttcomm_accept_inet_sock()
Date: Tue, 23 Sep 2014 17:46:32 -0400
Message-ID: <1411508792-32112-1-git-send-email-jeremie.galarneau__41051.1415372186$1411508855$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1XWXv0-0008TZ-5f
 for lttng-dev@lists.lttng.org; Tue, 23 Sep 2014 17:46:43 -0400
Received: by mail-qg0-f53.google.com with SMTP id e89so4753515qgf.12
 for <lttng-dev@lists.lttng.org>; Tue, 23 Sep 2014 14:46:36 -0700 (PDT)
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

RW5zdXJlIHRoYXQgc2VuZC9yZWN2IHRpbWVvdXRzIGFyZSBhcHBsaWVkIHRvIG5ldyBzb2NrZXRz
IGNyZWF0ZWQKZnJvbSBhIGx0dGNvbW1fYWNjZXB0X2luZXRfc29jaygpLgoKU2lnbmVkLW9mZi1i
eTogSsOpcsOpbWllIEdhbGFybmVhdSA8amVyZW1pZS5nYWxhcm5lYXVAZWZmaWNpb3MuY29tPgot
LS0KIHNyYy9jb21tb24vc2Vzc2lvbmQtY29tbS9pbmV0LmMgfCAxNCArKysrKysrKysrKysrKwog
MSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9zcmMvY29tbW9u
L3Nlc3Npb25kLWNvbW0vaW5ldC5jIGIvc3JjL2NvbW1vbi9zZXNzaW9uZC1jb21tL2luZXQuYwpp
bmRleCAyYzk1OWM1Li5jZjA2ZWNiIDEwMDY0NAotLS0gYS9zcmMvY29tbW9uL3Nlc3Npb25kLWNv
bW0vaW5ldC5jCisrKyBiL3NyYy9jb21tb24vc2Vzc2lvbmQtY29tbS9pbmV0LmMKQEAgLTI3NSw2
ICsyNzUsNyBAQCBzdHJ1Y3QgbHR0Y29tbV9zb2NrICpsdHRjb21tX2FjY2VwdF9pbmV0X3NvY2so
c3RydWN0IGx0dGNvbW1fc29jayAqc29jaykKIAlpbnQgbmV3X2ZkOwogCXNvY2tsZW5fdCBsZW47
CiAJc3RydWN0IGx0dGNvbW1fc29jayAqbmV3X3NvY2s7CisJdW5zaWduZWQgbG9uZyB0aW1lb3V0
OwogCiAJaWYgKHNvY2stPnByb3RvID09IExUVENPTU1fU09DS19VRFApIHsKIAkJLyoKQEAgLTI5
OCw2ICsyOTksMTkgQEAgc3RydWN0IGx0dGNvbW1fc29jayAqbHR0Y29tbV9hY2NlcHRfaW5ldF9z
b2NrKHN0cnVjdCBsdHRjb21tX3NvY2sgKnNvY2spCiAJCVBFUlJPUigiYWNjZXB0IGluZXQiKTsK
IAkJZ290byBlcnJvcjsKIAl9CisJdGltZW91dCA9IGx0dGNvbW1fZ2V0X25ldHdvcmtfdGltZW91
dCgpOworCWlmICh0aW1lb3V0KSB7CisJCWludCByZXQ7CisKKwkJcmV0ID0gbHR0Y29tbV9zZXRz
b2Nrb3B0X3Jjdl90aW1lb3V0KG5ld19mZCwgdGltZW91dCk7CisJCWlmIChyZXQpIHsKKwkJCWdv
dG8gZXJyb3I7CisJCX0KKwkJcmV0ID0gbHR0Y29tbV9zZXRzb2Nrb3B0X3NuZF90aW1lb3V0KG5l
d19mZCwgdGltZW91dCk7CisJCWlmIChyZXQpIHsKKwkJCWdvdG8gZXJyb3I7CisJCX0KKwl9CiAK
IAluZXdfc29jay0+ZmQgPSBuZXdfZmQ7CiAJbmV3X3NvY2stPm9wcyA9ICZpbmV0X29wczsKLS0g
CjIuMS4wCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHA6Ly9s
aXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
