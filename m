From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH lttng-modules] Fix: bump stable kernel version ranges for
 clock work-around
Date: Thu, 13 Oct 2016 17:00:36 +0200
Message-ID: <20161013150036.GA21105@kroah.com>
References: <1476367015-21624-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1476367015-21624-1-git-send-email-mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org, John Stultz <john.stultz@linaro.org>
List-Id: lttng-dev@lists.lttng.org

On Thu, Oct 13, 2016 at 03:56:55PM +0200, Mathieu Desnoyers wrote:
> Linux commit 27727df240c7 ("Avoid taking lock in NMI path with
> CONFIG_DEBUG_TIMEKEEPING"), changed the logic to open-code
> the timekeeping_get_ns() function, but forgot to include
> the unit conversion from cycles to nanoseconds, breaking the
> function's output, which impacts LTTng.
> 
> We expected Linux commit 58bfea9532 "timekeeping: Fix
> __ktime_get_fast_ns() regression" to make its way into stable
> kernels promptly, but it appears new stable kernel releases were
> done before the fix was cherry-picked from the master branch.

Sorry, will go queue that up now...

greg k-h
