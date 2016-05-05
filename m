From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules stable-2.6 0/2] Fix Ubuntu kernels
Date: Thu,  5 May 2016 16:57:51 -0400
Message-ID: <1462481873-703-1-git-send-email-mjeanson__35155.5766923868$1462481908$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 1BF43A063F
 for <lttng-dev@lists.lttng.org>; Thu,  5 May 2016 20:58:01 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id D5995340343
 for <lttng-dev@lists.lttng.org>; Thu,  5 May 2016 20:58:00 +0000 (UTC)
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

SGVyZSBhcmUgMiBwYXRjaGVzIGJhY2twb3J0ZWQgZnJvbSBtYXN0ZXIgdG8gc3RhYmxlLTIuNiB0
byBmaXggdGhlCmJ1aWxkIG9uIFVidW50dSBrZXJuZWxzLgoKTWF0aGlldSBEZXNub3llcnMgKDEp
OgogIEZpeDogdXBkYXRlIHNjaGVkIGluc3RydW1lbnRhdGlvbiBmb3Iga2VybmVsIDQuNC4wCgpN
aWNoYWVsIEplYW5zb24gKDEpOgogIEZpeDogVWJ1bnR1IGtlcm5lbCByYW5nZSBmb3IgbW1fcGFn
ZV9hbGxvY19leHRmcmFnCgogaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUva21l
bS5oICB8ICAyICstCiBpbnN0cnVtZW50YXRpb24vZXZlbnRzL2x0dG5nLW1vZHVsZS9zY2hlZC5o
IHwgMjggKysrKysrKysrKysrKysrKysrKysrKysrKy0tLQogMiBmaWxlcyBjaGFuZ2VkLCAyNiBp
bnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0
dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9t
YWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
