From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [LTTNG-TOOLS 2.3 PATCH 1/2] Fix: return code of
	get_subbuff on metadata stream
Date: Mon,  5 Aug 2013 11:27:18 -0400
Message-ID: <1375716439-24407-1-git-send-email-jdesfossez__956.73033870316$1375716511$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1V6Mh3-0004mI-BE
	for lttng-dev@lists.lttng.org; Mon, 05 Aug 2013 11:27:38 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com, mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

On error, the ioctl kernctl_get_next_subbuf returns -1 and sets errno to
a meaningful value but we were ignoring it. It was causing
lttng_kconsumer_read_subbuffer to return -1 (error) instead of -EAGAIN
(normal).

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 src/common/kernel-consumer/kernel-consumer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/common/kernel-consumer/kernel-consumer.c b/src/common/kernel-consumer/kernel-consumer.c
index 3086abe..f8978d2 100644
--- a/src/common/kernel-consumer/kernel-consumer.c
+++ b/src/common/kernel-consumer/kernel-consumer.c
@@ -851,7 +851,7 @@ ssize_t lttng_kconsumer_read_subbuffer(struct lttng_consumer_stream *stream,
 	/* Get the next subbuffer */
 	err = kernctl_get_next_subbuf(infd);
 	if (err != 0) {
-		ret = err;
+		ret = -errno;
 		/*
 		 * This is a debug message even for single-threaded consumer,
 		 * because poll() have more relaxed criterions than get subbuf,
-- 
1.7.10.4
