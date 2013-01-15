From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH] Add ACCESS_ONCE() to avoid compiler splitting assignments
Date: Tue, 15 Jan 2013 10:19:36 -0800
Message-ID: <20130115181936.GA30319@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: lttng-dev@lists.lttng.org, linux-kernel@vger.kernel.org, rp@svcs.cs.pdx.edu
Cc: mathieu.desnoyers@efficios.com, laijs@cn.fujitsu.com, shemminger@vyatta.com, stern@rowland.harvard.edu, khlebnikov@openvz.org
List-Id: lttng-dev@lists.lttng.org

As noted by Konstantin Khlebnikov, gcc can split assignment of
constants to long variables (https://lkml.org/lkml/2013/1/15/141),
though assignment of NULL (0) is OK.  Assuming that a gcc bug is
fixed (http://gcc.gnu.org/bugzilla/attachment.cgi?id=29169&action=diff
has a patch), making the store be volatile keeps gcc from splitting.

This commit therefore applies ACCESS_ONCE() to CMM_STORE_SHARED(),
which is the underlying primitive used by rcu_assign_pointer().

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

diff --git a/urcu/system.h b/urcu/system.h
index 2a45f22..7a1887e 100644
--- a/urcu/system.h
+++ b/urcu/system.h
@@ -49,7 +49,7 @@
  */
 #define CMM_STORE_SHARED(x, v)		\
 	({				\
-		__typeof__(x) _v = _CMM_STORE_SHARED(x, v);	\
+		__typeof__(x) CMM_ACCESS_ONCE(_v) = _CMM_STORE_SHARED(x, v);	\
 		cmm_smp_wmc();		\
 		_v;			\
 	})
