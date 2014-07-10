From: francis.deslauriers@efficios.com
Subject: [PATCH lttng-ust] Move enablers syncing after the
	channel registration
Date: Thu, 10 Jul 2014 18:22:14 -0400
Message-ID: <1405030934-3924-1-git-send-email-francis.deslauriers__20717.6073374741$1405031047$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <fdeslaur@gmail.com>) id 1X5Mjz-0001Us-2Z
 for lttng-dev@lists.lttng.org; Thu, 10 Jul 2014 18:23:04 -0400
Received: by mail-qa0-f48.google.com with SMTP id x12so213074qac.35
 for <lttng-dev@lists.lttng.org>; Thu, 10 Jul 2014 15:22:53 -0700 (PDT)
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

From: Francis Deslauriers <francis.deslauriers@efficios.com>

Fixes possible race condition where an event registration is received
 before its channel registration by the consumer.

Signed-off-by: Francis Deslauriers <francis.deslauriers@efficios.com>
---
 liblttng-ust/lttng-events.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/liblttng-ust/lttng-events.c b/liblttng-ust/lttng-events.c
index e44628d..285b98e 100644
--- a/liblttng-ust/lttng-events.c
+++ b/liblttng-ust/lttng-events.c
@@ -248,8 +248,6 @@ int lttng_session_enable(struct lttng_session *session)
 
 	/* Set transient enabler state to "enabled" */
 	session->tstate = 1;
-	/* We need to sync enablers with session before activation. */
-	lttng_session_sync_enablers(session);
 
 	/*
 	 * Snapshot the number of events per channel to know the type of header
@@ -287,6 +285,9 @@ int lttng_session_enable(struct lttng_session *session)
 		}
 	}
 
+	/* We need to sync enablers with session before activation. */
+	lttng_session_sync_enablers(session);
+
 	/* Set atomically the state to "active" */
 	CMM_ACCESS_ONCE(session->active) = 1;
 	CMM_ACCESS_ONCE(session->been_active) = 1;
-- 
1.8.3.2
