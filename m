From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [BABELTRACE PATCH 18/18] namespace the lookup_integer
	function
Date: Thu, 24 Jan 2013 16:21:50 -0500
Message-ID: <1359062510-7557-18-git-send-email-jdesfossez__46887.9005675719$1359064937$gmane$org@efficios.com>
References: <1359062510-7557-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1TyUFZ-0008GI-Q7
	for lttng-dev@lists.lttng.org; Thu, 24 Jan 2013 16:22:22 -0500
In-Reply-To: <1359062510-7557-1-git-send-email-jdesfossez@efficios.com>
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

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 formats/ctf/ctf.c          |    8 ++++----
 include/babeltrace/types.h |    2 +-
 types/types.c              |    2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
index ba403aa..deb9a66 100644
--- a/formats/ctf/ctf.c
+++ b/formats/ctf/ctf.c
@@ -427,7 +427,7 @@ int ctf_read_event(struct stream_pos *ppos, struct ctf_stream_definition *stream
 		if (unlikely(ret))
 			goto error;
 		/* lookup event id */
-		integer_definition = lookup_integer(&stream->stream_event_header->p, "id", FALSE);
+		integer_definition = bt_lookup_integer(&stream->stream_event_header->p, "id", FALSE);
 		if (integer_definition) {
 			id = integer_definition->value._unsigned;
 		} else {
@@ -441,7 +441,7 @@ int ctf_read_event(struct stream_pos *ppos, struct ctf_stream_definition *stream
 
 		variant = bt_lookup_variant(&stream->stream_event_header->p, "v");
 		if (variant) {
-			integer_definition = lookup_integer(variant, "id", FALSE);
+			integer_definition = bt_lookup_integer(variant, "id", FALSE);
 			if (integer_definition) {
 				id = integer_definition->value._unsigned;
 			}
@@ -450,13 +450,13 @@ int ctf_read_event(struct stream_pos *ppos, struct ctf_stream_definition *stream
 
 		/* lookup timestamp */
 		stream->has_timestamp = 0;
-		integer_definition = lookup_integer(&stream->stream_event_header->p, "timestamp", FALSE);
+		integer_definition = bt_lookup_integer(&stream->stream_event_header->p, "timestamp", FALSE);
 		if (integer_definition) {
 			ctf_update_timestamp(stream, integer_definition);
 			stream->has_timestamp = 1;
 		} else {
 			if (variant) {
-				integer_definition = lookup_integer(variant, "timestamp", FALSE);
+				integer_definition = bt_lookup_integer(variant, "timestamp", FALSE);
 				if (integer_definition) {
 					ctf_update_timestamp(stream, integer_definition);
 					stream->has_timestamp = 1;
diff --git a/include/babeltrace/types.h b/include/babeltrace/types.h
index f01a11c..d742b40 100644
--- a/include/babeltrace/types.h
+++ b/include/babeltrace/types.h
@@ -518,7 +518,7 @@ void bt_append_scope_path(const char *path, GArray *q);
  */
 struct definition *bt_lookup_definition(const struct definition *definition,
 				     const char *field_name);
-struct definition_integer *lookup_integer(const struct definition *definition,
+struct definition_integer *bt_lookup_integer(const struct definition *definition,
 					  const char *field_name,
 					  int signedness);
 struct definition_enum *bt_lookup_enum(const struct definition *definition,
diff --git a/types/types.c b/types/types.c
index 25ce715..3e20dfe 100644
--- a/types/types.c
+++ b/types/types.c
@@ -624,7 +624,7 @@ struct definition *bt_lookup_definition(const struct definition *definition,
 					     scope);
 }
 
-struct definition_integer *lookup_integer(const struct definition *definition,
+struct definition_integer *bt_lookup_integer(const struct definition *definition,
 					  const char *field_name,
 					  int signedness)
 {
-- 
1.7.10.4
