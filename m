From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools] Build: bump autoconf version
	requirement to 2.64
Date: Thu,  2 Jul 2015 18:55:32 -0400
Message-ID: <1435877732-29499-1-git-send-email-jonathan.rajotte-julien__40036.05138646$1435877811$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1ZAnOf-0006pE-Pv
 for lttng-dev@lists.lttng.org; Thu, 02 Jul 2015 18:56:01 -0400
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

AC_INIT with package_url was introduced in AC 2.64

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 README.md    | 2 +-
 configure.ac | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/README.md b/README.md
index 2cb75b1..8c412cd 100644
--- a/README.md
+++ b/README.md
@@ -59,7 +59,7 @@ This source tree is based on the Autotools suite from GNU to simplify
 portability. Here are some things you should have on your system in
 order to compile the Git repository tree:
 
-  - GNU Autotools (Automake >= 1.10, Autoconf >= 2.50,
+  - GNU Autotools (Automake >= 1.10, Autoconf >= 2.64,
     Autoheader >= 2.50; make sure your system-wide `automake` points to
     a recent version!)
   - [GNU Libtool](http://www.gnu.org/software/autoconf/) >= 2.2
diff --git a/configure.ac b/configure.ac
index 48c3cb3..1fcac72 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1,3 +1,4 @@
+AC_PREREQ([2.64])
 AC_INIT([lttng-tools],[2.7.0-pre],[jeremie.galarneau@efficios.com],[],[https://lttng.org])
 AC_CONFIG_AUX_DIR([config])
 AC_CANONICAL_TARGET
-- 
2.1.4
