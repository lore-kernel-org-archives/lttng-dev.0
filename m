From: Charles Briere <charlesbriere.flatzo@gmail.com>
Subject: [PATCH lttng-tools 11/14] Added configure.ac check for
	pthread_cond_timedwait_monotonic support (which is a
	non-standard pthread function) & usage handling in sessiond's
	main.c.
Date: Mon,  6 May 2013 18:18:48 +0000
Message-ID: <1367864331-15212-11-git-send-email-charlesbriere.flatzo__4452.36713062531$1367866896$gmane$org@gmail.com>
References: <1367864331-15212-1-git-send-email-charlesbriere.flatzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f51.google.com ([209.85.216.51])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <charlesbriere.flatzo@gmail.com>) id 1UZQ0K-00006Y-5l
	for lttng-dev@lists.lttng.org; Mon, 06 May 2013 14:19:16 -0400
Received: by mail-qa0-f51.google.com with SMTP id hu16so1616530qab.3
	for <lttng-dev@lists.lttng.org>; Mon, 06 May 2013 11:19:10 -0700 (PDT)
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
Cc: lttng-dev@lists.lttng.org, Michael Poupart <michael-poupart@polymtl.ca>
List-Id: lttng-dev@lists.lttng.org

From: Michael Poupart <michael-poupart@polymtl.ca>

Signed-off-by: Michael Poupart <michael-poupart@polymtl.ca>
---
 configure.ac                  | 17 +++++++++++++++++
 src/bin/lttng-sessiond/main.c |  7 +++++++
 2 files changed, 24 insertions(+)

diff --git a/configure.ac b/configure.ac
index b3738d2..c405020 100644
--- a/configure.ac
+++ b/configure.ac
@@ -182,6 +182,23 @@ AM_CONDITIONAL([LTTNG_BUILD_WITH_LIBUUID], [test "x$have_libuuid" = "xyes"])
 AM_CONDITIONAL([LTTNG_BUILD_WITH_LIBC_UUID], [test "x$have_libc_uuid" = "xyes"])
 AM_CONDITIONAL([LTTNG_BUILD_WITH_LIBEXT2_UUID], [test "x$have_libext2_uuid" = "xyes"])
 
+# Check for the non-standard pthread_cond_timedwait_monotonic function in lpthread/libc
+AC_CHECK_LIB([pthread], [pthread_cond_timedwait_monotonic],
+[
+	have_pthread_cndtmwt_mono=yes
+],
+[
+	AC_CHECK_LIB([c], [pthread_cond_timedwait_monotonic],
+	[
+		have_pthread_cndtmwt_mono=yes
+	])
+])
+AS_IF([test "x$have_pthread_cndtmwt_mono" = "xyes"],
+[
+	AC_DEFINE_UNQUOTED([LTTNG_HAVE_PTHREAD_CNDTMWT_MONO], 1, [Has non-standard pthread_cond_timedwait_monotonic support.])
+])
+
+
 # URCU library version needed or newer
 liburcu_version=">= 0.7.2"
 
diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
index f6a051a..d8ff4c2 100644
--- a/src/bin/lttng-sessiond/main.c
+++ b/src/bin/lttng-sessiond/main.c
@@ -1732,6 +1732,7 @@ static int spawn_consumer_thread(struct consumer_data *consumer_data)
 		goto error;
 	}
 
+#ifndef LTTNG_HAVE_PTHREAD_CNDTMWT_MONO
 	/*
 	 * Set the monotonic clock in order to make sure we DO NOT jump in time
 	 * between the clock_gettime() call and the timedwait call. See bug #324
@@ -1743,6 +1744,7 @@ static int spawn_consumer_thread(struct consumer_data *consumer_data)
 		PERROR("pthread_condattr_setclock consumer data");
 		goto error;
 	}
+#endif
 
 	ret = pthread_cond_init(&consumer_data->cond, &consumer_data->condattr);
 	if (ret != 0) {
@@ -1792,8 +1794,13 @@ static int spawn_consumer_thread(struct consumer_data *consumer_data)
 			ret = pthread_cond_wait(&consumer_data->cond,
 					&consumer_data->cond_mutex);
 		} else {
+#ifdef LTTNG_HAVE_PTHREAD_CNDTMWT_MONO
+			ret = pthread_cond_timedwait_monotonic(&consumer_data->cond,
+					&consumer_data->cond_mutex, &timeout);
+#else
 			ret = pthread_cond_timedwait(&consumer_data->cond,
 					&consumer_data->cond_mutex, &timeout);
+#endif
 		}
 	}
 
-- 
1.8.1.msysgit.1
