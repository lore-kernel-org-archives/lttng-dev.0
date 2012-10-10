From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: rculfstack bug
Date: Wed, 10 Oct 2012 08:02:07 -0700
Message-ID: <20121010150207.GB2495__24785.7013986961$1349881470$gmane$org@linux.vnet.ibm.com>
References: <50754A57.1080104@cn.fujitsu.com> <20121010114215.GA11307@Krystal>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e38.co.us.ibm.com ([32.97.110.159])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <paulmck@linux.vnet.ibm.com>) id 1TLxoy-0004UV-I3
	for lttng-dev@lists.lttng.org; Wed, 10 Oct 2012 11:03:40 -0400
Received: from /spool/local
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <paulmck@linux.vnet.ibm.com>;
	Wed, 10 Oct 2012 09:02:39 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 0E41519D8076
	for <lttng-dev@lists.lttng.org>; Wed, 10 Oct 2012 09:02:30 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	q9AF2ExL190936
	for <lttng-dev@lists.lttng.org>; Wed, 10 Oct 2012 09:02:14 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id q9AF294m001790
	for <lttng-dev@lists.lttng.org>; Wed, 10 Oct 2012 09:02:09 -0600
Content-Disposition: inline
In-Reply-To: <20121010114215.GA11307@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On Wed, Oct 10, 2012 at 07:42:15AM -0400, Mathieu Desnoyers wrote:
> * Lai Jiangshan (laijs@cn.fujitsu.com) wrote:
> > test code:
> > ./tests/test_urcu_lfs 100 10 10
> > 
> > bug produce rate > 60%
> > 
> > {{{
> > I didn't see any bug when "./tests/test_urcu_lfs 10 10 10" Or "./tests/test_urcu_lfs 100 100 10"
> > But I just test it about 5 times
> > }}}
> > 
> > 4cores*1threads: Intel(R) Core(TM) i5 CPU         760
> > RCU_MB (no time to test for other rcu type)
> > test commit: 768fba83676f49eb73fd1d8ad452016a84c5ec2a
> > 
> > I didn't see any bug when "./tests/test_urcu_mb 10 100 10"
> > 
> > Sorry, I tried, but I failed to find out the root cause currently.
> 
> I think I managed to narrow down the issue:
> 
> 1) the master branch does not reproduce it, but commit
>    768fba83676f49eb73fd1d8ad452016a84c5ec2a repdroduces it about 50% of the
>    time.
> 
> 2) the main change between 768fba83676f49eb73fd1d8ad452016a84c5ec2a and
>    current master (f94061a3df4c9eab9ac869a19e4228de54771fcb) is call_rcu
>    moving to wfcqueue.
> 
> 3) the bug always arise, for me, at the end of the 10 seconds.
>    However, it might be simply due to the fact that most of the memory
>    get freed at the end of program execution.
> 
> 4) I've been able to get a backtrace, and it looks like we have some
>    call_rcu callback-invokation threads still working while
>    call_rcu_data_free() is invoked. In the backtrace, call_rcu_data_free()
>    is nicely waiting for the next thread to stop, and during that time,
>    two callback-invokation threads are invoking callbacks (and one of
>    them triggers the segfault).

Do any of the callbacks reference __thread variables from some other
thread?  If so, those threads must refrain from exiting until after
such callbacks complete.

							Thanx, Paul

> So I expect that commit 
> 
> commit 5161f31e09ce33dd79afad8d08a2372fbf1c4fbe
> Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Date:   Tue Sep 25 10:50:49 2012 -0500
> 
>     call_rcu: use wfcqueue, eliminate false-sharing
>     
>     Eliminate false-sharing between call_rcu (enqueuer) and worker threads
>     on the queue head and tail.
>     
>     Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
>     Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> 
> Could have managed to fix the issue, or change the timing enough that it
> does not reproduces. I'll continue investigating.
> 
> Thanks,
> 
> Mathieu
> 
> 
> > 
> > *** glibc detected *** /home/laijs/work/userspace-rcu/tests/.libs/lt-test_urcu_lfs: double free or corruption (out): 0x00007f20955dfbb0 ***
> > ======= Backtrace: =========
> > /lib64/libc.so.6[0x37ee676d63]
> > /home/laijs/work/userspace-rcu/tests/.libs/lt-test_urcu_lfs[0x4024f5]
> > /lib64/libpthread.so.0[0x37eda06ccb]
> > /lib64/libc.so.6(clone+0x6d)[0x37ee6e0c2d]
> > ======= Memory map: ========
> > 00400000-00405000 r-xp 00000000 08:08 6031723                            /home/laijs/work/userspace-rcu/tests/.libs/lt-test_urcu_lfs
> > 00605000-00606000 rw-p 00005000 08:08 6031723                            /home/laijs/work/userspace-rcu/tests/.libs/lt-test_urcu_lfs
> > 00606000-00616000 rw-p 00000000 00:00 0 
> > 00e9c000-03482000 rw-p 00000000 00:00 0                                  [heap]
> > 37ed600000-37ed61f000 r-xp 00000000 08:01 1507421                        /lib64/ld-2.13.so
> > 37ed81e000-37ed81f000 r--p 0001e000 08:01 1507421                        /lib64/ld-2.13.so
> > 37ed81f000-37ed820000 rw-p 0001f000 08:01 1507421                        /lib64/ld-2.13.so
> > 37ed820000-37ed821000 rw-p 00000000 00:00 0 
> > 37eda00000-37eda17000 r-xp 00000000 08:01 1507427                        /lib64/libpthread-2.13.so
> > 37eda17000-37edc16000 ---p 00017000 08:01 1507427                        /lib64/libpthread-2.13.so
> > 37edc16000-37edc17000 r--p 00016000 08:01 1507427                        /lib64/libpthread-2.13.so
> > 37edc17000-37edc18000 rw-p 00017000 08:01 1507427                        /lib64/libpthread-2.13.so
> > 37edc18000-37edc1c000 rw-p 00000000 00:00 0 
> > 37ee600000-37ee791000 r-xp 00000000 08:01 1507423                        /lib64/libc-2.13.so
> > 37ee791000-37ee991000 ---p 00191000 08:01 1507423                        /lib64/libc-2.13.so
> > 37ee991000-37ee995000 r--p 00191000 08:01 1507423                        /lib64/libc-2.13.so
> > 37ee995000-37ee996000 rw-p 00195000 08:01 1507423                        /lib64/libc-2.13.so
> > 37ee996000-37ee99c000 rw-p 00000000 00:00 0 
> > 37f0e00000-37f0e15000 r-xp 00000000 08:01 1507437                        /lib64/libgcc_s-4.5.1-20100924.so.1
> > 37f0e15000-37f1014000 ---p 00015000 08:01 1507437                        /lib64/libgcc_s-4.5.1-20100924.so.1
> > 37f1014000-37f1015000 rw-p 00014000 08:01 1507437                        /lib64/libgcc_s-4.5.1-20100924.so.1
> > 7f1ee4000000-7f1ee4029000 rw-p 00000000 00:00 0 
> > 7f1ee4029000-7f1ee8000000 ---p 00000000 00:00 0 
> > 7f1eec000000-7f1eee039000 rw-p 00000000 00:00 0 
> > 7f1eee039000-7f1ef0000000 ---p 00000000 00:00 0 
> > 7f1ef4000000-7f1ef4029000 rw-p 00000000 00:00 0 
> > 7f1ef4029000-7f1ef8000000 ---p 00000000 00:00 0 
> > 7f1efc000000-7f1efc029000 rw-p 00000000 00:00 0 
> > 7f1efc029000-7f1f00000000 ---p 00000000 00:00 0 
> > 7f1f04000000-7f1f060b8000 rw-p 00000000 00:00 0 
> > 7f1f060b8000-7f1f08000000 ---p 00000000 00:00 0 
> > 7f1f0c000000-7f1f0c029000 rw-p 00000000 00:00 0 
> > 7f1f0c029000-7f1f10000000 ---p 00000000 00:00 0 
> > 7f1f14000000-7f1f14029000 rw-p 00000000 00:00 0 
> > 7f1f14029000-7f1f18000000 ---p 00000000 00:00 0 
> > 7f1f1c000000-7f1f1c029000 rw-p 00000000 00:00 0 
> > 7f1f1c029000-7f1f20000000 ---p 00000000 00:00 0 
> > 7f1f24000000-7f1f24029000 rw-p 00000000 00:00 0 
> > 7f1f24029000-7f1f28000000 ---p 00000000 00:00 0 
> > 7f1f2c000000-7f1f2c029000 rw-p 00000000 00:00 0 
> > 7f1f2c029000-7f1f30000000 ---p 00000000 00:00 0 
> > 7f1f34000000-7f1f34029000 rw-p 00000000 00:00 0 
> > 7f1f34029000-7f1f38000000 ---p 00000000 00:00 0 
> > 7f1f3c000000-7f1f3c029000 rw-p 00000000 00:00 0 
> > 7f1f3c029000-7f1f40000000 ---p 00000000 00:00 0 
> > 7f1f44000000-7f1f44029000 rw-p 00000000 00:00 0 
> > 7f1f44029000-7f1f48000000 ---p 00000000 00:00 0 
> > 7f1f4c000000-7f1f4c029000 rw-p 00000000 00:00 0 
> > 7f1f4c029000-7f1f50000000 ---p 00000000 00:00 0 
> > 7f1f54000000-7f1f54029000 rw-p 00000000 00:00 0 
> > 7f1f54029000-7f1f58000000 ---p 00000000 00:00 0 
> > 7f1f5c000000-7f1f5c029000 rw-p 00000000 00:00 0 
> > 7f1f5c029000-7f1f60000000 ---p 00000000 00:00 0 
> > 7f1f64000000-7f1f64029000 rw-p 00000000 00:00 0 
> > 7f1f64029000-7f1f68000000 ---p 00000000 00:00 0 
> > 7f1f6c000000-7f1f6c029000 rw-p 00000000 00:00 0 
> > 7f1f6c029000-7f1f70000000 ---p 00000000 00:00 0 
> > 7f1f74000000-7f1f74029000 rw-p 00000000 00:00 0 
> > 7f1f74029000-7f1f78000000 ---p 00000000 00:00 0 
> > 7f1f7c000000-7f1f7c029000 rw-p 00000000 00:00 0 
> > 7f1f7c029000-7f1f80000000 ---p 00000000 00:00 0 
> > 7f1f84000000-7f1f84029000 rw-p 00000000 00:00 0 
> > 7f1f84029000-7f1f88000000 ---p 00000000 00:00 0 
> > 7f1f8c000000-7f1f8c029000 rw-p 00000000 00:00 0 
> > 7f1f8c029000-7f1f90000000 ---p 00000000 00:00 0 
> > 7f1f94000000-7f1f94029000 rw-p 00000000 00:00 0 
> > 7f1f94029000-7f1f98000000 ---p 00000000 00:00 0 
> > 7f1f9c000000-7f1f9c029000 rw-p 00000000 00:00 0 
> > 7f1f9c029000-7f1fa0000000 ---p 00000000 00:00 0 
> > 7f1fa4000000-7f1fa60ac000 rw-p 00000000 00:00 0 
> > 7f1fa60ac000-7f1fa8000000 ---p 00000000 00:00 0 
> > 7f1fac000000-7f1fac029000 rw-p 00000000 00:00 0 
> > 7f1fac029000-7f1fb0000000 ---p 00000000 00:00 0 
> > 7f1fb4000000-7f1fb4029000 rw-p 00000000 00:00 0 
> > 7f1fb4029000-7f1fb8000000 ---p 00000000 00:00 0 
> > 7f1fbc000000-7f1fbc029000 rw-p 00000000 00:00 0 
> > 7f1fbc029000-7f1fc0000000 ---p 00000000 00:00 0 
> > 7f1fc4000000-7f1fc4029000 rw-p 00000000 00:00 0 
> > 7f1fc4029000-7f1fc8000000 ---p 00000000 00:00 0 
> > 7f1fcc000000-7f1fce0a1000 rw-p 00000000 00:00 0 
> > 7f1fce0a1000-7f1fd0000000 ---p 00000000 00:00 0 
> > 7f1fd4000000-7f1fd4029000 rw-p 00000000 00:00 0 
> > 7f1fd4029000-7f1fd8000000 ---p 00000000 00:00 0 
> > 7f1fdc000000-7f1fde06b000 rw-p 00000000 00:00 0 
> > 7f1fde06b000-7f1fe0000000 ---p 00000000 00:00 0 
> > 7f1fe4000000-7f1fe4029000 rw-p 00000000 00:00 0 
> > 7f1fe4029000-7f1fe8000000 ---p 00000000 00:00 0 
> > 7f1fec000000-7f1fede38000 rw-p 00000000 00:00 0 
> > 7f1fede38000-7f1ff0000000 ---p 00000000 00:00 0 
> > 7f1ff4000000-7f1ff4029000 rw-p 00000000 00:00 0 
> > 7f1ff4029000-7f1ff8000000 ---p 00000000 00:00 0 
> > 7f1ffc000000-7f1ffc029000 rw-p 00000000 00:00 0 
> > 7f1ffc029000-7f2000000000 ---p 00000000 00:00 0 
> > 7f2004000000-7f20060c6000 rw-p 00000000 00:00 0 
> > 7f20060c6000-7f2008000000 ---p 00000000 00:00 0 
> > 7f200c000000-7f200c029000 rw-p 00000000 00:00 0 
> > 7f200c029000-7f2010000000 ---p 00000000 00:00 0 
> > 7f2014000000-7f2014029000 rw-p 00000000 00:00 0 
> > 7f2014029000-7f2018000000 ---p 00000000 00:00 0 
> > 7f201c000000-7f201c029000 rw-p 00000000 00:00 0 
> > 7f201c029000-7f2020000000 ---p 00000000 00:00 0 
> > 7f2024000000-7f2024029000 rw-p 00000000 00:00 0 
> > 7f2024029000-7f2028000000 ---p 00000000 00:00 0 
> > 7f202c000000-7f202c029000 rw-p 00000000 00:00 0 
> > 7f202c029000-7f2030000000 ---p 00000000 00:00 0 
> > 7f2034000000-7f2034029000 rw-p 00000000 00:00 0 
> > 7f2034029000-7f2038000000 ---p 00000000 00:00 0 
> > 7f203c000000-7f203c029000 rw-p 00000000 00:00 0 
> > 7f203c029000-7f2040000000 ---p 00000000 00:00 0 
> > 7f2044000000-7f2044029000 rw-p 00000000 00:00 0 
> > 7f2044029000-7f2048000000 ---p 00000000 00:00 0 
> > 7f204c000000-7f204c029000 rw-p 00000000 00:00 0 
> > 7f204c029000-7f2050000000 ---p 00000000 00:00 0 
> > 7f2054000000-7f2054029000 rw-p 00000000 00:00 0 
> > 7f2054029000-7f2058000000 ---p 00000000 00:00 0 
> > 7f205c000000-7f205c029000 rw-p 00000000 00:00 0 
> > 7f205c029000-7f2060000000 ---p 00000000 00:00 0 
> > 7f2064000000-7f2064029000 rw-p 00000000 00:00 0 
> > 7f2064029000-7f2068000000 ---p 00000000 00:00 0 
> > 7f206c000000-7f206c029000 rw-p 00000000 00:00 0 
> > 7f206c029000-7f2070000000 ---p 00000000 00:00 0 
> > 7f2074000000-7f2074029000 rw-p 00000000 00:00 0 
> > 7f2074029000-7f2078000000 ---p 00000000 00:00 0 
> > 7f207c000000-7f207e0bc000 rw-p 00000000 00:00 0 
> > 7f207e0bc000-7f2080000000 ---p 00000000 00:00 0 
> > 7f2084000000-7f2084029000 rw-p 00000000 00:00 0 
> > 7f2084029000-7f2088000000 ---p 00000000 00:00 0 
> > 7f208c000000-7f208c029000 rw-p 00000000 00:00 0 
> > 7f208c029000-7f2090000000 ---p 00000000 00:00 0 
> > 7f2094000000-7f20960c6000 rw-p 00000000 00:00 0 
> > 7f20960c6000-7f2098000000 ---p 00000000 00:00 0 
> > 7f209c000000-7f209c029000 rw-p 00000000 00:00 0 
> > 7f209c029000-7f20a0000000 ---p 00000000 00:00 0 
> > 7f20a4000000-7f20a4029000 rw-p 00000000 00:00 0 
> > 7f20a4029000-7f20a8000000 ---p 00000000 00:00 0 
> > 7f20ac000000-7f20ac029000 rw-p 00000000 00:00 0 
> > 7f20ac029000-7f20b0000000 ---p 00000000 00:00 0 
> > 7f20b4000000-7f20b4029000 rw-p 00000000 00:00 0 
> > 7f20b4029000-7f20b8000000 ---p 00000000 00:00 0 
> > 7f20bc000000-7f20bc029000 rw-p 00000000 00:00 0 
> > 7f20bc029000-7f20c0000000 ---p 00000000 00:00 0 
> > 7f20c4000000-7f20c4029000 rw-p 00000000 00:00 0 
> > 7f20c4029000-7f20c8000000 ---p 00000000 00:00 0 
> > 7f20c8ffa000-7f20c8ffb000 ---p 00000000 00:00 0 
> > 7f20c8ffb000-7f20c97fb000 rw-p 00000000 00:00 0                          [stack:10274]
> > 7f20c97fb000-7f20c97fc000 ---p 00000000 00:00 0 
> > 7f20c97fc000-7f20c9ffc000 rw-p 00000000 00:00 0 
> > 7f20c9ffc000-7f20c9ffd000 ---p 00000000 00:00 0 
> > 7f20c9ffd000-7f20ca7fd000 rw-p 00000000 00:00 0 
> > 7f20ca7fd000-7f20ca7fe000 ---p 00000000 00:00 0 
> > 7f20ca7fe000-7f20caffe000 rw-p 00000000 00:00 0 
> > 7f20cc000000-7f20cc029000 rw-p 00000000 00:00 0 
> > 7f20cc029000-7f20d0000000 ---p 00000000 00:00 0 
> > 7f20d4000000-7f20d4029000 rw-p 00000000 00:00 0 
> > 7f20d4029000-7f20d8000000 ---p 00000000 00:00 0 
> > 7f20dc000000-7f20dc029000 rw-p 00000000 00:00 0 
> > 7f20dc029000-7f20e0000000 ---p 00000000 00:00 0 
> > 7f210d9dd000-7f210d9de000 ---p 00000000 00:00 0 
> > 7f210d9de000-7f210e1de000 rw-p 00000000 00:00 0                          [stack:10160]
> > 7f210e1de000-7f210e1df000 ---p 00000000 00:00 0 
> > 7f210e1df000-7f210e9df000 rw-p 00000000 00:00 0                          [stack:10159]
> > 7f210e9df000-7f210e9e0000 ---p 00000000 00:00 0 
> > 7f210e9e0000-7f210f1e0000 rw-p 00000000 00:00 0 
> > 7f210f1e0000-7f210f1e1000 ---p 00000000 00:00 0 
> > 7f210f1e1000-7f210f9e4000 rw-p 00000000 00:00 0 
> > 7f210fa00000-7f210fa01000 rw-p 00000000 00:00 0 
> > 7f210fa01000-7f210fa02000 r-xp 00000000 08:08 6029369                    /home/laijs/work/userspace-rcu/.libs/liburcu-common.so.1.0.0
> > 7f210fa02000-7f210fc02000 ---p 00001000 08:08 6029369                    /home/laijs/work/userspace-rcu/.libs/liburcu-common.so.1.0.0
> > 7f210fc02000-7f210fc03000 rw-p 00001000 08:08 6029369                    /home/laijs/work/userspace-rcu/.libs/liburcu-common.so.1.0.0
> > 7f210fc03000-7f210fc04000 rw-p 00000000 00:00 0 
> > 7f210fc04000-7f210fc0a000 r-xp 00000000 08:08 6029586                    /home/laijs/work/userspace-rcu/.libs/liburcu-cds.so.1.0.0
> > 7f210fc0a000-7f210fe09000 ---p 00006000 08:08 6029586                    /home/laijs/work/userspace-rcu/.libs/liburcu-cds.so.1.0.0
> > 7f210fe09000-7f210fe0a000 rw-p 00005000 08:08 6029586                    /home/laijs/work/userspace-rcu/.libs/liburcu-cds.so.1.0.0
> > 7f210fe0a000-7f210fe0b000 rw-p 00000000 00:00 0 
> > 7fff7c648000-7fff7c669000 rw-p 00000000 00:00 0                          [stack]
> > 7fff7c715000-7fff7c716000 r-xp 00000000 00:00 0                          [vdso]
> > ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0                  [vsyscall]
> > 
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 
> -- 
> Mathieu Desnoyers
> Operating System Efficiency R&D Consultant
> EfficiOS Inc.
> http://www.efficios.com
> 
