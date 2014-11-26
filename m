From: Philippe Proulx <eeppeliteloop@gmail.com>
Subject: [lttng-ust] Fix: man: you can't link a lib with a
	static lib
Date: Wed, 26 Nov 2014 16:50:56 -0500
Message-ID: <1417038656-21690-1-git-send-email-eeppeliteloop__49040.6585894108$1417038660$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <eeppeliteloop@gmail.com>) id 1XtkTh-0003Wc-I5
 for lttng-dev@lists.lttng.org; Wed, 26 Nov 2014 16:50:26 -0500
Received: by mail-qa0-f46.google.com with SMTP id u7so2521605qaz.19
 for <lttng-dev@lists.lttng.org>; Wed, 26 Nov 2014 13:50:20 -0800 (PST)
Received: from archeepp.internal.efficios.com ([173.246.22.116])
 by mx.google.com with ESMTPSA id y3sm5001887qae.2.2014.11.26.13.50.18
 for <lttng-dev@lists.lttng.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 26 Nov 2014 13:50:18 -0800 (PST)
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

Fixes: #825

Signed-off-by: Philippe Proulx <eeppeliteloop@gmail.com>
---
 doc/man/lttng-ust.3 | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/doc/man/lttng-ust.3 b/doc/man/lttng-ust.3
index 0c8405f..3d52bc0 100644
--- a/doc/man/lttng-ust.3
+++ b/doc/man/lttng-ust.3
@@ -299,17 +299,13 @@ There are 2 ways to compile the Tracepoint Provider with the
 application: either statically or dynamically. Please follow
 carefully:
 
-  1.1) Compile the Tracepoint provider with the application, either
-       directly or through a static library (.a):
-    - Into exactly one object of your application: define
+  1) Compile the Tracepoint Provider with the application, either
+     directly or through a static library (.a):
+    - Into exactly one object of your application, define
       "TRACEPOINT_DEFINE" and include the tracepoint provider.
     - Use "\-I." for the compilation unit containing the tracepoint
-      provider include (e.g. tp.c).
-    - Link application with "\-ldl".
-    - If building the provider directly into the application,
-      link the application with "\-llttng-ust".
-    - If building a static library for the provider, link the static
-      library with "\-llttng-ust".
+      provider include (e.g., tp.c).
+    - Link the application with "\-llttng-ust" and "\-ldl".
     - Include the tracepoint provider header into all C files using
       the provider.
     - Examples:
-- 
2.1.3
