From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [LTTNG-TOOLS PATCH] Fix: don't destroy the sockets if
	the snapshot was successful
Date: Tue,  9 Dec 2014 16:38:05 -0500
Message-ID: <1418161085-18739-1-git-send-email-jdesfossez__14008.1696831205$1418161248$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1XySU5-0005z4-03
 for lttng-dev@lists.lttng.org; Tue, 09 Dec 2014 16:38:27 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Missing a goto to skip the error condition that was destroying the
relayd sockets even if a snapshot was successful. We want to keep them
open to reuse them for the next snapshots.

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 src/bin/lttng-sessiond/cmd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/bin/lttng-sessiond/cmd.c b/src/bin/lttng-sessiond/cmd.c
index 11ff9b4..58506b2 100644
--- a/src/bin/lttng-sessiond/cmd.c
+++ b/src/bin/lttng-sessiond/cmd.c
@@ -2979,11 +2979,13 @@ static int record_kernel_snapshot(struct ltt_kernel_session *ksess,
 	}
 
 	ret = LTTNG_OK;
+	goto end;
 
 error_snapshot:
 	/* Clean up copied sockets so this output can use some other later on. */
 	consumer_destroy_output_sockets(output->consumer);
 error:
+end:
 	return ret;
 }
 
-- 
1.9.1
