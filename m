From: Dave Chinner <david@fromorbit.com>
Subject: Re: [-stable 3.8.1 performance regression] madvise
 POSIX_FADV_DONTNEED
Date: Thu, 4 Jul 2013 10:03:44 +1000
Message-ID: <20130704000344.GG4072@dastard>
References: <20130618092925.GI1875@suse.de>
 <20130618101147.GA7436@suse.de>
 <20130619192508.GA666@Krystal>
 <CAJCc=kijujORhPUmPvzHj-MMdyVbf-iHEK0Jx-VHbTO8q4ESFA@mail.gmail.com>
 <20130620122016.GA12700@Krystal>
 <20130625015648.GO29376@dastard>
 <20130702135858.GA30837@Krystal>
 <20130703005514.GA17149@Krystal>
 <20130703084715.GF1875@suse.de>
 <x49wqp7puej.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <x49wqp7puej.fsf@segfault.boston.devel.redhat.com>
Sender: stable-owner@vger.kernel.org
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Mel Gorman <mgorman@suse.de>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Rob van der Heij <rvdheij@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Yannick Brosseau <yannick.brosseau@gmail.com>, stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Wed, Jul 03, 2013 at 10:53:08AM -0400, Jeff Moyer wrote:
> Mel Gorman <mgorman@suse.de> writes:
> 
> >> > I just tried replacing my sync_file_range()+fadvise() calls and instead
> >> > pass the O_DIRECT flag to open(). Unfortunately, I must be doing
> >> > something very wrong, because I get only 1/3rd of the throughput, and
> >> > the page cache fills up. Any idea why ?
> >> 
> >> Since O_DIRECT does not seem to provide acceptable throughput, it may be
> >> interesting to investigate other ways to lessen the latency impact of
> >> the fadvise DONTNEED hint.
> >> 
> >
> > There are cases where O_DIRECT falls back to buffered IO which is why you
> > might have found that page cache was still filling up. There are a few
> > reasons why this can happen but I would guess the common cause is that
> > the range of pages being written was in the page cache already and could
> > not be invalidated for some reason. I'm guessing this is the common case
> > for page cache filling even with O_DIRECT but would not bet money on it
> > as it's not a problem I investigated before.
> 
> Even when O_DIRECT falls back to buffered I/O for writes, it will
> invalidate the page cache range described by the buffered I/O once it
> completes.  For reads, the range is written out synchronously before the
> direct I/O is issued.  Either way, you shouldn't see the page cache
> filling up.

<sigh>

I keep forgetting that filesystems other than XFS have sub-optimal
direct IO implementations. I wish that "silent fallback to buffered
IO" idea had never seen the light of day, and that filesystems
implemented direct IO properly.

> Switching to O_DIRECT often incurs a performance hit, especially if the
> application does not submit more than one I/O at a time.  Remember,
> you're not getting readahead, and you're not getting the benefit of the
> writeback code submitting batches of I/O.

With the way IO is being done, there won't be any readahead (write
only workload) and they are directly controlling writeback one chunk
at a time, so there's not writeback caching to do batching, either.
There's no obvious reason that direct IO should be any slower
assuming that the application is actually doing 1MB sized and
aligned IOs like was mentioned, because both methods are directly
dispatching and then waiting for IO completion.

What filesystem is in use here?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
