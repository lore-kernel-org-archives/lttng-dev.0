From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH] timekeeping: introduce timekeeping_is_busy()
Date: Thu, 12 Sep 2013 03:25:31 +0200
Message-ID: <20130912012531.GS31370@twins.programming.kicks-ass.net>
References: <20130911150853.GA19800@Krystal>
 <52309D13.3020305@linaro.org>
 <20130911185441.GC23532@Krystal>
 <20130911203618.GH3966@linux.vnet.ibm.com>
 <20130912004811.GA6096@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130912004811.GA6096@Krystal>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Richard Cochran <richardcochran@gmail.com>, Prarit Bhargava <prarit@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On Wed, Sep 11, 2013 at 08:48:11PM -0400, Mathieu Desnoyers wrote:
> Thoughts ?


struct foo {
	...
};

spinlock_t foo_lock;
unsigned int foo_head = 0;
unsigned int foo_tail = 0;
struct foo foo_array[2];

void foo_assign(struct foo f)
{
	spin_lock(&foo_lock);
	foo_head++;
	smp_wmb();
	foo_array[foo_head & 1] = f;
	smp_wmb();
	foo_tail++;
	spin_unlock(&foo_lock);
}

struct foo foo_get(void)
{
	unsigned int tail, head;
	struct foo ret;

again:
	tail = ACCESS_ONCE(foo_tail);
	smp_rmb();
	ret = foo_array[tail & 1];
	smp_rmb();
	head = ACCESS_ONCE(foo_head);
	if (head - tail >= 2)
		goto again;

	return ret;
}

Should work and get you the most recent 'complete' foo even when
foo_get() is called nested inside foo_assign().
