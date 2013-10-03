From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: [LTTng UST PATCH 2/2] Add usage reference count for
	tracepoints
Date: Thu, 3 Oct 2013 06:46:39 +0000
Message-ID: <009B25148989C6458484484699278506E538AF45__21883.1545011655$1380782857$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1VRcgR-00088Z-9t
	for lttng-dev@lists.lttng.org; Thu, 03 Oct 2013 02:46:48 -0400
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
	by relay1.mentorg.com with esmtp
	id 1VRcgL-0007jq-SE from jp_ikaheimonen@mentor.com
	for lttng-dev@lists.lttng.org; Wed, 02 Oct 2013 23:46:41 -0700
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Keep track of how many libraries use a tracepoint, and disable
the tracepoint when the number of users drops to zero.

A new reference counter is added to tracepoint_entry.
This keeps track of how many callsites use that tracepoint.

When you have nested libraries sharing tracepoints, you cannot
just disable your tracepoints when the library is unregistered.
You must check that the tracepoint is not used by any other
libraries before you disable it.

The function remove_callsite now refers to disable_tracepoint,
so the functions add_callsite and remove_callsite are
relocated after disable_tracepoint.

Function lib_disable_tracepoints is unnecessary,
and is removed.
---
 liblttng-ust/tracepoint.c | 115 ++++++++++++++++++++++------------------------
 1 file changed, 55 insertions(+), 60 deletions(-)

diff --git a/liblttng-ust/tracepoint.c b/liblttng-ust/tracepoint.c
index 4870d45..2fa9623 100644
--- a/liblttng-ust/tracepoint.c
+++ b/liblttng-ust/tracepoint.c
@@ -95,6 +95,7 @@ struct tracepoint_entry {
 	struct cds_hlist_node hlist;
 	struct tracepoint_probe *probes;
 	int refcount;	/* Number of times armed. 0 if disarmed. */
+	int callsite_refcount; /* how many libs use this tp */
 	const char *signature;
 	char name[0];
 };
@@ -295,6 +296,7 @@ static struct tracepoint_entry *add_tracepoint(const char *name,
 	e->name[name_len] = '\0';
 	e->probes = NULL;
 	e->refcount = 0;
+	e->callsite_refcount = 0;
 	e->signature = signature;
 	cds_hlist_add_head(&e->hlist, head);
 	return e;
@@ -311,42 +313,6 @@ static void remove_tracepoint(struct tracepoint_entry *e)
 }
 
 /*
- * Add the callsite to the callsite hash table. Must be called with
- * tracepoint mutex held.
- */
-static void add_callsite(struct tracepoint_lib * lib, struct tracepoint *tp)
-{
-	struct cds_hlist_head *head;
-	struct callsite_entry *e;
-	const char *name = tp->name;
-	size_t name_len = strlen(name);
-	uint32_t hash;
-
-	if (name_len > LTTNG_UST_SYM_NAME_LEN - 1) {
-		WARN("Truncating tracepoint name %s which exceeds size limits of %u chars", name, LTTNG_UST_SYM_NAME_LEN - 1);
-		name_len = LTTNG_UST_SYM_NAME_LEN - 1;
-	}
-	hash = jhash(name, name_len, 0);
-	head = &callsite_table[hash & (CALLSITE_TABLE_SIZE - 1)];
-	e = zmalloc(sizeof(struct callsite_entry));
-	assert(e);
-	cds_hlist_add_head(&e->hlist, head);
-	e->tp = tp;
-	cds_list_add(&e->node, &(lib->callsites));
-}
-
-/*
- * Remove the callsite from the callsite hash table and from lib
- * callsite list. Must be called with tracepoint mutex held.
- */
-static void remove_callsite(struct callsite_entry *e)
-{
-	cds_hlist_del(&e->hlist);
-	cds_list_del(&e->node);
-	free(e);
-}
-
-/*
  * Sets the probe callback corresponding to one tracepoint.
  */
 static void set_tracepoint(struct tracepoint_entry **entry,
@@ -395,6 +361,55 @@ static void disable_tracepoint(struct tracepoint *elem)
 }
 
 /*
+ * Add the callsite to the callsite hash table. Must be called with
+ * tracepoint mutex held.
+ */
+static void add_callsite(struct tracepoint_lib * lib, struct tracepoint *tp)
+{
+	struct cds_hlist_head *head;
+	struct callsite_entry *e;
+	const char *name = tp->name;
+	size_t name_len = strlen(name);
+	uint32_t hash;
+	struct tracepoint_entry * tp_entry;
+
+	if (name_len > LTTNG_UST_SYM_NAME_LEN - 1) {
+		WARN("Truncating tracepoint name %s which exceeds size limits of %u chars", name, LTTNG_UST_SYM_NAME_LEN - 1);
+		name_len = LTTNG_UST_SYM_NAME_LEN - 1;
+	}
+	hash = jhash(name, name_len, 0);
+	head = &callsite_table[hash & (CALLSITE_TABLE_SIZE - 1)];
+	e = zmalloc(sizeof(struct callsite_entry));
+	assert(e);
+	cds_hlist_add_head(&e->hlist, head);
+	e->tp = tp;
+	cds_list_add(&e->node, &(lib->callsites));
+
+	tp_entry = get_tracepoint(name);
+	if (!tp_entry)
+		return;
+	tp_entry->callsite_refcount++;
+}
+
+/*
+ * Remove the callsite from the callsite hash table and from lib
+ * callsite list. Must be called with tracepoint mutex held.
+ */
+static void remove_callsite(struct callsite_entry *e)
+{
+	struct tracepoint_entry * tp_entry;
+	tp_entry = get_tracepoint(e->tp->name);
+	if (tp_entry) {
+		tp_entry->callsite_refcount--;
+		if (tp_entry->callsite_refcount == 0)
+			disable_tracepoint(e->tp);
+	}
+	cds_hlist_del(&e->hlist);
+	cds_list_del(&e->node);
+	free(e);
+}
+
+/*
  * Enable/disable all callsites based on the state of a specific
  * tracepoint entry.
  * Must be called with tracepoint mutex held.
@@ -705,24 +720,6 @@ static void new_tracepoints(struct tracepoint * const *start, struct tracepoint
 	}
 }
 
-static
-void lib_disable_tracepoints(struct tracepoint_lib *lib)
-{
-	struct tracepoint * const *begin;
-	struct tracepoint * const *end;
-	struct tracepoint * const *iter;
-
-	begin = lib->tracepoints_start;
-	end = lib->tracepoints_start + lib->tracepoints_count;
-
-	for (iter = begin; iter < end; iter++) {
-		if (!*iter)
-			continue;	/* skip dummy */
-		disable_tracepoint(*iter);
-	}
-
-}
-
 int tracepoint_register_lib(struct tracepoint * const *tracepoints_start,
 			    int tracepoints_count)
 {
@@ -780,13 +777,11 @@ int tracepoint_unregister_lib(struct tracepoint * const *tracepoints_start)
 
 		cds_list_del(&lib->list);
 		/*
-		 * Force tracepoint disarm for all tracepoints of this lib.
-		 * This takes care of destructor of library that would leave a
-		 * LD_PRELOAD wrapper override function enabled for tracing, but
-		 * the session teardown would not be able to reach the
-		 * tracepoint anymore to disable it.
+		 * Unregistering a callsite also decreases the
+		 * callsite reference count of the corresponding
+		 * tracepoint, and disables the tracepoint if
+		 * the reference count drops to zero.
 		 */
-		lib_disable_tracepoints(lib);
 		lib_unregister_callsites(lib);
 		DBG("just unregistered a tracepoints section from %p",
 			lib->tracepoints_start);
-- 
1.8.1.2
