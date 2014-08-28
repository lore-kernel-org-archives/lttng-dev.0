From: Jonathan Rajotte Julien <jonathan.r.julien@gmail.com>
Subject: [PATCH lttng-tool] Fix: mi print of probe attributes +
	validation
Date: Thu, 28 Aug 2014 16:51:09 -0400
Message-ID: <1409259069-1165-1-git-send-email-jonathan.r.julien__31639.4633766778$1409259343$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg21.ericsson.net ([198.24.6.65])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@ericsson.com>)
 id 1XN6iZ-0002Zm-Qw
 for lttng-dev@lists.lttng.org; Thu, 28 Aug 2014 16:54:53 -0400
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

Signed-off-by: Jonathan Rajotte Julien <jonathan.r.julien@gmail.com>
---
 src/common/mi-lttng.c   | 37 ++++++++++++++++++++++++++++++++++++-
 src/common/mi_lttng.xsd |  6 +++---
 2 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/src/common/mi-lttng.c b/src/common/mi-lttng.c
index 83df149..a250546 100644
--- a/src/common/mi-lttng.c
+++ b/src/common/mi-lttng.c
@@ -914,6 +914,16 @@ int mi_lttng_event_function_probe(struct mi_writer *writer,
 {
 	int ret;
 
+	ret = mi_lttng_writer_open_element(writer, config_element_attributes);
+	if (ret) {
+		goto end;
+	}
+
+	ret = mi_lttng_writer_open_element(writer, config_element_probe_attributes);
+	if (ret) {
+		goto end;
+	}
+
 	if (event->attr.probe.addr != 0) {
 		/* event probe address */
 		ret = mi_lttng_writer_write_element_unsigned_int(writer,
@@ -936,6 +946,9 @@ int mi_lttng_event_function_probe(struct mi_writer *writer,
 			goto end;
 		}
 	}
+
+	/* Close probe_attributes and attributes */
+	ret = mi_lttng_close_multi_element(writer, 2);
 end:
 	return ret;
 }
@@ -944,9 +957,29 @@ LTTNG_HIDDEN
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
+	ret = mi_lttng_writer_open_element(writer, config_element_probe_attributes);
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
+	/* Close function_attributes and attributes */
+	ret = mi_lttng_close_multi_element(writer, 2);
+end:
+	return ret;
 }
 
 LTTNG_HIDDEN
@@ -976,6 +1009,8 @@ int mi_lttng_event(struct mi_writer *writer,
 		}
 		break;
 	}
+	case LTTNG_EVENT_FUNCTION:
+		/* Fallthrough */
 	case LTTNG_EVENT_PROBE:
 		ret = mi_lttng_event_function_probe(writer, event);
 		break;
diff --git a/src/common/mi_lttng.xsd b/src/common/mi_lttng.xsd
index d2cc5d4..b115c61 100644
--- a/src/common/mi_lttng.xsd
+++ b/src/common/mi_lttng.xsd
@@ -146,9 +146,9 @@ THE SOFTWARE.
 	<!-- Maps to the lttng_event_probe_attr struct -->
 	<xs:complexType name="event_probe_attributes_type">
 		<xs:all>
-			<xs:element name="address" type="uint64_type" />
-			<xs:element name="offset" type="uint64_type" />
-			<xs:element name="symbol_name" type="name_type" />
+			<xs:element name="address" type="uint64_type" minOccurs="0" />
+			<xs:element name="offset" type="uint64_type" minOccurs="0" />
+			<xs:element name="symbol_name" type="name_type" minOccurs="0" />
 		</xs:all>
 	</xs:complexType>
 
-- 
2.0.4
