From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools 3/5] Cleanup: remove unused internal
 lttng_session_descriptor_get_base_path
Date: Fri, 25 Oct 2019 18:12:02 -0400
Message-ID: <20191025221204.29696-3-jonathan.rajotte-julien__21119.9904255167$1572041638$gmane$org@efficios.com>
References: <20191025221204.29696-1-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 470JHz0KQYz1PY3
 for <lttng-dev@lists.lttng.org>; Fri, 25 Oct 2019 18:12:15 -0400 (EDT)
In-Reply-To: <20191025221204.29696-1-jonathan.rajotte-julien@efficios.com>
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

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---

Feel free to squash this into the previous commits.

---
 include/lttng/session-descriptor-internal.h |  4 ----
 src/common/session-descriptor.c             | 23 ---------------------
 2 files changed, 27 deletions(-)

diff --git a/include/lttng/session-descriptor-internal.h b/include/lttng/session-descriptor-internal.h
index 18a70bad4..09d493393 100644
--- a/include/lttng/session-descriptor-internal.h
+++ b/include/lttng/session-descriptor-internal.h
@@ -109,8 +109,4 @@ int lttng_session_descriptor_assign(
 		struct lttng_session_descriptor *dst_descriptor,
 		const struct lttng_session_descriptor *src_descriptor);
 
-LTTNG_HIDDEN
-int lttng_session_descriptor_get_base_path(struct lttng_session_descriptor *dst,
-		const char **base_path);
-
 #endif /* LTTNG_SESSION_DESCRIPTOR_INTERNAL_H */
diff --git a/src/common/session-descriptor.c b/src/common/session-descriptor.c
index 6dea5ee7c..224138dd2 100644
--- a/src/common/session-descriptor.c
+++ b/src/common/session-descriptor.c
@@ -1176,26 +1176,3 @@ int lttng_session_descriptor_assign(
 end:
 	return ret;
 }
-
-LTTNG_HIDDEN
-int lttng_session_descriptor_get_base_path(struct lttng_session_descriptor *dst,
-		const char **_base_path)
-{
-	switch (dst->output_type) {
-	case LTTNG_SESSION_DESCRIPTOR_OUTPUT_TYPE_NETWORK:
-	{
-		if (dst->output.network.control &&
-				dst->output.network.control->subdir[0]) {
-			*_base_path = dst->output.network.control->subdir;
-		} else {
-			*_base_path = NULL;
-		}
-		break;
-	}
-	case LTTNG_SESSION_DESCRIPTOR_OUTPUT_TYPE_LOCAL:
-	case LTTNG_SESSION_DESCRIPTOR_OUTPUT_TYPE_NONE:
-		*_base_path = NULL;
-		break;
-	}
-	return 0;
-}
-- 
2.17.1
