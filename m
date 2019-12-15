From: Yuxin Ren <ryx@gwmail.gwu.edu>
Subject: Re: RCU consistency guarantees
Date: Sun, 15 Dec 2019 17:10:11 -0500
Message-ID: <CAAKbDrfUGrL=Yz=mf4B1Wij3XkxgTwY-4HNB4+XJKdRGK1T2BQ__19515.0897650578$1576447860$gmane$org@mail.gmail.com>
References: <CAAKbDrdMRrhnSzpPBZLf3nNUDW4YZLPkZkTD5gNJu+A9rATkWA@mail.gmail.com>
 <194534011.751.1575629349181.JavaMail.zimbra@efficios.com>
 <CAAKbDreZ8NerP-jsxezOmN3rktVSAk1a=RJw2YQY83UpQRrXfQ@mail.gmail.com>
 <512711764.1078.1575647945136.JavaMail.zimbra@efficios.com>
 <20191206163052.GG2889@paulmck-ThinkPad-P72>
 <CAAKbDrfzbaPJcKQE7wsjPCgmxUMhcZshDptt=abtufbtCMp85g@mail.gmail.com>
 <20191207063730.GN2889@paulmck-ThinkPad-P72>
 <CAAKbDre3N=RwTNeAqbr3MaA+zuioriLFasd85ZJsFr_pG_VApw@mail.gmail.com>
 <20191207224232.GR2889@paulmck-ThinkPad-P72>
 <CAAKbDrd5s06mnPYU_dwO1+dtySewm80ukaaEqJiJ0RtkFe-38w@mail.gmail.com>
 <20191215203019.GN2889@paulmck-ThinkPad-P72>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0938664408393169190=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 by lists.lttng.org (Postfix) with ESMTPS id 47bdrY0mx4z19MT
 for <lttng-dev@lists.lttng.org>; Sun, 15 Dec 2019 17:10:36 -0500 (EST)
Received: by mail-lf1-x132.google.com with SMTP id y19so2821180lfl.9
 for <lttng-dev@lists.lttng.org>; Sun, 15 Dec 2019 14:10:36 -0800 (PST)
In-Reply-To: <20191215203019.GN2889@paulmck-ThinkPad-P72>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: paulmck@kernel.org
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0938664408393169190==
Content-Type: multipart/alternative; boundary="0000000000003b8c6b0599c55dcd"

--0000000000003b8c6b0599c55dcd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 15, 2019 at 3:30 PM Paul E. McKenney <paulmck@kernel.org> wrote=
:

> On Sat, Dec 14, 2019 at 01:31:31AM -0500, Yuxin Ren wrote:
> > Hi Paul
> >
> > On Sat, Dec 7, 2019 at 5:42 PM Paul E. McKenney <paulmck@kernel.org>
> wrote:
> >
> > > On Sat, Dec 07, 2019 at 03:04:42PM -0500, Yuxin Ren wrote:
> > > > Thanks a lot for your help. I have some questions below.
> > > >
> > > > On Sat, Dec 7, 2019 at 1:37 AM Paul E. McKenney <paulmck@kernel.org=
>
> > > wrote:
> > > >
> > > > > On Fri, Dec 06, 2019 at 07:00:13PM -0500, Yuxin Ren wrote:
> > > > > > Thanks so much for your great help.
> > > > > > I definitely will look at those resources and papers!
> > > > > >
> > > > > > One more thing that I am confused
> > > > > > As I mentioned earlier, someone said One key distinction is tha=
t
> both
> > > > > MVCC
> > > > > > and RLU provide much stronger consistency guarantees to readers
> than
> > > does
> > > > > > RCU ...) (https://lwn.net/Articles/777036/).
> > > > >
> > > > > That someone was in fact me.  ;-)
> > > > >
> > > > > > I am not sure if the above statement is correct or not. But in
> > > general,
> > > > > > How can we compare RCU consistency guarantees to other techniqu=
es
> > > (such
> > > > > as
> > > > > > RLU)?
> > > > > > How to reason about which one has stronger or weaker guarantees=
?
> > > > >
> > > > > I suggest starting from the use case.  For concreteness, let's
> assume
> > > > > that we are using a hash table.  At one extreme, imagine a use
> case in
> > > > > which each event makes exactly one hash-table operation.  No
> > > information
> > > > > is carried from one event to the next.  (This might well be the
> case
> > > > > for simple web server.)  Such a use case cannot tell the differen=
ce
> > > > > between RCU on the one hand and MVCC/RLU on the other.
> > > > >
> > > > > At the other extreme, suppose that each event either accesses or
> > > updates
> > > > > multiple entries in the hash table.  In this case, MVCC/RLU will
> rule
> > > > > out outcomes that RCU would permit.  For example, suppose we had
> four
> > > > > events accessing two different elements in different buckets of t=
he
> > > > > hash table:
> > > > >
> > > > >         E1: Adds 32 to the hash table.
> > > > >         E2: Adds 1729 to the hash table.
> > > > >         E3: Within a read-side critical section, looks up 32 then
> 1729.
> > > > >         E4: Within a read-side critical section, looks up 1729
> then 32.
> > > > >
> > > > > Given either MVCC or RLU, it will not be possible for E3 to find
> 32 but
> > > > > not 1729 and at the same time for E4 to find 1729 but not 32.
> Given
> > > RCU,
> > > > > this outcome is possible.
> > > > >
> > > > When you say "Within a read-side section", do you mean within a
> single
> > > same
> > > > read section? such as
> > > >
> > > > > read_lock()
> > > > > lookup(32)
> > > > > lookup(1729)
> > > > > read_unlock()
> > > >
> > > >
> > > > How about putting two lookups into two read-side sections? Do we
> still
> > > have
> > > > the problem, then?
> > > >
> > > > > read_lock()
> > > > > lookup(32)
> > > > > read_unlock()
> > > > > read_lock()
> > > > > lookup(1729)
> > > > > read_unlock()
> > >
> > > Without in any way agreeing with your characterization of this as a
> > > problem, because rcu_read_lock() and rcu_read_unlock() provide
> > > absolutely no ordering guarantees in the absence of a grace period,
> > > any non-grace-period-related reordering that can happen with a single
> > > RCU read-side critical section can also happen when that critical
> > > section is split in two as you have done above.
> > >
> > > > Could you kindly give me more clues why RCU can see such reorder,
> while
> > > RLU
> > > > can prevent it?
> > >
> > > Here are minimal C-language implementations for RCU that can (and are=
)
> > > actually used:
> > >
> > Great. We use the same thing in our real-time work [1]
>
> It has been a popular choice for 40 years now.  ;-)
>
> > > #define rcu_read_lock()
> > > #define rcu_read_unlock()
> > >
> > > Please compare these to the read-side markers presented in the RLU
> paper,
> > > and then tell me your thoughts on the answer to your question.  ;-)
> > >
> > I submit my homework here, but I do not think I did it well.
> > 1. I believe in the default URCU implementation, it has memory barrier
> > inside the read_lock / read_unlock.
>
> It certainly was at one time.  But you would of course need to check
> to see what any given worker actually used.
>
> > 2. From the RLU paper, it shows the code for read-side operation.
> > RLU_READER_LOCK(ctx)
> >     ctx.is-writer=E2=86=90false
> >     ctx.run-cnt=E2=86=90ctx.run-cnt+1.
> >     memory fence
> >    ctx.local-clock=E2=86=90global-clock
> > RLU_READER_UNLOCK(ctx)
> >     ctx.run-cnt=E2=86=90ctx.run-cnt+1
> >     if (ctx.is-writer)
> >         RLU_COMMIT_WRITE_LOG(ctx)
> >
> > We can ignore the writer check, as in our case, the reader never do
> update.
> > My understanding is that read-side operations are only used to facilita=
te
> > the quiescence detection.
> > the run cnt is used to decide if a thread is active (if it is currently
> > inside a read-side section).
> > the local clock is used to check if the active thread goes into the
> > read-side section very late, so it does not prevent reclaiming memory
> > unlinked before it enters the read section.
> > However i see no difference between RLU and RCU read-side operation
> > regarding consistency guarantee.
> > Could you kindly teach me more?
>
> In order to teach you more, I do need some help from you.  I have posted
> a number of URLs earlier in this email thread.  Could you please tell
> me what you learned from each of them?
>
Sure, I will definitely learn those resources you provided, and come back
to you if I have more questions.
Simply speaking, I failed to find a clear and formal consistency
model/guarantee of RCU quickly.
The difficulty for me is, for most people, at their first glance, RCU only
has relax/weak consistency guarantee.
So whenever I suggest to use RCU to others, they always ask like
Does RCU provide Serializability? .. maybe not.
Does RCU provide Linearizability? ... maybe not
...
OK, what does RCU provide?  .. I am not sure. I even cannot find a single
document which has an accurate answer.

Let me give more examples.
1. When I recommend using read-write lock, people are happy to use it.
    However, when I further suggest to replace rw lock with RCU, then they
hesitate to do so. Because they feel RCU is weaker than rw lock, and do not
know what precisely RCU guarantee.
2. In contrast, in the database area, it has relative clear definition of
consistency levels (such as https://jepsen.io/consistency), and users are
easy to assert if they can use certain database configuration based on its
consistency model.

Again, I really appreciate your patience and communication, hope those does
not bother you a lot.

Thanks
Best,
Yuxin

>
>                                                                 Thanx, Pa=
ul
>
> > BTW, the RLU read-side ops are similar, but not efficient, comparing to
> our
> > Parsec work [1, 2]
> > [1] Yuxin Ren, G. Liu, G. Parmer, B. Brandenburg, Scalable Memory
> > Reclamation for Multi-Core, Real-Time Systems, in Proceedings of the 24=
th
> > IEEE Real-Time and Embedded Technology and Applications Symposium (RTAS=
),
> > 2018
> > [2] Q. Wang, T. Stamler, and G. Parmer, Parallel Sections: Scaling
> > System-Level Data-Structures, in Proceedings of European Conference on
> > Computer Systems (EuroSys), 2016
> >
> > Thanks,
> > Best,
> > Yuxin
> >
> >
> > > > This is because MVCC and RLU provide readers a consistent view of
> > > > > the updates, and RCU does not.  Of course, it is often the case
> that a
> > > > > consistent view is not needed, in which case the MVCC and RLU
> > > guarantees
> > > > > are incurring read-side overhead for no reason.  But if the use
> case
> > > > > requires consistent readers, RCU is not an option.
> > > > >
> > > > > The reason a consistent view is not always needed is that
> > > speed-of-light
> > > > > delays make it impossible to provide a consistent view of the
> outside
> > > > > world.  In the common case where the use case interacts with the
> > > > > outside world, the algorithms absolutely must be designed to
> tolerate
> > > > > inconsistency, which opens the door to things like RCU.
> > > >
> > > > I am confused here. I think speed-of-light delays happen everywhere=
,
> not
> > > > only bound to RCU, but also  any other synchronization approach (su=
ch
> > > RLU).
> > > > If so, how do others (RLU) provide consistent views?
> > >
> > > You just stated the answer.  Now it is only necessary for you to inve=
st
> > > the time, effort, and thought to fully understand it.  To help with
> this,
> > > the following paragraph provides another hint:
> > >
> > >         Yes, you are quite right, speed-of-light delays between the
> > >         outside world and the computer affect RLU just as surely as
> they
> > >         do RCU.  This means that the additional consistency guarantee=
s
> > >         provided by RLU must necessarily be limited to the confines o=
f
> the
> > >         computer system in question.  Taking this one step further,
> there
> > >         are also speed-of-light delays within the computer.  Therefor=
e,
> > >         in the general case, RLU can provide its consistency
> guarantees,
> > >         even within the confines of the computer system, only at the
> > >         expense of incurring delays.  Because RCU does not provide
> RLU's
> > >         consistency guarantees, it need not incur RLU's delays.
> > >
> > > This is not a new line of reasoning, see for example:
> > >
> > > @article{Herlihy:1996:LCN:1063369.1063372
> > > ,author =3D {Herlihy, Maurice and Shavit, Nir and Waarts, Orli}
> > > ,title =3D {Linearizable counting networks}
> > > ,journal =3D {Distrib. Comput.}
> > > ,volume =3D {9}
> > > ,issue =3D {4}
> > > ,month =3D {February}
> > > ,year =3D {1996}
> > > ,issn =3D {0178-2770}
> > > ,pages =3D {193--203}
> > > ,numpages =3D {11}
> > > ,url =3D {http://portal.acm.org/citation.cfm?id=3D1063369.1063372}
> > > ,doi =3D {10.1007/s004460050019}
> > > ,acmid =3D {1063372}
> > > ,publisher =3D {Springer-Verlag}
> > > ,address =3D {London, UK}
> > > ,keywords =3D {concurrency, contention, counting networks, data
> structures,
> > > linearizability}
> > > }
> > >
> > >                                                         Thanx, Paul
> > >
> > > > Thanks for your education.
> > > > Yuxin
> > > >
> > > > >
> > > > >                                                         Thanx, Pa=
ul
> > > > >
> > > > > > Thanks
> > > > > > Yuxin
> > > > > >
> > > > > > On Fri, Dec 6, 2019 at 11:30 AM Paul E. McKenney <
> paulmck@kernel.org
> > > >
> > > > > wrote:
> > > > > >
> > > > > > > On Fri, Dec 06, 2019 at 10:59:05AM -0500, Mathieu Desnoyers
> wrote:
> > > > > > > > ----- On Dec 6, 2019, at 3:51 PM, Yuxin Ren <
> ryx@gwmail.gwu.edu>
> > > > > wrote:
> > > > > > > >
> > > > > > > > > On Fri, Dec 6, 2019 at 5:49 AM Mathieu Desnoyers < [
> > > > > > > > > mailto:mathieu.desnoyers@efficios.com |
> > > > > mathieu.desnoyers@efficios.com
> > > > > > > ] >
> > > > > > > > > wrote:
> > > > > > > >
> > > > > > > > >> ----- On Dec 5, 2019, at 8:17 PM, Yuxin Ren < [ mailto:
> > > > > > > ryx@gwmail.gwu.edu |
> > > > > > > > >> ryx@gwmail.gwu.edu ] > wrote:
> > > > > > > >
> > > > > > > > >>> Hi,
> > > > > > > > >>> I am a student, and learning RCU now, but still know ve=
ry
> > > little
> > > > > > > about it.
> > > > > > > > >>> Are there any documents/papers/materials which
> (in)formally
> > > > > define
> > > > > > > and explain
> > > > > > > > >>> RCU consistency guarantees?
> > > > > > > >
> > > > > > > > >> You may want to have a look at
> > > > > > > >
> > > > > > > > >> User-Level Implementations of Read-Copy Update
> > > > > > > > >> Article in IEEE Transactions on Parallel and Distributed
> > > Systems
> > > > > > > 23(2):375 - 382
> > > > > > > > >> =C2=B7 March 2012
> > > > > > > >
> > > > > > > > > Thanks for your info.
> > > > > > > > > However, I do not think URCU talks about any consistency
> model
> > > > > > > formally.
> > > > > > > >
> > > > > > > > > From previous communication with Paul, he said RCU is not
> > > designed
> > > > > for
> > > > > > > > > linearizability, and it is totally acceptable that RCU is
> not
> > > > > > > linearizable.
> > > > > > > > > However, I am curious how to accurately/formally
> Characterize
> > > RCU
> > > > > > > consistency
> > > > > > > > > model/guarantees
> > > > > > > >
> > > > > > > > Adding Paul E. McKenney in CC.
> > > > > > > >
> > > > > > > > I am referring to the section "Overview of RCU semantics" i=
n
> the
> > > > > paper.
> > > > > > > Not sure it has the level of
> > > > > > > > formality you are looking for though. Paul, do you have
> pointers
> > > to
> > > > > > > additional material ?
> > > > > > >
> > > > > > > Indeed I do!  The Linux kernel memory model (LKMM) includes
> RCU.
> > > It is
> > > > > > > in tools/memory-model in recent kernel source trees, which
> includes
> > > > > > > documentation.  This is an executable model, which means that
> you
> > > > > > > can create litmus tests and have the model formally and
> > > automatically
> > > > > > > evaluate them.
> > > > > > >
> > > > > > > There are also a number of publications covering LKMM:
> > > > > > >
> > > > > > > o       A formal kernel memory-ordering model
> > > > > > >         https://lwn.net/Articles/718628/
> > > > > > >         https://lwn.net/Articles/720550/
> > > > > > >
> > > > > > >         These cover the release stores and dependency orderin=
g
> that
> > > > > > >         provide RCU's publish-subscribe guarantees.
> > > > > > >
> > > > > > >         Backup material here:
> > > > > > >
> > > > > > >
> > > > > > >
> > > > >
> > >
> https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/LWNLinuxM=
M/
> > > > > > >
> > > > > > >         With these two likely being of particular interest:
> > > > > > >
> > > > > > >
> > > > > > >
> > > > >
> > >
> https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/LWNLinuxM=
M/RCUguarantees.html
> > > > > > >
> > > > > > >
> > > > >
> > >
> https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/LWNLinuxM=
M/srcu.html
> > > > > > >
> > > > > > > o       Frightening Small Children and Disconcerting Grown-up=
s:
> > > > > > > Concurrency in the Linux Kernel
> > > > > > >         https://dl.acm.org/citation.cfm?id=3D3177156
> > > > > > >
> > > http://www0.cs.ucl.ac.uk/staff/j.alglave/papers/asplos18.pdf
> > > > > > >
> > > > > > >         Backup material:
> > > > > > >
> > > > > > >         http://diy.inria.fr/linux/
> > > > > > >
> > > > > > > o       Who's afraid of a big bad optimizing compiler?
> > > > > > >         https://lwn.net/Articles/793253/
> > > > > > >
> > > > > > > o       Calibrating your fear of big bad optimizing compilers
> > > > > > >         https://lwn.net/Articles/799218/
> > > > > > >
> > > > > > >         These last two justify use of normal C-language
> assignment
> > > > > > >         statements to initialize and access data referenced b=
y
> > > > > > >         RCU-protected pointers.
> > > > > > >
> > > > > > > There is a large body of litmus tests (thousands of them) her=
e:
> > > > > > >
> > > > > > >         https://github.com/paulmckrcu/litmus
> > > > > > >
> > > > > > > Many of these litmus tests involve RCU, and these can be
> located by
> > > > > > > search for files containing rcu_read_lock(), rcu_read_unlock(=
),
> > > > > > > synchronize_rcu(), and so on.
> > > > > > >
> > > > > > > Or were you looking for something else?
> > > > > > >
> > > > > > >                                                         Thanx=
,
> Paul
> > > > > > >
> > > > > > > > Thanks,
> > > > > > > >
> > > > > > > > Mathieu
> > > > > > > >
> > > > > > > > >> as a starting point.
> > > > > > > >
> > > > > > > > >> Thanks,
> > > > > > > >
> > > > > > > > >> Mathieu
> > > > > > > >
> > > > > > > > >>> I know there are some consistency models in the databas=
e
> area
> > > > > (such
> > > > > > > as PRAM,
> > > > > > > > >>> Read Uncommitted, etc) from [
> https://jepsen.io/consistency
> > > |
> > > > > > > > >>> https://jepsen.io/consistency ] and [1].
> > > > > > > > >>> How does RCU related to those consistency models?
> > > > > > > >
> > > > > > > > >>> I also found some comments online (One key distinction =
is
> > > that
> > > > > both
> > > > > > > MVCC and RLU
> > > > > > > > >>> provide much stronger consistency guarantees to readers
> than
> > > does
> > > > > > > RCU ...) ( [
> > > > > > > > >>> https://lwn.net/Articles/777036/ |
> > > > > https://lwn.net/Articles/777036/
> > > > > > > ] ).
> > > > > > > > >>> I do not understand how we reason/dresibe/compare the
> > > consistency
> > > > > > > guarantees. (
> > > > > > > > >>> I even do not know what consistency guarantees provided
> by
> > > RCU
> > > > > > > formally)
> > > > > > > > >>> Could someone explain this to me?
> > > > > > > >
> > > > > > > > >>> [1] Bailis, P., Davidson, A., Fekete, A., Ghodsi, A.,
> > > > > Hellerstein,
> > > > > > > J. M., &
> > > > > > > > >>> Stoica, I. (2013). Highly available transactions:
> Virtues and
> > > > > > > limitations.
> > > > > > > > >>> Proceedings of the VLDB Endowment, 7(3), 181-192.
> > > > > > > >
> > > > > > > > >>> Thanks
> > > > > > > > >>> Yuxin
> > > > > > > >
> > > > > > > > >>> _______________________________________________
> > > > > > > > >>> lttng-dev mailing list
> > > > > > > > >>> [ mailto:lttng-dev@lists.lttng.org |
> > > lttng-dev@lists.lttng.org ]
> > > > > > > > >>> [
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> > > |
> > > > > > > > >>>
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev ]
> > > > > > > >
> > > > > > > > >> --
> > > > > > > > >> Mathieu Desnoyers
> > > > > > > > >> EfficiOS Inc.
> > > > > > > > >> [ http://www.efficios.com/ | http://www.efficios.com ]
> > > > > > > >
> > > > > > > > --
> > > > > > > > Mathieu Desnoyers
> > > > > > > > EfficiOS Inc.
> > > > > > > > http://www.efficios.com
> > > > > > >
> > > > >
> > >
>

--0000000000003b8c6b0599c55dcd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sun, Dec 15, 2019 at 3:30 PM Paul =
E. McKenney &lt;<a href=3D"mailto:paulmck@kernel.org" target=3D"_blank">pau=
lmck@kernel.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">On Sat, Dec 14, 2019 at 01:31:31AM -0500, Yuxin Ren wrote:<b=
r>
&gt; Hi Paul<br>
&gt; <br>
&gt; On Sat, Dec 7, 2019 at 5:42 PM Paul E. McKenney &lt;<a href=3D"mailto:=
paulmck@kernel.org" target=3D"_blank">paulmck@kernel.org</a>&gt; wrote:<br>
&gt; <br>
&gt; &gt; On Sat, Dec 07, 2019 at 03:04:42PM -0500, Yuxin Ren wrote:<br>
&gt; &gt; &gt; Thanks a lot for your help. I have some questions below.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; On Sat, Dec 7, 2019 at 1:37 AM Paul E. McKenney &lt;<a href=
=3D"mailto:paulmck@kernel.org" target=3D"_blank">paulmck@kernel.org</a>&gt;=
<br>
&gt; &gt; wrote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; On Fri, Dec 06, 2019 at 07:00:13PM -0500, Yuxin Ren wro=
te:<br>
&gt; &gt; &gt; &gt; &gt; Thanks so much for your great help.<br>
&gt; &gt; &gt; &gt; &gt; I definitely will look at those resources and pape=
rs!<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; One more thing that I am confused<br>
&gt; &gt; &gt; &gt; &gt; As I mentioned earlier, someone said One key disti=
nction is that both<br>
&gt; &gt; &gt; &gt; MVCC<br>
&gt; &gt; &gt; &gt; &gt; and RLU provide much stronger consistency guarante=
es to readers than<br>
&gt; &gt; does<br>
&gt; &gt; &gt; &gt; &gt; RCU ...) (<a href=3D"https://lwn.net/Articles/7770=
36/" rel=3D"noreferrer" target=3D"_blank">https://lwn.net/Articles/777036/<=
/a>).<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; That someone was in fact me.=C2=A0 ;-)<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; I am not sure if the above statement is correct or=
 not. But in<br>
&gt; &gt; general,<br>
&gt; &gt; &gt; &gt; &gt; How can we compare RCU consistency guarantees to o=
ther techniques<br>
&gt; &gt; (such<br>
&gt; &gt; &gt; &gt; as<br>
&gt; &gt; &gt; &gt; &gt; RLU)?<br>
&gt; &gt; &gt; &gt; &gt; How to reason about which one has stronger or weak=
er guarantees?<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; I suggest starting from the use case.=C2=A0 For concret=
eness, let&#39;s assume<br>
&gt; &gt; &gt; &gt; that we are using a hash table.=C2=A0 At one extreme, i=
magine a use case in<br>
&gt; &gt; &gt; &gt; which each event makes exactly one hash-table operation=
.=C2=A0 No<br>
&gt; &gt; information<br>
&gt; &gt; &gt; &gt; is carried from one event to the next.=C2=A0 (This migh=
t well be the case<br>
&gt; &gt; &gt; &gt; for simple web server.)=C2=A0 Such a use case cannot te=
ll the difference<br>
&gt; &gt; &gt; &gt; between RCU on the one hand and MVCC/RLU on the other.<=
br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; At the other extreme, suppose that each event either ac=
cesses or<br>
&gt; &gt; updates<br>
&gt; &gt; &gt; &gt; multiple entries in the hash table.=C2=A0 In this case,=
 MVCC/RLU will rule<br>
&gt; &gt; &gt; &gt; out outcomes that RCU would permit.=C2=A0 For example, =
suppose we had four<br>
&gt; &gt; &gt; &gt; events accessing two different elements in different bu=
ckets of the<br>
&gt; &gt; &gt; &gt; hash table:<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0E1: Adds 32 to the has=
h table.<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0E2: Adds 1729 to the h=
ash table.<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0E3: Within a read-side=
 critical section, looks up 32 then 1729.<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0E4: Within a read-side=
 critical section, looks up 1729 then 32.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Given either MVCC or RLU, it will not be possible for E=
3 to find 32 but<br>
&gt; &gt; &gt; &gt; not 1729 and at the same time for E4 to find 1729 but n=
ot 32.=C2=A0 Given<br>
&gt; &gt; RCU,<br>
&gt; &gt; &gt; &gt; this outcome is possible.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; When you say &quot;Within a read-side section&quot;, do you =
mean within a single<br>
&gt; &gt; same<br>
&gt; &gt; &gt; read section? such as<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; read_lock()<br>
&gt; &gt; &gt; &gt; lookup(32)<br>
&gt; &gt; &gt; &gt; lookup(1729)<br>
&gt; &gt; &gt; &gt; read_unlock()<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; How about putting two lookups into two read-side sections? D=
o we still<br>
&gt; &gt; have<br>
&gt; &gt; &gt; the problem, then?<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; read_lock()<br>
&gt; &gt; &gt; &gt; lookup(32)<br>
&gt; &gt; &gt; &gt; read_unlock()<br>
&gt; &gt; &gt; &gt; read_lock()<br>
&gt; &gt; &gt; &gt; lookup(1729)<br>
&gt; &gt; &gt; &gt; read_unlock()<br>
&gt; &gt;<br>
&gt; &gt; Without in any way agreeing with your characterization of this as=
 a<br>
&gt; &gt; problem, because rcu_read_lock() and rcu_read_unlock() provide<br=
>
&gt; &gt; absolutely no ordering guarantees in the absence of a grace perio=
d,<br>
&gt; &gt; any non-grace-period-related reordering that can happen with a si=
ngle<br>
&gt; &gt; RCU read-side critical section can also happen when that critical=
<br>
&gt; &gt; section is split in two as you have done above.<br>
&gt; &gt;<br>
&gt; &gt; &gt; Could you kindly give me more clues why RCU can see such reo=
rder, while<br>
&gt; &gt; RLU<br>
&gt; &gt; &gt; can prevent it?<br>
&gt; &gt;<br>
&gt; &gt; Here are minimal C-language implementations for RCU that can (and=
 are)<br>
&gt; &gt; actually used:<br>
&gt; &gt;<br>
&gt; Great. We use the same thing in our real-time work [1]<br>
<br>
It has been a popular choice for 40 years now.=C2=A0 ;-)<br>
<br>
&gt; &gt; #define rcu_read_lock()<br>
&gt; &gt; #define rcu_read_unlock()<br>
&gt; &gt;<br>
&gt; &gt; Please compare these to the read-side markers presented in the RL=
U paper,<br>
&gt; &gt; and then tell me your thoughts on the answer to your question.=C2=
=A0 ;-)<br>
&gt; &gt;<br>
&gt; I submit my homework here, but I do not think I did it well.<br>
&gt; 1. I believe in the default URCU implementation, it has memory barrier=
<br>
&gt; inside the read_lock / read_unlock.<br>
<br>
It certainly was at one time.=C2=A0 But you would of course need to check<b=
r>
to see what any given worker actually used.<br>
<br>
&gt; 2. From the RLU paper, it shows the code for read-side operation.<br>
&gt; RLU_READER_LOCK(ctx)<br>
&gt;=C2=A0 =C2=A0 =C2=A0ctx.is-writer=E2=86=90false<br>
&gt;=C2=A0 =C2=A0 =C2=A0ctx.run-cnt=E2=86=90ctx.run-cnt+1.<br>
&gt;=C2=A0 =C2=A0 =C2=A0memory fence<br>
&gt;=C2=A0 =C2=A0 ctx.local-clock=E2=86=90global-clock<br>
&gt; RLU_READER_UNLOCK(ctx)<br>
&gt;=C2=A0 =C2=A0 =C2=A0ctx.run-cnt=E2=86=90ctx.run-cnt+1<br>
&gt;=C2=A0 =C2=A0 =C2=A0if (ctx.is-writer)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RLU_COMMIT_WRITE_LOG(ctx)<br>
&gt; <br>
&gt; We can ignore the writer check, as in our case, the reader never do up=
date.<br>
&gt; My understanding is that read-side operations are only used to facilit=
ate<br>
&gt; the quiescence detection.<br>
&gt; the run cnt is used to decide if a thread is active (if it is currentl=
y<br>
&gt; inside a read-side section).<br>
&gt; the local clock is used to check if the active thread goes into the<br=
>
&gt; read-side section very late, so it does not prevent reclaiming memory<=
br>
&gt; unlinked before it enters the read section.<br>
&gt; However i see no difference between RLU and RCU read-side operation<br=
>
&gt; regarding consistency guarantee.<br>
&gt; Could you kindly teach me more?<br>
<br>
In order to teach you more, I do need some help from you.=C2=A0 I have post=
ed<br>
a number of URLs earlier in this email thread.=C2=A0 Could you please tell<=
br>
me what you learned from each of them?<br></blockquote><div>Sure, I will de=
finitely learn those resources you provided, and come back to you if I have=
 more questions.</div><div>Simply speaking, I failed to find a clear and fo=
rmal consistency model/guarantee=C2=A0of RCU quickly.<br>The difficulty=C2=
=A0for me is, for most people, at their first glance, RCU only has relax/we=
ak consistency=C2=A0guarantee.=C2=A0</div><div>So whenever I suggest to use=
 RCU to others, they always ask like</div><div>Does RCU provide=C2=A0Serial=
izability? .. maybe not.</div><div>Does RCU provide=C2=A0Linearizability? .=
.. maybe not</div><div>...</div><div>OK, what does RCU provide?=C2=A0 .. I =
am not sure. I even cannot find a single document which has an accurate=C2=
=A0answer.</div><div><br></div><div>Let me give more examples.</div><div>1.=
 When I recommend=C2=A0using read-write lock, people are happy=C2=A0to use =
it.</div><div>=C2=A0 =C2=A0 However, when I further suggest to replace rw l=
ock with RCU, then they hesitate to do so. Because they feel RCU is weaker =
than rw lock, and do not know what precisely RCU guarantee.</div><div>2. In=
 contrast, in the database area, it has relative clear definition=C2=A0of c=
onsistency levels (such as=C2=A0<a href=3D"https://jepsen.io/consistency">h=
ttps://jepsen.io/consistency</a>), and users are easy to assert if they can=
 use certain database configuration based on its consistency model.</div><d=
iv><br></div><div>Again, I really appreciate=C2=A0your patience and communi=
cation, hope those does not bother=C2=A0you a lot.</div><div><br></div><div=
>Thanks</div><div>Best,</div><div>Yuxin</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 Thanx, Paul<br>
<br>
&gt; BTW, the RLU read-side ops are similar, but not efficient, comparing t=
o our<br>
&gt; Parsec work [1, 2]<br>
&gt; [1] Yuxin Ren, G. Liu, G. Parmer, B. Brandenburg, Scalable Memory<br>
&gt; Reclamation for Multi-Core, Real-Time Systems, in Proceedings of the 2=
4th<br>
&gt; IEEE Real-Time and Embedded Technology and Applications Symposium (RTA=
S),<br>
&gt; 2018<br>
&gt; [2] Q. Wang, T. Stamler, and G. Parmer, Parallel Sections: Scaling<br>
&gt; System-Level Data-Structures, in Proceedings of European Conference on=
<br>
&gt; Computer Systems (EuroSys), 2016<br>
&gt; <br>
&gt; Thanks,<br>
&gt; Best,<br>
&gt; Yuxin<br>
&gt; <br>
&gt; <br>
&gt; &gt; &gt; This is because MVCC and RLU provide readers a consistent vi=
ew of<br>
&gt; &gt; &gt; &gt; the updates, and RCU does not.=C2=A0 Of course, it is o=
ften the case that a<br>
&gt; &gt; &gt; &gt; consistent view is not needed, in which case the MVCC a=
nd RLU<br>
&gt; &gt; guarantees<br>
&gt; &gt; &gt; &gt; are incurring read-side overhead for no reason.=C2=A0 B=
ut if the use case<br>
&gt; &gt; &gt; &gt; requires consistent readers, RCU is not an option.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; The reason a consistent view is not always needed is th=
at<br>
&gt; &gt; speed-of-light<br>
&gt; &gt; &gt; &gt; delays make it impossible to provide a consistent view =
of the outside<br>
&gt; &gt; &gt; &gt; world.=C2=A0 In the common case where the use case inte=
racts with the<br>
&gt; &gt; &gt; &gt; outside world, the algorithms absolutely must be design=
ed to tolerate<br>
&gt; &gt; &gt; &gt; inconsistency, which opens the door to things like RCU.=
<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I am confused here. I think speed-of-light delays happen eve=
rywhere, not<br>
&gt; &gt; &gt; only bound to RCU, but also=C2=A0 any other synchronization =
approach (such<br>
&gt; &gt; RLU).<br>
&gt; &gt; &gt; If so, how do others (RLU) provide consistent views?<br>
&gt; &gt;<br>
&gt; &gt; You just stated the answer.=C2=A0 Now it is only necessary for yo=
u to invest<br>
&gt; &gt; the time, effort, and thought to fully understand it.=C2=A0 To he=
lp with this,<br>
&gt; &gt; the following paragraph provides another hint:<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Yes, you are quite right, speed-=
of-light delays between the<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0outside world and the computer a=
ffect RLU just as surely as they<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0do RCU.=C2=A0 This means that th=
e additional consistency guarantees<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0provided by RLU must necessarily=
 be limited to the confines of the<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0computer system in question.=C2=
=A0 Taking this one step further, there<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0are also speed-of-light delays w=
ithin the computer.=C2=A0 Therefore,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0in the general case, RLU can pro=
vide its consistency guarantees,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0even within the confines of the =
computer system, only at the<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0expense of incurring delays.=C2=
=A0 Because RCU does not provide RLU&#39;s<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0consistency guarantees, it need =
not incur RLU&#39;s delays.<br>
&gt; &gt;<br>
&gt; &gt; This is not a new line of reasoning, see for example:<br>
&gt; &gt;<br>
&gt; &gt; @article{Herlihy:1996:LCN:1063369.1063372<br>
&gt; &gt; ,author =3D {Herlihy, Maurice and Shavit, Nir and Waarts, Orli}<b=
r>
&gt; &gt; ,title =3D {Linearizable counting networks}<br>
&gt; &gt; ,journal =3D {Distrib. Comput.}<br>
&gt; &gt; ,volume =3D {9}<br>
&gt; &gt; ,issue =3D {4}<br>
&gt; &gt; ,month =3D {February}<br>
&gt; &gt; ,year =3D {1996}<br>
&gt; &gt; ,issn =3D {0178-2770}<br>
&gt; &gt; ,pages =3D {193--203}<br>
&gt; &gt; ,numpages =3D {11}<br>
&gt; &gt; ,url =3D {<a href=3D"http://portal.acm.org/citation.cfm?id=3D1063=
369.1063372" rel=3D"noreferrer" target=3D"_blank">http://portal.acm.org/cit=
ation.cfm?id=3D1063369.1063372</a>}<br>
&gt; &gt; ,doi =3D {10.1007/s004460050019}<br>
&gt; &gt; ,acmid =3D {1063372}<br>
&gt; &gt; ,publisher =3D {Springer-Verlag}<br>
&gt; &gt; ,address =3D {London, UK}<br>
&gt; &gt; ,keywords =3D {concurrency, contention, counting networks, data s=
tructures,<br>
&gt; &gt; linearizability}<br>
&gt; &gt; }<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Thanx, Paul<b=
r>
&gt; &gt;<br>
&gt; &gt; &gt; Thanks for your education.<br>
&gt; &gt; &gt; Yuxin<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Th=
anx, Paul<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; Thanks<br>
&gt; &gt; &gt; &gt; &gt; Yuxin<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; On Fri, Dec 6, 2019 at 11:30 AM Paul E. McKenney &=
lt;<a href=3D"mailto:paulmck@kernel.org" target=3D"_blank">paulmck@kernel.o=
rg</a><br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; wrote:<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; On Fri, Dec 06, 2019 at 10:59:05AM -0500, Mat=
hieu Desnoyers wrote:<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; ----- On Dec 6, 2019, at 3:51 PM, Yuxin =
Ren &lt;<a href=3D"mailto:ryx@gwmail.gwu.edu" target=3D"_blank">ryx@gwmail.=
gwu.edu</a>&gt;<br>
&gt; &gt; &gt; &gt; wrote:<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; On Fri, Dec 6, 2019 at 5:49 AM Math=
ieu Desnoyers &lt; [<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; mailto:<a href=3D"mailto:mathieu.de=
snoyers@efficios.com" target=3D"_blank">mathieu.desnoyers@efficios.com</a> =
|<br>
&gt; &gt; &gt; &gt; <a href=3D"mailto:mathieu.desnoyers@efficios.com" targe=
t=3D"_blank">mathieu.desnoyers@efficios.com</a><br>
&gt; &gt; &gt; &gt; &gt; &gt; ] &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; wrote:<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;&gt; ----- On Dec 5, 2019, at 8:17 P=
M, Yuxin Ren &lt; [ mailto:<br>
&gt; &gt; &gt; &gt; &gt; &gt; <a href=3D"mailto:ryx@gwmail.gwu.edu" target=
=3D"_blank">ryx@gwmail.gwu.edu</a> |<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;&gt; <a href=3D"mailto:ryx@gwmail.gw=
u.edu" target=3D"_blank">ryx@gwmail.gwu.edu</a> ] &gt; wrote:<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;&gt;&gt; Hi,<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;&gt;&gt; I am a student, and learnin=
g RCU now, but still know very<br>
&gt; &gt; little<br>
&gt; &gt; &gt; &gt; &gt; &gt; about it.<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;&gt;&gt; Are there any documents/pap=
ers/materials which (in)formally<br>
&gt; &gt; &gt; &gt; define<br>
&gt; &gt; &gt; &gt; &gt; &gt; and explain<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;&gt;&gt; RCU consistency guarantees?=
<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;&gt; You may want to have a look at<=
br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;&gt; User-Level Implementations of R=
ead-Copy Update<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;&gt; Article in IEEE Transactions on=
 Parallel and Distributed<br>
&gt; &gt; Systems<br>
&gt; &gt; &gt; &gt; &gt; &gt; 23(2):375 - 382<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;&gt; =C2=B7 March 2012<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; Thanks for your info.<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; However, I do not think URCU talks =
about any consistency model<br>
&gt; &gt; &gt; &gt; &gt; &gt; formally.<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; From previous communication with Pa=
ul, he said RCU is not<br>
&gt; &gt; designed<br>
&gt; &gt; &gt; &gt; for<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; linearizability, and it is totally =
acceptable that RCU is not<br>
&gt; &gt; &gt; &gt; &gt; &gt; linearizable.<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; However, I am curious how to accura=
tely/formally Characterize<br>
&gt; &gt; RCU<br>
&gt; &gt; &gt; &gt; &gt; &gt; consistency<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; model/guarantees<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; Adding Paul E. McKenney in CC.<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; I am referring to the section &quot;Over=
view of RCU semantics&quot; in the<br>
&gt; &gt; &gt; &gt; paper.<br>
&gt; &gt; &gt; &gt; &gt; &gt; Not sure it has the level of<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; formality you are looking for though. Pa=
ul, do you have pointers<br>
&gt; &gt; to<br>
&gt; &gt; &gt; &gt; &gt; &gt; additional material ?<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; Indeed I do!=C2=A0 The Linux kernel memory mo=
del (LKMM) includes RCU.<br>
&gt; &gt; It is<br>
&gt; &gt; &gt; &gt; &gt; &gt; in tools/memory-model in recent kernel source=
 trees, which includes<br>
&gt; &gt; &gt; &gt; &gt; &gt; documentation.=C2=A0 This is an executable mo=
del, which means that you<br>
&gt; &gt; &gt; &gt; &gt; &gt; can create litmus tests and have the model fo=
rmally and<br>
&gt; &gt; automatically<br>
&gt; &gt; &gt; &gt; &gt; &gt; evaluate them.<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; There are also a number of publications cover=
ing LKMM:<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; o=C2=A0 =C2=A0 =C2=A0 =C2=A0A formal kernel m=
emory-ordering model<br>
&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"h=
ttps://lwn.net/Articles/718628/" rel=3D"noreferrer" target=3D"_blank">https=
://lwn.net/Articles/718628/</a><br>
&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"h=
ttps://lwn.net/Articles/720550/" rel=3D"noreferrer" target=3D"_blank">https=
://lwn.net/Articles/720550/</a><br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0These cover =
the release stores and dependency ordering that<br>
&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0provide RCU&=
#39;s publish-subscribe guarantees.<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Backup mater=
ial here:<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; <a href=3D"https://mirrors.edge.kernel.org/pub/linux/kernel/peopl=
e/paulmck/LWNLinuxMM/" rel=3D"noreferrer" target=3D"_blank">https://mirrors=
.edge.kernel.org/pub/linux/kernel/people/paulmck/LWNLinuxMM/</a><br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0With these t=
wo likely being of particular interest:<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; <a href=3D"https://mirrors.edge.kernel.org/pub/linux/kernel/peopl=
e/paulmck/LWNLinuxMM/RCUguarantees.html" rel=3D"noreferrer" target=3D"_blan=
k">https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/LWNLinux=
MM/RCUguarantees.html</a><br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; <a href=3D"https://mirrors.edge.kernel.org/pub/linux/kernel/peopl=
e/paulmck/LWNLinuxMM/srcu.html" rel=3D"noreferrer" target=3D"_blank">https:=
//mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/LWNLinuxMM/srcu.h=
tml</a><br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; o=C2=A0 =C2=A0 =C2=A0 =C2=A0Frightening Small=
 Children and Disconcerting Grown-ups:<br>
&gt; &gt; &gt; &gt; &gt; &gt; Concurrency in the Linux Kernel<br>
&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"h=
ttps://dl.acm.org/citation.cfm?id=3D3177156" rel=3D"noreferrer" target=3D"_=
blank">https://dl.acm.org/citation.cfm?id=3D3177156</a><br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; <a href=3D"http://www0.cs.ucl.ac.uk/staff/j.alglave/papers/asplos=
18.pdf" rel=3D"noreferrer" target=3D"_blank">http://www0.cs.ucl.ac.uk/staff=
/j.alglave/papers/asplos18.pdf</a><br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Backup mater=
ial:<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"h=
ttp://diy.inria.fr/linux/" rel=3D"noreferrer" target=3D"_blank">http://diy.=
inria.fr/linux/</a><br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; o=C2=A0 =C2=A0 =C2=A0 =C2=A0Who&#39;s afraid =
of a big bad optimizing compiler?<br>
&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"h=
ttps://lwn.net/Articles/793253/" rel=3D"noreferrer" target=3D"_blank">https=
://lwn.net/Articles/793253/</a><br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; o=C2=A0 =C2=A0 =C2=A0 =C2=A0Calibrating your =
fear of big bad optimizing compilers<br>
&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"h=
ttps://lwn.net/Articles/799218/" rel=3D"noreferrer" target=3D"_blank">https=
://lwn.net/Articles/799218/</a><br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0These last t=
wo justify use of normal C-language assignment<br>
&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0statements t=
o initialize and access data referenced by<br>
&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RCU-protecte=
d pointers.<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; There is a large body of litmus tests (thousa=
nds of them) here:<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"h=
ttps://github.com/paulmckrcu/litmus" rel=3D"noreferrer" target=3D"_blank">h=
ttps://github.com/paulmckrcu/litmus</a><br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; Many of these litmus tests involve RCU, and t=
hese can be located by<br>
&gt; &gt; &gt; &gt; &gt; &gt; search for files containing rcu_read_lock(), =
rcu_read_unlock(),<br>
&gt; &gt; &gt; &gt; &gt; &gt; synchronize_rcu(), and so on.<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; Or were you looking for something else?<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0Thanx, Paul<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; Thanks,<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; Mathieu<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;&gt; as a starting point.<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;&gt; Thanks,<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;&gt; Mathieu<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;&gt;&gt; I know there are some consi=
stency models in the database area<br>
&gt; &gt; &gt; &gt; (such<br>
&gt; &gt; &gt; &gt; &gt; &gt; as PRAM,<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;&gt;&gt; Read Uncommitted, etc) from=
 [ <a href=3D"https://jepsen.io/consistency" rel=3D"noreferrer" target=3D"_=
blank">https://jepsen.io/consistency</a><br>
&gt; &gt; |<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;&gt;&gt; <a href=3D"https://jepsen.i=
o/consistency" rel=3D"noreferrer" target=3D"_blank">https://jepsen.io/consi=
stency</a> ] and [1].<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;&gt;&gt; How does RCU related to tho=
se consistency models?<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;&gt;&gt; I also found some comments =
online (One key distinction is<br>
&gt; &gt; that<br>
&gt; &gt; &gt; &gt; both<br>
&gt; &gt; &gt; &gt; &gt; &gt; MVCC and RLU<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;&gt;&gt; provide much stronger consi=
stency guarantees to readers than<br>
&gt; &gt; does<br>
&gt; &gt; &gt; &gt; &gt; &gt; RCU ...) ( [<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;&gt;&gt; <a href=3D"https://lwn.net/=
Articles/777036/" rel=3D"noreferrer" target=3D"_blank">https://lwn.net/Arti=
cles/777036/</a> |<br>
&gt; &gt; &gt; &gt; <a href=3D"https://lwn.net/Articles/777036/" rel=3D"nor=
eferrer" target=3D"_blank">https://lwn.net/Articles/777036/</a><br>
&gt; &gt; &gt; &gt; &gt; &gt; ] ).<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;&gt;&gt; I do not understand how we =
reason/dresibe/compare the<br>
&gt; &gt; consistency<br>
&gt; &gt; &gt; &gt; &gt; &gt; guarantees. (<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;&gt;&gt; I even do not know what con=
sistency guarantees provided by<br>
&gt; &gt; RCU<br>
&gt; &gt; &gt; &gt; &gt; &gt; formally)<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;&gt;&gt; Could someone explain this =
to me?<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;&gt;&gt; [1] Bailis, P., Davidson, A=
., Fekete, A., Ghodsi, A.,<br>
&gt; &gt; &gt; &gt; Hellerstein,<br>
&gt; &gt; &gt; &gt; &gt; &gt; J. M., &amp;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;&gt;&gt; Stoica, I. (2013). Highly a=
vailable transactions: Virtues and<br>
&gt; &gt; &gt; &gt; &gt; &gt; limitations.<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;&gt;&gt; Proceedings of the VLDB End=
owment, 7(3), 181-192.<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;&gt;&gt; Thanks<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;&gt;&gt; Yuxin<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;&gt;&gt; ___________________________=
____________________<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;&gt;&gt; lttng-dev mailing list<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;&gt;&gt; [ mailto:<a href=3D"mailto:=
lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a> =
|<br>
&gt; &gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lt=
tng-dev@lists.lttng.org</a> ]<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;&gt;&gt; [ <a href=3D"https://lists.=
lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=3D"noreferrer" target=3D"=
_blank">https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br>
&gt; &gt; |<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;&gt;&gt; <a href=3D"https://lists.lt=
tng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=3D"noreferrer" target=3D"_b=
lank">https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a> ]<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;&gt; --<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;&gt; Mathieu Desnoyers<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;&gt; EfficiOS Inc.<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;&gt; [ <a href=3D"http://www.efficio=
s.com/" rel=3D"noreferrer" target=3D"_blank">http://www.efficios.com/</a> |=
 <a href=3D"http://www.efficios.com" rel=3D"noreferrer" target=3D"_blank">h=
ttp://www.efficios.com</a> ]<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; --<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; Mathieu Desnoyers<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; EfficiOS Inc.<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; <a href=3D"http://www.efficios.com" rel=
=3D"noreferrer" target=3D"_blank">http://www.efficios.com</a><br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt;<br>
</blockquote></div></div>

--0000000000003b8c6b0599c55dcd--

--===============0938664408393169190==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0938664408393169190==--
