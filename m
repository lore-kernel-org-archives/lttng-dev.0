From: Anders Wallin <wallinux@gmail.com>
Subject: [PATCH lttng-tools] Tests: added test_autoload to
	noinst_SCRIPTS
Date: Thu, 26 Jul 2018 09:46:28 +0200
Message-ID: <20180726074628.4405-1-wallinux__15419.0854788341$1532591079$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com
 [IPv6:2a00:1450:4864:20::241])
 by lists.lttng.org (Postfix) with ESMTPS id 41bkgZ68qFztcG
 for <lttng-dev@lists.lttng.org>; Thu, 26 Jul 2018 03:46:34 -0400 (EDT)
Received: by mail-lj1-x241.google.com with SMTP id j19-v6so663733ljc.7
 for <lttng-dev@lists.lttng.org>; Thu, 26 Jul 2018 00:46:34 -0700 (PDT)
Received: from localhost.localdomain
 (host-95-199-31-103.mobileonline.telia.com. [95.199.31.103])
 by smtp.gmail.com with ESMTPSA id n23-v6sm105304ljh.77.2018.07.26.00.46.31
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 26 Jul 2018 00:46:31 -0700 (PDT)
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
List-Id: lttng-dev@lists.lttng.org

RnJvbTogQW5kZXJzIFdhbGxpbiA8YW5kZXJzLndhbGxpbkB3aW5kcml2ZXIuY29tPgoKU2lnbmVk
LW9mZi1ieTogQW5kZXJzIFdhbGxpbiA8d2FsbGludXhAZ21haWwuY29tPgotLS0KIHRlc3RzL3Jl
Z3Jlc3Npb24vdG9vbHMvc2F2ZS1sb2FkL01ha2VmaWxlLmFtIHwgMiArLQogMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvdGVzdHMvcmVn
cmVzc2lvbi90b29scy9zYXZlLWxvYWQvTWFrZWZpbGUuYW0gYi90ZXN0cy9yZWdyZXNzaW9uL3Rv
b2xzL3NhdmUtbG9hZC9NYWtlZmlsZS5hbQppbmRleCA1Y2Q2Nzc2Mi4uYTEwODAwMmQgMTAwNjQ0
Ci0tLSBhL3Rlc3RzL3JlZ3Jlc3Npb24vdG9vbHMvc2F2ZS1sb2FkL01ha2VmaWxlLmFtCisrKyBi
L3Rlc3RzL3JlZ3Jlc3Npb24vdG9vbHMvc2F2ZS1sb2FkL01ha2VmaWxlLmFtCkBAIC0xLDQgKzEs
NCBAQAotbm9pbnN0X1NDUklQVFMgPSB0ZXN0X3NhdmUgdGVzdF9sb2FkCitub2luc3RfU0NSSVBU
UyA9IHRlc3Rfc2F2ZSB0ZXN0X2xvYWQgdGVzdF9hdXRvbG9hZAogRVhUUkFfRElTVCA9ICQobm9p
bnN0X1NDUklQVFMpIGxvYWQtNDIubHR0bmcgbG9hZC00Mi1jb21wbGV4Lmx0dG5nIFwKIAlsb2Fk
LTQyLXRyYWNrZXJzLmx0dG5nCiAKLS0gCjIuMTguMAoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZA
bGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9s
aXN0aW5mby9sdHRuZy1kZXYK
