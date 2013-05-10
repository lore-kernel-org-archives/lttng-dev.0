From: "Pelton, Dave" <dpelton@ciena.com>
Subject: [PATCH userspace-rcu] use a filled signal mask to
 disable all signals
Date: Fri, 10 May 2013 01:32:52 -0400
Message-ID: <29C931202891DE4ABE913168E7AC43EC014227E029__43966.9813997627$1368164037$gmane$org@ONWVEXCHMB01.ciena.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx0b-00103a01.pphosted.com ([67.231.152.227])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <prvs=2842897bbe=dpelton@ciena.com>)
	id 1UafxF-0002Bf-7X
	for lttng-dev@lists.lttng.org; Fri, 10 May 2013 01:33:17 -0400
Received: from pps.filterd (m0001124 [127.0.0.1])
	by mx0b-00103a01.pphosted.com (8.14.4/8.14.4) with SMTP id
	r4A5WMD7026500
	for <lttng-dev@lists.lttng.org>; Fri, 10 May 2013 01:33:16 -0400
Received: from mdwexght02.ciena.com (LIN1-118-36-29.ciena.com [63.118.36.29])
	by mx0b-00103a01.pphosted.com with ESMTP id 1c8sc488eg-1
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
	for <lttng-dev@lists.lttng.org>; Fri, 10 May 2013 01:33:16 -0400
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

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

Signed-off-by: David Pelton <dpelton@ciena.com>
---
 urcu-bp.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/urcu-bp.c b/urcu-bp.c
index ef1e687..416a1b9 100644
--- a/urcu-bp.c
+++ b/urcu-bp.c
@@ -213,7 +213,7 @@ void synchronize_rcu(void)
 	sigset_t newmask, oldmask;
 	int ret;
 
-	ret = sigemptyset(&newmask);
+	ret = sigfillset(&newmask);
 	assert(!ret);
 	ret = pthread_sigmask(SIG_SETMASK, &newmask, &oldmask);
 	assert(!ret);
@@ -385,7 +385,7 @@ void rcu_bp_register(void)
 	sigset_t newmask, oldmask;
 	int ret;
 
-	ret = sigemptyset(&newmask);
+	ret = sigfillset(&newmask);
 	assert(!ret);
 	ret = pthread_sigmask(SIG_SETMASK, &newmask, &oldmask);
 	assert(!ret);
@@ -420,7 +420,7 @@ void rcu_bp_before_fork(void)
 	sigset_t newmask, oldmask;
 	int ret;
 
-	ret = sigemptyset(&newmask);
+	ret = sigfillset(&newmask);
 	assert(!ret);
 	ret = pthread_sigmask(SIG_SETMASK, &newmask, &oldmask);
 	assert(!ret);
-- 
1.6.2.5
