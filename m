From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?=
	<jeremie.galarneau@efficios.com>
Subject: [PATCH lttng-tools v2] Fix: Define __STDC_LIMIT_MACROS
	to fix C++ builds
Date: Mon, 10 Feb 2014 11:04:22 -0500
Message-ID: <1392048262-17049-1-git-send-email-jeremie.galarneau__45486.2467282966$1392048480$gmane$org@efficios.com>
References: <2121067902.21017.1391874228506.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1WCtMH-0008Sd-QR
	for lttng-dev@lists.lttng.org; Mon, 10 Feb 2014 11:05:27 -0500
Received: by mail-qa0-f54.google.com with SMTP id i13so9847783qae.27
	for <lttng-dev@lists.lttng.org>; Mon, 10 Feb 2014 08:05:16 -0800 (PST)
In-Reply-To: <2121067902.21017.1391874228506.JavaMail.zimbra@efficios.com>
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
dUBlZmZpY2lvcy5jb20+Ci0tLQogaW5jbHVkZS9sdHRuZy9sdHRuZy5oIHwgMTAgKysrKysrKysr
KwogMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9pbmNsdWRl
L2x0dG5nL2x0dG5nLmggYi9pbmNsdWRlL2x0dG5nL2x0dG5nLmgKaW5kZXggMThkZWMyYS4uZjBi
ZTIyNCAxMDA2NDQKLS0tIGEvaW5jbHVkZS9sdHRuZy9sdHRuZy5oCisrKyBiL2luY2x1ZGUvbHR0
bmcvbHR0bmcuaApAQCAtMjMsNyArMjMsMTcgQEAKICNkZWZpbmUgTFRUTkdfSAogCiAjaW5jbHVk
ZSA8bGltaXRzLmg+CisvKgorICogTmVjZXNzYXJ5IHRvIGluY2x1ZGUgdGhlIGZpeGVkIHdpZHRo
IHR5cGUgbGltaXRzIG9uIGdsaWJjIHZlcnNpb25zIG9sZGVyCisgKiB0aGFuIDIuMTggd2hlbiBi
dWlsZGluZyB3aXRoIGEgQysrIGNvbXBpbGVyLgorICovCisjaWZuZGVmIF9fU1REQ19MSU1JVF9N
QUNST1MKKyNkZWZpbmUgX19TVERDX0xJTUlUX01BQ1JPUworI2luY2x1ZGUgPHN0ZGludC5oPgor
I3VuZGVmIF9fU1REQ19MSU1JVF9NQUNST1MKKyNlbHNlIC8qICNpZm5kZWYgX19TVERDX0xJTUlU
X01BQ1JPUyAqLwogI2luY2x1ZGUgPHN0ZGludC5oPgorI2VuZGlmIC8qICNlbHNlICNpZm5kZWYg
X19TVERDX0xJTUlUX01BQ1JPUyAqLwogI2luY2x1ZGUgPHN5cy90eXBlcy5oPgogCiAvKiBFcnJv
ciBjb2RlcyB0aGF0IGNhbiBiZSByZXR1cm5lZCBieSBBUEkgY2FsbHMgKi8KLS0gCjEuOC41LjQK
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1k
ZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cDovL2xpc3RzLmx0
dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
