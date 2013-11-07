From: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
Subject: [PATCH lttng-ust 1/7] Define a new command
	LTTNG_UST_EXCLUSION
Date: Thu,  7 Nov 2013 12:22:29 +0200
Message-ID: <1383819755-6891-2-git-send-email-jp_ikaheimonen__4.00388748875713$1383820229$gmane$org@mentor.com>
References: <1383819755-6891-1-git-send-email-jp_ikaheimonen@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1VeMjm-0007mP-Mh
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 05:22:55 -0500
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
	by relay1.mentorg.com with esmtp
	id 1VeMjh-0006Hx-8W from jp_ikaheimonen@mentor.com
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 02:22:49 -0800
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

Define a new command id for attaching exclusions to enablers.
Define the structure for passing the command.

Signed-off-by: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
---
 include/lttng/ust-abi.h       | 1 +
 include/ust-comm.h            | 3 +++
 liblttng-ust/lttng-ust-comm.c | 1 +
 3 files changed, 5 insertions(+)

diff --git a/include/lttng/ust-abi.h b/include/lttng/ust-abi.h
index 6630332..ab70d57 100644
--- a/include/lttng/ust-abi.h
+++ b/include/lttng/ust-abi.h
@@ -273,6 +273,7 @@ struct lttng_ust_filter_bytecode {
 
 /* Event FD commands */
 #define LTTNG_UST_FILTER			_UST_CMD(0xA0)
+#define LTTNG_UST_EXCLUSION			_UST_CMD(0xA1)
 
 #define LTTNG_UST_ROOT_HANDLE	0
 
diff --git a/include/ust-comm.h b/include/ust-comm.h
index ae53f15..b9bbb39 100644
--- a/include/ust-comm.h
+++ b/include/ust-comm.h
@@ -91,6 +91,9 @@ struct ustcomm_ust_msg {
 			uint32_t reloc_offset;
 			uint64_t seqnum;
 		} LTTNG_PACKED filter;
+		struct {
+			uint32_t count;	/* how many names follow */
+		} LTTNG_PACKED exclusion;
 		char padding[USTCOMM_MSG_PADDING2];
 	} u;
 } LTTNG_PACKED;
diff --git a/liblttng-ust/lttng-ust-comm.c b/liblttng-ust/lttng-ust-comm.c
index a6e4ba3..bf2750c 100644
--- a/liblttng-ust/lttng-ust-comm.c
+++ b/liblttng-ust/lttng-ust-comm.c
@@ -172,6 +172,7 @@ static const char *cmd_name_mapping[] = {
 
 	/* Event FD commands */
 	[ LTTNG_UST_FILTER ] = "Create Filter",
+	[ LTTNG_UST_EXCLUSION ] = "Add exclusions to event",
 };
 
 static const char *str_timeout;
-- 
1.8.1.2
