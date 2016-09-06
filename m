From: Duncan Sands <duncan.sands@deepbluecap.com>
Subject: [PATCH] [URCU] Allow forcing the use of sys membarrier
Date: Tue, 6 Sep 2016 15:07:10 +0200
Message-ID: <6667246e-6677-1a47-94b6-b469fdf558ff__15625.9791962386$1473245706$gmane$org@free.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------EA08A3FFEA23AF46E2B7754A"
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wm0-f41.google.com (mail-wm0-f41.google.com [74.125.82.41])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id DD28DA3AC0
 for <lttng-dev@lists.lttng.org>; Tue,  6 Sep 2016 13:07:53 +0000 (UTC)
Received: by mail-wm0-f41.google.com with SMTP id b187so63314194wme.1
 for <lttng-dev@lists.lttng.org>; Tue, 06 Sep 2016 06:07:13 -0700 (PDT)
Received: from ?IPv6:2a01:e35:2e83:a840:b561:afa3:8000:8a7d?
 ([2a01:e35:2e83:a840:b561:afa3:8000:8a7d])
 by smtp.gmail.com with ESMTPSA id g141sm4904436wmd.1.2016.09.06.06.07.11
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 06 Sep 2016 06:07:11 -0700 (PDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This is a multi-part message in MIME format.
--------------EA08A3FFEA23AF46E2B7754A
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

When using the RCU_MEMBARRIER flavour of userspace-RCU, kernel support for 
sys-membarrier is detected dynamically and stored in the rcu_has_sys_membarrier 
global variable.  Checking the value of this variable adds a small but 
measurable overhead to smp_mb_slave.  I only use userspace-rcu on systems which 
support sys-membarrier, and I'd like a way of avoiding that overhead.

The attached patch makes the following changes: if RCU_FORCE_SYS_MEMBARRIER is 
defined then rcu_has_sys_membarrier is replaced with the constant 1, eliminating 
the overhead in smp_mb_slave.  As a sanity check, support for sys-membarrier is 
still detected at startup and if it isn't supported then the program aborts.

I didn't try to integrate this feature into the build system (eg by adding a 
configure option for it) since I'm using my own build system.

Best wishes, Duncan.

--------------EA08A3FFEA23AF46E2B7754A
Content-Type: text/x-patch;
 name="force-sys-membarrier.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="force-sys-membarrier.diff"

Index: userspace-rcu-0.9.2/urcu/map/urcu.h
===================================================================
--- userspace-rcu-0.9.2/urcu/map/urcu.h	(revision 32603)
+++ userspace-rcu-0.9.2/urcu/map/urcu.h	(working copy)
@@ -80,9 +80,6 @@
 
 #define rcu_flavor			rcu_flavor_memb
 
-/* Specific to MEMBARRIER flavor */
-#define rcu_has_sys_membarrier		rcu_has_sys_membarrier_memb
-
 #elif defined(RCU_SIGNAL)
 
 #define rcu_read_lock			rcu_read_lock_sig
Index: userspace-rcu-0.9.2/urcu/static/urcu.h
===================================================================
--- userspace-rcu-0.9.2/urcu/static/urcu.h	(revision 32603)
+++ userspace-rcu-0.9.2/urcu/static/urcu.h	(working copy)
@@ -90,7 +90,11 @@
  */
 
 #ifdef RCU_MEMBARRIER
+#ifdef RCU_FORCE_SYS_MEMBARRIER
+#define rcu_has_sys_membarrier 1
+#else
 extern int rcu_has_sys_membarrier;
+#endif
 
 static inline void smp_mb_slave(void)
 {
Index: userspace-rcu-0.9.2/urcu.c
===================================================================
--- userspace-rcu-0.9.2/urcu.c	(revision 32603)
+++ userspace-rcu-0.9.2/urcu.c	(working copy)
@@ -78,7 +78,9 @@
 
 #ifdef RCU_MEMBARRIER
 static int init_done;
+#ifndef RCU_FORCE_SYS_MEMBARRIER
 int rcu_has_sys_membarrier;
+#endif
 
 void __attribute__((constructor)) rcu_init(void);
 #endif
@@ -542,7 +544,12 @@
 	init_done = 1;
 	ret = membarrier(MEMBARRIER_CMD_QUERY, 0);
 	if (ret >= 0 && (ret & MEMBARRIER_CMD_SHARED)) {
+#ifndef RCU_FORCE_SYS_MEMBARRIER
 		rcu_has_sys_membarrier = 1;
+#else
+	} else {
+		abort();
+#endif
 	}
 }
 #endif

--------------EA08A3FFEA23AF46E2B7754A
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--------------EA08A3FFEA23AF46E2B7754A--
