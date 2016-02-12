From: Michael Jeanson <mjeanson@efficios.com>
Subject: [RFC PATCH lttng-tools 5/5] Add builtin modules support
	to kmod modprobe
Date: Fri, 12 Feb 2016 16:31:48 -0500
Message-ID: <1455312708-462-5-git-send-email-mjeanson__19471.4238438339$1455312890$gmane$org@efficios.com>
References: <1455312708-462-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mjeanson@efficios.com>) id 1aULK9-00042P-Uy
 for lttng-dev@lists.lttng.org; Fri, 12 Feb 2016 16:32:22 -0500
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

Report success when loading a module that is builtin the kernel.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 src/bin/lttng-sessiond/modprobe.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/bin/lttng-sessiond/modprobe.c b/src/bin/lttng-sessiond/modprobe.c
index 3e41f5c..ca0467e 100644
--- a/src/bin/lttng-sessiond/modprobe.c
+++ b/src/bin/lttng-sessiond/modprobe.c
@@ -180,9 +180,12 @@ static int modprobe_lttng(struct kern_modules_param *modules,
 			goto error;
 		}
 
-		ret = kmod_module_probe_insert_module(mod, KMOD_PROBE_IGNORE_LOADED,
+		ret = kmod_module_probe_insert_module(mod, 0,
 				NULL, NULL, NULL, NULL);
-		if (ret < 0) {
+		if (ret == -EEXIST) {
+			DBG("Module %s is already loaded", modules[i].name);
+			ret = 0;
+		} else if (ret < 0) {
 			if (required) {
 				ERR("Unable to load required module %s",
 						modules[i].name);
-- 
2.7.0
