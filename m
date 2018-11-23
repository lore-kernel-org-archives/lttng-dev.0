From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH urcu 3/4] Add *.exe to gitignore for Cygwin
Date: Fri, 23 Nov 2018 15:27:06 -0500
Message-ID: <20181123202707.19851-3-mjeanson__41495.8324320198$1543004777$gmane$org@efficios.com>
References: <20181123202707.19851-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 431nt813yTzyD0
 for <lttng-dev@lists.lttng.org>; Fri, 23 Nov 2018 15:27:28 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 0E3DF9A080
 for <lttng-dev@lists.lttng.org>; Fri, 23 Nov 2018 15:27:22 -0500 (EST)
In-Reply-To: <20181123202707.19851-1-mjeanson@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org, mathieu.desnoyers@efficios.com
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index d02ed09..4daa824 100644
--- a/.gitignore
+++ b/.gitignore
@@ -76,6 +76,7 @@ tests/benchmark/test_urcu_wfcq_dynlink
 
 tests/benchmark/*.log
 *.so
+*.exe
 
 doc/examples/urcu-flavors/qsbr
 doc/examples/urcu-flavors/mb
-- 
2.17.1
