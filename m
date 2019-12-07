From: Yuxin Ren <ryx@gwmail.gwu.edu>
Subject: Re: RCU consistency guarantees
Date: Fri, 6 Dec 2019 19:00:13 -0500
Message-ID: <CAAKbDrfzbaPJcKQE7wsjPCgmxUMhcZshDptt=abtufbtCMp85g__14247.3007481144$1575676854$gmane$org@mail.gmail.com>
References: <CAAKbDrdMRrhnSzpPBZLf3nNUDW4YZLPkZkTD5gNJu+A9rATkWA@mail.gmail.com>
 <194534011.751.1575629349181.JavaMail.zimbra@efficios.com>
 <CAAKbDreZ8NerP-jsxezOmN3rktVSAk1a=RJw2YQY83UpQRrXfQ@mail.gmail.com>
 <512711764.1078.1575647945136.JavaMail.zimbra@efficios.com>
 <20191206163052.GG2889@paulmck-ThinkPad-P72>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2512842037105845090=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com
 [IPv6:2a00:1450:4864:20::242])
 by lists.lttng.org (Postfix) with ESMTPS id 47V8jV52zVz12L0
 for <lttng-dev@lists.lttng.org>; Fri,  6 Dec 2019 19:00:29 -0500 (EST)
Received: by mail-lj1-x242.google.com with SMTP id s22so9451871ljs.7
 for <lttng-dev@lists.lttng.org>; Fri, 06 Dec 2019 16:00:29 -0800 (PST)
In-Reply-To: <20191206163052.GG2889@paulmck-ThinkPad-P72>
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

--===============2512842037105845090==
Content-Type: multipart/alternative; boundary="000000000000995117059911d988"

--000000000000995117059911d988
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks so much for your great help.
I definitely will look at those resources and papers!

One more thing that I am confused
As I mentioned earlier, someone said One key distinction is that both MVCC
and RLU provide much stronger consistency guarantees to readers than does
RCU ...) (https://lwn.net/Articles/777036/).
I am not sure if the above statement is correct or not. But in general,
How can we compare RCU consistency guarantees to other techniques (such as
RLU)?
How to reason about which one has stronger or weaker guarantees?

Thanks
Yuxin

On Fri, Dec 6, 2019 at 11:30 AM Paul E. McKenney <paulmck@kernel.org> wrote=
:

> On Fri, Dec 06, 2019 at 10:59:05AM -0500, Mathieu Desnoyers wrote:
> > ----- On Dec 6, 2019, at 3:51 PM, Yuxin Ren <ryx@gwmail.gwu.edu> wrote:
> >
> > > On Fri, Dec 6, 2019 at 5:49 AM Mathieu Desnoyers < [
> > > mailto:mathieu.desnoyers@efficios.com | mathieu.desnoyers@efficios.co=
m
> ] >
> > > wrote:
> >
> > >> ----- On Dec 5, 2019, at 8:17 PM, Yuxin Ren < [ mailto:
> ryx@gwmail.gwu.edu |
> > >> ryx@gwmail.gwu.edu ] > wrote:
> >
> > >>> Hi,
> > >>> I am a student, and learning RCU now, but still know very little
> about it.
> > >>> Are there any documents/papers/materials which (in)formally define
> and explain
> > >>> RCU consistency guarantees?
> >
> > >> You may want to have a look at
> >
> > >> User-Level Implementations of Read-Copy Update
> > >> Article in IEEE Transactions on Parallel and Distributed Systems
> 23(2):375 - 382
> > >> =C2=B7 March 2012
> >
> > > Thanks for your info.
> > > However, I do not think URCU talks about any consistency model
> formally.
> >
> > > From previous communication with Paul, he said RCU is not designed fo=
r
> > > linearizability, and it is totally acceptable that RCU is not
> linearizable.
> > > However, I am curious how to accurately/formally Characterize RCU
> consistency
> > > model/guarantees
> >
> > Adding Paul E. McKenney in CC.
> >
> > I am referring to the section "Overview of RCU semantics" in the paper.
> Not sure it has the level of
> > formality you are looking for though. Paul, do you have pointers to
> additional material ?
>
> Indeed I do!  The Linux kernel memory model (LKMM) includes RCU.  It is
> in tools/memory-model in recent kernel source trees, which includes
> documentation.  This is an executable model, which means that you
> can create litmus tests and have the model formally and automatically
> evaluate them.
>
> There are also a number of publications covering LKMM:
>
> o       A formal kernel memory-ordering model
>         https://lwn.net/Articles/718628/
>         https://lwn.net/Articles/720550/
>
>         These cover the release stores and dependency ordering that
>         provide RCU's publish-subscribe guarantees.
>
>         Backup material here:
>
>
> https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/LWNLinuxM=
M/
>
>         With these two likely being of particular interest:
>
>
> https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/LWNLinuxM=
M/RCUguarantees.html
>
> https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/LWNLinuxM=
M/srcu.html
>
> o       Frightening Small Children and Disconcerting Grown-ups:
> Concurrency in the Linux Kernel
>         https://dl.acm.org/citation.cfm?id=3D3177156
>         http://www0.cs.ucl.ac.uk/staff/j.alglave/papers/asplos18.pdf
>
>         Backup material:
>
>         http://diy.inria.fr/linux/
>
> o       Who's afraid of a big bad optimizing compiler?
>         https://lwn.net/Articles/793253/
>
> o       Calibrating your fear of big bad optimizing compilers
>         https://lwn.net/Articles/799218/
>
>         These last two justify use of normal C-language assignment
>         statements to initialize and access data referenced by
>         RCU-protected pointers.
>
> There is a large body of litmus tests (thousands of them) here:
>
>         https://github.com/paulmckrcu/litmus
>
> Many of these litmus tests involve RCU, and these can be located by
> search for files containing rcu_read_lock(), rcu_read_unlock(),
> synchronize_rcu(), and so on.
>
> Or were you looking for something else?
>
>                                                         Thanx, Paul
>
> > Thanks,
> >
> > Mathieu
> >
> > >> as a starting point.
> >
> > >> Thanks,
> >
> > >> Mathieu
> >
> > >>> I know there are some consistency models in the database area (such
> as PRAM,
> > >>> Read Uncommitted, etc) from [ https://jepsen.io/consistency |
> > >>> https://jepsen.io/consistency ] and [1].
> > >>> How does RCU related to those consistency models?
> >
> > >>> I also found some comments online (One key distinction is that both
> MVCC and RLU
> > >>> provide much stronger consistency guarantees to readers than does
> RCU ...) ( [
> > >>> https://lwn.net/Articles/777036/ | https://lwn.net/Articles/777036/
> ] ).
> > >>> I do not understand how we reason/dresibe/compare the consistency
> guarantees. (
> > >>> I even do not know what consistency guarantees provided by RCU
> formally)
> > >>> Could someone explain this to me?
> >
> > >>> [1] Bailis, P., Davidson, A., Fekete, A., Ghodsi, A., Hellerstein,
> J. M., &
> > >>> Stoica, I. (2013). Highly available transactions: Virtues and
> limitations.
> > >>> Proceedings of the VLDB Endowment, 7(3), 181-192.
> >
> > >>> Thanks
> > >>> Yuxin
> >
> > >>> _______________________________________________
> > >>> lttng-dev mailing list
> > >>> [ mailto:lttng-dev@lists.lttng.org | lttng-dev@lists.lttng.org ]
> > >>> [ https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev |
> > >>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev ]
> >
> > >> --
> > >> Mathieu Desnoyers
> > >> EfficiOS Inc.
> > >> [ http://www.efficios.com/ | http://www.efficios.com ]
> >
> > --
> > Mathieu Desnoyers
> > EfficiOS Inc.
> > http://www.efficios.com
>

--000000000000995117059911d988
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks so much for your great help.<div>I definitely=C2=A0=
will look at those resources and papers!</div><div><br></div><div>One more=
=C2=A0thing that I am confused</div><div>As I mentioned=C2=A0earlier, someo=
ne said=C2=A0One key distinction is that both MVCC and RLU provide much str=
onger consistency guarantees to readers than does RCU ...) (<a href=3D"http=
s://lwn.net/Articles/777036/">https://lwn.net/Articles/777036/</a>).</div><=
div>I am not sure if the above statement=C2=A0is correct=C2=A0or not. But i=
n general,=C2=A0</div><div>How can we compare RCU consistency=C2=A0guarante=
es=C2=A0to other techniques (such as RLU)?</div><div>How=C2=A0to reason abo=
ut which one has stronger or weaker guarantees?</div><div><br></div><div>Th=
anks</div><div>Yuxin</div></div><br><div class=3D"gmail_quote"><div dir=3D"=
ltr" class=3D"gmail_attr">On Fri, Dec 6, 2019 at 11:30 AM Paul E. McKenney =
&lt;<a href=3D"mailto:paulmck@kernel.org">paulmck@kernel.org</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Fri, Dec 06,=
 2019 at 10:59:05AM -0500, Mathieu Desnoyers wrote:<br>
&gt; ----- On Dec 6, 2019, at 3:51 PM, Yuxin Ren &lt;<a href=3D"mailto:ryx@=
gwmail.gwu.edu" target=3D"_blank">ryx@gwmail.gwu.edu</a>&gt; wrote: <br>
&gt; <br>
&gt; &gt; On Fri, Dec 6, 2019 at 5:49 AM Mathieu Desnoyers &lt; [<br>
&gt; &gt; mailto:<a href=3D"mailto:mathieu.desnoyers@efficios.com" target=
=3D"_blank">mathieu.desnoyers@efficios.com</a> | <a href=3D"mailto:mathieu.=
desnoyers@efficios.com" target=3D"_blank">mathieu.desnoyers@efficios.com</a=
> ] &gt;<br>
&gt; &gt; wrote:<br>
&gt; <br>
&gt; &gt;&gt; ----- On Dec 5, 2019, at 8:17 PM, Yuxin Ren &lt; [ mailto:<a =
href=3D"mailto:ryx@gwmail.gwu.edu" target=3D"_blank">ryx@gwmail.gwu.edu</a>=
 |<br>
&gt; &gt;&gt; <a href=3D"mailto:ryx@gwmail.gwu.edu" target=3D"_blank">ryx@g=
wmail.gwu.edu</a> ] &gt; wrote:<br>
&gt; <br>
&gt; &gt;&gt;&gt; Hi,<br>
&gt; &gt;&gt;&gt; I am a student, and learning RCU now, but still know very=
 little about it.<br>
&gt; &gt;&gt;&gt; Are there any documents/papers/materials which (in)formal=
ly define and explain<br>
&gt; &gt;&gt;&gt; RCU consistency guarantees?<br>
&gt; <br>
&gt; &gt;&gt; You may want to have a look at<br>
&gt; <br>
&gt; &gt;&gt; User-Level Implementations of Read-Copy Update<br>
&gt; &gt;&gt; Article in IEEE Transactions on Parallel and Distributed Syst=
ems 23(2):375 - 382<br>
&gt; &gt;&gt; =C2=B7 March 2012<br>
&gt; <br>
&gt; &gt; Thanks for your info.<br>
&gt; &gt; However, I do not think URCU talks about any consistency model fo=
rmally.<br>
&gt; <br>
&gt; &gt; From previous communication with Paul, he said RCU is not designe=
d for<br>
&gt; &gt; linearizability, and it is totally acceptable that RCU is not lin=
earizable.<br>
&gt; &gt; However, I am curious how to accurately/formally Characterize RCU=
 consistency<br>
&gt; &gt; model/guarantees<br>
&gt; <br>
&gt; Adding Paul E. McKenney in CC. <br>
&gt; <br>
&gt; I am referring to the section &quot;Overview of RCU semantics&quot; in=
 the paper. Not sure it has the level of <br>
&gt; formality you are looking for though. Paul, do you have pointers to ad=
ditional material ? <br>
<br>
Indeed I do!=C2=A0 The Linux kernel memory model (LKMM) includes RCU.=C2=A0=
 It is<br>
in tools/memory-model in recent kernel source trees, which includes<br>
documentation.=C2=A0 This is an executable model, which means that you<br>
can create litmus tests and have the model formally and automatically<br>
evaluate them.<br>
<br>
There are also a number of publications covering LKMM:<br>
<br>
o=C2=A0 =C2=A0 =C2=A0 =C2=A0A formal kernel memory-ordering model<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://lwn.net/Articles/718628/" re=
l=3D"noreferrer" target=3D"_blank">https://lwn.net/Articles/718628/</a><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://lwn.net/Articles/720550/" re=
l=3D"noreferrer" target=3D"_blank">https://lwn.net/Articles/720550/</a><br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 These cover the release stores and dependency o=
rdering that<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 provide RCU&#39;s publish-subscribe guarantees.=
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Backup material here:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://mirrors.edge.kernel.org/pub/=
linux/kernel/people/paulmck/LWNLinuxMM/" rel=3D"noreferrer" target=3D"_blan=
k">https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/LWNLinux=
MM/</a><br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 With these two likely being of particular inter=
est:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://mirrors.edge.kernel.org/pub/=
linux/kernel/people/paulmck/LWNLinuxMM/RCUguarantees.html" rel=3D"noreferre=
r" target=3D"_blank">https://mirrors.edge.kernel.org/pub/linux/kernel/peopl=
e/paulmck/LWNLinuxMM/RCUguarantees.html</a><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://mirrors.edge.kernel.org/pub/=
linux/kernel/people/paulmck/LWNLinuxMM/srcu.html" rel=3D"noreferrer" target=
=3D"_blank">https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck=
/LWNLinuxMM/srcu.html</a><br>
<br>
o=C2=A0 =C2=A0 =C2=A0 =C2=A0Frightening Small Children and Disconcerting Gr=
own-ups: Concurrency in the Linux Kernel<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://dl.acm.org/citation.cfm?id=
=3D3177156" rel=3D"noreferrer" target=3D"_blank">https://dl.acm.org/citatio=
n.cfm?id=3D3177156</a><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://www0.cs.ucl.ac.uk/staff/j.alg=
lave/papers/asplos18.pdf" rel=3D"noreferrer" target=3D"_blank">http://www0.=
cs.ucl.ac.uk/staff/j.alglave/papers/asplos18.pdf</a><br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Backup material:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://diy.inria.fr/linux/" rel=3D"n=
oreferrer" target=3D"_blank">http://diy.inria.fr/linux/</a><br>
<br>
o=C2=A0 =C2=A0 =C2=A0 =C2=A0Who&#39;s afraid of a big bad optimizing compil=
er?<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://lwn.net/Articles/793253/" re=
l=3D"noreferrer" target=3D"_blank">https://lwn.net/Articles/793253/</a><br>
<br>
o=C2=A0 =C2=A0 =C2=A0 =C2=A0Calibrating your fear of big bad optimizing com=
pilers<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://lwn.net/Articles/799218/" re=
l=3D"noreferrer" target=3D"_blank">https://lwn.net/Articles/799218/</a><br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 These last two justify use of normal C-language=
 assignment<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 statements to initialize and access data refere=
nced by<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 RCU-protected pointers.<br>
<br>
There is a large body of litmus tests (thousands of them) here:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://github.com/paulmckrcu/litmus=
" rel=3D"noreferrer" target=3D"_blank">https://github.com/paulmckrcu/litmus=
</a><br>
<br>
Many of these litmus tests involve RCU, and these can be located by<br>
search for files containing rcu_read_lock(), rcu_read_unlock(),<br>
synchronize_rcu(), and so on.<br>
<br>
Or were you looking for something else?<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Thanx, Paul<br>
<br>
&gt; Thanks, <br>
&gt; <br>
&gt; Mathieu <br>
&gt; <br>
&gt; &gt;&gt; as a starting point.<br>
&gt; <br>
&gt; &gt;&gt; Thanks,<br>
&gt; <br>
&gt; &gt;&gt; Mathieu<br>
&gt; <br>
&gt; &gt;&gt;&gt; I know there are some consistency models in the database =
area (such as PRAM,<br>
&gt; &gt;&gt;&gt; Read Uncommitted, etc) from [ <a href=3D"https://jepsen.i=
o/consistency" rel=3D"noreferrer" target=3D"_blank">https://jepsen.io/consi=
stency</a> |<br>
&gt; &gt;&gt;&gt; <a href=3D"https://jepsen.io/consistency" rel=3D"noreferr=
er" target=3D"_blank">https://jepsen.io/consistency</a> ] and [1].<br>
&gt; &gt;&gt;&gt; How does RCU related to those consistency models?<br>
&gt; <br>
&gt; &gt;&gt;&gt; I also found some comments online (One key distinction is=
 that both MVCC and RLU<br>
&gt; &gt;&gt;&gt; provide much stronger consistency guarantees to readers t=
han does RCU ...) ( [<br>
&gt; &gt;&gt;&gt; <a href=3D"https://lwn.net/Articles/777036/" rel=3D"noref=
errer" target=3D"_blank">https://lwn.net/Articles/777036/</a> | <a href=3D"=
https://lwn.net/Articles/777036/" rel=3D"noreferrer" target=3D"_blank">http=
s://lwn.net/Articles/777036/</a> ] ).<br>
&gt; &gt;&gt;&gt; I do not understand how we reason/dresibe/compare the con=
sistency guarantees. (<br>
&gt; &gt;&gt;&gt; I even do not know what consistency guarantees provided b=
y RCU formally)<br>
&gt; &gt;&gt;&gt; Could someone explain this to me?<br>
&gt; <br>
&gt; &gt;&gt;&gt; [1] Bailis, P., Davidson, A., Fekete, A., Ghodsi, A., Hel=
lerstein, J. M., &amp;<br>
&gt; &gt;&gt;&gt; Stoica, I. (2013). Highly available transactions: Virtues=
 and limitations.<br>
&gt; &gt;&gt;&gt; Proceedings of the VLDB Endowment, 7(3), 181-192.<br>
&gt; <br>
&gt; &gt;&gt;&gt; Thanks<br>
&gt; &gt;&gt;&gt; Yuxin<br>
&gt; <br>
&gt; &gt;&gt;&gt; _______________________________________________<br>
&gt; &gt;&gt;&gt; lttng-dev mailing list<br>
&gt; &gt;&gt;&gt; [ mailto:<a href=3D"mailto:lttng-dev@lists.lttng.org" tar=
get=3D"_blank">lttng-dev@lists.lttng.org</a> | <a href=3D"mailto:lttng-dev@=
lists.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a> ]<br>
&gt; &gt;&gt;&gt; [ <a href=3D"https://lists.lttng.org/cgi-bin/mailman/list=
info/lttng-dev" rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.or=
g/cgi-bin/mailman/listinfo/lttng-dev</a> |<br>
&gt; &gt;&gt;&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listin=
fo/lttng-dev" rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/=
cgi-bin/mailman/listinfo/lttng-dev</a> ]<br>
&gt; <br>
&gt; &gt;&gt; --<br>
&gt; &gt;&gt; Mathieu Desnoyers<br>
&gt; &gt;&gt; EfficiOS Inc.<br>
&gt; &gt;&gt; [ <a href=3D"http://www.efficios.com/" rel=3D"noreferrer" tar=
get=3D"_blank">http://www.efficios.com/</a> | <a href=3D"http://www.efficio=
s.com" rel=3D"noreferrer" target=3D"_blank">http://www.efficios.com</a> ]<b=
r>
&gt; <br>
&gt; -- <br>
&gt; Mathieu Desnoyers <br>
&gt; EfficiOS Inc. <br>
&gt; <a href=3D"http://www.efficios.com" rel=3D"noreferrer" target=3D"_blan=
k">http://www.efficios.com</a> <br>
</blockquote></div>

--000000000000995117059911d988--

--===============2512842037105845090==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2512842037105845090==--
