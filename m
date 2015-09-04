From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools v2] Fix: use pid element instead of
	process element
Date: Fri,  4 Sep 2015 18:02:48 -0400
Message-ID: <1441404168-15913-1-git-send-email-jonathan.rajotte-julien__30759.1943223544$1441404239$gmane$org@efficios.com>
References: <CA+jJMxsexhr2DqMXjqnVbrBbfyGJddgf4s+Aa_5o1h-WwGPRHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1ZXz4e-0005Ub-Q8
 for lttng-dev@lists.lttng.org; Fri, 04 Sep 2015 18:03:12 -0400
In-Reply-To: <CA+jJMxsexhr2DqMXjqnVbrBbfyGJddgf4s+Aa_5o1h-WwGPRHg@mail.gmail.com>
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

v2: Include change to xsd. Looks like I forgot to squash it. I'll have to make
an offering to the git reflog god on this one.

For stable 2.7

This revert part of changes introduced by [1] and [2].

The use of process element break the existing MI xml api.

[1] 46ef4d0715faeef52cd2242b5b895c74507e223a
[2] a585578f837d992f00eba4f090c8ba251d9de94e

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 src/bin/lttng/commands/list.c     | 18 ++++++++---------
 src/common/mi-lttng.c             | 41 +++++++++++++++++++++++++++++++++++++++
 src/common/mi-lttng.h             | 19 ++++++++++++++++++
 src/common/mi_lttng.xsd           | 15 +++++++++++---
 tests/regression/tools/mi/test_mi |  2 +-
 5 files changed, 82 insertions(+), 13 deletions(-)

diff --git a/src/bin/lttng/commands/list.c b/src/bin/lttng/commands/list.c
index f7f3852..3198eca 100644
--- a/src/bin/lttng/commands/list.c
+++ b/src/bin/lttng/commands/list.c
@@ -340,8 +340,8 @@ static int mi_list_agent_ust_events(struct lttng_event *events, int count,
 		goto end;
 	}
 
-	/* Open processes element */
-	ret = mi_lttng_processes_open(writer);
+	/* Open pids element element */
+	ret = mi_lttng_pids_open(writer);
 	if (ret) {
 		goto end;
 	}
@@ -366,7 +366,7 @@ static int mi_list_agent_ust_events(struct lttng_event *events, int count,
 
 			if (!pid_element_open) {
 				/* Open and write a pid element */
-				ret = mi_lttng_process(writer, cur_pid, cmdline, 1);
+				ret = mi_lttng_pid(writer, cur_pid, cmdline, 1);
 				if (ret) {
 					goto error;
 				}
@@ -389,7 +389,7 @@ static int mi_list_agent_ust_events(struct lttng_event *events, int count,
 		}
 	}
 
-	/* Close processes */
+	/* Close pids */
 	ret = mi_lttng_writer_close_element(writer);
 	if (ret) {
 		goto end;
@@ -577,8 +577,8 @@ static int mi_list_ust_event_fields(struct lttng_event_field *fields, int count,
 		goto end;
 	}
 
-	/* Open processes element */
-	ret = mi_lttng_processes_open(writer);
+	/* Open pids element */
+	ret = mi_lttng_pids_open(writer);
 	if (ret) {
 		goto end;
 	}
@@ -606,8 +606,8 @@ static int mi_list_ust_event_fields(struct lttng_event_field *fields, int count,
 			cur_pid = fields[i].event.pid;
 			cmdline = get_cmdline_by_pid(cur_pid);
 			if (!pid_element_open) {
-				/* Open and write a process element */
-				ret = mi_lttng_process(writer, cur_pid, cmdline, 1);
+				/* Open and write a pid element */
+				ret = mi_lttng_pid(writer, cur_pid, cmdline, 1);
 				if (ret) {
 					goto error;
 				}
@@ -661,7 +661,7 @@ static int mi_list_ust_event_fields(struct lttng_event_field *fields, int count,
 		}
 	}
 
-	/* Close processes, domain, domains */
+	/* Close pid, domain, domains */
 	ret = mi_lttng_close_multi_element(writer, 3);
 end:
 	return ret;
diff --git a/src/common/mi-lttng.c b/src/common/mi-lttng.c
index 9d6500b..8fbd064 100644
--- a/src/common/mi-lttng.c
+++ b/src/common/mi-lttng.c
@@ -1199,6 +1199,47 @@ end:
 	return ret;
 }
 
+/*
+ * TODO: move the listing of pid for user agent to process semantic on
+ * mi api bump. The use of process element break the mi api.
+ */
+LTTNG_HIDDEN
+int mi_lttng_pid(struct mi_writer *writer, pid_t pid , const char *name,
+		int is_open)
+{
+	int ret;
+
+	/* Open pid process */
+	ret = mi_lttng_writer_open_element(writer, config_element_pid);
+	if (ret) {
+		goto end;
+	}
+
+	/* Writing pid number */
+	ret = mi_lttng_writer_write_element_signed_int(writer,
+			mi_lttng_element_pid_id, (int)pid);
+	if (ret) {
+		goto end;
+	}
+
+	/* Writing name of the process */
+	if (name) {
+		ret = mi_lttng_writer_write_element_string(writer, config_element_name,
+				name);
+		if (ret) {
+			goto end;
+		}
+	}
+
+	if (!is_open) {
+		/* Closing Pid */
+		ret = mi_lttng_writer_close_element(writer);
+	}
+
+end:
+	return ret;
+}
+
 LTTNG_HIDDEN
 int mi_lttng_targets_open(struct mi_writer *writer)
 {
diff --git a/src/common/mi-lttng.h b/src/common/mi-lttng.h
index 23b7810..5344a23 100644
--- a/src/common/mi-lttng.h
+++ b/src/common/mi-lttng.h
@@ -619,6 +619,25 @@ int mi_lttng_processes_open(struct mi_writer *writer);
  */
 int mi_lttng_process(struct mi_writer *writer, pid_t pid , const char *name,
 		int is_open);
+
+/*
+ * TODO: move pid of lttng list -u to process semantic on mi api bump
+ * Machine interface of a Process.
+ *
+ * writer An instance of a machine interface writer.
+ * pid A PID.
+ *
+ * is_open Defines whether or not the session element shall be closed.
+ *         This should be used carefully and the client
+ *         must close the pid element.
+ *         Use case: nested addition information on a domain
+ *                  ex: channel event.
+ *
+ * Returns zero if the element's value could be written.
+ * Negative values indicate an error.
+ */
+int mi_lttng_pid(struct mi_writer *writer, pid_t pid , const char *name,
+		int is_open);
 /*
  * Machine interface: open a targets element.
  *
diff --git a/src/common/mi_lttng.xsd b/src/common/mi_lttng.xsd
index 11d60d0..24978e4 100644
--- a/src/common/mi_lttng.xsd
+++ b/src/common/mi_lttng.xsd
@@ -273,10 +273,19 @@ THE SOFTWARE.
 		</xs:all>
 	</xs:complexType>
 
-	<!-- Maps to an array of pid -->
+	<!-- map to a pid -->
+	<xs:complexType name="pid_type">
+		<xs:all>
+			<xs:element name="id" type="xs:int" />
+			<xs:element name="name" type="name_type" />
+			<xs:element name="events" type="event_list_type" minOccurs="0" />
+		</xs:all>
+	</xs:complexType>
+
+	<!-- maps to an array of pid -->
 	<xs:complexType name="pids_type">
 		<xs:sequence>
-			<xs:element name="pid" type="xs:int" minOccurs="0" maxOccurs="unbounded" />
+			<xs:element name="pid" type="pid_type" minOccurs="0" maxOccurs="unbounded" />
 		</xs:sequence>
 	</xs:complexType>
 
@@ -339,7 +348,7 @@ THE SOFTWARE.
 		<xs:all>
 			<xs:element name="type" type="domain_type_type" />
 			<xs:element name="buffer_type" type="domain_buffer_type" />
-			<xs:element name="processes" type="processes_type" minOccurs="0" />
+			<xs:element name="pids" type="pids_type" minOccurs="0" />
 			<xs:element name="channels" type="channels_type" minOccurs="0" />
 			<xs:element name="events" type="event_list_type" minOccurs="0" />
 			<xs:element name="trackers" type="trackers_type" minOccurs="0" />
diff --git a/tests/regression/tools/mi/test_mi b/tests/regression/tools/mi/test_mi
index 7f22ee1..47ec1b1 100755
--- a/tests/regression/tools/mi/test_mi
+++ b/tests/regression/tools/mi/test_mi
@@ -48,7 +48,7 @@ XPATH_ENABLE_EVENT_SUCCESS="$XPATH_CMD_OUTPUT/events/event/success/text()"
 XPATH_DISABLE_EVENT_SUCCESS="$XPATH_CMD_OUTPUT/channel/events/event/success/text()"
 XPATH_LIST_DOMAIN="$XPATH_CMD_OUTPUT/sessions/session/domains/domain"
 XPATH_LIST_CHANNEL="$XPATH_CMD_OUTPUT/sessions/session/domains/domain/channels/channel"
-XPATH_LIST_UST_EVENT="$XPATH_CMD_OUTPUT/domains/domain[./type ='UST']/processes/process/events/event"
+XPATH_LIST_UST_EVENT="$XPATH_CMD_OUTPUT/domains/domain[./type ='UST']/pids/pid/events/event"
 XPATH_SNAPSHOT_ADD_SNAPSHOT="$XPATH_CMD_OUTPUT/snapshot_action[./name = 'add-output']/output"
 XPATH_SNAPSHOT_LIST="$XPATH_CMD_OUTPUT/snapshot_action[./name = 'list-output']/output"
 XPATH_SNAPSHOT_DEL="$XPATH_CMD_OUTPUT/snapshot_action[./name = 'del-output']/output"
-- 
2.1.4
