From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules stable-2.6] Backport from master
Date: Tue, 10 May 2016 09:36:59 -0400
Message-ID: <1462887420-30065-1-git-send-email-mjeanson__32248.6939527609$1462887451$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 02C5CA09C7
 for <lttng-dev@lists.lttng.org>; Tue, 10 May 2016 13:37:09 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id AF7F23403DD
 for <lttng-dev@lists.lttng.org>; Tue, 10 May 2016 13:37:08 +0000 (UTC)
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

SGVyZSBpcyBhIHBhdGNoIGZyb20gbWFzdGVyLCBiYWNrcG9ydGVkIHRvIHN0YWJsZS0yLjYuCgpN
YXRoaWV1IERlc25veWVycyAoMSk6CiAgRml4OiB4ODYga3ZtIG1tdXRyYWNlIGluc3RydW1lbnRh
dGlvbiBmb3Iga2VybmVsIDwgMy42CgogLi4uL2V2ZW50cy9sdHRuZy1tb2R1bGUvYXJjaC94ODYv
a3ZtL21tdXRyYWNlLmggICAgfCAyNiArKysrKysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hh
bmdlZCwgMjYgaW5zZXJ0aW9ucygrKQoKLS0gCjEuOS4xCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRl
dkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFu
L2xpc3RpbmZvL2x0dG5nLWRldgo=
