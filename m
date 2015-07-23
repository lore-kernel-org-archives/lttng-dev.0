From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-ust 1/2] Doc: add LTTNG_UST_GETCPU_PLUGIN
	to man page
Date: Thu, 23 Jul 2015 13:59:55 -0400
Message-ID: <1437674396-13934-1-git-send-email-jonathan.rajotte-julien__31817.8894850009$1437674501$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1ZIKn0-0005mQ-LZ
 for lttng-dev@lists.lttng.org; Thu, 23 Jul 2015 14:00:17 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id C51A1340418
 for <lttng-dev@lists.lttng.org>; Thu, 23 Jul 2015 18:00:10 +0000 (UTC)
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
index 15b4989..829f7ae 100644
--- a/doc/man/lttng-ust.3
+++ b/doc/man/lttng-ust.3
@@ -497,6 +497,11 @@ startup time.
 .IP "LTTNG_UST_WITHOUT_BADDR_STATEDUMP"
 Prevent liblttng-ust to perform a base-address statedump on session-enable.
 .PP
+.IP "LTTNG_UST_GETCPU_PLUGIN"
+Used by the getcpu override plugin system. The environment variable is used to
+provide the path of the shared object who will act as the getcpu override
+plugin. Example can be found under doc/example/getcpu-override .
+.PP
 
 .SH "SEE ALSO"
 
-- 
2.1.4
