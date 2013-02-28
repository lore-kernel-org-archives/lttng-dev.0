From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH babeltrace] Fix: Undefined behavior of double
	free on strlist in get_names_args
Date: Thu, 28 Feb 2013 15:51:48 -0500
Message-ID: <1362084708-10329-1-git-send-email-christian.babeux__5996.56635099581$1362084766$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ia0-f170.google.com ([209.85.210.170])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1UBASR-0001uq-0L
	for lttng-dev@lists.lttng.org; Thu, 28 Feb 2013 15:52:03 -0500
Received: by mail-ia0-f170.google.com with SMTP id k20so1976406iak.1
	for <lttng-dev@lists.lttng.org>; Thu, 28 Feb 2013 12:51:57 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 converter/babeltrace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/converter/babeltrace.c b/converter/babeltrace.c
index 20ded00..28c63cb 100644
--- a/converter/babeltrace.c
+++ b/converter/babeltrace.c
@@ -205,6 +205,7 @@ static int get_names_args(poptContext *pc)
 		} else {
 			fprintf(stderr, "[error] unknown field name type %s\n", str);
 			free(strlist);
+			strlist = NULL;
 			ret = -EINVAL;
 			goto end;
 		}
-- 
1.8.1.3
