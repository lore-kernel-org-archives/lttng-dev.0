From: Paul Woegerer <paul_woegerer@mentor.com>
Subject: [PATCH lttng-ust] Fix: Make deadlocks with baddr
	statedump unlikely
Date: Mon, 17 Mar 2014 10:22:01 +0100
Message-ID: <1395048121-20770-2-git-send-email-paul_woegerer__14205.9999554933$1395048317$gmane$org@mentor.com>
References: <1395048121-20770-1-git-send-email-paul_woegerer@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1WPTmW-0004QT-3e
	for lttng-dev@lists.lttng.org; Mon, 17 Mar 2014 05:24:30 -0400
In-Reply-To: <1395048121-20770-1-git-send-email-paul_woegerer@mentor.com>
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

Signed-off-by: Paul Woegerer <paul_woegerer@mentor.com>
---
 liblttng-ust/lttng-ust-baddr.c | 95 ++++++++++++++++++++++++++++++++----------
 1 file changed, 74 insertions(+), 21 deletions(-)

diff --git a/liblttng-ust/lttng-ust-baddr.c b/liblttng-ust/lttng-ust-baddr.c
index dec7e82..0e8ff24 100644
--- a/liblttng-ust/lttng-ust-baddr.c
+++ b/liblttng-ust/lttng-ust-baddr.c
@@ -39,17 +39,50 @@
 #define TP_SESSION_CHECK
 #include "ust_baddr_statedump.h"
 
+struct baddr_entry {
+	void *base_addr_ptr;
+	char resolved_path[PATH_MAX];
+	int vdso;
+};
+
 struct extract_data {
-	void *owner;
 	void *exec_baddr;	/* executable base address */
+	struct baddr_entry *baddrs;	/* other base addresses */
+	size_t num_baddrs;		/* number of other base addresses */
+	size_t idx_baddrs;		/* current base addresse index */
 };
 
+static
+int add_baddr(void *base_addr_ptr,
+	const char *resolved_path,
+	int vdso,
+	struct extract_data *data)
+{
+	struct baddr_entry *baddr;
+
+	if (data->num_baddrs < data->idx_baddrs + 1) {
+		data->num_baddrs *= 2;
+		data->baddrs = realloc(data->baddrs,
+			data->num_baddrs * sizeof(struct baddr_entry));
+		if (!data->baddrs)
+			return 1;
+	}
+
+	baddr = data->baddrs + data->idx_baddrs;
+	baddr->base_addr_ptr = base_addr_ptr;
+	strncpy(baddr->resolved_path, resolved_path, PATH_MAX - 1);
+	baddr->vdso = vdso;
+
+	data->idx_baddrs += 1;
+	return 0;
+}
+
 /*
  * Trace baddr into all sessions for which statedump is pending owned by
  * the caller thread.
  */
 static
-int trace_baddr(void *base_addr_ptr,
+void trace_baddr(void *base_addr_ptr,
 	const char *resolved_path,
 	int vdso,
 	void *owner)
@@ -62,16 +95,6 @@ int trace_baddr(void *base_addr_ptr,
 		sostat.st_size = 0;
 		sostat.st_mtime = -1;
 	}
-	/*
-	 * UST lock nests within dynamic loader lock.
-	 */
-	if (ust_lock()) {
-		/*
-		 * Stop iteration on headers if need to exit.
-		 */
-		ust_unlock();
-		return 1;
-	}
 
 	sessionsp = _lttng_get_sessions();
 	cds_list_for_each_entry(session, sessionsp, node) {
@@ -84,8 +107,6 @@ int trace_baddr(void *base_addr_ptr,
 				resolved_path, sostat.st_size,
 				sostat.st_mtime);
 	}
-	ust_unlock();
-	return 0;
 }
 
 static
@@ -93,7 +114,6 @@ int extract_soinfo_events(struct dl_phdr_info *info, size_t size, void *_data)
 {
 	int j;
 	struct extract_data *data = _data;
-	void *owner = data->owner;
 
 	for (j = 0; j < info->dlpi_phnum; j++) {
 		char resolved_path[PATH_MAX];
@@ -138,9 +158,8 @@ int extract_soinfo_events(struct dl_phdr_info *info, size_t size, void *_data)
 				vdso = 1;
 			}
 		}
-		if (trace_baddr(base_addr_ptr, resolved_path, vdso, owner)) {
+		if (add_baddr(base_addr_ptr, resolved_path, vdso, data))
 			return 1;
-		}
 		/*
 		 * We are only interested in the base address (lowest virtual
 		 * address associated with the memory image), skip the rest
@@ -151,9 +170,8 @@ int extract_soinfo_events(struct dl_phdr_info *info, size_t size, void *_data)
 }
 
 static
-void dump_exec_baddr(struct extract_data *data)
+void dump_exec_baddr(struct extract_data *data, void *owner)
 {
-	void *owner = data->owner;
 	void *base_addr_ptr;
 	char exe_path[PATH_MAX];
 	ssize_t exe_len;
@@ -172,6 +190,38 @@ void dump_exec_baddr(struct extract_data *data)
 	trace_baddr(base_addr_ptr, exe_path, 0, owner);
 }
 
+static
+void dump_baddrs(struct extract_data *data, void *owner)
+{
+	/* Emit tracepoints for shared objects */
+	struct baddr_entry *baddrs = data->baddrs;
+	size_t idx_baddrs = data->idx_baddrs;
+	size_t i = 0;
+
+	/*
+	 * UST lock nests within dynamic loader lock.
+	 */
+	if (ust_lock()) {
+		/*
+		 * Stop if need to exit.
+		 */
+		ust_unlock();
+		return;
+	}
+
+	while (i < idx_baddrs) {
+		struct baddr_entry *baddr = baddrs + i;
+		trace_baddr(baddr->base_addr_ptr,
+			baddr->resolved_path,
+			baddr->vdso, owner);
+		i += 1;
+	}
+	/* Emit tracepoint for executable */
+	dump_exec_baddr(data, owner);
+
+	ust_unlock();
+}
+
 int lttng_ust_baddr_statedump(void *owner)
 {
 	struct extract_data data;
@@ -179,8 +229,10 @@ int lttng_ust_baddr_statedump(void *owner)
 	if (!getenv("LTTNG_UST_WITH_EXPERIMENTAL_BADDR_STATEDUMP"))
 		return 0;
 
-	data.owner = owner;
 	data.exec_baddr = NULL;
+	data.num_baddrs = 32;
+	data.baddrs = malloc(data.num_baddrs * sizeof(struct baddr_entry));
+	data.idx_baddrs = 0;
 	/*
 	 * Iterate through the list of currently loaded shared objects and
 	 * generate events for loadable segments using
@@ -193,7 +245,8 @@ int lttng_ust_baddr_statedump(void *owner)
 	 * deadlocks, so dump the executable outside of the phdr
 	 * iteration.
 	 */
-	dump_exec_baddr(&data);
+	dump_baddrs(&data, owner);
+	free(data.baddrs);
 	return 0;
 }
 
-- 
1.9.0
