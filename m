From: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
Subject: [PATCH lttng-tools 10/28] Add new error codes for
	exclusion processing
Date: Thu,  7 Nov 2013 12:21:34 +0200
Message-ID: <1383819703-6793-1-git-send-email-jp_ikaheimonen__27533.0274635509$1383819787$gmane$org@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1VeMiq-0007US-LY
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 05:22:00 -0500
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
	by relay1.mentorg.com with esmtp
	id 1VeMil-0006Cq-7F from jp_ikaheimonen@mentor.com
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 02:21:51 -0800
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

Add new error codes LTTNG_ERR_EXCLUSION_INVAL and LTTNG_ERR_EXCLUSION_NOMEM

Signed-off-by: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
---
 include/lttng/lttng-error.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/lttng/lttng-error.h b/include/lttng/lttng-error.h
index 7631dbc..f752fc4 100644
--- a/include/lttng/lttng-error.h
+++ b/include/lttng/lttng-error.h
@@ -140,6 +140,8 @@ enum lttng_error_code {
 	LTTNG_ERR_FILTER_NOMEM           = 107, /* Lack of memory for filter bytecode */
 	LTTNG_ERR_FILTER_EXIST           = 108, /* Filter already exist */
 	LTTNG_ERR_NO_CONSUMER            = 109, /* No consumer exist for the session */
+	LTTNG_ERR_EXCLUSION_INVAL        = 110, /* Invalid event exclusion data */
+	LTTNG_ERR_EXCLUSION_NOMEM        = 111, /* Lack of memory while processing event exclusions */
 
 	/* MUST be last element */
 	LTTNG_ERR_NR,                           /* Last element */
-- 
1.8.1.2
