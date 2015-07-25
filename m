From: Partha Pratim Mukherjee <ppm.floss@gmail.com>
Subject: [PATCH lttng-tools] Fix: set session should not set
	not-existent session
Date: Sat, 25 Jul 2015 13:25:19 +0530
Message-ID: <87si8cwu1k.fsf__6947.85889140821$1437811071$gmane$org@nono.intra.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <ppm.floss@gmail.com>) id 1ZIuJm-0000HS-LC
 for lttng-dev@lists.lttng.org; Sat, 25 Jul 2015 03:56:33 -0400
Received: by pdbnt7 with SMTP id nt7so24606413pdb.0
 for <lttng-dev@lists.lttng.org>; Sat, 25 Jul 2015 00:56:20 -0700 (PDT)
Received: from nono.intra.net.hahabo.in ([122.177.177.234])
 by smtp.gmail.com with ESMTPSA id fn1sm7003218pab.8.2015.07.25.00.56.17
 for <lttng-dev@lists.lttng.org>
 (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
 Sat, 25 Jul 2015 00:56:19 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

set session does not check the existence of a session before setting
it as the current session. Fix it so that it gives error for
not-existent session.

Fixes: #885

Signed-off-by: Partha Pratim Mukherjee <ppm.floss@gmail.com>
---
 src/bin/lttng/commands/set_session.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/src/bin/lttng/commands/set_session.c b/src/bin/lttng/commands/set_session.c
index 3196f12..14fe9af 100644
--- a/src/bin/lttng/commands/set_session.c
+++ b/src/bin/lttng/commands/set_session.c
@@ -106,11 +106,34 @@ end:
 static int set_session(void)
 {
 	int ret = CMD_SUCCESS;
+	int count, i;
+	unsigned int session_found = 0;
+	struct lttng_session *sessions;
 
 	if (opt_session_name && strlen(opt_session_name) > NAME_MAX) {
 		ERR("Session name too long. Length must be lower or equal to %d",
 			NAME_MAX);
 		ret = CMD_ERROR;
+		goto end;
+	}
+
+	count = lttng_list_sessions(&sessions);
+	if (count < 0) {
+		ret = CMD_ERROR;
+		ERR("%s", lttng_strerror(count));
+		goto end;
+	}
+
+	for (i = 0; i < count; i++) {
+		if (strncmp(sessions[i].name, opt_session_name, NAME_MAX) == 0) {
+			session_found = 1;
+			break;
+		}
+	}
+
+	if (!session_found) {
+		ERR("Session '%s' not found", opt_session_name);
+		ret = CMD_ERROR;
 		goto error;
 	}
 
@@ -133,6 +156,8 @@ static int set_session(void)
 	ret = CMD_SUCCESS;
 
 error:
+	free(sessions);
+end:
 	return ret;
 }
 
-- 
1.7.10.4
