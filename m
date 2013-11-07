From: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
Subject: [PATCH lttng-ust 5/7] Store exclusions to enablers
Date: Thu,  7 Nov 2013 12:22:33 +0200
Message-ID: <1383819755-6891-6-git-send-email-jp_ikaheimonen__9184.06462665207$1383820300$gmane$org@mentor.com>
References: <1383819755-6891-1-git-send-email-jp_ikaheimonen@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1VeMjr-0007no-Pi
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 05:23:00 -0500
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
	by relay1.mentorg.com with esmtp
	id 1VeMjm-0006IO-CA from jp_ikaheimonen@mentor.com
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 02:22:54 -0800
In-Reply-To: <1383819755-6891-1-git-send-email-jp_ikaheimonen@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Implement a function that adds exclusions to the list in the enabler.
Call this function in the enabler command handler when the
LTTNG_UST_EXCLUSION command is received.

Signed-off-by: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
---
 include/lttng/ust-events.h   | 2 ++
 liblttng-ust/lttng-events.c  | 9 +++++++++
 liblttng-ust/lttng-ust-abi.c | 7 +++++++
 3 files changed, 18 insertions(+)

diff --git a/include/lttng/ust-events.h b/include/lttng/ust-events.h
index db8b9dc..5d43570 100644
--- a/include/lttng/ust-events.h
+++ b/include/lttng/ust-events.h
@@ -549,6 +549,8 @@ int lttng_enabler_attach_bytecode(struct lttng_enabler *enabler,
 		struct lttng_ust_filter_bytecode_node *bytecode);
 int lttng_enabler_attach_context(struct lttng_enabler *enabler,
 		struct lttng_ust_context *ctx);
+int lttng_enabler_attach_exclusion(struct lttng_enabler *enabler,
+		struct lttng_ust_excluder_node *excluder);
 
 int lttng_attach_context(struct lttng_ust_context *context_param,
 		struct lttng_ctx **ctx, struct lttng_session *session);
diff --git a/liblttng-ust/lttng-events.c b/liblttng-ust/lttng-events.c
index ad374f3..915cffb 100644
--- a/liblttng-ust/lttng-events.c
+++ b/liblttng-ust/lttng-events.c
@@ -721,6 +721,15 @@ int lttng_enabler_attach_bytecode(struct lttng_enabler *enabler,
 	return 0;
 }
 
+int lttng_enabler_attach_exclusion(struct lttng_enabler *enabler,
+		struct lttng_ust_excluder_node *excluder)
+{
+	excluder->enabler = enabler;
+	cds_list_add_tail(&excluder->node, &enabler->excluder_head);
+	lttng_session_lazy_sync_enablers(enabler->chan->session);
+	return 0;
+}
+
 int lttng_attach_context(struct lttng_ust_context *context_param,
 		struct lttng_ctx **ctx, struct lttng_session *session)
 {
diff --git a/liblttng-ust/lttng-ust-abi.c b/liblttng-ust/lttng-ust-abi.c
index a852aae..61245a8 100644
--- a/liblttng-ust/lttng-ust-abi.c
+++ b/liblttng-ust/lttng-ust-abi.c
@@ -933,6 +933,8 @@ static const struct lttng_ust_objd_ops lttng_channel_ops = {
  *		Disable recording for this enabler
  *	LTTNG_UST_FILTER
  *		Attach a filter to an enabler.
+ *	LTTNG_UST_EXCLUSION
+ *		Attach exclusions to an enabler.
  */
 static
 long lttng_enabler_cmd(int objd, unsigned int cmd, unsigned long arg,
@@ -958,6 +960,11 @@ long lttng_enabler_cmd(int objd, unsigned int cmd, unsigned long arg,
 			return ret;
 		return 0;
 	}
+	case LTTNG_UST_EXCLUSION:
+	{
+		return lttng_enabler_attach_exclusion(enabler,
+				(struct lttng_ust_excluder_node *) arg);
+	}
 	default:
 		return -EINVAL;
 	}
-- 
1.8.1.2
