From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-ust] Doc: basic lttng ust python agent
	documentation
Date: Mon, 10 Aug 2015 14:45:32 -0400
Message-ID: <1439232334-31308-3-git-send-email-jonathan.rajotte-julien__41395.5773380168$1439232550$gmane$org@efficios.com>
References: <1439232334-31308-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1ZOs6s-0001Ts-J0
 for lttng-dev@lists.lttng.org; Mon, 10 Aug 2015 14:47:48 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 4F47734053E
 for <lttng-dev@lists.lttng.org>; Mon, 10 Aug 2015 18:47:41 +0000 (UTC)
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

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 doc/python-agent.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 doc/python-agent.txt

diff --git a/doc/python-agent.txt b/doc/python-agent.txt
new file mode 100644
index 0000000..61ae4d0
--- /dev/null
+++ b/doc/python-agent.txt
@@ -0,0 +1,13 @@
+======================
+ Using the python agent
+======================
+
+To build the agent:
+
+$ ./configure --enable-python-agent
+
+The configure script is set to look for the first python version >= 2.7.
+To build the agent against another version of python:
+
+$ export PYTHON=<python path>
+$ ./configure --enable-python-agent
-- 
2.1.4
