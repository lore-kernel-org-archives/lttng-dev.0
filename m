From: Michael Jeanson <mjeanson@efficios.com>
Subject: [RFC PATCH lttng-tools 4/5] Add comments to kmod
	functions
Date: Fri, 12 Feb 2016 16:31:47 -0500
Message-ID: <1455312708-462-4-git-send-email-mjeanson__13129.0221041583$1455312870$gmane$org@efficios.com>
References: <1455312708-462-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mjeanson@efficios.com>) id 1aULK8-00042B-4J
 for lttng-dev@lists.lttng.org; Fri, 12 Feb 2016 16:32:21 -0500
In-Reply-To: <1455312708-462-1-git-send-email-mjeanson@efficios.com>
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

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 src/bin/lttng-sessiond/modprobe.c | 52 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/src/bin/lttng-sessiond/modprobe.c b/src/bin/lttng-sessiond/modprobe.c
index 90fec71..3e41f5c 100644
--- a/src/bin/lttng-sessiond/modprobe.c
+++ b/src/bin/lttng-sessiond/modprobe.c
@@ -16,6 +16,13 @@
  * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
+/**
+ * @file modprobe.c
+ *
+ * @brief modprobe related functions.
+ *
+ */
+
 #define _LGPL_SOURCE
 #include <assert.h>
 #include <stdio.h>
@@ -93,6 +100,9 @@ static int probes_capacity;
 #if HAVE_KMOD
 #include <libkmod.h>
 
+/**
+ * @brief Logging function for libkmod integration.
+ */
 static void log_kmod(void *data, int priority, const char *file, int line,
 		const char *fn, const char *format, va_list args)
 {
@@ -106,6 +116,15 @@ static void log_kmod(void *data, int priority, const char *file, int line,
 	free(str);
 }
 
+/**
+ * @brief Setup the libkmod context.
+ *
+ * Create the context, add a custom logging function and preload the
+ * ressources for faster operation.
+ *
+ * @returns	\c 0 on success
+ * 		\c < 0 on error
+ */
 static int setup_kmod_ctx(struct kmod_ctx **ctx)
 {
 	int ret = 0;
@@ -128,6 +147,19 @@ error:
 	return ret;
 }
 
+/**
+ * @brief Loads the kernel modules in \p modules
+ *
+ * @param modules	List of modules to load
+ * @param entries	Number of modules in the list
+ * @param required	Are the modules required or optionnal
+ *
+ * If the modules are required, we will return with error after the
+ * first failed module load, otherwise we continue loading.
+ *
+ * @returns		\c 0 on success
+ * 			\c < 0 on error
+ */
 static int modprobe_lttng(struct kern_modules_param *modules,
 		int entries, int required)
 {
@@ -174,6 +206,18 @@ error:
 	return ret;
 }
 
+/**
+ * @brief Recursively unload modules.
+ *
+ * This function implements the same modules unloading behavior as
+ * 'modprobe -r' or rmmod, it will recursevily go trought the \p module
+ * dependencies and unload modules with a refcount of 0.
+ *
+ * @param mod		The module to unload
+ *
+ * @returns		\c 0 on success
+ * 			\c < 0 on error
+ */
 static int rmmod_recurse(struct kmod_module *mod) {
 	int ret = 0;
 	struct kmod_list *deps, *itr;
@@ -202,6 +246,14 @@ static int rmmod_recurse(struct kmod_module *mod) {
 	return ret;
 }
 
+/**
+ * @brief Unloads the kernel modules in \p modules
+ *
+ * @param modules	List of modules to unload
+ * @param entries	Number of modules in the list
+ * @param required	Are the modules required or optionnal
+ *
+ */
 static void modprobe_remove_lttng(const struct kern_modules_param *modules,
 		int entries, int required)
 {
-- 
2.7.0
