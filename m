From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH V2] urcu: avoid false sharing for rcu_gp_ctr
Date: Tue, 11 Dec 2012 07:38:03 -0500
Message-ID: <20121211123802.GA4356__48468.1277921938$1355229561$gmane$org@Krystal>
References: <50C19575.2070802@cn.fujitsu.com> <20121207163234.GB11975@Krystal>
	<CACvQF50Y2wC3t=VMJ==574aHVvod+ipGA1K5hR97r_dRbcegkw@mail.gmail.com>
	<20121207165748.GA12338@Krystal>
	<CACvQF50V_9T6T3j4AwbdBuEiHHbcxdNGgP1WF5T4OHpXZyMgEA@mail.gmail.com>
	<20121207172252.GA12525@Krystal>
	<20121210150417.GR2516@linux.vnet.ibm.com>
	<20121210180111.GA11209@Krystal>
	<20121210234854.GK2516@linux.vnet.ibm.com>
	<50C6D2AB.9070100@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TiP66-0006ke-NF
	for lttng-dev@lists.lttng.org; Tue, 11 Dec 2012 07:38:06 -0500
Content-Disposition: inline
In-Reply-To: <50C6D2AB.9070100@cn.fujitsu.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Lai Jiangshan <laijs@cn.fujitsu.com>
Cc: Lai Jiangshan <eag0628@gmail.com>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, paulmck@linux.vnet.ibm.com
List-Id: lttng-dev@lists.lttng.org

* Lai Jiangshan (laijs@cn.fujitsu.com) wrote:
> From 66f50786b9d5f1bcf2ad56e3a9ab905005c6cd90 Mon Sep 17 00:00:00 2001
> From: Lai Jiangshan <laijs@cn.fujitsu.com>
> Date: Tue, 11 Dec 2012 14:24:44 +0800
> Subject: [PATCH] urcu: avoid false sharing for rcu_gp_ctr
> 
> @rcu_gp_ctr and @registry share the same cache line, it causes
> false sharing and slowdown both of the read site and update site.
> 
> Fix: Use different cache line for them.
> 
> Although rcu_gp_futex is updated less than rcu_gp_ctr, but
> they always be accessed at almost the same time, so we also move rcu_gp_futex
> to the cacheline of rcu_gp_ctr to reduce the cacheline-usage or cache-missing
> of read site.
> 
> test: (4X6=24 CPUs)
> 
> Before patch:
> 
> [root@localhost userspace-rcu]# ./tests/test_urcu_mb 20 1 20
> SUMMARY ./tests/test_urcu_mb      testdur   20 nr_readers  20 rdur      0 wdur      0 nr_writers   1 wdelay      0 nr_reads   2100285330 nr_writes      3390219 nr_ops   2103675549
> [root@localhost userspace-rcu]# ./tests/test_urcu_mb 20 1 20
> SUMMARY ./tests/test_urcu_mb      testdur   20 nr_readers  20 rdur      0 wdur      0 nr_writers   1 wdelay      0 nr_reads   1619868562 nr_writes      3529478 nr_ops   1623398040
> [root@localhost userspace-rcu]# ./tests/test_urcu_mb 20 1 20
> SUMMARY ./tests/test_urcu_mb      testdur   20 nr_readers  20 rdur      0 wdur      0 nr_writers   1 wdelay      0 nr_reads   1949067038 nr_writes      3469334 nr_ops   1952536372
> 
> after patch:
> 
> [root@localhost userspace-rcu]# ./tests/test_urcu_mb 20 1 20
> SUMMARY ./tests/test_urcu_mb      testdur   20 nr_readers  20 rdur      0 wdur      0 nr_writers   1 wdelay      0 nr_reads   3380191848 nr_writes      4903248 nr_ops   3385095096
> [root@localhost userspace-rcu]# ./tests/test_urcu_mb 20 1 20
> SUMMARY ./tests/test_urcu_mb      testdur   20 nr_readers  20 rdur      0 wdur      0 nr_writers   1 wdelay      0 nr_reads   3397637486 nr_writes      4129809 nr_ops   3401767295
> 
> Signed-off-by: Lai Jiangshan <laijs@cn.fujitsu.com>
> ---
>  Makefile.am              |   10 +++++-----
>  compat_rcu_gp.lds        |   25 +++++++++++++++++++++++++
>  compat_rcu_gp_bp.lds     |   24 ++++++++++++++++++++++++
>  compat_rcu_gp_mb.lds     |   25 +++++++++++++++++++++++++
>  compat_rcu_gp_qsbr.lds   |   25 +++++++++++++++++++++++++
>  compat_rcu_gp_signal.lds |   25 +++++++++++++++++++++++++
>  urcu-bp.c                |   14 ++++----------
>  urcu-qsbr.c              |   35 +++++++++++++++--------------------
>  urcu.c                   |   34 +++++++++++++---------------------
>  urcu/map/urcu-bp.h       |    3 +--
>  urcu/map/urcu-qsbr.h     |    3 +--
>  urcu/map/urcu.h          |    9 +++------
>  urcu/static/urcu-bp.h    |   23 ++++++++++++++---------
>  urcu/static/urcu-qsbr.h  |   39 ++++++++++++++++++++++++---------------
>  urcu/static/urcu.h       |   38 ++++++++++++++++++++++++--------------
>  15 files changed, 228 insertions(+), 104 deletions(-)
>  create mode 100644 compat_rcu_gp.lds
>  create mode 100644 compat_rcu_gp_bp.lds
>  create mode 100644 compat_rcu_gp_mb.lds
>  create mode 100644 compat_rcu_gp_qsbr.lds
>  create mode 100644 compat_rcu_gp_signal.lds
> 
> diff --git a/Makefile.am b/Makefile.am
> index 0a4d357..b2b7b6a 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -56,21 +56,21 @@ lib_LTLIBRARIES = liburcu-common.la \
>  #
>  liburcu_common_la_SOURCES = wfqueue.c wfcqueue.c wfstack.c $(COMPAT)
>  
> -liburcu_la_SOURCES = urcu.c urcu-pointer.c $(COMPAT)
> +liburcu_la_SOURCES = urcu.c urcu-pointer.c compat_rcu_gp.lds $(COMPAT)

Hrm, I tried your patch with "make V=1", and have not found any use of
those "lds" files. I'm not sure adding them as SOURCES is enough.

>  liburcu_la_LIBADD = liburcu-common.la
>  
> -liburcu_qsbr_la_SOURCES = urcu-qsbr.c urcu-pointer.c $(COMPAT)
> +liburcu_qsbr_la_SOURCES = urcu-qsbr.c urcu-pointer.c compat_rcu_gp_qsbr.lds $(COMPAT)
>  liburcu_qsbr_la_LIBADD = liburcu-common.la
>  
> -liburcu_mb_la_SOURCES = urcu.c urcu-pointer.c $(COMPAT)
> +liburcu_mb_la_SOURCES = urcu.c urcu-pointer.c compat_rcu_gp_mb.lds $(COMPAT)
>  liburcu_mb_la_CFLAGS = -DRCU_MB
>  liburcu_mb_la_LIBADD = liburcu-common.la
>  
> -liburcu_signal_la_SOURCES = urcu.c urcu-pointer.c $(COMPAT)
> +liburcu_signal_la_SOURCES = urcu.c urcu-pointer.c compat_rcu_gp_signal.lds $(COMPAT)
>  liburcu_signal_la_CFLAGS = -DRCU_SIGNAL
>  liburcu_signal_la_LIBADD = liburcu-common.la
>  
> -liburcu_bp_la_SOURCES = urcu-bp.c urcu-pointer.c $(COMPAT)
> +liburcu_bp_la_SOURCES = urcu-bp.c urcu-pointer.c compat_rcu_gp_bp.lds $(COMPAT)
>  liburcu_bp_la_LIBADD = liburcu-common.la
>  
>  liburcu_cds_la_SOURCES = rculfqueue.c rculfstack.c lfstack.c \
> diff --git a/compat_rcu_gp.lds b/compat_rcu_gp.lds
> new file mode 100644
> index 0000000..506a4ae
> --- /dev/null
> +++ b/compat_rcu_gp.lds
> @@ -0,0 +1,25 @@
> +/*
> + * compat_rcu_gp.lds
> + *
> + * Linker Script for compatibility of liburcu
> + *
> + * Copyright (c) 2012 Lai Jiangshan <laijs@cn.fujitsu.com>
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> + */
> +
> +rcu_gp_ctr_memb = rcu_gp_memb;
> +rcu_gp_futex_memb = rcu_gp_memb + 8;
> +
> diff --git a/compat_rcu_gp_bp.lds b/compat_rcu_gp_bp.lds
> new file mode 100644
> index 0000000..6ab7dfa
> --- /dev/null
> +++ b/compat_rcu_gp_bp.lds
> @@ -0,0 +1,24 @@
> +/*
> + * compat_rcu_gp_bp.lds
> + *
> + * Linker Script for compatibility of liburcu-bp
> + *
> + * Copyright (c) 2012 Lai Jiangshan <laijs@cn.fujitsu.com>
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> + */
> +
> +rcu_gp_ctr_bp = rcu_gp_bp;
> +
> diff --git a/compat_rcu_gp_mb.lds b/compat_rcu_gp_mb.lds
> new file mode 100644
> index 0000000..8313588
> --- /dev/null
> +++ b/compat_rcu_gp_mb.lds
> @@ -0,0 +1,25 @@
> +/*
> + * compat_rcu_gp_mb.lds
> + *
> + * Linker Script for compatibility of liburcu-mb
> + *
> + * Copyright (c) 2012 Lai Jiangshan <laijs@cn.fujitsu.com>
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> + */
> +
> +rcu_gp_ctr_mb = rcu_gp_mb;
> +rcu_gp_futex_mb = rcu_gp_mb + 8;
> +
> diff --git a/compat_rcu_gp_qsbr.lds b/compat_rcu_gp_qsbr.lds
> new file mode 100644
> index 0000000..d27e163
> --- /dev/null
> +++ b/compat_rcu_gp_qsbr.lds
> @@ -0,0 +1,25 @@
> +/*
> + * compat_rcu_gp_qsbr.lds
> + *
> + * Linker Script for compatibility of liburcu-qsbr
> + *
> + * Copyright (c) 2012 Lai Jiangshan <laijs@cn.fujitsu.com>
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> + */
> +
> +rcu_gp_ctr_qsbr = rcu_gp_qsbr;
> +rcu_gp_futex_qsbr = rcu_gp_qsbr + 8;
> +
> diff --git a/compat_rcu_gp_signal.lds b/compat_rcu_gp_signal.lds
> new file mode 100644
> index 0000000..f0a447d
> --- /dev/null
> +++ b/compat_rcu_gp_signal.lds
> @@ -0,0 +1,25 @@
> +/*
> + * compat_rcu_gp_signal.lds
> + *
> + * Linker Script for compatibility of liburcu-signal
> + *
> + * Copyright (c) 2012 Lai Jiangshan <laijs@cn.fujitsu.com>
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> + */
> +
> +rcu_gp_ctr_signal = rcu_gp_signal;
> +rcu_gp_futex_signal = rcu_gp_signal + 8;
> +
> diff --git a/urcu-bp.c b/urcu-bp.c
> index f99c0e5..2a2455b 100644
> --- a/urcu-bp.c
> +++ b/urcu-bp.c
> @@ -103,6 +103,8 @@ void *mremap_wrapper(void *old_address, size_t old_size,
>  void __attribute__((destructor)) rcu_bp_exit(void);
>  
>  static pthread_mutex_t rcu_gp_lock = PTHREAD_MUTEX_INITIALIZER;
> +/* Init the ctr as RCU_GP_COUNT, to accelerate the reader fast path. */
> +struct urcu_gp rcu_gp = { .ctr = RCU_GP_COUNT };
>  
>  #ifdef DEBUG_YIELD
>  unsigned int rcu_yield_active;
> @@ -110,14 +112,6 @@ DEFINE_URCU_TLS(unsigned int, rcu_rand_yield);
>  #endif
>  
>  /*
> - * Global grace period counter.
> - * Contains the current RCU_GP_CTR_PHASE.
> - * Also has a RCU_GP_COUNT of 1, to accelerate the reader fast path.
> - * Written to only by writer with mutex taken. Read by both writer and readers.
> - */
> -unsigned long rcu_gp_ctr = RCU_GP_COUNT;
> -
> -/*
>   * Pointer to registry elements. Written to only by each individual reader. Read
>   * by both the reader and the writers.
>   */
> @@ -174,7 +168,7 @@ static void wait_for_readers(struct cds_list_head *input_readers,
>  	/*
>  	 * Wait for each thread URCU_TLS(rcu_reader).ctr to either
>  	 * indicate quiescence (not nested), or observe the current
> -	 * rcu_gp_ctr value.
> +	 * rcu_gp.ctr value.
>  	 */
>  	for (;;) {
>  		wait_loops++;
> @@ -250,7 +244,7 @@ void synchronize_rcu(void)
>  	cmm_smp_mb();
>  
>  	/* Switch parity: 0 -> 1, 1 -> 0 */
> -	CMM_STORE_SHARED(rcu_gp_ctr, rcu_gp_ctr ^ RCU_GP_CTR_PHASE);
> +	CMM_STORE_SHARED(rcu_gp.ctr, rcu_gp.ctr ^ RCU_GP_CTR_PHASE);
>  
>  	/*
>  	 * Must commit qparity update to memory before waiting for other parity
> diff --git a/urcu-qsbr.c b/urcu-qsbr.c
> index 3c2c65d..5e2510d 100644
> --- a/urcu-qsbr.c
> +++ b/urcu-qsbr.c
> @@ -53,13 +53,8 @@
>  void __attribute__((destructor)) rcu_exit(void);
>  
>  static pthread_mutex_t rcu_gp_lock = PTHREAD_MUTEX_INITIALIZER;
> -
> -int32_t rcu_gp_futex;
> -
> -/*
> - * Global grace period counter.
> - */
> -unsigned long rcu_gp_ctr = RCU_GP_ONLINE;
> +/* Init the ctr as RCU_GP_ONLINE, to accelerate the reader fast path. */
> +struct urcu_gp rcu_gp = { { .ctr = RCU_GP_ONLINE } };
>  
>  /*
>   * Active attempts to check for reader Q.S. before calling futex().
> @@ -118,8 +113,8 @@ static void wait_gp(void)
>  {
>  	/* Read reader_gp before read futex */
>  	cmm_smp_rmb();
> -	if (uatomic_read(&rcu_gp_futex) == -1)
> -		futex_noasync(&rcu_gp_futex, FUTEX_WAIT, -1,
> +	if (uatomic_read(&rcu_gp.futex) == -1)
> +		futex_noasync(&rcu_gp.futex, FUTEX_WAIT, -1,
>  		      NULL, NULL, 0);
>  }
>  
> @@ -133,12 +128,12 @@ static void wait_for_readers(struct cds_list_head *input_readers,
>  	/*
>  	 * Wait for each thread URCU_TLS(rcu_reader).ctr to either
>  	 * indicate quiescence (offline), or for them to observe the
> -	 * current rcu_gp_ctr value.
> +	 * current rcu_gp.ctr value.
>  	 */
>  	for (;;) {
>  		wait_loops++;
>  		if (wait_loops >= RCU_QS_ACTIVE_ATTEMPTS) {
> -			uatomic_set(&rcu_gp_futex, -1);
> +			uatomic_set(&rcu_gp.futex, -1);
>  			/*
>  			 * Write futex before write waiting (the other side
>  			 * reads them in the opposite order).
> @@ -177,7 +172,7 @@ static void wait_for_readers(struct cds_list_head *input_readers,
>  			if (wait_loops >= RCU_QS_ACTIVE_ATTEMPTS) {
>  				/* Read reader_gp before write futex */
>  				cmm_smp_mb();
> -				uatomic_set(&rcu_gp_futex, 0);
> +				uatomic_set(&rcu_gp.futex, 0);
>  			}
>  			break;
>  		} else {
> @@ -253,11 +248,11 @@ void synchronize_rcu(void)
>  
>  	/*
>  	 * Must finish waiting for quiescent state for original parity
> -	 * before committing next rcu_gp_ctr update to memory. Failure
> +	 * before committing next rcu_gp.ctr update to memory. Failure
>  	 * to do so could result in the writer waiting forever while new
>  	 * readers are always accessing data (no progress).  Enforce
>  	 * compiler-order of load URCU_TLS(rcu_reader).ctr before store
> -	 * to rcu_gp_ctr.
> +	 * to rcu_gp.ctr.
>  	 */
>  	cmm_barrier();
>  
> @@ -269,13 +264,13 @@ void synchronize_rcu(void)
>  	cmm_smp_mb();
>  
>  	/* Switch parity: 0 -> 1, 1 -> 0 */
> -	CMM_STORE_SHARED(rcu_gp_ctr, rcu_gp_ctr ^ RCU_GP_CTR);
> +	CMM_STORE_SHARED(rcu_gp.ctr, rcu_gp.ctr ^ RCU_GP_CTR);
>  
>  	/*
> -	 * Must commit rcu_gp_ctr update to memory before waiting for
> +	 * Must commit rcu_gp.ctr update to memory before waiting for
>  	 * quiescent state. Failure to do so could result in the writer
>  	 * waiting forever while new readers are always accessing data
> -	 * (no progress). Enforce compiler-order of store to rcu_gp_ctr
> +	 * (no progress). Enforce compiler-order of store to rcu_gp.ctr
>  	 * before load URCU_TLS(rcu_reader).ctr.
>  	 */
>  	cmm_barrier();
> @@ -353,13 +348,13 @@ void synchronize_rcu(void)
>  		goto out;
>  
>  	/* Increment current G.P. */
> -	CMM_STORE_SHARED(rcu_gp_ctr, rcu_gp_ctr + RCU_GP_CTR);
> +	CMM_STORE_SHARED(rcu_gp.ctr, rcu_gp.ctr + RCU_GP_CTR);
>  
>  	/*
> -	 * Must commit rcu_gp_ctr update to memory before waiting for
> +	 * Must commit rcu_gp.ctr update to memory before waiting for
>  	 * quiescent state. Failure to do so could result in the writer
>  	 * waiting forever while new readers are always accessing data
> -	 * (no progress). Enforce compiler-order of store to rcu_gp_ctr
> +	 * (no progress). Enforce compiler-order of store to rcu_gp.ctr
>  	 * before load URCU_TLS(rcu_reader).ctr.
>  	 */
>  	cmm_barrier();
> diff --git a/urcu.c b/urcu.c
> index 15def09..782c42e 100644
> --- a/urcu.c
> +++ b/urcu.c
> @@ -83,16 +83,8 @@ void __attribute__((destructor)) rcu_exit(void);
>  #endif
>  
>  static pthread_mutex_t rcu_gp_lock = PTHREAD_MUTEX_INITIALIZER;
> -
> -int32_t rcu_gp_futex;
> -
> -/*
> - * Global grace period counter.
> - * Contains the current RCU_GP_CTR_PHASE.
> - * Also has a RCU_GP_COUNT of 1, to accelerate the reader fast path.
> - * Written to only by writer with mutex taken. Read by both writer and readers.
> - */
> -unsigned long rcu_gp_ctr = RCU_GP_COUNT;
> +/* Init the ctr as RCU_GP_COUNT, to accelerate the reader fast path. */
> +struct urcu_gp rcu_gp = { { .ctr = RCU_GP_COUNT } };
>  
>  /*
>   * Written to only by each individual reader. Read by both the reader and the
> @@ -217,8 +209,8 @@ static void wait_gp(void)
>  {
>  	/* Read reader_gp before read futex */
>  	smp_mb_master(RCU_MB_GROUP);
> -	if (uatomic_read(&rcu_gp_futex) == -1)
> -		futex_async(&rcu_gp_futex, FUTEX_WAIT, -1,
> +	if (uatomic_read(&rcu_gp.futex) == -1)
> +		futex_async(&rcu_gp.futex, FUTEX_WAIT, -1,
>  		      NULL, NULL, 0);
>  }
>  
> @@ -232,12 +224,12 @@ static void wait_for_readers(struct cds_list_head *input_readers,
>  	/*
>  	 * Wait for each thread URCU_TLS(rcu_reader).ctr to either
>  	 * indicate quiescence (not nested), or observe the current
> -	 * rcu_gp_ctr value.
> +	 * rcu_gp.ctr value.
>  	 */
>  	for (;;) {
>  		wait_loops++;
>  		if (wait_loops == RCU_QS_ACTIVE_ATTEMPTS) {
> -			uatomic_dec(&rcu_gp_futex);
> +			uatomic_dec(&rcu_gp.futex);
>  			/* Write futex before read reader_gp */
>  			smp_mb_master(RCU_MB_GROUP);
>  		}
> @@ -270,7 +262,7 @@ static void wait_for_readers(struct cds_list_head *input_readers,
>  			if (wait_loops == RCU_QS_ACTIVE_ATTEMPTS) {
>  				/* Read reader_gp before write futex */
>  				smp_mb_master(RCU_MB_GROUP);
> -				uatomic_set(&rcu_gp_futex, 0);
> +				uatomic_set(&rcu_gp.futex, 0);
>  			}
>  			break;
>  		} else {
> @@ -289,7 +281,7 @@ static void wait_for_readers(struct cds_list_head *input_readers,
>  			if (wait_loops == RCU_QS_ACTIVE_ATTEMPTS) {
>  				/* Read reader_gp before write futex */
>  				smp_mb_master(RCU_MB_GROUP);
> -				uatomic_set(&rcu_gp_futex, 0);
> +				uatomic_set(&rcu_gp.futex, 0);
>  			}
>  			break;
>  		} else {
> @@ -357,10 +349,10 @@ void synchronize_rcu(void)
>  
>  	/*
>  	 * Must finish waiting for quiescent state for original parity before
> -	 * committing next rcu_gp_ctr update to memory. Failure to do so could
> +	 * committing next rcu_gp.ctr update to memory. Failure to do so could
>  	 * result in the writer waiting forever while new readers are always
>  	 * accessing data (no progress).  Enforce compiler-order of load
> -	 * URCU_TLS(rcu_reader).ctr before store to rcu_gp_ctr.
> +	 * URCU_TLS(rcu_reader).ctr before store to rcu_gp.ctr.
>  	 */
>  	cmm_barrier();
>  
> @@ -372,13 +364,13 @@ void synchronize_rcu(void)
>  	cmm_smp_mb();
>  
>  	/* Switch parity: 0 -> 1, 1 -> 0 */
> -	CMM_STORE_SHARED(rcu_gp_ctr, rcu_gp_ctr ^ RCU_GP_CTR_PHASE);
> +	CMM_STORE_SHARED(rcu_gp.ctr, rcu_gp.ctr ^ RCU_GP_CTR_PHASE);
>  
>  	/*
> -	 * Must commit rcu_gp_ctr update to memory before waiting for quiescent
> +	 * Must commit rcu_gp.ctr update to memory before waiting for quiescent
>  	 * state. Failure to do so could result in the writer waiting forever
>  	 * while new readers are always accessing data (no progress). Enforce
> -	 * compiler-order of store to rcu_gp_ctr before load rcu_reader ctr.
> +	 * compiler-order of store to rcu_gp.ctr before load rcu_reader ctr.
>  	 */
>  	cmm_barrier();
>  
> diff --git a/urcu/map/urcu-bp.h b/urcu/map/urcu-bp.h
> index 63582fd..0464d3b 100644
> --- a/urcu/map/urcu-bp.h
> +++ b/urcu/map/urcu-bp.h
> @@ -44,8 +44,7 @@
>  #define rcu_exit			rcu_exit_bp
>  #define synchronize_rcu			synchronize_rcu_bp
>  #define rcu_reader			rcu_reader_bp
> -#define rcu_gp_ctr			rcu_gp_ctr_bp
> -#define rcu_gp_futex			rcu_gp_futex_bp	/* unused */
> +#define rcu_gp				rcu_gp_bp
>  
>  #define get_cpu_call_rcu_data		get_cpu_call_rcu_data_bp
>  #define get_call_rcu_thread		get_call_rcu_thread_bp
> diff --git a/urcu/map/urcu-qsbr.h b/urcu/map/urcu-qsbr.h
> index f0aecc9..2c22baf 100644
> --- a/urcu/map/urcu-qsbr.h
> +++ b/urcu/map/urcu-qsbr.h
> @@ -47,8 +47,7 @@
>  #define rcu_exit			rcu_exit_qsbr
>  #define synchronize_rcu			synchronize_rcu_qsbr
>  #define rcu_reader			rcu_reader_qsbr
> -#define rcu_gp_ctr			rcu_gp_ctr_qsbr
> -#define rcu_gp_futex			rcu_gp_futex_qsbr
> +#define rcu_gp				rcu_gp_qsbr
>  
>  #define get_cpu_call_rcu_data		get_cpu_call_rcu_data_qsbr
>  #define get_call_rcu_thread		get_call_rcu_thread_qsbr
> diff --git a/urcu/map/urcu.h b/urcu/map/urcu.h
> index 759cb41..5ef3d4f 100644
> --- a/urcu/map/urcu.h
> +++ b/urcu/map/urcu.h
> @@ -75,8 +75,7 @@
>  #define rcu_exit			rcu_exit_memb
>  #define synchronize_rcu			synchronize_rcu_memb
>  #define rcu_reader			rcu_reader_memb
> -#define rcu_gp_ctr			rcu_gp_ctr_memb
> -#define rcu_gp_futex			rcu_gp_futex_memb
> +#define rcu_gp				rcu_gp_memb
>  
>  #define get_cpu_call_rcu_data		get_cpu_call_rcu_data_memb
>  #define get_call_rcu_thread		get_call_rcu_thread_memb
> @@ -121,8 +120,7 @@
>  #define rcu_exit			rcu_exit_sig
>  #define synchronize_rcu			synchronize_rcu_sig
>  #define rcu_reader			rcu_reader_sig
> -#define rcu_gp_ctr			rcu_gp_ctr_sig
> -#define rcu_gp_futex			rcu_gp_futex_sig
> +#define rcu_gp				rcu_gp_sig
>  
>  #define get_cpu_call_rcu_data		get_cpu_call_rcu_data_sig
>  #define get_call_rcu_thread		get_call_rcu_thread_sig
> @@ -164,8 +162,7 @@
>  #define rcu_exit			rcu_exit_mb
>  #define synchronize_rcu			synchronize_rcu_mb
>  #define rcu_reader			rcu_reader_mb
> -#define rcu_gp_ctr			rcu_gp_ctr_mb
> -#define rcu_gp_futex			rcu_gp_futex_mb
> +#define rcu_gp				rcu_gp_mb
>  
>  #define get_cpu_call_rcu_data		get_cpu_call_rcu_data_mb
>  #define get_call_rcu_thread		get_call_rcu_thread_mb
> diff --git a/urcu/static/urcu-bp.h b/urcu/static/urcu-bp.h
> index c7f5326..a773a01 100644
> --- a/urcu/static/urcu-bp.h
> +++ b/urcu/static/urcu-bp.h
> @@ -130,12 +130,17 @@ static inline void rcu_debug_yield_init(void)
>   */
>  extern void rcu_bp_register(void);
>  
> -/*
> - * Global quiescent period counter with low-order bits unused.
> - * Using a int rather than a char to eliminate false register dependencies
> - * causing stalls on some architectures.
> - */
> -extern unsigned long rcu_gp_ctr;
> +struct urcu_gp {
> +	/*
> +	 * Global quiescent period counter with low-order bits unused.
> +	 * Contains the current RCU_GP_CTR_PHASE.
> +	 * Written to only by writer with mutex taken.
> +	 * Read by both writer and readers.
> +	 */
> +	unsigned long ctr;
> +} __attribute__((aligned(CAA_CACHE_LINE_SIZE)));
> +
> +extern struct urcu_gp rcu_gp;
>  
>  struct rcu_reader {
>  	/* Data used by both reader and synchronize_rcu() */
> @@ -166,13 +171,13 @@ static inline enum rcu_state rcu_reader_state(unsigned long *ctr)
>  	v = CMM_LOAD_SHARED(*ctr);
>  	if (!(v & RCU_GP_CTR_NEST_MASK))
>  		return RCU_READER_INACTIVE;
> -	if (!((v ^ rcu_gp_ctr) & RCU_GP_CTR_PHASE))
> +	if (!((v ^ rcu_gp.ctr) & RCU_GP_CTR_PHASE))
>  		return RCU_READER_ACTIVE_CURRENT;
>  	return RCU_READER_ACTIVE_OLD;
>  }
>  
>  /*
> - * Helper for _rcu_read_lock().  The format of rcu_gp_ctr (as well as
> + * Helper for _rcu_read_lock().  The format of rcu_gp.ctr (as well as
>   * the per-thread rcu_reader.ctr) has the upper bits containing a count of
>   * _rcu_read_lock() nesting, and a lower-order bit that contains either zero
>   * or RCU_GP_CTR_PHASE.  The smp_mb_slave() ensures that the accesses in
> @@ -181,7 +186,7 @@ static inline enum rcu_state rcu_reader_state(unsigned long *ctr)
>  static inline void _rcu_read_lock_update(unsigned long tmp)
>  {
>  	if (caa_likely(!(tmp & RCU_GP_CTR_NEST_MASK))) {
> -		_CMM_STORE_SHARED(URCU_TLS(rcu_reader)->ctr, _CMM_LOAD_SHARED(rcu_gp_ctr));
> +		_CMM_STORE_SHARED(URCU_TLS(rcu_reader)->ctr, _CMM_LOAD_SHARED(rcu_gp.ctr));
>  		cmm_smp_mb();
>  	} else
>  		_CMM_STORE_SHARED(URCU_TLS(rcu_reader)->ctr, tmp + RCU_GP_COUNT);
> diff --git a/urcu/static/urcu-qsbr.h b/urcu/static/urcu-qsbr.h
> index f6e5580..d7a1e1c 100644
> --- a/urcu/static/urcu-qsbr.h
> +++ b/urcu/static/urcu-qsbr.h
> @@ -119,12 +119,23 @@ static inline void rcu_debug_yield_init(void)
>  #define RCU_GP_ONLINE		(1UL << 0)
>  #define RCU_GP_CTR		(1UL << 1)
>  
> -/*
> - * Global quiescent period counter with low-order bits unused.
> - * Using a int rather than a char to eliminate false register dependencies
> - * causing stalls on some architectures.
> - */
> -extern unsigned long rcu_gp_ctr;
> +struct urcu_gp {
> +	union {
> +		/*
> +		 * Global quiescent period counter with low-order bits unused.
> +		 * Using a int rather than a char to eliminate false register
> +		 * dependencies causing stalls on some architectures.
> +		 */
> +		unsigned long ctr;
> +
> +		/* ensure the futex is located at offset=8 */

The comment could probably be more verbose:

   /*
    * Ensure futex field is located at offset=8 for backward
    * compatibility linker script.
    */

> +		int64_t __unused;

I would be tempted to do:

urcu-linker.h:

#define URCU_GP_FUTEX_OFFSET    8

and use a
                char __unused[URCU_GP_FUTEX_OFFSET];

in the structure (and use this macro in the linker scripts as well).

The advantage of using a char rather than a int64_t is that it won't get
in the way of type pruning, and will allow more aliasing analysis to
take place: AFAIK, adding a int64_t aliased with a unsigned long within a union
requires that a compiler doing type pruning considers that those two
types can alias pretty much anywhere in a file including our header.

Thanks,

Mathieu


> +	};
> +
> +	int32_t futex;
> +} __attribute__((aligned(CAA_CACHE_LINE_SIZE)));
> +
> +extern struct urcu_gp rcu_gp;
>  
>  struct rcu_reader {
>  	/* Data used by both reader and synchronize_rcu() */
> @@ -137,8 +148,6 @@ struct rcu_reader {
>  
>  extern DECLARE_URCU_TLS(struct rcu_reader, rcu_reader);
>  
> -extern int32_t rcu_gp_futex;
> -
>  /*
>   * Wake-up waiting synchronize_rcu(). Called from many concurrent threads.
>   */
> @@ -147,10 +156,10 @@ static inline void wake_up_gp(void)
>  	if (caa_unlikely(_CMM_LOAD_SHARED(URCU_TLS(rcu_reader).waiting))) {
>  		_CMM_STORE_SHARED(URCU_TLS(rcu_reader).waiting, 0);
>  		cmm_smp_mb();
> -		if (uatomic_read(&rcu_gp_futex) != -1)
> +		if (uatomic_read(&rcu_gp.futex) != -1)
>  			return;
> -		uatomic_set(&rcu_gp_futex, 0);
> -		futex_noasync(&rcu_gp_futex, FUTEX_WAKE, 1,
> +		uatomic_set(&rcu_gp.futex, 0);
> +		futex_noasync(&rcu_gp.futex, FUTEX_WAKE, 1,
>  		      NULL, NULL, 0);
>  	}
>  }
> @@ -162,7 +171,7 @@ static inline enum rcu_state rcu_reader_state(unsigned long *ctr)
>  	v = CMM_LOAD_SHARED(*ctr);
>  	if (!v)
>  		return RCU_READER_INACTIVE;
> -	if (v == rcu_gp_ctr)
> +	if (v == rcu_gp.ctr)
>  		return RCU_READER_ACTIVE_CURRENT;
>  	return RCU_READER_ACTIVE_OLD;
>  }
> @@ -216,7 +225,7 @@ static inline void _rcu_quiescent_state_update_and_wakeup(unsigned long gp_ctr)
>   * to be invoked directly from non-LGPL code.
>   *
>   * We skip the memory barriers and gp store if our local ctr already
> - * matches the global rcu_gp_ctr value: this is OK because a prior
> + * matches the global rcu_gp.ctr value: this is OK because a prior
>   * _rcu_quiescent_state() or _rcu_thread_online() already updated it
>   * within our thread, so we have no quiescent state to report.
>   */
> @@ -224,7 +233,7 @@ static inline void _rcu_quiescent_state(void)
>  {
>  	unsigned long gp_ctr;
>  
> -	if ((gp_ctr = CMM_LOAD_SHARED(rcu_gp_ctr)) == URCU_TLS(rcu_reader).ctr)
> +	if ((gp_ctr = CMM_LOAD_SHARED(rcu_gp.ctr)) == URCU_TLS(rcu_reader).ctr)
>  		return;
>  	_rcu_quiescent_state_update_and_wakeup(gp_ctr);
>  }
> @@ -257,7 +266,7 @@ static inline void _rcu_thread_offline(void)
>  static inline void _rcu_thread_online(void)
>  {
>  	cmm_barrier();	/* Ensure the compiler does not reorder us with mutex */
> -	_CMM_STORE_SHARED(URCU_TLS(rcu_reader).ctr, CMM_LOAD_SHARED(rcu_gp_ctr));
> +	_CMM_STORE_SHARED(URCU_TLS(rcu_reader).ctr, CMM_LOAD_SHARED(rcu_gp.ctr));
>  	cmm_smp_mb();
>  }
>  
> diff --git a/urcu/static/urcu.h b/urcu/static/urcu.h
> index 973826a..d23e673 100644
> --- a/urcu/static/urcu.h
> +++ b/urcu/static/urcu.h
> @@ -213,12 +213,24 @@ static inline void smp_mb_slave(int group)
>  #define RCU_GP_CTR_PHASE	(1UL << (sizeof(unsigned long) << 2))
>  #define RCU_GP_CTR_NEST_MASK	(RCU_GP_CTR_PHASE - 1)
>  
> -/*
> - * Global quiescent period counter with low-order bits unused.
> - * Using a int rather than a char to eliminate false register dependencies
> - * causing stalls on some architectures.
> - */
> -extern unsigned long rcu_gp_ctr;
> +struct urcu_gp {
> +	union {
> +		/*
> +		 * Global grace period counter.
> +		 * Contains the current RCU_GP_CTR_PHASE.
> +		 * Written to only by writer with mutex taken.
> +		 * Read by both writer and readers.
> +		 */
> +		unsigned long ctr;
> +
> +		/* ensure the futex is located at offset=8 */
> +		int64_t __unused;
> +	};
> +
> +	int32_t futex;
> +} __attribute__((aligned(CAA_CACHE_LINE_SIZE)));
> +
> +extern struct urcu_gp rcu_gp;
>  
>  struct rcu_reader {
>  	/* Data used by both reader and synchronize_rcu() */
> @@ -231,16 +243,14 @@ struct rcu_reader {
>  
>  extern DECLARE_URCU_TLS(struct rcu_reader, rcu_reader);
>  
> -extern int32_t rcu_gp_futex;
> -
>  /*
>   * Wake-up waiting synchronize_rcu(). Called from many concurrent threads.
>   */
>  static inline void wake_up_gp(void)
>  {
> -	if (caa_unlikely(uatomic_read(&rcu_gp_futex) == -1)) {
> -		uatomic_set(&rcu_gp_futex, 0);
> -		futex_async(&rcu_gp_futex, FUTEX_WAKE, 1,
> +	if (caa_unlikely(uatomic_read(&rcu_gp.futex) == -1)) {
> +		uatomic_set(&rcu_gp.futex, 0);
> +		futex_async(&rcu_gp.futex, FUTEX_WAKE, 1,
>  		      NULL, NULL, 0);
>  	}
>  }
> @@ -256,13 +266,13 @@ static inline enum rcu_state rcu_reader_state(unsigned long *ctr)
>  	v = CMM_LOAD_SHARED(*ctr);
>  	if (!(v & RCU_GP_CTR_NEST_MASK))
>  		return RCU_READER_INACTIVE;
> -	if (!((v ^ rcu_gp_ctr) & RCU_GP_CTR_PHASE))
> +	if (!((v ^ rcu_gp.ctr) & RCU_GP_CTR_PHASE))
>  		return RCU_READER_ACTIVE_CURRENT;
>  	return RCU_READER_ACTIVE_OLD;
>  }
>  
>  /*
> - * Helper for _rcu_read_lock().  The format of rcu_gp_ctr (as well as
> + * Helper for _rcu_read_lock().  The format of rcu_gp.ctr (as well as
>   * the per-thread rcu_reader.ctr) has the upper bits containing a count of
>   * _rcu_read_lock() nesting, and a lower-order bit that contains either zero
>   * or RCU_GP_CTR_PHASE.  The smp_mb_slave() ensures that the accesses in
> @@ -271,7 +281,7 @@ static inline enum rcu_state rcu_reader_state(unsigned long *ctr)
>  static inline void _rcu_read_lock_update(unsigned long tmp)
>  {
>  	if (caa_likely(!(tmp & RCU_GP_CTR_NEST_MASK))) {
> -		_CMM_STORE_SHARED(URCU_TLS(rcu_reader).ctr, _CMM_LOAD_SHARED(rcu_gp_ctr));
> +		_CMM_STORE_SHARED(URCU_TLS(rcu_reader).ctr, _CMM_LOAD_SHARED(rcu_gp.ctr));
>  		smp_mb_slave(RCU_MB_GROUP);
>  	} else
>  		_CMM_STORE_SHARED(URCU_TLS(rcu_reader).ctr, tmp + RCU_GP_COUNT);
> -- 
> 1.7.4.4
> 

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
