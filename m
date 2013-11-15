From: =?UTF-8?q?Rapha=C3=ABl=20Beamonte?= <raphael.beamonte@gmail.com>
Subject: [lttng-tools PATCH 2/5] Tests: move invalid tests in
	test_utils_expand_path that should be valid
Date: Thu, 14 Nov 2013 19:58:32 -0500
Message-ID: <1384477115-18809-3-git-send-email-raphael.beamonte__5023.75206347114$1384477433$gmane$org@gmail.com>
References: <1517784416.67313.1384445660213.JavaMail.zimbra@efficios.com>
	<1384477115-18809-1-git-send-email-raphael.beamonte@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <raphael.beamonte@gmail.com>) id 1Vh7kJ-0006BB-0e
	for lttng-dev@lists.lttng.org; Thu, 14 Nov 2013 19:58:59 -0500
Received: by mail-ie0-f176.google.com with SMTP id x13so3683206ief.7
	for <lttng-dev@lists.lttng.org>; Thu, 14 Nov 2013 16:58:45 -0800 (PST)
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
Y29tPgotLS0KIHRlc3RzL3VuaXQvdGVzdF91dGlsc19leHBhbmRfcGF0aC5jIHwgICAgNCArKy0t
CiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL3Rlc3RzL3VuaXQvdGVzdF91dGlsc19leHBhbmRfcGF0aC5jIGIvdGVzdHMvdW5pdC90
ZXN0X3V0aWxzX2V4cGFuZF9wYXRoLmMKaW5kZXggYjc5NzQ0Yi4uYmI0NjBhMiAxMDA2NDQKLS0t
IGEvdGVzdHMvdW5pdC90ZXN0X3V0aWxzX2V4cGFuZF9wYXRoLmMKKysrIGIvdGVzdHMvdW5pdC90
ZXN0X3V0aWxzX2V4cGFuZF9wYXRoLmMKQEAgLTU1LDYgKzU1LDggQEAgc3RhdGljIHN0cnVjdCB2
YWxpZF90ZXN0X2lucHV0IHZhbGlkX3Rlc3RzX2lucHV0c1tdID0gewogCXsgIi4uIiwJCQkJIi4u
IiwJCSIiCQl9LAogCXsgIi4vIiwJCQkJIi4iLAkJIi8iCQl9LAogCXsgIi4iLAkJCQkiLiIsCQki
IgkJfSwKKwl7ICIvLi4vYS9iL2MvZC9lIiwJCSIiLAkJIi9hL2IvYy9kL2UiCX0sCisJeyAiL2Ev
Yi9jL2QvLi4vLi4vLi4vLi4vLi4vZSIsCSIiLAkJIi9lIgkJfSwKIH07CiBjaGFyICoqdmFsaWRf
dGVzdHNfZXhwZWN0ZWRfcmVzdWx0czsKIHN0YXRpYyBjb25zdCBpbnQgbnVtX3ZhbGlkX3Rlc3Rz
ID0KQEAgLTYzLDggKzY1LDYgQEAgc3RhdGljIGNvbnN0IGludCBudW1fdmFsaWRfdGVzdHMgPQog
LyogSW52YWxpZCB0ZXN0IGNhc2VzICovCiBzdGF0aWMgY2hhciAqaW52YWxpZF90ZXN0c19pbnB1
dHNbXSA9IHsKIAlOVUxMLAotCSIvLi4vYS9iL2MvZC9lIiwKLQkiL2EvYi9jL2QvLi4vLi4vLi4v
Li4vLi4vZSIsCiB9Owogc3RhdGljIGNvbnN0IGludCBudW1faW52YWxpZF90ZXN0cyA9CiAJCXNp
emVvZihpbnZhbGlkX3Rlc3RzX2lucHV0cykgLyBzaXplb2YoaW52YWxpZF90ZXN0c19pbnB1dHNb
MF0pOwotLSAKMS43LjEwLjQKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5v
cmcKaHR0cDovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmct
ZGV2Cg==
