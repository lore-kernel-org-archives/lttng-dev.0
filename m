From: Yuxin Ren <ryx@gwmail.gwu.edu>
Subject: Re: RCU consistency guarantees
Date: Sat, 14 Dec 2019 01:31:31 -0500
Message-ID: <CAAKbDrd5s06mnPYU_dwO1+dtySewm80ukaaEqJiJ0RtkFe-38w__31265.3649061517$1576305131$gmane$org@mail.gmail.com>
References: <CAAKbDrdMRrhnSzpPBZLf3nNUDW4YZLPkZkTD5gNJu+A9rATkWA@mail.gmail.com>
 <194534011.751.1575629349181.JavaMail.zimbra@efficios.com>
 <CAAKbDreZ8NerP-jsxezOmN3rktVSAk1a=RJw2YQY83UpQRrXfQ@mail.gmail.com>
 <512711764.1078.1575647945136.JavaMail.zimbra@efficios.com>
 <20191206163052.GG2889@paulmck-ThinkPad-P72>
 <CAAKbDrfzbaPJcKQE7wsjPCgmxUMhcZshDptt=abtufbtCMp85g@mail.gmail.com>
 <20191207063730.GN2889@paulmck-ThinkPad-P72>
 <CAAKbDre3N=RwTNeAqbr3MaA+zuioriLFasd85ZJsFr_pG_VApw@mail.gmail.com>
 <20191207224232.GR2889@paulmck-ThinkPad-P72>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2564164649379268757=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 by lists.lttng.org (Postfix) with ESMTPS id 47Zd3j6rR0z1873
 for <lttng-dev@lists.lttng.org>; Sat, 14 Dec 2019 01:31:45 -0500 (EST)
Received: by mail-lj1-x22f.google.com with SMTP id k8so1093585ljh.5
 for <lttng-dev@lists.lttng.org>; Fri, 13 Dec 2019 22:31:45 -0800 (PST)
In-Reply-To: <20191207224232.GR2889@paulmck-ThinkPad-P72>
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

--===============2564164649379268757==
Content-Type: multipart/alternative; boundary="000000000000ba52b10599a421a6"

--000000000000ba52b10599a421a6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul

On Sat, Dec 7, 2019 at 5:42 PM Paul E. McKenney <paulmck@kernel.org> wrote:

> On Sat, Dec 07, 2019 at 03:04:42PM -0500, Yuxin Ren wrote:
> > Thanks a lot for your help. I have some questions below.
> >
> > On Sat, Dec 7, 2019 at 1:37 AM Paul E. McKenney <paulmck@kernel.org>
> wrote:
> >
> > > On Fri, Dec 06, 2019 at 07:00:13PM -0500, Yuxin Ren wrote:
> > > > Thanks so much for your great help.
> > > > I definitely will look at those resources and papers!
> > > >
> > > > One more thing that I am confused
> > > > As I mentioned earlier, someone said One key distinction is that bo=
th
> > > MVCC
> > > > and RLU provide much stronger consistency guarantees to readers tha=
n
> does
> > > > RCU ...) (https://lwn.net/Articles/777036/).
> > >
> > > That someone was in fact me.  ;-)
> > >
> > > > I am not sure if the above statement is correct or not. But in
> general,
> > > > How can we compare RCU consistency guarantees to other techniques
> (such
> > > as
> > > > RLU)?
> > > > How to reason about which one has stronger or weaker guarantees?
> > >
> > > I suggest starting from the use case.  For concreteness, let's assume
> > > that we are using a hash table.  At one extreme, imagine a use case i=
n
> > > which each event makes exactly one hash-table operation.  No
> information
> > > is carried from one event to the next.  (This might well be the case
> > > for simple web server.)  Such a use case cannot tell the difference
> > > between RCU on the one hand and MVCC/RLU on the other.
> > >
> > > At the other extreme, suppose that each event either accesses or
> updates
> > > multiple entries in the hash table.  In this case, MVCC/RLU will rule
> > > out outcomes that RCU would permit.  For example, suppose we had four
> > > events accessing two different elements in different buckets of the
> > > hash table:
> > >
> > >         E1: Adds 32 to the hash table.
> > >         E2: Adds 1729 to the hash table.
> > >         E3: Within a read-side critical section, looks up 32 then 172=
9.
> > >         E4: Within a read-side critical section, looks up 1729 then 3=
2.
> > >
> > > Given either MVCC or RLU, it will not be possible for E3 to find 32 b=
ut
> > > not 1729 and at the same time for E4 to find 1729 but not 32.  Given
> RCU,
> > > this outcome is possible.
> > >
> > When you say "Within a read-side section", do you mean within a single
> same
> > read section? such as
> >
> > > read_lock()
> > > lookup(32)
> > > lookup(1729)
> > > read_unlock()
> >
> >
> > How about putting two lookups into two read-side sections? Do we still
> have
> > the problem, then?
> >
> > > read_lock()
> > > lookup(32)
> > > read_unlock()
> > > read_lock()
> > > lookup(1729)
> > > read_unlock()
>
> Without in any way agreeing with your characterization of this as a
> problem, because rcu_read_lock() and rcu_read_unlock() provide
> absolutely no ordering guarantees in the absence of a grace period,
> any non-grace-period-related reordering that can happen with a single
> RCU read-side critical section can also happen when that critical
> section is split in two as you have done above.
>
> > Could you kindly give me more clues why RCU can see such reorder, while
> RLU
> > can prevent it?
>
> Here are minimal C-language implementations for RCU that can (and are)
> actually used:
>
Great. We use the same thing in our real-time work [1]


> #define rcu_read_lock()
> #define rcu_read_unlock()
>
> Please compare these to the read-side markers presented in the RLU paper,
> and then tell me your thoughts on the answer to your question.  ;-)
>
I submit my homework here, but I do not think I did it well.
1. I believe in the default URCU implementation, it has memory barrier
inside the read_lock / read_unlock.
2. From the RLU paper, it shows the code for read-side operation.
RLU_READER_LOCK(ctx)
    ctx.is-writer=E2=86=90false
    ctx.run-cnt=E2=86=90ctx.run-cnt+1.
    memory fence
   ctx.local-clock=E2=86=90global-clock
RLU_READER_UNLOCK(ctx)
    ctx.run-cnt=E2=86=90ctx.run-cnt+1
    if (ctx.is-writer)
        RLU_COMMIT_WRITE_LOG(ctx)

We can ignore the writer check, as in our case, the reader never do update.
My understanding is that read-side operations are only used to facilitate
the quiescence detection.
the run cnt is used to decide if a thread is active (if it is currently
inside a read-side section).
the local clock is used to check if the active thread goes into the
read-side section very late, so it does not prevent reclaiming memory
unlinked before it enters the read section.
However i see no difference between RLU and RCU read-side operation
regarding consistency guarantee.
Could you kindly teach me more?

BTW, the RLU read-side ops are similar, but not efficient, comparing to our
Parsec work [1, 2]
[1] Yuxin Ren, G. Liu, G. Parmer, B. Brandenburg, Scalable Memory
Reclamation for Multi-Core, Real-Time Systems, in Proceedings of the 24th
IEEE Real-Time and Embedded Technology and Applications Symposium (RTAS),
2018
[2] Q. Wang, T. Stamler, and G. Parmer, Parallel Sections: Scaling
System-Level Data-Structures, in Proceedings of European Conference on
Computer Systems (EuroSys), 2016

Thanks,
Best,
Yuxin


> > This is because MVCC and RLU provide readers a consistent view of
> > > the updates, and RCU does not.  Of course, it is often the case that =
a
> > > consistent view is not needed, in which case the MVCC and RLU
> guarantees
> > > are incurring read-side overhead for no reason.  But if the use case
> > > requires consistent readers, RCU is not an option.
> > >
> > > The reason a consistent view is not always needed is that
> speed-of-light
> > > delays make it impossible to provide a consistent view of the outside
> > > world.  In the common case where the use case interacts with the
> > > outside world, the algorithms absolutely must be designed to tolerate
> > > inconsistency, which opens the door to things like RCU.
> >
> > I am confused here. I think speed-of-light delays happen everywhere, no=
t
> > only bound to RCU, but also  any other synchronization approach (such
> RLU).
> > If so, how do others (RLU) provide consistent views?
>
> You just stated the answer.  Now it is only necessary for you to invest
> the time, effort, and thought to fully understand it.  To help with this,
> the following paragraph provides another hint:
>
>         Yes, you are quite right, speed-of-light delays between the
>         outside world and the computer affect RLU just as surely as they
>         do RCU.  This means that the additional consistency guarantees
>         provided by RLU must necessarily be limited to the confines of th=
e
>         computer system in question.  Taking this one step further, there
>         are also speed-of-light delays within the computer.  Therefore,
>         in the general case, RLU can provide its consistency guarantees,
>         even within the confines of the computer system, only at the
>         expense of incurring delays.  Because RCU does not provide RLU's
>         consistency guarantees, it need not incur RLU's delays.
>
> This is not a new line of reasoning, see for example:
>
> @article{Herlihy:1996:LCN:1063369.1063372
> ,author =3D {Herlihy, Maurice and Shavit, Nir and Waarts, Orli}
> ,title =3D {Linearizable counting networks}
> ,journal =3D {Distrib. Comput.}
> ,volume =3D {9}
> ,issue =3D {4}
> ,month =3D {February}
> ,year =3D {1996}
> ,issn =3D {0178-2770}
> ,pages =3D {193--203}
> ,numpages =3D {11}
> ,url =3D {http://portal.acm.org/citation.cfm?id=3D1063369.1063372}
> ,doi =3D {10.1007/s004460050019}
> ,acmid =3D {1063372}
> ,publisher =3D {Springer-Verlag}
> ,address =3D {London, UK}
> ,keywords =3D {concurrency, contention, counting networks, data structure=
s,
> linearizability}
> }
>
>                                                         Thanx, Paul
>
> > Thanks for your education.
> > Yuxin
> >
> > >
> > >                                                         Thanx, Paul
> > >
> > > > Thanks
> > > > Yuxin
> > > >
> > > > On Fri, Dec 6, 2019 at 11:30 AM Paul E. McKenney <paulmck@kernel.or=
g
> >
> > > wrote:
> > > >
> > > > > On Fri, Dec 06, 2019 at 10:59:05AM -0500, Mathieu Desnoyers wrote=
:
> > > > > > ----- On Dec 6, 2019, at 3:51 PM, Yuxin Ren <ryx@gwmail.gwu.edu=
>
> > > wrote:
> > > > > >
> > > > > > > On Fri, Dec 6, 2019 at 5:49 AM Mathieu Desnoyers < [
> > > > > > > mailto:mathieu.desnoyers@efficios.com |
> > > mathieu.desnoyers@efficios.com
> > > > > ] >
> > > > > > > wrote:
> > > > > >
> > > > > > >> ----- On Dec 5, 2019, at 8:17 PM, Yuxin Ren < [ mailto:
> > > > > ryx@gwmail.gwu.edu |
> > > > > > >> ryx@gwmail.gwu.edu ] > wrote:
> > > > > >
> > > > > > >>> Hi,
> > > > > > >>> I am a student, and learning RCU now, but still know very
> little
> > > > > about it.
> > > > > > >>> Are there any documents/papers/materials which (in)formally
> > > define
> > > > > and explain
> > > > > > >>> RCU consistency guarantees?
> > > > > >
> > > > > > >> You may want to have a look at
> > > > > >
> > > > > > >> User-Level Implementations of Read-Copy Update
> > > > > > >> Article in IEEE Transactions on Parallel and Distributed
> Systems
> > > > > 23(2):375 - 382
> > > > > > >> =C2=B7 March 2012
> > > > > >
> > > > > > > Thanks for your info.
> > > > > > > However, I do not think URCU talks about any consistency mode=
l
> > > > > formally.
> > > > > >
> > > > > > > From previous communication with Paul, he said RCU is not
> designed
> > > for
> > > > > > > linearizability, and it is totally acceptable that RCU is not
> > > > > linearizable.
> > > > > > > However, I am curious how to accurately/formally Characterize
> RCU
> > > > > consistency
> > > > > > > model/guarantees
> > > > > >
> > > > > > Adding Paul E. McKenney in CC.
> > > > > >
> > > > > > I am referring to the section "Overview of RCU semantics" in th=
e
> > > paper.
> > > > > Not sure it has the level of
> > > > > > formality you are looking for though. Paul, do you have pointer=
s
> to
> > > > > additional material ?
> > > > >
> > > > > Indeed I do!  The Linux kernel memory model (LKMM) includes RCU.
> It is
> > > > > in tools/memory-model in recent kernel source trees, which includ=
es
> > > > > documentation.  This is an executable model, which means that you
> > > > > can create litmus tests and have the model formally and
> automatically
> > > > > evaluate them.
> > > > >
> > > > > There are also a number of publications covering LKMM:
> > > > >
> > > > > o       A formal kernel memory-ordering model
> > > > >         https://lwn.net/Articles/718628/
> > > > >         https://lwn.net/Articles/720550/
> > > > >
> > > > >         These cover the release stores and dependency ordering th=
at
> > > > >         provide RCU's publish-subscribe guarantees.
> > > > >
> > > > >         Backup material here:
> > > > >
> > > > >
> > > > >
> > >
> https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/LWNLinuxM=
M/
> > > > >
> > > > >         With these two likely being of particular interest:
> > > > >
> > > > >
> > > > >
> > >
> https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/LWNLinuxM=
M/RCUguarantees.html
> > > > >
> > > > >
> > >
> https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/LWNLinuxM=
M/srcu.html
> > > > >
> > > > > o       Frightening Small Children and Disconcerting Grown-ups:
> > > > > Concurrency in the Linux Kernel
> > > > >         https://dl.acm.org/citation.cfm?id=3D3177156
> > > > >
> http://www0.cs.ucl.ac.uk/staff/j.alglave/papers/asplos18.pdf
> > > > >
> > > > >         Backup material:
> > > > >
> > > > >         http://diy.inria.fr/linux/
> > > > >
> > > > > o       Who's afraid of a big bad optimizing compiler?
> > > > >         https://lwn.net/Articles/793253/
> > > > >
> > > > > o       Calibrating your fear of big bad optimizing compilers
> > > > >         https://lwn.net/Articles/799218/
> > > > >
> > > > >         These last two justify use of normal C-language assignmen=
t
> > > > >         statements to initialize and access data referenced by
> > > > >         RCU-protected pointers.
> > > > >
> > > > > There is a large body of litmus tests (thousands of them) here:
> > > > >
> > > > >         https://github.com/paulmckrcu/litmus
> > > > >
> > > > > Many of these litmus tests involve RCU, and these can be located =
by
> > > > > search for files containing rcu_read_lock(), rcu_read_unlock(),
> > > > > synchronize_rcu(), and so on.
> > > > >
> > > > > Or were you looking for something else?
> > > > >
> > > > >                                                         Thanx, Pa=
ul
> > > > >
> > > > > > Thanks,
> > > > > >
> > > > > > Mathieu
> > > > > >
> > > > > > >> as a starting point.
> > > > > >
> > > > > > >> Thanks,
> > > > > >
> > > > > > >> Mathieu
> > > > > >
> > > > > > >>> I know there are some consistency models in the database ar=
ea
> > > (such
> > > > > as PRAM,
> > > > > > >>> Read Uncommitted, etc) from [ https://jepsen.io/consistency
> |
> > > > > > >>> https://jepsen.io/consistency ] and [1].
> > > > > > >>> How does RCU related to those consistency models?
> > > > > >
> > > > > > >>> I also found some comments online (One key distinction is
> that
> > > both
> > > > > MVCC and RLU
> > > > > > >>> provide much stronger consistency guarantees to readers tha=
n
> does
> > > > > RCU ...) ( [
> > > > > > >>> https://lwn.net/Articles/777036/ |
> > > https://lwn.net/Articles/777036/
> > > > > ] ).
> > > > > > >>> I do not understand how we reason/dresibe/compare the
> consistency
> > > > > guarantees. (
> > > > > > >>> I even do not know what consistency guarantees provided by
> RCU
> > > > > formally)
> > > > > > >>> Could someone explain this to me?
> > > > > >
> > > > > > >>> [1] Bailis, P., Davidson, A., Fekete, A., Ghodsi, A.,
> > > Hellerstein,
> > > > > J. M., &
> > > > > > >>> Stoica, I. (2013). Highly available transactions: Virtues a=
nd
> > > > > limitations.
> > > > > > >>> Proceedings of the VLDB Endowment, 7(3), 181-192.
> > > > > >
> > > > > > >>> Thanks
> > > > > > >>> Yuxin
> > > > > >
> > > > > > >>> _______________________________________________
> > > > > > >>> lttng-dev mailing list
> > > > > > >>> [ mailto:lttng-dev@lists.lttng.org |
> lttng-dev@lists.lttng.org ]
> > > > > > >>> [ https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-de=
v
> |
> > > > > > >>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev =
]
> > > > > >
> > > > > > >> --
> > > > > > >> Mathieu Desnoyers
> > > > > > >> EfficiOS Inc.
> > > > > > >> [ http://www.efficios.com/ | http://www.efficios.com ]
> > > > > >
> > > > > > --
> > > > > > Mathieu Desnoyers
> > > > > > EfficiOS Inc.
> > > > > > http://www.efficios.com
> > > > >
> > >
>

--000000000000ba52b10599a421a6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Paul</div><br><div class=3D"gmail_quot=
e"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Dec 7, 2019 at 5:42 PM Pau=
l E. McKenney &lt;<a href=3D"mailto:paulmck@kernel.org" target=3D"_blank">p=
aulmck@kernel.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">On Sat, Dec 07, 2019 at 03:04:42PM -0500, Yuxin Ren wrote:=
<br>
&gt; Thanks a lot for your help. I have some questions below.<br>
&gt; <br>
&gt; On Sat, Dec 7, 2019 at 1:37 AM Paul E. McKenney &lt;<a href=3D"mailto:=
paulmck@kernel.org" target=3D"_blank">paulmck@kernel.org</a>&gt; wrote:<br>
&gt; <br>
&gt; &gt; On Fri, Dec 06, 2019 at 07:00:13PM -0500, Yuxin Ren wrote:<br>
&gt; &gt; &gt; Thanks so much for your great help.<br>
&gt; &gt; &gt; I definitely will look at those resources and papers!<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; One more thing that I am confused<br>
&gt; &gt; &gt; As I mentioned earlier, someone said One key distinction is =
that both<br>
&gt; &gt; MVCC<br>
&gt; &gt; &gt; and RLU provide much stronger consistency guarantees to read=
ers than does<br>
&gt; &gt; &gt; RCU ...) (<a href=3D"https://lwn.net/Articles/777036/" rel=
=3D"noreferrer" target=3D"_blank">https://lwn.net/Articles/777036/</a>).<br=
>
&gt; &gt;<br>
&gt; &gt; That someone was in fact me.=C2=A0 ;-)<br>
&gt; &gt;<br>
&gt; &gt; &gt; I am not sure if the above statement is correct or not. But =
in general,<br>
&gt; &gt; &gt; How can we compare RCU consistency guarantees to other techn=
iques (such<br>
&gt; &gt; as<br>
&gt; &gt; &gt; RLU)?<br>
&gt; &gt; &gt; How to reason about which one has stronger or weaker guarant=
ees?<br>
&gt; &gt;<br>
&gt; &gt; I suggest starting from the use case.=C2=A0 For concreteness, let=
&#39;s assume<br>
&gt; &gt; that we are using a hash table.=C2=A0 At one extreme, imagine a u=
se case in<br>
&gt; &gt; which each event makes exactly one hash-table operation.=C2=A0 No=
 information<br>
&gt; &gt; is carried from one event to the next.=C2=A0 (This might well be =
the case<br>
&gt; &gt; for simple web server.)=C2=A0 Such a use case cannot tell the dif=
ference<br>
&gt; &gt; between RCU on the one hand and MVCC/RLU on the other.<br>
&gt; &gt;<br>
&gt; &gt; At the other extreme, suppose that each event either accesses or =
updates<br>
&gt; &gt; multiple entries in the hash table.=C2=A0 In this case, MVCC/RLU =
will rule<br>
&gt; &gt; out outcomes that RCU would permit.=C2=A0 For example, suppose we=
 had four<br>
&gt; &gt; events accessing two different elements in different buckets of t=
he<br>
&gt; &gt; hash table:<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0E1: Adds 32 to the hash table.<b=
r>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0E2: Adds 1729 to the hash table.=
<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0E3: Within a read-side critical =
section, looks up 32 then 1729.<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0E4: Within a read-side critical =
section, looks up 1729 then 32.<br>
&gt; &gt;<br>
&gt; &gt; Given either MVCC or RLU, it will not be possible for E3 to find =
32 but<br>
&gt; &gt; not 1729 and at the same time for E4 to find 1729 but not 32.=C2=
=A0 Given RCU,<br>
&gt; &gt; this outcome is possible.<br>
&gt; &gt;<br>
&gt; When you say &quot;Within a read-side section&quot;, do you mean withi=
n a single same<br>
&gt; read section? such as<br>
&gt; <br>
&gt; &gt; read_lock()<br>
&gt; &gt; lookup(32)<br>
&gt; &gt; lookup(1729)<br>
&gt; &gt; read_unlock()<br>
&gt; <br>
&gt; <br>
&gt; How about putting two lookups into two read-side sections? Do we still=
 have<br>
&gt; the problem, then?<br>
&gt; <br>
&gt; &gt; read_lock()<br>
&gt; &gt; lookup(32)<br>
&gt; &gt; read_unlock()<br>
&gt; &gt; read_lock()<br>
&gt; &gt; lookup(1729)<br>
&gt; &gt; read_unlock()<br>
<br>
Without in any way agreeing with your characterization of this as a<br>
problem, because rcu_read_lock() and rcu_read_unlock() provide<br>
absolutely no ordering guarantees in the absence of a grace period,<br>
any non-grace-period-related reordering that can happen with a single<br>
RCU read-side critical section can also happen when that critical<br>
section is split in two as you have done above.<br>
<br>
&gt; Could you kindly give me more clues why RCU can see such reorder, whil=
e RLU<br>
&gt; can prevent it?<br>
<br>
Here are minimal C-language implementations for RCU that can (and are)<br>
actually used:<br></blockquote><div>Great. We use the same thing in our rea=
l-time work [1] <br></div><div><br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
<br>
#define rcu_read_lock()<br>
#define rcu_read_unlock()<br>
<br>
Please compare these to the read-side markers presented in the RLU paper,<b=
r>
and then tell me your thoughts on the answer to your question.=C2=A0 ;-)<br=
></blockquote><div>I submit my homework here, but I do not think I did it w=
ell.</div><div>1. I believe in the default URCU implementation, it has memo=
ry barrier inside the read_lock / read_unlock.</div><div>2. From the RLU pa=
per, it shows the code for read-side operation.</div><div>RLU_READER_LOCK(c=
tx)</div><div>=C2=A0=C2=A0=C2=A0 ctx.is-writer=E2=86=90false</div><div>=C2=
=A0=C2=A0=C2=A0 ctx.run-cnt=E2=86=90ctx.run-cnt+1.</div><div>=C2=A0=C2=A0=
=C2=A0 memory fence</div><div>=C2=A0=C2=A0 ctx.local-clock=E2=86=90global-c=
lock</div><div>RLU_READER_UNLOCK(ctx)</div><div>=C2=A0=C2=A0=C2=A0 ctx.run-=
cnt=E2=86=90ctx.run-cnt+1</div><div>=C2=A0=C2=A0=C2=A0 if (ctx.is-writer)</=
div><div>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RLU_COMMIT_WRITE_LOG(ct=
x)</div><div><br></div><div>We can ignore the writer check, as in our case,=
 the reader never do update.</div><div>My understanding is that read-side o=
perations are only used to facilitate the quiescence detection.</div><div>t=
he run cnt is used to decide if a thread is active (if it is currently insi=
de a read-side section).</div><div>the local clock is used to check if the =
active thread goes into the read-side section very late, so it does not pre=
vent reclaiming memory unlinked before it enters the read section.</div><di=
v>However i see no difference between RLU and RCU read-side operation regar=
ding consistency guarantee.</div><div>Could you kindly teach me more?</div>=
<div><br></div><div>BTW, the RLU read-side ops are similar, but not efficie=
nt, comparing to our Parsec work [1, 2]</div><div>[1] Yuxin Ren, G. Liu, G.=
 Parmer, B. Brandenburg, Scalable Memory Reclamation for Multi-Core, Real-T=
ime Systems, in Proceedings of the 24th IEEE Real-Time and Embedded Technol=
ogy and Applications Symposium (RTAS), 2018</div><div>[2] Q. Wang, T. Staml=
er, and G. Parmer, Parallel Sections: Scaling System-Level Data-Structures,=
 in Proceedings of European Conference on Computer Systems (EuroSys), 2016<=
/div><div><br></div><div>Thanks,</div><div>Best,</div><div>Yuxin<br></div><=
div><br></div><div><br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">
&gt; &gt; This is because MVCC and RLU provide readers a consistent view of=
<br>
&gt; &gt; the updates, and RCU does not.=C2=A0 Of course, it is often the c=
ase that a<br>
&gt; &gt; consistent view is not needed, in which case the MVCC and RLU gua=
rantees<br>
&gt; &gt; are incurring read-side overhead for no reason.=C2=A0 But if the =
use case<br>
&gt; &gt; requires consistent readers, RCU is not an option.<br>
&gt; &gt;<br>
&gt; &gt; The reason a consistent view is not always needed is that speed-o=
f-light<br>
&gt; &gt; delays make it impossible to provide a consistent view of the out=
side<br>
&gt; &gt; world.=C2=A0 In the common case where the use case interacts with=
 the<br>
&gt; &gt; outside world, the algorithms absolutely must be designed to tole=
rate<br>
&gt; &gt; inconsistency, which opens the door to things like RCU.<br>
&gt; <br>
&gt; I am confused here. I think speed-of-light delays happen everywhere, n=
ot<br>
&gt; only bound to RCU, but also=C2=A0 any other synchronization approach (=
such RLU).<br>
&gt; If so, how do others (RLU) provide consistent views?<br>
<br>
You just stated the answer.=C2=A0 Now it is only necessary for you to inves=
t<br>
the time, effort, and thought to fully understand it.=C2=A0 To help with th=
is,<br>
the following paragraph provides another hint:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Yes, you are quite right, speed-of-light delays=
 between the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 outside world and the computer affect RLU just =
as surely as they<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 do RCU.=C2=A0 This means that the additional co=
nsistency guarantees<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 provided by RLU must necessarily be limited to =
the confines of the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 computer system in question.=C2=A0 Taking this =
one step further, there<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 are also speed-of-light delays within the compu=
ter.=C2=A0 Therefore,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 in the general case, RLU can provide its consis=
tency guarantees,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 even within the confines of the computer system=
, only at the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 expense of incurring delays.=C2=A0 Because RCU =
does not provide RLU&#39;s<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 consistency guarantees, it need not incur RLU&#=
39;s delays.<br>
<br>
This is not a new line of reasoning, see for example:<br>
<br>
@article{Herlihy:1996:LCN:1063369.1063372<br>
,author =3D {Herlihy, Maurice and Shavit, Nir and Waarts, Orli}<br>
,title =3D {Linearizable counting networks}<br>
,journal =3D {Distrib. Comput.}<br>
,volume =3D {9}<br>
,issue =3D {4}<br>
,month =3D {February}<br>
,year =3D {1996}<br>
,issn =3D {0178-2770}<br>
,pages =3D {193--203}<br>
,numpages =3D {11}<br>
,url =3D {<a href=3D"http://portal.acm.org/citation.cfm?id=3D1063369.106337=
2" rel=3D"noreferrer" target=3D"_blank">http://portal.acm.org/citation.cfm?=
id=3D1063369.1063372</a>}<br>
,doi =3D {10.1007/s004460050019}<br>
,acmid =3D {1063372}<br>
,publisher =3D {Springer-Verlag}<br>
,address =3D {London, UK}<br>
,keywords =3D {concurrency, contention, counting networks, data structures,=
 linearizability}<br>
}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Thanx, Paul<br>
<br>
&gt; Thanks for your education.<br>
&gt; Yuxin<br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Thanx, Paul<b=
r>
&gt; &gt;<br>
&gt; &gt; &gt; Thanks<br>
&gt; &gt; &gt; Yuxin<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; On Fri, Dec 6, 2019 at 11:30 AM Paul E. McKenney &lt;<a href=
=3D"mailto:paulmck@kernel.org" target=3D"_blank">paulmck@kernel.org</a>&gt;=
<br>
&gt; &gt; wrote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; On Fri, Dec 06, 2019 at 10:59:05AM -0500, Mathieu Desno=
yers wrote:<br>
&gt; &gt; &gt; &gt; &gt; ----- On Dec 6, 2019, at 3:51 PM, Yuxin Ren &lt;<a=
 href=3D"mailto:ryx@gwmail.gwu.edu" target=3D"_blank">ryx@gwmail.gwu.edu</a=
>&gt;<br>
&gt; &gt; wrote:<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; On Fri, Dec 6, 2019 at 5:49 AM Mathieu Desnoy=
ers &lt; [<br>
&gt; &gt; &gt; &gt; &gt; &gt; mailto:<a href=3D"mailto:mathieu.desnoyers@ef=
ficios.com" target=3D"_blank">mathieu.desnoyers@efficios.com</a> |<br>
&gt; &gt; <a href=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_blan=
k">mathieu.desnoyers@efficios.com</a><br>
&gt; &gt; &gt; &gt; ] &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; wrote:<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; ----- On Dec 5, 2019, at 8:17 PM, Yuxin R=
en &lt; [ mailto:<br>
&gt; &gt; &gt; &gt; <a href=3D"mailto:ryx@gwmail.gwu.edu" target=3D"_blank"=
>ryx@gwmail.gwu.edu</a> |<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; <a href=3D"mailto:ryx@gwmail.gwu.edu" tar=
get=3D"_blank">ryx@gwmail.gwu.edu</a> ] &gt; wrote:<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt;&gt; Hi,<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt;&gt; I am a student, and learning RCU now,=
 but still know very little<br>
&gt; &gt; &gt; &gt; about it.<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt;&gt; Are there any documents/papers/materi=
als which (in)formally<br>
&gt; &gt; define<br>
&gt; &gt; &gt; &gt; and explain<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt;&gt; RCU consistency guarantees?<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; You may want to have a look at<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; User-Level Implementations of Read-Copy U=
pdate<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; Article in IEEE Transactions on Parallel =
and Distributed Systems<br>
&gt; &gt; &gt; &gt; 23(2):375 - 382<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; =C2=B7 March 2012<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; Thanks for your info.<br>
&gt; &gt; &gt; &gt; &gt; &gt; However, I do not think URCU talks about any =
consistency model<br>
&gt; &gt; &gt; &gt; formally.<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; From previous communication with Paul, he sai=
d RCU is not designed<br>
&gt; &gt; for<br>
&gt; &gt; &gt; &gt; &gt; &gt; linearizability, and it is totally acceptable=
 that RCU is not<br>
&gt; &gt; &gt; &gt; linearizable.<br>
&gt; &gt; &gt; &gt; &gt; &gt; However, I am curious how to accurately/forma=
lly Characterize RCU<br>
&gt; &gt; &gt; &gt; consistency<br>
&gt; &gt; &gt; &gt; &gt; &gt; model/guarantees<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; Adding Paul E. McKenney in CC.<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; I am referring to the section &quot;Overview of RC=
U semantics&quot; in the<br>
&gt; &gt; paper.<br>
&gt; &gt; &gt; &gt; Not sure it has the level of<br>
&gt; &gt; &gt; &gt; &gt; formality you are looking for though. Paul, do you=
 have pointers to<br>
&gt; &gt; &gt; &gt; additional material ?<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Indeed I do!=C2=A0 The Linux kernel memory model (LKMM)=
 includes RCU.=C2=A0 It is<br>
&gt; &gt; &gt; &gt; in tools/memory-model in recent kernel source trees, wh=
ich includes<br>
&gt; &gt; &gt; &gt; documentation.=C2=A0 This is an executable model, which=
 means that you<br>
&gt; &gt; &gt; &gt; can create litmus tests and have the model formally and=
 automatically<br>
&gt; &gt; &gt; &gt; evaluate them.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; There are also a number of publications covering LKMM:<=
br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; o=C2=A0 =C2=A0 =C2=A0 =C2=A0A formal kernel memory-orde=
ring model<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https://lwn=
.net/Articles/718628/" rel=3D"noreferrer" target=3D"_blank">https://lwn.net=
/Articles/718628/</a><br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https://lwn=
.net/Articles/720550/" rel=3D"noreferrer" target=3D"_blank">https://lwn.net=
/Articles/720550/</a><br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0These cover the releas=
e stores and dependency ordering that<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0provide RCU&#39;s publ=
ish-subscribe guarantees.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Backup material here:<=
br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; <a href=3D"https://mirrors.edge.kernel.org/pub/linux/kernel/peopl=
e/paulmck/LWNLinuxMM/" rel=3D"noreferrer" target=3D"_blank">https://mirrors=
.edge.kernel.org/pub/linux/kernel/people/paulmck/LWNLinuxMM/</a><br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0With these two likely =
being of particular interest:<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; <a href=3D"https://mirrors.edge.kernel.org/pub/linux/kernel/peopl=
e/paulmck/LWNLinuxMM/RCUguarantees.html" rel=3D"noreferrer" target=3D"_blan=
k">https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/LWNLinux=
MM/RCUguarantees.html</a><br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; <a href=3D"https://mirrors.edge.kernel.org/pub/linux/kernel/peopl=
e/paulmck/LWNLinuxMM/srcu.html" rel=3D"noreferrer" target=3D"_blank">https:=
//mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/LWNLinuxMM/srcu.h=
tml</a><br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; o=C2=A0 =C2=A0 =C2=A0 =C2=A0Frightening Small Children =
and Disconcerting Grown-ups:<br>
&gt; &gt; &gt; &gt; Concurrency in the Linux Kernel<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https://dl.=
acm.org/citation.cfm?id=3D3177156" rel=3D"noreferrer" target=3D"_blank">htt=
ps://dl.acm.org/citation.cfm?id=3D3177156</a><br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://www0=
.cs.ucl.ac.uk/staff/j.alglave/papers/asplos18.pdf" rel=3D"noreferrer" targe=
t=3D"_blank">http://www0.cs.ucl.ac.uk/staff/j.alglave/papers/asplos18.pdf</=
a><br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Backup material:<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://diy.=
inria.fr/linux/" rel=3D"noreferrer" target=3D"_blank">http://diy.inria.fr/l=
inux/</a><br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; o=C2=A0 =C2=A0 =C2=A0 =C2=A0Who&#39;s afraid of a big b=
ad optimizing compiler?<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https://lwn=
.net/Articles/793253/" rel=3D"noreferrer" target=3D"_blank">https://lwn.net=
/Articles/793253/</a><br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; o=C2=A0 =C2=A0 =C2=A0 =C2=A0Calibrating your fear of bi=
g bad optimizing compilers<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https://lwn=
.net/Articles/799218/" rel=3D"noreferrer" target=3D"_blank">https://lwn.net=
/Articles/799218/</a><br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0These last two justify=
 use of normal C-language assignment<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0statements to initiali=
ze and access data referenced by<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RCU-protected pointers=
.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; There is a large body of litmus tests (thousands of the=
m) here:<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https://git=
hub.com/paulmckrcu/litmus" rel=3D"noreferrer" target=3D"_blank">https://git=
hub.com/paulmckrcu/litmus</a><br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Many of these litmus tests involve RCU, and these can b=
e located by<br>
&gt; &gt; &gt; &gt; search for files containing rcu_read_lock(), rcu_read_u=
nlock(),<br>
&gt; &gt; &gt; &gt; synchronize_rcu(), and so on.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Or were you looking for something else?<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Th=
anx, Paul<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; Thanks,<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; Mathieu<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; as a starting point.<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; Thanks,<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; Mathieu<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt;&gt; I know there are some consistency mod=
els in the database area<br>
&gt; &gt; (such<br>
&gt; &gt; &gt; &gt; as PRAM,<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt;&gt; Read Uncommitted, etc) from [ <a href=
=3D"https://jepsen.io/consistency" rel=3D"noreferrer" target=3D"_blank">htt=
ps://jepsen.io/consistency</a> |<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt;&gt; <a href=3D"https://jepsen.io/consiste=
ncy" rel=3D"noreferrer" target=3D"_blank">https://jepsen.io/consistency</a>=
 ] and [1].<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt;&gt; How does RCU related to those consist=
ency models?<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt;&gt; I also found some comments online (On=
e key distinction is that<br>
&gt; &gt; both<br>
&gt; &gt; &gt; &gt; MVCC and RLU<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt;&gt; provide much stronger consistency gua=
rantees to readers than does<br>
&gt; &gt; &gt; &gt; RCU ...) ( [<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt;&gt; <a href=3D"https://lwn.net/Articles/7=
77036/" rel=3D"noreferrer" target=3D"_blank">https://lwn.net/Articles/77703=
6/</a> |<br>
&gt; &gt; <a href=3D"https://lwn.net/Articles/777036/" rel=3D"noreferrer" t=
arget=3D"_blank">https://lwn.net/Articles/777036/</a><br>
&gt; &gt; &gt; &gt; ] ).<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt;&gt; I do not understand how we reason/dre=
sibe/compare the consistency<br>
&gt; &gt; &gt; &gt; guarantees. (<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt;&gt; I even do not know what consistency g=
uarantees provided by RCU<br>
&gt; &gt; &gt; &gt; formally)<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt;&gt; Could someone explain this to me?<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt;&gt; [1] Bailis, P., Davidson, A., Fekete,=
 A., Ghodsi, A.,<br>
&gt; &gt; Hellerstein,<br>
&gt; &gt; &gt; &gt; J. M., &amp;<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt;&gt; Stoica, I. (2013). Highly available t=
ransactions: Virtues and<br>
&gt; &gt; &gt; &gt; limitations.<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt;&gt; Proceedings of the VLDB Endowment, 7(=
3), 181-192.<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt;&gt; Thanks<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt;&gt; Yuxin<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt;&gt; _____________________________________=
__________<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt;&gt; lttng-dev mailing list<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt;&gt; [ mailto:<a href=3D"mailto:lttng-dev@=
lists.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a> | <a href=
=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.ltt=
ng.org</a> ]<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt;&gt; [ <a href=3D"https://lists.lttng.org/=
cgi-bin/mailman/listinfo/lttng-dev" rel=3D"noreferrer" target=3D"_blank">ht=
tps://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a> |<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt;&gt; <a href=3D"https://lists.lttng.org/cg=
i-bin/mailman/listinfo/lttng-dev" rel=3D"noreferrer" target=3D"_blank">http=
s://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a> ]<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; --<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; Mathieu Desnoyers<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; EfficiOS Inc.<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; [ <a href=3D"http://www.efficios.com/" re=
l=3D"noreferrer" target=3D"_blank">http://www.efficios.com/</a> | <a href=
=3D"http://www.efficios.com" rel=3D"noreferrer" target=3D"_blank">http://ww=
w.efficios.com</a> ]<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; --<br>
&gt; &gt; &gt; &gt; &gt; Mathieu Desnoyers<br>
&gt; &gt; &gt; &gt; &gt; EfficiOS Inc.<br>
&gt; &gt; &gt; &gt; &gt; <a href=3D"http://www.efficios.com" rel=3D"norefer=
rer" target=3D"_blank">http://www.efficios.com</a><br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt;<br>
</blockquote></div></div>

--000000000000ba52b10599a421a6--

--===============2564164649379268757==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2564164649379268757==--
