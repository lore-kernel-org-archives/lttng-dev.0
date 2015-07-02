From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-tools] Doc: Update liburcu URL in README.md
Date: Thu,  2 Jul 2015 18:17:51 -0400
Message-ID: <1435875471-31171-1-git-send-email-mjeanson__4219.84263598478$1435875627$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mjeanson@efficios.com>) id 1ZAmoD-0006Y5-47
 for lttng-dev@lists.lttng.org; Thu, 02 Jul 2015 18:18:20 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 README.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/README.md b/README.md
index 716fb66..9a95e33 100644
--- a/README.md
+++ b/README.md
@@ -20,7 +20,7 @@ components:
     that, the kernel version may probably be older, but we can't provide
     any guarantee. Please let us know if you are able to go lower
     without any problems.
-  - **[`liburcu`](http://urcu.so/) >= 0.8.0**: userspace RCU library,
+  - **[`liburcu`](http://liburcu.org/) >= 0.8.0**: userspace RCU library,
     by Mathieu Desnoyers and Paul E. McKenney.
   - **`libpopt` >= 1.13**:  command line arguments parsing library.
     - Debian/Ubuntu package: `libpopt-dev`
-- 
1.9.1
