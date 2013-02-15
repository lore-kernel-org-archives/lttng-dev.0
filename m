From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [BABELTRACE PATCH 1/7] Namespace compliance for
	dependencies function
Date: Fri, 15 Feb 2013 12:22:50 -0500
Message-ID: <1360948976-14999-1-git-send-email-jdesfossez__28502.9795057655$1360949039$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1U6P05-0003vI-Oc
	for lttng-dev@lists.lttng.org; Fri, 15 Feb 2013 12:23:06 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Use the bt_ prefix instead of babeltrace_

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 formats/ctf/callbacks.c            |    6 +++---
 include/babeltrace/ctf/callbacks.h |    4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/formats/ctf/callbacks.c b/formats/ctf/callbacks.c
index 71e3248..793f3d3 100644
--- a/formats/ctf/callbacks.c
+++ b/formats/ctf/callbacks.c
@@ -38,7 +38,7 @@
 #include <inttypes.h>
 
 static
-struct bt_dependencies *_babeltrace_dependencies_create(const char *first,
+struct bt_dependencies *_bt_dependencies_create(const char *first,
 							va_list ap)
 {
 	const char *iter;
@@ -56,13 +56,13 @@ struct bt_dependencies *_babeltrace_dependencies_create(const char *first,
 	return dep;
 }
 
-struct bt_dependencies *babeltrace_dependencies_create(const char *first, ...)
+struct bt_dependencies *bt_dependencies_create(const char *first, ...)
 {
 	va_list ap;
 	struct bt_dependencies *deps;
 
 	va_start(ap, first);
-	deps = _babeltrace_dependencies_create(first, ap);
+	deps = _bt_dependencies_create(first, ap);
 	va_end(ap);
 	return deps;
 }
diff --git a/include/babeltrace/ctf/callbacks.h b/include/babeltrace/ctf/callbacks.h
index c178767..bc75769 100644
--- a/include/babeltrace/ctf/callbacks.h
+++ b/include/babeltrace/ctf/callbacks.h
@@ -51,13 +51,13 @@ enum bt_cb_ret {
 /*
  * Receives a variable number of strings as parameter, ended with NULL.
  */
-struct bt_dependencies *babeltrace_dependencies_create(const char *first, ...);
+struct bt_dependencies *bt_dependencies_create(const char *first, ...);
 
 /*
  * struct bt_dependencies must be destroyed explicitly if not passed as
  * parameter to a bt_ctf_iter_add_callback().
  */
-void babeltrace_dependencies_destroy(struct bt_dependencies *dep);
+void bt_dependencies_destroy(struct bt_dependencies *dep);
 
 /*
  * bt_ctf_iter_add_callback: Add a callback to iterator.
-- 
1.7.10.4
