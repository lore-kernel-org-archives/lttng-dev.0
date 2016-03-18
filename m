From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools] Fix: Use get_domain_str on add
	context
Date: Fri, 18 Mar 2016 18:44:45 -0400
Message-ID: <1458341085-4054-1-git-send-email-jonathan.rajotte-julien__11546.5634073646$1458341225$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id F2620A2D68
 for <lttng-dev@lists.lttng.org>; Fri, 18 Mar 2016 22:46:41 +0000 (UTC)
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

Rml4ZXMgIzEwMDYKClNpZ25lZC1vZmYtYnk6IEpvbmF0aGFuIFJham90dGUgPGpvbmF0aGFuLnJh
am90dGUtanVsaWVuQGVmZmljaW9zLmNvbT4KLS0tCiBzcmMvYmluL2x0dG5nL2NvbW1hbmRzL2Fk
ZF9jb250ZXh0LmMgfCA0ICsrLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc3JjL2Jpbi9sdHRuZy9jb21tYW5kcy9hZGRfY29u
dGV4dC5jIGIvc3JjL2Jpbi9sdHRuZy9jb21tYW5kcy9hZGRfY29udGV4dC5jCmluZGV4IGE2ZDcz
YTAuLmY3N2VkYjEgMTAwNjQ0Ci0tLSBhL3NyYy9iaW4vbHR0bmcvY29tbWFuZHMvYWRkX2NvbnRl
eHQuYworKysgYi9zcmMvYmluL2x0dG5nL2NvbW1hbmRzL2FkZF9jb250ZXh0LmMKQEAgLTY2MSwx
MSArNjYxLDExIEBAIHN0YXRpYyBpbnQgYWRkX2NvbnRleHQoY2hhciAqc2Vzc2lvbl9uYW1lKQog
CQl9IGVsc2UgewogCQkJaWYgKG9wdF9jaGFubmVsX25hbWUpIHsKIAkJCQlNU0coIiVzIGNvbnRl
eHQgJXMgYWRkZWQgdG8gY2hhbm5lbCAlcyIsCi0JCQkJCQlvcHRfa2VybmVsID8gImtlcm5lbCIg
OiAiVVNUIiwgdHlwZS0+b3B0LT5zeW1ib2wsCisJCQkJCQlnZXRfZG9tYWluX3N0cihkb20udHlw
ZSksIHR5cGUtPm9wdC0+c3ltYm9sLAogCQkJCQkJb3B0X2NoYW5uZWxfbmFtZSk7CiAJCQl9IGVs
c2UgewogCQkJCU1TRygiJXMgY29udGV4dCAlcyBhZGRlZCB0byBhbGwgY2hhbm5lbHMiLAotCQkJ
CQkJb3B0X2tlcm5lbCA/ICJrZXJuZWwiIDogIlVTVCIsIHR5cGUtPm9wdC0+c3ltYm9sKQorCQkJ
CQkJZ2V0X2RvbWFpbl9zdHIoZG9tLnR5cGUpLCB0eXBlLT5vcHQtPnN5bWJvbCkKIAkJCX0KIAkJ
CXN1Y2Nlc3MgPSAxOwogCQl9Ci0tIAoyLjcuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlz
dHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0
aW5mby9sdHRuZy1kZXYK
