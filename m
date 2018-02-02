From: Francis Deslauriers <francis.deslauriers@efficios.com>
Subject: [PATCH lttng-ust 5/8] Fix: missing enum removal from
	the enum hashtable
Date: Fri,  2 Feb 2018 14:48:08 -0500
Message-ID: <1517600891-23632-6-git-send-email-francis.deslauriers__7367.26764957911$1517600851$gmane$org@efficios.com>
References: <1517600891-23632-1-git-send-email-francis.deslauriers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3zY6x23639ztBM
 for <lttng-dev@lists.lttng.org>; Fri,  2 Feb 2018 19:48:38 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 6E32D3402D6
 for <lttng-dev@lists.lttng.org>; Fri,  2 Feb 2018 19:49:17 +0000 (UTC)
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
ZmZpY2lvcy5jb20+Ci0tLQogbGlibHR0bmctdXN0L2x0dG5nLWV2ZW50cy5jIHwgMSArCiAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9saWJsdHRuZy11c3QvbHR0
bmctZXZlbnRzLmMgYi9saWJsdHRuZy11c3QvbHR0bmctZXZlbnRzLmMKaW5kZXggZThkNDg1Ny4u
MmI2NzliNSAxMDA2NDQKLS0tIGEvbGlibHR0bmctdXN0L2x0dG5nLWV2ZW50cy5jCisrKyBiL2xp
Ymx0dG5nLXVzdC9sdHRuZy1ldmVudHMuYwpAQCAtOTkwLDYgKzk5MCw3IEBAIHN0YXRpYwogdm9p
ZCBfbHR0bmdfZW51bV9kZXN0cm95KHN0cnVjdCBsdHRuZ19lbnVtICpfZW51bSkKIHsKIAljZHNf
bGlzdF9kZWwoJl9lbnVtLT5ub2RlKTsKKwljZHNfaGxpc3RfZGVsKCZfZW51bS0+aGxpc3QpOwog
CWZyZWUoX2VudW0pOwogfQogCi0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlz
dHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0
aW5mby9sdHRuZy1kZXYK
