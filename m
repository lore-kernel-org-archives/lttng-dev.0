From: Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [diamon-discuss] [RELEASE] LTTng-modules 2.9.11, 2.10.8,
 2.11.0-rc2 (Linux kernel tracer)
Date: Thu, 21 Mar 2019 08:41:22 -0400
Message-ID: <20190321124122.GA30542@google.com>
References: <60988959.4070.1541112982406.JavaMail.zimbra@efficios.com>
 <CAJWu+ooEbjOXgVeq+g4MGEve9PTo7p7UUKjYYHhq-Wz6UbUhfg@mail.gmail.com>
 <1199524058.2398.1553016874435.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1199524058.2398.1553016874435.JavaMail.zimbra@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: diamon-discuss@lists.linuxfoundation.org, lttng-dev <lttng-dev@lists.lttng.org>, linux-kernel <linux-kernel@vger.kernel.org>, rostedt@goodmis.org
List-Id: lttng-dev@lists.lttng.org

On Tue, Mar 19, 2019 at 01:34:34PM -0400, Mathieu Desnoyers wrote:
> ----- On Nov 1, 2018, at 7:33 PM, Joel Fernandes via diamon-discuss diamon-discuss@lists.linuxfoundation.org wrote:
> 
> > On Thu, Nov 1, 2018 at 3:56 PM Mathieu Desnoyers
> > <mathieu.desnoyers@efficios.com> wrote:
> >>
> >> Hi,
> >>
> >> This is a set of bugfix releases of the LTTng modules kernel tracer.
> >> It covers the three currently active lttng-modules branches: the
> >> 2.9 and 2.10 stable branches, as well as the 2.11 branch in release
> >> candidate cycle.
> >>
> >> Those releases add support for kernel 4.19.
> >>
> >> One important improvement is to prevent allocation of buffers larger
> >> than the available memory, which can cause the OOM killer to trigger.
> >> Even if the OOM killer end up having to trigger, the current OOM kill
> >> target is set to the current thread while allocating buffers.
> > 
> > This is interesting. Me and Steve were looking at exactly this issue
> > with the ftrace ring buffer a few months ago. Turns out that even
> > setting the OOM kill target may not be enough to prevent all OOMs. I
> > don't remember the reason why not, I'll have to dig out those threads
> > but that's what the -mm folks said at the time. I did remember vaguely
> > that I tested it and the kill target doesn't always get killed.. its
> > possible that something *other* parallel allocation can be victimized
> > AFAIR, even though the culprit is the kill target.
> > 
> 
> Hi Joel,
> 
> Sorry for the late reply. Thanks for your input!

No problem, thanks for the reply :)

> Here is a description of the solution we implemented:
> 
> "   Get an estimate of the number of available pages and return ENOMEM if
>     there are not enough pages to cover the needs of the caller. Also, mark
>     the calling user thread as the first target for the OOM killer in case
>     the estimate of available pages was wrong.
>     
>     This greatly reduces the attack surface of this issue as well as reducing
>     its potential impact.
>     
>     This approach is inspired by the one taken by the Linux kernel
>     trace ring buffer[1]."
> 
> This is implemented in commit 1f0ab1eb040 "Prevent allocation of buffers if exceeding available memory"
> within lttng-modules.
> 
> Are you aware of another way to achieve this that would prevent the incorrect
> OOM victimization scenario you describe above ?

Adding Steve as well.

As far as I can see, lttng does exactly the same thing ftrace does, however
ftrace also does allocations with __GFP_RETRY_MAYFAIL. I think you want to do
that too. That will prevent the ring buffer allocation from being the source
of the OOM trigger. However, if OOM is triggered due to parallel allocations
from other sources, then the ring-buffer allocation will still be killed even
though it is not the only source of the large allocation.  That is the best
we came up with.

Also does it also make sense for lttng ring buffer to use the ftrace code for
ring buffer, or make the ftrace ring buffer better and have lttng use it? Or
is the lttng ring buffer design too radically different?

thanks,

 - Joel
