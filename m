From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: userspace rcu flavor improvements
Date: Sat, 17 Nov 2012 11:16:39 -0500
Message-ID: <1353169007-31389-1-git-send-email-mathieu.desnoyers__6530.85019807822$1353169095$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <mathieu.desnoyers@efficios.com>) id 1TZl5D-0000qf-UT
	for lttng-dev@lists.lttng.org; Sat, 17 Nov 2012 11:17:27 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org, rp@svcs.cs.pdx.edu, "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>, Lai Jiangshan <laijs@cn.fujitsu.com>, Alan Stern <stern@rowland.harvard.edu>
List-Id: lttng-dev@lists.lttng.org

Here are a couple of improvements for all userspace RCU flavors. Many
thanks to Alan Stern for his suggestions.

Patch 8/8 is only done for qsbr so far, and proposed as RFC. I'd like to
try and benchmark other approaches to concurrent grace periods too.

Feedback is welcome,

Thanks,

Mathieu
