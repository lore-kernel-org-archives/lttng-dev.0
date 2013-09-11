From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH] timekeeping: introduce timekeeping_is_busy()
Date: Wed, 11 Sep 2013 13:07:50 -0400
Message-ID: <20130911130750.6a60d30f@gandalf.local.home>
References: <20130911150853.GA19800@Krystal>
	<52309D13.3020305@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <52309D13.3020305@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: John Stultz <john.stultz@linaro.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Thomas Gleixner <tglx@linutronix.de>, Richard Cochran <richardcochran@gmail.com>, Prarit Bhargava <prarit@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On Wed, 11 Sep 2013 09:40:51 -0700
John Stultz <john.stultz@linaro.org> wrote:

> (and it avoids me forgetting to set the owner in some future change,
> further mucking things up :).

Wow, I had to read that twice to see what you really wrote. I was
thinking "damn, John is getting vulgar!" ;-)

-- Steve 
