From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-modules 2/2] Fix: do not use diagnostic
 pragma when GCC version is lower than 4.6.0
Date: Thu,  4 Jul 2019 16:02:13 -0400
Message-ID: <20190704200213.21186-2-jonathan.rajotte-julien__36314.9550439388$1562270588$gmane$org@efficios.com>
References: <20190704200213.21186-1-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 45fpmL1nDNz10ds
 for <lttng-dev@lists.lttng.org>; Thu,  4 Jul 2019 16:02:26 -0400 (EDT)
In-Reply-To: <20190704200213.21186-1-jonathan.rajotte-julien@efficios.com>
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

Officially the diagnostic pragma are supported starting in 4.6. [1]
But they were present before 4.6 with limitation which we cannot
honour easily.

[1] https://gcc.gnu.org/gcc-4.6/changes.html

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 lib/bitfield.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bitfield.h b/lib/bitfield.h
index ebbe754..a9e268b 100644
--- a/lib/bitfield.h
+++ b/lib/bitfield.h
@@ -29,8 +29,10 @@
 /*
  * _bt_is_signed_type() willingly generates comparison of unsigned
  * expression < 0, which is always false. Silence compiler warnings.
+ * GCC versions lower than 4.6.0 do not accept diagnostic pragma inside
+ * functions.
  */
-#ifdef __GNUC__
+#if defined(__GNUC__) && (__GNUC__ * 10000 + __GNUC_MINOR__ * 100 + __GNUC_PATCHLEVEL__) >= 40600
 # define _BT_DIAG_PUSH			_Pragma("GCC diagnostic push")
 # define _BT_DIAG_POP			_Pragma("GCC diagnostic pop")
 
-- 
2.17.1
