From: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
Subject: [PATCH lttng-tools 02/28] Define a structure for event
	exclusion data
Date: Thu,  7 Nov 2013 12:18:24 +0200
Message-ID: <1383819504-6472-1-git-send-email-jp_ikaheimonen__19023.5177324668$1383819571$gmane$org@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1VeMft-0006jY-UL
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 05:18:54 -0500
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
	by relay1.mentorg.com with esmtp
	id 1VeMfo-0005kl-GN from jp_ikaheimonen@mentor.com
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 02:18:48 -0800
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

Define a structure that holds the event exclusion data. The last
data item is a flexible array that contains a variable number
of exclusion names.

Signed-off-by: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
---
 src/common/sessiond-comm/sessiond-comm.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/src/common/sessiond-comm/sessiond-comm.h b/src/common/sessiond-comm/sessiond-comm.h
index ed98248..9a33479 100644
--- a/src/common/sessiond-comm/sessiond-comm.h
+++ b/src/common/sessiond-comm/sessiond-comm.h
@@ -293,6 +293,18 @@ struct lttng_filter_bytecode {
 } LTTNG_PACKED;
 
 /*
+ * Event exclusion data. At the end of the structure, there will actually
+ * by zero or more names, where the actual number of names is given by
+ * the 'count' item of the structure.
+ */
+#define LTTNG_EVENT_EXCLUSION_PADDING	32
+struct lttng_event_exclusion {
+	uint32_t count;
+	char padding[LTTNG_EVENT_EXCLUSION_PADDING];
+	char names[LTTNG_SYMBOL_NAME_LEN][0];
+} LTTNG_PACKED;
+
+/*
  * Data structure for the response from sessiond to the lttng client.
  */
 struct lttcomm_lttng_msg {
-- 
1.8.1.2
