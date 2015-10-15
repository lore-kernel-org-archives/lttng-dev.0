From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH babeltrace] Cleanup: remove unused label 'end'
Date: Thu, 15 Oct 2015 16:40:22 -0400
Message-ID: <1444941622-16238-1-git-send-email-mjeanson__38275.0427503653$1444941688$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mjeanson@efficios.com>) id 1ZmpKG-0005zm-4f
 for lttng-dev@lists.lttng.org; Thu, 15 Oct 2015 16:40:36 -0400
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

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 include/babeltrace/compat/send.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/babeltrace/compat/send.h b/include/babeltrace/compat/send.h
index 3c6d01a..3998694 100644
--- a/include/babeltrace/compat/send.h
+++ b/include/babeltrace/compat/send.h
@@ -109,7 +109,7 @@ ssize_t bt_send_nosigpipe(int fd, const void *buffer, size_t size)
 	}
 	/* Restore send() errno */
 	errno = saved_err;
-end:
+
 	return sent;
 }
 #endif
-- 
1.9.1
