From: Partha Pratim Mukherjee <ppm.floss@gmail.com>
Subject: [PATCH lttng-tools] Fix: destroy session removes the
	default config file
Date: Wed, 20 May 2015 18:59:01 +0000
Message-ID: <87h9r7yt1m.fsf__3570.15020349554$1432148553$gmane$org@hahabo.in>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <ppm.floss@gmail.com>) id 1Yv9Ey-000129-Dv
 for lttng-dev@lists.lttng.org; Wed, 20 May 2015 15:01:23 -0400
Received: by pdbnk13 with SMTP id nk13so78849167pdb.1
 for <lttng-dev@lists.lttng.org>; Wed, 20 May 2015 12:01:10 -0700 (PDT)
Received: from hahabo.in.hahabo.in ([162.243.157.168])
 by mx.google.com with ESMTPSA id jd4sm16865279pbd.46.2015.05.20.12.01.08
 for <lttng-dev@lists.lttng.org>
 (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
 Wed, 20 May 2015 12:01:09 -0700 (PDT)
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

Destroy session command by default removes the default config file
without checking the current session. As a result when we call any
other command which expects a default session by calling
get_session_name() function, it fails.

This patch will fix this by checking that the default config file gets
removed only when destroy session is called with the current session.

Fixes: #887

Signed-off-by: Partha Pratim Mukherjee <ppm.floss@gmail.com>
---
 src/bin/lttng/commands/destroy.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/bin/lttng/commands/destroy.c b/src/bin/lttng/commands/destroy.c
index 95343c9..3fcecc2 100644
--- a/src/bin/lttng/commands/destroy.c
+++ b/src/bin/lttng/commands/destroy.c
@@ -90,7 +90,9 @@ static int destroy_session(struct lttng_session *session)
 	}
 
 	MSG("Session %s destroyed", session->name);
-	config_destroy_default();
+	if (strncmp(session->name, get_session_name(), NAME_MAX) == 0) {
+		config_destroy_default();
+	}
 
 	if (lttng_opt_mi) {
 		ret = mi_lttng_session(writer, session, 0);
-- 
1.7.10.4
