From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools 2/2] Fix: don't destroy the sockets
 if the snapshot was successful
Date: Thu,  7 Feb 2019 20:25:42 -0500
Message-ID: <20190208012542.30069-2-jonathan.rajotte-julien__512.69128905318$1549589188$gmane$org@efficios.com>
References: <20190208012542.30069-1-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 43wcvL3hk3zfjP
 for <lttng-dev@lists.lttng.org>; Thu,  7 Feb 2019 20:25:50 -0500 (EST)
In-Reply-To: <20190208012542.30069-1-jonathan.rajotte-julien@efficios.com>
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

Missing a goto to skip the error condition that was destroying the
relayd sockets even if a snapshot was successful. We want to keep them
open to reuse them for the next snapshots.

This is verbatim from the fix 1371fc1228461eb532118280e67ab3e9de015757

It is also the same fix.

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 src/bin/lttng-sessiond/cmd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/bin/lttng-sessiond/cmd.c b/src/bin/lttng-sessiond/cmd.c
index d3c8376be..d91869fae 100644
--- a/src/bin/lttng-sessiond/cmd.c
+++ b/src/bin/lttng-sessiond/cmd.c
@@ -4179,10 +4179,13 @@ static enum lttng_error_code record_ust_snapshot(struct ltt_ust_session *usess,
 		goto error_snapshot;
 	}
 
+	goto end;
+
 error_snapshot:
 	/* Clean up copied sockets so this output can use some other later on. */
 	consumer_destroy_output_sockets(output->consumer);
 error:
+end:
 	return status;
 }
 
-- 
2.17.1
