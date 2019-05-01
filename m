From: Yannick Lamarre <ylamarre@efficios.com>
Subject: [RFC PATCH lttng-tools v2 11/20] Add serialized
 versions of lttng_event_context structs
Date: Wed,  1 May 2019 15:34:35 -0400
Message-ID: <20190501193444.17403-12-ylamarre__21808.3847941429$1556739344$gmane$org@efficios.com>
References: <20190501193444.17403-1-ylamarre@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44vTB724fdz1Kb9
 for <lttng-dev@lists.lttng.org>; Wed,  1 May 2019 15:34:55 -0400 (EDT)
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

Serialized versions of lttng_event_context and lttng_event_perf_counter_ctx are
packed structures to be used in communication protocols for consistent
sizes across platforms. The serialized versions are stripped of pointers
and padding.

Pointers are removed since their size can vary across processes on
platforms supporting multiple pointer sizes (32bits vs 64bits) and this
creates mismatches in structure sizes.
Padding is also removed since it defeats the purpose of a packed struct
and is not used to extend the protocols.

Signed-off-by: Yannick Lamarre <ylamarre@efficios.com>
---
Reworded commit message to better justify removal of pointer and padding
fields.

 include/lttng/event-internal.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/lttng/event-internal.h b/include/lttng/event-internal.h
index f8130e3b..25a88448 100644
--- a/include/lttng/event-internal.h
+++ b/include/lttng/event-internal.h
@@ -27,6 +27,17 @@
 
 struct lttng_userspace_probe_location;
 
+struct lttng_event_perf_counter_ctx_serialized {
+	uint32_t type;
+	uint64_t config;
+	char name[LTTNG_SYMBOL_NAME_LEN];
+} LTTNG_PACKED;
+
+struct lttng_event_context_serialized {
+	uint32_t ctx; /* enum lttng_event_context_type */
+	struct lttng_event_perf_counter_ctx_serialized perf_counter;
+} LTTNG_PACKED;
+
 struct lttng_event_extended {
 	/*
 	 * exclusions and filter_expression are only set when the lttng_event
-- 
2.11.0
