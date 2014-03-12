From: Zifei Tong <zifeitong@gmail.com>
Subject: [PATCH] Define tracepoint callback only if
	TRACEPOINT_DEFINE defined
Date: Wed, 12 Mar 2014 17:40:37 +0800
Message-ID: <1394617237-30807-1-git-send-email-zifeitong__24109.1314856478$1394617302$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <zifeitong@gmail.com>) id 1WNfeo-0005Sp-Ml
	for lttng-dev@lists.lttng.org; Wed, 12 Mar 2014 05:41:03 -0400
Received: by mail-pd0-f179.google.com with SMTP id w10so837406pde.10
	for <lttng-dev@lists.lttng.org>; Wed, 12 Mar 2014 02:40:56 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Compiling tracepoint providers in clang will result in 'Wunused-function'
warning, since tracepoint callbacks are defined but never called.

lttng-gen-tp is also updated to not put TRACEPOINT_DEFINE in generated
headers.

Fixes #760

Signed-off-by: Zifei Tong <zifeitong@gmail.com>
---
 doc/examples/gen-tp/sample.c |  1 +
 include/lttng/tracepoint.h   | 13 ++++++++++---
 tools/lttng-gen-tp           |  1 -
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/doc/examples/gen-tp/sample.c b/doc/examples/gen-tp/sample.c
index dab6e7d..ae22f28 100644
--- a/doc/examples/gen-tp/sample.c
+++ b/doc/examples/gen-tp/sample.c
@@ -23,6 +23,7 @@
 
 #include <unistd.h>
 
+#define TRACEPOINT_DEFINE
 #include "sample_tracepoint.h"
 int main(int argc, char **argv)
 {
diff --git a/include/lttng/tracepoint.h b/include/lttng/tracepoint.h
index 66e2abd..462a0fc 100644
--- a/include/lttng/tracepoint.h
+++ b/include/lttng/tracepoint.h
@@ -150,8 +150,8 @@ extern "C" {
  * between caller's ip addresses within the probe using the return
  * address.
  */
-#define _DECLARE_TRACEPOINT(_provider, _name, ...)			 		\
-extern struct tracepoint __tracepoint_##_provider##___##_name;				\
+#if defined(TRACEPOINT_DEFINE)
+#define _DECLARE_TRACEPOINT_CB(_provider, _name, ...)			 		\
 static inline __attribute__((always_inline)) lttng_ust_notrace				\
 void __tracepoint_cb_##_provider##___##_name(_TP_ARGS_PROTO(__VA_ARGS__));		\
 static											\
@@ -174,7 +174,14 @@ void __tracepoint_cb_##_provider##___##_name(_TP_ARGS_PROTO(__VA_ARGS__))		\
 	} while ((++__tp_probe)->func);							\
 end:											\
 	tp_rcu_read_unlock_bp();							\
-}											\
+}
+#else
+#define _DECLARE_TRACEPOINT_CB(_provider, _name, ...)
+#endif
+
+#define _DECLARE_TRACEPOINT(_provider, _name, ...)			 		\
+extern struct tracepoint __tracepoint_##_provider##___##_name;				\
+_DECLARE_TRACEPOINT_CB(_provider, _name, __VA_ARGS__)			 		\
 static inline lttng_ust_notrace								\
 void __tracepoint_register_##_provider##___##_name(char *name,				\
 		void (*func)(void), void *data);					\
diff --git a/tools/lttng-gen-tp b/tools/lttng-gen-tp
index c49e8a5..ff8c22d 100755
--- a/tools/lttng-gen-tp
+++ b/tools/lttng-gen-tp
@@ -69,7 +69,6 @@ class CFile:
 /*
  * The header containing our TRACEPOINT_EVENTs.
  */
-#define TRACEPOINT_DEFINE
 #include "{headerFilename}"
 """
     def __init__(self, filename, template):
-- 
1.9.0
