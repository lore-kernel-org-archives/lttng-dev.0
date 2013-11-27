From: Charles Briere <charlesbriere.flatzo@gmail.com>
Subject: [PATCH liburcu 2/5] Dont link pthread on Android
Date: Tue, 26 Nov 2013 21:08:19 -0800
Message-ID: <1385528902-4797-2-git-send-email-charlesbriere.flatzo__33266.1940869459$1385529030$gmane$org@gmail.com>
References: <1385528902-4797-1-git-send-email-charlesbriere.flatzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <charlesbriere.flatzo@gmail.com>) id 1VlXNb-0002Me-Aj
	for lttng-dev@lists.lttng.org; Wed, 27 Nov 2013 00:09:41 -0500
Received: by mail-pb0-f51.google.com with SMTP id up15so9567160pbc.38
	for <lttng-dev@lists.lttng.org>; Tue, 26 Nov 2013 21:09:33 -0800 (PST)
In-Reply-To: <1385528902-4797-1-git-send-email-charlesbriere.flatzo@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com
Cc: Charles Briere <charlesbriere.flatzo@gmail.com>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On Android, pthread is already part of libc
called Bionic and doesn't have an external
library to link with.

Signed-off-by: Charles Briere <charlesbriere.flatzo@gmail.com>
---
 Makefile.am                  | 5 ++++-
 tests/benchmark/Makefile.am  | 4 +++-
 tests/regression/Makefile.am | 4 +++-
 tests/unit/Makefile.am       | 4 +++-
 4 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index e09778f..baac8b9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -4,7 +4,10 @@ INCLUDES = -I$(top_builddir)/urcu
 
 #Add the -version-info directly here since we are only building
 # library that use the version-info
-AM_LDFLAGS=-lpthread -version-info $(URCU_LIBRARY_VERSION)
+AM_LDFLAGS=-version-info $(URCU_LIBRARY_VERSION)
+if !TARGET_IS_ANDROID
+AM_LDFLAGS += -lpthread
+endif
 AM_CFLAGS=-Wall
 
 SUBDIRS = . doc tests
diff --git a/tests/benchmark/Makefile.am b/tests/benchmark/Makefile.am
index e071034..91ba1da 100644
--- a/tests/benchmark/Makefile.am
+++ b/tests/benchmark/Makefile.am
@@ -1,4 +1,6 @@
-AM_LDFLAGS=-lpthread
+if !TARGET_IS_ANDROID
+AM_LDFLAGS += -lpthread
+endif
 AM_CFLAGS=-I$(top_srcdir) -I$(top_builddir) -I$(top_srcdir)/tests/common -g
 
 noinst_PROGRAMS = test_urcu test_urcu_dynamic_link test_urcu_timing \
diff --git a/tests/regression/Makefile.am b/tests/regression/Makefile.am
index 2c0542f..2cefa33 100644
--- a/tests/regression/Makefile.am
+++ b/tests/regression/Makefile.am
@@ -1,4 +1,6 @@
-AM_LDFLAGS=-lpthread
+if !TARGET_IS_ANDROID
+AM_LDFLAGS += -lpthread
+endif
 AM_CFLAGS=-I$(top_srcdir) -I$(top_builddir) -I$(top_srcdir)/tests/common -g
 
 noinst_PROGRAMS = test_urcu_fork \
diff --git a/tests/unit/Makefile.am b/tests/unit/Makefile.am
index 1fa8b71..85860e2 100644
--- a/tests/unit/Makefile.am
+++ b/tests/unit/Makefile.am
@@ -1,4 +1,6 @@
-AM_LDFLAGS=-lpthread
+if !TARGET_IS_ANDROID
+AM_LDFLAGS += -lpthread
+endif
 AM_CFLAGS=-I$(top_srcdir) -I$(top_builddir) -I$(top_srcdir)/tests/common -g
 
 noinst_PROGRAMS = test_uatomic \
-- 
1.8.4.2
