From: Andrew Gabbasov <andrew_gabbasov@mentor.com>
Subject: [PATCH lttng-tools] Fix a typo in lttng-probe-module
	name
Date: Wed, 28 Nov 2012 08:43:26 -0600
Message-ID: <1354113806-19089-1-git-send-email-andrew_gabbasov__37265.4818384492$1354113867$gmane$org@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Andrew_Gabbasov@mentor.com>) id 1TdirX-0002QO-V9
	for lttng-dev@lists.lttng.org; Wed, 28 Nov 2012 09:43:44 -0500
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
	by relay1.mentorg.com with esmtp
	id 1TdirR-0000tP-J9 from Andrew_Gabbasov@mentor.com
	for lttng-dev@lists.lttng.org; Wed, 28 Nov 2012 06:43:37 -0800
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

Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
---
 src/bin/lttng-sessiond/modprobe.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/bin/lttng-sessiond/modprobe.c b/src/bin/lttng-sessiond/modprobe.c
index f38d393..8e5cc94 100644
--- a/src/bin/lttng-sessiond/modprobe.c
+++ b/src/bin/lttng-sessiond/modprobe.c
@@ -54,7 +54,7 @@ const struct kern_modules_param kern_modules_list[] = {
 	{ "lttng-probe-kmem", 0 },
 	{ "lttng-probe-kvm", 0 },
 	{ "lttng-probe-lock", 0 },
-	{ "lttng-probe-modules", 0 },
+	{ "lttng-probe-module", 0 },
 	{ "lttng-probe-napi", 0 },
 	{ "lttng-probe-net", 0 },
 	{ "lttng-probe-power", 0 },
-- 
1.7.10.4
