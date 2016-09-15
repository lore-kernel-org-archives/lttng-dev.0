From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH babeltrace 2/4] Cleanup: bt namespace for compat
	timegm
Date: Wed, 14 Sep 2016 20:32:28 -0400
Message-ID: <1473899550-30486-2-git-send-email-mjeanson__39851.6440218829$1473900060$gmane$org@efficios.com>
References: <1473899550-30486-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id DEE29A4053
 for <lttng-dev@lists.lttng.org>; Thu, 15 Sep 2016 00:41:37 +0000 (UTC)
In-Reply-To: <1473899550-30486-1-git-send-email-mjeanson@efficios.com>
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
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

U2lnbmVkLW9mZi1ieTogTWljaGFlbCBKZWFuc29uIDxtamVhbnNvbkBlZmZpY2lvcy5jb20+Ci0t
LQogY29udmVydGVyL2JhYmVsdHJhY2UtbG9nLmMgICAgICB8IDIgKy0KIGluY2x1ZGUvYmFiZWx0
cmFjZS9jb21wYXQvdXRjLmggfCA0ICsrLS0KIDIgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25z
KCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2NvbnZlcnRlci9iYWJlbHRyYWNlLWxv
Zy5jIGIvY29udmVydGVyL2JhYmVsdHJhY2UtbG9nLmMKaW5kZXggZGI3ZjYwZi4uOGNiMzVkMSAx
MDA2NDQKLS0tIGEvY29udmVydGVyL2JhYmVsdHJhY2UtbG9nLmMKKysrIGIvY29udmVydGVyL2Jh
YmVsdHJhY2UtbG9nLmMKQEAgLTIzMCw3ICsyMzAsNyBAQCB2b2lkIHdyaXRlX2V2ZW50X2hlYWRl
cihzdHJ1Y3QgY3RmX3N0cmVhbV9wb3MgKnBvcywgY2hhciAqbGluZSwKIAkJCXRpLnRtX21pbiA9
IG1pbjsKIAkJCXRpLnRtX3NlYyA9IHNlYzsKIAotCQkJZXBfc2VjID0gYmFiZWx0cmFjZV90aW1l
Z20oJnRpKTsKKwkJCWVwX3NlYyA9IGJ0X3RpbWVnbSgmdGkpOwogCQkJaWYgKGVwX3NlYyAhPSAo
dGltZV90KSAtMSkgewogCQkJCSp0cyA9ICh1aW50NjRfdCkgZXBfc2VjICogTlNFQ19QRVJfU0VD
CiAJCQkJCSsgKHVpbnQ2NF90KSBtc2VjICogTlNFQ19QRVJfTVNFQzsKZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvYmFiZWx0cmFjZS9jb21wYXQvdXRjLmggYi9pbmNsdWRlL2JhYmVsdHJhY2UvY29tcGF0
L3V0Yy5oCmluZGV4IGQ1OWQ4NTYuLmZkNDFmNjIgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvYmFiZWx0
cmFjZS9jb21wYXQvdXRjLmgKKysrIGIvaW5jbHVkZS9iYWJlbHRyYWNlL2NvbXBhdC91dGMuaApA
QCAtMjksNyArMjksNyBAQAogI2lmIGRlZmluZWQoX0JTRF9TT1VSQ0UpIHx8IGRlZmluZWQoX1NW
SURfU09VUkNFKQogCiBzdGF0aWMgaW5saW5lCi10aW1lX3QgYmFiZWx0cmFjZV90aW1lZ20oc3Ry
dWN0IHRtICp0bSkKK3RpbWVfdCBidF90aW1lZ20oc3RydWN0IHRtICp0bSkKIHsKIAlyZXR1cm4g
dGltZWdtKHRtKTsKIH0KQEAgLTQ3LDcgKzQ3LDcgQEAgdGltZV90IGJhYmVsdHJhY2VfdGltZWdt
KHN0cnVjdCB0bSAqdG0pCiAgKi8KIAogc3RhdGljIGlubGluZQotdGltZV90IGJhYmVsdHJhY2Vf
dGltZWdtKHN0cnVjdCB0bSAqdG0pCit0aW1lX3QgYnRfdGltZWdtKHN0cnVjdCB0bSAqdG0pCiB7
CiAJdGltZV90IHJldDsKIAljaGFyICp0ejsKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5n
LWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWls
bWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
