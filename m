From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: print dots while waiting for
	data	availability
Date: Wed, 26 Jun 2013 13:14:20 -0400
Message-ID: <20130626171420.GA32374__5869.90409433401$1372266897$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UrtIW-0006Oi-Cj
	for lttng-dev@lists.lttng.org; Wed, 26 Jun 2013 13:14:24 -0400
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
diff --git a/src/lib/lttng-ctl/lttng-ctl.c b/src/lib/lttng-ctl/lttng-ctl.c
index 08c0554..8de1a23 100644
--- a/src/lib/lttng-ctl/lttng-ctl.c
+++ b/src/lib/lttng-ctl/lttng-ctl.c
@@ -573,6 +573,7 @@ static int _lttng_stop_tracing(const char *session_name, int wait)
 	}
 
 	_MSG("Waiting for data availability");
+	fflush(stdout);
 
 	/* Check for data availability */
 	do {
@@ -590,6 +591,7 @@ static int _lttng_stop_tracing(const char *session_name, int wait)
 		if (data_ret) {
 			usleep(DEFAULT_DATA_AVAILABILITY_WAIT_TIME);
 			_MSG(".");
+			fflush(stdout);
 		}
 	} while (data_ret != 0);
 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
