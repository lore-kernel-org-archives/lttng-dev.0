From: Junchang Wang <junchangwang@gmail.com>
Subject: [RFC 3/4] userspace-rcu: Update Makefile.am to include
 rculflist into the project
Date: Wed, 10 Jul 2019 11:28:09 +0800
Message-ID: <1562729290-6437-4-git-send-email-junchangwang__38438.4977792919$1562729544$gmane$org@gmail.com>
References: <1562729290-6437-1-git-send-email-junchangwang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 by lists.lttng.org (Postfix) with ESMTPS id 45k4Rt4KgYz163w
 for <lttng-dev@lists.lttng.org>; Tue,  9 Jul 2019 23:29:30 -0400 (EDT)
Received: by mail-pl1-x635.google.com with SMTP id y8so445357plr.12
 for <lttng-dev@lists.lttng.org>; Tue, 09 Jul 2019 20:29:30 -0700 (PDT)
In-Reply-To: <1562729290-6437-1-git-send-email-junchangwang@gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: mathieu.desnoyers@efficios.com, lttng-dev@lists.lttng.org
Cc: paulmck@linux.ibm.com
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Junchang Wang <junchangwang@gmail.com>
---
 include/Makefile.am | 1 +
 include/urcu/cds.h  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/Makefile.am b/include/Makefile.am
index 34812d4..c4de329 100644
--- a/include/Makefile.am
+++ b/include/Makefile.am
@@ -2,6 +2,7 @@ nobase_dist_include_HEADERS = urcu/compiler.h urcu/hlist.h urcu/list.h \
 		urcu/rculist.h urcu/rcuhlist.h urcu/system.h urcu/futex.h \
 		urcu/uatomic/generic.h urcu/arch/generic.h urcu/wfstack.h \
 		urcu/wfqueue.h urcu/rculfstack.h urcu/rculfqueue.h \
+		urcu/rculflist.h \
 		urcu/ref.h urcu/cds.h urcu/urcu_ref.h urcu/urcu-futex.h \
 		urcu/uatomic_arch.h urcu/rculfhash.h urcu/wfcqueue.h \
 		urcu/lfstack.h urcu/syscall-compat.h \
diff --git a/include/urcu/cds.h b/include/urcu/cds.h
index 78534bb..faa31ab 100644
--- a/include/urcu/cds.h
+++ b/include/urcu/cds.h
@@ -30,6 +30,7 @@
 #include <urcu/rculfqueue.h>
 #include <urcu/rculfstack.h>
 #include <urcu/rculfhash.h>
+#include <urcu/rculflist.h>
 #include <urcu/wfqueue.h>
 #include <urcu/wfcqueue.h>
 #include <urcu/wfstack.h>
-- 
2.7.4
