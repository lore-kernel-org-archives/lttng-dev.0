From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools 1/2] Fix: Off by one in
	lttcomm_sock_domain enum
Date: Fri, 10 Aug 2012 13:22:51 -0400
Message-ID: <1344619372-21976-2-git-send-email-christian.babeux__23766.3425891244$1344619433$gmane$org@efficios.com>
References: <1344619372-21976-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-gg0-f176.google.com ([209.85.161.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1Szsvn-0006ij-Eg
	for lttng-dev@lists.lttng.org; Fri, 10 Aug 2012 13:23:27 -0400
Received: by ggke5 with SMTP id e5so862991ggk.35
	for <lttng-dev@lists.lttng.org>; Fri, 10 Aug 2012 10:23:20 -0700 (PDT)
In-Reply-To: <1344619372-21976-1-git-send-email-christian.babeux@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

     The wrong value is used to lookup the socket creation
     function in net_families causing a segfault when using IPv6.

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 src/common/sessiond-comm/sessiond-comm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/common/sessiond-comm/sessiond-comm.h b/src/common/sessiond-comm/sessiond-comm.h
index aebe30c..8d1400c 100644
--- a/src/common/sessiond-comm/sessiond-comm.h
+++ b/src/common/sessiond-comm/sessiond-comm.h
@@ -208,8 +208,8 @@ enum lttcomm_sock_proto {
  * Index in the net_families array below. Please keep in sync!
  */
 enum lttcomm_sock_domain {
-	LTTCOMM_INET      = 1,
-	LTTCOMM_INET6     = 2,
+	LTTCOMM_INET      = 0,
+	LTTCOMM_INET6     = 1,
 };
 
 struct lttcomm_sockaddr {
-- 
1.7.11.4
