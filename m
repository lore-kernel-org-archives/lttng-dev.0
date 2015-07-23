From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH v2 lttng-ust 1/2] Doc: add
	LTTNG_UST_GETCPU_PLUGIN to man page
Date: Thu, 23 Jul 2015 16:02:50 -0400
Message-ID: <1437681771-7495-1-git-send-email-jonathan.rajotte-julien__30378.7824385383$1437681857$gmane$org@efficios.com>
References: <1437674396-13934-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1ZIMht-0006T9-IT
 for lttng-dev@lists.lttng.org; Thu, 23 Jul 2015 16:03:13 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id B1D7C34043E
 for <lttng-dev@lists.lttng.org>; Thu, 23 Jul 2015 20:03:01 +0000 (UTC)
In-Reply-To: <1437674396-13934-1-git-send-email-jonathan.rajotte-julien@efficios.com>
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

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 doc/man/lttng-ust.3 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/man/lttng-ust.3 b/doc/man/lttng-ust.3
index 15b4989..e66ab88 100644
--- a/doc/man/lttng-ust.3
+++ b/doc/man/lttng-ust.3
@@ -497,6 +497,11 @@ startup time.
 .IP "LTTNG_UST_WITHOUT_BADDR_STATEDUMP"
 Prevent liblttng-ust to perform a base-address statedump on session-enable.
 .PP
+.IP "LTTNG_UST_GETCPU_PLUGIN"
+Used by the getcpu override plugin system. The environment variable
+provides the path to the shared object which will act as the getcpu override
+plugin. An example can be found under doc/examples/getcpu-override .
+.PP
 
 .SH "SEE ALSO"
 
-- 
2.1.4
