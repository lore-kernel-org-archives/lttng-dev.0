From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 1/1] Fix: sessiond: handle NULL
 control output in session descriptor base path getter
Date: Thu,  5 Sep 2019 15:18:40 -0400
Message-ID: <20190905191840.21430-1-mathieu.desnoyers__1448.0195635528$1567711142$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 46PVpt1LSPzsGX
 for <lttng-dev@lists.lttng.org>; Thu,  5 Sep 2019 15:18:45 -0400 (EDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: jgalar@efficios.com, joraj@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Creating a session with "lttng create --live" without specifying any
URL triggers a NULL pointer exception because the output is not set
when getting the session descriptor base path.

Indeed, the destination output URL will only be set later in
cmd_create_session_from_descriptor(), when setting the default output.

When the default output is used, no base path override is possible,
therefore it is fine to assign the base_path to NULL in the base path
getter.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/common/session-descriptor.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/common/session-descriptor.c b/src/common/session-descriptor.c
index b5fdb067..208eb46f 100644
--- a/src/common/session-descriptor.c
+++ b/src/common/session-descriptor.c
@@ -1186,8 +1186,12 @@ int lttng_session_descriptor_get_base_path(struct lttng_session_descriptor *dst,
 	switch (dst->output_type) {
 	case LTTNG_SESSION_DESCRIPTOR_OUTPUT_TYPE_NETWORK:
 	{
-		*_base_path = dst->output.network.control->subdir[0] ?
-				dst->output.network.control->subdir : NULL;
+		if (dst->output.network.control &&
+				dst->output.network.control->subdir[0]) {
+			*_base_path = dst->output.network.control->subdir;
+		} else {
+			*_base_path = NULL;
+		}
 		break;
 	}
 	case LTTNG_SESSION_DESCRIPTOR_OUTPUT_TYPE_LOCAL:
-- 
2.11.0
