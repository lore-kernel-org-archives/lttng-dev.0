From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules stable-2.6 2/2] Fix: Ubuntu kernel
	range for mm_page_alloc_extfrag
Date: Thu,  5 May 2016 16:57:53 -0400
Message-ID: <1462481873-703-3-git-send-email-mjeanson__15587.1633593508$1462481908$gmane$org@efficios.com>
References: <1462481873-703-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 0B92CA33DF
 for <lttng-dev@lists.lttng.org>; Thu,  5 May 2016 20:58:07 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id DD0CC3403A2
 for <lttng-dev@lists.lttng.org>; Thu,  5 May 2016 20:58:06 +0000 (UTC)
In-Reply-To: <1462481873-703-1-git-send-email-mjeanson@efficios.com>
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

U2lnbmVkLW9mZi1ieTogTWljaGFlbCBKZWFuc29uIDxtamVhbnNvbkBlZmZpY2lvcy5jb20+ClNp
Z25lZC1vZmYtYnk6IE1hdGhpZXUgRGVzbm95ZXJzIDxtYXRoaWV1LmRlc25veWVyc0BlZmZpY2lv
cy5jb20+Ci0tLQogaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUva21lbS5oIHwg
MiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZm
IC0tZ2l0IGEvaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUva21lbS5oIGIvaW5z
dHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUva21lbS5oCmluZGV4IDE3MWZjYjkuLjAx
MTVhZmUgMTAwNjQ0Ci0tLSBhL2luc3RydW1lbnRhdGlvbi9ldmVudHMvbHR0bmctbW9kdWxlL2tt
ZW0uaAorKysgYi9pbnN0cnVtZW50YXRpb24vZXZlbnRzL2x0dG5nLW1vZHVsZS9rbWVtLmgKQEAg
LTI5MSw3ICsyOTEsNyBAQCBMVFROR19UUkFDRVBPSU5UX0VWRU5UX0lOU1RBTkNFX1BSSU5UKG1t
X3BhZ2UsIG1tX3BhZ2VfcGNwdV9kcmFpbiwKIAl8fCBMVFROR19LRVJORUxfUkFOR0UoMywxOCwx
MCwgMywxOSwwKQkJXAogCXx8IExUVE5HX0RFQklBTl9LRVJORUxfUkFOR0UoMywxNiw3LDksMCww
LCAzLDE3LDAsMCwwLDApCVwKIAl8fCBMVFROR19VQlVOVFVfS0VSTkVMX1JBTkdFKDMsMTMsMTEs
NTAsIDMsMTQsMCwwKQlcCi0JfHwgTFRUTkdfVUJVTlRVX0tFUk5FTF9SQU5HRSgzLDE2LDcsMzgs
IDMsMTcsMCwwKSkKKwl8fCBMVFROR19VQlVOVFVfS0VSTkVMX1JBTkdFKDMsMTYsNywzNCwgMywx
NywwLDApKQogCiBMVFROR19UUkFDRVBPSU5UX0VWRU5UKG1tX3BhZ2VfYWxsb2NfZXh0ZnJhZywK
IAotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRw
czovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
