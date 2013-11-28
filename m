From: Paul Woegerer <paul_woegerer@mentor.com>
Subject: [PATCH lttng-ust 2/3] Fix: baddr_statedump deadlock
	with JUL tracing
Date: Thu, 28 Nov 2013 13:26:53 +0100
Message-ID: <1385641614-18806-3-git-send-email-paul_woegerer__7423.64714756167$1385641705$gmane$org@mentor.com>
References: <1385641614-18806-1-git-send-email-paul_woegerer@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1Vm0gm-0001KB-3P
	for lttng-dev@lists.lttng.org; Thu, 28 Nov 2013 07:27:25 -0500
In-Reply-To: <1385641614-18806-1-git-send-email-paul_woegerer@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org, mathieu.desnoyers@efficios.com, dgoulet@efficios.com
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Paul Woegerer <paul_woegerer@mentor.com>
---
 liblttng-ust/lttng-ust-comm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/liblttng-ust/lttng-ust-comm.c b/liblttng-ust/lttng-ust-comm.c
index 2d3766f..0c7fc65 100644
--- a/liblttng-ust/lttng-ust-comm.c
+++ b/liblttng-ust/lttng-ust-comm.c
@@ -1214,10 +1214,12 @@ restart:
 			if (ret) {
 				ERR("Error handling message for %s socket", sock_info->name);
 			} else {
+				int ctor_passed;
 				struct lttng_session *session;
 
+				ctor_passed = sock_info->constructor_sem_posted;
 				session = sock_info->session_enabled;
-				if (session) {
+				if (ctor_passed && session) {
 					sock_info->session_enabled = NULL;
 					lttng_ust_baddr_statedump(session);
 				}
-- 
1.8.4
