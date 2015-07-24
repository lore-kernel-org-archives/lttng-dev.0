From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools 2/2] Fix: do not spawn sessiond on
	track/untrack commands
Date: Fri, 24 Jul 2015 17:43:00 -0400
Message-ID: <1437774180-32746-2-git-send-email-jonathan.rajotte-julien__28647.4574044862$1437774261$gmane$org@efficios.com>
References: <1437774180-32746-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1ZIkkP-0005kI-8e
 for lttng-dev@lists.lttng.org; Fri, 24 Jul 2015 17:43:17 -0400
In-Reply-To: <1437774180-32746-1-git-send-email-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 src/bin/lttng/lttng.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/bin/lttng/lttng.c b/src/bin/lttng/lttng.c
index 13c7732..4cc320c 100644
--- a/src/bin/lttng/lttng.c
+++ b/src/bin/lttng/lttng.c
@@ -432,7 +432,9 @@ static int check_args_no_sessiond(int argc, char **argv)
 				strncmp(argv[i], "--list-options", sizeof("--list-options")) == 0 ||
 				strncmp(argv[i], "--list-commands", sizeof("--list-commands")) == 0 ||
 				strncmp(argv[i], "version", sizeof("version")) == 0 ||
-				strncmp(argv[i], "view", sizeof("view")) == 0) {
+				strncmp(argv[i], "view", sizeof("view")) == 0 ||
+				strncmp(argv[i], "track", sizeof("track")) == 0 ||
+				strncmp(argv[i], "untrack", sizeof("untrack")) == 0) {
 			return 1;
 		}
 	}
-- 
2.1.4
