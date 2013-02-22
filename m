From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Package liburcu: build for hurd-i386
Date: Fri, 22 Feb 2013 09:09:20 -0500
Message-ID: <20130222140920.GA22156__7216.89106799221$1361542268$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1U8tJR-0006NN-Ka
	for lttng-dev@lists.lttng.org; Fri, 22 Feb 2013 09:09:21 -0500
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: hurd-i386@buildd.debian.org
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi,

I noticed a build failure on hurd-i386, and committed a fix in Userspace
RCU master branch to address this issue. Testing would be welcome. If it
helps, then I might consider backporting this fix into the stable-0.7
branch.


commit 2953b501ab1dcf908d07de9b414a08397519f5b6
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Fri Feb 22 09:05:32 2013 -0500

    Fix tests: finer-grained use of CPU_SET, CPU_ZERO and cpu_set_t
    
    Noticed build failure at
    https://buildd.debian.org/status/package.php?p=liburcu :
    
    Tail of log for liburcu on hurd-i386:
    
    test_urcu.c:110:0: warning: "CPU_SET" redefined [enabled by default]
    In file included from /usr/include/pthread/pthread.h:50:0,
                     from /usr/include/pthread.h:2,
                     from test_urcu.c:26:
    /usr/include/sched.h:80:0: note: this is the location of the previous defini
    make[3]: *** [test_urcu.o] Error 1
    make[2]: *** [all-recursive] Error 1
    make[1]: *** [all] Error 2
    dh_auto_build: make -j1 returned exit code 2
    make: *** [build-arch] Error 2
    dpkg-buildpackage: error: debian/rules build-arch gave error exit status 2
    make[3]: Entering directory `/build/buildd-liburcu_0.7.6-1-hurd-i386-wGBAtt/
      CC     test_urcu.o
    make[3]: Leaving directory `/build/buildd-liburcu_0.7.6-1-hurd-i386-wGBAtt/l
    make[2]: Leaving directory `/build/buildd-liburcu_0.7.6-1-hurd-i386-wGBAtt/l
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

commit fe1f98621fe1cfafdf66c332a004e2a8c8397b2a
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Fri Feb 22 08:50:49 2013 -0500

    Test for CPU_SET
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
