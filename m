From: Simarpreet Singh <simarpreet007@gmail.com>
Subject: [PATCH lttng-tools] Fixing a few typos in lttng-tools
	tree Fixes #453
Date: Tue,  9 Apr 2013 15:41:35 -0400
Message-ID: <1365536495-8416-1-git-send-email-simarpreet007__8205.6644642309$1365536549$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <simarpreet007@gmail.com>) id 1UPeQd-0003yr-G5
	for lttng-dev@lists.lttng.org; Tue, 09 Apr 2013 15:42:03 -0400
Received: by mail-ie0-f172.google.com with SMTP id c10so8917925ieb.17
	for <lttng-dev@lists.lttng.org>; Tue, 09 Apr 2013 12:41:58 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org, Simarpreet Singh <simarpreet007@gmail.com>
List-Id: lttng-dev@lists.lttng.org


Signed-off-by: Simarpreet Singh <simarpreet007@gmail.com>
---
 src/common/error.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/common/error.c b/src/common/error.c
index 4fb022c..4b9b46e 100644
--- a/src/common/error.c
+++ b/src/common/error.c
@@ -40,7 +40,7 @@ static const char *error_string_array[] = {
 	[ ERROR_INDEX(LTTNG_ERR_SESS_NOT_FOUND) ] = "Session name not found",
 	[ ERROR_INDEX(LTTNG_ERR_FATAL) ] = "Fatal error of the session daemon",
 	[ ERROR_INDEX(LTTNG_ERR_SELECT_SESS) ] = "A session MUST be selected",
-	[ ERROR_INDEX(LTTNG_ERR_EXIST_SESS) ] = "Session name already exist",
+	[ ERROR_INDEX(LTTNG_ERR_EXIST_SESS) ] = "Session name already exists",
 	[ ERROR_INDEX(LTTNG_ERR_NO_EVENT) ] = "Event not found",
 	[ ERROR_INDEX(LTTNG_ERR_CONNECT_FAIL) ] = "Unable to connect to Unix socket",
 	[ ERROR_INDEX(LTTNG_ERR_EPERM) ] = "Permission denied",
@@ -58,7 +58,7 @@ static const char *error_string_array[] = {
 	[ ERROR_INDEX(LTTNG_ERR_KERN_DISABLE_FAIL) ] = "Disable kernel event failed",
 	[ ERROR_INDEX(LTTNG_ERR_KERN_META_FAIL) ] = "Opening metadata failed",
 	[ ERROR_INDEX(LTTNG_ERR_KERN_START_FAIL) ] = "Starting kernel trace failed",
-	[ ERROR_INDEX(LTTNG_ERR_KERN_STOP_FAIL) ] = "Stoping kernel trace failed",
+	[ ERROR_INDEX(LTTNG_ERR_KERN_STOP_FAIL) ] = "Stopping kernel trace failed",
 	[ ERROR_INDEX(LTTNG_ERR_KERN_CONSUMER_FAIL) ] = "Kernel consumer start failed",
 	[ ERROR_INDEX(LTTNG_ERR_KERN_STREAM_FAIL) ] = "Kernel create stream failed",
 	[ ERROR_INDEX(LTTNG_ERR_KERN_LIST_FAIL) ] = "Listing kernel events failed",
@@ -73,7 +73,7 @@ static const char *error_string_array[] = {
 	[ ERROR_INDEX(LTTNG_ERR_UST_DISABLE_FAIL) ] = "Disable UST event failed",
 	[ ERROR_INDEX(LTTNG_ERR_UST_META_FAIL) ] = "Opening metadata failed",
 	[ ERROR_INDEX(LTTNG_ERR_UST_START_FAIL) ] = "Starting UST trace failed",
-	[ ERROR_INDEX(LTTNG_ERR_UST_STOP_FAIL) ] = "Stoping UST trace failed",
+	[ ERROR_INDEX(LTTNG_ERR_UST_STOP_FAIL) ] = "Stopping UST trace failed",
 	[ ERROR_INDEX(LTTNG_ERR_UST_CONSUMER64_FAIL) ] = "64-bit UST consumer start failed",
 	[ ERROR_INDEX(LTTNG_ERR_UST_CONSUMER32_FAIL) ] = "32-bit UST consumer start failed",
 	[ ERROR_INDEX(LTTNG_ERR_UST_STREAM_FAIL) ] = "UST create stream failed",
@@ -82,7 +82,7 @@ static const char *error_string_array[] = {
 	[ ERROR_INDEX(LTTNG_ERR_UST_EVENT_NOT_FOUND)] = "UST event not found",
 	[ ERROR_INDEX(LTTNG_ERR_UST_CONTEXT_EXIST)] = "UST context already exist",
 	[ ERROR_INDEX(LTTNG_ERR_UST_CONTEXT_INVAL)] = "UST invalid context",
-	[ ERROR_INDEX(LTTNG_ERR_NEED_ROOT_SESSIOND) ] = "Tracing the kernel requires a root lttng-sessiond daemon and \"tracing\" group user membership",
+	[ ERROR_INDEX(LTTNG_ERR_NEED_ROOT_SESSIOND) ] = "Tracing the kernel requires a root lttng-sessiond daemon or \"tracing\" group user membership",
 	[ ERROR_INDEX(LTTNG_ERR_TRACE_ALREADY_STARTED) ] = "Tracing already started",
 	[ ERROR_INDEX(LTTNG_ERR_TRACE_ALREADY_STOPPED) ] = "Tracing already stopped",
 	[ ERROR_INDEX(LTTNG_ERR_KERN_EVENT_ENOSYS) ] = "Kernel event type not supported",
@@ -91,7 +91,7 @@ static const char *error_string_array[] = {
 	[ ERROR_INDEX(LTTNG_ERR_NO_KERNCONSUMERD) ] = "No kernel consumer detected",
 	[ ERROR_INDEX(LTTNG_ERR_EVENT_EXIST_LOGLEVEL) ] = "Event already enabled with different loglevel",
 	[ ERROR_INDEX(LTTNG_ERR_URL_DATA_MISS) ] = "Missing data path URL",
-	[ ERROR_INDEX(LTTNG_ERR_URL_CTRL_MISS) ] = "Missing control data path URL",
+	[ ERROR_INDEX(LTTNG_ERR_URL_CTRL_MISS) ] = "Missing control path URL",
 	[ ERROR_INDEX(LTTNG_ERR_ENABLE_CONSUMER_FAIL) ] = "Enabling consumer failed",
 	[ ERROR_INDEX(LTTNG_ERR_RELAYD_CONNECT_FAIL) ] = "Unable to connect to lttng-relayd",
 	[ ERROR_INDEX(LTTNG_ERR_RELAYD_VERSION_FAIL) ] = "Relay daemon not compatible",
-- 
1.7.9.5
