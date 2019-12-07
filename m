From: "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: RCU consistency guarantees
Date: Sat, 7 Dec 2019 14:42:32 -0800
Message-ID: <20191207224232.GR2889__41236.9331739441$1575916661$gmane$org@paulmck-ThinkPad-P72>
References: <CAAKbDrdMRrhnSzpPBZLf3nNUDW4YZLPkZkTD5gNJu+A9rATkWA@mail.gmail.com>
 <194534011.751.1575629349181.JavaMail.zimbra@efficios.com>
 <CAAKbDreZ8NerP-jsxezOmN3rktVSAk1a=RJw2YQY83UpQRrXfQ@mail.gmail.com>
 <512711764.1078.1575647945136.JavaMail.zimbra@efficios.com>
 <20191206163052.GG2889@paulmck-ThinkPad-P72>
 <CAAKbDrfzbaPJcKQE7wsjPCgmxUMhcZshDptt=abtufbtCMp85g@mail.gmail.com>
 <20191207063730.GN2889@paulmck-ThinkPad-P72>
 <CAAKbDre3N=RwTNeAqbr3MaA+zuioriLFasd85ZJsFr_pG_VApw@mail.gmail.com>
Reply-To: paulmck@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by lists.lttng.org (Postfix) with ESMTPS id 47Vkx60Mwlz12Yx
 for <lttng-dev@lists.lttng.org>; Sat,  7 Dec 2019 17:42:33 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CAAKbDre3N=RwTNeAqbr3MaA+zuioriLFasd85ZJsFr_pG_VApw@mail.gmail.com>
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

On Sat, Dec 07, 2019 at 03:04:42PM -0500, Yuxin Ren wrote:
> Thanks a lot for your help. I have some questions below.
> =

> On Sat, Dec 7, 2019 at 1:37 AM Paul E. McKenney <paulmck@kernel.org> wrot=
e:
> =

> > On Fri, Dec 06, 2019 at 07:00:13PM -0500, Yuxin Ren wrote:
> > > Thanks so much for your great help.
> > > I definitely will look at those resources and papers!
> > >
> > > One more thing that I am confused
> > > As I mentioned earlier, someone said One key distinction is that both
> > MVCC
> > > and RLU provide much stronger consistency guarantees to readers than =
does
> > > RCU ...) (https://lwn.net/Articles/777036/).
> >
> > That someone was in fact me.  ;-)
> >
> > > I am not sure if the above statement is correct or not. But in genera=
l,
> > > How can we compare RCU consistency guarantees to other techniques (su=
ch
> > as
> > > RLU)?
> > > How to reason about which one has stronger or weaker guarantees?
> >
> > I suggest starting from the use case.  For concreteness, let's assume
> > that we are using a hash table.  At one extreme, imagine a use case in
> > which each event makes exactly one hash-table operation.  No information
> > is carried from one event to the next.  (This might well be the case
> > for simple web server.)  Such a use case cannot tell the difference
> > between RCU on the one hand and MVCC/RLU on the other.
> >
> > At the other extreme, suppose that each event either accesses or updates
> > multiple entries in the hash table.  In this case, MVCC/RLU will rule
> > out outcomes that RCU would permit.  For example, suppose we had four
> > events accessing two different elements in different buckets of the
> > hash table:
> >
> >         E1: Adds 32 to the hash table.
> >         E2: Adds 1729 to the hash table.
> >         E3: Within a read-side critical section, looks up 32 then 1729.
> >         E4: Within a read-side critical section, looks up 1729 then 32.
> >
> > Given either MVCC or RLU, it will not be possible for E3 to find 32 but
> > not 1729 and at the same time for E4 to find 1729 but not 32.  Given RC=
U,
> > this outcome is possible.
> >
> When you say "Within a read-side section", do you mean within a single sa=
me
> read section? such as
> =

> > read_lock()
> > lookup(32)
> > lookup(1729)
> > read_unlock()
> =

> =

> How about putting two lookups into two read-side sections? Do we still ha=
ve
> the problem, then?
> =

> > read_lock()
> > lookup(32)
> > read_unlock()
> > read_lock()
> > lookup(1729)
> > read_unlock()

Without in any way agreeing with your characterization of this as a
problem, because rcu_read_lock() and rcu_read_unlock() provide
absolutely no ordering guarantees in the absence of a grace period,
any non-grace-period-related reordering that can happen with a single
RCU read-side critical section can also happen when that critical
section is split in two as you have done above.

> Could you kindly give me more clues why RCU can see such reorder, while R=
LU
> can prevent it?

Here are minimal C-language implementations for RCU that can (and are)
actually used:

#define rcu_read_lock()
#define rcu_read_unlock()

Please compare these to the read-side markers presented in the RLU paper,
and then tell me your thoughts on the answer to your question.  ;-)

> > This is because MVCC and RLU provide readers a consistent view of
> > the updates, and RCU does not.  Of course, it is often the case that a
> > consistent view is not needed, in which case the MVCC and RLU guarantees
> > are incurring read-side overhead for no reason.  But if the use case
> > requires consistent readers, RCU is not an option.
> >
> > The reason a consistent view is not always needed is that speed-of-light
> > delays make it impossible to provide a consistent view of the outside
> > world.  In the common case where the use case interacts with the
> > outside world, the algorithms absolutely must be designed to tolerate
> > inconsistency, which opens the door to things like RCU.
> =

> I am confused here. I think speed-of-light delays happen everywhere, not
> only bound to RCU, but also  any other synchronization approach (such RLU=
).
> If so, how do others (RLU) provide consistent views?

You just stated the answer.  Now it is only necessary for you to invest
the time, effort, and thought to fully understand it.  To help with this,
the following paragraph provides another hint:

	Yes, you are quite right, speed-of-light delays between the
	outside world and the computer affect RLU just as surely as they
	do RCU.  This means that the additional consistency guarantees
	provided by RLU must necessarily be limited to the confines of the
	computer system in question.  Taking this one step further, there
	are also speed-of-light delays within the computer.  Therefore,
	in the general case, RLU can provide its consistency guarantees,
	even within the confines of the computer system, only at the
	expense of incurring delays.  Because RCU does not provide RLU's
	consistency guarantees, it need not incur RLU's delays.

This is not a new line of reasoning, see for example:

@article{Herlihy:1996:LCN:1063369.1063372
,author =3D {Herlihy, Maurice and Shavit, Nir and Waarts, Orli}
,title =3D {Linearizable counting networks}
,journal =3D {Distrib. Comput.}
,volume =3D {9}
,issue =3D {4}
,month =3D {February}
,year =3D {1996}
,issn =3D {0178-2770}
,pages =3D {193--203}
,numpages =3D {11}
,url =3D {http://portal.acm.org/citation.cfm?id=3D1063369.1063372}
,doi =3D {10.1007/s004460050019}
,acmid =3D {1063372}
,publisher =3D {Springer-Verlag}
,address =3D {London, UK}
,keywords =3D {concurrency, contention, counting networks, data structures,=
 linearizability}
}

							Thanx, Paul

> Thanks for your education.
> Yuxin
> =

> >
> >                                                         Thanx, Paul
> >
> > > Thanks
> > > Yuxin
> > >
> > > On Fri, Dec 6, 2019 at 11:30 AM Paul E. McKenney <paulmck@kernel.org>
> > wrote:
> > >
> > > > On Fri, Dec 06, 2019 at 10:59:05AM -0500, Mathieu Desnoyers wrote:
> > > > > ----- On Dec 6, 2019, at 3:51 PM, Yuxin Ren <ryx@gwmail.gwu.edu>
> > wrote:
> > > > >
> > > > > > On Fri, Dec 6, 2019 at 5:49 AM Mathieu Desnoyers < [
> > > > > > mailto:mathieu.desnoyers@efficios.com |
> > mathieu.desnoyers@efficios.com
> > > > ] >
> > > > > > wrote:
> > > > >
> > > > > >> ----- On Dec 5, 2019, at 8:17 PM, Yuxin Ren < [ mailto:
> > > > ryx@gwmail.gwu.edu |
> > > > > >> ryx@gwmail.gwu.edu ] > wrote:
> > > > >
> > > > > >>> Hi,
> > > > > >>> I am a student, and learning RCU now, but still know very lit=
tle
> > > > about it.
> > > > > >>> Are there any documents/papers/materials which (in)formally
> > define
> > > > and explain
> > > > > >>> RCU consistency guarantees?
> > > > >
> > > > > >> You may want to have a look at
> > > > >
> > > > > >> User-Level Implementations of Read-Copy Update
> > > > > >> Article in IEEE Transactions on Parallel and Distributed Syste=
ms
> > > > 23(2):375 - 382
> > > > > >> =B7 March 2012
> > > > >
> > > > > > Thanks for your info.
> > > > > > However, I do not think URCU talks about any consistency model
> > > > formally.
> > > > >
> > > > > > From previous communication with Paul, he said RCU is not desig=
ned
> > for
> > > > > > linearizability, and it is totally acceptable that RCU is not
> > > > linearizable.
> > > > > > However, I am curious how to accurately/formally Characterize R=
CU
> > > > consistency
> > > > > > model/guarantees
> > > > >
> > > > > Adding Paul E. McKenney in CC.
> > > > >
> > > > > I am referring to the section "Overview of RCU semantics" in the
> > paper.
> > > > Not sure it has the level of
> > > > > formality you are looking for though. Paul, do you have pointers =
to
> > > > additional material ?
> > > >
> > > > Indeed I do!  The Linux kernel memory model (LKMM) includes RCU.  I=
t is
> > > > in tools/memory-model in recent kernel source trees, which includes
> > > > documentation.  This is an executable model, which means that you
> > > > can create litmus tests and have the model formally and automatical=
ly
> > > > evaluate them.
> > > >
> > > > There are also a number of publications covering LKMM:
> > > >
> > > > o       A formal kernel memory-ordering model
> > > >         https://lwn.net/Articles/718628/
> > > >         https://lwn.net/Articles/720550/
> > > >
> > > >         These cover the release stores and dependency ordering that
> > > >         provide RCU's publish-subscribe guarantees.
> > > >
> > > >         Backup material here:
> > > >
> > > >
> > > >
> > https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/LWNLinu=
xMM/
> > > >
> > > >         With these two likely being of particular interest:
> > > >
> > > >
> > > >
> > https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/LWNLinu=
xMM/RCUguarantees.html
> > > >
> > > >
> > https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/LWNLinu=
xMM/srcu.html
> > > >
> > > > o       Frightening Small Children and Disconcerting Grown-ups:
> > > > Concurrency in the Linux Kernel
> > > >         https://dl.acm.org/citation.cfm?id=3D3177156
> > > >         http://www0.cs.ucl.ac.uk/staff/j.alglave/papers/asplos18.pdf
> > > >
> > > >         Backup material:
> > > >
> > > >         http://diy.inria.fr/linux/
> > > >
> > > > o       Who's afraid of a big bad optimizing compiler?
> > > >         https://lwn.net/Articles/793253/
> > > >
> > > > o       Calibrating your fear of big bad optimizing compilers
> > > >         https://lwn.net/Articles/799218/
> > > >
> > > >         These last two justify use of normal C-language assignment
> > > >         statements to initialize and access data referenced by
> > > >         RCU-protected pointers.
> > > >
> > > > There is a large body of litmus tests (thousands of them) here:
> > > >
> > > >         https://github.com/paulmckrcu/litmus
> > > >
> > > > Many of these litmus tests involve RCU, and these can be located by
> > > > search for files containing rcu_read_lock(), rcu_read_unlock(),
> > > > synchronize_rcu(), and so on.
> > > >
> > > > Or were you looking for something else?
> > > >
> > > >                                                         Thanx, Paul
> > > >
> > > > > Thanks,
> > > > >
> > > > > Mathieu
> > > > >
> > > > > >> as a starting point.
> > > > >
> > > > > >> Thanks,
> > > > >
> > > > > >> Mathieu
> > > > >
> > > > > >>> I know there are some consistency models in the database area
> > (such
> > > > as PRAM,
> > > > > >>> Read Uncommitted, etc) from [ https://jepsen.io/consistency |
> > > > > >>> https://jepsen.io/consistency ] and [1].
> > > > > >>> How does RCU related to those consistency models?
> > > > >
> > > > > >>> I also found some comments online (One key distinction is that
> > both
> > > > MVCC and RLU
> > > > > >>> provide much stronger consistency guarantees to readers than =
does
> > > > RCU ...) ( [
> > > > > >>> https://lwn.net/Articles/777036/ |
> > https://lwn.net/Articles/777036/
> > > > ] ).
> > > > > >>> I do not understand how we reason/dresibe/compare the consist=
ency
> > > > guarantees. (
> > > > > >>> I even do not know what consistency guarantees provided by RCU
> > > > formally)
> > > > > >>> Could someone explain this to me?
> > > > >
> > > > > >>> [1] Bailis, P., Davidson, A., Fekete, A., Ghodsi, A.,
> > Hellerstein,
> > > > J. M., &
> > > > > >>> Stoica, I. (2013). Highly available transactions: Virtues and
> > > > limitations.
> > > > > >>> Proceedings of the VLDB Endowment, 7(3), 181-192.
> > > > >
> > > > > >>> Thanks
> > > > > >>> Yuxin
> > > > >
> > > > > >>> _______________________________________________
> > > > > >>> lttng-dev mailing list
> > > > > >>> [ mailto:lttng-dev@lists.lttng.org | lttng-dev@lists.lttng.or=
g ]
> > > > > >>> [ https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev |
> > > > > >>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev ]
> > > > >
> > > > > >> --
> > > > > >> Mathieu Desnoyers
> > > > > >> EfficiOS Inc.
> > > > > >> [ http://www.efficios.com/ | http://www.efficios.com ]
> > > > >
> > > > > --
> > > > > Mathieu Desnoyers
> > > > > EfficiOS Inc.
> > > > > http://www.efficios.com
> > > >
> >
