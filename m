From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: [PATCH babeltrace] Fix running tests out of tree
Date: Sat, 14 Feb 2015 13:49:38 -0500
Message-ID: <1423939778-1788-1-git-send-email-simon.marchi__27528.6120399416$1423939848$gmane$org@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.electronicbox.net ([96.127.255.82])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <simon.marchi@polymtl.ca>) id 1YMhmj-0002Vk-3Q
 for lttng-dev@lists.lttng.org; Sat, 14 Feb 2015 13:49:47 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

When building out of tree, make check fails because the "tests" file is
not found.

Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
---
 tests/Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/Makefile.am b/tests/Makefile.am
index 8d84b16..2e307f4 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -21,4 +21,4 @@ clean-local:
 	fi
 
 check-am:
-	./run.sh tests
+	./run.sh $(srcdir)/tests
-- 
2.3.0
