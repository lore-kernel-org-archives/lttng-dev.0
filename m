From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [BABELTRACE PATCH] Fix: check return value of
	bt_context_create
Date: Tue, 21 Aug 2012 09:43:35 -0400
Message-ID: <1345556615-8109-1-git-send-email-jdesfossez__22796.5240636424$1345556667$gmane$org@efficios.com>
References: <20120821120531.GA13784@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1T3okO-0005Nr-6Q
	for lttng-dev@lists.lttng.org; Tue, 21 Aug 2012 09:43:56 -0400
In-Reply-To: <20120821120531.GA13784@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 converter/babeltrace.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/converter/babeltrace.c b/converter/babeltrace.c
index f5541d2..c9007c3 100644
--- a/converter/babeltrace.c
+++ b/converter/babeltrace.c
@@ -549,6 +549,9 @@ int main(int argc, char **argv)
 	}
 
 	ctx = bt_context_create();
+	if (!ctx) {
+		goto error_td_read;
+	}
 
 	ret = bt_context_add_traces_recursive(ctx, opt_input_path,
 			opt_input_format, NULL);
-- 
1.7.10.4
