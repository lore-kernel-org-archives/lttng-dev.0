From: Yuxin Ren <ryx@gwmail.gwu.edu>
Subject: Re: RCU consistency guarantees
Date: Sat, 7 Dec 2019 15:04:42 -0500
Message-ID: <CAAKbDre3N=RwTNeAqbr3MaA+zuioriLFasd85ZJsFr_pG_VApw__28795.357844659$1575749119$gmane$org@mail.gmail.com>
References: <CAAKbDrdMRrhnSzpPBZLf3nNUDW4YZLPkZkTD5gNJu+A9rATkWA@mail.gmail.com>
 <194534011.751.1575629349181.JavaMail.zimbra@efficios.com>
 <CAAKbDreZ8NerP-jsxezOmN3rktVSAk1a=RJw2YQY83UpQRrXfQ@mail.gmail.com>
 <512711764.1078.1575647945136.JavaMail.zimbra@efficios.com>
 <20191206163052.GG2889@paulmck-ThinkPad-P72>
 <CAAKbDrfzbaPJcKQE7wsjPCgmxUMhcZshDptt=abtufbtCMp85g@mail.gmail.com>
 <20191207063730.GN2889@paulmck-ThinkPad-P72>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4566789761914688777=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com
 [IPv6:2a00:1450:4864:20::241])
 by lists.lttng.org (Postfix) with ESMTPS id 47VgRG6dV4z131q
 for <lttng-dev@lists.lttng.org>; Sat,  7 Dec 2019 15:04:58 -0500 (EST)
Received: by mail-lj1-x241.google.com with SMTP id 21so11328758ljr.0
 for <lttng-dev@lists.lttng.org>; Sat, 07 Dec 2019 12:04:58 -0800 (PST)
In-Reply-To: <20191207063730.GN2889@paulmck-ThinkPad-P72>
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

--===============4566789761914688777==
Content-Type: multipart/alternative; boundary="000000000000301204059922ad8b"

--000000000000301204059922ad8b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks a lot for your help. I have some questions below.

On Sat, Dec 7, 2019 at 1:37 AM Paul E. McKenney <paulmck@kernel.org> wrote:

> On Fri, Dec 06, 2019 at 07:00:13PM -0500, Yuxin Ren wrote:
> > Thanks so much for your great help.
> > I definitely will look at those resources and papers!
> >
> > One more thing that I am confused
> > As I mentioned earlier, someone said One key distinction is that both
> MVCC
> > and RLU provide much stronger consistency guarantees to readers than do=
es
> > RCU ...) (https://lwn.net/Articles/777036/).
>
> That someone was in fact me.  ;-)
>
> > I am not sure if the above statement is correct or not. But in general,
> > How can we compare RCU consistency guarantees to other techniques (such
> as
> > RLU)?
> > How to reason about which one has stronger or weaker guarantees?
>
> I suggest starting from the use case.  For concreteness, let's assume
> that we are using a hash table.  At one extreme, imagine a use case in
> which each event makes exactly one hash-table operation.  No information
> is carried from one event to the next.  (This might well be the case
> for simple web server.)  Such a use case cannot tell the difference
> between RCU on the one hand and MVCC/RLU on the other.
>
> At the other extreme, suppose that each event either accesses or updates
> multiple entries in the hash table.  In this case, MVCC/RLU will rule
> out outcomes that RCU would permit.  For example, suppose we had four
> events accessing two different elements in different buckets of the
> hash table:
>
>         E1: Adds 32 to the hash table.
>         E2: Adds 1729 to the hash table.
>         E3: Within a read-side critical section, looks up 32 then 1729.
>         E4: Within a read-side critical section, looks up 1729 then 32.
>
> Given either MVCC or RLU, it will not be possible for E3 to find 32 but
> not 1729 and at the same time for E4 to find 1729 but not 32.  Given RCU,
> this outcome is possible.
>
When you say "Within a read-side section", do you mean within a single same
read section? such as

> read_lock()
> lookup(32)
> lookup(1729)
> read_unlock()


How about putting two lookups into two read-side sections? Do we still have
the problem, then?

> read_lock()
> lookup(32)
> read_unlock()
> read_lock()
> lookup(1729)
> read_unlock()


Could you kindly give me more clues why RCU can see such reorder, while RLU
can prevent it?


> This is because MVCC and RLU provide readers a consistent view of
> the updates, and RCU does not.  Of course, it is often the case that a
> consistent view is not needed, in which case the MVCC and RLU guarantees
> are incurring read-side overhead for no reason.  But if the use case
> requires consistent readers, RCU is not an option.
>
> The reason a consistent view is not always needed is that speed-of-light
> delays make it impossible to provide a consistent view of the outside
> world.  In the common case where the use case interacts with the
> outside world, the algorithms absolutely must be designed to tolerate
> inconsistency, which opens the door to things like RCU.
>

I am confused here. I think speed-of-light delays happen everywhere, not
only bound to RCU, but also  any other synchronization approach (such RLU).
If so, how do others (RLU) provide consistent views?

Thanks for your education.
Yuxin

>
>                                                         Thanx, Paul
>
> > Thanks
> > Yuxin
> >
> > On Fri, Dec 6, 2019 at 11:30 AM Paul E. McKenney <paulmck@kernel.org>
> wrote:
> >
> > > On Fri, Dec 06, 2019 at 10:59:05AM -0500, Mathieu Desnoyers wrote:
> > > > ----- On Dec 6, 2019, at 3:51 PM, Yuxin Ren <ryx@gwmail.gwu.edu>
> wrote:
> > > >
> > > > > On Fri, Dec 6, 2019 at 5:49 AM Mathieu Desnoyers < [
> > > > > mailto:mathieu.desnoyers@efficios.com |
> mathieu.desnoyers@efficios.com
> > > ] >
> > > > > wrote:
> > > >
> > > > >> ----- On Dec 5, 2019, at 8:17 PM, Yuxin Ren < [ mailto:
> > > ryx@gwmail.gwu.edu |
> > > > >> ryx@gwmail.gwu.edu ] > wrote:
> > > >
> > > > >>> Hi,
> > > > >>> I am a student, and learning RCU now, but still know very littl=
e
> > > about it.
> > > > >>> Are there any documents/papers/materials which (in)formally
> define
> > > and explain
> > > > >>> RCU consistency guarantees?
> > > >
> > > > >> You may want to have a look at
> > > >
> > > > >> User-Level Implementations of Read-Copy Update
> > > > >> Article in IEEE Transactions on Parallel and Distributed Systems
> > > 23(2):375 - 382
> > > > >> =C2=B7 March 2012
> > > >
> > > > > Thanks for your info.
> > > > > However, I do not think URCU talks about any consistency model
> > > formally.
> > > >
> > > > > From previous communication with Paul, he said RCU is not designe=
d
> for
> > > > > linearizability, and it is totally acceptable that RCU is not
> > > linearizable.
> > > > > However, I am curious how to accurately/formally Characterize RCU
> > > consistency
> > > > > model/guarantees
> > > >
> > > > Adding Paul E. McKenney in CC.
> > > >
> > > > I am referring to the section "Overview of RCU semantics" in the
> paper.
> > > Not sure it has the level of
> > > > formality you are looking for though. Paul, do you have pointers to
> > > additional material ?
> > >
> > > Indeed I do!  The Linux kernel memory model (LKMM) includes RCU.  It =
is
> > > in tools/memory-model in recent kernel source trees, which includes
> > > documentation.  This is an executable model, which means that you
> > > can create litmus tests and have the model formally and automatically
> > > evaluate them.
> > >
> > > There are also a number of publications covering LKMM:
> > >
> > > o       A formal kernel memory-ordering model
> > >         https://lwn.net/Articles/718628/
> > >         https://lwn.net/Articles/720550/
> > >
> > >         These cover the release stores and dependency ordering that
> > >         provide RCU's publish-subscribe guarantees.
> > >
> > >         Backup material here:
> > >
> > >
> > >
> https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/LWNLinuxM=
M/
> > >
> > >         With these two likely being of particular interest:
> > >
> > >
> > >
> https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/LWNLinuxM=
M/RCUguarantees.html
> > >
> > >
> https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/LWNLinuxM=
M/srcu.html
> > >
> > > o       Frightening Small Children and Disconcerting Grown-ups:
> > > Concurrency in the Linux Kernel
> > >         https://dl.acm.org/citation.cfm?id=3D3177156
> > >         http://www0.cs.ucl.ac.uk/staff/j.alglave/papers/asplos18.pdf
> > >
> > >         Backup material:
> > >
> > >         http://diy.inria.fr/linux/
> > >
> > > o       Who's afraid of a big bad optimizing compiler?
> > >         https://lwn.net/Articles/793253/
> > >
> > > o       Calibrating your fear of big bad optimizing compilers
> > >         https://lwn.net/Articles/799218/
> > >
> > >         These last two justify use of normal C-language assignment
> > >         statements to initialize and access data referenced by
> > >         RCU-protected pointers.
> > >
> > > There is a large body of litmus tests (thousands of them) here:
> > >
> > >         https://github.com/paulmckrcu/litmus
> > >
> > > Many of these litmus tests involve RCU, and these can be located by
> > > search for files containing rcu_read_lock(), rcu_read_unlock(),
> > > synchronize_rcu(), and so on.
> > >
> > > Or were you looking for something else?
> > >
> > >                                                         Thanx, Paul
> > >
> > > > Thanks,
> > > >
> > > > Mathieu
> > > >
> > > > >> as a starting point.
> > > >
> > > > >> Thanks,
> > > >
> > > > >> Mathieu
> > > >
> > > > >>> I know there are some consistency models in the database area
> (such
> > > as PRAM,
> > > > >>> Read Uncommitted, etc) from [ https://jepsen.io/consistency |
> > > > >>> https://jepsen.io/consistency ] and [1].
> > > > >>> How does RCU related to those consistency models?
> > > >
> > > > >>> I also found some comments online (One key distinction is that
> both
> > > MVCC and RLU
> > > > >>> provide much stronger consistency guarantees to readers than do=
es
> > > RCU ...) ( [
> > > > >>> https://lwn.net/Articles/777036/ |
> https://lwn.net/Articles/777036/
> > > ] ).
> > > > >>> I do not understand how we reason/dresibe/compare the consisten=
cy
> > > guarantees. (
> > > > >>> I even do not know what consistency guarantees provided by RCU
> > > formally)
> > > > >>> Could someone explain this to me?
> > > >
> > > > >>> [1] Bailis, P., Davidson, A., Fekete, A., Ghodsi, A.,
> Hellerstein,
> > > J. M., &
> > > > >>> Stoica, I. (2013). Highly available transactions: Virtues and
> > > limitations.
> > > > >>> Proceedings of the VLDB Endowment, 7(3), 181-192.
> > > >
> > > > >>> Thanks
> > > > >>> Yuxin
> > > >
> > > > >>> _______________________________________________
> > > > >>> lttng-dev mailing list
> > > > >>> [ mailto:lttng-dev@lists.lttng.org | lttng-dev@lists.lttng.org =
]
> > > > >>> [ https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev |
> > > > >>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev ]
> > > >
> > > > >> --
> > > > >> Mathieu Desnoyers
> > > > >> EfficiOS Inc.
> > > > >> [ http://www.efficios.com/ | http://www.efficios.com ]
> > > >
> > > > --
> > > > Mathieu Desnoyers
> > > > EfficiOS Inc.
> > > > http://www.efficios.com
> > >
>

--000000000000301204059922ad8b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Thanks a lot for your help. I have some q=
uestions below.</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Sat, Dec 7, 2019 at 1:37 AM Paul E. McKenney &lt;<a href=
=3D"mailto:paulmck@kernel.org">paulmck@kernel.org</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">On Fri, Dec 06, 2019 at 07=
:00:13PM -0500, Yuxin Ren wrote:<br>
&gt; Thanks so much for your great help.<br>
&gt; I definitely will look at those resources and papers!<br>
&gt; <br>
&gt; One more thing that I am confused<br>
&gt; As I mentioned earlier, someone said One key distinction is that both =
MVCC<br>
&gt; and RLU provide much stronger consistency guarantees to readers than d=
oes<br>
&gt; RCU ...) (<a href=3D"https://lwn.net/Articles/777036/" rel=3D"noreferr=
er" target=3D"_blank">https://lwn.net/Articles/777036/</a>).<br>
<br>
That someone was in fact me.=C2=A0 ;-)<br>
<br>
&gt; I am not sure if the above statement is correct or not. But in general=
,<br>
&gt; How can we compare RCU consistency guarantees to other techniques (suc=
h as<br>
&gt; RLU)?<br>
&gt; How to reason about which one has stronger or weaker guarantees?<br>
<br>
I suggest starting from the use case.=C2=A0 For concreteness, let&#39;s ass=
ume<br>
that we are using a hash table.=C2=A0 At one extreme, imagine a use case in=
<br>
which each event makes exactly one hash-table operation.=C2=A0 No informati=
on<br>
is carried from one event to the next.=C2=A0 (This might well be the case<b=
r>
for simple web server.)=C2=A0 Such a use case cannot tell the difference<br=
>
between RCU on the one hand and MVCC/RLU on the other.<br>
<br>
At the other extreme, suppose that each event either accesses or updates<br=
>
multiple entries in the hash table.=C2=A0 In this case, MVCC/RLU will rule<=
br>
out outcomes that RCU would permit.=C2=A0 For example, suppose we had four<=
br>
events accessing two different elements in different buckets of the<br>
hash table:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 E1: Adds 32 to the hash table.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 E2: Adds 1729 to the hash table.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 E3: Within a read-side critical section, looks =
up 32 then 1729.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 E4: Within a read-side critical section, looks =
up 1729 then 32.<br>
<br>
Given either MVCC or RLU, it will not be possible for E3 to find 32 but<br>
not 1729 and at the same time for E4 to find 1729 but not 32.=C2=A0 Given R=
CU,<br>
this outcome is possible.<br></blockquote><div>When you say &quot;Within a =
read-side section&quot;, do you mean within a single same read section? suc=
h as</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">read_lock()<br>=
lookup(32)<br>lookup(1729)<br>read_unlock()</blockquote><div><br></div><div=
>How about putting two lookups into two read-side sections? Do we still hav=
e the problem, then?=C2=A0<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">read_lock()<br>lookup(32)<br>read_unlock()<br>read_lock()<br>loo=
kup(1729)<br>read_unlock()</blockquote><div><br></div><div>Could you kindly=
 give me more clues why RCU can see such reorder, while RLU can prevent it?=
</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
This is because MVCC and RLU provide readers a consistent view of<br>
the updates, and RCU does not.=C2=A0 Of course, it is often the case that a=
<br>
consistent view is not needed, in which case the MVCC and RLU guarantees<br=
>
are incurring read-side overhead for no reason.=C2=A0 But if the use case<b=
r>
requires consistent readers, RCU is not an option.<br>
<br>
The reason a consistent view is not always needed is that speed-of-light<br=
>
delays make it impossible to provide a consistent view of the outside<br>
world.=C2=A0 In the common case where the use case interacts with the<br>
outside world, the algorithms absolutely must be designed to tolerate<br>
inconsistency, which opens the door to things like RCU.<br></blockquote><di=
v><br></div><div>I am confused here. I think speed-of-light delays happen e=
verywhere, not only bound to RCU, but also=C2=A0 any other synchronization=
=C2=A0approach (such RLU).</div><div>If so, how do others (RLU) provide=C2=
=A0consistent views?</div><div><br></div><div>Thanks for your education.</d=
iv><div>Yuxin</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Thanx, Paul<br>
<br>
&gt; Thanks<br>
&gt; Yuxin<br>
&gt; <br>
&gt; On Fri, Dec 6, 2019 at 11:30 AM Paul E. McKenney &lt;<a href=3D"mailto=
:paulmck@kernel.org" target=3D"_blank">paulmck@kernel.org</a>&gt; wrote:<br=
>
&gt; <br>
&gt; &gt; On Fri, Dec 06, 2019 at 10:59:05AM -0500, Mathieu Desnoyers wrote=
:<br>
&gt; &gt; &gt; ----- On Dec 6, 2019, at 3:51 PM, Yuxin Ren &lt;<a href=3D"m=
ailto:ryx@gwmail.gwu.edu" target=3D"_blank">ryx@gwmail.gwu.edu</a>&gt; wrot=
e:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; On Fri, Dec 6, 2019 at 5:49 AM Mathieu Desnoyers &lt; [=
<br>
&gt; &gt; &gt; &gt; mailto:<a href=3D"mailto:mathieu.desnoyers@efficios.com=
" target=3D"_blank">mathieu.desnoyers@efficios.com</a> | <a href=3D"mailto:=
mathieu.desnoyers@efficios.com" target=3D"_blank">mathieu.desnoyers@efficio=
s.com</a><br>
&gt; &gt; ] &gt;<br>
&gt; &gt; &gt; &gt; wrote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;&gt; ----- On Dec 5, 2019, at 8:17 PM, Yuxin Ren &lt; [ =
mailto:<br>
&gt; &gt; <a href=3D"mailto:ryx@gwmail.gwu.edu" target=3D"_blank">ryx@gwmai=
l.gwu.edu</a> |<br>
&gt; &gt; &gt; &gt;&gt; <a href=3D"mailto:ryx@gwmail.gwu.edu" target=3D"_bl=
ank">ryx@gwmail.gwu.edu</a> ] &gt; wrote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;&gt;&gt; Hi,<br>
&gt; &gt; &gt; &gt;&gt;&gt; I am a student, and learning RCU now, but still=
 know very little<br>
&gt; &gt; about it.<br>
&gt; &gt; &gt; &gt;&gt;&gt; Are there any documents/papers/materials which =
(in)formally define<br>
&gt; &gt; and explain<br>
&gt; &gt; &gt; &gt;&gt;&gt; RCU consistency guarantees?<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;&gt; You may want to have a look at<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;&gt; User-Level Implementations of Read-Copy Update<br>
&gt; &gt; &gt; &gt;&gt; Article in IEEE Transactions on Parallel and Distri=
buted Systems<br>
&gt; &gt; 23(2):375 - 382<br>
&gt; &gt; &gt; &gt;&gt; =C2=B7 March 2012<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Thanks for your info.<br>
&gt; &gt; &gt; &gt; However, I do not think URCU talks about any consistenc=
y model<br>
&gt; &gt; formally.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; From previous communication with Paul, he said RCU is n=
ot designed for<br>
&gt; &gt; &gt; &gt; linearizability, and it is totally acceptable that RCU =
is not<br>
&gt; &gt; linearizable.<br>
&gt; &gt; &gt; &gt; However, I am curious how to accurately/formally Charac=
terize RCU<br>
&gt; &gt; consistency<br>
&gt; &gt; &gt; &gt; model/guarantees<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Adding Paul E. McKenney in CC.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I am referring to the section &quot;Overview of RCU semantic=
s&quot; in the paper.<br>
&gt; &gt; Not sure it has the level of<br>
&gt; &gt; &gt; formality you are looking for though. Paul, do you have poin=
ters to<br>
&gt; &gt; additional material ?<br>
&gt; &gt;<br>
&gt; &gt; Indeed I do!=C2=A0 The Linux kernel memory model (LKMM) includes =
RCU.=C2=A0 It is<br>
&gt; &gt; in tools/memory-model in recent kernel source trees, which includ=
es<br>
&gt; &gt; documentation.=C2=A0 This is an executable model, which means tha=
t you<br>
&gt; &gt; can create litmus tests and have the model formally and automatic=
ally<br>
&gt; &gt; evaluate them.<br>
&gt; &gt;<br>
&gt; &gt; There are also a number of publications covering LKMM:<br>
&gt; &gt;<br>
&gt; &gt; o=C2=A0 =C2=A0 =C2=A0 =C2=A0A formal kernel memory-ordering model=
<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https://lwn.net/Artic=
les/718628/" rel=3D"noreferrer" target=3D"_blank">https://lwn.net/Articles/=
718628/</a><br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https://lwn.net/Artic=
les/720550/" rel=3D"noreferrer" target=3D"_blank">https://lwn.net/Articles/=
720550/</a><br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0These cover the release stores a=
nd dependency ordering that<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0provide RCU&#39;s publish-subscr=
ibe guarantees.<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Backup material here:<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; <a href=3D"https://mirrors.edge.kernel.org/pub/linux/kernel/peopl=
e/paulmck/LWNLinuxMM/" rel=3D"noreferrer" target=3D"_blank">https://mirrors=
.edge.kernel.org/pub/linux/kernel/people/paulmck/LWNLinuxMM/</a><br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0With these two likely being of p=
articular interest:<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; <a href=3D"https://mirrors.edge.kernel.org/pub/linux/kernel/peopl=
e/paulmck/LWNLinuxMM/RCUguarantees.html" rel=3D"noreferrer" target=3D"_blan=
k">https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/LWNLinux=
MM/RCUguarantees.html</a><br>
&gt; &gt;<br>
&gt; &gt; <a href=3D"https://mirrors.edge.kernel.org/pub/linux/kernel/peopl=
e/paulmck/LWNLinuxMM/srcu.html" rel=3D"noreferrer" target=3D"_blank">https:=
//mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/LWNLinuxMM/srcu.h=
tml</a><br>
&gt; &gt;<br>
&gt; &gt; o=C2=A0 =C2=A0 =C2=A0 =C2=A0Frightening Small Children and Discon=
certing Grown-ups:<br>
&gt; &gt; Concurrency in the Linux Kernel<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https://dl.acm.org/ci=
tation.cfm?id=3D3177156" rel=3D"noreferrer" target=3D"_blank">https://dl.ac=
m.org/citation.cfm?id=3D3177156</a><br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://www0.cs.ucl.ac=
.uk/staff/j.alglave/papers/asplos18.pdf" rel=3D"noreferrer" target=3D"_blan=
k">http://www0.cs.ucl.ac.uk/staff/j.alglave/papers/asplos18.pdf</a><br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Backup material:<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://diy.inria.fr/l=
inux/" rel=3D"noreferrer" target=3D"_blank">http://diy.inria.fr/linux/</a><=
br>
&gt; &gt;<br>
&gt; &gt; o=C2=A0 =C2=A0 =C2=A0 =C2=A0Who&#39;s afraid of a big bad optimiz=
ing compiler?<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https://lwn.net/Artic=
les/793253/" rel=3D"noreferrer" target=3D"_blank">https://lwn.net/Articles/=
793253/</a><br>
&gt; &gt;<br>
&gt; &gt; o=C2=A0 =C2=A0 =C2=A0 =C2=A0Calibrating your fear of big bad opti=
mizing compilers<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https://lwn.net/Artic=
les/799218/" rel=3D"noreferrer" target=3D"_blank">https://lwn.net/Articles/=
799218/</a><br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0These last two justify use of no=
rmal C-language assignment<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0statements to initialize and acc=
ess data referenced by<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RCU-protected pointers.<br>
&gt; &gt;<br>
&gt; &gt; There is a large body of litmus tests (thousands of them) here:<b=
r>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https://github.com/pa=
ulmckrcu/litmus" rel=3D"noreferrer" target=3D"_blank">https://github.com/pa=
ulmckrcu/litmus</a><br>
&gt; &gt;<br>
&gt; &gt; Many of these litmus tests involve RCU, and these can be located =
by<br>
&gt; &gt; search for files containing rcu_read_lock(), rcu_read_unlock(),<b=
r>
&gt; &gt; synchronize_rcu(), and so on.<br>
&gt; &gt;<br>
&gt; &gt; Or were you looking for something else?<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Thanx, Paul<b=
r>
&gt; &gt;<br>
&gt; &gt; &gt; Thanks,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Mathieu<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;&gt; as a starting point.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;&gt; Thanks,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;&gt; Mathieu<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;&gt;&gt; I know there are some consistency models in the=
 database area (such<br>
&gt; &gt; as PRAM,<br>
&gt; &gt; &gt; &gt;&gt;&gt; Read Uncommitted, etc) from [ <a href=3D"https:=
//jepsen.io/consistency" rel=3D"noreferrer" target=3D"_blank">https://jepse=
n.io/consistency</a> |<br>
&gt; &gt; &gt; &gt;&gt;&gt; <a href=3D"https://jepsen.io/consistency" rel=
=3D"noreferrer" target=3D"_blank">https://jepsen.io/consistency</a> ] and [=
1].<br>
&gt; &gt; &gt; &gt;&gt;&gt; How does RCU related to those consistency model=
s?<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;&gt;&gt; I also found some comments online (One key dist=
inction is that both<br>
&gt; &gt; MVCC and RLU<br>
&gt; &gt; &gt; &gt;&gt;&gt; provide much stronger consistency guarantees to=
 readers than does<br>
&gt; &gt; RCU ...) ( [<br>
&gt; &gt; &gt; &gt;&gt;&gt; <a href=3D"https://lwn.net/Articles/777036/" re=
l=3D"noreferrer" target=3D"_blank">https://lwn.net/Articles/777036/</a> | <=
a href=3D"https://lwn.net/Articles/777036/" rel=3D"noreferrer" target=3D"_b=
lank">https://lwn.net/Articles/777036/</a><br>
&gt; &gt; ] ).<br>
&gt; &gt; &gt; &gt;&gt;&gt; I do not understand how we reason/dresibe/compa=
re the consistency<br>
&gt; &gt; guarantees. (<br>
&gt; &gt; &gt; &gt;&gt;&gt; I even do not know what consistency guarantees =
provided by RCU<br>
&gt; &gt; formally)<br>
&gt; &gt; &gt; &gt;&gt;&gt; Could someone explain this to me?<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;&gt;&gt; [1] Bailis, P., Davidson, A., Fekete, A., Ghods=
i, A., Hellerstein,<br>
&gt; &gt; J. M., &amp;<br>
&gt; &gt; &gt; &gt;&gt;&gt; Stoica, I. (2013). Highly available transaction=
s: Virtues and<br>
&gt; &gt; limitations.<br>
&gt; &gt; &gt; &gt;&gt;&gt; Proceedings of the VLDB Endowment, 7(3), 181-19=
2.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;&gt;&gt; Thanks<br>
&gt; &gt; &gt; &gt;&gt;&gt; Yuxin<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;&gt;&gt; _______________________________________________=
<br>
&gt; &gt; &gt; &gt;&gt;&gt; lttng-dev mailing list<br>
&gt; &gt; &gt; &gt;&gt;&gt; [ mailto:<a href=3D"mailto:lttng-dev@lists.lttn=
g.org" target=3D"_blank">lttng-dev@lists.lttng.org</a> | <a href=3D"mailto:=
lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a> =
]<br>
&gt; &gt; &gt; &gt;&gt;&gt; [ <a href=3D"https://lists.lttng.org/cgi-bin/ma=
ilman/listinfo/lttng-dev" rel=3D"noreferrer" target=3D"_blank">https://list=
s.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a> |<br>
&gt; &gt; &gt; &gt;&gt;&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mail=
man/listinfo/lttng-dev" rel=3D"noreferrer" target=3D"_blank">https://lists.=
lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a> ]<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;&gt; --<br>
&gt; &gt; &gt; &gt;&gt; Mathieu Desnoyers<br>
&gt; &gt; &gt; &gt;&gt; EfficiOS Inc.<br>
&gt; &gt; &gt; &gt;&gt; [ <a href=3D"http://www.efficios.com/" rel=3D"noref=
errer" target=3D"_blank">http://www.efficios.com/</a> | <a href=3D"http://w=
ww.efficios.com" rel=3D"noreferrer" target=3D"_blank">http://www.efficios.c=
om</a> ]<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; --<br>
&gt; &gt; &gt; Mathieu Desnoyers<br>
&gt; &gt; &gt; EfficiOS Inc.<br>
&gt; &gt; &gt; <a href=3D"http://www.efficios.com" rel=3D"noreferrer" targe=
t=3D"_blank">http://www.efficios.com</a><br>
&gt; &gt;<br>
</blockquote></div></div>

--000000000000301204059922ad8b--

--===============4566789761914688777==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============4566789761914688777==--
