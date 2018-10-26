From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules] Fix: update kvm instrumentation
 for SLES12 SP2 LTSS >= 4.4.121-92.92
Date: Fri, 26 Oct 2018 18:01:17 -0400
Message-ID: <20181026220117.10706-1-mjeanson__30420.2321487994$1540591183$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 42hdHj3TMjzk5w
 for <lttng-dev@lists.lttng.org>; Fri, 26 Oct 2018 18:01:36 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 6EC97246990
 for <lttng-dev@lists.lttng.org>; Fri, 26 Oct 2018 18:01:30 -0400 (EDT)
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

U2lnbmVkLW9mZi1ieTogTWljaGFlbCBKZWFuc29uIDxtamVhbnNvbkBlZmZpY2lvcy5jb20+Ci0t
LQogaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUva3ZtLmggfCAzICsrLQogMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBh
L2luc3RydW1lbnRhdGlvbi9ldmVudHMvbHR0bmctbW9kdWxlL2t2bS5oIGIvaW5zdHJ1bWVudGF0
aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUva3ZtLmgKaW5kZXggODg3ZmU2Zi4uZjRiZWU2OSAxMDA2
NDQKLS0tIGEvaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUva3ZtLmgKKysrIGIv
aW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUva3ZtLmgKQEAgLTg1LDcgKzg1LDgg
QEAgTFRUTkdfVFJBQ0VQT0lOVF9FVkVOVChrdm1fYWNrX2lycSwKIAl7IEtWTV9UUkFDRV9NTUlP
X1dSSVRFLCAid3JpdGUiIH0KIAogCi0jaWYgKExUVE5HX1NMRV9LRVJORUxfUkFOR0UoNCw0LDEz
MSw5NCwwLDAsIDQsNSwwLDAsMCwwKSkKKyNpZiAoTFRUTkdfU0xFX0tFUk5FTF9SQU5HRSg0LDQs
MTIxLDkyLDkyLDAsIDQsNCwxMjIsMCwwLDApIFwKKwl8fCBMVFROR19TTEVfS0VSTkVMX1JBTkdF
KDQsNCwxMzEsOTQsMCwwLCA0LDUsMCwwLDAsMCkpCiAKIExUVE5HX1RSQUNFUE9JTlRfRVZFTlQo
a3ZtX21taW8sCiAJVFBfUFJPVE8oaW50IHR5cGUsIGludCBsZW4sIHU2NCBncGEsIHU2NCB2YWwp
LAotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0
cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
