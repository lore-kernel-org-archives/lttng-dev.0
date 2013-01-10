From: David Goulet <dgoulet@efficios.com>
Subject: [PATCH lttng-tools] Fix: update next_net_seq_num after
	sending header
Date: Thu, 10 Jan 2013 12:24:53 -0500
Message-ID: <1357838693-22011-1-git-send-email-dgoulet__16468.9793986783$1357838748$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1TtLsK-0006IK-8Y
	for lttng-dev@lists.lttng.org; Thu, 10 Jan 2013 12:25:08 -0500
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

Increment the sequence number after we are sure that the relayd has
received correctly the data header. If an error occurs when sending the
header, the data won't be extracted from the buffers thus keeping this
sequence number untouched.

Furthermore, after sending the header, if the relayd dies, this value
won't matter much and if there is an error on the stream when reading
the trace data, the stream will be deleted thus closed on the relayd
making this value useless.

It's important to note that this sequence number is updated on the
relayd side if the full expected data packet was received. So,
incrementing the value after the transmission of the header is not
changing anything in terms of value coherency. The point is to have a
semantic of when read and used successfully (transmission to relayd),
let's update it.

In that code flow, the stream's lock is acquired so no need to
read/update it atomically. I've also added a comments to better
understand the purpose of this variable and how to use it.

Signed-off-by: David Goulet <dgoulet@efficios.com>
---
 src/common/consumer.c |    4 +++-
 src/common/consumer.h |   14 +++++++++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/src/common/consumer.c b/src/common/consumer.c
index 935a03d..15fc9b0 100644
--- a/src/common/consumer.c
+++ b/src/common/consumer.c
@@ -755,7 +755,7 @@ static int write_relayd_stream_header(struct lttng_consumer_stream *stream,
 		 * this next value, 1 should always be substracted in order to compare
 		 * the last seen sequence number on the relayd side to the last sent.
 		 */
-		data_hdr.net_seq_num = htobe64(stream->next_net_seq_num++);
+		data_hdr.net_seq_num = htobe64(stream->next_net_seq_num);
 		/* Other fields are zeroed previously */
 
 		ret = relayd_send_data_hdr(&relayd->data_sock, &data_hdr,
@@ -764,6 +764,8 @@ static int write_relayd_stream_header(struct lttng_consumer_stream *stream,
 			goto error;
 		}
 
+		++stream->next_net_seq_num;
+
 		/* Set to go on data socket */
 		outfd = relayd->data_sock.fd;
 	}
diff --git a/src/common/consumer.h b/src/common/consumer.h
index 193533e..8305146 100644
--- a/src/common/consumer.h
+++ b/src/common/consumer.h
@@ -129,7 +129,19 @@ struct lttng_consumer_stream {
 	unsigned int metadata_flag;
 	/* Used when the stream is set for network streaming */
 	uint64_t relayd_stream_id;
-	/* Next sequence number to use for trace packet */
+	/*
+	 * When sending a stream packet to a relayd, this number is used to track
+	 * the packet sent by the consumer and seen by the relayd. When sending the
+	 * data header to the relayd, this number is sent and if the transmission
+	 * was successful, it is incremented.
+	 *
+	 * Even if the full data is not fully transmitted it won't matter since
+	 * only two possible error can happen after that where either the relayd
+	 * died or a read error is detected on the stream making this value useless
+	 * after that.
+	 *
+	 * This value SHOULD be read/updated atomically or with the lock acquired.
+	 */
 	uint64_t next_net_seq_num;
 	/*
 	 * Lock to use the stream FDs since they are used between threads.
-- 
1.7.10.4
