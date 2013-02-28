From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools] Fix: Memory leak when zmalloc fail
	on kernel channel allocation
Date: Thu, 28 Feb 2013 15:48:29 -0500
Message-ID: <1362084510-10072-6-git-send-email-christian.babeux__22587.1005481624$1362084603$gmane$org@efficios.com>
References: <1362084510-10072-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ia0-f181.google.com ([209.85.210.181])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1UBAPh-0001s7-Bs
	for lttng-dev@lists.lttng.org; Thu, 28 Feb 2013 15:49:13 -0500
Received: by mail-ia0-f181.google.com with SMTP id w33so1952708iag.26
	for <lttng-dev@lists.lttng.org>; Thu, 28 Feb 2013 12:49:08 -0800 (PST)
In-Reply-To: <1362084510-10072-1-git-send-email-christian.babeux@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 src/bin/lttng-sessiond/trace-kernel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/bin/lttng-sessiond/trace-kernel.c b/src/bin/lttng-sessiond/trace-kernel.c
index 48be065..8839a00 100644
--- a/src/bin/lttng-sessiond/trace-kernel.c
+++ b/src/bin/lttng-sessiond/trace-kernel.c
@@ -158,6 +158,7 @@ struct ltt_kernel_channel *trace_kernel_create_channel(
 	lkc->channel = zmalloc(sizeof(struct lttng_channel));
 	if (lkc->channel == NULL) {
 		PERROR("lttng_channel zmalloc");
+		free(lkc);
 		goto error;
 	}
 	memcpy(lkc->channel, chan, sizeof(struct lttng_channel));
-- 
1.8.1.3
