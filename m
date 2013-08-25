From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH] Introduce RCU-enabled DQs (v2)
Date: Sun, 25 Aug 2013 15:18:35 -0400
Message-ID: <20130825191835.GA1073__29586.855779826$1377458370$gmane$org@Krystal>
References: <1377371209-2017-1-git-send-email-ncmike@ncultra.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1VDfpe-00048S-CA
	for lttng-dev@lists.lttng.org; Sun, 25 Aug 2013 15:18:40 -0400
Content-Disposition: inline
In-Reply-To: <1377371209-2017-1-git-send-email-ncmike@ncultra.org>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mike Day <ncmike@ncultra.org>
Cc: rp@svcs.cs.pdx.edu, qemu-devel@nongnu.org, lttng-dev@lists.lttng.org, Anthony Liguori <anthony@codemonkey.ws>, Paolo Bonzini <pbonzini@redhat.com>, Paul Mckenney <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

Hi Mike,

* Mike Day (ncmike@ncultra.org) wrote:
> Add RCU-enabled variants on the existing bsd DQ facility. Each Q
> operation has the same interface as the existing (non-RCU)
> version. Also, each operation is implemented as macro for now.
> 
> Using the RCU-enabled DQ, existing DQ users will be able to convert to
> RCU without using a different list interface.
> 
> This version (2) adds a macro to walk a Q in reverse:
> 
> QLIST_FOREACH_REVERSE_RCU(el, head, field)
> 
> Accordingly the reader threads in the test program walk the Q in
> reverse in addition to walking forward.
> 
> To accompany the RCU-enabled DQ, there is also a test file that uses
> concurrent readers to contend with a single updater.
> 
> This patchset builds on top of Paolo Bonzini's rcu tree:
> https://github.com/bonzini/qemu/tree/rcu

I'm not very comfortable with your DQ implementation not providing any
kind of guarantee to a forward traversal followed by backward traversal,
nor for backward followed by forward traversal. If a list add is
executed concurrently with traversals, and we can ensure there are no
list del of the node, if a traversal sees the added node when doing
forward iteration, I would clearly expect to still see it if a backward
iteration follows.

I took the liberty of implementing a couple of ideas I had to provide
a RCU DQ with those guarantees. I just pushed the code here (beware, I
just did some basic single-threaded unit tests so far, so consider this
code as largely untested concurrency-wise):

  git clone git://git.urcu.io/urcu.git
  branch: rcudq
  file: urcu/rcudq.h

Direct link to the file via gitweb:
  http://git.lttng.org/?p=userspace-rcu.git;a=blob;f=urcu/rcudq.h;h=4a8d7b0d5143a958514cf130b1c124d99f3194ca;hb=refs/heads/rcudq

The basic idea is that I add a "skip" flag within each node so
traversals will see the node appear into the list atomically, even
though they are being chained into the prev next and next prev pointers
non-atomically. Unfortunately, this requires an extra write barrier on
the add and delete operations, but considering that list manipulation
requires mutual exclusion anyway, an extra write barrier should not hurt
too much.

Comments are welcome!

Thanks,

Mathieu

> 
> Signed-off-by: Mike Day <ncmike@ncultra.org>
> ---
>  docs/rcu.txt             |   2 +-
>  include/qemu/queue.h     |  11 --
>  include/qemu/rcu_queue.h | 145 ++++++++++++++++++++++++
>  tests/Makefile           |   6 +-
>  tests/rcuq_test.c        | 290 +++++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 440 insertions(+), 14 deletions(-)
>  create mode 100644 include/qemu/rcu_queue.h
>  create mode 100644 tests/rcuq_test.c
> 
> diff --git a/docs/rcu.txt b/docs/rcu.txt
> index b3c593c..de59896 100644
> --- a/docs/rcu.txt
> +++ b/docs/rcu.txt
> @@ -106,7 +106,7 @@ The core RCU API is small:
>          so that the reclaimer function can fetch the struct foo address
>          and free it:
>  
> -            call_rcu1(foo_reclaim, &foo.rcu);
> +            call_rcu1(&foo.rcu, foo_reclaim);
>  
>              void foo_reclaim(struct rcu_head *rp)
>              {
> diff --git a/include/qemu/queue.h b/include/qemu/queue.h
> index 847ddd1..f6f0636 100644
> --- a/include/qemu/queue.h
> +++ b/include/qemu/queue.h
> @@ -139,17 +139,6 @@ struct {                                                                \
>          (elm)->field.le_prev = &(head)->lh_first;                       \
>  } while (/*CONSTCOND*/0)
>  
> -#define QLIST_INSERT_HEAD_RCU(head, elm, field) do {                    \
> -        (elm)->field.le_prev = &(head)->lh_first;                       \
> -        (elm)->field.le_next = (head)->lh_first;                        \
> -        smp_wmb(); /* fill elm before linking it */                     \
> -        if ((head)->lh_first != NULL)  {                                \
> -            (head)->lh_first->field.le_prev = &(elm)->field.le_next;    \
> -        }                                                               \
> -        (head)->lh_first = (elm);                                       \
> -        smp_wmb();                                                      \
> -} while (/* CONSTCOND*/0)
> -
>  #define QLIST_REMOVE(elm, field) do {                                   \
>          if ((elm)->field.le_next != NULL)                               \
>                  (elm)->field.le_next->field.le_prev =                   \
> diff --git a/include/qemu/rcu_queue.h b/include/qemu/rcu_queue.h
> new file mode 100644
> index 0000000..198a87d
> --- /dev/null
> +++ b/include/qemu/rcu_queue.h
> @@ -0,0 +1,145 @@
> +#ifndef QEMU_RCU_SYS_QUEUE_H
> +#define QEMU_RCU_SYS_QUEUE_H
> +
> +/*
> + * rc_queue.h
> + *
> + * Userspace RCU QSBR header.
> + *
> + * LGPL-compatible code should include this header with :
> + *
> + * #define _LGPL_SOURCE
> + * #include <urcu.h>
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
> + *
> + * Copyright (c) 2013 Mike D. Day, IBM Corporation.
> + *
> + * IBM's contributions to this file may be relicensed under LGPLv2 or later.
> + */
> +
> +#include "qemu/rcu.h"  /* rcu.h includes qemu/queue.h and qemu/atomic.h */
> +
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +/*
> + * List functions.
> + */
> +
> +
> +/*
> + *  The difference between atomic_read/set and atomic_rcu_read/set
> + *  is in the including of a read/write memory barrier to the volatile
> + *  access. atomic_rcu_* macros include the memory barrier, the
> + *  plain atomic macros do not. Therefore, it should be correct to
> + *  issue a series of reads or writes to the same element using only
> + *  the atomic_* macro, until the last read or write, which should be
> + *  atomic_rcu_* to introduce a read or write memory barrier as
> + *  appropriate.
> + */
> +
> +/* Upon publication of the listelm->next value, list readers
> + * will see the new node when following next pointers from
> + * antecedent nodes, but may not see the new node when following
> + * prev pointers from subsequent nodes until after the rcu grace
> + * period expires.
> + * see linux/include/rculist.h __list_add_rcu(new, prev, next)
> + */
> +#define QLIST_INSERT_AFTER_RCU(listelm, elm, field) do {    \
> +    (elm)->field.le_next = (listelm)->field.le_next;        \
> +    (elm)->field.le_prev = &(listelm)->field.le_next;       \
> +    atomic_rcu_set(&(listelm)->field.le_next, (elm));       \
> +    if ((elm)->field.le_next != NULL) {                     \
> +       (elm)->field.le_next->field.le_prev =                \
> +        &(elm)->field.le_next;                              \
> +        }                                                   \
> +} while (/*CONSTCOND*/0)
> +
> +/* Upon publication of the listelm->prev->next value, list
> + * readers will see the new element when following prev pointers
> + * from subsequent elements, but may not see the new element
> + * when following next pointers from antecedent elements
> + * until after the rcu grace period expires.
> + */
> +
> +#define QLIST_INSERT_BEFORE_RCU(listelm, elm, field) do {   \
> +        (elm)->field.le_prev = (listelm)->field.le_prev;    \
> +    (elm)->field.le_next = (listelm);                       \
> +    atomic_rcu_set((listelm)->field.le_prev, (elm));        \
> +    (listelm)->field.le_prev = &(elm)->field.le_next;       \
> +} while (/*CONSTCOND*/0)
> +
> +
> +/* Upon publication of the head->first value, list readers
> + * will see the new element when following the head, but may
> + * not see the new element when following prev pointers from
> + * subsequent elements until after the rcu grace period has
> + * expired.
> + */
> +
> +#define QLIST_INSERT_HEAD_RCU(head, elm, field) do {    \
> +    (elm)->field.le_prev = &(head)->lh_first;           \
> +    (elm)->field.le_next = (head)->lh_first;            \
> +    atomic_rcu_set((&(head)->lh_first), (elm));         \
> +    if ((elm)->field.le_next != NULL) {                 \
> +       (elm)->field.le_next->field.le_prev =            \
> +        &(elm)->field.le_next;                          \
> +    }                                                   \
> +} while (/*CONSTCOND*/0)
> +
> +
> +/* prior to publication of the elm->prev->next value, some list
> + * readers  may still see the removed element when following
> + * the antecedent's next pointer.
> + */
> +
> +#define QLIST_REMOVE_RCU(elm, field) do {                       \
> +    if ((elm)->field.le_next != NULL) {                         \
> +       (elm)->field.le_next->field.le_prev =                    \
> +        (elm)->field.le_prev;                                   \
> +    }                                                           \
> +    atomic_rcu_set((elm)->field.le_prev, (elm)->field.le_next); \
> +} while (/*CONSTCOND*/0)
> +
> +/* list traversal must occur within an rcu critical section.
> + */
> +
> +#define QLIST_FOREACH_RCU(var, head, field)                 \
> +        for ((var) = atomic_rcu_read(&(head)->lh_first);    \
> +                (var);                                      \
> +                (var) = ((var)->field.le_next))
> +
> +/* list traversal must occur within an rcu critical section.
> + */
> +#define QLIST_FOREACH_SAFE_RCU(var, head, field, next_var)  \
> +    for ((var) = (atomic_rcu_read(&(head)->lh_first));      \
> +      (var) && ((next_var) = (var)->field.le_next, 1);      \
> +           (var) = (next_var))
> +
> +/* QLIST_ENTRY MUST be the first element of (var)
> + */
> +#define QLIST_FOREACH_REVERSE_RCU(var, head, field)                     \
> +    for ( ;                                                             \
> +    (var) && (var) != (head)->lh_first;                                 \
> +          (var) = (typeof(var))atomic_rcu_read(&(var)->field.le_prev))
> +
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +#endif /* QEMU_RCU_SYS_QUEUE.H */
> diff --git a/tests/Makefile b/tests/Makefile
> index 136b7a4..98674f9 100644
> --- a/tests/Makefile
> +++ b/tests/Makefile
> @@ -53,7 +53,8 @@ gcov-files-test-int128-y =
>  check-unit-y += tests/test-bitops$(EXESUF)
>  check-unit-y += tests/rcutorture$(EXESUF)
>  gcov-files-rcutorture-y = util/rcu.c
> -
> +check-unit-y += tests/rcuq_test$(EXESUF)
> +gcov-files-rcuq_test-y = util/rcu.c
>  check-block-$(CONFIG_POSIX) += tests/qemu-iotests-quick.sh
>  
>  # All QTests for now are POSIX-only, but the dependencies are
> @@ -105,7 +106,7 @@ test-obj-y = tests/check-qint.o tests/check-qstring.o tests/check-qdict.o \
>  	tests/test-qmp-input-visitor.o tests/test-qmp-input-strict.o \
>  	tests/test-qmp-commands.o tests/test-visitor-serialization.o \
>  	tests/test-x86-cpuid.o tests/test-mul64.o tests/test-int128.o \
> -	tests/test-tls.o tests/rcutorture.o
> +	tests/test-tls.o tests/rcutorture.o tests/rcuq_test.o
>  
>  test-qapi-obj-y = tests/test-qapi-visit.o tests/test-qapi-types.o
>  
> @@ -131,6 +132,7 @@ tests/test-cutils$(EXESUF): tests/test-cutils.o util/cutils.o
>  tests/test-int128$(EXESUF): tests/test-int128.o
>  tests/test-tls$(EXESUF): tests/test-tls.o libqemuutil.a
>  tests/rcutorture$(EXESUF): tests/rcutorture.o libqemuutil.a
> +tests/rcuq_test$(EXESUF): tests/rcuq_test.o libqemuutil.a
>  
>  tests/test-qapi-types.c tests/test-qapi-types.h :\
>  $(SRC_PATH)/tests/qapi-schema/qapi-schema-test.json $(SRC_PATH)/scripts/qapi-types.py
> diff --git a/tests/rcuq_test.c b/tests/rcuq_test.c
> new file mode 100644
> index 0000000..4f62143
> --- /dev/null
> +++ b/tests/rcuq_test.c
> @@ -0,0 +1,290 @@
> +/*
> + * rcuq_test.c
> + *
> + * usage: rcuq_test <readers> <duration>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
> + *
> + * Copyright (c) 2013 Mike D. Day, IBM Corporation.
> + */
> +
> +/*
> + * Test variables.
> + */
> +
> +#include <glib.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include "qemu/atomic.h"
> +#include "qemu/rcu.h"
> +#include "qemu/compiler.h"
> +#include "qemu/thread.h"
> +#include "qemu/rcu_queue.h"
> +
> +long long n_reads = 0LL;
> +long long n_updates = 0LL;
> +long long n_reclaims = 0LL;
> +long long n_nodes_removed = 0LL;
> +long long n_nodes = 0LL;
> +
> +
> +int nthreadsrunning;
> +
> +char argsbuf[64];
> +
> +#define GOFLAG_INIT 0
> +#define GOFLAG_RUN  1
> +#define GOFLAG_STOP 2
> +
> +static volatile int goflag = GOFLAG_INIT;
> +
> +#define RCU_READ_RUN 1000
> +#define RCU_UPDATE_RUN 10
> +#define NR_THREADS 100
> +#define RCU_Q_LEN 100
> +
> +static QemuThread threads[NR_THREADS];
> +static struct rcu_reader_data *data[NR_THREADS];
> +static int n_threads;
> +
> +static int select_random_el(int max)
> +{
> +    return (rand() % max);
> +}
> +
> +
> +static void create_thread(void *(*func)(void *))
> +{
> +    if (n_threads >= NR_THREADS) {
> +        fprintf(stderr, "Thread limit of %d exceeded!\n", NR_THREADS);
> +        exit(-1);
> +    }
> +    qemu_thread_create(&threads[n_threads], func, &data[n_threads],
> +                       QEMU_THREAD_JOINABLE);
> +    n_threads++;
> +}
> +
> +static void wait_all_threads(void)
> +{
> +    int i;
> +
> +    for (i = 0; i < n_threads; i++) {
> +        qemu_thread_join(&threads[i]);
> +    }
> +    n_threads = 0;
> +}
> +
> +
> +struct list_element {
> +    QLIST_ENTRY(list_element) entry;
> +    struct rcu_head rcu;
> +    long long val;
> +};
> +
> +static void reclaim_list_el(struct rcu_head *prcu)
> +{
> +    struct list_element *el = container_of(prcu, struct list_element, rcu);
> +    g_free(el);
> +    atomic_add(&n_reclaims, 1);
> +}
> +
> +static QLIST_HEAD(q_list_head, list_element) Q_list_head;
> +
> +static void *rcu_q_reader(void *arg)
> +{
> +    long long j, n_reads_local = 0;
> +    struct list_element *el, *prev_el = NULL;
> +
> +    *(struct rcu_reader_data **)arg = tls_get_rcu_reader();
> +    atomic_inc(&nthreadsrunning);
> +    rcu_thread_offline();
> +    while (goflag == GOFLAG_INIT) {
> +        g_usleep(1000);
> +    }
> +
> +    rcu_thread_online();
> +    while (goflag == GOFLAG_RUN) {
> +        rcu_read_lock();
> +        QLIST_FOREACH_RCU(el, &Q_list_head, entry) {
> +            prev_el = el;
> +            j = el->val;
> +            if (j){;}
> +            n_reads_local++;
> +            if (goflag == GOFLAG_STOP)
> +                break;
> +        }
> +        rcu_read_unlock();
> +
> +        rcu_quiescent_state();
> +        g_usleep(100);
> +        rcu_read_lock();
> +        QLIST_FOREACH_REVERSE_RCU(prev_el, &Q_list_head, entry) {
> +            el = prev_el;
> +            j = el->val;
> +            if (j){;}
> +            n_reads_local++;
> +            if (goflag != GOFLAG_RUN)
> +                break;
> +        }
> +        rcu_read_unlock();
> +
> +        rcu_quiescent_state();
> +        g_usleep(100);
> +    }
> +    rcu_thread_offline();
> +    atomic_add(&n_reads, n_reads_local);
> +    return NULL;
> +}
> +
> +
> +static void *rcu_q_updater(void *arg)
> +{
> +    int i, j, target_el;
> +    long long n_updates_local = 0;
> +    long long n_removed_local = 0;
> +    struct list_element *el, *prev_el;
> +
> +    *(struct rcu_reader_data **)arg = tls_get_rcu_reader();
> +    atomic_inc(&nthreadsrunning);
> +    while (goflag == GOFLAG_INIT) {
> +        g_usleep(1000);
> +    }
> +
> +    while (goflag == GOFLAG_RUN) {
> +        for (i = 0; i < RCU_UPDATE_RUN && goflag == GOFLAG_RUN; i++) {
> +            target_el = select_random_el(RCU_Q_LEN);
> +            j = 0;
> +            /* FOREACH_RCU could work here but let's use both macros */
> +            QLIST_FOREACH_SAFE_RCU(prev_el, &Q_list_head, entry, el) {
> +                j++;
> +                if (target_el == j) {
> +                    QLIST_REMOVE_RCU(prev_el, entry);
> +                    /* may be more than one updater in the future */
> +                    call_rcu1(&prev_el->rcu, reclaim_list_el);
> +                    n_removed_local++;
> +                    break;
> +                }
> +            }
> +            if (goflag == GOFLAG_STOP)
> +                break;
> +            target_el = select_random_el(RCU_Q_LEN);
> +            j = 0;
> +            QLIST_FOREACH_RCU(el, &Q_list_head, entry) {
> +                j++;
> +                if (target_el == j) {
> +                    prev_el = g_new(struct list_element, 1);
> +                    atomic_add(&n_nodes, 1);
> +                    prev_el->val = atomic_read(&n_nodes);
> +                    QLIST_INSERT_BEFORE_RCU(el, prev_el, entry);
> +                    break;
> +                }
> +            }
> +        }
> +        n_updates_local += 2;
> +        synchronize_rcu();
> +    }
> +    rcu_quiescent_state();
> +    atomic_add(&n_updates, n_updates_local);
> +    atomic_add(&n_nodes_removed, n_removed_local);
> +    return NULL;
> +}
> +
> +static void rcu_qtest_init(void)
> +{
> +    struct list_element *new_el;
> +    int i;
> +    nthreadsrunning = 0;
> +    srand(time(0));
> +    for (i = 0; i < RCU_Q_LEN; i++) {
> +        new_el = g_new(struct list_element, 1);
> +        new_el->val = i;
> +        QLIST_INSERT_HEAD_RCU(&Q_list_head, new_el, entry);
> +    }
> +    atomic_add(&n_nodes, RCU_Q_LEN);
> +}
> +
> +static void rcu_qtest_run(int duration, int nreaders)
> +{
> +    int nthreads = nreaders + 1;
> +    while (atomic_read(&nthreadsrunning) < nthreads) {
> +        g_usleep(1000);
> +    }
> +
> +    goflag = GOFLAG_RUN;
> +    sleep(duration);
> +    goflag = GOFLAG_STOP;
> +    wait_all_threads();
> +}
> +
> +
> +static void rcu_qtest(const char *test, int duration, int nreaders)
> +{
> +    int i;
> +    long long n_removed_local=0;
> +
> +    struct list_element *el, *prev_el;
> +
> +    rcu_qtest_init();
> +    for (i = 0; i < nreaders; i++) {
> +        create_thread(rcu_q_reader);
> +    }
> +    create_thread(rcu_q_updater);
> +    rcu_qtest_run(duration, nreaders);
> +    rcu_thread_offline();
> +
> +    QLIST_FOREACH_SAFE_RCU(prev_el, &Q_list_head, entry, el) {
> +        QLIST_REMOVE_RCU(prev_el, entry);
> +        call_rcu1(&prev_el->rcu, reclaim_list_el);
> +        n_removed_local++;
> +    }
> +    atomic_add(&n_nodes_removed, n_removed_local);
> +    rcu_quiescent_state();
> +    synchronize_rcu();
> +    while (n_nodes_removed > n_reclaims){
> +        rcu_quiescent_state();
> +        g_usleep(100);
> +        synchronize_rcu();
> +    }
> +    printf("%s: %d readers; 1 updater; nodes read: %lld, nodes removed: %lld; nodes reclaimed: %lld\n",
> +           test, nthreadsrunning -1, n_reads, n_nodes_removed, n_reclaims);
> +    exit(0);
> +}
> +
> +static void usage(int argc, char *argv[])
> +{
> +    fprintf(stderr, "Usage: %s duration nreaders\n", argv[0]);
> +    exit(-1);
> +}
> +
> +
> +int main(int argc, char *argv[])
> +{
> +    int duration = 0, readers = 0;
> +
> +    if (argc >= 2) {
> +        duration = strtoul(argv[1], NULL, 0);
> +    }
> +    if (argc >= 3) {
> +        readers = strtoul(argv[2], NULL, 0);
> +    }
> +
> +    /* This thread is not part of the test.  */
> +    rcu_thread_offline();
> +    if (duration && readers)
> +        rcu_qtest(argv[0], duration, readers);
> +    usage(argc, argv);
> +    return 0;
> +}
> -- 
> 1.8.3.1
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
