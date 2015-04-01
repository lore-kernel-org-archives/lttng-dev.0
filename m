From: Eugene Ivanov <eiva@orc-group.com>
Subject: Deadlock between call_rcu thread and RCU-bp thread
 doing registration in rcu_read_lock()
Date: Wed, 1 Apr 2015 13:01:09 +0300
Message-ID: <551BC1E5.3020809__7495.50692639804$1427882573$gmane$org@orc-group.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx03.orcsoftware.com ([194.14.211.251]
 helo=nan.ad.orcsoftware.com) by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Eugene.Ivanov@orc-group.com>) id 1YdFSv-0004Y1-LG
 for lttng-dev@lists.lttng.org; Wed, 01 Apr 2015 06:01:48 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

I use rcu-bp (0.8.6) and get deadlock between call_rcu thread and
threads willing to do rcu_read_lock():
1. Some thread is in read-side critical section.
2. call_rcu thread waits for readers in stack of rcu_bp_register(), i.e.
holds mutex.
3. Another thread enters into critical section via rcu_read_lock() and
blocks on the mutex taken by thread 2.

Such deadlock is quite unexpected for me. Especially if RCU is used for
reference counting.

Originally it happened with rculfhash, below is minimized reproducer:

#include <pthread.h>
#include <urcu-bp.h>

struct Node
{
         struct rcu_head rcu_head;
};

static void free_node(struct rcu_head * head)
{
         struct Node *node = caa_container_of(head, struct Node, rcu_head);
         free(node);
}

static void * reader_thread(void * arg)
{
     rcu_read_lock();
     rcu_read_unlock();
     return NULL;
}

int main(int argc, char * argv[])
{
     rcu_read_lock();
     struct Node * node = malloc(sizeof(*node));
     call_rcu(&node->rcu_head, free_node);

     pthread_t read_thread_info;
     pthread_create(&read_thread_info, NULL, reader_thread, NULL);
     pthread_join(read_thread_info, NULL);

     rcu_read_unlock();

     return 0;
}


Stacks:

Thread 3 (Thread 0x7f8e2ab05700 (LWP 7386)):
#0  0x00000035cacdf343 in *__GI___poll (fds=<optimized out>,
nfds=<optimized out>, timeout=<optimized out>) at
../sysdeps/unix/sysv/linux/poll.c:87
#1  0x000000383880233e in wait_for_readers
(input_readers=0x7f8e2ab04cf0, cur_snap_readers=0x0,
qsreaders=0x7f8e2ab04ce0) at urcu-bp.c:211
#2  0x0000003838802af2 in synchronize_rcu_bp () at urcu-bp.c:272
#3  0x00000038388043a3 in call_rcu_thread (arg=0x1f7f030) at
urcu-call-rcu-impl.h:320
#4  0x00000035cb0079d1 in start_thread (arg=0x7f8e2ab05700) at
pthread_create.c:301
#5  0x00000035cace8b6d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:115
Thread 2 (Thread 0x7f8e2a304700 (LWP 7387)):
#0  __lll_lock_wait () at
../nptl/sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:136
#1  0x00000035cb009508 in _L_lock_854 () from /lib64/libpthread.so.0
#2  0x00000035cb0093d7 in __pthread_mutex_lock (mutex=0x3838a05ca0
<rcu_gp_lock>) at pthread_mutex_lock.c:61
#3  0x0000003838801ed9 in mutex_lock (mutex=<optimized out>) at
urcu-bp.c:147
#4  0x000000383880351e in rcu_bp_register () at urcu-bp.c:493
#5  0x000000383880382e in _rcu_read_lock_bp () at urcu/static/urcu-bp.h:159
#6  rcu_read_lock_bp () at urcu-bp.c:296
#7  0x0000000000400801 in reader_thread ()
#8  0x00000035cb0079d1 in start_thread (arg=0x7f8e2a304700) at
pthread_create.c:301
#9  0x00000035cace8b6d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:115
Thread 1 (Thread 0x7f8e2ab06740 (LWP 7385)):
#0  0x00000035cb00822d in pthread_join (threadid=140248569890560,
thread_return=0x0) at pthread_join.c:89
#1  0x000000000040088f in main ()


--
Eugene Ivanov


________________________________

This e-mail is confidential and may contain legally privileged information. It is intended only for the addressees. If you have received this e-mail in error, kindly notify us immediately by telephone or e-mail and delete the message from your system.
