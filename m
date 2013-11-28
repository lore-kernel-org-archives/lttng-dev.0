From: Paul Woegerer <paul_woegerer@mentor.com>
Subject: [PATCH lttng-ust 0/3] Solve remaining issues with
	base-address-state tracing
Date: Thu, 28 Nov 2013 13:26:51 +0100
Message-ID: <1385641614-18806-1-git-send-email-paul_woegerer__8475.02177716724$1385641687$gmane$org@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1Vm0gj-0001Hf-Mk
	for lttng-dev@lists.lttng.org; Thu, 28 Nov 2013 07:27:23 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org, mathieu.desnoyers@efficios.com, dgoulet@efficios.com
List-Id: lttng-dev@lists.lttng.org

This patch series addresses the remaining issues that were reported against
base-address-state tracing. Base-address-state tracing is now fully integrated
into lttng-ust (no separate shared object anymore).

Users that would like to suppress the generation of ust_baddr_statedump events
entirely can now use environment variable LTTNG_UST_WITHOUT_BADDR_STATEDUMP=1.

The deadlock in combination with JUL tracing is also fixed now. It was caused
by the fact that JUL tracing causes the static constructor of lttng-ust to be
called in the context of dlopen:

To setup JUL tracing the JVM executes:

   System.loadLibrary("lttng-ust-jul-jni");

This effectively dlopen's lttng-ust-jul-jni.so.0 and that will cause the static
ctor of lttng-ust to get executed. Now if the completion of the execution of
the lttng-ust ctor depends on someone that tries to acquire a lock on glibc's
dl_load_lock we run into a deadlock because the lock is already hold as a side
effect of the dlopen that was initiated by the JVM to load "lttng-ust-jul-jni".
But exactly that happened when base-address-state tracing tries to generate
ust_baddr_statedump events on session-enable (e.g. calling dladdr or emitting a
tracepoint all try to acquire the dl_load_lock).

By making the ust_baddr_statedump happen a "little later" so that it cannot
block the completion of the static ctor anymore, the deadlock is prevented.
Once we know the static ctor will complete for sure we also know that the JVM
initiated dlopen that called the static ctor will complete.  At that point is
is again safe to use calls that involve acquiring dl_load_lock. Making the
statedump happen a "little later" is implemented by patch:

   Fix: baddr_statedump deadlock with JUL tracing


Paul Woegerer (3):
  Integrate base-address statedump into lttng-ust
  Fix: baddr_statedump deadlock with JUL tracing
  Allow suppressing of base-address-state tracing

 Makefile.am                                        |  3 +-
 liblttng-ust-baddr/Makefile.am                     | 18 +----
 liblttng-ust-baddr/lttng-ust-baddr.c               | 34 ++--------
 liblttng-ust-baddr/lttng-ust-baddr.h               | 22 +++++++
 liblttng-ust-baddr/ust_baddr_statedump.h           |  2 +-
 liblttng-ust-dl/Makefile.am                        |  5 +-
 .../ust_baddr.c                                    |  0
 .../ust_baddr.h                                    |  0
 liblttng-ust-dl/ustdl.c                            | 76 ++++++----------------
 liblttng-ust/Makefile.am                           |  1 +
 liblttng-ust/lttng-ust-comm.c                      | 50 ++------------
 11 files changed, 63 insertions(+), 148 deletions(-)
 create mode 100644 liblttng-ust-baddr/lttng-ust-baddr.h
 rename {liblttng-ust-baddr => liblttng-ust-dl}/ust_baddr.c (100%)
 rename {liblttng-ust-baddr => liblttng-ust-dl}/ust_baddr.h (100%)

-- 
1.8.4
