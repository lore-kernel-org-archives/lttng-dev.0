From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [-stable 3.8.1 performance regression] madvise POSIX_FADV_DONTNEED
Date: Wed, 03 Jul 2013 10:53:08 -0400
Message-ID: <x49wqp7puej.fsf@segfault.boston.devel.redhat.com>
References: <20130617141357.GA6034@Krystal>
	<20130617142459.1d563072231ba269cdac8f11@linux-foundation.org>
	<20130618092925.GI1875@suse.de> <20130618101147.GA7436@suse.de>
	<20130619192508.GA666@Krystal>
	<CAJCc=kijujORhPUmPvzHj-MMdyVbf-iHEK0Jx-VHbTO8q4ESFA@mail.gmail.com>
	<20130620122016.GA12700@Krystal> <20130625015648.GO29376@dastard>
	<20130702135858.GA30837@Krystal> <20130703005514.GA17149@Krystal>
	<20130703084715.GF1875@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20130703084715.GF1875@suse.de> (Mel Gorman's message of "Wed, 3
	Jul 2013 09:47:15 +0100")
Sender: stable-owner@vger.kernel.org
To: Mel Gorman <mgorman@suse.de>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Dave Chinner <david@fromorbit.com>, Rob van der Heij <rvdheij@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Yannick Brosseau <yannick.brosseau@gmail.com>, stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Mel Gorman <mgorman@suse.de> writes:

>> > I just tried replacing my sync_file_range()+fadvise() calls and instead
>> > pass the O_DIRECT flag to open(). Unfortunately, I must be doing
>> > something very wrong, because I get only 1/3rd of the throughput, and
>> > the page cache fills up. Any idea why ?
>> 
>> Since O_DIRECT does not seem to provide acceptable throughput, it may be
>> interesting to investigate other ways to lessen the latency impact of
>> the fadvise DONTNEED hint.
>> 
>
> There are cases where O_DIRECT falls back to buffered IO which is why you
> might have found that page cache was still filling up. There are a few
> reasons why this can happen but I would guess the common cause is that
> the range of pages being written was in the page cache already and could
> not be invalidated for some reason. I'm guessing this is the common case
> for page cache filling even with O_DIRECT but would not bet money on it
> as it's not a problem I investigated before.

Even when O_DIRECT falls back to buffered I/O for writes, it will
invalidate the page cache range described by the buffered I/O once it
completes.  For reads, the range is written out synchronously before the
direct I/O is issued.  Either way, you shouldn't see the page cache
filling up.

Switching to O_DIRECT often incurs a performance hit, especially if the
application does not submit more than one I/O at a time.  Remember,
you're not getting readahead, and you're not getting the benefit of the
writeback code submitting batches of I/O.

HTH,
Jeff
