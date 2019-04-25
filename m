From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools] Fix: libcompat is now part of
 libcommon
Date: Thu, 25 Apr 2019 14:12:37 -0400
Message-ID: <20190425181237.8139-1-jonathan.rajotte-julien__47160.1369603135$1556216043$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44qlf72cXGz1Kkg
 for <lttng-dev@lists.lttng.org>; Thu, 25 Apr 2019 14:12:47 -0400 (EDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

18710679a8ac57fda5dbd26cf16bb180dce9e286 includes libcompat into libcommon.

This also make the compat_(e)poll_* symbols visible through liblttng-ctl.
Same for fcntl compat.

Mark them as hidden.

These symbols are not visible on the 2.10/2.11 branches.

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 src/bin/lttng-relayd/Makefile.am   |  1 -
 src/bin/lttng-sessiond/Makefile.am |  1 -
 src/common/compat/compat-epoll.c   |  6 +++++
 src/common/compat/compat-fcntl.c   |  1 +
 src/common/compat/compat-poll.c    |  5 +++++
 src/common/compat/fcntl.h          |  4 +++-
 src/common/compat/poll.h           | 36 ++++++++++++++++++++----------
 tests/unit/Makefile.am             |  4 ----
 8 files changed, 39 insertions(+), 19 deletions(-)

diff --git a/src/bin/lttng-relayd/Makefile.am b/src/bin/lttng-relayd/Makefile.am
index cf56ea495..6320375b4 100644
--- a/src/bin/lttng-relayd/Makefile.am
+++ b/src/bin/lttng-relayd/Makefile.am
@@ -29,7 +29,6 @@ lttng_relayd_LDADD = -lurcu-common -lurcu \
 		$(top_builddir)/src/common/sessiond-comm/libsessiond-comm.la \
 		$(top_builddir)/src/common/hashtable/libhashtable.la \
 		$(top_builddir)/src/common/libcommon.la \
-		$(top_builddir)/src/common/compat/libcompat.la \
 		$(top_builddir)/src/common/index/libindex.la \
 		$(top_builddir)/src/common/health/libhealth.la \
 		$(top_builddir)/src/common/config/libconfig.la \
diff --git a/src/bin/lttng-sessiond/Makefile.am b/src/bin/lttng-sessiond/Makefile.am
index 9800c4b2c..6bfa5f389 100644
--- a/src/bin/lttng-sessiond/Makefile.am
+++ b/src/bin/lttng-sessiond/Makefile.am
@@ -68,7 +68,6 @@ lttng_sessiond_LDADD = -lurcu-common -lurcu $(KMOD_LIBS) \
 		$(top_builddir)/src/common/kernel-ctl/libkernel-ctl.la \
 		$(top_builddir)/src/common/hashtable/libhashtable.la \
 		$(top_builddir)/src/common/libcommon.la \
-		$(top_builddir)/src/common/compat/libcompat.la \
 		$(top_builddir)/src/common/relayd/librelayd.la \
 		$(top_builddir)/src/common/testpoint/libtestpoint.la \
 		$(top_builddir)/src/common/health/libhealth.la \
diff --git a/src/common/compat/compat-epoll.c b/src/common/compat/compat-epoll.c
index 6a781c7ae..cf92c63b4 100644
--- a/src/common/compat/compat-epoll.c
+++ b/src/common/compat/compat-epoll.c
@@ -67,6 +67,7 @@ error:
 /*
  * Create epoll set and allocate returned events structure.
  */
+LTTNG_HIDDEN
 int compat_epoll_create(struct lttng_poll_event *events, int size, int flags)
 {
 	int ret;
@@ -119,6 +120,7 @@ error:
 /*
  * Add a fd to the epoll set with requesting events.
  */
+LTTNG_HIDDEN
 int compat_epoll_add(struct lttng_poll_event *events, int fd, uint32_t req_events)
 {
 	int ret;
@@ -166,6 +168,7 @@ error:
 /*
  * Remove a fd from the epoll set.
  */
+LTTNG_HIDDEN
 int compat_epoll_del(struct lttng_poll_event *events, int fd)
 {
 	int ret;
@@ -200,6 +203,7 @@ error:
 /*
  * Set an fd's events.
  */
+LTTNG_HIDDEN
 int compat_epoll_mod(struct lttng_poll_event *events, int fd, uint32_t req_events)
 {
 	int ret;
@@ -241,6 +245,7 @@ error:
 /*
  * Wait on epoll set. This is a blocking call of timeout value.
  */
+LTTNG_HIDDEN
 int compat_epoll_wait(struct lttng_poll_event *events, int timeout)
 {
 	int ret;
@@ -293,6 +298,7 @@ error:
 /*
  * Setup poll set maximum size.
  */
+LTTNG_HIDDEN
 int compat_epoll_set_max_size(void)
 {
 	int ret, fd, retval = 0;
diff --git a/src/common/compat/compat-fcntl.c b/src/common/compat/compat-fcntl.c
index c6c6b4e99..a0f4a1997 100644
--- a/src/common/compat/compat-fcntl.c
+++ b/src/common/compat/compat-fcntl.c
@@ -21,6 +21,7 @@
 
 #ifdef __linux__
 
+LTTNG_HIDDEN
 int compat_sync_file_range(int fd, off64_t offset, off64_t nbytes,
 		unsigned int flags)
 {
diff --git a/src/common/compat/compat-poll.c b/src/common/compat/compat-poll.c
index b45b39dc6..11149f4d4 100644
--- a/src/common/compat/compat-poll.c
+++ b/src/common/compat/compat-poll.c
@@ -102,6 +102,7 @@ error:
 /*
  * Create pollfd data structure.
  */
+LTTNG_HIDDEN
 int compat_poll_create(struct lttng_poll_event *events, int size)
 {
 	struct compat_poll_event_array *current, *wait;
@@ -200,6 +201,7 @@ error:
 /*
  * Modify an fd's events..
  */
+LTTNG_HIDDEN
 int compat_poll_mod(struct lttng_poll_event *events, int fd,
 		uint32_t req_events)
 {
@@ -236,6 +238,7 @@ error:
 /*
  * Remove a fd from the pollfd structure.
  */
+LTTNG_HIDDEN
 int compat_poll_del(struct lttng_poll_event *events, int fd)
 {
 	int new_size, i, count = 0, ret;
@@ -281,6 +284,7 @@ error:
 /*
  * Wait on poll() with timeout. Blocking call.
  */
+LTTNG_HIDDEN
 int compat_poll_wait(struct lttng_poll_event *events, int timeout)
 {
 	int ret;
@@ -328,6 +332,7 @@ error:
 /*
  * Setup poll set maximum size.
  */
+LTTNG_HIDDEN
 int compat_poll_set_max_size(void)
 {
 	int ret, retval = 0;
diff --git a/src/common/compat/fcntl.h b/src/common/compat/fcntl.h
index 1efcea797..edb19906d 100644
--- a/src/common/compat/fcntl.h
+++ b/src/common/compat/fcntl.h
@@ -21,6 +21,7 @@
 #include <fcntl.h>
 #include <errno.h>
 #include <sys/types.h>
+#include <common/macros.h>
 
 #if (defined(__FreeBSD__) || defined(__CYGWIN__))
 typedef long long off64_t;
@@ -31,7 +32,8 @@ typedef off64_t loff_t;
 #endif
 
 #ifdef __linux__
-extern int compat_sync_file_range(int fd, off64_t offset, off64_t nbytes,
+LTTNG_HIDDEN
+int compat_sync_file_range(int fd, off64_t offset, off64_t nbytes,
 		unsigned int flags);
 #define lttng_sync_file_range(fd, offset, nbytes, flags) \
 	compat_sync_file_range(fd, offset, nbytes, flags)
diff --git a/src/common/compat/poll.h b/src/common/compat/poll.h
index d4bd87f58..5379c806a 100644
--- a/src/common/compat/poll.h
+++ b/src/common/compat/poll.h
@@ -122,7 +122,8 @@ static inline int __lttng_epoll_get_prev_fd(struct lttng_poll_event *events,
 /*
  * Create the epoll set. No memory allocation is done here.
  */
-extern int compat_epoll_create(struct lttng_poll_event *events,
+LTTNG_HIDDEN
+int compat_epoll_create(struct lttng_poll_event *events,
 		int size, int flags);
 #define lttng_poll_create(events, size, flags) \
 	compat_epoll_create(events, size, flags)
@@ -152,14 +153,16 @@ static inline int compat_glibc_epoll_create(int size, int flags)
  * Wait on epoll set with the number of fd registered to the lttng_poll_event
  * data structure (events).
  */
-extern int compat_epoll_wait(struct lttng_poll_event *events, int timeout);
+LTTNG_HIDDEN
+int compat_epoll_wait(struct lttng_poll_event *events, int timeout);
 #define lttng_poll_wait(events, timeout) \
 	compat_epoll_wait(events, timeout)
 
 /*
  * Add a fd to the epoll set and resize the epoll_event structure if needed.
  */
-extern int compat_epoll_add(struct lttng_poll_event *events,
+LTTNG_HIDDEN
+int compat_epoll_add(struct lttng_poll_event *events,
 		int fd, uint32_t req_events);
 #define lttng_poll_add(events, fd, req_events) \
 	compat_epoll_add(events, fd, req_events)
@@ -167,14 +170,16 @@ extern int compat_epoll_add(struct lttng_poll_event *events,
 /*
  * Remove a fd from the epoll set.
  */
-extern int compat_epoll_del(struct lttng_poll_event *events, int fd);
+LTTNG_HIDDEN
+int compat_epoll_del(struct lttng_poll_event *events, int fd);
 #define lttng_poll_del(events, fd) \
 	compat_epoll_del(events, fd)
 
 /*
  * Modify an fd's events in the epoll set.
  */
-extern int compat_epoll_mod(struct lttng_poll_event *events,
+LTTNG_HIDDEN
+int compat_epoll_mod(struct lttng_poll_event *events,
 		int fd, uint32_t req_events);
 #define lttng_poll_mod(events, fd, req_events) \
 	compat_epoll_add(events, fd, req_events)
@@ -182,7 +187,8 @@ extern int compat_epoll_mod(struct lttng_poll_event *events,
 /*
  * Set up the poll set limits variable poll_max_size
  */
-extern int compat_epoll_set_max_size(void);
+LTTNG_HIDDEN
+int compat_epoll_set_max_size(void);
 #define lttng_poll_set_max_size() \
 	compat_epoll_set_max_size()
 
@@ -326,7 +332,8 @@ static inline int __lttng_poll_get_prev_fd(struct lttng_poll_event *events,
 /*
  * Create a pollfd structure of size 'size'.
  */
-extern int compat_poll_create(struct lttng_poll_event *events, int size);
+LTTNG_HIDDEN
+int compat_poll_create(struct lttng_poll_event *events, int size);
 #define lttng_poll_create(events, size, flags) \
 	compat_poll_create(events, size)
 
@@ -334,14 +341,16 @@ extern int compat_poll_create(struct lttng_poll_event *events, int size);
  * Wait on poll(2) event with nb_fd registered to the lttng_poll_event data
  * structure.
  */
-extern int compat_poll_wait(struct lttng_poll_event *events, int timeout);
+LTTNG_HIDDEN
+int compat_poll_wait(struct lttng_poll_event *events, int timeout);
 #define lttng_poll_wait(events, timeout) \
 	compat_poll_wait(events, timeout)
 
 /*
  * Add the fd to the pollfd structure. Resize if needed.
  */
-extern int compat_poll_add(struct lttng_poll_event *events,
+LTTNG_HIDDEN
+int compat_poll_add(struct lttng_poll_event *events,
 		int fd, uint32_t req_events);
 #define lttng_poll_add(events, fd, req_events) \
 	compat_poll_add(events, fd, req_events)
@@ -351,14 +360,16 @@ extern int compat_poll_add(struct lttng_poll_event *events,
  * pollfd, data is copied from the old pollfd to the new and, finally, the old
  * one is freed().
  */
-extern int compat_poll_del(struct lttng_poll_event *events, int fd);
+LTTNG_HIDDEN
+int compat_poll_del(struct lttng_poll_event *events, int fd);
 #define lttng_poll_del(events, fd) \
 	compat_poll_del(events, fd)
 
 /*
  * Modify an fd's events in the epoll set.
  */
-extern int compat_poll_mod(struct lttng_poll_event *events,
+LTTNG_HIDDEN
+int compat_poll_mod(struct lttng_poll_event *events,
 		int fd, uint32_t req_events);
 #define lttng_poll_mod(events, fd, req_events) \
 	compat_poll_add(events, fd, req_events)
@@ -366,7 +377,8 @@ extern int compat_poll_mod(struct lttng_poll_event *events,
 /*
  * Set up the poll set limits variable poll_max_size
  */
-extern int compat_poll_set_max_size(void);
+LTTNG_HIDDEN
+int compat_poll_set_max_size(void);
 #define lttng_poll_set_max_size() \
 	compat_poll_set_max_size()
 
diff --git a/tests/unit/Makefile.am b/tests/unit/Makefile.am
index 5f485f007..bd25d6a3f 100644
--- a/tests/unit/Makefile.am
+++ b/tests/unit/Makefile.am
@@ -70,9 +70,7 @@ SESSIOND_OBJS = $(top_builddir)/src/bin/lttng-sessiond/buffer-registry.$(OBJEXT)
 	 $(top_builddir)/src/bin/lttng-sessiond/thread-utils.$(OBJEXT) \
 	 $(top_builddir)/src/bin/lttng-sessiond/process-utils.$(OBJEXT) \
 	 $(top_builddir)/src/bin/lttng-sessiond/thread.$(OBJEXT) \
-	 $(top_builddir)/src/common/libcommon.la \
 	 $(top_builddir)/src/common/testpoint/libtestpoint.la \
-	 $(top_builddir)/src/common/compat/libcompat.la \
 	 $(top_builddir)/src/common/health/libhealth.la \
 	 $(top_builddir)/src/common/sessiond-comm/libsessiond-comm.la
 
@@ -93,7 +91,6 @@ test_session_LDADD = $(LIBTAP) $(LIBCOMMON) $(LIBRELAYD) $(LIBSESSIOND_COMM) \
 		     $(KMOD_LIBS) \
 		     $(top_builddir)/src/lib/lttng-ctl/liblttng-ctl.la \
 		     $(top_builddir)/src/common/kernel-ctl/libkernel-ctl.la \
-		     $(top_builddir)/src/common/compat/libcompat.la \
 		     $(top_builddir)/src/common/testpoint/libtestpoint.la \
 		     $(top_builddir)/src/common/health/libhealth.la \
 		     $(top_builddir)/src/common/config/libconfig.la \
@@ -114,7 +111,6 @@ test_ust_data_LDADD = $(LIBTAP) $(LIBCOMMON) $(LIBRELAYD) $(LIBSESSIOND_COMM) \
 		      $(KMOD_LIBS) \
 		      $(top_builddir)/src/lib/lttng-ctl/liblttng-ctl.la \
 		      $(top_builddir)/src/common/kernel-ctl/libkernel-ctl.la \
-		      $(top_builddir)/src/common/compat/libcompat.la \
 		      $(top_builddir)/src/common/testpoint/libtestpoint.la \
 		      $(top_builddir)/src/common/health/libhealth.la \
 		      $(top_builddir)/src/common/config/libconfig.la \
-- 
2.17.1
