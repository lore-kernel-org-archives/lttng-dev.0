From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools 3/4 v2] man: update disable-event
	section
Date: Mon, 21 Sep 2015 18:43:56 -0400
Message-ID: <1442875437-15639-3-git-send-email-jonathan.rajotte-julien__16033.9346541607$1442875776$gmane$org@efficios.com>
References: <CA+jJMxvMk+jb3nNMv9fk=-REKGT2XC4KtihyDR7xCH7_S86h4w@mail.gmail.com>
 <1442875437-15639-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1Ze9oi-0003cH-RI
 for lttng-dev@lists.lttng.org; Mon, 21 Sep 2015 18:44:28 -0400
In-Reply-To: <1442875437-15639-1-git-send-email-jonathan.rajotte-julien@efficios.com>
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

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 doc/man/lttng.1 | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/doc/man/lttng.1 b/doc/man/lttng.1
index cdd816d..db5a7c9 100644
--- a/doc/man/lttng.1
+++ b/doc/man/lttng.1
@@ -590,11 +590,7 @@ Dynamic function entry/return probe. Addr and offset can be octal
 (0NNN...), decimal (NNN...) or hexadecimal (0xNNN...)
 .TP
 .BR "\-\-syscall"
-System call event. Enabling syscalls tracing (kernel tracer), you will
-not be able to disable them with disable-event. This is a known
-limitation. You can disable the entire channel to do the trick. Also note
-that per-syscall selection is not supported yet. Use with "-a" to enable
-all syscalls.
+System call event.
 .TP
 .BR "\-\-filter 'expression'"
 Set a filter on a newly enabled event. Filter expression on event
@@ -681,7 +677,7 @@ Apply for the user-space tracer
 .PP
 
 .PP
-\fBdisable-event\fP NAME[,NAME2,...] (\-k | \-u) [OPTIONS]
+\fBdisable-event\fP NAME[,NAME2,...] (\-k | \-u | \-j | \-l | \-p) [TYPE] [OPTIONS]
 .RS
 Disable tracing event
 
@@ -711,8 +707,8 @@ Apply on session name
 Apply on channel name
 .TP
 .BR "\-a, \-\-all-events"
-Disable all events. This does NOT disable "*" but rather every known
-events of the session.
+Disable all events. This does NOT ONLY disable "*" but rather every known
+events of the session
 .TP
 .BR "\-k, \-\-kernel"
 Apply for the kernel tracer
@@ -727,7 +723,26 @@ Apply for Java application using Java Util Logging interface (JUL)
 Apply for Java application using LOG4J
 .TP
 .BR "\-p, \-\-python"
-Apply for Python application using the logging module.
+Apply for Python application using the logging module
+
+.TP
+.B TYPE (kernel domain only):
+
+.TP
+.BR "\-\-all"
+Disable event of all type
+.TP
+.BR "\-\-tracepoint"
+Disable event of type tracepoint
+.TP
+.BR "\-\-syscall"
+Disable event of type syscall
+.TP
+.BR "\-\-probe"
+Disable event of type probe
+.TP
+.BR "\-\-function"
+Disable event of type function
 .RE
 .PP
 
-- 
2.1.4
