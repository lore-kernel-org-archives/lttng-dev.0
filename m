From: =?UTF-8?q?Rapha=C3=ABl=20Beamonte?= <raphael.beamonte@gmail.com>
Subject: [lttng-tools PATCH 0/5] utils_expand_path fix
Date: Sat, 23 Nov 2013 17:32:23 -0500
Message-ID: <1385245948-23011-1-git-send-email-raphael.beamonte__14290.1759049439$1385246128$gmane$org@gmail.com>
References: <20131115154539.GA6986@thessa>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <raphael.beamonte@gmail.com>) id 1VkLkq-0004uD-Ag
	for lttng-dev@lists.lttng.org; Sat, 23 Nov 2013 17:32:50 -0500
Received: by mail-ie0-f173.google.com with SMTP id to1so4425395ieb.4
	for <lttng-dev@lists.lttng.org>; Sat, 23 Nov 2013 14:32:38 -0800 (PST)
In-Reply-To: <20131115154539.GA6986@thessa>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: =?UTF-8?q?Rapha=C3=ABl=20Beamonte?= <raphael.beamonte@gmail.com>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

SGVsbG8gRGF2aWQhCgpIZXJlIGlzIHRoZSBmaXggbmVlZGVkIHRvIGhhdmUgdGhlIGV4cGVjdGVk
IGJlaGF2aW9yIGZvciBwYXRoIHRoYXQKZW5kcyB3aXRoICcvLicgb3IgJy8uLicuIEkgYWxzbyBw
cm9maXQgdG8gc2VuZCBwYXRjaGVzIGZvciB0aGUgdW5pdAp0ZXN0IHRvIGFsbG93IHRvIGFkZCB0
ZXN0cyB1c2luZyBhbiBleGlzdGluZyB0cmVlIGFuZCBzeW1saW5rcywKYWRkaW5nIHRoZSBtaXNz
aW5nIGNvcHlyaWdodCBpbiB1dGlscy5jIGFuZCBjb3JyZWN0aW5nIHRoZSBpbmRlbnRhdGlvbgpv
ZiBvbmUgY29tbWVudC4KCldhaXRpbmcgZm9yIHlvdXIgY29tbWVudHMhCgpUaGFua3MsClJhcGhh
w6tsCgoKUmFwaGHDq2wgQmVhbW9udGUgKDUpOgogIEFkZCBtaXNzaW5nIGNvcHlyaWdodCB0byB1
dGlscy5jCiAgRml4OiBjb21tZW50IGluZGVudGF0aW9uCiAgRml4OiB1dGlsc19leHBhbmRfcGF0
aCBub3cgd29ya3MgZm9yIHBhdGhzIHRoYXQgZW5kcyB3aXRoICcvLicgb3IKICAgICcvLi4nCiAg
VGVzdHM6IGFkZCBzeW1saW5rIHRlc3RzIGZvciB0ZXN0X3V0aWxzX2V4cGFuZF9wYXRoCiAgVGVz
dHM6IGFkZCB2YWxpZCB0ZXN0IGNhc2VzIHRvIHRlc3RfdXRpbHNfZXhwYW5kX3BhdGgKCiBzcmMv
Y29tbW9uL3V0aWxzLmMgICAgICAgICAgICAgICAgICB8ICAgMzAgKysrKystCiB0ZXN0cy91bml0
L3Rlc3RfdXRpbHNfZXhwYW5kX3BhdGguYyB8ICAxNzUgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKy0KIDIgZmlsZXMgY2hhbmdlZCwgMTk5IGluc2VydGlvbnMoKyksIDYgZGVsZXRp
b25zKC0pCgotLSAKMS43LjEwLjQKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRu
Zy5vcmcKaHR0cDovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0
bmctZGV2Cg==
