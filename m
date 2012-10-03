From: David Goulet <dgoulet@efficios.com>
Subject: [PATCH lttng-tools 1/3] Fix: Add missing call rcu and
	read side lock
Date: Wed,  3 Oct 2012 11:48:35 -0400
Message-ID: <1349279317-28056-1-git-send-email-dgoulet__49082.4967543178$1349279418$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1TJRBy-0006YR-QR
	for lttng-dev@lists.lttng.org; Wed, 03 Oct 2012 11:48:58 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: David Goulet <dgoulet@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: David Goulet <dgoulet@efficios.com>
---
 src/common/consumer.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/common/consumer.c b/src/common/consumer.c
index f01eb5d..7c3762e 100644
--- a/src/common/consumer.c
+++ b/src/common/consumer.c
@@ -688,7 +688,9 @@ void consumer_del_channel(struct lttng_consumer_channel *channel)
 		}
 	}
 
+	rcu_read_lock();
 	call_rcu(&channel->node.head, consumer_free_channel);
+	rcu_read_unlock();
 end:
 	pthread_mutex_unlock(&consumer_data.lock);
 }
@@ -1535,7 +1537,7 @@ static void destroy_stream_ht(struct lttng_ht *ht)
 		ret = lttng_ht_del(ht, &iter);
 		assert(!ret);
 
-		free(stream);
+		call_rcu(&stream->node.head, consumer_free_stream);
 	}
 	rcu_read_unlock();
 
@@ -1635,7 +1637,9 @@ static void consumer_del_metadata_stream(struct lttng_consumer_stream *stream)
 		consumer_del_channel(stream->chan);
 	}
 
-	free(stream);
+	rcu_read_lock();
+	call_rcu(&stream->node.head, consumer_free_stream);
+	rcu_read_unlock();
 }
 
 /*
-- 
1.7.10.4
