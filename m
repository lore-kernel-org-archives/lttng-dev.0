From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools] Fix: check validity of a stream
 before invoking ust flush command
Date: Wed, 28 Aug 2019 15:26:03 -0400
Message-ID: <20190828192603.9698-1-jonathan.rajotte-julien__29481.5205664904$1567020392$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 46JbMC6BlMzrYj
 for <lttng-dev@lists.lttng.org>; Wed, 28 Aug 2019 15:26:15 -0400 (EDT)
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
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

At the time ustctl_flush_buffer is called the ustream object might have
already been freed on lttng-ust side.

This can happen following a lttng_consumer_cleanup_relayd and concurrent
consumer flush command (lttng stop).

The train of events goes as follows.

An error on communication with lttng-relayd occurs.
lttng_consumer_cleanup_relayd flags the streams for deletion
(CONSUMER_ENDPOINT_INACTIVE). validate_endpoint_status_data_stream calls
consumer_del_stream.

At the same time the hash table of streams is iterated over in the
flush_channel function following a stop command. The loop is iterating on
a given stream. The current thread is unscheduled before taking the stream
lock.

In the initial thread, the same stream is the current iteration of
cds_lfht_for_each_entry in validate_endpoint_status_data_stream.

consumer_del_stream is called on it. The stream lock is acquired, and
destroy_close_stream is called. lttng_ustconsumer_del_stream is eventually
called and at this point the ustream is freed.

Going back to the iteration in flush_channel. The current stream is still
valid from the point of view of the iteration, ustctl_flush_buffer is then
called on a freed ustream object.

This can lead to unknown behaviour since there is no validation on
lttng-ust side. The underlying memory of the ustream object is garbage at
this point.

To prevent such scenario, we check for the presence of the node in the
hash table via cds_lfht_is_node_deleted. This is valid because the node is
removed from the hash table before deleting the ustream object on
lttng-ust side. The removal from the hash table also requires the stream
lock ensuring the validity of cds_lfht_is_node_deleted return value.

This duplicate similar "validation" check of the stream object. [1][2]

[1] src/common/consumer/consumer.c:consumer_close_channel_streams
[2] src/common/ust-consumer/ust-consumer.c:close_metadata

This issue can be reproduced by the following scenario:

    Modify flush_channel to sleep (i.e 10s) before acquiring the lock on
    a stream.

    Modify lttng-ust ustctl_destroy_stream to set the
    ring_buffer_clock_read callback to NULL.
      Note: An assert on !cds_lfht_is_node_deleted in flush channel
      after acquiring the lock can provide the same information. We are
      modifying the callback to simulate the original backtrace from our
      customer.

    lttng-relayd
    lttng-sessiond
    lttng create --live
    lttng enable-event -u -a
    lttng start
    Start some applications to generate data.
    lttng stop
      The stop command force a flush of the channel/streams.
    pkill -9 lttng-relayd
    Expect assert or segfault

The original customer backtrace:

  0  lib_ring_buffer_try_switch_slow (handle=<optimized out>, tsc=<synthetic pointer>, offsets=0x3fffa9b76c80, chan=0x3fff98006e90, buf=<optimized out>,
     mode=<optimized out>) at /usr/src/debug/lttng-ust/2.9.1/git/libringbuffer/ring_buffer_frontend.c:1834
  1  lib_ring_buffer_switch_slow (buf=0x3fff98016b40, mode=<optimized out>, handle=0x3fff98017670)
     at /usr/src/debug/lttng-ust/2.9.1/git/libringbuffer/ring_buffer_frontend.c:1952
  2  0x00003fffac680940 in ustctl_flush_buffer (stream=<optimized out>, producer_active=<optimized out>)
     at /usr/src/debug/lttng-ust/2.9.1/git/liblttng-ust-ctl/ustctl.c:1568
  3  0x0000000010031bc8 in flush_channel (chan_key=<optimized out>) at ust-consumer.c:772
  4  lttng_ustconsumer_recv_cmd (ctx=<optimized out>, sock=<optimized out>, consumer_sockpoll=<optimized out>) at ust-consumer.c:1651
  5  0x000000001000de50 in lttng_consumer_recv_cmd (ctx=<optimized out>, sock=<optimized out>, consumer_sockpoll=<optimized out>) at consumer.c:2011
  6  0x0000000010014208 in consumer_thread_sessiond_poll (data=0x10079430) at consumer.c:3192
  7  0x00003fffac608b30 in start_thread (arg=0x3fffa9b7bdb0) at pthread_create.c:462
  8  0x00003fffac530d0c in .__clone () at ../sysdeps/unix/sysv/linux/powerpc/powerpc64/clone.S:96

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 src/common/ust-consumer/ust-consumer.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/common/ust-consumer/ust-consumer.c b/src/common/ust-consumer/ust-consumer.c
index 94b761cb8..f2e62d0ee 100644
--- a/src/common/ust-consumer/ust-consumer.c
+++ b/src/common/ust-consumer/ust-consumer.c
@@ -764,10 +764,19 @@ static int flush_channel(uint64_t chan_key)
 		health_code_update();
 
 		pthread_mutex_lock(&stream->lock);
+
+		/*
+		 * Protect against concurrent teardown of a stream.
+		 */
+		if (cds_lfht_is_node_deleted(&stream->node.node)) {
+			goto next;
+		}
+
 		if (!stream->quiescent) {
 			ustctl_flush_buffer(stream->ustream, 0);
 			stream->quiescent = true;
 		}
+next:
 		pthread_mutex_unlock(&stream->lock);
 	}
 error:
-- 
2.17.1
