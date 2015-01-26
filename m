From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-ust 1/2] Fix: make dist: python agent file
	handling
Date: Mon, 26 Jan 2015 11:50:30 -0500
Message-ID: <1422291031-28246-1-git-send-email-jonathan.rajotte-julien__6819.50498042188$1422291091$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1YFmsH-0005SU-Eq
 for lttng-dev@lists.lttng.org; Mon, 26 Jan 2015 11:50:54 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 84CE23401C5
 for <lttng-dev@lists.lttng.org>; Mon, 26 Jan 2015 16:50:54 +0000 (UTC)
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

Fresh make dist tried to package a build time file:lttng_agent.py
and make dist tried to package a non-existent file.

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 liblttng-ust-python-agent/Makefile.am | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/liblttng-ust-python-agent/Makefile.am b/liblttng-ust-python-agent/Makefile.am
index 7b51447..5d5b6ab 100644
--- a/liblttng-ust-python-agent/Makefile.am
+++ b/liblttng-ust-python-agent/Makefile.am
@@ -2,9 +2,9 @@
 AM_CPPFLAGS = $(PYTHON_INCLUDE) -I$(top_srcdir)/include/
 AM_CFLAGS = -fno-strict-aliasing
 
-EXTRA_DIST = lttng-agent.py.in
+EXTRA_DIST = lttng_agent.py.in
 
-lttng_agent_PYTHON = lttng_agent.py
+nodist_lttng_agent_PYTHON = lttng_agent.py
 lttng_agentdir = $(pythondir)
 
 lib_LTLIBRARIES = liblttng-ust-python-agent.la
-- 
1.9.1
