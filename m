From: =?UTF-8?q?Rapha=C3=ABl=20Beamonte?= <raphael.beamonte@gmail.com>
Subject: [lttng-tools PATCH 1/5] Tests: add a check in
	test_utils_expand_path to avoid segfault if result is NULL
Date: Thu, 14 Nov 2013 19:58:31 -0500
Message-ID: <1384477115-18809-2-git-send-email-raphael.beamonte__12963.7263752103$1384477288$gmane$org@gmail.com>
References: <1517784416.67313.1384445660213.JavaMail.zimbra@efficios.com>
	<1384477115-18809-1-git-send-email-raphael.beamonte@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <raphael.beamonte@gmail.com>) id 1Vh7kI-0006B7-2I
	for lttng-dev@lists.lttng.org; Thu, 14 Nov 2013 19:58:55 -0500
Received: by mail-ie0-f174.google.com with SMTP id ar20so3865700iec.5
	for <lttng-dev@lists.lttng.org>; Thu, 14 Nov 2013 16:58:44 -0800 (PST)
In-Reply-To: <1384477115-18809-1-git-send-email-raphael.beamonte@gmail.com>
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
Y29tPgotLS0KIHRlc3RzL3VuaXQvdGVzdF91dGlsc19leHBhbmRfcGF0aC5jIHwgICAgMyArKy0K
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1n
aXQgYS90ZXN0cy91bml0L3Rlc3RfdXRpbHNfZXhwYW5kX3BhdGguYyBiL3Rlc3RzL3VuaXQvdGVz
dF91dGlsc19leHBhbmRfcGF0aC5jCmluZGV4IDI3YmZlOGYuLmI3OTc0NGIgMTAwNjQ0Ci0tLSBh
L3Rlc3RzL3VuaXQvdGVzdF91dGlsc19leHBhbmRfcGF0aC5jCisrKyBiL3Rlc3RzL3VuaXQvdGVz
dF91dGlsc19leHBhbmRfcGF0aC5jCkBAIC0xMzUsNyArMTM1LDggQEAgc3RhdGljIHZvaWQgdGVz
dF91dGlsc19leHBhbmRfcGF0aCh2b2lkKQogCQlzcHJpbnRmKG5hbWUsICJ2YWxpZCB0ZXN0IGNh
c2U6ICVzIiwgdmFsaWRfdGVzdHNfaW5wdXRzW2ldLmlucHV0KTsKIAogCQlyZXN1bHQgPSB1dGls
c19leHBhbmRfcGF0aCh2YWxpZF90ZXN0c19pbnB1dHNbaV0uaW5wdXQpOwotCQlvayhzdHJjbXAo
cmVzdWx0LCB2YWxpZF90ZXN0c19leHBlY3RlZF9yZXN1bHRzW2ldKSA9PSAwLCBuYW1lKTsKKwkJ
b2socmVzdWx0ICE9IE5VTEwgJiYKKwkJCQlzdHJjbXAocmVzdWx0LCB2YWxpZF90ZXN0c19leHBl
Y3RlZF9yZXN1bHRzW2ldKSA9PSAwLCBuYW1lKTsKIAogCQlmcmVlKHJlc3VsdCk7CiAJfQotLSAK
MS43LjEwLjQKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cDov
L2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
