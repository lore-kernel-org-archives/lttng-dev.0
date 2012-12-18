From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH 4/5] run-report: Allow tests to spawn and
	control their own sessiond
Date: Tue, 18 Dec 2012 16:31:17 -0500
Message-ID: <1355866278-11702-4-git-send-email-christian.babeux__16190.0786254138$1355866363$gmane$org@efficios.com>
References: <1355866278-11702-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1Tl4ld-0005LD-QW
	for lttng-dev@lists.lttng.org; Tue, 18 Dec 2012 16:32:01 -0500
Received: by mail-ie0-f181.google.com with SMTP id 16so1646043iea.40
	for <lttng-dev@lists.lttng.org>; Tue, 18 Dec 2012 13:31:56 -0800 (PST)
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

The run-report script can spawn a sessiond if the 'daemon' key value is set
to 'True' in the test description dictionary. If the 'daemon' key is set to
'False', the TEST_NO_SESSIOND environment variable is set so no sessiond can
be spawned in the tests. This variable is also set when the run-report spawn
its own sessiond.

This behavior has the unfortunate side-effect of restricting any kind of
spawning and control of the sessiond via the tests.

Fix this issue by allowing the tests to spawn their own sessiond. We need
to pass an additional env dictionary to the TestWorker in order to spawn
the test with the proper environment variables set.

To indicate that a test will spawn and manage its own sessiond, the 'daemon'
key value should be set to the "test" string.

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 tests/run-report.py | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/tests/run-report.py b/tests/run-report.py
index b0bdb74..d36d938 100755
--- a/tests/run-report.py
+++ b/tests/run-report.py
@@ -173,18 +173,16 @@ class SamplingWorker(threading.Thread):
             mem_ret_q.put((count, mem_stat))
 
 class TestWorker(threading.Thread):
-    def __init__(self, path, name):
+    def __init__(self, path, name, env):
         threading.Thread.__init__(self)
         self.path = path
         self.name = name
+        self.env  = env
 
     def run(self):
         bin_path_name = os.path.join(self.path, self.name)
 
-        env = os.environ
-        env['TEST_NO_SESSIOND'] = '1'
-
-        test = subprocess.Popen([bin_path_name], env=env, preexec_fn = lambda: signal(SIGPIPE, SIG_DFL))
+        test = subprocess.Popen([bin_path_name], env=self.env, preexec_fn = lambda: signal(SIGPIPE, SIG_DFL))
         test.wait()
 
         # Send ret value to main thread
@@ -303,10 +301,23 @@ def run_test(test):
         print "Unable to find test file '%s'. Skipping" % (test['bin'])
         return 0
 
-    # No session daemon needed
-    if not test['daemon']:
+    # Session daemon is controlled by the test
+    if test['daemon'] == "test":
+        print PRINT_ARROW + " Session daemon is controlled by the test"
+        env = os.environ
+        env['TEST_NO_SESSIOND'] = '0'
+        tw = TestWorker(".", test['bin'], env)
+        tw.start()
+        ret = test_ret_q.get(True)
+        print_test_success(ret, test['success'])
+        return 0
+    elif test['daemon'] == False:
         print PRINT_ARROW + " No session daemon needed"
-        ret = start_test(test['bin'])
+        env = os.environ
+        env['TEST_NO_SESSIOND'] = '1'
+        tw = TestWorker(".", test['bin'], env)
+        tw.start()
+        ret = test_ret_q.get(True)
         print_test_success(ret, test['success'])
         return 0
     else:
@@ -327,7 +338,12 @@ def run_test(test):
         cpu_count, cpu_stats = get_cpu_usage(pid = dem_pid)
         print_cpu_stats(cpu_stats, cpu_count)
 
-    tw = TestWorker(".", test['bin'])
+    # Sessiond was already spawned, do not let the test spawn
+    # an additional sessiond
+    env = os.environ
+    env['TEST_NO_SESSIOND'] = '1'
+
+    tw = TestWorker(".", test['bin'], env)
     tw.start()
 
     if not no_stats:
-- 
1.8.0.2
