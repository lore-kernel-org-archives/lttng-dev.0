From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules] Fix: version checks for kernel 4.0
Date: Wed, 17 Jun 2015 16:28:02 -0400
Message-ID: <1434572882-29119-1-git-send-email-mjeanson__17384.0701034807$1434572986$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mjeanson@efficios.com>) id 1Z5Jwt-0006JY-Bu
 for lttng-dev@lists.lttng.org; Wed, 17 Jun 2015 16:28:41 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id C9C2A340334
 for <lttng-dev@lists.lttng.org>; Wed, 17 Jun 2015 20:28:33 +0000 (UTC)
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
 probes/Makefile | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/probes/Makefile b/probes/Makefile
index 4de157b..f0325c8 100644
--- a/probes/Makefile
+++ b/probes/Makefile
@@ -61,10 +61,12 @@ obj-m +=  $(shell \
 		-o \( $(VERSION) -eq 2 -a $(PATCHLEVEL) -ge 6 -a $(SUBLEVEL) -ge 37 \) ] ; then \
 		echo "lttng-probe-net.o" ; fi;)
 obj-m +=  $(shell \
-	if [ $(VERSION) -ge 3 -a $(PATCHLEVEL) -ge 1 ] ; then \
+	if [ $(VERSION) -ge 4 \
+		-o \( $(VERSION) -eq 3 -a $(PATCHLEVEL) -ge 1 \) ] ; then \
 		echo "lttng-probe-sock.o" ; fi;)
 obj-m +=  $(shell \
-	if [ $(VERSION) -ge 3 -a $(PATCHLEVEL) -ge 1 ] ; then \
+	if [ $(VERSION) -ge 4 \
+		-o \( $(VERSION) -eq 3 -a $(PATCHLEVEL) -ge 1 \) ] ; then \
 		echo "lttng-probe-udp.o" ; fi;)
 endif
 
@@ -79,8 +81,8 @@ ifneq ($(CONFIG_EXT3_FS),)
 ext3_dep = $(srctree)/fs/ext3/*.h
 ext3_dep_check = $(wildcard $(ext3_dep))
 ext3 = $(shell \
-	if [ $(VERSION) -ge 3 -a $(PATCHLEVEL) -ge 1 ] ; then \
-		if [ $(VERSION) -ge 3 -a $(PATCHLEVEL) -ge 4 -a \
+	if [ $(VERSION) -ge 4 -o \( $(VERSION) -eq 3 -a $(PATCHLEVEL) -ge 1 \) ] ; then \
+		if [ \( $(VERSION) -ge 4 -o \( $(VERSION) -eq 3 -a $(PATCHLEVEL) -ge 4 \) \) -a \
 			-z "$(ext3_dep_check)" ] ; then \
 			echo "warn" ; \
 			exit ; \
@@ -106,7 +108,8 @@ endif
 
 ifneq ($(CONFIG_JBD),)
 obj-m +=  $(shell \
-	if [ $(VERSION) -ge 3 -a $(PATCHLEVEL) -ge 1 ] ; then \
+	if [ $(VERSION) -ge 4 \
+		-o \( $(VERSION) -eq 3 -a $(PATCHLEVEL) -ge 1 \) ] ; then \
 		echo "lttng-probe-jbd.o" ; fi;)
 endif
 
@@ -172,7 +175,8 @@ obj-m += $(ext4)
 endif
 
 obj-m +=  $(shell \
-	if [ $(VERSION) -ge 3 -a $(PATCHLEVEL) -ge 4 ] ; then \
+	if [ $(VERSION) -ge 4 \
+		-o \( $(VERSION) -eq 3 -a $(PATCHLEVEL) -ge 4 \) ] ; then \
 		echo "lttng-probe-printk.o" ; fi;)
 ifneq ($(CONFIG_FRAME_WARN),0)
 CFLAGS_lttng-probe-printk.o += -Wframe-larger-than=2200
-- 
1.9.1
