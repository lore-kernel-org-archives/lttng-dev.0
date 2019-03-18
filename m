From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules 5/5] Fix: atomic_long_add_unless()
 returns a boolean
Date: Mon, 18 Mar 2019 16:20:36 -0400
Message-ID: <20190318202036.17523-5-mjeanson__30660.2582031459$1552940617$gmane$org@efficios.com>
References: <20190318202036.17523-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44NSHh4yG8z17Xw
 for <lttng-dev@lists.lttng.org>; Mon, 18 Mar 2019 16:21:04 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id A8CE31C8DBE
 for <lttng-dev@lists.lttng.org>; Mon, 18 Mar 2019 16:21:04 -0400 (EDT)
In-Reply-To: <20190318202036.17523-1-mjeanson@efficios.com>
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
List-Id: lttng-dev@lists.lttng.org

Because of a documentation error in older kernels, it was assumed that
atomic_long_add_unless would return the 'unless' value when it failed
but the implementation actually returns a boolean.

Also add missing error code int 'ret' and compare against the right type
max value.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 lttng-abi.c    | 7 +++----
 lttng-events.c | 4 ++--
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/lttng-abi.c b/lttng-abi.c
index 0534472..ca94379 100644
--- a/lttng-abi.c
+++ b/lttng-abi.c
@@ -419,8 +419,8 @@ int lttng_abi_create_channel(struct file *session_file,
 		transport_name = "<unknown>";
 		break;
 	}
-	if (atomic_long_add_unless(&session_file->f_count,
-		1, INT_MAX) == INT_MAX) {
+	if (!atomic_long_add_unless(&session_file->f_count, 1, LONG_MAX)) {
+		ret = -EOVERFLOW;
 		goto refcount_error;
 	}
 	/*
@@ -1072,8 +1072,7 @@ int lttng_abi_create_event(struct file *channel_file,
 		goto file_error;
 	}
 	/* The event holds a reference on the channel */
-	if (atomic_long_add_unless(&channel_file->f_count,
-		1, INT_MAX) == INT_MAX) {
+	if (!atomic_long_add_unless(&channel_file->f_count, 1, LONG_MAX)) {
 		ret = -EOVERFLOW;
 		goto refcount_error;
 	}
diff --git a/lttng-events.c b/lttng-events.c
index f4206c5..a4570b7 100644
--- a/lttng-events.c
+++ b/lttng-events.c
@@ -1140,8 +1140,8 @@ int lttng_session_list_tracker_pids(struct lttng_session *session)
 		ret = PTR_ERR(tracker_pids_list_file);
 		goto file_error;
 	}
-	if (atomic_long_add_unless(&session->file->f_count,
-		1, INT_MAX) == INT_MAX) {
+	if (!atomic_long_add_unless(&session->file->f_count, 1, LONG_MAX)) {
+		ret = -EOVERFLOW;
 		goto refcount_error;
 	}
 	ret = lttng_tracker_pids_list_fops.open(NULL, tracker_pids_list_file);
-- 
2.17.1
