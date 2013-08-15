From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools] Fix: Snapshot should be taken asap
	in core handler script
Date: Thu, 15 Aug 2013 13:03:36 -0400
Message-ID: <1376586216-14065-1-git-send-email-christian.babeux__30736.2352883958$1376586289$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qe0-f45.google.com ([209.85.128.45])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1VA0xj-0006a3-8L
	for lttng-dev@lists.lttng.org; Thu, 15 Aug 2013 13:03:56 -0400
Received: by mail-qe0-f45.google.com with SMTP id x7so601772qeu.4
	for <lttng-dev@lists.lttng.org>; Thu, 15 Aug 2013 10:03:45 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Taking a snapshot should be the first thing the core handler does.
An enormous core file write to disk could potentially discard a lot
of tracing data if done before the snapshot.

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 extras/core-handler/handler.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/extras/core-handler/handler.sh b/extras/core-handler/handler.sh
index 7817282..c2d2402 100755
--- a/extras/core-handler/handler.sh
+++ b/extras/core-handler/handler.sh
@@ -29,6 +29,12 @@ SESSION_NAME="coredump-handler"
 # Sessiond binary name.
 SESSIOND_BIN_NAME="lttng-sessiond"
 
+# TODO: Checking for a sessiond lockfile would be more appropriate.
+if $PGREP_BIN -u root "${SESSIOND_BIN_NAME}" > /dev/null 2>&1
+then
+    $LTTNG_BIN snapshot record -s ${SESSION_NAME} > /dev/null 2>&1
+fi
+
 # Core file settings.
 CORE_PATH="/tmp/lttng/core"
 CORE_PREFIX="core"
@@ -54,9 +60,3 @@ $CAT_BIN - > "${CORE_PATH}/${CORE_PREFIX}.$p"
 
 # Optional, chain core dump handler with original systemd script.
 #$CAT_BIN - | /usr/lib/systemd/systemd-coredump $p $u $g $s $t $e
-
-# TODO: Checking for a sessiond lockfile would be more appropriate.
-if $PGREP_BIN -u root "${SESSIOND_BIN_NAME}" > /dev/null 2>&1
-then
-    $LTTNG_BIN snapshot record -s ${SESSION_NAME} > /dev/null 2>&1
-fi
-- 
1.8.3.3
