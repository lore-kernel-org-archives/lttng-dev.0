From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-ust 1/2] Fix: missing define when not
 building with gcc
Date: Thu,  4 Jul 2019 14:51:36 -0400
Message-ID: <20190704185137.24943-1-jonathan.rajotte-julien__28456.0718968109$1562266339$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 45fnC75R2pz10XL
 for <lttng-dev@lists.lttng.org>; Thu,  4 Jul 2019 14:52:03 -0400 (EDT)
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

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 include/lttng/bitfield.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/lttng/bitfield.h b/include/lttng/bitfield.h
index 7faf23f9..92f1c2c9 100644
--- a/include/lttng/bitfield.h
+++ b/include/lttng/bitfield.h
@@ -59,6 +59,7 @@
 # define _BT_DIAG_PUSH
 # define _BT_DIAG_POP
 # define _BT_DIAG_IGNORE
+# define _BT_DIAG_IGNORE_TYPE_LIMITS
 #endif
 
 #define _bt_is_signed_type(type)	((type) -1 < (type) 0)
-- 
2.17.1
