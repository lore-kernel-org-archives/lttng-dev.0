From: Simon Marchi <simon.marchi@ericsson.com>
Subject: [PATCH lttng-tools] lttng-sessiond: auto-load
	lttng-probe-i2c module
Date: Tue, 4 Oct 2016 18:24:50 -0400
Message-ID: <20161004222450.8004-1-simon.marchi__29653.4097673886$1475620025$gmane$org@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from sessmg22.ericsson.net (sessmg22.ericsson.net [193.180.251.58])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 8C8C6A3D30
 for <lttng-dev@lists.lttng.org>; Tue,  4 Oct 2016 22:28:10 +0000 (UTC)
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
Cc: Simon Marchi <simon.marchi@ericsson.com>
List-Id: lttng-dev@lists.lttng.org

QXV0b21hdGljYWxseSBsb2FkIHRoZSBsdHRuZy1wcm9iZS1pMmMga2VybmVsIG1vZHVsZSwgd2hp
Y2ggd2FzIHJlY2VudGx5CmFkZGVkIGluIGx0dG5nLW1vZHVsZXMsIGFsb25nIHdpdGggdGhlIG90
aGVyIHByb2JlIG1vZHVsZXMuCgpTaWduZWQtb2ZmLWJ5OiBTaW1vbiBNYXJjaGkgPHNpbW9uLm1h
cmNoaUBlcmljc3Nvbi5jb20+Ci0tLQogc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9tb2Rwcm9iZS5j
IHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9zcmMv
YmluL2x0dG5nLXNlc3Npb25kL21vZHByb2JlLmMgYi9zcmMvYmluL2x0dG5nLXNlc3Npb25kL21v
ZHByb2JlLmMKaW5kZXggY2EwNDY3ZS4uZjU4ZjUwYyAxMDA2NDQKLS0tIGEvc3JjL2Jpbi9sdHRu
Zy1zZXNzaW9uZC9tb2Rwcm9iZS5jCisrKyBiL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvbW9kcHJv
YmUuYwpAQCAtNTcsNiArNTcsNyBAQCBzdHJ1Y3Qga2Vybl9tb2R1bGVzX3BhcmFtIGtlcm5fbW9k
dWxlc19wcm9iZXNfZGVmYXVsdFtdID0gewogCXsgImx0dG5nLXByb2JlLWV4dDMiIH0sCiAJeyAi
bHR0bmctcHJvYmUtZXh0NCIgfSwKIAl7ICJsdHRuZy1wcm9iZS1ncGlvIiB9LAorCXsgImx0dG5n
LXByb2JlLWkyYyIgfSwKIAl7ICJsdHRuZy1wcm9iZS1pcnEiIH0sCiAJeyAibHR0bmctcHJvYmUt
amJkIiB9LAogCXsgImx0dG5nLXByb2JlLWpiZDIiIH0sCi0tIAoyLjEwLjEKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxp
c3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2kt
YmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
