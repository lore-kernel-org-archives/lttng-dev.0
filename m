From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools] Fix: Use after free on
	spawn_sessiond error path in check_sessiond
Date: Thu, 28 Feb 2013 15:48:30 -0500
Message-ID: <1362084510-10072-7-git-send-email-christian.babeux__32251.3043917299$1362084617$gmane$org@efficios.com>
References: <1362084510-10072-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ia0-f175.google.com ([209.85.210.175])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1UBAPm-0001ss-TV
	for lttng-dev@lists.lttng.org; Thu, 28 Feb 2013 15:49:19 -0500
Received: by mail-ia0-f175.google.com with SMTP id r4so1934675iaj.6
	for <lttng-dev@lists.lttng.org>; Thu, 28 Feb 2013 12:49:13 -0800 (PST)
In-Reply-To: <1362084510-10072-1-git-send-email-christian.babeux@efficios.com>
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


Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 src/bin/lttng/lttng.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/src/bin/lttng/lttng.c b/src/bin/lttng/lttng.c
index 8562144..be673f9 100644
--- a/src/bin/lttng/lttng.c
+++ b/src/bin/lttng/lttng.c
@@ -374,13 +374,12 @@ static int check_sessiond(void)
 		}
 
 		ret = spawn_sessiond(pathname);
-		free(alloc_pathname);
 		if (ret < 0) {
 			ERR("Problem occurred when starting %s", pathname);
-			goto end;
 		}
-	}
 
+		free(alloc_pathname);
+	}
 end:
 	return ret;
 }
-- 
1.8.1.3
