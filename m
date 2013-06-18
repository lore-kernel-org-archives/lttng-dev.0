From: Romain Lenglet <romain.lenglet@berabera.info>
Subject: [PATCH] lttng-gen-tp: remove support for # comments
Date: Tue, 18 Jun 2013 10:49:24 -0700
Message-ID: <1371577764-7740-1-git-send-email-romain.lenglet__44424.341110471$1371578105$gmane$org@berabera.info>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from hanabi.berabera.info ([91.121.79.76])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <romain.lenglet@berabera.info>) id 1Up02R-0006TU-UR
	for lttng-dev@lists.lttng.org; Tue, 18 Jun 2013 13:49:52 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: Romain Lenglet <romain.lenglet@berabera.info>
List-Id: lttng-dev@lists.lttng.org

Support #define, #include, etc. in tracepoint files.

Signed-off-by: Romain Lenglet <romain.lenglet@berabera.info>
---
 doc/man/lttng-gen-tp.1 |    2 +-
 tools/lttng-gen-tp     |    3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/doc/man/lttng-gen-tp.1 b/doc/man/lttng-gen-tp.1
index 84c05c9..96f02c4 100644
--- a/doc/man/lttng-gen-tp.1
+++ b/doc/man/lttng-gen-tp.1
@@ -64,7 +64,7 @@ TRACEPOINT_LOGLEVEL.
 (See lttng-ust(3) for the complete list of available definition.)
 
 You write them as you would write them in a C header file. You can add
-comments with \fB/* */\fP, \fB//\fP and \fB#\fP.
+comments with \fB/* */\fP and \fB//\fP.
 
 The provider name (the first field of TRACEPOINT_EVENT) must be
 the same for the whole file.
diff --git a/tools/lttng-gen-tp b/tools/lttng-gen-tp
index 5937dfd..5ea221b 100755
--- a/tools/lttng-gen-tp
+++ b/tools/lttng-gen-tp
@@ -159,9 +159,6 @@ class TemplateFile:
 
         self.text = f.read()
 
-        #Remove # comments (from input and output file
-        removeComments = re.compile("#.*$",flags=re.MULTILINE)
-        self.text = removeComments.sub("",self.text)
         #Remove // comments
         removeLineComment = re.compile("\/\/.*$",flags=re.MULTILINE)
         nolinecomment = removeLineComment.sub("",self.text)
-- 
1.7.9.5
