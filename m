From: "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: RCU consistency guarantees
Date: Fri, 6 Dec 2019 22:37:30 -0800
Message-ID: <20191207063730.GN2889__40921.0663101234$1575916624$gmane$org@paulmck-ThinkPad-P72>
References: <CAAKbDrdMRrhnSzpPBZLf3nNUDW4YZLPkZkTD5gNJu+A9rATkWA@mail.gmail.com>
 <194534011.751.1575629349181.JavaMail.zimbra@efficios.com>
 <CAAKbDreZ8NerP-jsxezOmN3rktVSAk1a=RJw2YQY83UpQRrXfQ@mail.gmail.com>
 <512711764.1078.1575647945136.JavaMail.zimbra@efficios.com>
 <20191206163052.GG2889@paulmck-ThinkPad-P72>
 <CAAKbDrfzbaPJcKQE7wsjPCgmxUMhcZshDptt=abtufbtCMp85g@mail.gmail.com>
Reply-To: paulmck@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by lists.lttng.org (Postfix) with ESMTPS id 47VKl03kFpz124g
 for <lttng-dev@lists.lttng.org>; Sat,  7 Dec 2019 01:47:23 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CAAKbDrfzbaPJcKQE7wsjPCgmxUMhcZshDptt=abtufbtCMp85g@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Yuxin Ren <ryx@gwmail.gwu.edu>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Fri, Dec 06, 2019 at 07:00:13PM -0500, Yuxin Ren wrote:
> Thanks so much for your great help.
> I definitely will look at those resources and papers!
> =

> One more thing that I am confused
> As I mentioned earlier, someone said One key distinction is that both MVCC
> and RLU provide much stronger consistency guarantees to readers than does
> RCU ...) (https://lwn.net/Articles/777036/).

That someone was in fact me.  ;-)

> I am not sure if the above statement is correct or not. But in general,
> How can we compare RCU consistency guarantees to other techniques (such as
> RLU)?
> How to reason about which one has stronger or weaker guarantees?

I suggest starting from the use case.  For concreteness, let's assume
that we are using a hash table.  At one extreme, imagine a use case in
which each event makes exactly one hash-table operation.  No information
is carried from one event to the next.  (This might well be the case
for simple web server.)  Such a use case cannot tell the difference
between RCU on the one hand and MVCC/RLU on the other.

At the other extreme, suppose that each event either accesses or updates
multiple entries in the hash table.  In this case, MVCC/RLU will rule
out outcomes that RCU would permit.  For example, suppose we had four
events accessing two different elements in different buckets of the
hash table:

	E1: Adds 32 to the hash table.
	E2: Adds 1729 to the hash table.
	E3: Within a read-side critical section, looks up 32 then 1729.
	E4: Within a read-side critical section, looks up 1729 then 32.

Given either MVCC or RLU, it will not be possible for E3 to find 32 but
not 1729 and at the same time for E4 to find 1729 but not 32.  Given RCU,
this outcome is possible.

This is because MVCC and RLU provide readers a consistent view of
the updates, and RCU does not.  Of course, it is often the case that a
consistent view is not needed, in which case the MVCC and RLU guarantees
are incurring read-side overhead for no reason.  But if the use case
requires consistent readers, RCU is not an option.

The reason a consistent view is not always needed is that speed-of-light
delays make it impossible to provide a consistent view of the outside
world.  In the common case where the use case interacts with the
outside world, the algorithms absolutely must be designed to tolerate
inconsistency, which opens the door to things like RCU.

							Thanx, Paul

> Thanks
> Yuxin
> =

> On Fri, Dec 6, 2019 at 11:30 AM Paul E. McKenney <paulmck@kernel.org> wro=
te:
> =

> > On Fri, Dec 06, 2019 at 10:59:05AM -0500, Mathieu Desnoyers wrote:
> > > ----- On Dec 6, 2019, at 3:51 PM, Yuxin Ren <ryx@gwmail.gwu.edu> wrot=
e:
> > >
> > > > On Fri, Dec 6, 2019 at 5:49 AM Mathieu Desnoyers < [
> > > > mailto:mathieu.desnoyers@efficios.com | mathieu.desnoyers@efficios.=
com
> > ] >
> > > > wrote:
> > >
> > > >> ----- On Dec 5, 2019, at 8:17 PM, Yuxin Ren < [ mailto:
> > ryx@gwmail.gwu.edu |
> > > >> ryx@gwmail.gwu.edu ] > wrote:
> > >
> > > >>> Hi,
> > > >>> I am a student, and learning RCU now, but still know very little
> > about it.
> > > >>> Are there any documents/papers/materials which (in)formally define
> > and explain
> > > >>> RCU consistency guarantees?
> > >
> > > >> You may want to have a look at
> > >
> > > >> User-Level Implementations of Read-Copy Update
> > > >> Article in IEEE Transactions on Parallel and Distributed Systems
> > 23(2):375 - 382
> > > >> =B7 March 2012
> > >
> > > > Thanks for your info.
> > > > However, I do not think URCU talks about any consistency model
> > formally.
> > >
> > > > From previous communication with Paul, he said RCU is not designed =
for
> > > > linearizability, and it is totally acceptable that RCU is not
> > linearizable.
> > > > However, I am curious how to accurately/formally Characterize RCU
> > consistency
> > > > model/guarantees
> > >
> > > Adding Paul E. McKenney in CC.
> > >
> > > I am referring to the section "Overview of RCU semantics" in the pape=
r.
> > Not sure it has the level of
> > > formality you are looking for though. Paul, do you have pointers to
> > additional material ?
> >
> > Indeed I do!  The Linux kernel memory model (LKMM) includes RCU.  It is
> > in tools/memory-model in recent kernel source trees, which includes
> > documentation.  This is an executable model, which means that you
> > can create litmus tests and have the model formally and automatically
> > evaluate them.
> >
> > There are also a number of publications covering LKMM:
> >
> > o       A formal kernel memory-ordering model
> >         https://lwn.net/Articles/718628/
> >         https://lwn.net/Articles/720550/
> >
> >         These cover the release stores and dependency ordering that
> >         provide RCU's publish-subscribe guarantees.
> >
> >         Backup material here:
> >
> >
> > https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/LWNLinu=
xMM/
> >
> >         With these two likely being of particular interest:
> >
> >
> > https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/LWNLinu=
xMM/RCUguarantees.html
> >
> > https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/LWNLinu=
xMM/srcu.html
> >
> > o       Frightening Small Children and Disconcerting Grown-ups:
> > Concurrency in the Linux Kernel
> >         https://dl.acm.org/citation.cfm?id=3D3177156
> >         http://www0.cs.ucl.ac.uk/staff/j.alglave/papers/asplos18.pdf
> >
> >         Backup material:
> >
> >         http://diy.inria.fr/linux/
> >
> > o       Who's afraid of a big bad optimizing compiler?
> >         https://lwn.net/Articles/793253/
> >
> > o       Calibrating your fear of big bad optimizing compilers
> >         https://lwn.net/Articles/799218/
> >
> >         These last two justify use of normal C-language assignment
> >         statements to initialize and access data referenced by
> >         RCU-protected pointers.
> >
> > There is a large body of litmus tests (thousands of them) here:
> >
> >         https://github.com/paulmckrcu/litmus
> >
> > Many of these litmus tests involve RCU, and these can be located by
> > search for files containing rcu_read_lock(), rcu_read_unlock(),
> > synchronize_rcu(), and so on.
> >
> > Or were you looking for something else?
> >
> >                                                         Thanx, Paul
> >
> > > Thanks,
> > >
> > > Mathieu
> > >
> > > >> as a starting point.
> > >
> > > >> Thanks,
> > >
> > > >> Mathieu
> > >
> > > >>> I know there are some consistency models in the database area (su=
ch
> > as PRAM,
> > > >>> Read Uncommitted, etc) from [ https://jepsen.io/consistency |
> > > >>> https://jepsen.io/consistency ] and [1].
> > > >>> How does RCU related to those consistency models?
> > >
> > > >>> I also found some comments online (One key distinction is that bo=
th
> > MVCC and RLU
> > > >>> provide much stronger consistency guarantees to readers than does
> > RCU ...) ( [
> > > >>> https://lwn.net/Articles/777036/ | https://lwn.net/Articles/77703=
6/
> > ] ).
> > > >>> I do not understand how we reason/dresibe/compare the consistency
> > guarantees. (
> > > >>> I even do not know what consistency guarantees provided by RCU
> > formally)
> > > >>> Could someone explain this to me?
> > >
> > > >>> [1] Bailis, P., Davidson, A., Fekete, A., Ghodsi, A., Hellerstein,
> > J. M., &
> > > >>> Stoica, I. (2013). Highly available transactions: Virtues and
> > limitations.
> > > >>> Proceedings of the VLDB Endowment, 7(3), 181-192.
> > >
> > > >>> Thanks
> > > >>> Yuxin
> > >
> > > >>> _______________________________________________
> > > >>> lttng-dev mailing list
> > > >>> [ mailto:lttng-dev@lists.lttng.org | lttng-dev@lists.lttng.org ]
> > > >>> [ https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev |
> > > >>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev ]
> > >
> > > >> --
> > > >> Mathieu Desnoyers
> > > >> EfficiOS Inc.
> > > >> [ http://www.efficios.com/ | http://www.efficios.com ]
> > >
> > > --
> > > Mathieu Desnoyers
> > > EfficiOS Inc.
> > > http://www.efficios.com
> >
