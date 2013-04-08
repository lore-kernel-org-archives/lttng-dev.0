From: Francis Deslauriers <fdeslaur@gmail.com>
Subject: [RFC-Patch 2/2] x86:Instruments page fault trace event
Date: Mon,  8 Apr 2013 01:19:18 -0400
Message-ID: <1365398358-23374-2-git-send-email-fdeslaur__5394.70523731342$1365404720$gmane$org@gmail.com>
References: <1365398358-23374-1-git-send-email-fdeslaur@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <fdeslaur@gmail.com>) id 1UP4Ub-0001iA-52
	for lttng-dev@lists.lttng.org; Mon, 08 Apr 2013 01:19:45 -0400
Received: by mail-qc0-f170.google.com with SMTP id d42so1128344qca.29
	for <lttng-dev@lists.lttng.org>; Sun, 07 Apr 2013 22:19:39 -0700 (PDT)
In-Reply-To: <1365398358-23374-1-git-send-email-fdeslaur@gmail.com>
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

U2lnbmVkLW9mZi1ieTogRnJhbmNpcyBEZXNsYXVyaWVycyA8ZmRlc2xhdXJAZ21haWwuY29tPgpS
ZXZpZXdlZC1ieTogUmFwaGHDq2wgQmVhbW9udGUgPHJhcGhhZWwuYmVhbW9udGVAcG9seW10bC5j
YT4KLS0tCiBhcmNoL3g4Ni9tbS9mYXVsdC5jIHwgICAgNSArKysrKwogMSBmaWxlIGNoYW5nZWQs
IDUgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2FyY2gveDg2L21tL2ZhdWx0LmMgYi9hcmNo
L3g4Ni9tbS9mYXVsdC5jCmluZGV4IDJiOTc1MjUuLmY0MWE1YTAgMTAwNjQ0Ci0tLSBhL2FyY2gv
eDg2L21tL2ZhdWx0LmMKKysrIGIvYXJjaC94ODYvbW0vZmF1bHQuYwpAQCAtMjAsNiArMjAsOSBA
QAogI2luY2x1ZGUgPGFzbS9maXhtYXAuaD4JCQkvKiBWU1lTQ0FMTF9TVEFSVAkJKi8KICNpbmNs
dWRlIDxhc20vY29udGV4dF90cmFja2luZy5oPgkvKiBleGNlcHRpb25fZW50ZXIoKSwgLi4uCSov
CiAKKyNkZWZpbmUgQ1JFQVRFX1RSQUNFX1BPSU5UUworI2luY2x1ZGUgPHRyYWNlL2V2ZW50cy9m
YXVsdC5oPgkJLyogdHJhY2VfcGFnZV9mYXVsdF8qKCksIC4uLgkqLworCiAvKgogICogUGFnZSBm
YXVsdCBlcnJvciBjb2RlIGJpdHM6CiAgKgpAQCAtMTE4Myw3ICsxMTg2LDkgQEAgZ29vZF9hcmVh
OgogCSAqIG1ha2Ugc3VyZSB3ZSBleGl0IGdyYWNlZnVsbHkgcmF0aGVyIHRoYW4gZW5kbGVzc2x5
IHJlZG8KIAkgKiB0aGUgZmF1bHQ6CiAJICovCisJdHJhY2VfcGFnZV9mYXVsdF9lbnRyeShyZWdz
LCBhZGRyZXNzLCB3cml0ZSk7CiAJZmF1bHQgPSBoYW5kbGVfbW1fZmF1bHQobW0sIHZtYSwgYWRk
cmVzcywgZmxhZ3MpOworCXRyYWNlX3BhZ2VfZmF1bHRfZXhpdChmYXVsdCk7CiAKIAlpZiAodW5s
aWtlbHkoZmF1bHQgJiAoVk1fRkFVTFRfUkVUUll8Vk1fRkFVTFRfRVJST1IpKSkgewogCQlpZiAo
bW1fZmF1bHRfZXJyb3IocmVncywgZXJyb3JfY29kZSwgYWRkcmVzcywgZmF1bHQpKQotLSAKMS43
LjEwLjQKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwps
dHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cDovL2xp
c3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
