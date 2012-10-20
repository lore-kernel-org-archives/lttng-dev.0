From: Julien Desfossez <jdesfossez@efficios.com>
Subject: RFC : design notes for remote traces live reading
Date: Sat, 20 Oct 2012 16:37:55 -0400
Message-ID: <50830BA3.6000508__13260.6334788308$1350765522$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fukushima.klipix.org ([194.250.102.243])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1TPfo9-0001aZ-HR
	for lttng-dev@lists.lttng.org; Sat, 20 Oct 2012 16:38:09 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, David Goulet <dgoulet@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

In order to achieve live reading of streamed traces, we need :
- the index generation while tracing
- index streaming
- synchronization of streams
- cooperating viewers

This RFC addresses each of these points with the anticipated design,
implementation is on its way, so quick feedbacks greatly appreciated !

* Index generation
The index associates a trace packet with an offset inside the tracefile.
While tracing, when a packet is ready to be written, we can ask the ring
buffer to provide us the information required to produce the index
(data_offset, packet_size, content_size, timestamp_begin, timestamp_end,
events_discarded, events_discarded_len, stream_id).

* Index streaming
The index is mandatory for live reading since we use it for the streams
synchronization. We absolutely need to receive the index, so we send it
on the control port (TCP-only), but most of the information related to
the index is only relevant if we receive the associated data packet. So
the proposed protocol is the following :
- with each data packet, send the data_offset, packet_size, content_size
(all uint64_t) along with the already in place information (stream id
and sequence number)
- after sending a data packet, the consumer sends on the control port a
new message (RELAYD_SEND_INDEX) with timestamp_begin, timestamp_end,
events_discarded, events_discarded_len, stream_id, the sequence number,
(all uint64_t), and the relayd stream id of the tracefile
- when the relay receives a data packet it looks if it already received
an index corresponding to this stream and sequence number, if yes it
completes the index structure and writes the index on disk, otherwise it
creates an index structure in memory with the information it can fill
and stores it in a hash table waiting for the corresponding index packet
to arrive
- the same concept applies when the relay receives an index packet.

This two-part remote index generation allows us to determine if we lost
packets because of the network, limit the number of bytes sent on the
control port and make sure we still have an index for each packet with
its timestamps and the number of events lost so the viewer knows if we
lost events because of the tracer or the network.

Design question : since the lookup is always based on two factors
(relayd stream_id and sequence number), do we want to create a hash
table for each stream on the relay ?
We have to consider that at some point, we might have to reorder trace
packets (when we support UDP) before writing them to disk, so we will
need a similar structure to temporarily store out-of-order packets.
Also the hash table storing the indexes needs an expiration mechanism
(based on timing or number of packets).

* Synchronization of streams
Already discussed in an earlier RFC, summary :
- at a predefined rate, the consumer sends a synchronization packet that
contains the last sequence number that can be safely read by the viewer
for each stream of the session, it happens as soon as possible when all
streams are generating data, and also time-based to cover the case with
streams not generating any data.
- the relay receives this packet, ensures all data packets and indexes
are commited on disk (and sync'ed) and updates the synchronization with
the viewers (discussed just below)

* Cooperating viewers
The viewers need to be aware that they are reading streamed data and
play nicely with the synchronization algorithms in place. The proposed
approach is using fcntl(2) "Advisory locking" to lock specific portions
of the tracefiles. The viewers will have to test and make sure they are
respecting the locks when they are switching packets.
So in summary :
- when the relay is ready to let the viewers access the data, it adds a
new write lock on the region that cannot be safely read and removes the
previous one
- when a viewer needs to switch packet, it tests for the presence of a
lock on the region of the file it needs to access, if there is no lock
it can safely read the data, otherwise it blocks until the lock is removed.
- when a data packet is lost on the network, an index is written, but
the offset in the tracefile is set to an invalid value (-1) so the
reader knows the data was lost in transit.
- the viewers need also to be adapted to read on-disk indexes, support
metadata updates, respect the locking.

Not addressed here but mandatory : the metadata must be completely
streamed before streaming trace data that correspond to this new metadata.

Feedbacks, questions and improvement ideas welcome !

Thanks,

Julien
