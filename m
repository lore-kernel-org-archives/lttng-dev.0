From: Lai Jiangshan <laijs@cn.fujitsu.com>
Subject: Re: userspace rcu flavor improvements
Date: Mon, 19 Nov 2012 15:52:18 +0800
Message-ID: <50A9E532.6000706__6636.0127566897$1353311408$gmane$org@cn.fujitsu.com>
References: <1353169007-31389-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <laijs@cn.fujitsu.com>) id 1TaM6m-0001Lw-A8
	for lttng-dev@lists.lttng.org; Mon, 19 Nov 2012 02:49:32 -0500
In-Reply-To: <1353169007-31389-1-git-send-email-mathieu.desnoyers@efficios.com>
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
> Here are a couple of improvements for all userspace RCU flavors. Many
> thanks to Alan Stern for his suggestions.


It makes urcu like SRCU. (sync_rcu = check zero + flip + check zero)
If I have time, I may port more SRCU code to urcu.

> 
> Patch 8/8 is only done for qsbr so far, and proposed as RFC. I'd like to
> try and benchmark other approaches to concurrent grace periods too.
> 
> Feedback is welcome,
> 
> Thanks,
> 
> Mathieu
> 
> 
