From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?=
 <jeremie.galarneau@efficios.com>
Subject: [PATCH lttng-tools] Fix: Tests should set the
	LTTNG_SESSION_CONFIG_XSD_PATH variable
Date: Wed, 14 May 2014 16:52:22 -0400
Message-ID: <1400100742-18018-1-git-send-email-jeremie.galarneau__41967.8309037865$1400100809$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1WkgAB-0004HZ-L0
 for lttng-dev@lists.lttng.org; Wed, 14 May 2014 16:52:37 -0400
Received: by mail-ig0-f169.google.com with SMTP id hl10so7652507igb.4
 for <lttng-dev@lists.lttng.org>; Wed, 14 May 2014 13:52:26 -0700 (PDT)
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

VGVzdHMgc2hvdWxkIHNldCB0aGUgTFRUTkdfU0VTU0lPTl9DT05GSUdfWFNEX1BBVEggZW52aXJv
bm1lbnQKdmFyaWFibGUgdG8gdXNlIHRoZSBpbi10cmVlIHNlc3Npb24gY29uZmlndXJhdGlvbiBz
Y2hlbWEuCgpTaWduZWQtb2ZmLWJ5OiBKw6lyw6ltaWUgR2FsYXJuZWF1IDxqZXJlbWllLmdhbGFy
bmVhdUBlZmZpY2lvcy5jb20+Ci0tLQogdGVzdHMvdXRpbHMvdXRpbHMuc2ggfCAyICsrCiAxIGZp
bGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGVzdHMvdXRpbHMvdXRp
bHMuc2ggYi90ZXN0cy91dGlscy91dGlscy5zaAppbmRleCBhMWEyNmQ5Li4yODBjYzQwIDEwMDY0
NAotLS0gYS90ZXN0cy91dGlscy91dGlscy5zaAorKysgYi90ZXN0cy91dGlscy91dGlscy5zaApA
QCAtMTY2LDYgKzE2Niw4IEBAIGZ1bmN0aW9uIHN0YXJ0X2x0dG5nX3Nlc3Npb25kKCkKIAlmaQog
CiAJRElSPSQocmVhZGxpbmsgLWYgJFRFU1RESVIpCisJOiAke0xUVE5HX1NFU1NJT05fQ09ORklH
X1hTRF9QQVRIPSR7RElSfS8uLi9zcmMvY29tbW9uL2NvbmZpZy99CisJZXhwb3J0IExUVE5HX1NF
U1NJT05fQ09ORklHX1hTRF9QQVRICiAKIAlpZiBbIC16ICQocGlkb2YgbHQtJFNFU1NJT05EX0JJ
TikgXTsgdGhlbgogCQkkRElSLy4uL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvJFNFU1NJT05EX0JJ
TiAtLWJhY2tncm91bmQgLS1jb25zdW1lcmQzMi1wYXRoPSIkRElSLy4uL3NyYy9iaW4vbHR0bmct
Y29uc3VtZXJkL2x0dG5nLWNvbnN1bWVyZCIgLS1jb25zdW1lcmQ2NC1wYXRoPSIkRElSLy4uL3Ny
Yy9iaW4vbHR0bmctY29uc3VtZXJkL2x0dG5nLWNvbnN1bWVyZCIKLS0gCjEuOS4yCgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxp
bmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHA6Ly9saXN0cy5sdHRuZy5vcmcv
Y2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
