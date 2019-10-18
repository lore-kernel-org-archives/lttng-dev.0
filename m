From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-tools] Fix typo 'Attemp' -> 'Attempt'
Date: Fri, 18 Oct 2019 17:12:22 -0400
Message-ID: <20191018211222.4196-1-mjeanson__2594.35557979799$1571433172$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 46vzJN5yYMzpcB
 for <lttng-dev@lists.lttng.org>; Fri, 18 Oct 2019 17:12:36 -0400 (EDT)
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

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 src/common/trace-chunk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/common/trace-chunk.c b/src/common/trace-chunk.c
index afba60b38..20dbd0a5e 100644
--- a/src/common/trace-chunk.c
+++ b/src/common/trace-chunk.c
@@ -1269,7 +1269,7 @@ lttng_trace_chunk_registry_publish_chunk(
 				 *
 				 * Re-attempt to publish.
 				 */
-				ERR("Attemp to publish a trace chunk to the chunk registry raced with a trace chunk deletion");
+				ERR("Attempt to publish a trace chunk to the chunk registry raced with a trace chunk deletion");
 				continue;
 			}
 		}
-- 
2.17.1
