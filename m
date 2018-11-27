From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-tools] Add *.exe to gitignore for Cygwin
Date: Tue, 27 Nov 2018 14:24:27 -0500
Message-ID: <20181127192427.8337-1-mjeanson__21726.3355655179$1543346580$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 434DHh66zzzwSH
 for <lttng-dev@lists.lttng.org>; Tue, 27 Nov 2018 14:24:32 -0500 (EST)
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
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index c25fb700..19276012 100644
--- a/.gitignore
+++ b/.gitignore
@@ -18,6 +18,7 @@ Makefile.in
 *.class
 *.trs
 *.log
+*.exe
 .dirstamp
 configure
 aclocal.m4
-- 
2.17.1
