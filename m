From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Package liburcu fix for kfreebsd-amd64 and kfreebsd-i386
Date: Fri, 22 Feb 2013 08:45:15 -0500
Message-ID: <20130222134515.GA22069__8583.74050953916$1361540820$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1U8sw9-0006Ad-H8
	for lttng-dev@lists.lttng.org; Fri, 22 Feb 2013 08:45:17 -0500
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: kfreebsd-amd64@buildd.debian.org, kfreebsd-i386@buildd.debian.org
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi,

I noticed failures to build for the liburcu Debian package for
kfreebsd-amd64 and kfreebsd-i386. I just pushed a commit into the master
branch that should solve the build errors encountered. Would it be
possible to test a build of Userspace RCU master branch against those
two architectures ? If it works fine, then I could backport this commit
into the stable-0.7 branch.

commit 63b495d8b20ff76ba08d823df2e9702acc936beb
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Fri Feb 22 08:35:37 2013 -0500

    Fix build on architectures with HAVE_SCHED_GETCPU but without HAVE_SYSCONF
    
    Noticed on: https://buildd.debian.org/status/package.php?p=liburcu
    
    Tail of log for liburcu on kfreebsd-amd64:
    
      CC     urcu.lo
    In file included from urcu.c:450:0:
    urcu-call-rcu-impl.h:145:12: error: static declaration of 'sched_getcpu' follows non-static declaration
    In file included from /usr/include/sched.h:43:0,
                     from /usr/include/pthread.h:20,
                     from urcu.c:30:
    /usr/include/x86_64-kfreebsd-gnu/bits/sched.h:65:12: note: previous declaration of 'sched_getcpu' was here
    make[3]: *** [urcu.lo] Error 1
    make[3]: Leaving directory `/build/buildd-liburcu_0.7.6-1-kfreebsd-amd64-nnkICd/liburcu-0.7.6'
    make[2]: *** [all-recursive] Error 1
    make[2]: Leaving directory `/build/buildd-liburcu_0.7.6-1-kfreebsd-amd64-nnkICd/liburcu-0.7.6'
    make[1]: *** [all] Error 2
    make[1]: Leaving directory `/build/buildd-liburcu_0.7.6-1-kfreebsd-amd64-nnkICd/liburcu-0.7.6'
    dh_auto_build: make -j1 returned exit code 2
    make: *** [build-arch] Error 2
    
    Tail of log for liburcu on kfreebsd-i386:
    
      CC     urcu.lo
    In file included from urcu.c:450:0:
    urcu-call-rcu-impl.h:145:12: error: static declaration of 'sched_getcpu' follows non-static declaration
    In file included from /usr/include/sched.h:43:0,
                     from /usr/include/pthread.h:20,
                     from urcu.c:30:
    /usr/include/i386-kfreebsd-gnu/bits/sched.h:65:12: note: previous declaration of 'sched_getcpu' was here
    make[3]: *** [urcu.lo] Error 1
    make[3]: Leaving directory `/build/buildd-liburcu_0.7.6-1-kfreebsd-i386-sWzNKU/liburcu-0.7.6'
    make[2]: *** [all-recursive] Error 1
    make[2]: Leaving directory `/build/buildd-liburcu_0.7.6-1-kfreebsd-i386-sWzNKU/liburcu-0.7.6'
    make[1]: *** [all] Error 2
    make[1]: Leaving directory `/build/buildd-liburcu_0.7.6-1-kfreebsd-i386-sWzNKU/liburcu-0.7.6'
    dh_auto_build: make -j1 returned exit code 2
    make: *** [build-arch] Error 2
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
