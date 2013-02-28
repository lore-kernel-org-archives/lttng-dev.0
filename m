From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools] Fix: Memory leaks on error paths in
	config_read_session_name
Date: Thu, 28 Feb 2013 15:48:25 -0500
Message-ID: <1362084510-10072-2-git-send-email-christian.babeux__14076.4888296419$1362084580$gmane$org@efficios.com>
References: <1362084510-10072-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1UBAPK-0001o8-5B
	for lttng-dev@lists.lttng.org; Thu, 28 Feb 2013 15:48:50 -0500
Received: by mail-ie0-f180.google.com with SMTP id bn7so2627544ieb.25
	for <lttng-dev@lists.lttng.org>; Thu, 28 Feb 2013 12:48:44 -0800 (PST)
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
 src/bin/lttng/conf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/bin/lttng/conf.c b/src/bin/lttng/conf.c
index c1bfcfd..7439c1c 100644
--- a/src/bin/lttng/conf.c
+++ b/src/bin/lttng/conf.c
@@ -203,6 +203,7 @@ char *config_read_session_name(char *path)
 	if (fp == NULL) {
 		ERR("Can't find valid lttng config %s/.lttngrc", path);
 		MSG("Did you create a session? (lttng create <my_session>)");
+		free(session_name);
 		goto error;
 	}
 
@@ -221,6 +222,7 @@ char *config_read_session_name(char *path)
 	}
 
 error_close:
+	free(session_name);
 	ret = fclose(fp);
 	if (ret < 0) {
 		PERROR("close config read session name");
-- 
1.8.1.3
