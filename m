From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: UST Hanging at Tracepoint
Date: Wed, 13 Jun 2012 04:29:05 -0400
Message-ID: <20120613082905.GA30485__20879.8127984211$1339576168$gmane$org@Krystal>
References: <3F56B905CF2083408E8482044F20428AEF604D22@ONWVEXCHMB01.ciena.com>
	<3F56B905CF2083408E8482044F20428AEF78BC79@ONWVEXCHMB01.ciena.com>
	<20120612140925.GB13917@Krystal> <20120612141344.GC13917@Krystal>
	<3F56B905CF2083408E8482044F20428AEF7A0AFE@ONWVEXCHMB01.ciena.com>
	<3F56B905CF2083408E8482044F20428AEF7A0B4C@ONWVEXCHMB01.ciena.com>
	<20120612162526.GB16098@Krystal>
	<3F56B905CF2083408E8482044F20428AEF7A0ED6@ONWVEXCHMB01.ciena.com>
	<20120613000950.GD21966@Krystal> <20120613002128.GE21966@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Seiwt-0001UN-0u
	for lttng-dev@lists.lttng.org; Wed, 13 Jun 2012 04:29:07 -0400
Content-Disposition: inline
In-Reply-To: <20120613002128.GE21966@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Burton, Michael" <mburton@ciena.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "dgoulet@efficios.com" <dgoulet@efficios.com>
List-Id: lttng-dev@lists.lttng.org

* Mathieu Desnoyers (mathieu.desnoyers@efficios.com) wrote:
> * Mathieu Desnoyers (mathieu.desnoyers@efficios.com) wrote:
> > * Burton, Michael (mburton@ciena.com) wrote:
> > > Mathieu,
> > > 
> > > I think there is a deadlock scenario in UST, which has been causing my problem.
> > 
> > Good catch !
> > 
> > > 
> > > sessiond is started as root:
> > >     - creates global sockets ONLY
> > >     - DOES NOT CREATE shm in $HOME/lttng-ust-wait-<uid>
> > > 
> > > application linked against ust is run as root:
> > >   - in lttng_ust_init constructor
> > >   - ust_listener_thread  (local_apps)
> > >     - fails to connect to local_apps in $HOME/.lttng (as expected)
> > >     - prev_connect_failed=1
> > >     - ust_unlock()
> > >     - restart
> > >     - wait_for_sessiond()
> > >  -->  - ust_lock()
> > >  |      - get_map_shm()
> > >  |        - get_wait_shm()
> > > DEADLOCK    - shm_open() FAILS (not created by sessiond when run by root)
> > >  |            - fork() (trying to create shared memory itself)
> > >  |              - ust_before_fork()
> > >  ------------>    - ust_lock()
> > > 
> > > 
> > > You should be able to create this with an empty main, with no
> > > tracepoints.  As long as sessiond is started as root so
> > > $HOME/lttng-ust-wait-<uid> is not created.  You can also make the
> > > lttng-ust constructor (lttng_ust_init) wait forever and then you'll be
> > > able to see the deadlock in gdb without even leaving the
> > > lttng_ust_init constructor.
> > 
> > Ah, I see. This deadlock is caused by the interaction between
> > liblttng-ust-libc-wrapper and liblttng-ust (the fork override is
> > performed by liblttng-ust-libc-wrapper). I'll have to look into this
> > issue further. More on that soon.
> 
> Actually, I meant that it comes from interaction between
> liblttng-ust-fork and liblttng-ust (sorry about the confusion above).
> I'll see if I can provide a direct access to the fork() symbol to
> liblttng-ust, using a weak symbol so it is defined even when
> liblttng-ust-fork is not linked.
> 
> More on that soon...

Fixed by master commit:

commit e8508a495280a1396a0319a157409a7ea61ffc5a
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Wed Jun 13 04:26:34 2012 -0400

    Fix: liblttng-ust-fork deadlock

and merged into stable-2.0.

Thanks for pointing out this important bug.

Mathieu

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
