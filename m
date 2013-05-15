From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?=
	<jeremie.galarneau@efficios.com>
Subject: [PATCH lttng-tools] Tests: Remove temporary trace
	directory on bail-out
Date: Wed, 15 May 2013 15:21:13 -0400
Message-ID: <1368645673-24342-1-git-send-email-jeremie.galarneau__44389.1023206108$1368645712$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vc0-f179.google.com ([209.85.220.179])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1UchGL-0008CJ-SN
	for lttng-dev@lists.lttng.org; Wed, 15 May 2013 15:21:22 -0400
Received: by mail-vc0-f179.google.com with SMTP id hz11so1189223vcb.10
	for <lttng-dev@lists.lttng.org>; Wed, 15 May 2013 12:21:16 -0700 (PDT)
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

U2lnbmVkLW9mZi1ieTogSsOpcsOpbWllIEdhbGFybmVhdSA8amVyZW1pZS5nYWxhcm5lYXVAZWZm
aWNpb3MuY29tPgotLS0KIHRlc3RzL3V0aWxzL3Rlc3RfdXRpbHMucHkgfCA0ICsrLS0KIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
dGVzdHMvdXRpbHMvdGVzdF91dGlscy5weSBiL3Rlc3RzL3V0aWxzL3Rlc3RfdXRpbHMucHkKaW5k
ZXggNWUwMGRlNC4uNGIzODYzMCAxMDA2NDQKLS0tIGEvdGVzdHMvdXRpbHMvdGVzdF91dGlscy5w
eQorKysgYi90ZXN0cy91dGlscy90ZXN0X3V0aWxzLnB5CkBAIC00OCw4ICs0OCw4IEBAIGRlZiBi
YWlsKGRpYWcsIHNlc3Npb25faW5mbyA9IE5vbmUpOgogICAgIGlmIHNlc3Npb25faW5mbyBpcyBu
b3QgTm9uZToKICAgICAgICAgc3RvcF9zZXNzaW9uKHNlc3Npb25faW5mbywgVHJ1ZSkKIAotICAg
ICAgICBpZiBvcy5wYXRoLmV4aXN0cyhzZXNzaW9uX2luZm8udHJhY2VfcGF0aCk6Ci0gICAgICAg
ICAgICBzaHV0aWwucm10cmVlKHNlc3Npb25faW5mby50cmFjZV9wYXRoKQorICAgICAgICBpZiBv
cy5wYXRoLmV4aXN0cyhzZXNzaW9uX2luZm8udG1wX2RpcmVjdG9yeSk6CisgICAgICAgICAgICBz
aHV0aWwucm10cmVlKHNlc3Npb25faW5mby50bXBfZGlyZWN0b3J5KQogICAgIGV4aXQoLTEpCiAK
IGRlZiBwcmludF90ZXN0X3Jlc3VsdChyZXN1bHQsIG51bWJlciwgZGVzY3JpcHRpb24pOgotLSAK
MS44LjIuMgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Cmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwOi8v
bGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
