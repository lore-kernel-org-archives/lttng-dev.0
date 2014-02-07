From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?=
	<jeremie.galarneau@efficios.com>
Subject: [PATCH lttng-tools] Fix: Define __STDC_LIMIT_MACROS to
	fix C++ builds
Date: Fri,  7 Feb 2014 18:32:21 -0500
Message-ID: <1391815941-30337-1-git-send-email-jeremie.galarneau__39991.6322007359$1391816013$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f51.google.com ([209.85.216.51])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1WBuuL-0003hJ-6L
	for lttng-dev@lists.lttng.org; Fri, 07 Feb 2014 18:32:34 -0500
Received: by mail-qa0-f51.google.com with SMTP id f11so6273317qae.38
	for <lttng-dev@lists.lttng.org>; Fri, 07 Feb 2014 15:32:23 -0800 (PST)
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

TmVjZXNzYXJ5IHRvIGluY2x1ZGUgdGhlIGZpeGVkLXdpZHRoIHR5cGUgbGltaXRzIG9uIGdsaWJj
IHZlcnNpb25zCm9sZGVyIHRoYW4gMi4xOCB3aGVuIGJ1aWxkaW5nIHdpdGggYSBDKysgY29tcGls
ZXIuCgpTaWduZWQtb2ZmLWJ5OiBKw6lyw6ltaWUgR2FsYXJuZWF1IDxqZXJlbWllLmdhbGFybmVh
dUBlZmZpY2lvcy5jb20+Ci0tLQogaW5jbHVkZS9sdHRuZy9sdHRuZy5oIHwgNiArKysrKysKIDEg
ZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2x0dG5n
L2x0dG5nLmggYi9pbmNsdWRlL2x0dG5nL2x0dG5nLmgKaW5kZXggMThkZWMyYS4uMmQ0MTBmYSAx
MDA2NDQKLS0tIGEvaW5jbHVkZS9sdHRuZy9sdHRuZy5oCisrKyBiL2luY2x1ZGUvbHR0bmcvbHR0
bmcuaApAQCAtMjMsNyArMjMsMTMgQEAKICNkZWZpbmUgTFRUTkdfSAogCiAjaW5jbHVkZSA8bGlt
aXRzLmg+CisvKgorICogTmVjZXNzYXJ5IHRvIGluY2x1ZGUgdGhlIGZpeGVkIHdpZHRoIHR5cGUg
bGltaXRzIG9uIGdsaWJjIHZlcnNpb25zIG9sZGVyCisgKiB0aGFuIDIuMTggd2hlbiBidWlsZGlu
ZyB3aXRoIGEgQysrIGNvbXBpbGVyLgorICovCisjZGVmaW5lIF9fU1REQ19MSU1JVF9NQUNST1MK
ICNpbmNsdWRlIDxzdGRpbnQuaD4KKyN1bmRlZiBfX1NURENfTElNSVRfTUFDUk9TCiAjaW5jbHVk
ZSA8c3lzL3R5cGVzLmg+CiAKIC8qIEVycm9yIGNvZGVzIHRoYXQgY2FuIGJlIHJldHVybmVkIGJ5
IEFQSSBjYWxscyAqLwotLSAKMS44LjUuMgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3Rz
Lmx0dG5nLm9yZwpodHRwOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5m
by9sdHRuZy1kZXYK
