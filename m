From: Jonathan Rajotte Julien <jonathan.r.julien@gmail.com>
Subject: [PATCH lttng-tool] Fix: mi: Make sure GIT_VERSION
	symbol always exist
Date: Mon, 28 Jul 2014 17:54:36 -0400
Message-ID: <1406584476-32009-1-git-send-email-jonathan.r.julien__21974.8160838664$1406584601$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg21.ericsson.net ([198.24.6.65])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@ericsson.com>)
 id 1XBssq-0006sA-L5
 for lttng-dev@lists.lttng.org; Mon, 28 Jul 2014 17:55:10 -0400
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

The use of GIT_VERSION symbol in mi to express the position in git tree
force the need to have it defined for each type of build.

This make sure that a build from source file only (git scm not present) is possible.

Signed-off-by: Jonathan Rajotte Julien <jonathan.r.julien@gmail.com>
---
 include/Makefile.am    | 15 ++-------------
 include/version.h.tmpl |  6 +++++-
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/include/Makefile.am b/include/Makefile.am
index d40cb4a..ca515da 100644
--- a/include/Makefile.am
+++ b/include/Makefile.am
@@ -47,19 +47,8 @@ version.h:
 			## don't want to update the file if it is already up to date
 			##
 			if [ $$(grep -cE "^#define GIT_VERSION \"?$${git_version}\"?$$" "$${version_h}") -eq 0 ]; then \
-				if [ $$(grep -c "^#define GIT_VERSION" "$${version_h}") -gt 0 ]; then \
-					##
-					## If there is already a GIT_VERSION defined,
-					## we just replace it by the new version
-					##
-					sed -i "s'^#define GIT_VERSION.*$$'#define GIT_VERSION \"$${git_version}\"'" "$${version_h}"; \
-				else \
-					##
-					## Else, we add a GIT_VERSION define
-					## containing our new version.
-					##
-					sed -i "s'^\(#define VERSION_H.*\)$$'\1\n\n#define GIT_VERSION \"$${git_version}\"'" "$${version_h}"; \
-				fi; \
+				sed -i "s'^#define GIT_VERSION.*$$'#define GIT_VERSION \"$${git_version}\"'" "$${version_h}"; \
+				sed -i "s'^#define GIT_SOURCE.*$$'#define GIT_SOURCE 1'" "$${version_h}"; \
 			fi; \
 		fi; \
 	fi)
diff --git a/include/version.h.tmpl b/include/version.h.tmpl
index 2cab733..3ef6905 100644
--- a/include/version.h.tmpl
+++ b/include/version.h.tmpl
@@ -20,10 +20,14 @@
 #ifndef VERSION_H
 #define VERSION_H
 
+
+#define GIT_SOURCE 0
+#define GIT_VERSION ""
+
 /*
  * Define the macro containing the FULL version
  */
-#ifdef GIT_VERSION
+#if GIT_SOURCE
 #define FULL_VERSION "" GIT_VERSION
 #else /* GIT_VERSION */
 #define FULL_VERSION "" VERSION
-- 
2.0.0
