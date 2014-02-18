From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Extract lttng trace from kernel coredump
Date: Tue, 18 Feb 2014 20:02:57 +0000 (UTC)
Message-ID: <1494812851.27081.1392753777851.JavaMail.zimbra__45487.2331386015$1392753855$gmane$org@efficios.com>
References: <52D46B33.4010401@acm.org> <20140114184243.GC8177@thessa>
	<52D5A08F.4020204@acm.org>
	<1303248645.9400.1390063653581.JavaMail.zimbra@efficios.com>
	<52DAC820.7000005@acm.org>
	<353610105.9520.1390071650232.JavaMail.zimbra@efficios.com>
	<52FD1D81.60306@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1WFqsg-00085v-7W
	for lttng-dev@lists.lttng.org; Tue, 18 Feb 2014 15:03:08 -0500
In-Reply-To: <52FD1D81.60306@acm.org>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: minyard@acm.org
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Corey Minyard" <minyard@acm.org>
> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: "David Goulet" <dgoulet@efficios.com>, lttng-dev@lists.lttng.org
> Sent: Thursday, February 13, 2014 2:31:13 PM
> Subject: Re: [lttng-dev] Extract lttng trace from kernel coredump
> 
> On 01/18/2014 01:00 PM, Mathieu Desnoyers wrote:
> > You can use the flight recorder mode in recent LTTng for this (2.3 and
> > newer). It simply writes to memory, without any output. I understand that
> > you want to create a contiguous ring buffer memory layout. However, you
> > have to be aware that this will probably be done using either
> >
> > a) statically allocated memory at boot time (not very flexible),
> > b) vmalloc() (very flexible, but can triggers minor page faults, which
> >    can interact badly with page fault instrumentation. vmalloc() space
> >    is often limited by a kernel boot time parameter, and is putting
> >    quite important limitations on systems with 32-bit address spaces).
> >
> >> But I am certainly open to suggestions on how to do this, and happy to
> >> have anything included back into the mainline.
> >>
> >> And I'm still learning about the internals of LTT.
> > One option would be to modify the tool to understand the LTTng 2.x buffer
> > layout by stitching pages together by software using the LTTng
> > libringbuffer "subbuffer table". You can think of it as a 2-level page
> > table, but one level indexes the sub-buffers, and the next level indexes
> > the pages within a sub-buffer.
> 
> I'm finally back to this.  I discovered that /proc/vmcore did not map
> vmalloc-ed memory, so I had to come up with something to handle that
> before I could continue to work on this.
> 
> This information was very useful, and snapshot mode is definitely the
> way to go.  I just want to make sure I understand this before I go on. I
> have some specific question:

Sorry for the lag... ;)

I'll reply to your questions below just to make sure we're in sync.

> 
> consumed is where the data starts and offset is where the data ends.

Yes, approximately. This is right for consumed (this is where 
consumable data starts), but "offset" is either:
- where the data ends, or
- slightly beyond where the last contiguously committed data end.

It means we have to take extra care for buffers where the amount of
commit_seq count is not a multiple of the sub-buffer size.

> So
> just go through the subbufs through a double index.  Calculate the
> start/end location by taking the consumed/offset value,

First apply a module buffer size, otherwise the free running counters
divided by subbuffer size will go beyond the backend.buf_wsb array.

> dividing that by
> the size of a subbuffer,

Yes,

> looking up that value in backend.buf_wsb,
> getting the index from the id there, then indexing into the
> backend.array with the index.

Yes.

> Once you have the subbuffer, you mod the
> location by the size of a subbuffer and that's the subbuffer offset.

Exactly.

> Divide the subbuffer offset by a page size to get the page index in the
> subbuffer, and mod by a page size to get the offset into the page.

Yes.

> 
> Starting from the consumed position, dump data from pages until you hit
> subbufer->data_size, then move to the next subbuffer.  On the last
> subbuffer, you have to fill in the header and dump up to the offset.

Not quite exactly. It's better to do:

for each subbuffer between consumed and offset (inclusive)
  - if commit_seq is multiple of subbuffer size
    dump subbuffer->data_size
  - if commit_seq is not a multiple of subbuffer size,
    dump commit_seq % subbuf size bytes of data, filling up the
    header accordingly.

Basically, all data that was "being written" (between commit_seq % subbuf size
and write offset % subbuf size) cannot be read, because it likely contains
holes and/or incomplete data.

> 
> I think I'm missing something, though, because the data size of the last
> subbuffer doesn't match the offset location in that subbuffer.  It's a
> pretty good distance away.

Does my explanation above help clear things out ?

Thanks,

Mathieu

> 
> Thanks,
> 
> -corey
> 
> > A good way to understand its layout is to look at:
> >
> > lttng-modules (master)
> > lib/ringbuffer/ring_buffer_backend.c
> >
> > lib_ring_buffer_backend_allocate()
> >
> > lib/ringbuffer/backend_types.h
> >
> > struct lib_ring_buffer_backend
> > struct lib_ring_buffer_backend_subbuffer
> > struct lib_ring_buffer_backend_pages
> > struct lib_ring_buffer_backend_page
> >
> > In your case, you never care about the bufb->buf_rsb (read-side owned
> > subbuffer),
> > because you always ever just write into it. buf_rsb is only useful when
> > taking
> > snapshots.
> >
> > bufb->buf_wsb[] has the mapping from sub-buffers write-side index within
> > the buffer to the associated index into bufb->array[], which allows getting
> > the
> > actual sub-buffers and memory pages associated to each buffer.
> >
> > You'll notice that the "id" field within struct
> > lib_ring_buffer_backend_subbuffer
> > is actually made of a mask of many fields. In order to understand how to
> > use it,
> > see
> >
> > lib/ringbuffer/backend_types.h
> >
> > where we provide helpers to get and set the various information elements
> > contained within the "id" field. See subbuffer_id*() functions and comments
> > surrounding them.
> >
> > So you'll need to use the structures presented above to make sense of the
> > memory
> > layout of a buffer, and reorganize it into a CTF file that can be read by
> > Babeltrace or other CTF trace readers.
> >
> > The algorithm you want to end up doing (offline, on a vmcore) is pretty
> > much
> > the same as grabbing an online snapshot (iterate from the consumer position
> > up to
> > the producer position, see
> > lib/ringbuffer/frontend.h:ib_ring_buffer_snapshot() ).
> > You will need an extra trick to handle the sub-buffer that was being
> > written to
> > at the time of the crash, by using the
> >
> > lib/ringbuffer/frontend_types.h struct commit_counters_hot "seq" field
> >
> > which is designed to track the contiguously committed data within the
> > currently
> > written buffer. This can be used at any point in time (whenever a crash
> > occurs) to
> > populate the last sub-buffer's content size, packet size, see:
> >
> > lttng-ring-buffer-client.h: client_buffer_end()
> >
> > and find out how much of the last sub-buffer needs to be copied into the
> > output
> > CTF trace.
> >
> > Thanks,
> >
> > Mathieu
> >
> >> Thanks,
> >>
> >> -corey
> >>
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
