From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: [lttng-tool PATCH] Fix compilation fail if NTESTPOINT
	is defined
Date: Tue,  1 Oct 2013 13:28:45 -0400
Message-ID: <1380648525-28642-1-git-send-email-yannick.brosseau__11300.9853791029$1380648603$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1VR3kk-0002yv-3g
	for lttng-dev@lists.lttng.org; Tue, 01 Oct 2013 13:28:59 -0400
Received: by mail-ie0-f178.google.com with SMTP id to1so14976435ieb.9
	for <lttng-dev@lists.lttng.org>; Tue, 01 Oct 2013 10:28:48 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Yannick Brosseau <yannick.brosseau@gmail.com>
---
 src/common/testpoint/testpoint.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/common/testpoint/testpoint.h b/src/common/testpoint/testpoint.h
index dc5be83..f0d79f0 100644
--- a/src/common/testpoint/testpoint.h
+++ b/src/common/testpoint/testpoint.h
@@ -17,8 +17,8 @@
 
 #ifdef NTESTPOINT
 
-#define testpoint(name)
-#define TESTPOINT_DECL(name)
+#define testpoint(name) (0)
+#define TESTPOINT_DECL(name) (0)
 
 #else /* NTESTPOINT */
 
-- 
1.8.4.rc3
