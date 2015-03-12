From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Alternative to signals/sys_membarrier() in liburcu
Date: Thu, 12 Mar 2015 20:56:00 +0000 (UTC)
Message-ID: <1243872207.287578.1426193760572.JavaMail.zimbra@efficios.com>
References: <666590480.287502.1426193588471.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <666590480.287502.1426193588471.JavaMail.zimbra@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Sullivan <sully@msully.net>
Cc: Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, lttng-dev@lists.lttng.org, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>
List-Id: lttng-dev@lists.lttng.org

(sorry for re-send, my mail client tricked me into posting HTML
to lkml)

Hi, 

Michael Sullivan proposed a clever hack abusing mprotect() to 
perform the same effect as sys_membarrier() I submitted a few 
years ago ( https://lkml.org/lkml/2010/4/18/15 ). 

At that time, the sys_membarrier implementation was deemed 
technically sound, but there were not enough users of the system call 
to justify its inclusion. 

So far, the number of users of liburcu has increased, but liburcu 
still appears to be the only direct user of sys_membarrier. On this 
front, we could argue that many other system calls have only 
one user: glibc. In that respect, liburcu is quite similar to glibc. 

So the question as it stands appears to be: would you be comfortable 
having users abuse mprotect(), relying on its side-effect of issuing 
a smp_mb() on each targeted CPU for the TLB shootdown, as 
an effective implementation of process-wide memory barrier ? 

Thoughts ? 

Thanks! 

Mathieu 





From: "Michael Sullivan" <sully@msully.net> 
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com> 
Cc: lttng-dev@lists.lttng.org 
Sent: Thursday, March 12, 2015 12:04:07 PM 
Subject: Re: [lttng-dev] Alternative to signals/sys_membarrier() in liburcu 

On Thu, Mar 12, 2015 at 10:57 AM, Mathieu Desnoyers < mathieu.desnoyers@efficios.com > wrote: 




Even though it depends on internal behavior not currently specified by mprotect, 
I'd very much like to see the prototype you have, 


I ended up posting my code at https://github.com/msullivan/userspace-rcu/tree/msync-barrier . 
The interesting patch is https://github.com/msullivan/userspace-rcu/commit/04656b468d418efbc5d934ab07954eb8395a7ab0 . 

Quick blog post I wrote about it at http://www.msully.net/blog/2015/02/24/forcing-memory-barriers-on-other-cpus-with-mprotect2/ . 
(I talked briefly about sys_membarrier in the post as best as I could piece together from LKML; if my comment on it is inaccurate I can edit the post.) 

-Michael Sullivan 



-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
