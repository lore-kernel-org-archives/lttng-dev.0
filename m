From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: liburcu sparc support, build failure on buildd
Date: Fri, 22 Feb 2013 09:15:51 -0500
Message-ID: <20130222141551.GB22156__36415.536949835$1361542659$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1U8tPk-0006Qb-QW
	for lttng-dev@lists.lttng.org; Fri, 22 Feb 2013 09:15:52 -0500
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: sparc@buildd.debian.org, debian-sparc@lists.debian.org
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi,

I notice the following build failure here

https://buildd.debian.org/status/package.php?p=liburcu

Tail of log for liburcu on sparc:

urcu/static/wfqueue.h:84:2: warning: implicit declaration of function 'CMM_STORE_SHARED' [-Wimplicit-function-declaration]
urcu/static/wfqueue.h: In function '___cds_wfq_node_sync_next':
urcu/static/wfqueue.h:99:2: warning: implicit declaration of function 'CMM_LOAD_SHARED' [-Wimplicit-function-declaration]
urcu/static/wfqueue.h:99:15: warning: assignment makes pointer from integer without a cast [enabled by default]
urcu/static/wfqueue.h:104:4: warning: implicit declaration of function 'caa_cpu_relax' [-Wimplicit-function-declaration]
urcu/static/wfqueue.h: In function '___cds_wfq_dequeue_blocking':
urcu/static/wfqueue.h:126:55: warning: comparison between pointer and integer [enabled by default]
make[3]: *** [wfqueue.lo] Error 1
make[3]: Leaving directory `/build/buildd-liburcu_0.7.6-1-sparc-GySyug/liburcu-0.7.6'
make[2]: *** [all-recursive] Error 1
make[2]: Leaving directory `/build/buildd-liburcu_0.7.6-1-sparc-GySyug/liburcu-0.7.6'
make[1]: *** [all] Error 2
make[1]: Leaving directory `/build/buildd-liburcu_0.7.6-1-sparc-GySyug/liburcu-0.7.6'
dh_auto_build: make -j1 returned exit code 2
make: *** [build-arch] Error 2

One main question I have: what sparc architectures are supported by
Debian's "sparc" architecture ? Userspace RCU only supports Sparcv9 and
onward, because it requires some atomic instructions.

As documented in the urcu README file, building a package that includes
sparcv9 isntructions for 32-bit sparc can be done with:

CFLAGS="-m32 -Wa,-Av9a -g -O2" ./configure

But if Debian sparc needs to support pre-v9 sparcs, then I guess it
would not be appropriate to use v9 instructions for urcu sparc build.

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
