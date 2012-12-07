From: Lai Jiangshan <eag0628@gmail.com>
Subject: Re: [PATCH] urcu: avoid false sharing for rcu_gp_ctr
Date: Sat, 8 Dec 2012 01:17:17 +0800
Message-ID: <CACvQF50V_9T6T3j4AwbdBuEiHHbcxdNGgP1WF5T4OHpXZyMgEA__27535.1874916398$1354900681$gmane$org@mail.gmail.com>
References: <50C19575.2070802@cn.fujitsu.com> <20121207163234.GB11975@Krystal>
	<CACvQF50Y2wC3t=VMJ==574aHVvod+ipGA1K5hR97r_dRbcegkw@mail.gmail.com>
	<20121207165748.GA12338@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1989499700=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
In-Reply-To: <20121207165748.GA12338@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, "ltt-dev@lists.casi.polymtl.ca" <ltt-dev@lists.casi.polymtl.ca>
List-Id: lttng-dev@lists.lttng.org

--===============1989499700==
Content-Type: multipart/alternative; boundary=e89a8ff1c254340a7404d04663fc

--e89a8ff1c254340a7404d04663fc
Content-Type: text/plain; charset=ISO-8859-1

On Saturday, December 8, 2012, Mathieu Desnoyers wrote:

> * Lai Jiangshan (eag0628@gmail.com <javascript:;>) wrote:
> > we can define rcu_gp_ctr and registry with aligned attribute, but it is
> not
> > reliable way
> >
> > We need only this:
> > unsigned long rcu_gp_ctr __attribute((aligned and padded(don't put other
> > var next to it except the futex)))
>
> In which situation would this be unreliable ?



int a;
int b __attribute__((aligned));
int c;

b and c will be in the same line, even we define c as aligned too, the
compiler/linker may put a next to b, thus a and b in the same line


>
> Thanks,
>
> Mathieu
>
> >
> > On Saturday, December 8, 2012, Mathieu Desnoyers wrote:
> >
> > > * Lai Jiangshan (laijs@cn.fujitsu.com <javascript:;> <javascript:;>)
> wrote:
> > > > @rcu_gp_ctr and @registry share the same cache line, it causes
> > > > false sharing and slowdown both of the read site and update site.
> > > >
> > > > Fix: Use different cache line for them.
> > > >
> > > > Although rcu_gp_futex is updated less than rcu_gp_ctr, but
> > > > they always be accessed at almost the same time, so we also move
> > > rcu_gp_futex
> > > > to the cacheline of rcu_gp_ctr to reduce the cacheline-usage or
> > > cache-missing
> > > > of read site.
> > >
> > > Hi Lai,
> > >
> > > I agree on the goal: placing registry and rcu_gp_ctr on different
> > > cache-lines. And yes, it makes sense to put rcu_gp_ctr and rcu_gp_futex
> > > on the same cache-line. I agree that the next patch is fine too
> (keeping
> > > qsbr and other urcu similar). This is indeed what I try to ensure
> > > myself.
> > >
> > > I'm just concerned that this patch seems to break ABI compability for
> > > liburcu: the read-side, within applications, would have to be
> > > recompiled. So I guess we should decide if we do this change in a way
> > > that does not break the ABI (e.g. not introducing a structure), or if
> we
> > > choose to bump the library version number.
> > >
> > > Thoughts ?
> > >
> > > Thanks,
> > >
> > > Mathieu
> > >
> > > >
> > > >
> > > > test: (4X6=24 CPUs)
> > > >
> > > > Before patch:
> > > >
> > > > [root@localhost userspace-rcu]# ./tests/test_urcu_mb 20 1 20
> > > > SUMMARY ./tests/test_urcu_mb      testdur   20 nr_readers  20 rdur
> > >  0 wdur      0 nr_writers   1 wdelay      0 nr_reads   2100285330
> nr_writes
> > >      3390219 nr_ops   2103675549
> > > > [root@localhost userspace-rcu]# ./tests/test_urcu_mb 20 1 20
> > > > SUMMARY ./tests/test_urcu_mb      testdur   20 nr_readers  20 rdur
> > >  0 wdur      0 nr_writers   1 wdelay      0 nr_reads   1619868562
> nr_writes
> > >      3529478 nr_ops   1623398040
> > > > [root@localhost userspace-rcu]# ./tests/test_urcu_mb 20 1 20
> > > > SUMMARY ./tests/test_urcu_mb      testdur   20 nr_readers  20 rdur
> > >  0 wdur      0 nr_writers   1 wdelay      0 nr_reads   1949067038
> nr_writes
> > >      3469334 nr_ops   1952536372
> > > >
> > > >
> > > > after patch:
> > > >
> > > > [root@localhost userspace-rcu]# ./tests/test_urcu_mb 20 1 20
> > > > SUMMARY ./tests/test_urcu_mb      testdur   20 nr_readers  20 rdur
> > >  0 wdur      0 nr_writers   1 wdelay      0 nr_reads   3380191848
> nr_writes
> > >      4903248 nr_ops   3385095096
> > > > [root@localhost userspace-rcu]# ./tests/test_urcu_mb 20 1 20
> > > > SUMMARY ./tests/test_urcu_mb      testdur   20 nr_readers  20 rdur
> > >  0 wdur      0 nr_writers   1 wdelay      0 nr_reads   3397637486
> nr_writes
> > >      4129809 nr_ops   3401767295
> > > >
> > > > Singed-by: Lai Jiangshan <laijs@cn.fujitsu.com <javascript:;><javascript:;>>
> > > > ---
> > > > diff --git a/urcu.c b/urcu.c
> > > > index 15def09..436d71c 100644
> > > > --- a/urcu.c
> > > > +++ b/urcu.c
> > > > @@ -83,16 +83,7 @@ void __attribute__((destructor)) rcu_exit(void);
> > > >  #endif
> > > >
> > > >  static pthread_mutex_t rcu_gp_lock = PTHREAD_MUTEX_INITIALIZER;
> > > > -
> > > > -int32_t rcu_gp_futex;
> > > > -
> > > > -/*
> > > > - * Global grace period counter.
> > > > - * Contains the current RCU_GP_CTR_PHASE.
> > > > - * Also has a RCU_GP_COUNT of 1, to accelerate the reader fast path.
> > > > - * Written to only by writer with mutex taken. Read by both writer
> and
> > > readers.
> > > > - */
> > > > -unsigned long rcu_gp_ctr = RCU_GP_COUNT;
> > > > +struct urcu_gp rcu_gp = { .ctr = RCU_GP_COUNT };
> > > >
> > > >  /*
> > > >   * Written to only by each individual reader. Read by both the
> reader
> > > and the
> > > > @@ -217,8 +208,8 @@ static void wait_gp(void)
> > > >  {
> > > >       /* Read reader_gp before read futex */
> > > >       smp_mb_master(RCU_MB_GROUP);
> > > > -     if (uatomic_read(&rcu_gp_futex) == -1)
> > > > -             futex_async(&rcu_gp_futex, FUTEX_WAIT, -1,
> > > > +     if (uatomic_read(&rcu_gp.futex) == -1)
> > > > +             futex_async(&rcu_gp.futex, FUTEX_WAIT, -1,
> > > >                     NULL, NULL, 0);
> > > >  }
> > > >
> > > > @@ -232,12 +223,12 @@ static void wait_for_readers(struct
> cds_list_head
> > > *input_readers,
> > > >       /*
> > > >        * Wait for each thread URCU_TLS(rcu_reader).ctr to either
> > > >        * indicate quiescence (not nested), or observe the current
> > > > -      * rcu_gp_ctr value.
> > > > +      * rcu_gp.ctr value.
> > > >        */
> > > >       for (;;) {
> > > >               wait_loops++;
> > > >               if (wait_loops == RCU_QS_ACTIVE_ATTEMPTS) {
> > > > -                     uatomic_dec(&rcu_gp_futex);
> > > > +                     uatomic_dec(&rcu_gp.futex);
> > > >                       /* Write futex before read reader_gp */
> > > >                       smp_mb_master(RCU_MB_GROUP);
> > > >               }
> > > > @@ -270,7 +261,7 @@ static void wait_for_readers(struct cds_list_head
> > > *input_readers,
> > > >                       if (wait_loops == RCU_QS_ACTIVE_ATTEMPTS) {
> > > >                               /* Read reader_gp before write futex */
> > > >                               smp_mb_master(RCU_MB_GROUP);
> > > > -                             uatomic_set(&rcu_gp_futex, 0);
> > > > +                             uatomic_set(&rcu_gp.futex, 0);
> > > >                       }
> > > >                       break;
> > > >               } else {
> > > > @@ -289,7 +280,7 @@ static void wait_for_readers(struct cds_list_head
> > > *input_readers,
> > > >                       if (wait_loops == RCU_QS_ACTIVE_ATTEMPTS) {
> > > >                               /* Read reader_gp before write futex */
> > > >                             > > lttng-dev@lists.lttng.org<javascript:;><javascript:;>
> > > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> > >
>
> --
> Mathieu Desnoyers
> Operating System Efficiency R&D Consultant
> EfficiOS Inc.
> http://www.efficios.com
>

--e89a8ff1c254340a7404d04663fc
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br>On Saturday, December 8, 2012, Mathieu Desnoyers  wrote:<br><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">* Lai Jiangshan (<a href=3D"javascript:;" onclick=
=3D"_e(event, &#39;cvml&#39;, &#39;eag0628@gmail.com&#39;)">eag0628@gmail.c=
om</a>) wrote:<br>

&gt; we can define rcu_gp_ctr and registry with aligned attribute, but it i=
s not<br>
&gt; reliable way<br>
&gt;<br>
&gt; We need only this:<br>
&gt; unsigned long rcu_gp_ctr __attribute((aligned and padded(don&#39;t put=
 other<br>
&gt; var next to it except the futex)))<br>
<br>
In which situation would this be unreliable ?</blockquote><div><br></div><b=
r><div>int a;</div><div>int b __attribute__((aligned));</div><div>int c;</d=
iv><div><br></div><div>b and c will be in the same line, even we define c a=
s aligned too, the compiler/linker may put a next to b, thus a and b in the=
 same line<span></span></div>
<div>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex">
<br>
Thanks,<br>
<br>
Mathieu<br>
<br>
&gt;<br>
&gt; On Saturday, December 8, 2012, Mathieu Desnoyers wrote:<br>
&gt;<br>
&gt; &gt; * Lai Jiangshan (<a href=3D"javascript:;" onclick=3D"_e(event, &#=
39;cvml&#39;, &#39;laijs@cn.fujitsu.com&#39;)">laijs@cn.fujitsu.com</a> &lt=
;javascript:;&gt;) wrote:<br>
&gt; &gt; &gt; @rcu_gp_ctr and @registry share the same cache line, it caus=
es<br>
&gt; &gt; &gt; false sharing and slowdown both of the read site and update =
site.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Fix: Use different cache line for them.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Although rcu_gp_futex is updated less than rcu_gp_ctr, but<b=
r>
&gt; &gt; &gt; they always be accessed at almost the same time, so we also =
move<br>
&gt; &gt; rcu_gp_futex<br>
&gt; &gt; &gt; to the cacheline of rcu_gp_ctr to reduce the cacheline-usage=
 or<br>
&gt; &gt; cache-missing<br>
&gt; &gt; &gt; of read site.<br>
&gt; &gt;<br>
&gt; &gt; Hi Lai,<br>
&gt; &gt;<br>
&gt; &gt; I agree on the goal: placing registry and rcu_gp_ctr on different=
<br>
&gt; &gt; cache-lines. And yes, it makes sense to put rcu_gp_ctr and rcu_gp=
_futex<br>
&gt; &gt; on the same cache-line. I agree that the next patch is fine too (=
keeping<br>
&gt; &gt; qsbr and other urcu similar). This is indeed what I try to ensure=
<br>
&gt; &gt; myself.<br>
&gt; &gt;<br>
&gt; &gt; I&#39;m just concerned that this patch seems to break ABI compabi=
lity for<br>
&gt; &gt; liburcu: the read-side, within applications, would have to be<br>
&gt; &gt; recompiled. So I guess we should decide if we do this change in a=
 way<br>
&gt; &gt; that does not break the ABI (e.g. not introducing a structure), o=
r if we<br>
&gt; &gt; choose to bump the library version number.<br>
&gt; &gt;<br>
&gt; &gt; Thoughts ?<br>
&gt; &gt;<br>
&gt; &gt; Thanks,<br>
&gt; &gt;<br>
&gt; &gt; Mathieu<br>
&gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; test: (4X6=3D24 CPUs)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Before patch:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; [root@localhost userspace-rcu]# ./tests/test_urcu_mb 20 1 20=
<br>
&gt; &gt; &gt; SUMMARY ./tests/test_urcu_mb =A0 =A0 =A0testdur =A0 20 nr_re=
aders =A020 rdur<br>
&gt; &gt; =A00 wdur =A0 =A0 =A00 nr_writers =A0 1 wdelay =A0 =A0 =A00 nr_re=
ads =A0 2100285330 nr_writes<br>
&gt; &gt; =A0 =A0 =A03390219 nr_ops =A0 2103675549<br>
&gt; &gt; &gt; [root@localhost userspace-rcu]# ./tests/test_urcu_mb 20 1 20=
<br>
&gt; &gt; &gt; SUMMARY ./tests/test_urcu_mb =A0 =A0 =A0testdur =A0 20 nr_re=
aders =A020 rdur<br>
&gt; &gt; =A00 wdur =A0 =A0 =A00 nr_writers =A0 1 wdelay =A0 =A0 =A00 nr_re=
ads =A0 1619868562 nr_writes<br>
&gt; &gt; =A0 =A0 =A03529478 nr_ops =A0 1623398040<br>
&gt; &gt; &gt; [root@localhost userspace-rcu]# ./tests/test_urcu_mb 20 1 20=
<br>
&gt; &gt; &gt; SUMMARY ./tests/test_urcu_mb =A0 =A0 =A0testdur =A0 20 nr_re=
aders =A020 rdur<br>
&gt; &gt; =A00 wdur =A0 =A0 =A00 nr_writers =A0 1 wdelay =A0 =A0 =A00 nr_re=
ads =A0 1949067038 nr_writes<br>
&gt; &gt; =A0 =A0 =A03469334 nr_ops =A0 1952536372<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; after patch:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; [root@localhost userspace-rcu]# ./tests/test_urcu_mb 20 1 20=
<br>
&gt; &gt; &gt; SUMMARY ./tests/test_urcu_mb =A0 =A0 =A0testdur =A0 20 nr_re=
aders =A020 rdur<br>
&gt; &gt; =A00 wdur =A0 =A0 =A00 nr_writers =A0 1 wdelay =A0 =A0 =A00 nr_re=
ads =A0 3380191848 nr_writes<br>
&gt; &gt; =A0 =A0 =A04903248 nr_ops =A0 3385095096<br>
&gt; &gt; &gt; [root@localhost userspace-rcu]# ./tests/test_urcu_mb 20 1 20=
<br>
&gt; &gt; &gt; SUMMARY ./tests/test_urcu_mb =A0 =A0 =A0testdur =A0 20 nr_re=
aders =A020 rdur<br>
&gt; &gt; =A00 wdur =A0 =A0 =A00 nr_writers =A0 1 wdelay =A0 =A0 =A00 nr_re=
ads =A0 3397637486 nr_writes<br>
&gt; &gt; =A0 =A0 =A04129809 nr_ops =A0 3401767295<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Singed-by: Lai Jiangshan &lt;<a href=3D"javascript:;" onclic=
k=3D"_e(event, &#39;cvml&#39;, &#39;laijs@cn.fujitsu.com&#39;)">laijs@cn.fu=
jitsu.com</a> &lt;javascript:;&gt;&gt;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt; diff --git a/urcu.c b/urcu.c<br>
&gt; &gt; &gt; index 15def09..436d71c 100644<br>
&gt; &gt; &gt; --- a/urcu.c<br>
&gt; &gt; &gt; +++ b/urcu.c<br>
&gt; &gt; &gt; @@ -83,16 +83,7 @@ void __attribute__((destructor)) rcu_exit=
(void);<br>
&gt; &gt; &gt; =A0#endif<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; =A0static pthread_mutex_t rcu_gp_lock =3D PTHREAD_MUTEX_INIT=
IALIZER;<br>
&gt; &gt; &gt; -<br>
&gt; &gt; &gt; -int32_t rcu_gp_futex;<br>
&gt; &gt; &gt; -<br>
&gt; &gt; &gt; -/*<br>
&gt; &gt; &gt; - * Global grace period counter.<br>
&gt; &gt; &gt; - * Contains the current RCU_GP_CTR_PHASE.<br>
&gt; &gt; &gt; - * Also has a RCU_GP_COUNT of 1, to accelerate the reader f=
ast path.<br>
&gt; &gt; &gt; - * Written to only by writer with mutex taken. Read by both=
 writer and<br>
&gt; &gt; readers.<br>
&gt; &gt; &gt; - */<br>
&gt; &gt; &gt; -unsigned long rcu_gp_ctr =3D RCU_GP_COUNT;<br>
&gt; &gt; &gt; +struct urcu_gp rcu_gp =3D { .ctr =3D RCU_GP_COUNT };<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; =A0/*<br>
&gt; &gt; &gt; =A0 * Written to only by each individual reader. Read by bot=
h the reader<br>
&gt; &gt; and the<br>
&gt; &gt; &gt; @@ -217,8 +208,8 @@ static void wait_gp(void)<br>
&gt; &gt; &gt; =A0{<br>
&gt; &gt; &gt; =A0 =A0 =A0 /* Read reader_gp before read futex */<br>
&gt; &gt; &gt; =A0 =A0 =A0 smp_mb_master(RCU_MB_GROUP);<br>
&gt; &gt; &gt; - =A0 =A0 if (uatomic_read(&amp;rcu_gp_futex) =3D=3D -1)<br>
&gt; &gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 futex_async(&amp;rcu_gp_futex, FUT=
EX_WAIT, -1,<br>
&gt; &gt; &gt; + =A0 =A0 if (uatomic_read(&amp;rcu_gp.futex) =3D=3D -1)<br>
&gt; &gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 futex_async(&amp;rcu_gp.futex, FUT=
EX_WAIT, -1,<br>
&gt; &gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 NULL, NULL, 0);<br>
&gt; &gt; &gt; =A0}<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; @@ -232,12 +223,12 @@ static void wait_for_readers(struct cd=
s_list_head<br>
&gt; &gt; *input_readers,<br>
&gt; &gt; &gt; =A0 =A0 =A0 /*<br>
&gt; &gt; &gt; =A0 =A0 =A0 =A0* Wait for each thread URCU_TLS(rcu_reader).c=
tr to either<br>
&gt; &gt; &gt; =A0 =A0 =A0 =A0* indicate quiescence (not nested), or observ=
e the current<br>
&gt; &gt; &gt; - =A0 =A0 =A0* rcu_gp_ctr value.<br>
&gt; &gt; &gt; + =A0 =A0 =A0* rcu_gp.ctr value.<br>
&gt; &gt; &gt; =A0 =A0 =A0 =A0*/<br>
&gt; &gt; &gt; =A0 =A0 =A0 for (;;) {<br>
&gt; &gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 wait_loops++;<br>
&gt; &gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (wait_loops =3D=3D RCU_QS_ACT=
IVE_ATTEMPTS) {<br>
&gt; &gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 uatomic_dec(&amp;r=
cu_gp_futex);<br>
&gt; &gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 uatomic_dec(&amp;r=
cu_gp.futex);<br>
&gt; &gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Write futex b=
efore read reader_gp */<br>
&gt; &gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 smp_mb_master(RC=
U_MB_GROUP);<br>
&gt; &gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
&gt; &gt; &gt; @@ -270,7 +261,7 @@ static void wait_for_readers(struct cds_=
list_head<br>
&gt; &gt; *input_readers,<br>
&gt; &gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (wait_loops =
=3D=3D RCU_QS_ACTIVE_ATTEMPTS) {<br>
&gt; &gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
/* Read reader_gp before write futex */<br>
&gt; &gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
smp_mb_master(RCU_MB_GROUP);<br>
&gt; &gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ua=
tomic_set(&amp;rcu_gp_futex, 0);<br>
&gt; &gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ua=
tomic_set(&amp;rcu_gp.futex, 0);<br>
&gt; &gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
&gt; &gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
&gt; &gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {<br>
&gt; &gt; &gt; @@ -289,7 +280,7 @@ static void wait_for_readers(struct cds_=
list_head<br>
&gt; &gt; *input_readers,<br>
&gt; &gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (wait_loops =
=3D=3D RCU_QS_ACTIVE_ATTEMPTS) {<br>
&gt; &gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
/* Read reader_gp before write futex */<br>
&gt; &gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt;=
 &gt; <a href=3D"javascript:;" onclick=3D"_e(event, &#39;cvml&#39;, &#39;lt=
tng-dev@lists.lttng.org&#39;)">lttng-dev@lists.lttng.org</a> &lt;javascript=
:;&gt;<br>
&gt; &gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-=
dev" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttn=
g-dev</a><br>
&gt; &gt;<br>
<br>
--<br>
Mathieu Desnoyers<br>
Operating System Efficiency R&amp;D Consultant<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.c=
om</a><br>
</blockquote>

--e89a8ff1c254340a7404d04663fc--


--===============1989499700==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1989499700==--
