From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: Re: [-stable 3.8.1 performance regression] madvise POSIX_FADV_DONTNEED
Date: Wed, 03 Jul 2013 14:47:58 -0400
Message-ID: <51D471DE.3020800@gmail.com>
References: <20130617141357.GA6034@Krystal> <20130617142459.1d563072231ba269cdac8f11@linux-foundation.org> <20130618092925.GI1875@suse.de> <20130618101147.GA7436@suse.de> <20130619192508.GA666@Krystal> <CAJCc=kijujORhPUmPvzHj-MMdyVbf-iHEK0Jx-VHbTO8q4ESFA@mail.gmail.com> <20130620122016.GA12700@Krystal> <20130625015648.GO29376@dastard> <20130702135858.GA30837@Krystal> <20130703005514.GA17149@Krystal> <20130703084715.GF1875@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130703084715.GF1875@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Mel Gorman <mgorman@suse.de>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Dave Chinner <david@fromorbit.com>, Rob van der Heij <rvdheij@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On 2013-07-03 04:47, Mel Gorman wrote:
>> Given it is just a hint, we should be allowed to perform page
>> > deactivation lazily. Is there any fundamental reason to wait for worker
>> > threads on each CPU to complete their lru drain before returning from
>> > fadvise() to user-space ?
>> > 
> Only to make sure they pages are actually dropped as requested. The reason
> the wait was introduced in the first place was that page cache was filling
> up even with the fadvise calls and causing disruption. In 3.11 disruption
> due to this sort of parallel IO should be reduced but making fadvise work
> properly is reasonable in itself. Was that patch I posted ever tested or
> did I manage to miss it?
I did test it. On our test case, we get a worst result with it.

Yannick
