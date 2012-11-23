From: Lai Jiangshan <laijs@cn.fujitsu.com>
Subject: Re: [PATCH 14/16] urcu-qsbr: batch concurrent
	synchronize_rcu()
Date: Fri, 23 Nov 2012 10:23:03 +0800
Message-ID: <50AEDE07.6040705__32487.5539554798$1353637297$gmane$org@cn.fujitsu.com>
References: <1353440429-19223-1-git-send-email-mathieu.desnoyers@efficios.com>
	<1353440429-19223-15-git-send-email-mathieu.desnoyers@efficios.com>
	<50AC8F56.6040109@cn.fujitsu.com> <20121121183304.GA25932@Krystal>
	<50ADEAAF.1010703@cn.fujitsu.com>
	<20121122183041.GB2829@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <laijs@cn.fujitsu.com>) id 1TbisH-0001ia-Qi
	for lttng-dev@lists.lttng.org; Thu, 22 Nov 2012 21:20:14 -0500
In-Reply-To: <20121122183041.GB2829@linux.vnet.ibm.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: paulmck@linux.vnet.ibm.com
Cc: Alan Stern <stern@rowland.harvard.edu>, lttng-dev@lists.lttng.org, rp@svcs.cs.pdx.edu, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: lttng-dev@lists.lttng.org

On 11/23/2012 02:30 AM, Paul E. McKenney wrote:
> On Thu, Nov 22, 2012 at 05:04:47PM +0800, Lai Jiangshan wrote:
>> On 11/22/2012 02:33 AM, Mathieu Desnoyers wrote:
>>> * Lai Jiangshan (laijs@cn.fujitsu.com) wrote:
>>>> Could you delay 14~16 for 40 days if I don't implement it in 40 days?
>>>
>>> I'm curious to know more about the changes you are planning. Is that
>>> another way to implement grace periods that would allow multiple threads
>>> to execute synchronize_rcu() concurrently ?
>>
>> synchronize_rcu()s in this implement share coarse-grain step(1 GP)
>> to achieve concurrence. My implement will use fine-grain step(1 check or 1 flip)
>> like SRCU. and call_rcu() is also considered in this implement to avoid
>> unneeded wait.
>>
>>>
>>> Please note that changes in these algorithms will need to go through
>>> very strict review/validation/verification. So I expect that if it takes
>>> 40 days to implement, we can plan at least 3-4 months of validation work.
>>
>> I means I don't have time. If I can't steal some time from the late 40 days,
>> this code is OK for me.
> 
> Why don't we take the current code, which would allow some academic
> projects to test on large systems in the next few months, and then
> replace it with your code when available and if appropriate?
> 


Agreed.

thanks,
Lai
