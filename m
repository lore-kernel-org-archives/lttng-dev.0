From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH urcu 3/3] Add missing fall through annotations
Date: Wed, 12 Dec 2018 15:01:39 -0500
Message-ID: <20181212200139.19046-3-mjeanson__12442.5024762333$1544644829$gmane$org@efficios.com>
References: <20181212200139.19046-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 43FSPw48x1z175Z
 for <lttng-dev@lists.lttng.org>; Wed, 12 Dec 2018 15:01:56 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 8DC07A343F
 for <lttng-dev@lists.lttng.org>; Wed, 12 Dec 2018 15:01:56 -0500 (EST)
In-Reply-To: <20181212200139.19046-1-mjeanson@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org, mathieu.desnoyers@efficios.com
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 tests/benchmark/test_urcu_hash.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/benchmark/test_urcu_hash.h b/tests/benchmark/test_urcu_hash.h
index 023ae1c..5e84aef 100644
--- a/tests/benchmark/test_urcu_hash.h
+++ b/tests/benchmark/test_urcu_hash.h
@@ -249,10 +249,11 @@ uint32_t hash_u32(
 
 	/*----------------------------------- handle the last 3 uint32_t's */
 	switch (length) {	/* all the case statements fall through */
-	case 3: c += k[2];
-	case 2: b += k[1];
+	case 3: c += k[2]; /* fall through */
+	case 2: b += k[1]; /* fall through */
 	case 1: a += k[0];
 		final(a, b, c);
+		/* fall through */
 	case 0:			/* case 0: nothing left to add */
 		break;
 	}
-- 
2.17.1
