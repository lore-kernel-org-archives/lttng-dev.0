From: =?UTF-8?q?Rapha=C3=ABl=20Beamonte?= <raphael.beamonte@gmail.com>
Subject: [lttng-tools PATCH] Add a git version line in LTTng
	versions compiled from git sources.
Date: Tue, 12 Mar 2013 22:07:50 -0400
Message-ID: <963e75cf2cdaa8ccf854f3d34932d5fc1f2c1103.1363140466.git.raphael.beamonte__10287.0060400621$1363140552$gmane$org@gmail.com>
References: <513FA045.401@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <raphael.beamonte@gmail.com>) id 1UFb76-0005eZ-VW
	for lttng-dev@lists.lttng.org; Tue, 12 Mar 2013 22:08:21 -0400
Received: by mail-ie0-f169.google.com with SMTP id 13so756714iea.14
	for <lttng-dev@lists.lttng.org>; Tue, 12 Mar 2013 19:08:13 -0700 (PDT)
In-Reply-To: <513FA045.401@efficios.com>
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

U2lnbmVkLW9mZi1ieTogUmFwaGHDq2wgQmVhbW9udGUgPHJhcGhhZWwuYmVhbW9udGVAZ21haWwu
Y29tPgotLS0KIHNyYy9iaW4vbHR0bmcvTWFrZWZpbGUuYW0gfCAgICA2ICsrKysrLQogc3JjL2Jp
bi9sdHRuZy9sdHRuZy5jICAgICB8ICAgIDYgKysrKystCiAyIGZpbGVzIGNoYW5nZWQsIDEwIGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc3JjL2Jpbi9sdHRuZy9N
YWtlZmlsZS5hbSBiL3NyYy9iaW4vbHR0bmcvTWFrZWZpbGUuYW0KaW5kZXggMjFlZWJhYi4uMWIx
MjE5YiAxMDA2NDQKLS0tIGEvc3JjL2Jpbi9sdHRuZy9NYWtlZmlsZS5hbQorKysgYi9zcmMvYmlu
L2x0dG5nL01ha2VmaWxlLmFtCkBAIC0xLDUgKzEsOSBAQAorZ2l0X3ZlcnNpb25fc3RyaW5nPSQk
KGdpdCBkZXNjcmliZSAtLWxvbmcgLS1hbGwgMj4vZGV2L251bGwpCitnaXRfdmVyc2lvbj0kJCh0
ZXN0IC1uICIke2dpdF92ZXJzaW9uX3N0cmluZ30iICYmIGVjaG8gIi1ER0lUX1ZFUlNJT049XCIk
e2dpdF92ZXJzaW9uX3N0cmluZ31cIiIpCisKIEFNX0NQUEZMQUdTID0gLUkkKHRvcF9zcmNkaXIp
L2luY2x1ZGUgLUkkKHRvcF9zcmNkaXIpL3NyYyBcCi0JCQkgIC1ESU5TVEFMTF9CSU5fUEFUSD1c
IiIkKGJpbmRpcikiXCIKKwkJCSAgLURJTlNUQUxMX0JJTl9QQVRIPVwiIiQoYmluZGlyKSJcIiBc
CisJCQkgICR7Z2l0X3ZlcnNpb259CiAKIGJpbl9QUk9HUkFNUyA9IGx0dG5nCiAKZGlmZiAtLWdp
dCBhL3NyYy9iaW4vbHR0bmcvbHR0bmcuYyBiL3NyYy9iaW4vbHR0bmcvbHR0bmcuYwppbmRleCA4
NTYyMTQ0Li4yOGY4ZmVjIDEwMDY0NAotLS0gYS9zcmMvYmluL2x0dG5nL2x0dG5nLmMKKysrIGIv
c3JjL2Jpbi9sdHRuZy9sdHRuZy5jCkBAIC04MSw3ICs4MSwxMSBAQCBzdGF0aWMgc3RydWN0IGNt
ZF9zdHJ1Y3QgY29tbWFuZHNbXSA9ICB7CiAKIHN0YXRpYyB2b2lkIHVzYWdlKEZJTEUgKm9mcCkK
IHsKLQlmcHJpbnRmKG9mcCwgIkxUVG5nIFRyYWNlIENvbnRyb2wgIiBWRVJTSU9OIiAtICIgVkVS
U0lPTl9OQU1FIlxuXG4iKTsKKwlmcHJpbnRmKG9mcCwgIkxUVG5nIFRyYWNlIENvbnRyb2wgIiBW
RVJTSU9OIiAtICIgVkVSU0lPTl9OQU1FIlxuIik7CisjaWZkZWYgR0lUX1ZFUlNJT04KKwlmcHJp
bnRmKG9mcCwgIkdpdCB2ZXJzaW9uOiAiIEdJVF9WRVJTSU9OIlxuIik7CisjZW5kaWYKKwlmcHJp
bnRmKG9mcCwgIlxuIik7CiAJZnByaW50ZihvZnAsICJ1c2FnZTogbHR0bmcgW09QVElPTlNdIDxD
T01NQU5EPiBbPEFSR1M+XVxuIik7CiAJZnByaW50ZihvZnAsICJcbiIpOwogCWZwcmludGYob2Zw
LCAiT3B0aW9uczpcbiIpOwotLSAKMS43LjEwLjQKCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBs
aXN0cy5sdHRuZy5vcmcKaHR0cDovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlz
dGluZm8vbHR0bmctZGV2Cg==
