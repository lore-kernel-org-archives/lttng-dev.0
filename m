From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-ust] fix: document proper liburcu version
 dependency
Date: Mon, 21 Oct 2019 13:04:31 -0400
Message-ID: <20191021170431.9141-1-mjeanson__45367.3870580801$1571677517$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 46xjft1dxLz1QMp
 for <lttng-dev@lists.lttng.org>; Mon, 21 Oct 2019 13:04:37 -0400 (EDT)
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

---
 README.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/README.md b/README.md
index ff491701..fc2cc6c0 100644
--- a/README.md
+++ b/README.md
@@ -11,7 +11,7 @@ user space tracing helpers for any application.
 Prerequisites
 -------------
 
-LTTng-UST depends on [liburcu](http://liburcu.org/) v0.7.2 at build and
+LTTng-UST depends on **[liburcu](http://liburcu.org/) >= 0.11** at build and
 run times. It also optionally depends on libnuma.
 
 
-- 
2.17.1
