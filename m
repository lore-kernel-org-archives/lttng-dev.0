From: Charles Briere <charlesbriere.flatzo@gmail.com>
Subject: [PATCH lttng-tools 05/14] sys/un.h is already included
	in compat/socket.h and throws error if included before sock.h
	on Android.
Date: Mon,  6 May 2013 18:18:42 +0000
Message-ID: <1367864331-15212-5-git-send-email-charlesbriere.flatzo__41724.6182253168$1367864407$gmane$org@gmail.com>
References: <1367864331-15212-1-git-send-email-charlesbriere.flatzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <charlesbriere.flatzo@gmail.com>) id 1UZQ0A-0008WO-0h
	for lttng-dev@lists.lttng.org; Mon, 06 May 2013 14:19:06 -0400
Received: by mail-qc0-f169.google.com with SMTP id p9so382071qca.28
	for <lttng-dev@lists.lttng.org>; Mon, 06 May 2013 11:19:00 -0700 (PDT)
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
Cc: Charles Briere <charlesbriere.flatzo@gmail.com>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Charles Briere <charlesbriere.flatzo@gmail.com>
---
 src/common/sessiond-comm/unix.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/common/sessiond-comm/unix.h b/src/common/sessiond-comm/unix.h
index 34f156f..0252f4f 100644
--- a/src/common/sessiond-comm/unix.h
+++ b/src/common/sessiond-comm/unix.h
@@ -20,7 +20,6 @@
 
 #define _GNU_SOURCE
 #include <limits.h>
-#include <sys/un.h>
 
 #include <common/compat/socket.h>
 
-- 
1.8.1.msysgit.1
