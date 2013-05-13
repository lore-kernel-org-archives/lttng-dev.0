From: Jon Bernard <jbernard@tuxion.com>
Subject: [PATCH lttng-modules] Remove bashism in
 lttng-syscalls-generate-headers.sh
Date: Mon, 13 May 2013 10:33:18 -0400
Message-ID: <20130513143318.GA18192__21209.6564275727$1368455642$gmane$org@quintessa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jbernard@tuxion.com>) id 1Ubtod-0006ua-Rl
	for lttng-dev@lists.lttng.org; Mon, 13 May 2013 10:33:28 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 6B2752067F
	for <lttng-dev@lists.lttng.org>; Mon, 13 May 2013 10:33:22 -0400 (EDT)
Received: from localhost (unknown [216.252.204.142])
	by mail.messagingengine.com (Postfix) with ESMTPA id 25C322000C5
	for <lttng-dev@lists.lttng.org>; Mon, 13 May 2013 10:33:22 -0400 (EDT)
Content-Disposition: inline
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

Options to echo are not portable. In particular, the 'echo -e' option is
implemented by some shells, including bash, to expand escape sequences. However,
dash is one of the other family of shells that instead expands escape sequences
by default.

The printf command is portable and much more reliable.
---
 instrumentation/syscalls/lttng-syscalls-generate-headers.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/instrumentation/syscalls/lttng-syscalls-generate-headers.sh b/instrumentation/syscalls/lttng-syscalls-generate-headers.sh
index 046dc06..1754ae8 100755
--- a/instrumentation/syscalls/lttng-syscalls-generate-headers.sh
+++ b/instrumentation/syscalls/lttng-syscalls-generate-headers.sh
@@ -59,7 +59,7 @@ if [ "$CLASS" = integers ]; then
 
 NRARGS=0
 
-echo -e \
+printf \
 'SC_DECLARE_EVENT_CLASS_NOARGS(syscalls_noargs,\n'\
 '	TP_STRUCT__entry(),\n'\
 '	TP_fast_assign(),\n'\
-- 
1.7.10.4


-- 
Jon
