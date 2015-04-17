From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools] Save/load: add support for shared
	memory path
Date: Fri, 17 Apr 2015 17:26:41 -0400
Message-ID: <1429306001-12872-1-git-send-email-jonathan.rajotte-julien__35683.7665699006$1429306080$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1YjDmp-0007rW-Mi
 for lttng-dev@lists.lttng.org; Fri, 17 Apr 2015 17:27:00 -0400
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

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 src/bin/lttng-sessiond/save.c          | 10 ++++++++++
 src/common/config/config-session-abi.h |  1 +
 src/common/config/config.c             | 19 +++++++++++++++++++
 src/common/config/session.xsd          |  1 +
 4 files changed, 31 insertions(+)

diff --git a/src/bin/lttng-sessiond/save.c b/src/bin/lttng-sessiond/save.c
index 0c6894b..d6316ef 100644
--- a/src/bin/lttng-sessiond/save.c
+++ b/src/bin/lttng-sessiond/save.c
@@ -1663,6 +1663,16 @@ int save_session(struct ltt_session *session,
 		goto end;
 	}
 
+	if(session->shm_path[0] != '\0') {
+		ret = config_writer_write_element_string(writer,
+				config_element_shared_memory_path,
+				session->shm_path);
+		if (ret) {
+			ret = LTTNG_ERR_SAVE_IO_FAIL;
+			goto end;
+		}
+	}
+
 	ret = save_domains(writer, session);
 	if (ret) {
 		goto end;
diff --git a/src/common/config/config-session-abi.h b/src/common/config/config-session-abi.h
index 8cbff25..8ac5cb0 100644
--- a/src/common/config/config-session-abi.h
+++ b/src/common/config/config-session-abi.h
@@ -67,6 +67,7 @@ const char * const config_element_data_uri;
 const char * const config_element_max_size;
 const char * const config_element_pid;
 const char * const config_element_pids;
+const char * const config_element_shared_memory_path;
 
 const char * const config_domain_type_kernel;
 const char * const config_domain_type_ust;
diff --git a/src/common/config/config.c b/src/common/config/config.c
index d84e38b..bc4f0c0 100644
--- a/src/common/config/config.c
+++ b/src/common/config/config.c
@@ -117,6 +117,7 @@ const char * const config_element_data_uri = "data_uri";
 const char * const config_element_max_size = "max_size";
 const char * const config_element_pid = "pid";
 const char * const config_element_pids = "pids";
+const char * const config_element_shared_memory_path = "shared_memory_path";
 
 const char * const config_domain_type_kernel = "KERNEL";
 const char * const config_domain_type_ust = "UST";
@@ -2172,6 +2173,7 @@ int process_session_node(xmlNodePtr session_node, const char *session_name,
 	int ret, started = -1, snapshot_mode = -1;
 	uint64_t live_timer_interval = UINT64_MAX;
 	char *name = NULL;
+	char *shm_path = NULL;
 	xmlNodePtr domains_node = NULL;
 	xmlNodePtr output_node = NULL;
 	xmlNodePtr node;
@@ -2216,6 +2218,16 @@ int process_session_node(xmlNodePtr session_node, const char *session_name,
 			config_element_output)) {
 			/* output */
 			output_node = node;
+		} else if (!shm_path && !strcmp((const char *) node->name,
+					config_element_shared_memory_path)) {
+			/* shared memory path */
+			xmlChar *node_content = xmlNodeGetContent(node);
+			if (!node_content) {
+				ret = -LTTNG_ERR_NOMEM;
+				goto error;
+			}
+
+			shm_path = (char *) node_content;
 		} else {
 			/* attributes, snapshot_mode or live_timer_interval */
 			xmlNodePtr attributes_child =
@@ -2356,6 +2368,13 @@ domain_init_error:
 		goto error;
 	}
 
+	if (shm_path) {
+		ret = lttng_set_session_shm_path(name, shm_path);
+		if (ret) {
+			goto error;
+		}
+	}
+
 	for (node = xmlFirstElementChild(domains_node); node;
 		node = xmlNextElementSibling(node)) {
 		ret = process_domain_node(node, name);
diff --git a/src/common/config/session.xsd b/src/common/config/session.xsd
index 6d74e85..0a7458d 100644
--- a/src/common/config/session.xsd
+++ b/src/common/config/session.xsd
@@ -279,6 +279,7 @@ elementFormDefault="qualified" version="2.5">
 <xs:complexType name="session_type">
 	<xs:all>
 		<xs:element name="name" type="name_type"/>
+		<xs:element name="shared_memory_path" type="xs:string" minOccurs="0"/>
 		<xs:element name="domains" type="domain_list_type" minOccurs="0"/>
 		<xs:element name="started" type="xs:boolean" default="0" minOccurs="0"/>
 		<xs:element name="attributes" type="session_attributes_type" minOccurs="0"/>
-- 
2.1.4
