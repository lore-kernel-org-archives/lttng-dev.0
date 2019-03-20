From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-ust] Report perf integration status at
 configure
Date: Wed, 20 Mar 2019 17:02:25 -0400
Message-ID: <20190320210225.19141-1-mjeanson__14880.1687218779$1553115776$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44Pj6l32hGz180J
 for <lttng-dev@lists.lttng.org>; Wed, 20 Mar 2019 17:02:38 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 92F461CCDE4
 for <lttng-dev@lists.lttng.org>; Wed, 20 Mar 2019 17:02:37 -0400 (EDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 configure.ac | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configure.ac b/configure.ac
index 9ab76501..3e443132 100644
--- a/configure.ac
+++ b/configure.ac
@@ -615,6 +615,9 @@ PPRINT_PROP_BOOL_CUSTOM([JNI interface (JNI)], $value, [use --enable-jni-interfa
 test "x$python_agent" = xyes && value=1 || value=0
 PPRINT_PROP_BOOL_CUSTOM([Python agent], $value, [use --enable-python-agent])
 
+test "x$have_perf_event" = "xyes" && value=1 || value=0
+PPRINT_PROP_BOOL_CUSTOM([Perf event integration], $value)
+
 test "x$enable_numa" = xyes && value=1 || value=0
 PPRINT_PROP_BOOL([NUMA], $value)
 
-- 
2.17.1
