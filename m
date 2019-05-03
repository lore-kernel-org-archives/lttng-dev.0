From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 4/9] Fix: test: utils.sh: exit from
 process on full_cleanup
Date: Fri,  3 May 2019 09:55:42 -0400
Message-ID: <20190503135547.12968-5-mathieu.desnoyers__27707.5421226741$1556910764$gmane$org@efficios.com>
References: <20190503135547.12968-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44wYZC3dB1z1Kbm
 for <lttng-dev@lists.lttng.org>; Fri,  3 May 2019 09:56:03 -0400 (EDT)
In-Reply-To: <20190503135547.12968-1-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: jgalar@efficios.com, joraj@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tests/utils/utils.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/utils/utils.sh b/tests/utils/utils.sh
index b8ac88c1..42e78d25 100644
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
2.11.0
