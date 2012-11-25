From: Andrew Gabbasov <andrew_gabbasov@mentor.com>
Subject: [PATCH lttng-modules] sock instrumentation: fix fields
	to get referenced values
Date: Sun, 25 Nov 2012 13:41:42 -0600
Message-ID: <1353872502-19968-1-git-send-email-andrew_gabbasov__26972.6435341456$1353872542$gmane$org@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Andrew_Gabbasov@mentor.com>) id 1Tci5P-0005AM-2K
	for lttng-dev@lists.lttng.org; Sun, 25 Nov 2012 14:41:51 -0500
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
	by relay1.mentorg.com with esmtp
	id 1Tci5J-0000EX-J5 from Andrew_Gabbasov@mentor.com
	for lttng-dev@lists.lttng.org; Sun, 25 Nov 2012 11:41:45 -0800
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Due to specific of passing values in lttng-modules, if it is supposed
to display the values, passing a pointer will not be enough,
we need to store the actual values.

Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
---
 instrumentation/events/lttng-module/sock.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/instrumentation/events/lttng-module/sock.h b/instrumentation/events/lttng-module/sock.h
index b0c7411..3e3dbc7 100644
--- a/instrumentation/events/lttng-module/sock.h
+++ b/instrumentation/events/lttng-module/sock.h
@@ -37,7 +37,7 @@ TRACE_EVENT(sock_exceed_buf_limit,
 
 	TP_STRUCT__entry(
 		__string(name, prot->name)
-		__field(long *, sysctl_mem)
+		__array(long, sysctl_mem, 3)
 		__field(long, allocated)
 		__field(int, sysctl_rmem)
 		__field(int, rmem_alloc)
@@ -45,7 +45,7 @@ TRACE_EVENT(sock_exceed_buf_limit,
 
 	TP_fast_assign(
 		tp_strcpy(name, prot->name)
-		tp_assign(sysctl_mem, prot->sysctl_mem)
+		tp_memcpy(sysctl_mem, prot->sysctl_mem, 3 * sizeof(long))
 		tp_assign(allocated, allocated)
 		tp_assign(sysctl_rmem, prot->sysctl_rmem[0])
 		tp_assign(rmem_alloc, atomic_read(&sk->sk_rmem_alloc))
-- 
1.7.10.4
