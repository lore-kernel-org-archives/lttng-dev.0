From: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
Subject: [PATCH lttng-ust 2/7] Define exclusion structure for
	UST ABI
Date: Thu,  7 Nov 2013 12:22:30 +0200
Message-ID: <1383819755-6891-3-git-send-email-jp_ikaheimonen__38712.4885841787$1383820248$gmane$org@mentor.com>
References: <1383819755-6891-1-git-send-email-jp_ikaheimonen@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1VeMjn-0007nC-UX
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 05:22:56 -0500
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
	by relay1.mentorg.com with esmtp
	id 1VeMji-0006I8-Gm from jp_ikaheimonen@mentor.com
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 02:22:50 -0800
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

Define a structure for holding exception data. The last data item
is a flexible array that contains a variable number of
exclusions names.

Signed-off-by: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
---
 include/lttng/ust-abi.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/lttng/ust-abi.h b/include/lttng/ust-abi.h
index ab70d57..0287466 100644
--- a/include/lttng/ust-abi.h
+++ b/include/lttng/ust-abi.h
@@ -228,6 +228,13 @@ struct lttng_ust_filter_bytecode {
 	char data[0];
 } LTTNG_PACKED;
 
+#define LTTNG_UST_EXCLUSION_PADDING	32
+struct lttng_ust_event_exclusion {
+	uint32_t count;
+	char padding[LTTNG_UST_EXCLUSION_PADDING];
+	char names[LTTNG_UST_SYM_NAME_LEN][0];
+} LTTNG_PACKED;
+
 #define _UST_CMD(minor)				(minor)
 #define _UST_CMDR(minor, type)			(minor)
 #define _UST_CMDW(minor, type)			(minor)
-- 
1.8.1.2
