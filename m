From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: RFC : design notes for remote traces live reading
Date: Sat, 20 Oct 2012 18:54:42 -0400
Message-ID: <20121020225442.GA5020__49626.4265304946$1350773718$gmane$org@Krystal>
References: <50830BA3.6000508@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TPhwL-0002Y2-1L
	for lttng-dev@lists.lttng.org; Sat, 20 Oct 2012 18:54:45 -0400
Content-Disposition: inline
In-Reply-To: <50830BA3.6000508@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Julien Desfossez <jdesfossez@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* Julien Desfossez (jdesfossez@efficios.com) wrote:
> In order to achieve live reading of streamed traces, we need :
> - the index generation while tracing
> - index streaming
> - synchronization of streams
> - cooperating viewers
> 
> This RFC addresses each of these points with the anticipated design,
> implementation is on its way, so quick feedbacks greatly appreciated !
> 
> * Index generation
> The index associates a trace packet with an offset inside the tracefile.
> While tracing, when a packet is ready to be written, we can ask the ring
> buffer to provide us the information required to produce the index
> (data_offset,

Is data_offset just the header size ? Do we really want that in the
on-disk index ? It can be easily computed from the metadata, I'm not
sure we want to duplicate this information.

> packet_size, content_size, timestamp_begin, timestamp_end,
> events_discarded, events_discarded_len,

events_discarded_len is also known from metadata.

> stream_id).

Maybe you could detail the exact layout of an element in the index as a
packed C structure and provide it in the next round of this RFC so we
know exactly which types and what contend you plan.

> 
> * Index streaming
> The index is mandatory for live reading since we use it for the streams
> synchronization. We absolutely need to receive the index, so we send it
> on the control port (TCP-only), but most of the information related to
> the index is only relevant if we receive the associated data packet. So
> the proposed protocol is the following :
> - with each data packet, send the data_offset, packet_size, content_size

what is data_offset ?

> (all uint64_t) along with the already in place information (stream id
> and sequence number)
> - after sending a data packet, the consumer sends on the control port a
> new message (RELAYD_SEND_INDEX) with timestamp_begin, timestamp_end,
> events_discarded, events_discarded_len, stream_id, the sequence number,

do we need events_discarded_len ?

> (all uint64_t), and the relayd stream id of the tracefile
> - when the relay receives a data packet it looks if it already received
> an index corresponding to this stream and sequence number, if yes it
> completes the index structure and writes the index on disk, otherwise it
> creates an index structure in memory with the information it can fill
> and stores it in a hash table waiting for the corresponding index packet
> to arrive
> - the same concept applies when the relay receives an index packet.

Yep. We could possibly describe this as a 2-way merge point between data
and index, performed through lookups (by what key ?) in a hash table.

> 
> This two-part remote index generation allows us to determine if we lost
> packets because of the network, limit the number of bytes sent on the
> control port and make sure we still have an index for each packet with
> its timestamps and the number of events lost so the viewer knows if we
> lost events because of the tracer or the network.
> 
> Design question : since the lookup is always based on two factors
> (relayd stream_id and sequence number), do we want to create a hash
> table for each stream on the relay ?

Nope. A single hash table can be used. The hash function takes both
stream ID and seq num (e.g. with a xor), and the compare function
compares with both.

> We have to consider that at some point, we might have to reorder trace
> packets (when we support UDP) before writing them to disk, so we will
> need a similar structure to temporarily store out-of-order packets.

I don't think it will be necessary for UDP: UDP datagrams, AFAIK, arrive
ordered at the receiver application, even if they are made of many
actual IP packets. Basically, we can simply send each entire trace
packet as one single UDP datagram.

> Also the hash table storing the indexes needs an expiration mechanism
> (based on timing or number of packets).

Upon addition into the hash table, we could use a separate data
structure to keep track of expiration timers. When an entry is removed
from the hash table, we remove its associated timer entry. It does not
need to sit in the same data structure. Maybe a linked list, or maybe a
red black tree, would be more appropriate to keep track of these
expiration times. A periodical timer could perform the discard of
packets when they reach their timeout.

> 
> * Synchronization of streams
> Already discussed in an earlier RFC, summary :
> - at a predefined rate, the consumer sends a synchronization packet that
> contains the last sequence number that can be safely read by the viewer
> for each stream of the session, it happens as soon as possible when all
> streams are generating data, and also time-based to cover the case with
> streams not generating any data.

Note: if the consumer has not sent any data whatsoever (on any stream)
since the last synchronization beacon, it can skip sending the next
beacon. This is a nice power consumption optimisation.

> - the relay receives this packet, ensures all data packets and indexes
> are commited on disk (and sync'ed) and updates the synchronization with
> the viewers (discussed just below)
> 
> * Cooperating viewers
> The viewers need to be aware that they are reading streamed data and
> play nicely with the synchronization algorithms in place. The proposed
> approach is using fcntl(2) "Advisory locking" to lock specific portions
> of the tracefiles. The viewers will have to test and make sure they are
> respecting the locks when they are switching packets.
> So in summary :
> - when the relay is ready to let the viewers access the data, it adds a
> new write lock on the region that cannot be safely read and removes the
> previous one
> - when a viewer needs to switch packet, it tests for the presence of a
> lock on the region of the file it needs to access, if there is no lock
> it can safely read the data, otherwise it blocks until the lock is removed.
> - when a data packet is lost on the network, an index is written, but
> the offset in the tracefile is set to an invalid value (-1) so the
> reader knows the data was lost in transit.
> - the viewers need also to be adapted to read on-disk indexes, support
> metadata updates, respect the locking.

How do you expect to deal with streams coming during tracing ? How is
the viewer expected to be told a new stream needs to be read, and how
is the file creation / advisory locking vs file open (read) / advisory
locking expected to be handled ?

> 
> Not addressed here but mandatory : the metadata must be completely
> streamed before streaming trace data that correspond to this new metadata.

Yes. We might want to think a little more about what happens when we
stream partially complete metadata that cuts it somewhere where it
cannot be parsed.. ?

Thanks!

Mathieu

> 
> Feedbacks, questions and improvement ideas welcome !
> 
> Thanks,
> 
> Julien

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
