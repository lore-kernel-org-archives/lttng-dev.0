From: Paul Woegerer <paul_woegerer@mentor.com>
Subject: [PATCH] Fix: baddr_statedump tracepoint registration
Date: Tue, 10 Dec 2013 14:07:51 +0100
Message-ID: <1386680871-14908-1-git-send-email-paul_woegerer__36559.9600635052$1386680958$gmane$org@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1VqN38-00058R-8U
	for lttng-dev@lists.lttng.org; Tue, 10 Dec 2013 08:08:32 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org, mathieu.desnoyers@efficios.com
List-Id: lttng-dev@lists.lttng.org

Ensure baddr_statedump tracepoint registration is completed prior to
using the tracepoint in lttng_ust_baddr_statedump().

Make liblttng-ust-dl robust for explicit baddr_statedump tracepoint
deregistration in lttng_ust_cleanup() (prevent dlopen/dlclose to get
traced if ust_baddr tracepoints are not available).

Signed-off-by: Paul Woegerer <paul_woegerer@mentor.com>
---
 liblttng-ust-dl/ustdl.c        |  4 ++--
 liblttng-ust/lttng-ust-baddr.c | 12 ++++++++++++
 liblttng-ust/lttng-ust-baddr.h |  3 +++
 liblttng-ust/lttng-ust-comm.c  |  2 ++
 4 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/liblttng-ust-dl/ustdl.c b/liblttng-ust-dl/ustdl.c
index 3038d5c..ceb9b5b 100644
--- a/liblttng-ust-dl/ustdl.c
+++ b/liblttng-ust-dl/ustdl.c
@@ -90,7 +90,7 @@ void lttng_ust_baddr_push(void *so_base, const char *so_name)
 void *dlopen(const char *filename, int flag)
 {
 	void *handle = _lttng_ust_dl_libc_dlopen(filename, flag);
-	if (handle) {
+	if (__tracepoint_ptrs_registered && handle) {
 		struct link_map *p = NULL;
 		if (dlinfo(handle, RTLD_DI_LINKMAP, &p) != -1 && p != NULL
 				&& p->l_addr != 0)
@@ -101,7 +101,7 @@ void *dlopen(const char *filename, int flag)
 
 int dlclose(void *handle)
 {
-	if (handle) {
+	if (__tracepoint_ptrs_registered && handle) {
 		struct link_map *p = NULL;
 		if (dlinfo(handle, RTLD_DI_LINKMAP, &p) != -1 && p != NULL
 				&& p->l_addr != 0)
diff --git a/liblttng-ust/lttng-ust-baddr.c b/liblttng-ust/lttng-ust-baddr.c
index df0ba45..b7843e2 100644
--- a/liblttng-ust/lttng-ust-baddr.c
+++ b/liblttng-ust/lttng-ust-baddr.c
@@ -194,3 +194,15 @@ int lttng_ust_baddr_statedump(void *owner)
 	dump_exec_baddr(&data);
 	return 0;
 }
+
+void lttng_ust_baddr_statedump_init(void)
+{
+	__tracepoints__init();
+	__tracepoints__ptrs_init();
+}
+
+void lttng_ust_baddr_statedump_destroy(void)
+{
+	__tracepoints__ptrs_destroy();
+	__tracepoints__destroy();
+}
diff --git a/liblttng-ust/lttng-ust-baddr.h b/liblttng-ust/lttng-ust-baddr.h
index 08f7db7..e7a0dfb 100644
--- a/liblttng-ust/lttng-ust-baddr.h
+++ b/liblttng-ust/lttng-ust-baddr.h
@@ -21,6 +21,9 @@
 
 #include <lttng/ust-events.h>
 
+void lttng_ust_baddr_statedump_init(void);
+void lttng_ust_baddr_statedump_destroy(void);
+
 int lttng_ust_baddr_statedump(void *owner);
 
 #endif /* LTTNG_UST_BADDR_H */
diff --git a/liblttng-ust/lttng-ust-comm.c b/liblttng-ust/lttng-ust-comm.c
index 6eb4a89..0c96f01 100644
--- a/liblttng-ust/lttng-ust-comm.c
+++ b/liblttng-ust/lttng-ust-comm.c
@@ -1343,6 +1343,7 @@ void __attribute__((constructor)) lttng_ust_init(void)
 	 */
 	init_usterr();
 	init_tracepoint();
+	lttng_ust_baddr_statedump_init();
 	lttng_ring_buffer_metadata_client_init();
 	lttng_ring_buffer_client_overwrite_init();
 	lttng_ring_buffer_client_overwrite_rt_init();
@@ -1457,6 +1458,7 @@ void lttng_ust_cleanup(int exiting)
 	lttng_ring_buffer_client_overwrite_rt_exit();
 	lttng_ring_buffer_client_overwrite_exit();
 	lttng_ring_buffer_metadata_client_exit();
+	lttng_ust_baddr_statedump_destroy();
 	exit_tracepoint();
 	if (!exiting) {
 		/* Reinitialize values for fork */
-- 
1.8.5
