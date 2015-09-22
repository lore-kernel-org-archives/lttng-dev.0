From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH babeltrace] Fix: add compat for glib < 2.32
Date: Tue, 22 Sep 2015 14:46:07 -0400
Message-ID: <1442947567-7242-1-git-send-email-mjeanson__5082.99571597508$1442947664$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mjeanson@efficios.com>) id 1ZeSa4-0001Pt-D0
 for lttng-dev@lists.lttng.org; Tue, 22 Sep 2015 14:46:28 -0400
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

A dependency on glib >= 2.32 was introduced in this commit:

commit 347829f5b1eaf79a540f4623f7ae5ee4e9e3d4c7
Author: Philippe Proulx <eeppeliteloop@gmail.com>
Date:   Thu Mar 12 16:14:31 2015 -0400

    Add basic object system

To stay compatible with SLES11, keep our dependency on 2.22 and add a
compatibility header.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 include/Makefile.am              |  1 +
 include/babeltrace/compat/glib.h | 80 ++++++++++++++++++++++++++++++++++++++++
 lib/values.c                     |  6 +--
 3 files changed, 84 insertions(+), 3 deletions(-)
 create mode 100644 include/babeltrace/compat/glib.h

diff --git a/include/Makefile.am b/include/Makefile.am
index 15159dd..88c28c2 100644
--- a/include/Makefile.am
+++ b/include/Makefile.am
@@ -71,5 +71,6 @@ noinst_HEADERS = \
 	babeltrace/compat/string.h \
 	babeltrace/compat/utc.h \
 	babeltrace/compat/limits.h \
+	babeltrace/compat/glib.h \
 	babeltrace/endian.h \
 	babeltrace/mmap-align.h
diff --git a/include/babeltrace/compat/glib.h b/include/babeltrace/compat/glib.h
new file mode 100644
index 0000000..8db2d97
--- /dev/null
+++ b/include/babeltrace/compat/glib.h
@@ -0,0 +1,80 @@
+#ifndef _BABELTRACE_COMPAT_GLIB_H
+#define _BABELTRACE_COMPAT_GLIB_H
+
+/*
+ * babeltrace/compat/uuid.h
+ *
+ * Copyright (C) 2015 Michael Jeanson <mjeanson@efficios.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+#include <glib.h>
+
+#if GLIB_CHECK_VERSION(2,31,8)
+
+static inline gboolean
+babeltrace_g_hash_table_contains(GHashTable *hash_table, gconstpointer key)
+{
+	return g_hash_table_contains(hash_table, key);
+}
+
+#else
+
+static inline gboolean
+babeltrace_g_hash_table_contains(GHashTable *hash_table, gconstpointer key)
+{
+       const char *value;
+
+       value = g_hash_table_lookup(hash_table, key);
+       if (value == NULL) {
+               return FALSE;
+       }
+
+       return TRUE;
+}
+
+#endif
+
+
+#if GLIB_CHECK_VERSION(2,29,16)
+
+static inline GPtrArray *
+babeltrace_g_ptr_array_new_full(guint reserved_size,
+		GDestroyNotify element_free_func)
+{
+	return g_ptr_array_new_full(reserved_size, element_free_func);
+}
+
+#else
+
+static inline GPtrArray *
+babeltrace_g_ptr_array_new_full(guint reserved_size,
+		GDestroyNotify element_free_func)
+{
+       GPtrArray *array;
+
+       array = g_ptr_array_sized_new(reserved_size);
+       g_ptr_array_set_free_func(array, element_free_func);
+
+       return array;
+}
+#endif
+
+#endif /* _BABELTRACE_COMPAT_GLIB_H */
diff --git a/lib/values.c b/lib/values.c
index 5778528..f75f008 100644
--- a/lib/values.c
+++ b/lib/values.c
@@ -33,7 +33,7 @@
 #include <babeltrace/object-internal.h>
 #include <babeltrace/ref.h>
 #include <babeltrace/values.h>
-#include <glib.h>
+#include <babeltrace/compat/glib.h>
 
 #define BT_VALUE_FROM_CONCRETE(_concrete) ((struct bt_value *) (_concrete))
 #define BT_VALUE_TO_BOOL(_base) ((struct bt_value_bool *) (_base))
@@ -606,7 +606,7 @@ struct bt_value *bt_value_array_create(void)
 	}
 
 	array_obj->base = bt_value_create_base(BT_VALUE_TYPE_ARRAY);
-	array_obj->garray = g_ptr_array_new_full(0,
+	array_obj->garray = babeltrace_g_ptr_array_new_full(0,
 		(GDestroyNotify) bt_put);
 
 	if (!array_obj->garray) {
@@ -1028,7 +1028,7 @@ bool bt_value_map_has_key(const struct bt_value *map_obj, const char *key)
 	}
 
 	quark = g_quark_from_string(key);
-	ret = g_hash_table_contains(typed_map_obj->ght,
+	ret = babeltrace_g_hash_table_contains(typed_map_obj->ght,
 		GUINT_TO_POINTER(quark));
 
 end:
-- 
1.9.1
