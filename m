From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools] Fix: Memory leaks on error paths
	when exporting consumerd libdir in env
Date: Thu, 28 Feb 2013 15:48:26 -0500
Message-ID: <1362084510-10072-3-git-send-email-christian.babeux__49396.5557463982$1362084581$gmane$org@efficios.com>
References: <1362084510-10072-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1UBAPP-0001oh-9s
	for lttng-dev@lists.lttng.org; Thu, 28 Feb 2013 15:48:55 -0500
Received: by mail-ie0-f181.google.com with SMTP id 17so2647712iea.26
	for <lttng-dev@lists.lttng.org>; Thu, 28 Feb 2013 12:48:49 -0800 (PST)
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
 src/bin/lttng-sessiond/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
index e9529f1..82f0a84 100644
--- a/src/bin/lttng-sessiond/main.c
+++ b/src/bin/lttng-sessiond/main.c
@@ -1798,6 +1798,7 @@ static pid_t spawn_consumerd(struct consumer_data *consumer_data)
 				ret = putenv(tmpnew);
 				if (ret) {
 					ret = -errno;
+					free(tmpnew);
 					goto error;
 				}
 			}
@@ -1842,6 +1843,7 @@ static pid_t spawn_consumerd(struct consumer_data *consumer_data)
 				ret = putenv(tmpnew);
 				if (ret) {
 					ret = -errno;
+					free(tmpnew);
 					goto error;
 				}
 			}
-- 
1.8.1.3
