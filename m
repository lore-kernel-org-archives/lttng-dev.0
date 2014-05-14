From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?=
 <jeremie.galarneau@efficios.com>
Subject: [PATCH lttng-tools] Fix: Copy-pasted PERROR messages
	may be misleading
Date: Wed, 14 May 2014 11:32:10 -0400
Message-ID: <1400081530-2950-1-git-send-email-jeremie.galarneau__5150.74582440338$1400081591$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1WkbAI-00029R-TU
 for lttng-dev@lists.lttng.org; Wed, 14 May 2014 11:32:21 -0400
Received: by mail-ig0-f180.google.com with SMTP id c1so1925045igq.13
 for <lttng-dev@lists.lttng.org>; Wed, 14 May 2014 08:32:13 -0700 (PDT)
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

U29tZSBQRVJST1JzIGluIGx0dG5nLXNlc3Npb25kJ3MgcHRocmVhZF9jcmVhdGUncyBlcnJvciBo
YW5kbGluZwpjb2RlIGluZGljYXRlIHRoZSB3cm9uZyB0aHJlYWQgbmFtZSB3aGljaCBtYXkgYmUg
bWlzbGVhZGluZwpkdXJpbmcgZGVidWdnaW5nLgoKU2lnbmVkLW9mZi1ieTogSsOpcsOpbWllIEdh
bGFybmVhdSA8amVyZW1pZS5nYWxhcm5lYXVAZWZmaWNpb3MuY29tPgotLS0KIHNyYy9iaW4vbHR0
bmctc2Vzc2lvbmQvbWFpbi5jIHwgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQv
bWFpbi5jIGIvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9tYWluLmMKaW5kZXggM2E4YTFiMi4uM2Zj
MjU2NSAxMDA2NDQKLS0tIGEvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9tYWluLmMKKysrIGIvc3Jj
L2Jpbi9sdHRuZy1zZXNzaW9uZC9tYWluLmMKQEAgLTUxOTAsNyArNTE5MCw3IEBAIGludCBtYWlu
KGludCBhcmdjLCBjaGFyICoqYXJndikKIAlyZXQgPSBwdGhyZWFkX2NyZWF0ZSgmYXBwc19ub3Rp
ZnlfdGhyZWFkLCBOVUxMLAogCQkJdXN0X3RocmVhZF9tYW5hZ2Vfbm90aWZ5LCAodm9pZCAqKSBO
VUxMKTsKIAlpZiAocmV0ICE9IDApIHsKLQkJUEVSUk9SKCJwdGhyZWFkX2NyZWF0ZSBhcHBzIik7
CisJCVBFUlJPUigicHRocmVhZF9jcmVhdGUgbm90aWZ5Iik7CiAJCWdvdG8gZXhpdF9hcHBzX25v
dGlmeTsKIAl9CiAKQEAgLTUxOTgsNyArNTE5OCw3IEBAIGludCBtYWluKGludCBhcmdjLCBjaGFy
ICoqYXJndikKIAlyZXQgPSBwdGhyZWFkX2NyZWF0ZSgmanVsX3JlZ190aHJlYWQsIE5VTEwsCiAJ
CQlqdWxfdGhyZWFkX21hbmFnZV9yZWdpc3RyYXRpb24sICh2b2lkICopIE5VTEwpOwogCWlmIChy
ZXQgIT0gMCkgewotCQlQRVJST1IoInB0aHJlYWRfY3JlYXRlIGFwcHMiKTsKKwkJUEVSUk9SKCJw
dGhyZWFkX2NyZWF0ZSBKVUwiKTsKIAkJZ290byBleGl0X2p1bF9yZWc7CiAJfQogCi0tIAoxLjku
MgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5n
LWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwOi8vbGlzdHMu
bHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
