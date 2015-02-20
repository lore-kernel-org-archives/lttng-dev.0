From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH babeltrace] Fix: test: add automake variable for
	test trace folders copy on oot build
Date: Fri, 20 Feb 2015 11:51:56 -0500
Message-ID: <1424451116-9722-1-git-send-email-jonathan.rajotte-julien__28098.8040882677$1424451198$gmane$org@efficios.com>
References: <54E759DD.3030506@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1YOqoV-0002jx-ID
 for lttng-dev@lists.lttng.org; Fri, 20 Feb 2015 11:52:28 -0500
In-Reply-To: <54E759DD.3030506@efficios.com>
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

Reported-by: Simon Marchi <simon.marchi@polymtl.ca>
Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 tests/Makefile.am | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/Makefile.am b/tests/Makefile.am
index 2e307f4..e474522 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -4,6 +4,8 @@ EXTRA_DIST = ctf-traces/** tests
 
 SCRIPT_LIST = run.sh
 
+TRACE_FOLDER = ctf-traces
+
 dist_noinst_SCRIPTS = $(SCRIPT_LIST)
 
 all-local:
@@ -11,6 +13,9 @@ all-local:
 		for script in $(SCRIPT_LIST); do \
 			cp -f $(srcdir)/$$script $(builddir); \
 		done; \
+		for script in $(TRACE_FOLDER); do \
+			cp -a $(srcdir)/$$script $(builddir); \
+		done; \
 	fi
 
 clean-local:
@@ -18,6 +23,9 @@ clean-local:
 		for script in $(SCRIPT_LIST); do \
 			rm -f $(builddir)/$$script; \
 		done; \
+		for script in $(TRACE_FOLDER); do \
+			rm -rf $(builddir)/$$script; \
+		done; \
 	fi
 
 check-am:
-- 
1.9.1
