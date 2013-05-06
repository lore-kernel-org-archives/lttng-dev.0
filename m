From: Charles Briere <charlesbriere.flatzo@gmail.com>
Subject: [PATCH lttng-tools 12/14] Using pthread_kill instead of
	pthread_cancel (not a good idea but requried for now)
Date: Mon,  6 May 2013 18:18:49 +0000
Message-ID: <1367864331-15212-12-git-send-email-charlesbriere.flatzo__30064.8748911501$1367867074$gmane$org@gmail.com>
References: <1367864331-15212-1-git-send-email-charlesbriere.flatzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qe0-f51.google.com ([209.85.128.51])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <charlesbriere.flatzo@gmail.com>) id 1UZQ0M-00006k-1x
	for lttng-dev@lists.lttng.org; Mon, 06 May 2013 14:19:18 -0400
Received: by mail-qe0-f51.google.com with SMTP id x7so2212221qeu.38
	for <lttng-dev@lists.lttng.org>; Mon, 06 May 2013 11:19:12 -0700 (PDT)
In-Reply-To: <1367864331-15212-1-git-send-email-charlesbriere.flatzo@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

From: Pierre-Luc St-Charles <pierre-luc.st-charles@polymtl.ca>

Signed-off-by: Pierre-Luc St-Charles <pierre-luc.st-charles@polymtl.ca>
---
 configure.ac                  | 18 ++++++++++++++++++
 src/bin/lttng-sessiond/main.c |  8 ++++++++
 2 files changed, 26 insertions(+)

diff --git a/configure.ac b/configure.ac
index c405020..154b0a7 100644
--- a/configure.ac
+++ b/configure.ac
@@ -198,6 +198,24 @@ AS_IF([test "x$have_pthread_cndtmwt_mono" = "xyes"],
 	AC_DEFINE_UNQUOTED([LTTNG_HAVE_PTHREAD_CNDTMWT_MONO], 1, [Has non-standard pthread_cond_timedwait_monotonic support.])
 ])
 
+# Check for pthread_cancel support (which might not be present in lightweight versions of lpthread)
+AC_CHECK_LIB([pthread], [pthread_cancel],
+[
+	have_pthread_cancel=yes
+],
+[
+	AC_CHECK_LIB([c], [pthread_cancel],
+	[
+		have_pthread_cancel=yes
+	])
+])
+AS_IF([test "x$have_pthread_cancel" = "xyes"],
+[
+	AC_DEFINE_UNQUOTED([LTTNG_HAVE_PTHREAD_CANCEL], 1, [Has standard pthread_cancel support.])
+],
+[
+	AC_MSG_WARN([The targeted platform does not support pthread_cancel; defaulting to pthread_kill, but it might not be 100% safe.])
+])
 
 # URCU library version needed or newer
 liburcu_version=">= 0.7.2"
diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
index d8ff4c2..73bdc0a 100644
--- a/src/bin/lttng-sessiond/main.c
+++ b/src/bin/lttng-sessiond/main.c
@@ -1816,10 +1816,18 @@ static int spawn_consumer_thread(struct consumer_data *consumer_data)
 			 */
 			ERR("Condition timed out. The consumer thread was never ready."
 					" Killing it");
+#ifdef LTTNG_HAVE_PTHREAD_CANCEL
 			ret = pthread_cancel(consumer_data->thread);
 			if (ret < 0) {
 				PERROR("pthread_cancel consumer thread");
 			}
+#else
+			WARN("Using pthread_kill instead of pthread_cancel...");
+			ret = pthread_kill(consumer_data->thread,SIGTERM);
+			if (ret < 0) {
+				PERROR("pthread_kill consumer thread");
+			}
+#endif
 		} else {
 			PERROR("pthread_cond_wait failed consumer thread");
 		}
-- 
1.8.1.msysgit.1
