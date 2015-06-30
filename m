From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH urcu] Fix: make benchmark test run in oot
	build
Date: Tue, 30 Jun 2015 15:18:24 +0000 (UTC)
Message-ID: <2061220050.1315.1435677504889.JavaMail.zimbra__19260.3406533182$1435677598$gmane$org@efficios.com>
References: <1435676655-16099-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1Z9xJ8-0006nS-Cy
 for lttng-dev@lists.lttng.org; Tue, 30 Jun 2015 11:18:51 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 77D1C340367
 for <lttng-dev@lists.lttng.org>; Tue, 30 Jun 2015 15:18:41 +0000 (UTC)
In-Reply-To: <1435676655-16099-1-git-send-email-mjeanson@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Merged into master and stable-0.8, thanks!

Mathieu

----- On Jun 30, 2015, at 11:04 AM, Michael Jeanson mjeanson@efficios.com wrote:

> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
> tests/benchmark/Makefile.am       | 32 ++++++++++++++++++++++++++++++--
> tests/benchmark/common.sh         |  0
> tests/benchmark/runpaul-phase5.sh |  0
> tests/benchmark/runpaul-phase6.sh |  0
> 4 files changed, 30 insertions(+), 2 deletions(-)
> mode change 100644 => 100755 tests/benchmark/common.sh
> mode change 100644 => 100755 tests/benchmark/runpaul-phase5.sh
> mode change 100644 => 100755 tests/benchmark/runpaul-phase6.sh
> 
> diff --git a/tests/benchmark/Makefile.am b/tests/benchmark/Makefile.am
> index 85d454d..e25dd8f 100644
> --- a/tests/benchmark/Makefile.am
> +++ b/tests/benchmark/Makefile.am
> @@ -3,6 +3,22 @@ AM_LDFLAGS=-lpthread
> endif
> AM_CFLAGS=-I$(top_srcdir) -I$(top_builddir) -I$(top_srcdir)/tests/common -g
> 
> +SCRIPT_LIST = common.sh \
> +	runall.sh \
> +	runhash.sh \
> +	runtests.sh \
> +	runpaul-phase1.sh \
> +	runpaul-phase2.sh \
> +	runpaul-phase3.sh \
> +	runpaul-phase4.sh \
> +	runpaul-phase5.sh \
> +	runpaul-phase6.sh \
> +	runpaul-phase7.sh \
> +	runtests-batch.sh \
> +	subphase4.sh
> +
> +dist_noinst_SCRIPTS = $(SCRIPT_LIST)
> +
> noinst_PROGRAMS = test_urcu test_urcu_dynamic_link test_urcu_timing \
> 	test_urcu_signal test_urcu_signal_dynamic_link test_urcu_signal_timing \
>         test_rwlock_timing test_rwlock test_perthreadlock_timing \
> @@ -32,8 +48,6 @@ URCU_CDS_LIB=$(top_builddir)/liburcu-cds.la
> 
> DEBUG_YIELD_LIB=$(builddir)/../common/libdebug-yield.la
> 
> -EXTRA_DIST = *.sh
> -
> test_urcu_SOURCES = test_urcu.c
> test_urcu_LDADD = $(URCU_LIB)
> 
> @@ -194,6 +208,20 @@ test_urcu_hash_SOURCES = test_urcu_hash.c test_urcu_hash.h
> \
> test_urcu_hash_CFLAGS = -DRCU_QSBR $(AM_CFLAGS)
> test_urcu_hash_LDADD = $(URCU_QSBR_LIB) $(URCU_COMMON_LIB) $(URCU_CDS_LIB)
> 
> +all-local:
> +	@if [ x"$(srcdir)" != x"$(builddir)" ]; then \
> +		for script in $(SCRIPT_LIST); do \
> +			cp -f $(srcdir)/$$script $(builddir); \
> +		done; \
> +	fi
> +
> +clean-local:
> +	@if [ x"$(srcdir)" != x"$(builddir)" ]; then \
> +		for script in $(SCRIPT_LIST); do \
> +			rm -f $(builddir)/$$script; \
> +		done; \
> +	fi
> +
> .PHONY: bench
> 
> bench:
> diff --git a/tests/benchmark/common.sh b/tests/benchmark/common.sh
> old mode 100644
> new mode 100755
> diff --git a/tests/benchmark/runpaul-phase5.sh
> b/tests/benchmark/runpaul-phase5.sh
> old mode 100644
> new mode 100755
> diff --git a/tests/benchmark/runpaul-phase6.sh
> b/tests/benchmark/runpaul-phase6.sh
> old mode 100644
> new mode 100755
> --
> 1.9.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
