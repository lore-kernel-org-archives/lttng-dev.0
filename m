From: John Stultz <john.stultz@linaro.org>
Subject: Re: [RFC PATCH] Introduce timekeeper latch synchronization
Date: Fri, 13 Sep 2013 12:20:22 -0700
Message-ID: <52336576.1060908@linaro.org>
References: <20130913025253.GA17218@Krystal> <20130913153020.GA24383@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130913153020.GA24383@Krystal>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Richard Cochran <richardcochran@gmail.com>, Prarit Bhargava <prarit@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 09/13/2013 08:30 AM, Mathieu Desnoyers wrote:
> By the way, if there are some standard test-bench for timekeeping, I'd
> be very interested to hear about them.
I've got a git repo of tests that I use for basic sanity checks here:
    https://github.com/johnstultz-work/timetests.git

thanks
-john
