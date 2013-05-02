From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: urcu rfc: privatize urcu/futex.h
Date: Thu, 2 May 2013 16:51:41 -0400
Message-ID: <20130502205141.GA16536__49805.7731114843$1367527936$gmane$org@Krystal>
References: <5020DBFF.3020702@cn.fujitsu.com> <20120807140616.GA29280@Krystal>
	<5021BAF5.4080507@cn.fujitsu.com> <5021C1A5.5090404@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UY0Te-0006dk-MR
	for lttng-dev@lists.lttng.org; Thu, 02 May 2013 16:51:42 -0400
Content-Disposition: inline
In-Reply-To: <5021C1A5.5090404@cn.fujitsu.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Lai Jiangshan <laijs@cn.fujitsu.com>
Cc: Lai Jiangshan <eag0628@gmail.com>, lttng-dev@lists.lttng.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

* Lai Jiangshan (laijs@cn.fujitsu.com) wrote:
> (Added a CC email address)
> 
> On 08/08/2012 09:03 AM, Lai Jiangshan wrote:
> > On 08/07/2012 10:06 PM, Mathieu Desnoyers wrote:
> >> Hi Lai,
> >>
> >> * Lai Jiangshan (laijs@cn.fujitsu.com) wrote:
> >>> futex.h is in urcu/, it means it can be used by users out of the library.
> >>>
> >>> But
> >>>
> >>> If the user's system has futex, he should use #include <linux/futex.h>.
> >>> If the user's system don't have futex, it is not good that if the user
> >>> use this compat_futex.
> >>>
> >>> Because the compat_futex_async()'s behavior is different from the
> >>> futex in linux.  If the caller don't change the value of @uaddr, the
> >>> futex(FUTEX_WAKE) in linux can also wake a thread, but
> >>> compat_futex_async() don't.  (I guess no one use this behavior, but if
> >>> there are someone, we give them a wrong thing)
> >>
> >> Hrm, passing a NULL uaddr parameter is really not the targeted use-case.
> >> We could probably just document that uaddr should not be NULL when using
> >> compat_futex ?
> > 
> > Sorry, I wanted to show you such un-normal behavior:
> > 
> > /* keep the value of *uaddr unchanged, wake up a thread to do something */
> > futex(FUTEX_WAKE, uaddr, ...).
> > 
> > This can't not wake up any thread for current compat_futex_async() implement.
> > But the sys_futex() can.
> > 
> > 
> 
> It is hard to implement compat_futex_async() to make its behavior compatible
> with sys_futex().(I don't like the two alternatives too, I just wrote
> what I have thought) so I sent rfc email to suggest to privatize
> urcu/futex.h.

I don't think this issue has been taken care of, am I correct ?

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
