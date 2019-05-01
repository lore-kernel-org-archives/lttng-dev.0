From: Yannick Lamarre <ylamarre@efficios.com>
Subject: [RFC PATCH lttng-tools v2 17/20] Add serialized
 versions of lttng_snapshot_output structs
Date: Wed,  1 May 2019 15:34:41 -0400
Message-ID: <20190501193444.17403-18-ylamarre__18283.5957779147$1556739668$gmane$org@efficios.com>
References: <20190501193444.17403-1-ylamarre@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44vTB846LMz1KcQ
 for <lttng-dev@lists.lttng.org>; Wed,  1 May 2019 15:34:56 -0400 (EDT)
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

Serialized version of lttng_snapshot_output is a packed structure to be
used in communication protocols for consistent size across platforms.
The serialized version is stripped of pointers and padding.

Pointers are removed since their size can vary across processes on
platforms supporting multiple pointer sizes (32bits vs 64bits) and this
creates mismatches in structure sizes.
Padding is also removed since it defeats the purpose of a packed struct
and is not used to extend the protocols.

Signed-off-by: Yannick Lamarre <ylamarre@efficios.com>
---
Reworded commit message to better justify removal of pointer and padding
fields.

 include/lttng/snapshot-internal.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/lttng/snapshot-internal.h b/include/lttng/snapshot-internal.h
index b7391c22..9bde25fb 100644
--- a/include/lttng/snapshot-internal.h
+++ b/include/lttng/snapshot-internal.h
@@ -21,6 +21,7 @@
 #include <limits.h>
 #include <stdint.h>
 #include <lttng/constant.h>
+#include <common/macros.h>
 
 /*
  * Object used for the snapshot API. This is opaque to the public library.
@@ -45,6 +46,14 @@ struct lttng_snapshot_output {
 	char data_url[PATH_MAX];
 };
 
+struct lttng_snapshot_output_serialized {
+	uint32_t id;
+	uint64_t max_size;
+	char name[LTTNG_NAME_MAX];
+	char ctrl_url[PATH_MAX];
+	char data_url[PATH_MAX];
+} LTTNG_PACKED;
+
 /*
  * Snapshot output list object opaque to the user.
  */
-- 
2.11.0
