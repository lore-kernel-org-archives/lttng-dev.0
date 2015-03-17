From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: userspace-rcu-0.8.6 problems on MacOSX
Date: Tue, 17 Mar 2015 22:04:29 +0000 (UTC)
Message-ID: <1727337246.24545.1426629869749.JavaMail.zimbra__17652.8319054798$1426629933$gmane$org@efficios.com>
References: <18312E03-EE49-4807-8227-7DE555AFFD28@rfc1035.com>
 <5501CBE5.1020702@voxpopuli.im>
 <CAJ7wx-EgDGitV7swToCZohrmept1pi+OkgBCeFXmkwS25GBP8Q@mail.gmail.com>
 <55035469.9050001@voxpopuli.im>
 <979006401.6127.1426468668277.JavaMail.zimbra@efficios.com>
 <55087C8B.8050504@voxpopuli.im>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1YXzbH-0000FH-49
 for lttng-dev@lists.lttng.org; Tue, 17 Mar 2015 18:04:37 -0400
In-Reply-To: <55087C8B.8050504@voxpopuli.im>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Cc: Jim Reid <jim@rfc1035.com>, lttng-dev@lists.lttng.org, Zifei Tong <soariez@gmail.com>
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> 
> Thanks Mathieu! With all the latest fixes, liburcu master can now
> compile as-is on Mac.
> 
> 
> On 2015-03-15 9:17 PM, Mathieu Desnoyers wrote:
> >
> >> However, by doing so those tests now hang on my Mac test system (whereas
> >> before they would get skipped). Is it possible those tests don't even
> >> work on Mac?
> > Do they really hang, or just take a very long time to run ?
> > Can you reproduce this easily ?
> >
> >
> 
> Quite reproducible, yes. I let 'make regtest' run for a couple hours,
> and it stuck at:
> 
> cd ../benchmark && ./runall.sh && cd ..
> Executing batch RCU test
> ./test_urcu_gc 4 4 10 -d 0 -b 1
> 
> 
> Running the last command by hand also hangs. It's using very little CPU
> in both cases.

Here is the fix.

commit db21eff94739900b1ab51d231dfb281ead0a0fa5
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Tue Mar 17 17:53:21 2015 -0400

    Fix: compat_futex_noasync race condition
    
    The Userspace RCU compatibility layer around sys_futex has a race
    condition which makes pretty much all "benchmark" tests hang pretty
    quickly on non-Linux systems (tested on Mac OS X).
    
    I narrowed it down to a bug in compat_futex_noasync: this compat layer
    uses a single pthread mutex and condition variable for all callers,
    independently of their uaddr. The FUTEX_WAKE performs a pthread cond
    broadcast to all waiters. FUTEX_WAIT must then compare *uaddr with val
    to see which thread has been awakened.
    
    Unfortunately, the check was not done again after each return from
    pthread_cond_wait(), thus causing the race.
    
    This race affects threads using the futex_noasync() compatibility layer
    concurrently, thus it affects only on non-Linux systems.
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

It's in master, backported to stable-0.7 and stable-0.8.

We really need to gear up our CI with MacOSX support. I just bought
a mac mini for this purpose.

Thanks for the testing!

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
