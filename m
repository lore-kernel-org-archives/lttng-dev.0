From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: lttng-live: send HUP reply
	when per-PID streams are gone
Date: Tue,  2 May 2017 10:37:28 -0400
Message-ID: <1493735848-32743-1-git-send-email-mathieu.desnoyers__23915.6793490567$1493735869$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3wHP6L5cHFzDKc
 for <lttng-dev@lists.lttng.org>; Tue,  2 May 2017 14:38:18 +0000 (UTC)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Q3VycmVudGx5LCB0aGUgIkhVUCIgcmVwbHkgKGh1bmcgdXApIGlzIG9ubHkgc2VudCB3aGVuIGEg
c2Vzc2lvbiBkZXN0cm95CmlzIHBlcmZvcm1lZCBhbmQgYWxsIGRhdGEgaGFzIGJlZW4gc2VudC4g
SG93ZXZlciwgd2l0aCBwZXItcGlkIGJ1ZmZlcnMsCmFwcGxpY2F0aW9uIGNhbiBjb21lIGFuZCBn
byBkdXJpbmcgdGhlIHRyYWNpbmcgc2Vzc2lvbiwgc28gd2UgbmVlZCB0bwpzZW5kIHRoZSBIVVAg
cmVwbHkgZm9yIGVhY2ggaW5kaXZpZHVhbCBzdHJlYW0gdGhhdCBpcyBnb25lLgoKU2lnbmVkLW9m
Zi1ieTogTWF0aGlldSBEZXNub3llcnMgPG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbT4K
LS0tCiBzcmMvYmluL2x0dG5nLXJlbGF5ZC9saXZlLmMgfCA3ICsrKysrLS0KIDEgZmlsZSBjaGFu
Z2VkLCA1IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc3JjL2Jp
bi9sdHRuZy1yZWxheWQvbGl2ZS5jIGIvc3JjL2Jpbi9sdHRuZy1yZWxheWQvbGl2ZS5jCmluZGV4
IDllMTA4NWYuLjYxYWNhZmUgMTAwNjQ0Ci0tLSBhL3NyYy9iaW4vbHR0bmctcmVsYXlkL2xpdmUu
YworKysgYi9zcmMvYmluL2x0dG5nLXJlbGF5ZC9saXZlLmMKQEAgLTExNzQsMTAgKzExNzQsMTMg
QEAgc3RhdGljIGludCBjaGVja19pbmRleF9zdGF0dXMoc3RydWN0IHJlbGF5X3ZpZXdlcl9zdHJl
YW0gKnZzdHJlYW0sCiB7CiAJaW50IHJldDsKIAotCWlmICh0cmFjZS0+c2Vzc2lvbi0+Y29ubmVj
dGlvbl9jbG9zZWQKKwlpZiAoKHRyYWNlLT5zZXNzaW9uLT5jb25uZWN0aW9uX2Nsb3NlZCB8fCBy
c3RyZWFtLT5jbG9zZWQpCiAJCQkmJiByc3RyZWFtLT5pbmRleF9yZWNlaXZlZF9zZXFjb3VudAog
CQkJCT09IHZzdHJlYW0tPmluZGV4X3NlbnRfc2VxY291bnQpIHsKLQkJLyogTGFzdCBpbmRleCBz
ZW50IGFuZCBzZXNzaW9uIGNvbm5lY3Rpb24gaXMgY2xvc2VkLiAqLworCQkvKgorCQkgKiBMYXN0
IGluZGV4IHNlbnQgYW5kIHNlc3Npb24gY29ubmVjdGlvbiBvciByZWxheQorCQkgKiBzdHJlYW0g
YXJlIGNsb3NlZC4KKwkJICovCiAJCWluZGV4LT5zdGF0dXMgPSBodG9iZTMyKExUVE5HX1ZJRVdF
Ul9JTkRFWF9IVVApOwogCQlnb3RvIGh1cDsKIAl9IGVsc2UgaWYgKHJzdHJlYW0tPmJlYWNvbl90
c19lbmQgIT0gLTFVTEwgJiYKLS0gCjIuMS40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0
cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3Rp
bmZvL2x0dG5nLWRldgo=
