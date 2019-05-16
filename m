From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 4/6] Fix: test: utils.sh: exit from
 process on full_cleanup
Date: Thu, 16 May 2019 15:07:59 -0400
Message-ID: <20190516190801.16878-4-mathieu.desnoyers__11614.495264233$1558033763$gmane$org@efficios.com>
References: <20190516190801.16878-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 454gtH6mmlzypP
 for <lttng-dev@lists.lttng.org>; Thu, 16 May 2019 15:08:07 -0400 (EDT)
In-Reply-To: <20190516190801.16878-1-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: joraj@efficios.com, jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tests/utils/utils.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/utils/utils.sh b/tests/utils/utils.sh
index 53964027..ad3088d6 100644
--- a/tests/utils/utils.sh
+++ b/tests/utils/utils.sh
@@ -66,6 +66,7 @@ function full_cleanup ()
 	# The '-' before the pid number ($$) indicates 'kill' to signal the
 	# whole process group.
 	trap - SIGTERM && kill -- -$$
+	exit 1
 }
 
 function null_pipes ()
-- 
2.17.1
