From: Charles Briere <c.briere@samsung.com>
Subject: [PATCH lttng-tools 08/24] Fix : Don't compile ust
 functions when not enabled
Date: Mon, 27 Oct 2014 20:49:28 +0000
Message-ID: <1414442926-14381-9-git-send-email-c.briere__49111.1194053248$1414443255$gmane$org@samsung.com>
References: <1414442926-14381-1-git-send-email-c.briere@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mailout1.w2.samsung.com ([211.189.100.11]
 helo=usmailout1.samsung.com) by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <c.briere@samsung.com>) id 1XirER-0007nk-NI
 for lttng-dev@lists.lttng.org; Mon, 27 Oct 2014 16:49:43 -0400
Received: from uscpsbgex2.samsung.com
 (u123.gpu85.samsung.co.kr [203.254.195.123]) by mailout1.w2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NE400FZYF6J0930@mailout1.w2.samsung.com> for
 lttng-dev@lists.lttng.org; Mon, 27 Oct 2014 16:49:31 -0400 (EDT)
In-reply-to: <1414442926-14381-1-git-send-email-c.briere@samsung.com>
Content-language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "jeremie.galarneau@efficios.com" <jeremie.galarneau@efficios.com>, "dgoulet@efficios.com" <dgoulet@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "karim.yaghmour@opersys.com" <karim.yaghmour@opersys.com>
List-Id: lttng-dev@lists.lttng.org

From: Charles Briere <c.briere@samsung.com>

Signed-off-by: Charles Briere <c.briere@samsung.com>
---
 src/bin/lttng-sessiond/shm.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/src/bin/lttng-sessiond/shm.c b/src/bin/lttng-sessiond/shm.c
index a5caa8b..fa3867c 100644
--- a/src/bin/lttng-sessiond/shm.c
+++ b/src/bin/lttng-sessiond/shm.c
@@ -16,6 +16,8 @@
  * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
+#if HAVE_LIBLTTNG_UST_CTL
+
 #define _GNU_SOURCE
 #include <fcntl.h>
 #include <limits.h>
@@ -170,3 +172,16 @@ char *shm_ust_get_mmap(char *shm_path, int global)
 error:
 	return NULL;
 }
+
+#else
+
+/*
+ * Dummy implementation so we do not need to put
+ * ifdef in main.c
+ */
+char *shm_ust_get_mmap(char *shm_path, int global)
+{
+	return 0;
+}
+
+#endif /* HAVE_LIBLTTNG_UST_CTL */
-- 
2.1.2
