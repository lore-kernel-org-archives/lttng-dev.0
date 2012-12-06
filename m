From: Lai Jiangshan <laijs@cn.fujitsu.com>
Subject: Re: [URCU pull request review] urcu improvements
Date: Thu, 06 Dec 2012 11:59:14 +0800
Message-ID: <50C01812.7060400__32799.8403613039$1354769716$gmane$org@cn.fujitsu.com>
References: <1353440429-19223-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <laijs@cn.fujitsu.com>) id 1TgTTp-000320-6K
	for lttng-dev@lists.lttng.org; Wed, 05 Dec 2012 23:54:37 -0500
In-Reply-To: <1353440429-19223-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Alan Stern <stern@rowland.harvard.edu>, rp@svcs.cs.pdx.edu
List-Id: lttng-dev@lists.lttng.org

ACK for the whole patchset.

Thanks,
Lai

On 11/21/2012 03:40 AM, Mathieu Desnoyers wrote:
> Here is a pull request to myself for my recent work on wfcqueue and urcu
> flavors into the userspace RCU master branch.
> 
> Please let me know if you see any immediate show stoppers.
> 
> List of changes:
> 
> [PATCH 01/16] Fix: wfcqueue nonblocking dequeue
> [PATCH 02/16] wfcqueue: enqueue and splice return queue state
> [PATCH 03/16] test wfcqueue: add tests for queue state return value
> [PATCH 04/16] urcu-call-rcu: use wait-free splice return value
> [PATCH 05/16] wfcqueue: document empty criterion
> [PATCH 06/16] wfcqueue: implement mutex-free splice
> [PATCH 07/16] urcu-qsbr: improve 2-phase wait scheme
> [PATCH 08/16] urcu-mb/signal/membarrier: improve 2-phase wait scheme
> [PATCH 09/16] urcu-bp: improve 2-phase wait scheme
> [PATCH 10/16] urcu-qsbr: move offline threads to separate list
> [PATCH 11/16] urcu-mb/signal/membarrier: move quiescent threads to
> [PATCH 12/16] urcu-bp: move quiescent threads to separate list
> [PATCH 13/16] tests: use standard malloc/free for synchronize_rcu()
> [PATCH 14/16] urcu-qsbr: batch concurrent synchronize_rcu()
> [PATCH 15/16] urcu-wait: move wait code into separate file
> [PATCH 16/16] urcu-wait: move queue management code into urcu-wait.h
> 
> diffstat:
> 
>  Makefile.am             |    2 
>  tests/test_urcu.c       |   60 ++------------
>  tests/test_urcu_bp.c    |   59 ++------------
>  tests/test_urcu_qsbr.c  |   61 ++-------------
>  tests/test_urcu_wfcq.c  |  131 +++++++++++++++++++++++++-------
>  urcu-bp.c               |   88 ++++++++++++++-------
>  urcu-call-rcu-impl.h    |    9 +-
>  urcu-qsbr.c             |  193 ++++++++++++++++++++++++++++++++++++------------
>  urcu-wait.h             |  184 +++++++++++++++++++++++++++++++++++++++++++++
>  urcu.c                  |   95 +++++++++++++++--------
>  urcu/static/urcu-bp.h   |   29 ++++---
>  urcu/static/urcu-qsbr.h |   14 ++-
>  urcu/static/urcu.h      |   15 ++-
>  urcu/static/wfcqueue.h  |  133 +++++++++++++++++++++++++--------
>  urcu/wfcqueue.h         |   62 +++++++++++----
>  wfcqueue.c              |   16 +--
>  16 files changed, 786 insertions(+), 365 deletions(-)
> 
> Thanks,
> 
> Mathieu
> 
> 
