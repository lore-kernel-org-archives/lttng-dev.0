From: Lai Jiangshan <laijs@cn.fujitsu.com>
Subject: Re: [PATCH 5/8] urcu-mb/signal/membarrier: move
 quiescent threads to separate list
Date: Mon, 19 Nov 2012 15:16:34 +0800
Message-ID: <50A9DCD2.7000009__37247.6426455707$1353309471$gmane$org@cn.fujitsu.com>
References: <1353169007-31389-1-git-send-email-mathieu.desnoyers@efficios.com>
	<1353169007-31389-6-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <laijs@cn.fujitsu.com>) id 1TaLbT-00016H-VN
	for lttng-dev@lists.lttng.org; Mon, 19 Nov 2012 02:17:12 -0500
In-Reply-To: <1353169007-31389-6-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>, lttng-dev@lists.lttng.org, rp@svcs.cs.pdx.edu, Alan Stern <stern@rowland.harvard.edu>
List-Id: lttng-dev@lists.lttng.org

On 11/18/2012 12:16 AM, Mathieu Desnoyers wrote:
> Accelerate 2-phase grace period by not having to iterate twice on
> threads not nested within a RCU read-side lock.

You almost gain nothing.
The first wait_for_readers() waits none very likely.

> @@ -341,7 +361,12 @@ void synchronize_rcu(void)
>  	/*
>  	 * Wait for readers to observe new parity or be quiescent.
>  	 */
> -	wait_for_readers();
> +	wait_for_readers(&registry, NULL, &qsreaders);

wait_for_readers(&cur_snap_readers, NULL, &qsreaders);
