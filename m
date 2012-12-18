From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH 2/5] run-report: Restore SIGPIPE default handler
	in subprocess calls
Date: Tue, 18 Dec 2012 16:31:15 -0500
Message-ID: <1355866278-11702-2-git-send-email-christian.babeux__3014.45455193079$1355866344$gmane$org@efficios.com>
References: <1355866278-11702-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1Tl4lQ-0005JG-An
	for lttng-dev@lists.lttng.org; Tue, 18 Dec 2012 16:31:48 -0500
Received: by mail-ie0-f173.google.com with SMTP id e13so1698089iej.18
	for <lttng-dev@lists.lttng.org>; Tue, 18 Dec 2012 13:31:43 -0800 (PST)
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

Python override the SIGPIPE default handler because it prefers to check
every write and raise an IOError exception rather than taking SIGPIPE [1].

This behavior has the unfortunate side-effect of polluting stdout with
broken pipe messages on shell pipelines invocations (e.g. echo foo |
grep something | etc.) in shell scripts spawned via subprocess.Popen().

This commit fix the polluting of stdout by restoring the default SIGPIPE
handler on subprocess calls.

[1] - http://bugs.python.org/issue1652

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 tests/run-report.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/run-report.py b/tests/run-report.py
index ca6e6a3..6f559c9 100755
--- a/tests/run-report.py
+++ b/tests/run-report.py
@@ -7,7 +7,7 @@ import Queue
 import time
 import shlex
 
-from signal import signal, SIGTERM, SIGINT
+from signal import signal, SIGTERM, SIGINT, SIGPIPE, SIG_DFL
 
 SESSIOND_BIN_NAME = "lttng-sessiond"
 SESSIOND_BIN_PATH = "src/bin/lttng-sessiond/"
@@ -182,7 +182,7 @@ class TestWorker(threading.Thread):
         env = os.environ
         env['TEST_NO_SESSIOND'] = '1'
 
-        test = subprocess.Popen([bin_path_name], env=env)
+        test = subprocess.Popen([bin_path_name], env=env, preexec_fn = lambda: signal(SIGPIPE, SIG_DFL))
         test.wait()
 
         # Send ret value to main thread
-- 
1.8.0.2
