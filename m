From: Jonathan Rajotte Julien <jonathan.r.julien@gmail.com>
Subject: [PATCH lttng-tool] Always print GIT_VERSION even if
	empty
Date: Mon, 28 Jul 2014 15:43:29 -0400
Message-ID: <1406576609-28197-1-git-send-email-jonathan.r.julien__4578.92102790556$1406576781$gmane$org@gmail.com>
References: <1406140700-7627-1-git-send-email-jonathan.r.julien@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg20.ericsson.net ([198.24.6.45])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@ericsson.com>)
 id 1XBqpg-00063S-5O
 for lttng-dev@lists.lttng.org; Mon, 28 Jul 2014 15:43:45 -0400
In-Reply-To: <1406140700-7627-1-git-send-email-jonathan.r.julien@gmail.com>
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

Adjustment from last proposed patch. Less crowded and more standard.
This should not break any packaging.

feedback?

Signed-off-by: Jonathan Rajotte Julien <jonathan.r.julien@gmail.com>
---
 include/Makefile.am              | 14 +-------------
 include/version.h.tmpl           |  9 +--------
 src/bin/lttng/commands/version.c |  2 +-
 src/bin/lttng/lttng.c            |  4 ++--
 4 files changed, 5 insertions(+), 24 deletions(-)

diff --git a/include/Makefile.am b/include/Makefile.am
index d40cb4a..89b084d 100644
--- a/include/Makefile.am
+++ b/include/Makefile.am
@@ -47,19 +47,7 @@ version.h:
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
 			fi; \
 		fi; \
 	fi)
diff --git a/include/version.h.tmpl b/include/version.h.tmpl
index 2cab733..861a477 100644
--- a/include/version.h.tmpl
+++ b/include/version.h.tmpl
@@ -20,13 +20,6 @@
 #ifndef VERSION_H
 #define VERSION_H
 
-/*
- * Define the macro containing the FULL version
- */
-#ifdef GIT_VERSION
-#define FULL_VERSION "" GIT_VERSION
-#else /* GIT_VERSION */
-#define FULL_VERSION "" VERSION
-#endif /* GIT_VERSION */
+#define GIT_VERSION ""
 
 #endif /* VERSION_H */
diff --git a/src/bin/lttng/commands/version.c b/src/bin/lttng/commands/version.c
index 13e5c99..768ebb5 100644
--- a/src/bin/lttng/commands/version.c
+++ b/src/bin/lttng/commands/version.c
@@ -164,7 +164,7 @@ int cmd_version(int argc, const char **argv)
 	if (lttng_opt_mi) {
 		ret = print_mi();
 	} else {
-		MSG("lttng version " FULL_VERSION " - " VERSION_NAME);
+		MSG("lttng version " VERSION " - " VERSION_NAME " - " GIT_VERSION);
 		MSG("\n" VERSION_DESCRIPTION "\n");
 		MSG("Web site: http://lttng.org");
 		MSG("\n%s", lttng_license);
diff --git a/src/bin/lttng/lttng.c b/src/bin/lttng/lttng.c
index bad57fd..41232be 100644
--- a/src/bin/lttng/lttng.c
+++ b/src/bin/lttng/lttng.c
@@ -90,7 +90,7 @@ static struct cmd_struct commands[] =  {
 
 static void usage(FILE *ofp)
 {
-	fprintf(ofp, "LTTng Trace Control " FULL_VERSION" - " VERSION_NAME"\n\n");
+	fprintf(ofp, "LTTng Trace Control " VERSION " - " VERSION_NAME" - " GIT_VERSION "\n\n");
 	fprintf(ofp, "usage: lttng [OPTIONS] <COMMAND> [<ARGS>]\n");
 	fprintf(ofp, "\n");
 	fprintf(ofp, "Options:\n");
@@ -134,7 +134,7 @@ static void usage(FILE *ofp)
 
 static void version(FILE *ofp)
 {
-	fprintf(ofp, "%s (LTTng Trace Control) " FULL_VERSION" - " VERSION_NAME"\n",
+	fprintf(ofp, "%s (LTTng Trace Control) " VERSION" - " VERSION_NAME" - " GIT_VERSION "\n",
 			progname);
 }
 
-- 
2.0.0
