From: Lai Jiangshan <laijs@cn.fujitsu.com>
Subject: Re: [RFC URCU PATCH] wfqueue: ABI v1,
 simplify implementation, 2.3x to 2.6x performance boost
Date: Tue, 21 Aug 2012 08:12:04 +0800
Message-ID: <5032D254.7040207__35854.0234891281$1345507886$gmane$org@cn.fujitsu.com>
References: <20120815213107.GB17224@Krystal> <5032054D.7050508@cn.fujitsu.com>
	<20120820131642.GA551@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <laijs@cn.fujitsu.com>) id 1T3c3d-0007Iv-0P
	for lttng-dev@lists.lttng.org; Mon, 20 Aug 2012 20:10:57 -0400
In-Reply-To: <20120820131642.GA551@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, Paul McKenney <paulmck@linux.vnet.ibm.com>, rp@svcs.cs.pdx.edu
List-Id: lttng-dev@lists.lttng.org

On 08/20/2012 09:16 PM, Mathieu Desnoyers wrote:
> * Lai Jiangshan (laijs@cn.fujitsu.com) wrote:
>> On 08/16/2012 05:31 AM, Mathieu Desnoyers wrote:
>>> This work is derived from the patch from Lai Jiangshan submitted as
>>> "urcu: new wfqueue implementation"
>>> (http://lists.lttng.org/pipermail/lttng-dev/2012-August/018379.html)
>>>
>>
> 
> Hi Lai,
> 
>> Hi, Mathieu
>>
>> please add this part to your patch.
>>
>> Changes(item5 has alternative):
>>
>> 1) Reorder the head and the tail in struct cds_wfq_queue
>>    Reason: wfq is enqueue-preference
> 
> Is this a technical improvement over the original order ? Both cache
> lines are aligned, so it should not matter which one comes first. So I'm
> not sure why we should favor one order vs the other.

struct astruct {
	int foo; /* field offset = 0 */
	int bar; /* field offset = 4 */
};

Access to p->foo and access to p->bar are different in CPU instruction.
Access to p->bar will need to add a offset to p. (the addition may cost a very small time)
instructions will be probably longer than the instructions access to p->foo.

If the code of access to p->bar is significant more than the code of access to p->foo,
we should swap p->bar and p->foo field's order to shorten the total instruction size
to reduce footprint.

Our enqueue is inline function, when this inline function is expanded in every call site,
the code of access to the tail will much significant, so we need to put the tail at first.



> 
>> 2) Reorder the code of ___cds_wfq_next_blocking()
>>    Reason: short code, better readability
> 
> Yes, I agree with this change. Can you extract it into a separate patch ?

You merge it into your patch which ___cds_wfq_next_blocking() is introduced.

> 
>>
>> 3) Add cds_wfq_dequeue_[un]lock
>>    Reason: the fields of struct cds_wfq_queue are not exposed to users of lib,
>> 	but some APIs needs to have this lock held. Add this locking function
>> 	to allow the users use such APIs
> 
> I agree with this change too. You can put it into the same patch as (2).

You merge it into your patch.
