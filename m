From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 2/2] Cleanup: remove "disabled" flag
	for new release cycle
Date: Wed, 12 Nov 2014 18:18:33 -0500
Message-ID: <1415834313-10400-2-git-send-email-mathieu.desnoyers__29329.4151001193$1415834409$gmane$org@efficios.com>
References: <1415834313-10400-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1XohBw-0000nP-Cb
 for lttng-dev@lists.lttng.org; Wed, 12 Nov 2014 18:19:13 -0500
In-Reply-To: <1415834313-10400-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-sessiond/trace-ust.c |  5 -----
 src/bin/lttng-sessiond/ust-app.c   | 21 ---------------------
 2 files changed, 26 deletions(-)

diff --git a/src/bin/lttng-sessiond/trace-ust.c b/src/bin/lttng-sessiond/trace-ust.c
index ac980fd..1f6fd52 100644
--- a/src/bin/lttng-sessiond/trace-ust.c
+++ b/src/bin/lttng-sessiond/trace-ust.c
@@ -419,11 +419,6 @@ struct ltt_ust_event *trace_ust_create_event(struct lttng_event *ev,
 		ERR("Unknown ust loglevel type (%d)", ev->loglevel_type);
 		goto error_free_event;
 	}
-	/*
-	 * Fix for enabler race. Enable is now done explicitly by
-	 * sessiond after setting filter.
-	 */
-	lue->attr.disabled = 1;
 
 	/* Same layout. */
 	lue->filter_expression = filter_expression;
diff --git a/src/bin/lttng-sessiond/ust-app.c b/src/bin/lttng-sessiond/ust-app.c
index 7e4bf94..c2d2074 100644
--- a/src/bin/lttng-sessiond/ust-app.c
+++ b/src/bin/lttng-sessiond/ust-app.c
@@ -1471,27 +1471,6 @@ int create_ust_event(struct ust_app *app, struct ust_app_session *ua_sess,
 			}
 			goto error;
 		}
-	} else {
-		ret = disable_ust_event(app, ua_sess, ua_event);
-		if (ret < 0) {
-			/*
-			 * If we hit an EPERM, something is wrong with our disable call. If
-			 * we get an EEXIST, there is a problem on the tracer side since we
-			 * just created it.
-			 */
-			switch (ret) {
-			case -LTTNG_UST_ERR_PERM:
-				/* Code flow problem */
-				assert(0);
-			case -LTTNG_UST_ERR_EXIST:
-				/* It's OK for our use case. */
-				ret = 0;
-				break;
-			default:
-				break;
-			}
-			goto error;
-		}
 	}
 
 error:
-- 
2.1.1
