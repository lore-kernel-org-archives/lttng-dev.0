From: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
Subject: [PATCH lttng-ust 6/7] Add handler for
	LTTNG_UST_EXCLUSION in UST ABI
Date: Thu,  7 Nov 2013 12:22:34 +0200
Message-ID: <1383819755-6891-7-git-send-email-jp_ikaheimonen__33328.3642693006$1383820324$gmane$org@mentor.com>
References: <1383819755-6891-1-git-send-email-jp_ikaheimonen@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1VeMjt-0007oS-34
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 05:23:02 -0500
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
	by relay1.mentorg.com with esmtp
	id 1VeMjn-0006Ir-LG from jp_ikaheimonen@mentor.com
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 02:22:55 -0800
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

Add message handler for the LTTNG_UST_EXCLUSION command in
UST ABI. Copy the exclusion data into a lttng_ust_excluder_node
structure and pass it to the enabler command handler.

Signed-off-by: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
---
 liblttng-ust/lttng-ust-comm.c | 62 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/liblttng-ust/lttng-ust-comm.c b/liblttng-ust/lttng-ust-comm.c
index bf2750c..597712b 100644
--- a/liblttng-ust/lttng-ust-comm.c
+++ b/liblttng-ust/lttng-ust-comm.c
@@ -488,6 +488,68 @@ int handle_message(struct sock_info *sock_info,
 		}
 		break;
 	}
+	case LTTNG_UST_EXCLUSION:
+	{
+		/* Receive exclusion names */
+		struct lttng_ust_excluder_node *node;
+		unsigned int count;
+
+		count = lum->u.exclusion.count;
+		if (count == 0) {
+			/* There are no names to read */
+			ret = 0;
+			goto error;
+		}
+		node = zmalloc(sizeof(*node) +
+				count * LTTNG_UST_SYM_NAME_LEN);
+		if (!node) {
+			ret = -ENOMEM;
+			goto error;
+		}
+		node->excluder.count = count;
+		len = ustcomm_recv_unix_sock(sock, node->excluder.names,
+				count * LTTNG_UST_SYM_NAME_LEN);
+		switch (len) {
+		case 0:	/* orderly shutdown */
+			ret = 0;
+			free(node);
+			goto error;
+		default:
+			if (len == count * LTTNG_UST_SYM_NAME_LEN) {
+				DBG("Exclusion data received");
+				break;
+			} else if (len < 0) {
+				DBG("Receive failed from lttng-sessiond with errno %d", (int) -len);
+				if (len == -ECONNRESET) {
+					ERR("%s remote end closed connection", sock_info->name);
+					ret = len;
+					free(node);
+					goto error;
+				}
+				ret = len;
+				free(node);
+				goto end;
+			} else {
+				DBG("Incorrect exclusion data message size: %zd", len);
+				ret = -EINVAL;
+				free(node);
+				goto end;
+			}
+		}
+		if (ops->cmd) {
+			ret = ops->cmd(lum->handle, lum->cmd,
+					(unsigned long) node,
+					&args, sock_info);
+			if (ret) {
+				free(node);
+			}
+			/* Don't free exclusion data if everything went fine. */
+		} else {
+			ret = -ENOSYS;
+			free(node);
+		}
+		break;
+	}
 	case LTTNG_UST_CHANNEL:
 	{
 		void *chan_data;
-- 
1.8.1.2
