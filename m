From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH 5/5] run-report: Add tools filtering,
	health check and streaming tests
Date: Tue, 18 Dec 2012 16:31:18 -0500
Message-ID: <1355866278-11702-5-git-send-email-christian.babeux__13060.9567663216$1355866364$gmane$org@efficios.com>
References: <1355866278-11702-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1Tl4lk-0005MD-EF
	for lttng-dev@lists.lttng.org; Tue, 18 Dec 2012 16:32:08 -0500
Received: by mail-ie0-f169.google.com with SMTP id c14so1662608ieb.14
	for <lttng-dev@lists.lttng.org>; Tue, 18 Dec 2012 13:32:03 -0800 (PST)
In-Reply-To: <1355866278-11702-1-git-send-email-christian.babeux@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 tests/test_list.py | 82 ++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 74 insertions(+), 8 deletions(-)
 mode change 100644 => 100755 tests/test_list.py

diff --git a/tests/test_list.py b/tests/test_list.py
old mode 100644
new mode 100755
index cf16094..2a613b9
--- a/tests/test_list.py
+++ b/tests/test_list.py
@@ -31,7 +31,7 @@ Tests = \
     'success': 0, 'enabled': True
     },
 
-    #### KERNEL ####
+    # Kernel tests
     {
     'bin': "kernel/run-kernel-tests.sh", 'daemon': True, 'kern': True,
     'name': "Kernel tracer - lttng client",
@@ -39,7 +39,7 @@ Tests = \
     'success': 0, 'enabled': True
     },
 
-    #### UST ####
+    # UST tests
     {
     'bin': "ust/run-ust-global-tests.sh", 'daemon': True, 'kern': False,
     'name': "UST tracer - Global domain",
@@ -58,13 +58,13 @@ Tests = \
     'desc': "Test multiple large number of events with concurrent application",
     'success': 0, 'enabled': True
     },
-    {
     # Deactivated. This test last 20 minutes...
-    'bin': "ust/low-throughput/run", 'daemon': True, 'kern': False,
-    'name': "UST tracer - Testing high events throughput",
-    'desc': "Test low throughput of events",
-    'success': 0, 'enabled': False
-    },
+    #{
+    #'bin': "ust/low-throughput/run", 'daemon': True, 'kern': False,
+    #'name': "UST tracer - Testing high events throughput",
+    #'desc': "Test low throughput of events",
+    #'success': 0, 'enabled': False
+    #},
     {
     'bin': "ust/before-after/run", 'daemon': True, 'kern': False,
     'name': "UST tracer - Tracing before and after app execution",
@@ -77,4 +77,70 @@ Tests = \
     'desc': "Test tracing with 4 sessions for one application",
     'success': 0, 'enabled': True
     },
+
+    # Tools filtering tests
+    {
+    'bin': "tools/filtering/unsupported-ops", 'daemon': True, 'kern': False,
+    'name': "Filtering - Unsupported operators",
+    'desc': "Test the failure of filter with unsupported operators",
+    'success': 0, 'enabled': True
+    },
+    {
+    'bin': "tools/filtering/invalid-filters", 'daemon': True, 'kern': False,
+    'name': "Filtering - Invalid filters",
+    'desc': "Test the failure of invalid filters",
+    'success': 0, 'enabled': True
+    },
+    {
+    'bin': "tools/filtering/valid-filters", 'daemon': True, 'kern': False,
+    'name': "Filtering - Valid filters",
+    'desc': "Validate the expected trace output of valid filters",
+    'success': 0, 'enabled': True
+    },
+
+    # Tools health check tests
+    {
+    'bin': "tools/health/health_thread_exit", 'daemon': "test", 'kern': True,
+    'name': "Health check - Thread exit",
+    'desc': "Call exit in the various lttng-sessiond threads and ensure that health failure is detected",
+    'success': 0, 'enabled': True
+    },
+    {
+    'bin': "tools/health/health_thread_stall", 'daemon': "test", 'kern': True,
+    'name': "Health check - Thread stall",
+    'desc': "Stall the various lttng-sessiond threads and ensure that health failure is detected",
+    'success': 0, 'enabled': True
+    },
+    {
+    'bin': "tools/health/health_tp_fail", 'daemon': "test", 'kern': True,
+    'name': "Health check - Testpoint failure",
+    'desc': "Trigger a failure in the testpoint mechanism in each thread to provoke thread teardown",
+    'success': 0, 'enabled': True
+    },
+
+    # Tools streaming tests
+    {
+    'bin': "tools/streaming/run-kernel", 'daemon': True, 'kern': True,
+    'name': "Streaming - Kernel tracing",
+    'desc': "Stream a kernel trace across the network",
+    'success': 0, 'enabled': True
+    },
+    {
+    'bin': "tools/streaming/run-ust", 'daemon': True, 'kern': False,
+    'name': "Streaming - Userspace tracing",
+    'desc': "Stream a userspace trace across the network",
+    'success': 0, 'enabled': True
+    },
+    {
+    'bin': "tools/streaming/uri_switch", 'daemon': True, 'kern': False,
+    'name': "Streaming - URI switching",
+    'desc': "Switch URI and verify that the trace result are in the proper location",
+    'success': 0, 'enabled': True
+    },
+    {
+    'bin': "tools/streaming/high_throughput_limits", 'daemon': True, 'kern': True,
+    'name': "Streaming - High throughput with bandwith limits",
+    'desc': "Trace streaming with bandwidth limits",
+    'success': 0, 'enabled': True
+    },
 ]
-- 
1.8.0.2
