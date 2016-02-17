From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools] Fix: test: handle env variables
	undefined
Date: Wed, 17 Feb 2016 16:33:00 -0500
Message-ID: <1455744780-2527-1-git-send-email-jonathan.rajotte-julien__21935.2879481905$1455744886$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1aW9ix-0007wa-PR
 for lttng-dev@lists.lttng.org; Wed, 17 Feb 2016 16:33:33 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Prevent errors on non-existent key fetching e.g LD_PRELOAD & LD_LIBRARY_PATH.
Uses .get() with a default empty string to prevent this case.

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 tests/regression/ust/ust-dl/test_ust-dl.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/regression/ust/ust-dl/test_ust-dl.py b/tests/regression/ust/ust-dl/test_ust-dl.py
index 7117ca1..9801012 100644
--- a/tests/regression/ust/ust-dl/test_ust-dl.py
+++ b/tests/regression/ust/ust-dl/test_ust-dl.py
@@ -46,8 +46,8 @@ enable_ust_tracepoint_event(session_info, "*")
 start_session(session_info)
 
 test_env = os.environ.copy()
-test_env["LD_PRELOAD"] += ":liblttng-ust-dl.so"
-test_env["LD_LIBRARY_PATH"] += ":" + test_path
+test_env["LD_PRELOAD"] = test_env.get("LD_PRELOAD", "") + ":liblttng-ust-dl.so"
+test_env["LD_LIBRARY_PATH"] = test_env.get("LD_LIBRARY_PATH", "") + ":" + test_path
 test_process = subprocess.Popen(test_path + "prog",
                                 stdout=subprocess.PIPE, stderr=subprocess.PIPE,
                                 env=test_env)
-- 
2.5.0
