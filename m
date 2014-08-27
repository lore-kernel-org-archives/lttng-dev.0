From: Jonathan Rajotte Julien <jonathan.r.julien@gmail.com>
Subject: [PATCH v2] mi: Fix event attributes printing under
	attributes element
Date: Wed, 27 Aug 2014 16:56:18 -0400
Message-ID: <1409172978-22933-1-git-send-email-jonathan.r.julien__353.176557882939$1409173026$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg20.ericsson.net ([198.24.6.45])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@ericsson.com>)
 id 1XMkGc-0002qG-1i
 for lttng-dev@lists.lttng.org; Wed, 27 Aug 2014 16:56:31 -0400
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

The event attributes (symbol name, address, and offset) where not
printed under the good element. Furthermore the xsd semantic was invalid
on attributes validation

Signed-off-by: Jonathan Rajotte Julien <jonathan.r.julien@gmail.com>
---
 src/common/mi-lttng.c   | 23 ++++++++++++++++++++++-
 src/common/mi_lttng.xsd | 25 +++++--------------------
 2 files changed, 27 insertions(+), 21 deletions(-)

diff --git a/src/common/mi-lttng.c b/src/common/mi-lttng.c
index 83df149..1f8c4ee 100644
--- a/src/common/mi-lttng.c
+++ b/src/common/mi-lttng.c
@@ -914,6 +914,11 @@ int mi_lttng_event_function_probe(struct mi_writer *writer,
 {
 	int ret;
 
+	ret = mi_lttng_writer_open_element(writer, config_element_attributes);
+	if (ret) {
+		goto end;
+	}
+
 	if (event->attr.probe.addr != 0) {
 		/* event probe address */
 		ret = mi_lttng_writer_write_element_unsigned_int(writer,
@@ -936,6 +941,8 @@ int mi_lttng_event_function_probe(struct mi_writer *writer,
 			goto end;
 		}
 	}
+
+	ret = mi_lttng_writer_close_element(writer);
 end:
 	return ret;
 }
@@ -944,9 +951,23 @@ LTTNG_HIDDEN
 int mi_lttng_event_function_entry(struct mi_writer *writer,
 		struct lttng_event *event)
 {
+	int ret;
+
+	ret = mi_lttng_writer_open_element(writer, config_element_attributes);
+	if (ret) {
+		goto end;
+	}
+
 	/* event probe symbol_name */
-	return mi_lttng_writer_write_element_string(writer,
+	ret = mi_lttng_writer_write_element_string(writer,
 			config_element_symbol_name, event->attr.ftrace.symbol_name);
+	if (ret) {
+		goto end;
+	}
+
+	ret = mi_lttng_writer_close_element(writer);
+end:
+	return ret;
 }
 
 LTTNG_HIDDEN
diff --git a/src/common/mi_lttng.xsd b/src/common/mi_lttng.xsd
index d2cc5d4..f9e784a 100644
--- a/src/common/mi_lttng.xsd
+++ b/src/common/mi_lttng.xsd
@@ -143,28 +143,13 @@ THE SOFTWARE.
 		</xs:restriction>
 	</xs:simpleType>
 
-	<!-- Maps to the lttng_event_probe_attr struct -->
-	<xs:complexType name="event_probe_attributes_type">
-		<xs:all>
-			<xs:element name="address" type="uint64_type" />
-			<xs:element name="offset" type="uint64_type" />
-			<xs:element name="symbol_name" type="name_type" />
-		</xs:all>
-	</xs:complexType>
-
-	<!-- Maps to the lttng_event_function_attr struct -->
-	<xs:complexType name="event_ftrace_attributes_type">
-		<xs:all>
-			<xs:element name="symbol_name" type="name_type" />
-		</xs:all>
-	</xs:complexType>
-
 	<!-- Maps to per event type configuration -->
 	<xs:complexType name="event_attributes_type">
-		<xs:choice>
-			<xs:element name="probe_attributes" type="event_probe_attributes_type" />
-			<xs:element name="function_attributes" type="event_ftrace_attributes_type" />
-		</xs:choice>
+		<xs:all>
+			<xs:element name="symbol_name" type="name_type" minOccurs="0" />
+			<xs:element name="address" type="uint64_type" minOccurs="0" />
+			<xs:element name="offset" type="uint64_type" minOccurs="0" />
+		</xs:all>
 	</xs:complexType>
 
 	<!-- Maps to exclusion type -->
-- 
2.0.4
