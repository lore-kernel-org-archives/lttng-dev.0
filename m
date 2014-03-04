From: Zifei Tong <zifeitong@gmail.com>
Subject: [PATCH lttng-ust] Fix: mismatch between code and
	comments
Date: Tue,  4 Mar 2014 20:50:14 +0800
Message-ID: <1393937414-32622-1-git-send-email-zifeitong__8948.35420554063$1393937527$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <zifeitong@gmail.com>) id 1WKooa-0007qn-3D
	for lttng-dev@lists.lttng.org; Tue, 04 Mar 2014 07:51:22 -0500
Received: by mail-pb0-f48.google.com with SMTP id md12so5165696pbc.7
	for <lttng-dev@lists.lttng.org>; Tue, 04 Mar 2014 04:51:14 -0800 (PST)
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

Signed-off-by: Zifei Tong <zifeitong@gmail.com>
---
 liblttng-ust-ctl/ustctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/liblttng-ust-ctl/ustctl.c b/liblttng-ust-ctl/ustctl.c
index 854d8ae..e07ec92 100644
--- a/liblttng-ust-ctl/ustctl.c
+++ b/liblttng-ust-ctl/ustctl.c
@@ -294,7 +294,7 @@ int ustctl_set_exclusion(int sock, struct lttng_ust_event_exclusion *exclusion,
 		return ret;
 	}
 
-	/* send var len bytecode */
+	/* send var len exclusion names */
 	ret = ustcomm_send_unix_sock(sock,
 			exclusion->names,
 			exclusion->count * LTTNG_UST_SYM_NAME_LEN);
-- 
1.9.0
