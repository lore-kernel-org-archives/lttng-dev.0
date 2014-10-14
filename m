From: "Emilio G. Cota" <cota@braap.org>
Subject: [urcu][PATCH] compiler: use __GNUC__ instead of the
	undefined __GNUC_MAJOR__
Date: Mon, 13 Oct 2014 22:31:25 -0400
Message-ID: <1413253885-7154-1-git-send-email-cota__16275.5338162698$1413253959$gmane$org@braap.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from out4-smtp.messagingengine.com ([66.111.4.28])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <cota@braap.org>) id 1Xdru4-0007Mt-VJ
 for lttng-dev@lists.lttng.org; Mon, 13 Oct 2014 22:32:03 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by gateway2.nyi.internal (Postfix) with ESMTP id B618F21043
 for <lttng-dev@lists.lttng.org>; Mon, 13 Oct 2014 22:31:54 -0400 (EDT)
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

gcc defines the major number with __GNUC__, not __GNUC_MAJOR__:
  https://gcc.gnu.org/onlinedocs/cpp/Common-Predefined-Macros.html

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 urcu/compiler.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/urcu/compiler.h b/urcu/compiler.h
index 1e30903..2e0237e 100644
--- a/urcu/compiler.h
+++ b/urcu/compiler.h
@@ -97,8 +97,8 @@
 		(unsigned long) (v))
 
 #if defined (__GNUC__) \
-	&& ((__GNUC_MAJOR__ == 4) && (__GNUC_MINOR__ >= 5)	\
-		|| __GNUC_MAJOR__ >= 5)
+	&& ((__GNUC__ == 4) && (__GNUC_MINOR__ >= 5)	\
+		|| __GNUC__ >= 5)
 #define CDS_DEPRECATED(msg)	\
 	__attribute__((deprecated(msg)))
 #else
-- 
1.8.3
