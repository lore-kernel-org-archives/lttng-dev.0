From: Yannick Lamarre <ylamarre@efficios.com>
Subject: [RFC PATCH lttng-tools v2 20/20] Introduce
 serialization unit test
Date: Wed,  1 May 2019 15:34:44 -0400
Message-ID: <20190501193444.17403-21-ylamarre__45123.444839713$1556739786$gmane$org@efficios.com>
References: <20190501193444.17403-1-ylamarre@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44vTB95CP3z1Kft
 for <lttng-dev@lists.lttng.org>; Wed,  1 May 2019 15:34:57 -0400 (EDT)
In-Reply-To: <20190501193444.17403-1-ylamarre@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Yannick Lamarre <ylamarre@efficios.com>
---
New unit test for serialization functions.

 .gitignore                                         |   1 +
 tests/unit/Makefile.am                             |   8 +-
 .../unit/test_utils_sessiond_comm_serialization.c  | 290 +++++++++++++++++++++
 3 files changed, 298 insertions(+), 1 deletion(-)
 create mode 100644 tests/unit/test_utils_sessiond_comm_serialization.c

diff --git a/.gitignore b/.gitignore
index 19276012..a73eebc9 100644
--- a/.gitignore
+++ b/.gitignore
@@ -75,6 +75,7 @@ TAGS
 /tests/unit/test_ust_data
 /tests/unit/test_utils_parse_size_suffix
 /tests/unit/test_utils_parse_time_suffix
+/tests/unit/test_utils_sessiond_comm_serialization
 /tests/unit/test_utils_expand_path
 /tests/unit/test_notification
 kernel_all_events_basic
diff --git a/tests/unit/Makefile.am b/tests/unit/Makefile.am
index 26989fa0..f156c640 100644
--- a/tests/unit/Makefile.am
+++ b/tests/unit/Makefile.am
@@ -28,7 +28,8 @@ LIBLTTNG_CTL=$(top_builddir)/src/lib/lttng-ctl/liblttng-ctl.la
 # Define test programs
 noinst_PROGRAMS = test_uri test_session test_kernel_data \
                   test_utils_parse_size_suffix test_utils_parse_time_suffix \
-                  test_utils_expand_path test_string_utils test_notification
+                  test_utils_expand_path test_string_utils test_notification \
+				  test_utils_sessiond_comm_serialization
 
 if HAVE_LIBLTTNG_UST_CTL
 noinst_PROGRAMS += test_ust_data
@@ -156,3 +157,8 @@ test_string_utils_LDADD = $(LIBTAP) $(LIBCOMMON) $(LIBSTRINGUTILS) $(DL_LIBS)
 # Notification api
 test_notification_SOURCES = test_notification.c
 test_notification_LDADD = $(LIBTAP) $(LIBLTTNG_CTL) $(DL_LIBS)
+
+# Serialization unit test
+test_utils_sessiond_comm_serialization_SOURCES = test_utils_sessiond_comm_serialization.c
+test_utils_sessiond_comm_serialization_LDADD = $(LIBTAP) $(LIBSESSIOND_COMM) $(LIBCOMMON) $(LIBLTTNG_CTL) $(DL_LIBS)
+
diff --git a/tests/unit/test_utils_sessiond_comm_serialization.c b/tests/unit/test_utils_sessiond_comm_serialization.c
new file mode 100644
index 00000000..bc9d11cc
--- /dev/null
+++ b/tests/unit/test_utils_sessiond_comm_serialization.c
@@ -0,0 +1,290 @@
+/*
+ * Copyright (c)  2019 Yannick Lamarre <yannick.lamarre@efficios.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * as published by the Free Software Foundation; only version 2
+ * of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#include <assert.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/types.h>
+
+#include <tap/tap.h>
+
+#include <common/sessiond-comm/sessiond-comm.h>
+#include <common/common.h>
+
+/* Number of TAP tests in this file */
+#define NUM_TESTS 141
+
+/* For error.h */
+int lttng_opt_quiet = 1;
+int lttng_opt_verbose = 0;
+int lttng_opt_mi;
+
+void test_lttng_channel(void)
+{
+	struct lttng_domain reference_domain;
+	struct lttng_channel channel;
+	struct lttng_channel_extended extended_channel;
+	struct lttng_channel_serialized serialized_channel;
+	struct lttng_channel_extended_serialized serialized_extended_channel;
+
+	reference_domain.type = LTTNG_DOMAIN_KERNEL;
+	reference_domain.buf_type = LTTNG_BUFFER_GLOBAL;
+
+	/* Initializing structures to unmatching values. */
+	memset(&channel, 0, sizeof(struct lttng_channel));
+	memset(&serialized_channel, 0xFF, sizeof(struct lttng_channel_serialized));
+
+	diag("Testing serialization and deserialization of lttng_channel.");
+	ok(lttng_channel_serialize(&serialized_channel, &channel) == 0, "Serialize function returned successfully");
+
+	ok(channel.enabled == serialized_channel.enabled, "enabled field properly copied");
+	ok(sizeof(channel.name) == sizeof(serialized_channel.name), "Size of name field is equal");
+	ok(memcmp(channel.name, serialized_channel.name, sizeof(channel.name)) == 0, "name field properly copied");
+	ok(channel.attr.overwrite == serialized_channel.attr.overwrite, "overwrite field field properly copied");
+	ok(channel.attr.subbuf_size == serialized_channel.attr.subbuf_size, "subbuf_size field properly copied");
+	ok(channel.attr.num_subbuf == serialized_channel.attr.num_subbuf, "num_subbuf field properly copied");
+	ok(channel.attr.switch_timer_interval == serialized_channel.attr.switch_timer_interval, "switch_timer_interval field properly copied");
+	ok(channel.attr.read_timer_interval == serialized_channel.attr.read_timer_interval, "read_timer_interval field properly copied");
+	ok(channel.attr.output == serialized_channel.attr.output, "output field properly copied");
+	ok(channel.attr.tracefile_size == serialized_channel.attr.tracefile_size, "tracefile_size field properly copied");
+	ok(channel.attr.tracefile_count == serialized_channel.attr.tracefile_count, "tracefile_count field properly copied");
+	ok(channel.attr.live_timer_interval == serialized_channel.attr.live_timer_interval, "live_timer_interval field properly copied");
+
+	/* Resetting channel to unmatching value. */
+	memset(&channel, 0xFF, sizeof(struct lttng_channel));
+
+	ok(lttng_channel_deserialize(&channel, &serialized_channel) == 0, "Deserialize function returned successfully");
+
+	ok(channel.enabled == serialized_channel.enabled, "enabled field properly copied");
+	ok(memcmp(channel.name, serialized_channel.name, sizeof(channel.name)) == 0, "name field properly copied");
+	ok(channel.attr.overwrite == serialized_channel.attr.overwrite, "overwrite field field properly copied");
+	ok(channel.attr.subbuf_size == serialized_channel.attr.subbuf_size, "subbuf_size field properly copied");
+	ok(channel.attr.num_subbuf == serialized_channel.attr.num_subbuf, "num_subbuf field properly copied");
+	ok(channel.attr.switch_timer_interval == serialized_channel.attr.switch_timer_interval, "switch_timer_interval field properly copied");
+	ok(channel.attr.read_timer_interval == serialized_channel.attr.read_timer_interval, "read_timer_interval field properly copied");
+	ok(channel.attr.output == serialized_channel.attr.output, "output field properly copied");
+	ok(channel.attr.tracefile_size == serialized_channel.attr.tracefile_size, "tracefile_size field properly copied");
+	ok(channel.attr.tracefile_count == serialized_channel.attr.tracefile_count, "tracefile_count field properly copied");
+	ok(channel.attr.live_timer_interval == serialized_channel.attr.live_timer_interval, "live_timer_interval field properly copied");
+
+	diag("Testing serialized_extended_channel initialization function");
+	ok(init_serialized_extended_channel(&reference_domain, &serialized_extended_channel) == 0, "Initialization function returned successfully");
+
+	ok(serialized_extended_channel.monitor_timer_interval == DEFAULT_KERNEL_CHANNEL_MONITOR_TIMER, "monitor_timer_interval field initialized to the right value");
+	ok(serialized_extended_channel.blocking_timeout == DEFAULT_KERNEL_CHANNEL_BLOCKING_TIMEOUT, "blocking_timeout field initialized to the right value");
+
+	reference_domain.type = LTTNG_DOMAIN_UST;
+	reference_domain.buf_type = LTTNG_BUFFER_PER_PID;
+
+	ok(init_serialized_extended_channel(&reference_domain, &serialized_extended_channel) == 0, "Initialization function returned successfully");
+
+	ok(serialized_extended_channel.monitor_timer_interval == DEFAULT_UST_PID_CHANNEL_MONITOR_TIMER, "monitor_timer_interval field initialized to the right value");
+	ok(serialized_extended_channel.blocking_timeout == DEFAULT_UST_PID_CHANNEL_BLOCKING_TIMEOUT, "blocking_timeout field initialized to the right value");
+
+	reference_domain.type = LTTNG_DOMAIN_UST;
+	reference_domain.buf_type = LTTNG_BUFFER_PER_UID;
+
+	ok(init_serialized_extended_channel(&reference_domain, &serialized_extended_channel) == 0, "Initialization function returned successfully");
+
+	ok(serialized_extended_channel.monitor_timer_interval == DEFAULT_UST_UID_CHANNEL_MONITOR_TIMER, "monitor_timer_interval field initialized to the right value");
+	ok(serialized_extended_channel.blocking_timeout == DEFAULT_UST_UID_CHANNEL_BLOCKING_TIMEOUT, "blocking_timeout field initialized to the right value");
+
+	diag("Testing serialized_extended_channel serialization functions");
+	memset(&extended_channel, 0xFF, sizeof(struct lttng_channel_extended));
+	ok(lttng_channel_extended_deserialize(&extended_channel, &serialized_extended_channel) == 0, "Deserialization function returned successfully");
+
+	ok(extended_channel.monitor_timer_interval == serialized_extended_channel.monitor_timer_interval, "monitor_timer_interval field properly copied");
+	ok(extended_channel.blocking_timeout == serialized_extended_channel.blocking_timeout, "blocking_timeout field properly copied");
+	ok(serialized_extended_channel.discarded_events == extended_channel.discarded_events, "discard_events field properly copied");
+	ok(serialized_extended_channel.lost_packets == extended_channel.lost_packets, "lost_packets field properly copied");
+
+	memset(&serialized_extended_channel, 0xFF, sizeof(struct lttng_channel_extended_serialized));
+	ok(lttng_channel_extended_serialize(&serialized_extended_channel, &extended_channel) == 0, "Serialization function returned successfully");
+
+	ok(extended_channel.monitor_timer_interval == serialized_extended_channel.monitor_timer_interval, "monitor_timer_interval field properly copied");
+	ok(extended_channel.blocking_timeout == serialized_extended_channel.blocking_timeout, "blocking_timeout field properly copied");
+	ok(serialized_extended_channel.discarded_events == extended_channel.discarded_events, "discard_events field properly copied");
+	ok(serialized_extended_channel.lost_packets == extended_channel.lost_packets, "lost_packets field properly copied");
+}
+
+void test_lttng_event_context(void)
+{
+	struct lttng_event_context event_context;
+	struct lttng_event_context_serialized serialized_event_context;
+
+	/* Initialize structures to unmatching values. */
+	memset(&event_context, 0, sizeof(struct lttng_event_context));
+	memset(&serialized_event_context, 0xFF, sizeof(struct lttng_event_context_serialized));
+
+	ok(lttng_event_context_serialize(&serialized_event_context, &event_context) == 0, "Serialization function returned successfully");
+
+	ok(event_context.ctx == serialized_event_context.ctx, "ctx field properly copied");
+	ok(event_context.u.perf_counter.type == serialized_event_context.perf_counter.type, "type field properly copied");
+	ok(event_context.u.perf_counter.config == serialized_event_context.perf_counter.config, "config field properly copied");
+	ok(sizeof(event_context.u.perf_counter.name) == sizeof(serialized_event_context.perf_counter.name), "Size of name field is equal");
+	ok(memcmp(event_context.u.perf_counter.name, serialized_event_context.perf_counter.name, sizeof(event_context.u.perf_counter.name)) == 0, "name field properly copied");
+
+	memset(&event_context, 0xFF, sizeof(struct lttng_event_context));
+	ok(lttng_event_context_deserialize(&event_context, &serialized_event_context) == 0, "Deserialization function returned successfully");
+
+	ok(event_context.ctx == serialized_event_context.ctx, "ctx field properly copied");
+	ok(event_context.u.perf_counter.type == serialized_event_context.perf_counter.type, "type field properly copied");
+	ok(event_context.u.perf_counter.config == serialized_event_context.perf_counter.config, "config field properly copied");
+	ok(memcmp(event_context.u.perf_counter.name, serialized_event_context.perf_counter.name, sizeof(event_context.u.perf_counter.name)) == 0, "name field properly copied");
+}
+
+void test_lttng_event(void)
+{
+	struct lttng_event event;
+	struct lttng_event_serialized serialized_event;
+
+	memset(&event, 0, sizeof(struct lttng_event));
+	memset(&serialized_event, 0xFF, sizeof(struct lttng_event_serialized));
+
+	ok(lttng_event_no_attr_serialize(&serialized_event, &event) == 0, "Serialization function returned successfully");
+
+	ok(event.type == serialized_event.type, "type field properly copied");
+	ok(event.loglevel_type == serialized_event.loglevel_type, "loglevel_type field properly copied");
+	ok(event.loglevel == serialized_event.loglevel, "loglevel field properly copied");
+	ok(event.enabled == serialized_event.enabled, "enabled field properly copied");
+	ok(event.pid == serialized_event.pid, "pid field properly copied");
+	ok(event.filter == serialized_event.filter, "filter field properly copied");
+	ok(event.exclusion == serialized_event.exclusion, "exclusion field properly copied");
+	ok(event.flags == serialized_event.flags, "flags field properly copied");
+	ok(sizeof(event.name) == sizeof(serialized_event.name), "Size of name field is equal");
+	ok(memcmp(event.name, serialized_event.name, sizeof(event.name)) == 0, "name field properly copied");
+
+	memset(&event, 0xFF, sizeof(struct lttng_event));
+	ok(lttng_event_no_attr_deserialize(&event, &serialized_event) == 0, "Deserialization function returned successfully");
+
+	ok(event.type == serialized_event.type, "type field properly copied");
+	ok(event.loglevel_type == serialized_event.loglevel_type, "loglevel_type field properly copied");
+	ok(event.loglevel == serialized_event.loglevel, "loglevel field properly copied");
+	ok(event.enabled == serialized_event.enabled, "enabled field properly copied");
+	ok(event.pid == serialized_event.pid, "pid field properly copied");
+	ok(event.filter == serialized_event.filter, "filter field properly copied");
+	ok(event.exclusion == serialized_event.exclusion, "exclusion field properly copied");
+	ok(event.flags == serialized_event.flags, "flags field properly copied");
+	ok(memcmp(event.name, serialized_event.name, sizeof(event.name)) == 0, "name field properly copied");
+
+	memset(&serialized_event, 0xFF, sizeof(struct lttng_event_serialized));
+	ok(lttng_event_function_attr_serialize(&serialized_event, &event) == 0, "Serialization function returned successfully");
+
+	ok(event.type == serialized_event.type, "type field properly copied");
+	ok(event.loglevel_type == serialized_event.loglevel_type, "loglevel_type field properly copied");
+	ok(event.loglevel == serialized_event.loglevel, "loglevel field properly copied");
+	ok(event.enabled == serialized_event.enabled, "enabled field properly copied");
+	ok(event.pid == serialized_event.pid, "pid field properly copied");
+	ok(event.filter == serialized_event.filter, "filter field properly copied");
+	ok(event.exclusion == serialized_event.exclusion, "exclusion field properly copied");
+	ok(event.flags == serialized_event.flags, "flags field properly copied");
+	ok(memcmp(event.name, serialized_event.name, sizeof(event.name)) == 0, "name field properly copied");
+	ok(sizeof(event.attr.ftrace.symbol_name) == sizeof(serialized_event.attr.ftrace.symbol_name), "Size of symbol_name field is equal");
+	ok(memcmp(event.attr.ftrace.symbol_name, serialized_event.attr.ftrace.symbol_name, sizeof(event.attr.ftrace.symbol_name)) == 0, "symbol_name field properly copied");
+
+	memset(&event, 0xFF, sizeof(struct lttng_event));
+	ok(lttng_event_function_attr_deserialize(&event, &serialized_event) == 0, "Deserialization function returned successfully");
+
+	ok(event.type == serialized_event.type, "type field properly copied");
+	ok(event.loglevel_type == serialized_event.loglevel_type, "loglevel_type field properly copied");
+	ok(event.loglevel == serialized_event.loglevel, "loglevel field properly copied");
+	ok(event.enabled == serialized_event.enabled, "enabled field properly copied");
+	ok(event.pid == serialized_event.pid, "pid field properly copied");
+	ok(event.filter == serialized_event.filter, "filter field properly copied");
+	ok(event.exclusion == serialized_event.exclusion, "exclusion field properly copied");
+	ok(event.flags == serialized_event.flags, "flags field properly copied");
+	ok(memcmp(event.name, serialized_event.name, sizeof(event.name)) == 0, "name field properly copied");
+	ok(memcmp(event.attr.ftrace.symbol_name, serialized_event.attr.ftrace.symbol_name, sizeof(event.attr.ftrace.symbol_name)) == 0, "symbol_name field properly copied");
+
+	memset(&serialized_event, 0xFF, sizeof(struct lttng_event_serialized));
+	ok(lttng_event_probe_attr_serialize(&serialized_event, &event) == 0, "Serialization function returned successfully");
+
+	ok(event.type == serialized_event.type, "type field properly copied");
+	ok(event.loglevel_type == serialized_event.loglevel_type, "loglevel_type field properly copied");
+	ok(event.loglevel == serialized_event.loglevel, "loglevel field properly copied");
+	ok(event.enabled == serialized_event.enabled, "enabled field properly copied");
+	ok(event.pid == serialized_event.pid, "pid field properly copied");
+	ok(event.filter == serialized_event.filter, "filter field properly copied");
+	ok(event.exclusion == serialized_event.exclusion, "exclusion field properly copied");
+	ok(event.flags == serialized_event.flags, "flags field properly copied");
+	ok(memcmp(event.name, serialized_event.name, sizeof(event.name)) == 0, "name field properly copied");
+	ok(event.attr.probe.addr == serialized_event.attr.probe.addr, "addr field properly copied");
+	ok(event.attr.probe.offset == serialized_event.attr.probe.offset, "offset field properly copied");
+	ok(sizeof(event.attr.probe.symbol_name) == sizeof(serialized_event.attr.probe.symbol_name), "Size of symbol_name field is equal");
+	ok(memcmp(event.attr.probe.symbol_name, serialized_event.attr.probe.symbol_name, sizeof(event.attr.probe.symbol_name)) == 0, "symbol_name field properly copied");
+
+	memset(&event, 0xFF, sizeof(struct lttng_event));
+	ok(lttng_event_probe_attr_deserialize(&event, &serialized_event) == 0, "Deserialization function returned successfully");
+
+	ok(event.type == serialized_event.type, "type field properly copied");
+	ok(event.loglevel_type == serialized_event.loglevel_type, "loglevel_type field properly copied");
+	ok(event.loglevel == serialized_event.loglevel, "loglevel field properly copied");
+	ok(event.enabled == serialized_event.enabled, "enabled field properly copied");
+	ok(event.pid == serialized_event.pid, "pid field properly copied");
+	ok(event.filter == serialized_event.filter, "filter field properly copied");
+	ok(event.exclusion == serialized_event.exclusion, "exclusion field properly copied");
+	ok(event.flags == serialized_event.flags, "flags field properly copied");
+	ok(memcmp(event.name, serialized_event.name, sizeof(event.name)) == 0, "name field properly copied");
+	ok(event.attr.probe.addr == serialized_event.attr.probe.addr, "addr field properly copied");
+	ok(event.attr.probe.offset == serialized_event.attr.probe.offset, "offset field properly copied");
+	ok(memcmp(event.attr.probe.symbol_name, serialized_event.attr.probe.symbol_name, sizeof(event.attr.probe.symbol_name)) == 0, "symbol_name field properly copied");
+}
+
+void test_lttng_snapshot_output(void)
+{
+	struct lttng_snapshot_output snapshot_output;
+	struct lttng_snapshot_output_serialized serialized_snapshot_output;
+
+	memset(&snapshot_output, 0, sizeof(struct lttng_snapshot_output));
+	memset(&serialized_snapshot_output, 0xFF, sizeof(struct lttng_snapshot_output_serialized));
+	ok(lttng_snapshot_output_serialize(&serialized_snapshot_output, &snapshot_output) == 0, "Serialization function returned successfully");
+
+	ok(snapshot_output.id == serialized_snapshot_output.id, "id field properly copied");
+	ok(snapshot_output.max_size == serialized_snapshot_output.max_size, "max_size field properly copied");
+	ok(sizeof(snapshot_output.name) == sizeof(serialized_snapshot_output.name), "Size of name field is equal");
+	ok(memcmp(snapshot_output.name, serialized_snapshot_output.name, sizeof(snapshot_output.name)) == 0, "name field properly copied");
+	ok(sizeof(snapshot_output.ctrl_url) == sizeof(serialized_snapshot_output.ctrl_url), "Size if ctrl_url field is equal");
+	ok(memcmp(snapshot_output.ctrl_url, serialized_snapshot_output.ctrl_url, sizeof(snapshot_output.ctrl_url)) == 0, "ctrl_url field properly copied");
+	ok(sizeof(snapshot_output.data_url) == sizeof(serialized_snapshot_output.data_url), "Size of data_url field is equal");
+	ok(memcmp(snapshot_output.data_url, serialized_snapshot_output.data_url, sizeof(snapshot_output.data_url)) == 0, "data_url field properly copied");
+
+	memset(&snapshot_output, 0xFF, sizeof(struct lttng_snapshot_output));
+	ok(lttng_snapshot_output_deserialize(&snapshot_output, &serialized_snapshot_output) == 0, "Deserialization function returned successfully");
+
+	ok(snapshot_output.id == serialized_snapshot_output.id, "id field properly copied");
+	ok(snapshot_output.max_size == serialized_snapshot_output.max_size, "max_size field properly copied");
+	ok(memcmp(snapshot_output.name, serialized_snapshot_output.name, sizeof(snapshot_output.name)) == 0, "name field properly copied");
+	ok(memcmp(snapshot_output.ctrl_url, serialized_snapshot_output.ctrl_url, sizeof(snapshot_output.ctrl_url)) == 0, "ctrl_url field properly copied");
+	ok(memcmp(snapshot_output.data_url, serialized_snapshot_output.data_url, sizeof(snapshot_output.data_url)) == 0, "data_url field properly copied");
+}
+
+int main(void)
+{
+	plan_tests(NUM_TESTS);
+
+	diag("Serialization functions' unit tests");
+	test_lttng_channel();
+	test_lttng_event_context();
+	test_lttng_event();
+	test_lttng_snapshot_output();
+
+	return exit_status();
+}
-- 
2.11.0
