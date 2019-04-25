From: Yannick Lamarre <ylamarre@efficios.com>
Subject: [PATCH lttng-tools v5 4/8] Adapt poll layer behaviour
 to match the epoll layer
Date: Thu, 25 Apr 2019 10:36:16 -0400
Message-ID: <20190425143620.3348-5-ylamarre__16829.5051132858$1556203127$gmane$org@efficios.com>
References: <20190425143620.3348-1-ylamarre@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44qfrX6X5Lz1KRt
 for <lttng-dev@lists.lttng.org>; Thu, 25 Apr 2019 10:36:28 -0400 (EDT)
In-Reply-To: <20190425143620.3348-1-ylamarre@efficios.com>
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

Signed-off-by: Yannick Lamarre <ylamarre@efficios.com>
---
Removed trailing trailing whitespace in comments.

 src/common/compat/compat-poll.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/src/common/compat/compat-poll.c b/src/common/compat/compat-poll.c
index b45b39dc..2318920a 100644
--- a/src/common/compat/compat-poll.c
+++ b/src/common/compat/compat-poll.c
@@ -1,5 +1,6 @@
 /*
  * Copyright (C)  2011 - David Goulet <david.goulet@polymtl.ca>
+ * Copyright (C)  2019 - Yannick Lamarre <ylamarre@efficios.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, version 2 only,
@@ -204,10 +205,10 @@ int compat_poll_mod(struct lttng_poll_event *events, int fd,
 		uint32_t req_events)
 {
 	int i;
-	bool fd_found = false;
 	struct compat_poll_event_array *current;
 
-	if (events == NULL || events->current.events == NULL || fd < 0) {
+	if (events == NULL || events->current.nb_fd == 0 ||
+			events->current.events == NULL || fd < 0) {
 		ERR("Bad compat poll mod arguments");
 		goto error;
 	}
@@ -216,16 +217,16 @@ int compat_poll_mod(struct lttng_poll_event *events, int fd,
 
 	for (i = 0; i < current->nb_fd; i++) {
 		if (current->events[i].fd == fd) {
-			fd_found = true;
 			current->events[i].events = req_events;
 			events->need_update = 1;
 			break;
 		}
 	}
 
-	if (!fd_found) {
-		goto error;
-	}
+	/*
+	 * The epoll flavor doesn't flag modifying a non-included FD as an
+	 * error.
+	 */
 
 	return 0;
 
@@ -238,11 +239,12 @@ error:
  */
 int compat_poll_del(struct lttng_poll_event *events, int fd)
 {
-	int new_size, i, count = 0, ret;
+	int i, count = 0, ret;
+	uint32_t new_size;
 	struct compat_poll_event_array *current;
 
-	if (events == NULL || events->current.events == NULL || fd < 0) {
-		ERR("Wrong arguments for poll del");
+	if (events == NULL || events->current.nb_fd == 0 ||
+			events->current.events == NULL || fd < 0) {
 		goto error;
 	}
 
@@ -257,13 +259,20 @@ int compat_poll_del(struct lttng_poll_event *events, int fd)
 			count++;
 		}
 	}
+
+	/* The fd was not in our set, return no error as with epoll. */
+	if (current->nb_fd == count) {
+		goto end;
+	}
+
 	/* No fd duplicate should be ever added into array. */
 	assert(current->nb_fd - 1 == count);
 	current->nb_fd = count;
 
 	/* Resize array if needed. */
 	new_size = 1U << utils_get_count_order_u32(current->nb_fd);
-	if (new_size != current->alloc_size && new_size >= current->init_size) {
+	if (new_size != current->alloc_size && new_size >= current->init_size
+			&& current->nb_fd != 0) {
 		ret = resize_poll_event(current, new_size);
 		if (ret < 0) {
 			goto error;
@@ -272,6 +281,7 @@ int compat_poll_del(struct lttng_poll_event *events, int fd)
 
 	events->need_update = 1;
 
+end:
 	return 0;
 
 error:
-- 
2.11.0
