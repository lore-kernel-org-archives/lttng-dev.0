From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools] Add missing optional dependency to
	babeltrace in README
Date: Fri,  7 Feb 2014 12:43:38 -0500
Message-ID: <1391795018-691-1-git-send-email-christian.babeux__35965.0662205697$1391795107$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1WBpT6-0000wV-1s
	for lttng-dev@lists.lttng.org; Fri, 07 Feb 2014 12:44:05 -0500
Received: by mail-qa0-f43.google.com with SMTP id o15so5713050qap.2
	for <lttng-dev@lists.lttng.org>; Fri, 07 Feb 2014 09:43:54 -0800 (PST)
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

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 README | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/README b/README
index 3b5ae2e..4d70318 100644
--- a/README
+++ b/README
@@ -36,6 +36,11 @@ REQUIREMENTS:
 
       * Debian/Ubuntu package: uuid-dev
 
+    - Babeltrace (optional)
+      Trace viewer. Enable the use of "lttng view" command
+
+      * Debian/Ubuntu package: babeltrace
+
     - Perl (optional)
       Needed for make check and tests.
 
-- 
1.8.5.2
