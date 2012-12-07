From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] urcu: avoid false sharing for rcu_gp_ctr
Date: Fri, 7 Dec 2012 11:57:48 -0500
Message-ID: <20121207165748.GA12338__32586.9270171554$1354899506$gmane$org@Krystal>
References: <50C19575.2070802@cn.fujitsu.com> <20121207163234.GB11975@Krystal>
	<CACvQF50Y2wC3t=VMJ==574aHVvod+ipGA1K5hR97r_dRbcegkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Content-Disposition: inline
In-Reply-To: <CACvQF50Y2wC3t=VMJ==574aHVvod+ipGA1K5hR97r_dRbcegkw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Lai Jiangshan <eag0628@gmail.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, "ltt-dev@lists.casi.polymtl.ca" <ltt-dev@lists.casi.polymtl.ca>
List-Id: lttng-dev@lists.lttng.org

* Lai Jiangshan (eag0628@gmail.com) wrote:
> we can define rcu_gp_ctr and registry with aligned attribute, but it is not
> reliable way
> 
> We need only this:
> unsigned long rcu_gp_ctr __attribute((aligned and padded(don't put other
> var next to it except the futex)))

In which situation would this be unreliable ?

Thanks,

Mathieu

> 
> On Saturday, December 8, 2012, Mathieu Desnoyers wrote:
> 
> > * Lai Jiangshan (laijs@cn.fujitsu.com <javascript:;>) wrote:
> > > @rcu_gp_ctr and @registry share the same cache line, it causes
> > > false sharing and slowdown both of the read site and update site.
> > >
> > > Fix: Use different cache line for them.
> > >
> > > Although rcu_gp_futex is updated less than rcu_gp_ctr, but
> > > they always be accessed at almost the same time, so we also move
> > rcu_gp_futex
> > > to the cacheline of rcu_gp_ctr to reduce the cacheline-usage or
> > cache-missing
> > > of read site.
> >
> > Hi Lai,
> >
> > I agree on the goal: placing registry and rcu_gp_ctr on different
> > cache-lines. And yes, it makes sense to put rcu_gp_ctr and rcu_gp_futex
> > on the same cache-line. I agree that the next patch is fine too (keeping
> > qsbr and other urcu similar). This is indeed what I try to ensure
> > myself.
> >
> > I'm just concerned that this patch seems to break ABI compability for
> > liburcu: the read-side, within applications, would have to be
> > recompiled. So I guess we should decide if we do this change in a way
> > that does not break the ABI (e.g. not introducing a structure), or if we
> > choose to bump the library version number.
> >
> > Thoughts ?
> >
> > Thanks,
> >
> > Mathieu
> >
> > >
> > >
> > > test: (4X6=24 CPUs)
> > >
> > > Before patch:
> > >
> > > [root@localhost userspace-rcu]# ./tests/test_urcu_mb 20 1 20
> > > SUMMARY ./tests/test_urcu_mb      testdur   20 nr_readers  20 rdur
> >  0 wdur      0 nr_writers   1 wdelay      0 nr_reads   2100285330 nr_writes
> >      3390219 nr_ops   2103675549
> > > [root@localhost userspace-rcu]# ./tests/test_urcu_mb 20 1 20
> > > SUMMARY ./tests/test_urcu_mb      testdur   20 nr_readers  20 rdur
> >  0 wdur      0 nr_writers   1 wdelay      0 nr_reads   1619868562 nr_writes
> >      3529478 nr_ops   1623398040
> > > [root@localhost userspace-rcu]# ./tests/test_urcu_mb 20 1 20
> > > SUMMARY ./tests/test_urcu_mb      testdur   20 nr_readers  20 rdur
> >  0 wdur      0 nr_writers   1 wdelay      0 nr_reads   1949067038 nr_writes
> >      3469334 nr_ops   1952536372
> > >
> > >
> > > after patch:
> > >
> > > [root@localhost userspace-rcu]# ./tests/test_urcu_mb 20 1 20
> > > SUMMARY ./tests/test_urcu_mb      testdur   20 nr_readers  20 rdur
> >  0 wdur      0 nr_writers   1 wdelay      0 nr_reads   3380191848 nr_writes
> >      4903248 nr_ops   3385095096
> > > [root@localhost userspace-rcu]# ./tests/test_urcu_mb 20 1 20
> > > SUMMARY ./tests/test_urcu_mb      testdur   20 nr_readers  20 rdur
> >  0 wdur      0 nr_writers   1 wdelay      0 nr_reads   3397637486 nr_writes
> >      4129809 nr_ops   3401767295
> > >
> > > Singed-by: Lai Jiangshan <laijs@cn.fujitsu.com <javascript:;>>
> > > ---
> > > diff --git a/urcu.c b/urcu.c
> > > index 15def09..436d71c 100644
> > > --- a/urcu.c
> > > +++ b/urcu.c
> > > @@ -83,16 +83,7 @@ void __attribute__((destructor)) rcu_exit(void);
> > >  #endif
> > >
> > >  static pthread_mutex_t rcu_gp_lock = PTHREAD_MUTEX_INITIALIZER;
> > > -
> > > -int32_t rcu_gp_futex;
> > > -
> > > -/*
> > > - * Global grace period counter.
> > > - * Contains the current RCU_GP_CTR_PHASE.
> > > - * Also has a RCU_GP_COUNT of 1, to accelerate the reader fast path.
> > > - * Written to only by writer with mutex taken. Read by both writer and
> > readers.
> > > - */
> > > -unsigned long rcu_gp_ctr = RCU_GP_COUNT;
> > > +struct urcu_gp rcu_gp = { .ctr = RCU_GP_COUNT };
> > >
> > >  /*
> > >   * Written to only by each individual reader. Read by both the reader
> > and the
> > > @@ -217,8 +208,8 @@ static void wait_gp(void)
> > >  {
> > >       /* Read reader_gp before read futex */
> > >       smp_mb_master(RCU_MB_GROUP);
> > > -     if (uatomic_read(&rcu_gp_futex) == -1)
> > > -             futex_async(&rcu_gp_futex, FUTEX_WAIT, -1,
> > > +     if (uatomic_read(&rcu_gp.futex) == -1)
> > > +             futex_async(&rcu_gp.futex, FUTEX_WAIT, -1,
> > >                     NULL, NULL, 0);
> > >  }
> > >
> > > @@ -232,12 +223,12 @@ static void wait_for_readers(struct cds_list_head
> > *input_readers,
> > >       /*
> > >        * Wait for each thread URCU_TLS(rcu_reader).ctr to either
> > >        * indicate quiescence (not nested), or observe the current
> > > -      * rcu_gp_ctr value.
> > > +      * rcu_gp.ctr value.
> > >        */
> > >       for (;;) {
> > >               wait_loops++;
> > >               if (wait_loops == RCU_QS_ACTIVE_ATTEMPTS) {
> > > -                     uatomic_dec(&rcu_gp_futex);
> > > +                     uatomic_dec(&rcu_gp.futex);
> > >                       /* Write futex before read reader_gp */
> > >                       smp_mb_master(RCU_MB_GROUP);
> > >               }
> > > @@ -270,7 +261,7 @@ static void wait_for_readers(struct cds_list_head
> > *input_readers,
> > >                       if (wait_loops == RCU_QS_ACTIVE_ATTEMPTS) {
> > >                               /* Read reader_gp before write futex */
> > >                               smp_mb_master(RCU_MB_GROUP);
> > > -                             uatomic_set(&rcu_gp_futex, 0);
> > > +                             uatomic_set(&rcu_gp.futex, 0);
> > >                       }
> > >                       break;
> > >               } else {
> > > @@ -289,7 +280,7 @@ static void wait_for_readers(struct cds_list_head
> > *input_readers,
> > >                       if (wait_loops == RCU_QS_ACTIVE_ATTEMPTS) {
> > >                               /* Read reader_gp before write futex */
> > >                               smp_mb_master(RCU_MB_GROUP);
> > > -                             uatomic_set(&rcu_gp_futex, 0);
> > > +                             uatomic_set(&rcu_gp.futex, 0);
> > >                       }
> > >                       break;
> > >               } else {
> > > @@ -357,10 +348,10 @@ void synchronize_rcu(void)
> > >
> > >       /*
> > >        * Must finish waiting for quiescent state for original parity
> > before
> > > -      * committing next rcu_gp_ctr update to memory. Failure to do so
> > could
> > > +      * committing next rcu_gp.ctr update to memory. Failure to do so
> > could
> > >        * result in the writer waiting forever while new readers are
> > always
> > >        * accessing data (no progress).  Enforce compiler-order of load
> > > -      * URCU_TLS(rcu_reader).ctr before store to rcu_gp_ctr.
> > > +      * URCU_TLS(rcu_reader).ctr before store to rcu_gp.ctr.
> > >        */
> > >       cmm_barrier();
> > >
> > > @@ -372,13 +363,13 @@ void synchronize_rcu(void)
> > >       cmm_smp_mb();
> > >
> > >       /* Switch parity: 0 -> 1, 1 -> 0 */
> > > -     CMM_STORE_SHARED(rcu_gp_ctr, rcu_gp_ctr ^ RCU_GP_CTR_PHASE);
> > > +     CMM_STORE_SHARED(rcu_gp.ctr, rcu_gp.ctr ^ RCU_GP_CTR_PHASE);
> > >
> > >       /*
> > > -      * Must commit rcu_gp_ctr update to memory before waiting for
> > quiescent
> > > +      * Must commit rcu_gp.ctr update to memory before waiting for
> > quiescent
> > >        * state. Failure to do so could result in the writer waiting
> > forever
> > >        * while new readers are always accessing data (no progress).
> > Enforce
> > > -      * compiler-order of store to rcu_gp_ctr before load rcu_reader
> > ctr.
> > > +      * compiler-order of store to rcu_gp.ctr before load rcu_reader
> > ctr.
> > >        */
> > >       cmm_barrier();
> > >
> > > diff --git a/urcu/static/urcu.h b/urcu/static/urcu.h
> > > index 973826a..0dd733e 100644
> > > --- a/urcu/static/urcu.h
> > > +++ b/urcu/static/urcu.h
> > > @@ -213,12 +213,20 @@ static inline void smp_mb_slave(int group)
> > >  #define RCU_GP_CTR_PHASE     (1UL << (sizeof(unsigned long) << 2))
> > >  #define RCU_GP_CTR_NEST_MASK (RCU_GP_CTR_PHASE - 1)
> > >
> > > -/*
> > > - * Global quiescent period counter with low-order bits unused.
> > > - * Using a int rather than a char to eliminate false register
> > dependencies
> > > - * causing stalls on some architectures.
> > > - */
> > > -extern unsigned long rcu_gp_ctr;
> > > +struct urcu_gp {
> > > +     /*
> > > +      * Global grace period counter.
> > > +      * Contains the current RCU_GP_CTR_PHASE.
> > > +      * Also has a RCU_GP_COUNT of 1, to accelerate the reader fast
> > path.
> > > +      * Written to only by writer with mutex taken.
> > > +      * Read by both writer and readers.
> > > +      */
> > > +     unsigned long ctr;
> > > +
> > > +     int32_t futex;
> > > +} __attribute__((aligned(CAA_CACHE_LINE_SIZE)));
> > > +
> > > +extern struct urcu_gp rcu_gp;
> > >
> > >  struct rcu_reader {
> > >       /* Data used by both reader and synchronize_rcu() */
> > > @@ -231,16 +239,14 @@ struct rcu_reader {
> > >
> > >  extern DECLARE_URCU_TLS(struct rcu_reader, rcu_reader);
> > >
> > > -extern int32_t rcu_gp_futex;
> > > -
> > >  /*
> > >   * Wake-up waiting synchronize_rcu(). Called from many concurrent
> > threads.
> > >   */
> > >  static inline void wake_up_gp(void)
> > >  {
> > > -     if (caa_unlikely(uatomic_read(&rcu_gp_futex) == -1)) {
> > > -             uatomic_set(&rcu_gp_futex, 0);
> > > -             futex_async(&rcu_gp_futex, FUTEX_WAKE, 1,
> > > +     if (caa_unlikely(uatomic_read(&rcu_gp.futex) == -1)) {
> > > +             uatomic_set(&rcu_gp.futex, 0);
> > > +             futex_async(&rcu_gp.futex, FUTEX_WAKE, 1,
> > >                     NULL, NULL, 0);
> > >       }
> > >  }
> > > @@ -256,13 +262,13 @@ static inline enum rcu_state
> > rcu_reader_state(unsigned long *ctr)
> > >       v = CMM_LOAD_SHARED(*ctr);
> > >       if (!(v & RCU_GP_CTR_NEST_MASK))
> > >               return RCU_READER_INACTIVE;
> > > -     if (!((v ^ rcu_gp_ctr) & RCU_GP_CTR_PHASE))
> > > +     if (!((v ^ rcu_gp.ctr) & RCU_GP_CTR_PHASE))
> > >               return RCU_READER_ACTIVE_CURRENT;
> > >       return RCU_READER_ACTIVE_OLD;
> > >  }
> > >
> > >  /*
> > > - * Helper for _rcu_read_lock().  The format of rcu_gp_ctr (as well as
> > > + * Helper for _rcu_read_lock().  The format of rcu_gp.ctr (as well as
> > >   * the per-thread rcu_reader.ctr) has the upper bits containing a count
> > of
> > >   * _rcu_read_lock() nesting, and a lower-order bit that contains either
> > zero
> > >   * or RCU_GP_CTR_PHASE.  The smp_mb_slave() ensures that the accesses in
> > > @@ -271,7 +277,7 @@ static inline enum rcu_state
> > rcu_reader_state(unsigned long *ctr)
> > >  static inline void _rcu_read_lock_update(unsigned long tmp)
> > >  {
> > >       if (caa_likely(!(tmp & RCU_GP_CTR_NEST_MASK))) {
> > > -             _CMM_STORE_SHARED(URCU_TLS(rcu_reader).ctr,
> > _CMM_LOAD_SHARED(rcu_gp_ctr));
> > > +             _CMM_STORE_SHARED(URCU_TLS(rcu_reader).ctr,
> > _CMM_LOAD_SHARED(rcu_gp.ctr));
> > >               smp_mb_slave(RCU_MB_GROUP);
> > >       } else
> > >               _CMM_STORE_SHARED(URCU_TLS(rcu_reader).ctr, tmp +
> > RCU_GP_COUNT);
> >
> > --
> > Mathieu Desnoyers
> > Operating System Efficiency R&D Consultant
> > EfficiOS Inc.
> > http://www.efficios.com
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org <javascript:;>
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
