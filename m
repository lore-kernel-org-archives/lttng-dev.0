From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RELEASE] Userspace RCU 0.7.3
Date: Wed, 27 Jun 2012 12:02:25 -0400
Message-ID: <20120627160225.GA17076__38666.23809231$1340813108$gmane$org@Krystal>
References: <20120601180533.GA15522@Krystal>
	<alpine.DEB.2.02.1206040932580.2583@mtl.rackplans.net>
	<20120604155143.GA24551@Krystal>
	<alpine.DEB.2.02.1206270608320.25860@mtl.rackplans.net>
	<20120627133523.GA13831@Krystal>
	<alpine.DEB.2.02.1206271033210.25860@mtl.rackplans.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1SjuhI-00057c-Ey
	for lttng-dev@lists.lttng.org; Wed, 27 Jun 2012 12:02:28 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1206271033210.25860@mtl.rackplans.net>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Gerhard Mack <gmack@innerfire.net>
Cc: lttng-dev@lists.lttng.org, Alexandre Montplaisir <alexandre.montplaisir@polymtl.ca>
List-Id: lttng-dev@lists.lttng.org

well this fix is in queue for the upcoming 0.7.4, which is not released
yet. So yes, it is not present in the last stable release.

Thanks,

Mathieu

* Gerhard Mack (gmack@innerfire.net) wrote:
> 
> 
> Yes, it looks like it does.  Sorry for the noise it looks like it picked 
> up debian''s 6.7.2 rather than the newer version.
> 
> 	Gerhard
> 
> 
> On Wed, 27 Jun 2012, Mathieu Desnoyers wrote:
> 
> > Date: Wed, 27 Jun 2012 09:35:24 -0400
> > From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > To: Gerhard Mack <gmack@innerfire.net>
> > Cc: Alexandre Montplaisir <alexandre.montplaisir@polymtl.ca>,
> >     lttng-dev@lists.lttng.org
> > Subject: Re: [RELEASE] Userspace RCU 0.7.3
> > 
> > * Gerhard Mack (gmack@innerfire.net) wrote:
> > > 
> > > Just a heads up, I had to add the following to get it working with code 
> > > compiled with the gcc flag "-std=c99"
> > > 
> > > #ifndef asm
> > > #define asm  __asm
> > > #endif 
> > 
> > Normally, in userspace rcu git master HEAD, you have this commit
> > already:
> > 
> > commit e51500edbd9919cee53bc85cbb4b22cd4786fc42
> > Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Date:   Tue Jun 12 11:24:31 2012 -0400
> > 
> >     Fix c99 compatibility: use __asm__ and __volatile__ in public headers
> >     
> >     Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > 
> > Does it fix it for you ?
> > 
> > Thanks,
> > 
> > Mathieu
> > 
> > > 
> > > 	Gerhard
> > > 
> > > On Mon, 4 Jun 2012, Mathieu Desnoyers wrote:
> > > 
> > > > Date: Mon, 4 Jun 2012 11:51:43 -0400
> > > > From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > > To: Gerhard Mack <gmack@innerfire.net>,
> > > >     Alexandre Montplaisir <alexandre.montplaisir@polymtl.ca>
> > > > Cc: lttng-dev@lists.lttng.org
> > > > Subject: Re: [RELEASE] Userspace RCU 0.7.3
> > > > 
> > > > * Gerhard Mack (gmack@innerfire.net) wrote:
> > > > > 
> > > > > Are there any online examples of how to use this library?  I can't seem to 
> > > > > find any.
> > > > 
> > > > The perfbook from Paul McKenney now uses userspace RCU in its examples
> > > > (http://kernel.org/pub/linux/kernel/people/paulmck/perfbook/perfbook.html)
> > > > 
> > > > Also, you will find various small programs in the source tree of the
> > > > userspace-rcu packages under tests/ that act as test programs, and also
> > > > show how to use the library. (in the git tree:
> > > > http://git.lttng.org/?p=userspace-rcu.git;a=tree;f=tests;hb=HEAD)
> > > > 
> > > > I guess setting up a tutorial HTML page from the test content would be
> > > > valuable, we just have not had the time to do it at this point. Maybe
> > > > setting up links to that documentation on the lttng.org/urcu web page
> > > > would be a good start though.
> > > > 
> > > > Alexandre, when you find a minute, can you look into this ?
> > > > 
> > > > Thanks!
> > > > 
> > > > Mathieu
> > > > 
> > > > 
> > > > > 
> > > > > 	Gerhard
> > > > > 
> > > > > 
> > > > > 
> > > > > On Fri, 1 Jun 2012, Mathieu Desnoyers wrote:
> > > > > 
> > > > > > Date: Fri, 1 Jun 2012 14:05:33 -0400
> > > > > > From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > > > > To: linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org,
> > > > > >     rp@svcs.cs.pdx.edu
> > > > > > Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>,
> > > > > >     Lai Jiangshan <laijs@cn.fujitsu.com>,
> > > > > >     Stephen Hemminger <shemminger@vyatta.com>
> > > > > > Subject: [RELEASE] Userspace RCU 0.7.3
> > > > > > 
> > > > > > liburcu is a LGPLv2.1 userspace RCU (read-copy-update) library. This
> > > > > > data synchronization library provides read-side access which scales
> > > > > > linearly with the number of cores. It does so by allowing multiples
> > > > > > copies of a given data structure to live at the same time, and by
> > > > > > monitoring the data structure accesses to detect grace periods after
> > > > > > which memory reclamation is possible.
> > > > > > 
> > > > > > liburcu-cds provides efficient data structures based on RCU and
> > > > > > lock-free algorithms. Those structures include hash tables, queues,
> > > > > > stacks, and doubly-linked lists.
> > > > > > 
> > > > > > This is a minor compatibility-related release, fixing build issues with
> > > > > > FreeBSD and NetBSD. On Linux, only the test_perthreadlock fix could
> > > > > > change the result of make check (which could previously fail due to
> > > > > > non-initialized mutexes), but it does not impact anything installed on
> > > > > > the system.
> > > > > > 
> > > > > > Changelog:
> > > > > > 2012-06-01 Userspace RCU 0.7.3
> > > > > >         * Fix tests: make dist lib dependency
> > > > > >         * Update README for OS supported, tests dependency
> > > > > >         * Add CodingStyle to tarball
> > > > > >         * Add coding style document
> > > > > >         * Test fix: test_perthreadlock uninitialized mutex
> > > > > >         * tests: support FreeBSD short "time" args
> > > > > >         * freebsd 8.2 fix: define MAP_ANONYMOUS for compatibility
> > > > > > 
> > > > > > Project website: http://lttng.org/urcu
> > > > > > Download link: http://lttng.org/files/urcu/
> > > > > > 
> > > > > > 
> > > > > 
> > > > > --
> > > > > Gerhard Mack
> > > > > 
> > > > > gmack@innerfire.net
> > > > > 
> > > > > <>< As a computer, I find your faith in technology amusing.
> > > > 
> > > > 
> > > 
> > > --
> > > Gerhard Mack
> > > 
> > > gmack@innerfire.net
> > > 
> > > <>< As a computer, I find your faith in technology amusing.
> > 
> > 
> 
> --
> Gerhard Mack
> 
> gmack@innerfire.net
> 
> <>< As a computer, I find your faith in technology amusing.

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
