From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Extract lttng trace from kernel coredump
Date: Sat, 18 Jan 2014 19:00:50 +0000 (UTC)
Message-ID: <353610105.9520.1390071650232.JavaMail.zimbra__2637.75833086601$1390071718$gmane$org@efficios.com>
References: <52D46B33.4010401@acm.org> <20140114184243.GC8177@thessa>
	<52D5A08F.4020204@acm.org>
	<1303248645.9400.1390063653581.JavaMail.zimbra@efficios.com>
	<52DAC820.7000005@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1W4b8Z-00029k-UE
	for lttng-dev@lists.lttng.org; Sat, 18 Jan 2014 14:01:02 -0500
In-Reply-To: <52DAC820.7000005@acm.org>
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
> Sent: Saturday, January 18, 2014 1:29:52 PM
> Subject: Re: [lttng-dev] Extract lttng trace from kernel coredump
> 
> On 01/18/2014 10:47 AM, Mathieu Desnoyers wrote:
> > ----- Original Message -----
> >> From: "Corey Minyard" <minyard@acm.org>
> >> To: "David Goulet" <dgoulet@efficios.com>
> >> Cc: lttng-dev@lists.lttng.org
> >> Sent: Tuesday, January 14, 2014 3:39:43 PM
> >> Subject: Re: [lttng-dev] Extract lttng trace from kernel coredump
> >>
> >> On 01/14/2014 12:42 PM, David Goulet wrote:
> >>> On 13 Jan (16:39:47), Corey Minyard wrote:
> >>>> I'm working on a feature to allow an lttng trace to be extracted from a
> >>>> kernel coredump, and I'm wondering the best way to proceed.  I've looked
> >>>> at extracting from the existing data structures, but that would require
> >>>> something to always have a trace file open and it looks more than a
> >>>> little complicated.  I was thinking instead of having a different trace
> >>>> channel for configuring this coredump and some globals to point to the
> >>>> various data structures.  Would that be the best way to pursue this?  Is
> >>>> there a better way, perhaps?
> >>> Oh yes we do actually already have a way to do that :)
> >>>
> >>> Please see:
> >>> https://git.lttng.org/?p=lttng-tools.git;a=tree;f=extras/core-handler;h=29ded89a71fd36e159d671ca1f405cea394f8683;hb=HEAD
> >>>
> >>> With the snapshot feature, it's quite easy to do that. Hope that helps
> >>> you with what you are trying to achieve.
> >> I did see that, but it seems to be for an application coredump.  I was
> >> looking for something that would work for a kernel coredump.  So that if
> >> the kernel crashes, you can use kdump to extract the kernel core and
> >> then extract the LTT buffers from that.  The idea is that if the kernel
> >> crashes, you can get some idea of what was happening before the crash.
> > Something along these lines have been proposed a while back on the ML,
> > but it was against an old LTTng version (0.x):
> >
> > http://lists.lttng.org/pipermail/lttng-dev/2010-August/014239.html
> >
> > It might be interesting to adapt it to the newer LTTng 2.x. Anyone
> > interested
> > to look into this ?
> 
> That was done by a colleague of mine.  However, things appear to have
> changed so much since then that it doesn't seem simple to extract a
> trace from memory.  It could be done, but I'm currently looking at
> adding a separate transport that writes to a simpler per-core circular
> data structure and doesn't actually ever generate any output.  Since it
> doesn't generate any output, it can be much simpler.

You can use the flight recorder mode in recent LTTng for this (2.3 and
newer). It simply writes to memory, without any output. I understand that
you want to create a contiguous ring buffer memory layout. However, you
have to be aware that this will probably be done using either

a) statically allocated memory at boot time (not very flexible),
b) vmalloc() (very flexible, but can triggers minor page faults, which
   can interact badly with page fault instrumentation. vmalloc() space
   is often limited by a kernel boot time parameter, and is putting
   quite important limitations on systems with 32-bit address spaces).

> 
> But I am certainly open to suggestions on how to do this, and happy to
> have anything included back into the mainline.
> 
> And I'm still learning about the internals of LTT.

One option would be to modify the tool to understand the LTTng 2.x buffer
layout by stitching pages together by software using the LTTng
libringbuffer "subbuffer table". You can think of it as a 2-level page
table, but one level indexes the sub-buffers, and the next level indexes
the pages within a sub-buffer.

A good way to understand its layout is to look at:

lttng-modules (master)
lib/ringbuffer/ring_buffer_backend.c

lib_ring_buffer_backend_allocate()

lib/ringbuffer/backend_types.h

struct lib_ring_buffer_backend
struct lib_ring_buffer_backend_subbuffer
struct lib_ring_buffer_backend_pages
struct lib_ring_buffer_backend_page

In your case, you never care about the bufb->buf_rsb (read-side owned subbuffer),
because you always ever just write into it. buf_rsb is only useful when taking
snapshots.

bufb->buf_wsb[] has the mapping from sub-buffers write-side index within
the buffer to the associated index into bufb->array[], which allows getting the
actual sub-buffers and memory pages associated to each buffer.

You'll notice that the "id" field within struct lib_ring_buffer_backend_subbuffer
is actually made of a mask of many fields. In order to understand how to use it,
see 

lib/ringbuffer/backend_types.h

where we provide helpers to get and set the various information elements
contained within the "id" field. See subbuffer_id*() functions and comments
surrounding them.

So you'll need to use the structures presented above to make sense of the memory
layout of a buffer, and reorganize it into a CTF file that can be read by
Babeltrace or other CTF trace readers.

The algorithm you want to end up doing (offline, on a vmcore) is pretty much
the same as grabbing an online snapshot (iterate from the consumer position up to
the producer position, see lib/ringbuffer/frontend.h:ib_ring_buffer_snapshot() ).
You will need an extra trick to handle the sub-buffer that was being written to
at the time of the crash, by using the

lib/ringbuffer/frontend_types.h struct commit_counters_hot "seq" field

which is designed to track the contiguously committed data within the currently
written buffer. This can be used at any point in time (whenever a crash occurs) to
populate the last sub-buffer's content size, packet size, see:

lttng-ring-buffer-client.h: client_buffer_end()

and find out how much of the last sub-buffer needs to be copied into the output
CTF trace.

Thanks,

Mathieu

> 
> Thanks,
> 
> -corey
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
