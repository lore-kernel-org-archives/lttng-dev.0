From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [tip:timers/urgent] timekeeping: Fix HRTICK related deadlock
 from ntp lock changes
Date: Tue, 17 Sep 2013 09:07:28 +0200
Message-ID: <20130917070728.GC20661@gmail.com>
References: <1378943457-27314-1-git-send-email-john.stultz@linaro.org>
 <tip-7bd36014460f793c19e7d6c94dab67b0afcfcb7f@git.kernel.org>
 <20130916160426.GA24669@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130916160426.GA24669@Krystal>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: hpa@zytor.com, linux-kernel@vger.kernel.org, gerlando.falauto@keymile.com, john.stultz@linaro.org, minggr@gmail.com, tglx@linutronix.de, linux-tip-commits@vger.kernel.org, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


* Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> Hi Ingo,
> 
> Do you have an estimate of the time it will take for this fix to hit 
> mainline, stable-3.10 and stable-3.11 ? Meanwhile, I'm marking 3.10 and 
> 3.11 as broken for LTTng with a kernel version at compile-time, since 
> this kernel regression currently triggers hard system lockup when people 
> use LTTng on those kernels, and this is certainly something nobody 
> wants.

So, at least as per the description of John, this should only trigger if 
SCHED_HRTICK is enabled in sched_features - which is disabled by default, 
it's a debug-only development feature. Does the bug trigger on more 
regular kernels as well?

I planned to send it Linus after v3.12-rc1, in the next day or two.

Thanks,

	Ingo
