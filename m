From: Zifei Tong <zifeitong@gmail.com>
Subject: [PATCH lttng-ust] Add 'unused' attribute to tracepoint
	callback
Date: Fri, 14 Mar 2014 21:23:21 +0800
Message-ID: <1394803401-32171-1-git-send-email-zifeitong__40858.3020595417$1394803611$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <zifeitong@gmail.com>) id 1WOS6M-0006ln-7G
	for lttng-dev@lists.lttng.org; Fri, 14 Mar 2014 09:24:47 -0400
Received: by mail-pd0-f176.google.com with SMTP id r10so2531134pdi.21
	for <lttng-dev@lists.lttng.org>; Fri, 14 Mar 2014 06:24:36 -0700 (PDT)
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

Compiling tracepoint provider with clang generates 'Wunused-function'
warnings. Add 'unused' attribute to silence these warnings.

Fixes #760

Signed-off-by: Zifei Tong <zifeitong@gmail.com>
---
 include/lttng/tracepoint.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/lttng/tracepoint.h b/include/lttng/tracepoint.h
index 66e2abd..c5a09d8 100644
--- a/include/lttng/tracepoint.h
+++ b/include/lttng/tracepoint.h
@@ -152,7 +152,7 @@ extern "C" {
  */
 #define _DECLARE_TRACEPOINT(_provider, _name, ...)			 		\
 extern struct tracepoint __tracepoint_##_provider##___##_name;				\
-static inline __attribute__((always_inline)) lttng_ust_notrace				\
+static inline __attribute__((always_inline, unused)) lttng_ust_notrace			\
 void __tracepoint_cb_##_provider##___##_name(_TP_ARGS_PROTO(__VA_ARGS__));		\
 static											\
 void __tracepoint_cb_##_provider##___##_name(_TP_ARGS_PROTO(__VA_ARGS__))		\
-- 
1.9.0
