From: Francis Giraldeau <francis.giraldeau@gmail.com>
Subject: [PATCH] Fix typo in run script
Date: Sat, 11 May 2013 20:31:52 -0400
Message-ID: <1368318712-31852-1-git-send-email-francis.giraldeau__4371.75277988917$1368318786$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <francis.giraldeau@gmail.com>) id 1UbKDK-0005cD-VK
	for lttng-dev@lists.lttng.org; Sat, 11 May 2013 20:32:35 -0400
Received: by mail-qc0-f169.google.com with SMTP id z10so2853871qcx.0
	for <lttng-dev@lists.lttng.org>; Sat, 11 May 2013 17:32:29 -0700 (PDT)
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

The actual library is liblttng-ust-libc-wrapper.so

Signed-off-by: Francis Giraldeau <francis.giraldeau@gmail.com>
---
 liblttng-ust-libc-wrapper/run | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/liblttng-ust-libc-wrapper/run b/liblttng-ust-libc-wrapper/run
index 2583d23..80d4175 100755
--- a/liblttng-ust-libc-wrapper/run
+++ b/liblttng-ust-libc-wrapper/run
@@ -1,3 +1,3 @@
 #!/bin/sh
 
-LD_VERBOSE=1 LD_PRELOAD=.libs/liblttng-ust-libc.so ${*}
+LD_VERBOSE=1 LD_PRELOAD=.libs/liblttng-ust-libc-wrapper.so ${*}
-- 
1.8.1.2
