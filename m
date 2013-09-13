From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH] Introduce timekeeper latch synchronization
Date: Fri, 13 Sep 2013 10:05:48 -0700
Message-ID: <523345EC.8070206@efficios.com>
References: <20130913025253.GA17218@Krystal> <alpine.DEB.2.02.1309131803360.4089@ionos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.02.1309131803360.4089@ionos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, John Stultz <john.stultz@linaro.org>, Richard Cochran <richardcochran@gmail.com>, Prarit Bhargava <prarit@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 13/09/13 09:13 AM, Thomas Gleixner wrote:
> On Thu, 12 Sep 2013, Mathieu Desnoyers wrote:
>> * Peter Zijlstra (peterz@infradead.org) wrote:
>> [...]
>>> Yep, that's good. I suppose if there's multiple use sites we can jump
>>> through another few hoops to get rid of the specific struct foo
>>> assumptions by storing sizeof() whatever we do use and playing pointer
>>> math games.
>>>
>>> But for now with the time stuff as only user this looks ok.
>> OK! Here is the full implementation of the idea against Linux
>> timekeeper, ntp, and PPS. It appears that ntp and PPS were relying on
>> the timekeeper seqlock too. And guess what, after booting my laptop with
>> this kernel there still no smoke coming out of it after a good 5 minutes
>> of testing. ;-)
>>
>> Comments are welcome.
> First of all this needs to be split into several patches.
How about:
- three patches refactoring data structures into objects (no
synchronization changes whatsoever). timekeeper, ntp and pps each done
in separate patches,
- one patch to introduce the new synchronization scheme along with the
usage site changes. This patch would include the removal of the
shadow_timekeeper variable, which is made pointless by the introduction
of this mixed-rcu-seqcount synchronization scheme.

is that enough, or you see a more fine-grained breakdown ?


>
>>  static void update_wall_time(void)
>  ...
>> -	write_seqcount_begin(&timekeeper_seq);
>>  	/* Update clock->cycle_last with the new value */
>>  	clock->cycle_last = tk->cycle_last;
>> -	/*
>> -	 * Update the real timekeeper.
>> -	 *
>> -	 * We could avoid this memcpy by switching pointers, but that
>> -	 * requires changes to all other timekeeper usage sites as
>> -	 * well, i.e. move the timekeeper pointer getter into the
>> -	 * spinlocked/seqcount protected sections. And we trade this
>> -	 * memcpy under the timekeeper_seq against one before we start
>> -	 * updating.
>> -	 */
>> -	memcpy(real_tk, tk, sizeof(*tk));
>> -	timekeeping_update(real_tk, action);
> So you're dropping the timekeeping_update() call here. I wonder how
> this works.

It doesn't :-)

There appears to be a couple of side-effects related to removal of the
call to timekeeping_update(). On the positive side, I now have much more
free time on my hands. However, people seem to complain that I arrive
late to meetings for some reasons ;-)

>
>> +	timekeeper_write_begin(&latch_timekeeper, &prev, &tk);
>> +	*tk = *prev;
> Do we really need to do the copy on all call sites, instead of doing
> it in timekeeper_write_begin() ?

Since we're indeed doing the copy on all call sites, I think it would be
good to move it into timekeeper_write_begin() as you suggest.

Initially, I kept the copy in the caller in case we could do without the
copy in some cases (in case the caller would overwrite the entire
structure without caring about prior content). But since we need to copy
timekeeper, ntp and pps structures, I doubt this is realistic. So let's
move this copy into timekeeper_write_begin().

Thanks !

Mathieu


>
> Thanks,
>
> 	tglx
