From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules] Fix: update kvm instrumentation
	for Ubuntu 3.13.0-144
Date: Fri, 23 Mar 2018 11:41:46 -0400
Message-ID: <1521819706-30382-1-git-send-email-mjeanson__12463.7787849226$1521819598$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 40777k0GWxzxR5
 for <lttng-dev@lists.lttng.org>; Fri, 23 Mar 2018 11:41:53 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id E5A66423DFE
 for <lttng-dev@lists.lttng.org>; Fri, 23 Mar 2018 11:41:52 -0400 (EDT)
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
LQogaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUva3ZtLmggfCAxICsKIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL2luc3RydW1lbnRhdGlvbi9l
dmVudHMvbHR0bmctbW9kdWxlL2t2bS5oIGIvaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1t
b2R1bGUva3ZtLmgKaW5kZXggOGY5YTEzMi4uODVhYThhNyAxMDA2NDQKLS0tIGEvaW5zdHJ1bWVu
dGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUva3ZtLmgKKysrIGIvaW5zdHJ1bWVudGF0aW9uL2V2
ZW50cy9sdHRuZy1tb2R1bGUva3ZtLmgKQEAgLTkxLDYgKzkxLDcgQEAgTFRUTkdfVFJBQ0VQT0lO
VF9FVkVOVChrdm1fYWNrX2lycSwKIAl8fCBMVFROR19LRVJORUxfUkFOR0UoNCw0LDExMiwgNCw1
LDApIFwKIAl8fCBMVFROR19LRVJORUxfUkFOR0UoNCwxLDUwLCA0LDIsMCkgXAogCXx8IExUVE5H
X0tFUk5FTF9SQU5HRSgzLDE2LDUyLCAzLDE3LDApIFwKKwl8fCBMVFROR19VQlVOVFVfS0VSTkVM
X1JBTkdFKDMsMTMsMTEsMTQ0LCAzLDE0LDAsMCkgXAogCXx8IExUVE5HX0tFUk5FTF9SQU5HRSgz
LDIsOTcsIDMsMywwKSBcCiAJfHwgTFRUTkdfREVCSUFOX0tFUk5FTF9SQU5HRSg0LDksNjUsMCwz
LDAsIDQsMTAsMCwwLDAsMCkgXAogCXx8IExUVE5HX0ZFRE9SQV9LRVJORUxfUkFOR0UoNCwxNCwx
MywzMDAsIDQsMTUsMCwwKSkKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0
cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3Rp
bmZvL2x0dG5nLWRldgo=
