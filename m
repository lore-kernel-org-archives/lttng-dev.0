From: Lai Jiangshan <laijs@cn.fujitsu.com>
Subject: Re: [RFC URCU PATCH] wfqueue: ABI v1,
 simplify	implementation, 2.3x to 2.6x performance boost
Date: Fri, 07 Sep 2012 11:23:56 +0800
Message-ID: <504968CC.4090101__18684.2212839567$1346988172$gmane$org@cn.fujitsu.com>
References: <20120815213107.GB17224@Krystal> <5032054D.7050508@cn.fujitsu.com>
	<20120820131642.GA551@Krystal> <50330371.6060401@cn.fujitsu.com>
	<50357FF8.9060704@cn.fujitsu.com> <20120906134346.GE3630@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <laijs@cn.fujitsu.com>) id 1T9p9C-0002em-Nj
	for lttng-dev@lists.lttng.org; Thu, 06 Sep 2012 23:22:23 -0400
In-Reply-To: <20120906134346.GE3630@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>, lttng-dev@lists.lttng.org, Lai Jiangshan <eag0628@gmail.com>, rp@svcs.cs.pdx.edu
List-Id: lttng-dev@lists.lttng.org

On 09/06/2012 09:43 PM, Mathieu Desnoyers wrote:
> * Lai Jiangshan (laijs@cn.fujitsu.com) wrote:
>> ping
> 
> we discussed a "batch" design offline. Do you think you would have time
> to spin a patch implementing it ?
> 

I prefer separated enqueue_struct dequeue_struct a little, so I'm waiting for you.

DEADLOCK!

thanks,
Lai
