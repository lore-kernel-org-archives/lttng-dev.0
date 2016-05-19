From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 0/4] error.h message printing fixes
Date: Thu, 19 May 2016 11:57:41 -0400
Message-ID: <1463673465-26888-1-git-send-email-mathieu.desnoyers__10927.8657277629$1463673491$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id C4364A35BE
 for <lttng-dev@lists.lttng.org>; Thu, 19 May 2016 15:57:50 +0000 (UTC)
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

TWF0aGlldSBEZXNub3llcnMgKDQpOgogIEZpeDogYWRkIG1pc3Npbmcgc2VtaWNvbG9ucyBhZnRl
ciBNU0csIERCRywgRVJSIHByaW50IG1hY3JvcwogIEZpeDogY29kaW5nIHN0eWxlIGRvY3VtZW50
IGhhcyBlcnJvbmVvdXMgc2VtaWNvbG9uIGF0IGVuZCBvZiBtYWNybwogIFVwZGF0ZSBjb2Rpbmcg
c3R5bGUgZG9jdW1lbnQgZm9yIG1hY3JvIHN0eWxlCiAgQ2xlYW51cCBlcnJvci5oIF9fbHR0bmdf
cHJpbnQoKSB1c2VkIGZvciBtZXNzYWdlIHByaW50aW5nCgogQ29kaW5nU3R5bGUgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgIDIwICsrKysrLS0KIHNyYy9iaW4vbHR0bmcvY29tbWFuZHMvYWRk
X2NvbnRleHQuYyB8ICAgMiArLQogc3JjL2NvbW1vbi9jb25zdW1lci9jb25zdW1lci5jICAgICAg
IHwgICAyICstCiBzcmMvY29tbW9uL2Vycm9yLmggICAgICAgICAgICAgICAgICAgfCAxMTAgKysr
KysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0KIHNyYy9jb21tb24vcnVuYXMuYyAgICAg
ICAgICAgICAgICAgICB8ICAgMiArLQogNSBmaWxlcyBjaGFuZ2VkLCA5OCBpbnNlcnRpb25zKCsp
LCAzOCBkZWxldGlvbnMoLSkKCi0tIAoyLjEuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlz
dHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0
aW5mby9sdHRuZy1kZXYK
