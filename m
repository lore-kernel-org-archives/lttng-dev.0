From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 2/6] Fix: various compat poll/epoll
	issues
Date: Mon,  5 Jan 2015 16:43:04 -0500
Message-ID: <1420494188-20782-2-git-send-email-mathieu.desnoyers__4808.40900349921$1420494295$gmane$org@efficios.com>
References: <1420494188-20782-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1Y8FQn-0005cI-42
 for lttng-dev@lists.lttng.org; Mon, 05 Jan 2015 16:43:22 -0500
In-Reply-To: <1420494188-20782-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

poll:
- fix two nb_fd off by one in "add",
- simplify array size calculation,
- add error checking,
- compress the content of array before resizing it on "del"
  (out-of-bound memory access issue),
- set wait.nb_fd = 0 when no FD are present in array on wait,
- remove need_realloc flag: this can be checked internally by comparing
  current->alloc_size and wait->alloc_size. Minimize the number of
  duplicated state.

epoll:
- add error checking,
- simplify array size calculation (make it similar to poll),
- Set default size when poll_max_size is 0 within
  compat_epoll_set_max_size(), which allow better error checking
  elsewhere in epoll compat code.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/common/compat/compat-epoll.c | 62 ++++++++++++++++-------------------
 src/common/compat/compat-poll.c  | 70 +++++++++++++++++-----------------------
 src/common/compat/poll.h         |  7 ++--
 3 files changed, 61 insertions(+), 78 deletions(-)

diff --git a/src/common/compat/compat-epoll.c b/src/common/compat/compat-epoll.c
index 29bd2f8..5d6153b 100644
--- a/src/common/compat/compat-epoll.c
+++ b/src/common/compat/compat-epoll.c
@@ -77,8 +77,13 @@ int compat_epoll_create(struct lttng_poll_event *events, int size, int flags)
 		goto error;
 	}
 
+	if (!poll_max_size) {
+		ERR("poll_max_size not initialized yet");
+		goto error;
+	}
+
 	/* Don't bust the limit here */
-	if (size > poll_max_size && poll_max_size != 0) {
+	if (size > poll_max_size) {
 		size = poll_max_size;
 	}
 
@@ -166,7 +171,7 @@ int compat_epoll_del(struct lttng_poll_event *events, int fd)
 {
 	int ret;
 
-	if (events == NULL || fd < 0) {
+	if (events == NULL || fd < 0 || events->nb_fd == 0) {
 		goto error;
 	}
 
@@ -205,6 +210,12 @@ int compat_epoll_wait(struct lttng_poll_event *events, int timeout)
 		ERR("Wrong arguments in compat_epoll_wait");
 		goto error;
 	}
+	assert(events->nb_fd >= 0);
+
+	if (events->nb_fd == 0) {
+		errno = EINVAL;
+		return -1;
+	}
 
 	/*
 	 * Resize if needed before waiting. We could either expand the array or
@@ -212,23 +223,8 @@ int compat_epoll_wait(struct lttng_poll_event *events, int timeout)
 	 * ensured that the events argument of the epoll_wait call will be large
 	 * enough to hold every possible returned events.
 	 */
-	if (events->nb_fd > events->alloc_size) {
-		/* Expand if the nb_fd is higher than the actual size. */
-		new_size = max_t(uint32_t,
-				1U << utils_get_count_order_u32(events->nb_fd),
-				events->alloc_size << 1UL);
-	} else if ((events->nb_fd << 1UL) <= events->alloc_size &&
-			events->nb_fd >= events->init_size) {
-		/* Shrink if nb_fd multiplied by two is <= than the actual size. */
-		new_size = max_t(uint32_t,
-				utils_get_count_order_u32(events->nb_fd) >> 1U,
-				events->alloc_size >> 1U);
-	} else {
-		/* Indicate that we don't want to resize. */
-		new_size = 0;
-	}
-
-	if (new_size) {
+	new_size = 1U << utils_get_count_order_u32(events->nb_fd);
+	if (new_size != events->alloc_size && new_size >= events->init_size) {
 		ret = resize_poll_event(events, new_size);
 		if (ret < 0) {
 			/* ENOMEM problem at this point. */
@@ -258,17 +254,16 @@ error:
 /*
  * Setup poll set maximum size.
  */
-void compat_epoll_set_max_size(void)
+int compat_epoll_set_max_size(void)
 {
-	int ret, fd;
+	int ret, fd, retval = 0;
 	ssize_t size_ret;
 	char buf[64];
 
-	poll_max_size = DEFAULT_POLL_SIZE;
-
 	fd = open(COMPAT_EPOLL_PROC_PATH, O_RDONLY);
 	if (fd < 0) {
-		return;
+		retval = -1;
+		goto end;
 	}
 
 	size_ret = lttng_read(fd, buf, sizeof(buf));
@@ -278,21 +273,20 @@ void compat_epoll_set_max_size(void)
 	 */
 	if (size_ret < 0 || size_ret >= sizeof(buf)) {
 		PERROR("read set max size");
-		goto error;
+		retval = -1;
+		goto end_read;
 	}
 	buf[size_ret] = '\0';
-
 	poll_max_size = atoi(buf);
-	if (poll_max_size == 0) {
-		/* Extra precaution */
-		poll_max_size = DEFAULT_POLL_SIZE;
-	}
-
-	DBG("epoll set max size is %d", poll_max_size);
-
-error:
+end_read:
 	ret = close(fd);
 	if (ret) {
 		PERROR("close");
 	}
+end:
+	if (!poll_max_size) {
+		poll_max_size = DEFAULT_POLL_SIZE;
+	}
+	DBG("epoll set max size is %d", poll_max_size);
+	return retval;
 }
diff --git a/src/common/compat/compat-poll.c b/src/common/compat/compat-poll.c
index 3293244..68d4dcb 100644
--- a/src/common/compat/compat-poll.c
+++ b/src/common/compat/compat-poll.c
@@ -81,7 +81,7 @@ static int update_current_events(struct lttng_poll_event *events)
 	wait = &events->wait;
 
 	wait->nb_fd = current->nb_fd;
-	if (events->need_realloc) {
+	if (current->alloc_size != wait->alloc_size) {
 		ret = resize_poll_event(wait, current->alloc_size);
 		if (ret < 0) {
 			goto error;
@@ -90,9 +90,8 @@ static int update_current_events(struct lttng_poll_event *events)
 	memcpy(wait->events, current->events,
 			current->nb_fd * sizeof(*current->events));
 
-	/* Update is done and realloc as well. */
+	/* Update is done. */
 	events->need_update = 0;
-	events->need_realloc = 0;
 
 	return 0;
 
@@ -112,6 +111,11 @@ int compat_poll_create(struct lttng_poll_event *events, int size)
 		goto error;
 	}
 
+	if (!poll_max_size) {
+		ERR("poll_max_size not initialized yet");
+		goto error;
+	}
+
 	/* Don't bust the limit here */
 	if (size > poll_max_size) {
 		size = poll_max_size;
@@ -120,7 +124,6 @@ int compat_poll_create(struct lttng_poll_event *events, int size)
 	/* Reset everything before begining the allocation. */
 	memset(events, 0, sizeof(struct lttng_poll_event));
 
-	/* Ease our life a bit. */
 	current = &events->current;
 	wait = &events->wait;
 
@@ -161,29 +164,23 @@ int compat_poll_add(struct lttng_poll_event *events, int fd,
 		goto error;
 	}
 
-	/* Ease our life a bit. */
 	current = &events->current;
 
 	/* Check if fd we are trying to add is already there. */
 	for (i = 0; i < current->nb_fd; i++) {
-		/* Don't put back the fd we want to delete */
 		if (current->events[i].fd == fd) {
 			errno = EEXIST;
 			goto error;
 		}
 	}
 
-	/* Check for a needed resize of the array. */
-	if (current->nb_fd > current->alloc_size) {
-		/* Expand it by a power of two of the current size. */
-		new_size = max_t(int,
-				1U << utils_get_count_order_u32(current->nb_fd),
-				current->alloc_size << 1UL);
+	/* Resize array if needed. */
+	new_size = 1U << utils_get_count_order_u32(current->nb_fd + 1);
+	if (new_size != current->alloc_size && new_size >= current->init_size) {
 		ret = resize_poll_event(current, new_size);
 		if (ret < 0) {
 			goto error;
 		}
-		events->need_realloc = 1;
 	}
 
 	current->events[current->nb_fd].fd = fd;
@@ -215,23 +212,6 @@ int compat_poll_del(struct lttng_poll_event *events, int fd)
 	/* Ease our life a bit. */
 	current = &events->current;
 
-	/* Check if we need to shrink it down. */
-	if ((current->nb_fd << 1UL) <= current->alloc_size &&
-			current->nb_fd >= current->init_size) {
-		/*
-		 * Shrink if nb_fd multiplied by two is <= than the actual size and we
-		 * are above the initial size.
-		 */
-		new_size = max_t(int,
-				utils_get_count_order_u32(current->nb_fd) >> 1U,
-				current->alloc_size >> 1U);
-		ret = resize_poll_event(current, new_size);
-		if (ret < 0) {
-			goto error;
-		}
-		events->need_realloc = 1;
-	}
-
 	for (i = 0; i < current->nb_fd; i++) {
 		/* Don't put back the fd we want to delete */
 		if (current->events[i].fd != fd) {
@@ -240,8 +220,19 @@ int compat_poll_del(struct lttng_poll_event *events, int fd)
 			count++;
 		}
 	}
+	/* No fd duplicate should be ever added into array. */
+	assert(current->nb_fd - 1 == count);
+	current->nb_fd = count;
+
+	/* Resize array if needed. */
+	new_size = 1U << utils_get_count_order_u32(current->nb_fd);
+	if (new_size != current->alloc_size && new_size >= current->init_size) {
+		ret = resize_poll_event(current, new_size);
+		if (ret < 0) {
+			goto error;
+		}
+	}
 
-	current->nb_fd--;
 	events->need_update = 1;
 
 	return 0;
@@ -261,10 +252,12 @@ int compat_poll_wait(struct lttng_poll_event *events, int timeout)
 		ERR("poll wait arguments error");
 		goto error;
 	}
+	assert(events->current.nb_fd >= 0);
 
 	if (events->current.nb_fd == 0) {
 		/* Return an invalid error to be consistent with epoll. */
 		errno = EINVAL;
+		events->wait.nb_fd = 0;
 		goto error;
 	}
 
@@ -296,25 +289,22 @@ error:
 /*
  * Setup poll set maximum size.
  */
-void compat_poll_set_max_size(void)
+int compat_poll_set_max_size(void)
 {
-	int ret;
+	int ret, retval = 0;
 	struct rlimit lim;
 
-	/* Default value */
-	poll_max_size = DEFAULT_POLL_SIZE;
-
 	ret = getrlimit(RLIMIT_NOFILE, &lim);
 	if (ret < 0) {
 		perror("getrlimit poll RLIMIT_NOFILE");
-		return;
+		retval = -1;
+		goto end;
 	}
-
 	poll_max_size = lim.rlim_cur;
+end:
 	if (poll_max_size == 0) {
-		/* Extra precaution */
 		poll_max_size = DEFAULT_POLL_SIZE;
 	}
-
 	DBG("poll set max size set to %u", poll_max_size);
+	return retval;
 }
diff --git a/src/common/compat/poll.h b/src/common/compat/poll.h
index f892c83..30bdca7 100644
--- a/src/common/compat/poll.h
+++ b/src/common/compat/poll.h
@@ -174,7 +174,7 @@ extern int compat_epoll_del(struct lttng_poll_event *events, int fd);
 /*
  * Set up the poll set limits variable poll_max_size
  */
-extern void compat_epoll_set_max_size(void);
+extern int compat_epoll_set_max_size(void);
 #define lttng_poll_set_max_size() \
 	compat_epoll_set_max_size()
 
@@ -285,8 +285,7 @@ struct compat_poll_event {
 	 * execution before a poll wait is done.
 	 */
 	struct compat_poll_event_array current;
-	/* Indicate if wait.events needs to be realloc. */
-	int need_realloc:1;
+
 	/* Indicate if wait.events need to be updated from current. */
 	int need_update:1;
 };
@@ -351,7 +350,7 @@ extern int compat_poll_del(struct lttng_poll_event *events, int fd);
 /*
  * Set up the poll set limits variable poll_max_size
  */
-extern void compat_poll_set_max_size(void);
+extern int compat_poll_set_max_size(void);
 #define lttng_poll_set_max_size() \
 	compat_poll_set_max_size()
 
-- 
2.1.1
