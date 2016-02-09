From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules] Fix: Add CONFIG_LTTNG to
	modules_install target
Date: Tue,  9 Feb 2016 15:16:56 -0500
Message-ID: <1455049016-6087-1-git-send-email-mjeanson__30471.61054933$1455049082$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mjeanson@efficios.com>) id 1aTEii-00007w-Ki
 for lttng-dev@lists.lttng.org; Tue, 09 Feb 2016 15:17:09 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 6D12B340526
 for <lttng-dev@lists.lttng.org>; Tue,  9 Feb 2016 20:17:03 +0000 (UTC)
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

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 6a8c5c7..5d6be94 100644
--- a/Makefile
+++ b/Makefile
@@ -103,12 +103,12 @@ default:
 	$(MAKE) -C $(KERNELDIR) M=$(PWD) CONFIG_LTTNG=m modules
 
 modules_install:
-	$(MAKE) -C $(KERNELDIR) M=$(PWD) modules_install
+	$(MAKE) -C $(KERNELDIR) M=$(PWD) CONFIG_LTTNG=m modules_install
 
 clean:
 	$(MAKE) -C $(KERNELDIR) M=$(PWD) clean
 
 %.i: %.c
-	$(MAKE) -C $(KERNELDIR) M=$(PWD) $@
+	$(MAKE) -C $(KERNELDIR) M=$(PWD) CONFIG_LTTNG=m $@
 
 endif # KERNELRELEASE
-- 
2.7.0
