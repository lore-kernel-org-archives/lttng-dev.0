From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 3/8] Document test anti-patterns
Date: Wed, 19 Nov 2014 22:40:27 +0100
Message-ID: <1416433232-20080-4-git-send-email-mathieu.desnoyers__9167.662196751$1416433340$gmane$org@efficios.com>
References: <1416433232-20080-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1XrCzb-0002NI-DZ
 for lttng-dev@lists.lttng.org; Wed, 19 Nov 2014 16:40:54 -0500
In-Reply-To: <1416433232-20080-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tests/Makefile.am |  2 +-
 tests/README      | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+), 1 deletion(-)
 create mode 100644 tests/README

diff --git a/tests/Makefile.am b/tests/Makefile.am
index c14e733..2f1f1c3 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -15,7 +15,7 @@ if USE_PYTHON
 endif
 
 dist_noinst_SCRIPTS = run.sh unit_tests fast_regression long_regression root_regression with_bindings_regression
-EXTRA_DIST = run.sh unit_tests fast_regression long_regression root_regression with_bindings_regression
+EXTRA_DIST = run.sh unit_tests fast_regression long_regression root_regression with_bindings_regression README
 
 all-local:
 	@if [ x"$(srcdir)" != x"$(builddir)" ]; then \
diff --git a/tests/README b/tests/README
new file mode 100644
index 0000000..fc8630c
--- /dev/null
+++ b/tests/README
@@ -0,0 +1,63 @@
+* Test Anti-Patterns
+
+OK, there are a few patterns that have been found over and over in the
+testing code base which makes the tests flaky. Here is an incomplete
+list. Don't do that.
+
+1) Using pidof to wait for a background application (by name) to
+   disappear.
+
+   Why is it flaky ?
+
+   The application may be delayed after being forked, but not executed
+   yet. Therefore, pidof will not find it. Use "wait" instead.
+
+2) Using sleep as delay-based optimistic synchronization technique.
+
+   Why is it flaky ?
+
+   Everything that needs to happen before/after other things need to
+   be explicitly synchronized using e.g. a file (used as a flag).
+   Sleep is just an indicator of a minimum arbitrary delay, but
+   machine load and scheduling can actually mess up the real delay
+   between applications. Use explicit synchronization points. Never
+   sleep.
+
+3) Using killall on a background application.
+
+   Why is it flaky ?
+
+   Similarly to pidof, killall may run before the background application
+   executes, thus failing to find it. Store the application PID after it
+   it launched in background into a temporary variable for later use
+   by kill and wait.
+
+4) Using wait ${!} to wait for completion of many background
+   applications.
+
+   Why is it flaky ?
+
+   It just waits for the last application put in background. Use
+   "wait" to wait for all background applications.
+
+5) Forgetting wait at the end (or error return path) of a test phase
+   that has background applications.
+
+   Why is it flaky ?
+
+   Those application may interact with the following testing phases,
+   thus skewing the results.
+
+6) Not grepping into the entire code base for similar patterns.
+
+   When you find a problematic coding pattern, chances are it appears
+   elsewhere in the testing code base. Please fix it everywhere!
+
+7) Introducing a utility abstraction without changing all open coded
+   similar code path.
+
+   When an abstraction for e.g. starting and stopping the session daemon
+   is introduced as a utility (e.g. utils.sh), future changes will
+   assume that all the testing code base is using this abstraction.
+   Leaving a few custom open-coded sites of duplicated code around is a
+   good way to make it a pain to update the abstraction in the future.
-- 
2.1.1
