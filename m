From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH userspace-rcu] use a filled signal mask
	to	disable all signals
Date: Fri, 10 May 2013 07:38:02 -0400
Message-ID: <20130510113802.GA15131__46106.3447910876$1368185919$gmane$org@Krystal>
References: <29C931202891DE4ABE913168E7AC43EC014227E029@ONWVEXCHMB01.ciena.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UaleH-0005Ec-Uk
	for lttng-dev@lists.lttng.org; Fri, 10 May 2013 07:38:06 -0400
Content-Disposition: inline
In-Reply-To: <29C931202891DE4ABE913168E7AC43EC014227E029@ONWVEXCHMB01.ciena.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Pelton, Dave" <dpelton@ciena.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Dave,

Nice catch ! I've reworked the patch to also fix compat_arch_x86.c and
use SIG_BLOCK at those sites (details in changelog). Here is the version
I plan to merge into userspace rcu. Thanks for spotting this!

Mathieu

commit 6ed4b2e64c6cef5d6d1a1c1943f29dbf4edf026a
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Fri May 10 07:30:18 2013 -0400

    Fix: Use a filled signal mask to disable all signals
    
    Changelog from David Pelton's original patch:
    
    While using lttng-ust with an application that was calling fork()
    with pending signals, I found that all signals were getting unmasked
    shortly before the underlying call to fork().  After some
    investigation, I found that the rcu_bp_before_fork() function was
    unmasking all signals.  Based on the comments for this function, it
    should be masking all signals.  Inspection of the rest of the code
    in urcu-bp.c revealed the same pattern in two other functions.
    
    This patch changes the code to use a filled signal mask to disable
    all signals.  The change to rcu_bp_before_fork() addressed the
    problem I was seeing while using lttng-ust.  The changes to the
    other two functions appear to fix other instances of the same
    problem.
    
    Updates by Mathieu Desnoyers:
    
    - Use SIG_BLOCK instead of SIG_SETMASK when setting a filled mask. This
      has the same behavior in this case (since we're blocking all signals),
      but is semantically neater: if we ever some signals from that mask,
      we'd like to to a union with the signal mask already blocked by the
      application.
    - Also fix incorrect signal masking in compat_arch_x86.c.
    
    Reported-by: David Pelton <dpelton@ciena.com>
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

diff --git a/compat_arch_x86.c b/compat_arch_x86.c
index 714201b..7d3b83a 100644
--- a/compat_arch_x86.c
+++ b/compat_arch_x86.c
@@ -80,9 +80,9 @@ static void mutex_lock_signal_save(pthread_mutex_t *mutex, sigset_t *oldmask)
 	int ret;
 
 	/* Disable signals */
-	ret = sigemptyset(&newmask);
+	ret = sigfillset(&newmask);
 	assert(!ret);
-	ret = pthread_sigmask(SIG_SETMASK, &newmask, oldmask);
+	ret = pthread_sigmask(SIG_BLOCK, &newmask, oldmask);
 	assert(!ret);
 	ret = pthread_mutex_lock(&compat_mutex);
 	assert(!ret);
diff --git a/urcu-bp.c b/urcu-bp.c
index ef1e687..a823659 100644
--- a/urcu-bp.c
+++ b/urcu-bp.c
@@ -213,9 +213,9 @@ void synchronize_rcu(void)
 	sigset_t newmask, oldmask;
 	int ret;
 
-	ret = sigemptyset(&newmask);
+	ret = sigfillset(&newmask);
 	assert(!ret);
-	ret = pthread_sigmask(SIG_SETMASK, &newmask, &oldmask);
+	ret = pthread_sigmask(SIG_BLOCK, &newmask, &oldmask);
 	assert(!ret);
 
 	mutex_lock(&rcu_gp_lock);
@@ -385,9 +385,9 @@ void rcu_bp_register(void)
 	sigset_t newmask, oldmask;
 	int ret;
 
-	ret = sigemptyset(&newmask);
+	ret = sigfillset(&newmask);
 	assert(!ret);
-	ret = pthread_sigmask(SIG_SETMASK, &newmask, &oldmask);
+	ret = pthread_sigmask(SIG_BLOCK, &newmask, &oldmask);
 	assert(!ret);
 
 	/*
@@ -420,9 +420,9 @@ void rcu_bp_before_fork(void)
 	sigset_t newmask, oldmask;
 	int ret;
 
-	ret = sigemptyset(&newmask);
+	ret = sigfillset(&newmask);
 	assert(!ret);
-	ret = pthread_sigmask(SIG_SETMASK, &newmask, &oldmask);
+	ret = pthread_sigmask(SIG_BLOCK, &newmask, &oldmask);
 	assert(!ret);
 	mutex_lock(&rcu_gp_lock);
 	saved_fork_signal_mask = oldmask;

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
