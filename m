From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH 3/5] run-report: Fix CPU usage stats computation
Date: Tue, 18 Dec 2012 16:31:16 -0500
Message-ID: <1355866278-11702-3-git-send-email-christian.babeux__19617.6866106272$1355866353$gmane$org@efficios.com>
References: <1355866278-11702-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1Tl4lX-0005KR-8c
	for lttng-dev@lists.lttng.org; Tue, 18 Dec 2012 16:31:55 -0500
Received: by mail-ie0-f173.google.com with SMTP id e13so1698272iej.18
	for <lttng-dev@lists.lttng.org>; Tue, 18 Dec 2012 13:31:50 -0800 (PST)
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

The CPU usage statistics are computed by grepping the top command
output. The top output format as since changed so the CPU usage
statistics were not properly computed.

Fix this by adjusting to the new top command output format.

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 tests/run-report.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tests/run-report.py b/tests/run-report.py
index 6f559c9..b0bdb74 100755
--- a/tests/run-report.py
+++ b/tests/run-report.py
@@ -46,10 +46,12 @@ def cpu_create_usage_dict(top_line):
     top_line = top_line.replace(",","")
     words = top_line.split()[1:]
 
-    for word in words:
-        index = word.find('%')
+
+    for key in top_dict:
+        index = words.index(key)
         # Add the value to the dictionnary
-        top_dict[word[index + 1:]] = float(word[:index])
+        val = words[index-1]
+        top_dict[key] = float(val)
 
     return top_dict
 
@@ -87,7 +89,7 @@ def cpu_sample_usage(pid=None):
     # Spawn top process
     top = subprocess.Popen(args, stdout = subprocess.PIPE)
 
-    grep = subprocess.Popen(["grep", "^Cpu"], stdin = top.stdout,
+    grep = subprocess.Popen(["grep", "Cpu"], stdin = top.stdout,
             stdout = subprocess.PIPE)
     top.stdout.close()
 
-- 
1.8.0.2
