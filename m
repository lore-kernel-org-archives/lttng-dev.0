From: Benjamin Poirier <bpoirier@suse.de>
Subject: [PATCH latency_tracker] Use $(src) rather than pwd to
	identify the source tree.
Date: Wed, 20 May 2015 16:32:54 -0700
Message-ID: <1432164774-11677-1-git-send-email-bpoirier__24954.9092994586$1432164990$gmane$org@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <benjamin.poirier@gmail.com>) id 1YvDUo-0002O6-QI
 for lttng-dev@lists.lttng.org; Wed, 20 May 2015 19:34:03 -0400
Received: by pabru16 with SMTP id ru16so84030076pab.1
 for <lttng-dev@lists.lttng.org>; Wed, 20 May 2015 16:33:49 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Julien Desfossez <jdesfossez@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This fixes the build when using kernels older than "aa55c8e kbuild: handle
C=... and M=... after entering into build directory (v3.18-rc1)" and a
separate object output directory (`make O=...`).

Signed-off-by: Benjamin Poirier <bpoirier@suse.de>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 360b24b..de141df 100644
--- a/Makefile
+++ b/Makefile
@@ -1,4 +1,4 @@
-ccflags-y += -I$(PWD)/include $(EXTCFLAGS)
+ccflags-y += -I$(src)/include $(EXTCFLAGS)
 
 latency_tracker-objs := tracker.o rculfhash.o rculfhash-mm-chunk.o wfcqueue.o
 
-- 
2.3.5
