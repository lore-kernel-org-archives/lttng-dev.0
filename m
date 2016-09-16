From: Duncan Sands <duncan.sands@deepbluecap.com>
Subject: Re: [PATCH] [URCU] Allow forcing the use of sys
 membarrier
Date: Fri, 16 Sep 2016 17:38:49 +0200
Message-ID: <bc09b6a2-ea88-550b-0ebe-c35782ea3f4f__16836.6046659232$1474042180$gmane$org@deepbluecap.com>
References: <6667246e-6677-1a47-94b6-b469fdf558ff@free.fr>
 <1661830054.13479.1473692701109.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------2612C4CA9E2856B3142FFEED"
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wm0-f49.google.com (mail-wm0-f49.google.com [74.125.82.49])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id D77E3A4072
 for <lttng-dev@lists.lttng.org>; Fri, 16 Sep 2016 15:39:51 +0000 (UTC)
Received: by mail-wm0-f49.google.com with SMTP id k186so48600572wmd.0
 for <lttng-dev@lists.lttng.org>; Fri, 16 Sep 2016 08:38:52 -0700 (PDT)
In-Reply-To: <1661830054.13479.1473692701109.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

This is a multi-part message in MIME format.
--------------2612C4CA9E2856B3142FFEED
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Mathieu,

On 09/12/2016 05:05 PM, Mathieu Desnoyers wrote:
> ----- On Sep 6, 2016, at 9:07 AM, Duncan Sands duncan.sands@deepbluecap.com wrote:
>
>> When using the RCU_MEMBARRIER flavour of userspace-RCU, kernel support for
>> sys-membarrier is detected dynamically and stored in the rcu_has_sys_membarrier
>> global variable.  Checking the value of this variable adds a small but
>> measurable overhead to smp_mb_slave.  I only use userspace-rcu on systems which
>> support sys-membarrier, and I'd like a way of avoiding that overhead.
>>
>> The attached patch makes the following changes: if RCU_FORCE_SYS_MEMBARRIER is
>> defined then rcu_has_sys_membarrier is replaced with the constant 1, eliminating
>> the overhead in smp_mb_slave.  As a sanity check, support for sys-membarrier is
>> still detected at startup and if it isn't supported then the program aborts.
>>
>> I didn't try to integrate this feature into the build system (eg by adding a
>> configure option for it) since I'm using my own build system.
>
> Hi Duncan,
>
> This is an interesting improvement. I'd be interested to merge it if it was
> integrated with the liburcu build system. Perhaps a --disable-dynamic-membarrier-check
> at configure ?

how about the attached patch?

Ciao, Duncan.

>
> Thanks,
>
> Mathieu
>
>>
>> Best wishes, Duncan.
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>


--------------2612C4CA9E2856B3142FFEED
Content-Type: text/x-patch;
 name="force.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="force.diff"

diff --git a/README.md b/README.md
index 6fe9c1e..adc432a 100644
--- a/README.md
+++ b/README.md
@@ -159,7 +159,9 @@ This is the preferred version of the library, in terms of
 grace-period detection speed, read-side speed and flexibility.
 Dynamically detects kernel support for `sys_membarrier()`. Falls back
 on `urcu-mb` scheme if support is not present, which has slower
-read-side.
+read-side.  Use the --disable-sys-membarrier-fallback configure option
+to disable falling back.  This gives a small speedup when `sys_membarrier()`
+is supported by the kernel (and a crash when it isn't).
 
 
 ### Usage of `liburcu-qsbr`
diff --git a/configure.ac b/configure.ac
index 7a992ed..5709270 100644
--- a/configure.ac
+++ b/configure.ac
@@ -18,6 +18,7 @@ AM_MAINTAINER_MODE([enable])
 # Enable silent rules if available (Introduced in AM 1.11)
 m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes])])
 
+AH_TEMPLATE([RCU_FORCE_SYS_MEMBARRIER], [Require the O/S to support sys-membarrier (when using the default flavor).])
 AH_TEMPLATE([CONFIG_RCU_SMP], [Enable SMP support. With SMP support enabled, uniprocessors are also supported. With SMP support disabled, UP systems work fine, but the behavior of SMP systems is undefined.])
 AH_TEMPLATE([CONFIG_RCU_HAVE_FENCE], [Defined when on a system that has memory fence instructions.])
 AH_TEMPLATE([CONFIG_RCU_HAVE_FUTEX], [Defined when on a system with futex support.])
@@ -26,6 +27,13 @@ AH_TEMPLATE([CONFIG_RCU_ARM_HAVE_DMB], [Use the dmb instruction if available for
 AH_TEMPLATE([CONFIG_RCU_TLS], [TLS provided by the compiler.])
 AH_TEMPLATE([CONFIG_RCU_HAVE_CLOCK_GETTIME], [clock_gettime() is detected.])
 
+# Allow requiring the O/S to support sys-membarrier (when using the default flavor).
+AC_ARG_ENABLE([sys-membarrier-fallback],
+	AS_HELP_STRING([--disable-sys-membarrier-fallback], [Abort if sys-membarrier is needed but not available rather than using a slow alternative.]),
+	[def_sys_membarrier_fallback=$enableval],
+	[def_sys_membarrier_fallback="yes"])
+AS_IF([test "x$def_sys_membarrier_fallback" != "xyes"], [AC_DEFINE([RCU_FORCE_SYS_MEMBARRIER], [1])])
+
 # Allow overriding storage used for TLS variables.
 AC_ARG_ENABLE([compiler-tls],
 	AS_HELP_STRING([--disable-compiler-tls], [Use pthread_getspecific() to emulate Thread Local Storage (TLS) variables.]),
diff --git a/include/urcu/map/urcu.h b/include/urcu/map/urcu.h
index 9a4bb1a..449513e 100644
--- a/include/urcu/map/urcu.h
+++ b/include/urcu/map/urcu.h
@@ -80,9 +80,6 @@
 
 #define rcu_flavor			rcu_flavor_memb
 
-/* Specific to MEMBARRIER flavor */
-#define rcu_has_sys_membarrier		rcu_has_sys_membarrier_memb
-
 #elif defined(RCU_SIGNAL)
 
 #define rcu_read_lock			rcu_read_lock_sig
diff --git a/include/urcu/static/urcu.h b/include/urcu/static/urcu.h
index 7048f99..5fe1ba5 100644
--- a/include/urcu/static/urcu.h
+++ b/include/urcu/static/urcu.h
@@ -89,7 +89,11 @@ enum rcu_state {
  */
 
 #ifdef RCU_MEMBARRIER
+#ifdef RCU_FORCE_SYS_MEMBARRIER
+#define rcu_has_sys_membarrier 1
+#else
 extern int rcu_has_sys_membarrier;
+#endif
 
 static inline void smp_mb_slave(void)
 {
diff --git a/src/urcu.c b/src/urcu.c
index ccd9706..b2ac166 100644
--- a/src/urcu.c
+++ b/src/urcu.c
@@ -77,7 +77,9 @@ enum membarrier_cmd {
 
 #ifdef RCU_MEMBARRIER
 static int init_done;
+#ifndef RCU_FORCE_SYS_MEMBARRIER
 int rcu_has_sys_membarrier;
+#endif
 
 void __attribute__((constructor)) rcu_init(void);
 #endif
@@ -541,7 +543,12 @@ void rcu_init(void)
 	init_done = 1;
 	ret = membarrier(MEMBARRIER_CMD_QUERY, 0);
 	if (ret >= 0 && (ret & MEMBARRIER_CMD_SHARED)) {
+#ifndef RCU_FORCE_SYS_MEMBARRIER
 		rcu_has_sys_membarrier = 1;
+#else
+       } else {
+               abort();
+#endif
 	}
 }
 #endif

--------------2612C4CA9E2856B3142FFEED
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--------------2612C4CA9E2856B3142FFEED--
