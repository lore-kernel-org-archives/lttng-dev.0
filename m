From: Francis Deslauriers <francis.deslauriers@efficios.com>
Subject: [PATCH lttng-ust 2/8] Fix: missing event removal from
	the event hashtable
Date: Fri,  2 Feb 2018 14:48:05 -0500
Message-ID: <1517600891-23632-3-git-send-email-francis.deslauriers__41665.3049098842$1517600878$gmane$org@efficios.com>
References: <1517600891-23632-1-git-send-email-francis.deslauriers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3zY6x23fh8ztBQ
 for <lttng-dev@lists.lttng.org>; Fri,  2 Feb 2018 19:48:38 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id E67F534030E
 for <lttng-dev@lists.lttng.org>; Fri,  2 Feb 2018 19:49:16 +0000 (UTC)
In-Reply-To: <1517600891-23632-1-git-send-email-francis.deslauriers@efficios.com>
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

U2lnbmVkLW9mZi1ieTogRnJhbmNpcyBEZXNsYXVyaWVycyA8ZnJhbmNpcy5kZXNsYXVyaWVyc0Bl
ZmZpY2lvcy5jb20+Ci0tLQogbGlibHR0bmctdXN0L2x0dG5nLWV2ZW50cy5jIHwgNCArKysrCiAx
IGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvbGlibHR0bmctdXN0
L2x0dG5nLWV2ZW50cy5jIGIvbGlibHR0bmctdXN0L2x0dG5nLWV2ZW50cy5jCmluZGV4IGY0YTdj
Y2MuLjc0MTlmNzggMTAwNjQ0Ci0tLSBhL2xpYmx0dG5nLXVzdC9sdHRuZy1ldmVudHMuYworKysg
Yi9saWJsdHRuZy11c3QvbHR0bmctZXZlbnRzLmMKQEAgLTg4Myw3ICs4ODMsMTEgQEAgdm9pZCBf
bHR0bmdfZXZlbnRfZGVzdHJveShzdHJ1Y3QgbHR0bmdfZXZlbnQgKmV2ZW50KQogewogCXN0cnVj
dCBsdHRuZ19lbmFibGVyX3JlZiAqZW5hYmxlcl9yZWYsICp0bXBfZW5hYmxlcl9yZWY7CiAKKwkv
KiBSZW1vdmUgZnJvbSBldmVudCBsaXN0LiAqLwogCWNkc19saXN0X2RlbCgmZXZlbnQtPm5vZGUp
OworCS8qIFJlbW92ZSBmcm9tIGV2ZW50IGhhc2ggdGFibGUuICovCisJY2RzX2hsaXN0X2RlbCgm
ZXZlbnQtPmhsaXN0KTsKKwogCWx0dG5nX2Rlc3Ryb3lfY29udGV4dChldmVudC0+Y3R4KTsKIAls
dHRuZ19mcmVlX2V2ZW50X2ZpbHRlcl9ydW50aW1lKGV2ZW50KTsKIAkvKiBGcmVlIGV2ZW50IGVu
YWJsZXIgcmVmcyAqLwotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0
dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8v
bHR0bmctZGV2Cg==
