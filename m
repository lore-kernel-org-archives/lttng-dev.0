From: Julien Desfossez <jdesfossez@efficios.com>
Subject: RFCv2 : design notes for remote traces live reading
Date: Thu, 25 Oct 2012 22:35:12 -0400
Message-ID: <5089F6E0.7000506__3054.9053139568$1351218959$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fukushima.klipix.org ([194.250.102.243])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1TRZlY-0000b5-Vp
	for lttng-dev@lists.lttng.org; Thu, 25 Oct 2012 22:35:21 -0400
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
- cooperating tracers
- the index generation while tracing
- index streaming
- synchronization of streams
- cooperating viewers

This RFC addresses each of these points with the anticipated design,
implementation is on its way, so quick feedbacks greatly appreciated !

* Cooperating tracers
The metadata is mandatory to process any CTF trace. In order to achieve
live trace reading, the metadata must be available to the viewer when it
starts reading the trace.
For now, the considered approach is to flush periodically the metadata
stream to make sure it is sent.
This topic needs more discussions.
We need to find a way to make sure that the viewer cannot start reading
data for which it does not have the metadata.

* Index generation
The index associates a trace packet with an offset inside the tracefile.
While tracing, when a packet is ready to be written, we can ask the ring
buffer to provide the information required to produce the index. For the
viewers, the structure describing an index entry is the following :

struct packet_index {
  off_t offset; /* offset of the packet in the file, in bytes */
  int64_t data_offset; /* offset of data within the packet, in bits */
  uint64_t packet_size; /* packet size, in bits */
  uint64_t content_size; /* content size, in bits */
  uint64_t timestamp_begin;
  uint64_t timestamp_end;
  uint64_t events_discarded;
  uint64_t events_discarded_len;/* length of the field, in bits */
  uint64_t stream_id;
};

The offset field is known when writing the trace file on disk.
The fields data_offset and events_discarded_len can be computed from the
metadata so we don't need to extract these 3 fields from the ring buffer.

So the structure we need to extract from the tracer and write is the
following :
struct packet_index {
  uint64_t packet_size; /* packet size, in bits */
  uint64_t content_size; /* content size, in bits */
  uint64_t timestamp_begin;
  uint64_t timestamp_end;
  uint64_t events_discarded;
  uint64_t stream_id;
};

* Index streaming
The index is mandatory for live reading since we use it for the streams
synchronization. We absolutely need to receive the index, so we send it
on the control port (TCP-only), but most of the information related to
the index is only relevant if we receive the associated data packet. So
the proposed protocol is the following :
- with each data packet, send the packet_size and content_size along
with the already in place information (stream id and sequence number)
- after sending a data packet, the consumer sends on the control port a
new message (RELAYD_SEND_INDEX) with timestamp_begin, timestamp_end,
events_discarded, stream_id, the sequence number, and the relayd stream
id of the tracefile
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
its timestamps and the number of lost events so the viewer knows if we
lost events because of the tracer or the network.

In the relay we will introduce a hash table to help the lookups. The
hash function will perform a XOR on the stream_id and sequence_number
and the compare function will compare the two to avoid collisions.

Also the hash table storing the indexes needs an expiration mechanism
(based on timing or number of packets).
Since some data may never arrive (lost UDP packets), we will add a
separate data structure to store the timeout associated with each index
entry. A timer will make sure to remove the expired entries.

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
- if a consumer does not send any data on any stream the synchronization
message is not necessary (since there is no data to display) so it won't
be sent

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
- when a new stream is created (cpu-hotplug or new application started),
a new trace file is created on disk. The relay creates and immediately
locks the file. The relay has the responsibility to not write data older
than the oldest event in the other streams already available to the
viewer (unlocked).
- The viewer has the responsibility to detect new tracefiles (by using a
notifications mechanism for example)
- the viewers need also to be adapted to read on-disk indexes, support
metadata updates, respect the locking.

Feedbacks, questions and improvement ideas welcome !

Thanks,

Julien
