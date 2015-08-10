From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-ust] Build: use AM_PATH_PYTHON to resolve
	python when building agent
Date: Mon, 10 Aug 2015 14:45:31 -0400
Message-ID: <1439232334-31308-2-git-send-email-jonathan.rajotte-julien__46266.9478184127$1439232529$gmane$org@efficios.com>
References: <1439232334-31308-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1ZOs6m-0001TU-RE
 for lttng-dev@lists.lttng.org; Mon, 10 Aug 2015 14:47:41 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 8987634053D
 for <lttng-dev@lists.lttng.org>; Mon, 10 Aug 2015 18:47:35 +0000 (UTC)
In-Reply-To: <1439232334-31308-1-git-send-email-jonathan.rajotte-julien@efficios.com>
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

The agent can be build against a forced python version by exporting
PYTHON environment variable at configure time.

ex:
$ export PYTHON=python3
$ ./configure --enable-python-agent

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 configure.ac | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configure.ac b/configure.ac
index d2b6bcb..ade4ffe 100644
--- a/configure.ac
+++ b/configure.ac
@@ -319,6 +319,9 @@ AC_ARG_ENABLE([python-agent],
 	[:]
 )
 AM_CONDITIONAL([BUILD_PYTHON_AGENT], [test "x$python_agent" = "xyes"])
+if test "x$python_agent" = "xyes"; then
+	AM_PATH_PYTHON([2.7])
+fi
 
 # sdt.h integration
 AC_ARG_WITH([sdt],
-- 
2.1.4
