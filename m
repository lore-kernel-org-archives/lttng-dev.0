From: Gabriel-Andrew Pollo-Guilbert <gabriel.pollo-guilbert@efficios.com>
Subject: [PATCH lttng-ust] Fix: remove uninitialised value
Date: Mon, 29 Jul 2019 11:14:26 -0400
Message-ID: <20190729151426.15105-1-gabriel.pollo-guilbert__15913.4744362504$1564413345$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 45y3Cg27Spz18Y0
 for <lttng-dev@lists.lttng.org>; Mon, 29 Jul 2019 11:15:27 -0400 (EDT)
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

Commit 973eac638e4fd introduces an uninitialised value that may prevent
shared memory from being allocated. The compiler didn't give any warning
because the pointer to the value is sent to a function that don't do anything
with it. We simply pass NULL to that function.
---
 liblttng-ust/lttng-ust-comm.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/liblttng-ust/lttng-ust-comm.c b/liblttng-ust/lttng-ust-comm.c
index 4bc350e2..a299ba84 100644
--- a/liblttng-ust/lttng-ust-comm.c
+++ b/liblttng-ust/lttng-ust-comm.c
@@ -875,17 +875,14 @@ int handle_message(struct sock_info *sock_info,
 	}
 	case LTTNG_UST_STREAM:
 	{
-		uint64_t memory_map_size;
-
 		/* Receive shm_fd, wakeup_fd */
 		ret = ustcomm_recv_stream_from_sessiond(sock,
-			&memory_map_size,
+			NULL,
 			&args.stream.shm_fd,
 			&args.stream.wakeup_fd);
 		if (ret) {
 			goto error;
 		}
-		lum->u.stream.len = memory_map_size;
 
 		if (ops->cmd)
 			ret = ops->cmd(lum->handle, lum->cmd,
-- 
2.22.0
