From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH babeltrace v3] Do not use g_list_free_full
Date: Mon,  4 Jan 2016 17:04:23 -0500
Message-ID: <1451945063-9730-1-git-send-email-jonathan.rajotte-julien__11674.3668717847$1451945133$gmane$org@efficios.com>
References: <1451943430-7346-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1aGDEz-0008N0-Cc
 for lttng-dev@lists.lttng.org; Mon, 04 Jan 2016 17:04:43 -0500
In-Reply-To: <1451943430-7346-1-git-send-email-jonathan.rajotte-julien@efficios.com>
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

v3: we support from 2.22 not 2.28.
--

Babeltrace support glib all the way back to 2.22 and g_list_free_full
exists from 2.28.0 (backported to 2.27.2) only.

The replacement is the current implementation found in modern glib.

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 formats/ctf/ir/visitor.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/formats/ctf/ir/visitor.c b/formats/ctf/ir/visitor.c
index 9b65ed5..704a804 100644
--- a/formats/ctf/ir/visitor.c
+++ b/formats/ctf/ir/visitor.c
@@ -724,7 +724,8 @@ end:
 		g_free(name_copy);
 	}
 	if (path_tokens) {
-		g_list_free_full(path_tokens, free);
+		g_list_foreach(path_tokens, (GFunc) free, NULL);
+		g_list_free(path_tokens);
 	}
 	return ret;
 error:
-- 
2.5.0
