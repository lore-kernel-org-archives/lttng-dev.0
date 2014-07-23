From: Jonathan Rajotte Julien <jonathan.r.julien@gmail.com>
Subject: [PATCH lttng-tool] Fix: print version number even if on
	a development git branch
Date: Wed, 23 Jul 2014 14:38:20 -0400
Message-ID: <1406140700-7627-1-git-send-email-jonathan.r.julien__44467.9985907443$1406168839$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg21.ericsson.net ([198.24.6.65])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@ericsson.com>)
 id 1XA8jq-0001eK-4f
 for lttng-dev@lists.lttng.org; Wed, 23 Jul 2014 22:26:35 -0400
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

The use of GIT_VERSION as a full replacement for FULL_NAME and
discarding the VERSION macro does not indicate which version
is lttng at.

This able lttng to be more verbose about the overall version
even if we are on a different git branch than master.

Signed-off-by: Jonathan Rajotte Julien <jonathan.r.julien@gmail.com>
---
 include/Makefile.am    | 13 +------------
 include/version.h.tmpl |  7 ++-----
 2 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/include/Makefile.am b/include/Makefile.am
index d40cb4a..ab13d86 100644
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
+					## Replace it by the new version
 					sed -i "s'^#define GIT_VERSION.*$$'#define GIT_VERSION \"$${git_version}\"'" "$${version_h}"; \
-				else \
-					##
-					## Else, we add a GIT_VERSION define
-					## containing our new version.
-					##
-					sed -i "s'^\(#define VERSION_H.*\)$$'\1\n\n#define GIT_VERSION \"$${git_version}\"'" "$${version_h}"; \
-				fi; \
 			fi; \
 		fi; \
 	fi)
diff --git a/include/version.h.tmpl b/include/version.h.tmpl
index 2cab733..2d69456 100644
--- a/include/version.h.tmpl
+++ b/include/version.h.tmpl
@@ -20,13 +20,10 @@
 #ifndef VERSION_H
 #define VERSION_H
 
+#define GIT_VERSION ""
 /*
  * Define the macro containing the FULL version
  */
-#ifdef GIT_VERSION
-#define FULL_VERSION "" GIT_VERSION
-#else /* GIT_VERSION */
-#define FULL_VERSION "" VERSION
-#endif /* GIT_VERSION */
+#define FULL_VERSION ""VERSION " " GIT_VERSION
 
 #endif /* VERSION_H */
-- 
2.0.0
