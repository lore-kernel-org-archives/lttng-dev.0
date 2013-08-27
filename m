From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: run_as gid/uid test should
	return result	to parent
Date: Tue, 27 Aug 2013 16:24:55 -0400
Message-ID: <20130827202455.GA12616__29222.5762423643$1377635156$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1VEPox-0008Sl-7S
	for lttng-dev@lists.lttng.org; Tue, 27 Aug 2013 16:25:04 -0400
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

Failure to do so could cause the parent to hang on read() waiting for
the return value from the child.

Targets: 2.3-rc and stable-2.2 branches.
 
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
diff --git a/src/common/runas.c b/src/common/runas.c
index bd51cd4..6979ad3 100644
--- a/src/common/runas.c
+++ b/src/common/runas.c
@@ -130,14 +130,16 @@ int child_run_as(void *_data)
 		ret = setegid(data->gid);
 		if (ret < 0) {
 			PERROR("setegid");
-			return EXIT_FAILURE;
+			sendret.i = -1;
+			goto write_return;
 		}
 	}
 	if (data->uid != geteuid()) {
 		ret = seteuid(data->uid);
 		if (ret < 0) {
 			PERROR("seteuid");
-			return EXIT_FAILURE;
+			sendret.i = -1;
+			goto write_return;
 		}
 	}
 	/*
@@ -145,6 +147,8 @@ int child_run_as(void *_data)
 	 */
 	umask(0);
 	sendret.i = (*data->cmd)(data->data);
+
+write_return:
 	/* send back return value */
 	writeleft = sizeof(sendret);
 	index = 0;

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
