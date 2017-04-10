From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules] RFC: Always build vmscan probe
Date: Mon, 10 Apr 2017 15:03:03 -0400
Message-ID: <1491850983-2984-1-git-send-email-mjeanson__19827.9184675359$1491851013$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3w202r5KLHzy9n
 for <lttng-dev@lists.lttng.org>; Mon, 10 Apr 2017 19:03:48 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 92AF53403AD
 for <lttng-dev@lists.lttng.org>; Mon, 10 Apr 2017 19:04:33 +0000 (UTC)
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

VGhlIG1tL3Ztc2Nhbi5jIGNvbXBpbGUgdW5pdCBpcyBhIG9iai15LCBldmVuIG9uIGFuIG9sZCAy
LjYuMzYga2VybmVsLAphbHdheXMgYnVpbGQgdGhlIHZtc2NhbiBwcm9iZSByZWdhcmRsZXNzIG9m
IGtlcm5lbCBjb25maWd1cmF0aW9uLgoKQ2xvc2VzOiAjMTQzCgpTaWduZWQtb2ZmLWJ5OiBNaWNo
YWVsIEplYW5zb24gPG1qZWFuc29uQGVmZmljaW9zLmNvbT4KLS0tCiBwcm9iZXMvS2J1aWxkIHwg
MTAgKy0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCA5IGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL3Byb2Jlcy9LYnVpbGQgYi9wcm9iZXMvS2J1aWxkCmluZGV4IDJh
ZmI2ZGQuLmJmMTRjNzUgMTAwNjQ0Ci0tLSBhL3Byb2Jlcy9LYnVpbGQKKysrIGIvcHJvYmVzL0ti
dWlsZApAQCAtMTQzLDE5ICsxNDMsMTEgQEAgaWZuZXEgKCQoQ09ORklHX1NDU0kpLCkKICAgICAg
IGVjaG8gImx0dG5nLXByb2JlLXNjc2kubyIgOyBmaTspCiBlbmRpZiAjIENPTkZJR19TQ1NJCiAK
LXZtc2NhbiA9ICQoc2hlbGwgXAorb2JqLSQoQ09ORklHX0xUVE5HKSArPSAkKHNoZWxsIFwKICAg
aWYgWyAkKFZFUlNJT04pIC1nZSAzIFwKICAgICAtbyBcKCAkKFZFUlNJT04pIC1lcSAyIC1hICQo
UEFUQ0hMRVZFTCkgLWVxIDYgLWEgJChTVUJMRVZFTCkgLWdlIDM2IFwpIF0gOyB0aGVuIFwKICAg
ICBlY2hvICJsdHRuZy1wcm9iZS12bXNjYW4ubyIgOyBmaTspCiAKLWlmbmVxICgkKENPTkZJR19T
V0FQKSwpCi0gIG9iai0kKENPTkZJR19MVFRORykgKz0gJCh2bXNjYW4pCi1lbHNlCi0gIGlmbmVx
ICgkKENPTkZJR19DR1JPVVBfTUVNX1JFU19DVExSKSwpCi0gICAgb2JqLSQoQ09ORklHX0xUVE5H
KSArPSAkKHZtc2NhbikKLSAgZW5kaWYgIyBDT05GSUdfQ0dST1VQX01FTV9SRVNfQ1RMUgotZW5k
aWYgIyBDT05GSUdfU1dBUAotCiAjIGxvY2sgcHJvYmUgZG9lcyBub3Qgd29yaywgc28gZGlzYWJs
aW5nIGl0IGZvciBub3cKICNpZm5lcSAoJChDT05GSUdfTE9DS0RFUCksKQogIyAgb2JqLSQoQ09O
RklHX0xUVE5HKSArPSBsdHRuZy1wcm9iZS1sb2NrLm8KLS0gCjIuNy40CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0
Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJp
bi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
