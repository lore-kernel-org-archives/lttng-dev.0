From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-tools] Fix: Improve the error reporting of
	the track/untrack command
Date: Wed, 12 Aug 2015 16:08:16 -0400
Message-ID: <1439410096-769-1-git-send-email-mjeanson__28420.4883654185$1439410215$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mjeanson@efficios.com>) id 1ZPcKF-0007tZ-1C
 for lttng-dev@lists.lttng.org; Wed, 12 Aug 2015 16:08:48 -0400
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

This patch adds feedback when a track/untrack command is successful and
specific messages on errors. It also changes the behavior when tracking
an already tracked PID or untracking a PID that is not tracked from an
error to a warning with a successful exit code.

Fixes: #898

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 include/lttng/lttng-error.h            |  2 ++
 src/bin/lttng-sessiond/trace-ust.c     |  4 ++--
 src/bin/lttng/commands/track-untrack.c | 23 +++++++++++++++++++++--
 src/common/error.c                     |  2 ++
 4 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/include/lttng/lttng-error.h b/include/lttng/lttng-error.h
index efdca65..a7746fa 100644
--- a/include/lttng/lttng-error.h
+++ b/include/lttng/lttng-error.h
@@ -134,6 +134,8 @@ enum lttng_error_code {
 	LTTNG_ERR_EXCLUSION_NOMEM        = 111, /* Lack of memory while processing event exclusions */
 	LTTNG_ERR_INVALID_EVENT_NAME     = 112, /* Invalid event name */
 	LTTNG_ERR_INVALID_CHANNEL_NAME   = 113, /* Invalid channel name */
+	LTTNG_ERR_PID_TRACKED            = 114, /* PID already tracked */
+	LTTNG_ERR_PID_NOT_TRACKED        = 115, /* PID not tracked */
 
 	/* MUST be last element */
 	LTTNG_ERR_NR,                           /* Last element */
diff --git a/src/bin/lttng-sessiond/trace-ust.c b/src/bin/lttng-sessiond/trace-ust.c
index 2486696..3881084 100644
--- a/src/bin/lttng-sessiond/trace-ust.c
+++ b/src/bin/lttng-sessiond/trace-ust.c
@@ -656,7 +656,7 @@ int pid_tracker_add_pid(struct ust_pid_tracker *pid_tracker, int pid)
 	tracker_node = pid_tracker_lookup(pid_tracker, pid, &iter);
 	if (tracker_node) {
 		/* Already exists. */
-		retval = LTTNG_ERR_INVALID;
+		retval = LTTNG_ERR_PID_TRACKED;
 		goto end;
 	}
 	tracker_node = zmalloc(sizeof(*tracker_node));
@@ -684,7 +684,7 @@ int pid_tracker_del_pid(struct ust_pid_tracker *pid_tracker, int pid)
 	tracker_node = pid_tracker_lookup(pid_tracker, pid, &iter);
 	if (!tracker_node) {
 		/* Not found */
-		retval = LTTNG_ERR_INVALID;
+		retval = LTTNG_ERR_PID_NOT_TRACKED;
 		goto end;
 	}
 	ret = lttng_ht_del(pid_tracker->ht, &iter);
diff --git a/src/bin/lttng/commands/track-untrack.c b/src/bin/lttng/commands/track-untrack.c
index 9ce8504..b3139c6 100644
--- a/src/bin/lttng/commands/track-untrack.c
+++ b/src/bin/lttng/commands/track-untrack.c
@@ -261,9 +261,28 @@ enum cmd_error_code track_untrack_pid(enum cmd_type cmd_type, const char *cmd_st
 		DBG("%s PID %d", cmd_str, pid_list[i]);
 		ret = lib_func(handle, pid_list[i]);
 		if (ret) {
-			success = 0;
-			retval = CMD_ERROR;
+			switch (-ret) {
+			case LTTNG_ERR_PID_TRACKED:
+				WARN("PID %i already tracked in session %s",
+						pid_list[i], session_name);
+				success = 1;
+				retval = CMD_SUCCESS;
+				break;
+			case LTTNG_ERR_PID_NOT_TRACKED:
+				WARN("PID %i not tracked in session %s",
+						pid_list[i], session_name);
+				success = 1;
+				retval = CMD_SUCCESS;
+				break;
+			default:
+				ERR("%s", lttng_strerror(ret));
+				success = 0;
+				retval = CMD_ERROR;
+				break;
+			}
 		} else {
+			MSG("PID %i %sed in session %s",
+					pid_list[i], cmd_str, session_name);
 			success = 1;
 		}
 
diff --git a/src/common/error.c b/src/common/error.c
index d3e3b94..ad0ac51 100644
--- a/src/common/error.c
+++ b/src/common/error.c
@@ -167,6 +167,8 @@ static const char *error_string_array[] = {
 	[ ERROR_INDEX(LTTNG_ERR_MI_NOT_IMPLEMENTED) ] = "Mi feature not implemented",
 	[ ERROR_INDEX(LTTNG_ERR_INVALID_EVENT_NAME) ] = "Invalid event name",
 	[ ERROR_INDEX(LTTNG_ERR_INVALID_CHANNEL_NAME) ] = "Invalid channel name",
+	[ ERROR_INDEX(LTTNG_ERR_PID_TRACKED) ] = "PID already tracked",
+	[ ERROR_INDEX(LTTNG_ERR_PID_NOT_TRACKED) ] = "PID not tracked",
 
 	/* Last element */
 	[ ERROR_INDEX(LTTNG_ERR_NR) ] = "Unknown error code"
-- 
1.9.1
