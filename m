From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: RFC : design notes for remote traces live reading
Date: Mon, 22 Oct 2012 11:38:02 -0400
Message-ID: <20121022153802.GA3432__7713.60003059289$1350920319$gmane$org@Krystal>
References: <50830BA3.6000508@efficios.com> <20121020225442.GA5020@Krystal>
	<5085639D.4030004@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TQK4q-0004Dp-UC
	for lttng-dev@lists.lttng.org; Mon, 22 Oct 2012 11:38:05 -0400
Content-Disposition: inline
In-Reply-To: <5085639D.4030004@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

* David Goulet (dgoulet@efficios.com) wrote:
> Hoy!
> 
> Comments below.
> 
> Mathieu Desnoyers:
> > * Julien Desfossez (jdesfossez@efficios.com) wrote:
> >> In order to achieve live reading of streamed traces, we need :
> >> - the index generation while tracing
> >> - index streaming
> >> - synchronization of streams
> >> - cooperating viewers
> >>
> >> This RFC addresses each of these points with the anticipated design,
> >> implementation is on its way, so quick feedbacks greatly appreciated !
> >>
> >> * Index generation
> >> The index associates a trace packet with an offset inside the tracefile.
> >> While tracing, when a packet is ready to be written, we can ask the ring
> >> buffer to provide us the information required to produce the index
> >> (data_offset,
> > 
> > Is data_offset just the header size ? Do we really want that in the
> > on-disk index ? It can be easily computed from the metadata, I'm not
> > sure we want to duplicate this information.
> > 
> >> packet_size, content_size, timestamp_begin, timestamp_end,
> >> events_discarded, events_discarded_len,
> > 
> > events_discarded_len is also known from metadata.
> > 
> >> stream_id).
> > 
> > Maybe you could detail the exact layout of an element in the index as a
> > packed C structure and provide it in the next round of this RFC so we
> > know exactly which types and what contend you plan.
> 
> I agree with that. Furthermore, part of this information might probably
> end up in the data header which poses problem for backward compatibility
> (relayd 2.2 --> sessiond 2.1 or relayd 2.1 --> sessiond 2.2). This is
> another issue entirely but having the clear memory layout will help a
> lot for future RFCs.
> 
> > 
> >>
> >> * Index streaming
> >> The index is mandatory for live reading since we use it for the streams
> >> synchronization. We absolutely need to receive the index, so we send it
> >> on the control port (TCP-only), but most of the information related to
> >> the index is only relevant if we receive the associated data packet. So
> >> the proposed protocol is the following :
> >> - with each data packet, send the data_offset, packet_size, content_size
> > 
> > what is data_offset ?
> > 
> >> (all uint64_t) along with the already in place information (stream id
> >> and sequence number)
> >> - after sending a data packet, the consumer sends on the control port a
> >> new message (RELAYD_SEND_INDEX) with timestamp_begin, timestamp_end,
> >> events_discarded, events_discarded_len, stream_id, the sequence number,
> > 
> > do we need events_discarded_len ?
> > 
> >> (all uint64_t), and the relayd stream id of the tracefile
> >> - when the relay receives a data packet it looks if it already received
> >> an index corresponding to this stream and sequence number, if yes it
> >> completes the index structure and writes the index on disk, otherwise it
> >> creates an index structure in memory with the information it can fill
> >> and stores it in a hash table waiting for the corresponding index packet
> >> to arrive
> >> - the same concept applies when the relay receives an index packet.
> > 
> > Yep. We could possibly describe this as a 2-way merge point between data
> > and index, performed through lookups (by what key ?) in a hash table.
> > 
> >>
> >> This two-part remote index generation allows us to determine if we lost
> >> packets because of the network, limit the number of bytes sent on the
> >> control port and make sure we still have an index for each packet with
> >> its timestamps and the number of events lost so the viewer knows if we
> >> lost events because of the tracer or the network.
> >>
> >> Design question : since the lookup is always based on two factors
> >> (relayd stream_id and sequence number), do we want to create a hash
> >> table for each stream on the relay ?
> > 
> > Nope. A single hash table can be used. The hash function takes both
> > stream ID and seq num (e.g. with a xor), and the compare function
> > compares with both.
> 
> Hmm... A bit worried about collision here ... since stream ID can be
> equal to a seq num so we have this problem: (stream:seq_num) 4:5 and 5:4.
> 
> Anyhow, the operation using the stream ID and seq num should produce a
> different output for the above case.

A hash function can have seldom collisions, that's fine. We then
disambiguate the collision using the compare function.

> 
> > 
> >> We have to consider that at some point, we might have to reorder trace
> >> packets (when we support UDP) before writing them to disk, so we will
> >> need a similar structure to temporarily store out-of-order packets.
> > 
> > I don't think it will be necessary for UDP: UDP datagrams, AFAIK, arrive
> > ordered at the receiver application, even if they are made of many
> > actual IP packets. Basically, we can simply send each entire trace
> > packet as one single UDP datagram.
> 
> Agreed but can add a bit of complexity on the session daemon side to
> extract subbuffers and cut them in a UDP datagrams especially if the
> buffer size changes (set by the user).
> 
> For instance, the subbuffers size is 256k and UDP datagram is 65k, well
> we will have to truncate the subbufers, queue part of it and probably
> add padding as well.
> 
> We might want to consider both possibilities were we do that based on
> UDP datagrams or what Julien is proposing.

Random question: can we do a sendmsg/recvmsg of 1MB over UDP ? Would the
kernel deliver the 1MB udp packet ?

> 
> > 
> >> Also the hash table storing the indexes needs an expiration mechanism
> >> (based on timing or number of packets).
> > 
> > Upon addition into the hash table, we could use a separate data
> > structure to keep track of expiration timers. When an entry is removed
> > from the hash table, we remove its associated timer entry. It does not
> > need to sit in the same data structure. Maybe a linked list, or maybe a
> > red black tree, would be more appropriate to keep track of these
> > expiration times. A periodical timer could perform the discard of
> > packets when they reach their timeout.
> 
> This means that at each packet received, we'll have to just drop nodes
> from whatever data structure that have expired?

No. Expiration checking can be done with a timer. When we receive
packets, this is yet another trigger that can let us remove stuff from
the expiration queue.

> 
> > 
> >>
> >> * Synchronization of streams
> >> Already discussed in an earlier RFC, summary :
> >> - at a predefined rate, the consumer sends a synchronization packet that
> >> contains the last sequence number that can be safely read by the viewer
> >> for each stream of the session, it happens as soon as possible when all
> >> streams are generating data, and also time-based to cover the case with
> >> streams not generating any data.
> > 
> > Note: if the consumer has not sent any data whatsoever (on any stream)
> > since the last synchronization beacon, it can skip sending the next
> > beacon. This is a nice power consumption optimisation.
> > 
> >> - the relay receives this packet, ensures all data packets and indexes
> >> are commited on disk (and sync'ed) and updates the synchronization with
> >> the viewers (discussed just below)
> >>
> >> * Cooperating viewers
> >> The viewers need to be aware that they are reading streamed data and
> >> play nicely with the synchronization algorithms in place. The proposed
> >> approach is using fcntl(2) "Advisory locking" to lock specific portions
> >> of the tracefiles. The viewers will have to test and make sure they are
> >> respecting the locks when they are switching packets.
> >> So in summary :
> >> - when the relay is ready to let the viewers access the data, it adds a
> >> new write lock on the region that cannot be safely read and removes the
> >> previous one
> >> - when a viewer needs to switch packet, it tests for the presence of a
> >> lock on the region of the file it needs to access, if there is no lock
> >> it can safely read the data, otherwise it blocks until the lock is removed.
> >> - when a data packet is lost on the network, an index is written, but
> >> the offset in the tracefile is set to an invalid value (-1) so the
> >> reader knows the data was lost in transit.
> >> - the viewers need also to be adapted to read on-disk indexes, support
> >> metadata updates, respect the locking.
> > 
> > How do you expect to deal with streams coming during tracing ? How is
> > the viewer expected to be told a new stream needs to be read, and how
> > is the file creation / advisory locking vs file open (read) / advisory
> > locking expected to be handled ?
> > 
> >>
> >> Not addressed here but mandatory : the metadata must be completely
> >> streamed before streaming trace data that correspond to this new metadata.
> > 
> > Yes. We might want to think a little more about what happens when we
> > stream partially complete metadata that cuts it somewhere where it
> > cannot be parsed.. ?
> 
> Of what I've experienced so far, there are times where the metadata is
> simply sent *only* when the stop command is done which uses a flush
> buffer operation and, since the trace throughput was so low so buffers
> don't get filled up.
> 
> Considering this *strong* requirement that the metadata needs to be
> streamed completely, can we think of a ustctl/kernctl that forces the
> metadata extraction?

Not sure what you mean. We can simply flush the metadata buffer. Or we
could decide to change the way we grab metadata altogether so it becomes
more synchronous with the application. However, this might be an issue
with application crash dump.

Thanks,

Mathieu

> 
> And this will be especially useful for new metadata added during
> tracing! (Not sure how we can deal with that on the session daemon since
> we have no idea but the tracer knows so maybe it could wake up the
> stream fd whenever there is metadata available?).
> 
> Cheers!
> David
> 
> > 
> > Thanks!
> > 
> > Mathieu
> > 
> >>
> >> Feedbacks, questions and improvement ideas welcome !
> >>
> >> Thanks,
> >>
> >> Julien
> > 

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
