From: Sebastien Boisvert <sboisvert@gydle.com>
Subject: [PATCH userspace-rcu 2/2] Port: build shared libraries
	in Cygwin
Date: Wed, 1 Jun 2016 23:02:31 -0400
Message-ID: <574FA1C7.8040803__20470.9033635028$1464836575$gmane$org@gydle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.gydle.com (mail.gydle.com [64.18.173.180])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 543C3A35D7
 for <lttng-dev@lists.lttng.org>; Thu,  2 Jun 2016 03:02:33 +0000 (UTC)
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

TGluazogaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvcGlwZXJtYWlsL2x0dG5nLWRldi8yMDE2LU1h
eS8wMjYwODEuaHRtbApTaWduZWQtb2ZmLWJ5OiBTZWJhc3RpZW4gQm9pc3ZlcnQgPHNib2lzdmVy
dEBneWRsZS5jb20+Ci0tLQogTWFrZWZpbGUuYW0gIHwgMyArKysKIGNvbmZpZ3VyZS5hYyB8IDUg
KysrKysKIDIgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvTWFr
ZWZpbGUuYW0gYi9NYWtlZmlsZS5hbQppbmRleCA2NzJiZWVjLi44ZTI1ZmQ5IDEwMDY0NAotLS0g
YS9NYWtlZmlsZS5hbQorKysgYi9NYWtlZmlsZS5hbQpAQCAtOCw2ICs4LDkgQEAgQU1fTERGTEFH
Uz0tdmVyc2lvbi1pbmZvICQoVVJDVV9MSUJSQVJZX1ZFUlNJT04pCiBpZiAhTElCQ19JTkNMVURF
U19QVEhSRUFECiBBTV9MREZMQUdTKz0tbHB0aHJlYWQKIGVuZGlmCitpZiBVU0VfQ1lHV0lOCitB
TV9MREZMQUdTKz0tbm8tdW5kZWZpbmVkCitlbmRpZgogQU1fQ0ZMQUdTPS1XYWxsCgogU1VCRElS
UyA9IC4gZG9jIHRlc3RzCmRpZmYgLS1naXQgYS9jb25maWd1cmUuYWMgYi9jb25maWd1cmUuYWMK
aW5kZXggZmUxYzU1ZC4uYjMwOTZjNiAxMDA2NDQKLS0tIGEvY29uZmlndXJlLmFjCisrKyBiL2Nv
bmZpZ3VyZS5hYwpAQCAtMTM0LDYgKzEzNCwxMSBAQCBBU19DQVNFKFskaG9zdF0sWyotKi1saW51
eC1hbmRyb2lkZWFiaV0sCiAJW0FNX0NPTkRJVElPTkFMKFRBUkdFVF9JU19BTkRST0lELCBmYWxz
ZSldCiApCgorQVNfQ0FTRShbJGhvc3RdLFsqLWN5Z3dpbipdLAorCVtBTV9DT05ESVRJT05BTChV
U0VfQ1lHV0lOLCB0cnVlKV0sCisJW0FNX0NPTkRJVElPTkFMKFVTRV9DWUdXSU4sIGZhbHNlKV0K
KykKKwogQUNfU1VCU1QoQVJDSFRZUEUpCiBBQ19TVUJTVChTVUJBUkNIVFlQRSkKCi0tIAoyLjgu
MwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1k
ZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5s
dHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
