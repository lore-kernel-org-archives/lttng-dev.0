From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [BABELTRACE PATCH 02/18] Hide internal functions of
	ctf-text
Date: Thu, 24 Jan 2013 16:21:34 -0500
Message-ID: <1359062510-7557-2-git-send-email-jdesfossez__9265.70612141422$1359062578$gmane$org@efficios.com>
References: <1359062510-7557-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1TyUFG-0008Dg-Vq
	for lttng-dev@lists.lttng.org; Thu, 24 Jan 2013 16:22:03 -0500
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
 include/babeltrace/ctf-text/types.h |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/babeltrace/ctf-text/types.h b/include/babeltrace/ctf-text/types.h
index d69af90..debecfe 100644
--- a/include/babeltrace/ctf-text/types.h
+++ b/include/babeltrace/ctf-text/types.h
@@ -61,13 +61,21 @@ struct ctf_text_stream_pos *ctf_text_pos(struct stream_pos *pos)
 /*
  * Write only is supported for now.
  */
+BT_HIDDEN
 int ctf_text_integer_write(struct stream_pos *pos, struct definition *definition);
+BT_HIDDEN
 int ctf_text_float_write(struct stream_pos *pos, struct definition *definition);
+BT_HIDDEN
 int ctf_text_string_write(struct stream_pos *pos, struct definition *definition);
+BT_HIDDEN
 int ctf_text_enum_write(struct stream_pos *pos, struct definition *definition);
+BT_HIDDEN
 int ctf_text_struct_write(struct stream_pos *pos, struct definition *definition);
+BT_HIDDEN
 int ctf_text_variant_write(struct stream_pos *pos, struct definition *definition);
+BT_HIDDEN
 int ctf_text_array_write(struct stream_pos *pos, struct definition *definition);
+BT_HIDDEN
 int ctf_text_sequence_write(struct stream_pos *pos, struct definition *definition);
 
 static inline
@@ -82,6 +90,7 @@ void print_pos_tabs(struct ctf_text_stream_pos *pos)
 /*
  * Check if the field must be printed.
  */
+BT_HIDDEN
 int print_field(struct definition *definition);
 
 #endif /* _BABELTRACE_CTF_TEXT_TYPES_H */
-- 
1.7.10.4
