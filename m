From: Richard Braun <rbraun@sceen.net>
Subject: Quick questions about liburcu and RCU in general
Date: Tue, 7 May 2013 11:46:36 +0200
Message-ID: <20130507094636.GA6151__19766.9715075337$1367928068$gmane$org@mail.sceen.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from shattrath.sceen.net ([94.23.252.191] helo=mail.sceen.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <rbraun@sceen.net>) id 1UZeTm-00081S-D0
	for lttng-dev@lists.lttng.org; Tue, 07 May 2013 05:46:38 -0400
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

Hello,

I'm currently studying RCU/URCU, and I have a few questions that I wasn't
sure where to ask.

1/ Why use poll instead of sched_yield in e.g. force_mb_all_readers ?
(I guess it's about portability and the effect is expected to be the same,
but is there another reason ?)

2/ What was the conclusion of the discussion regarding sys_membarrier ?
(I couldn't find it in the main mail thread, and it looks quite interesting,
even though I expect most carefully written applications not to exceed
one thread per processor too much)

3/ Do you know if IBM allows the use of patented RCU techniques in GPLv3+
code as well ? ("GPL" is mentioned in the Linux documentation, and
apparently liburcu is covered by LGPLv2+ so I expect that to be the case,
just looking for a confirmation)

Thanks for your answers.

-- 
Richard Braun
