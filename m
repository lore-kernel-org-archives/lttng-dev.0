From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH] Introduce timekeeper latch synchronization
Date: Fri, 13 Sep 2013 11:30:20 -0400
Message-ID: <20130913153020.GA24383@Krystal>
References: <20130913025253.GA17218@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130913025253.GA17218@Krystal>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Richard Cochran <richardcochran@gmail.com>, Prarit Bhargava <prarit@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Mathieu Desnoyers (mathieu.desnoyers@efficios.com) wrote:
[...]
> @@ -1362,29 +1398,31 @@ static inline void old_vsyscall_fixup(struct timekeeper *tk)
>  static void update_wall_time(void)
>  {
[...]
> -	/*
> -	 * Update the real timekeeper.
> -	 *
> -	 * We could avoid this memcpy by switching pointers, but that
> -	 * requires changes to all other timekeeper usage sites as
> -	 * well, i.e. move the timekeeper pointer getter into the
> -	 * spinlocked/seqcount protected sections. And we trade this
> -	 * memcpy under the timekeeper_seq against one before we start
> -	 * updating.
> -	 */
> -	memcpy(real_tk, tk, sizeof(*tk));
> -	timekeeping_update(real_tk, action);

This line above appears to be important ;-) Let's see if my screensaver
stops misbehaving if I put it back. I will of course send a v2 after
some more testing.

By the way, if there are some standard test-bench for timekeeping, I'd
be very interested to hear about them.

Thanks!

Mathieu

> -	write_seqcount_end(&timekeeper_seq);
>  out:
> +	timekeeper_write_end(&latch_timekeeper);
>  	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
>  }

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
