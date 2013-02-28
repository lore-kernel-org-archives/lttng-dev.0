From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH babeltrace] Fix: Undefined behavior of double
	free on strlist in get_names_args
Date: Thu, 28 Feb 2013 18:13:26 -0500
Message-ID: <1362093206-12791-1-git-send-email-christian.babeux__18912.7974249006$1362093263$gmane$org@efficios.com>
References: <20130228225429.GA915@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1UBCfT-00033U-Oh
	for lttng-dev@lists.lttng.org; Thu, 28 Feb 2013 18:13:39 -0500
Received: by mail-ie0-f181.google.com with SMTP id 17so2774572iea.40
	for <lttng-dev@lists.lttng.org>; Thu, 28 Feb 2013 15:13:34 -0800 (PST)
In-Reply-To: <20130228225429.GA915@Krystal>
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
 converter/babeltrace.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/converter/babeltrace.c b/converter/babeltrace.c
index 20ded00..ed19fa8 100644
--- a/converter/babeltrace.c
+++ b/converter/babeltrace.c
@@ -204,7 +204,6 @@ static int get_names_args(poptContext *pc)
 			opt_payload_field_names = 0;
 		} else {
 			fprintf(stderr, "[error] unknown field name type %s\n", str);
-			free(strlist);
 			ret = -EINVAL;
 			goto end;
 		}
-- 
1.8.1.3
