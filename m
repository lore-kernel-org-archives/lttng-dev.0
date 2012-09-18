From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Deaklock in liblttng-ust
Date: Tue, 18 Sep 2012 00:54:49 -0400
Message-ID: <20120918045449.GA16820__19735.8298501515$1347944117$gmane$org@Krystal>
References: <6539770C71C3814BB0BFC2DBEBD1050801062B20@CORPUSMX30B.corp.emc.com>
	<20120913113739.GA27777@Krystal> <5052AC26.5050904@emc.com>
	<20120917133324.GC4256@Krystal> <5057F12E.2090209@emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TDppj-0008O2-R0
	for lttng-dev@lists.lttng.org; Tue, 18 Sep 2012 00:54:51 -0400
Content-Disposition: inline
In-Reply-To: <5057F12E.2090209@emc.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: changz <zheng.chang@emc.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* changz (zheng.chang@emc.com) wrote:
> On 9/17/2012 21:33 PM, Mathieu Desnoyers wrote:
>> * changz (zheng.chang@emc.com) wrote:
>>> ......
>>>
>>> The child process calls _fini when it calls API exit. It gets hung and
>>> meanwhile the parent is waiting for its termination.
>>> I think the whole life-cycle of the process should be considered. The
>>> parent's waiting in critical region is dangerous.
>>> Is it possible to refine the critical region with smaller fineness?
>>>
>>> What do you think?
>> Hrm, yes you're right. I'm looking into it.
>>
>> The main issue is that get_wait_shm() bypass the fork() wrapper (with
>> lttng_ust_nest_count), which is responsible for holding the UST mutex
>> across fork(). Therefore, when exiting the context of the child process,
>> we execute the destructor, which try to grab the UST mutex, which might
>> be in pretty much any state.
>>
>> Given that we don't want this process to try to register to
>> lttng-sessiond (because this is internal to lttng-ust), we might want to
>> let it skip the destructor execution. This would actually be the easiest
>> way out.
>>
>> Does the follow patch fix the issue for you ?
>>
>> diff --git a/liblttng-ust/lttng-ust-comm.c b/liblttng-ust/lttng-ust-comm.c
>> index be64acd..596fd7d 100644
>> --- a/liblttng-ust/lttng-ust-comm.c
>> +++ b/liblttng-ust/lttng-ust-comm.c
>> @@ -616,9 +616,9 @@ int get_wait_shm(struct sock_info *sock_info, size_t mmap_size)
>>   			ret = ftruncate(wait_shm_fd, mmap_size);
>>   			if (ret) {
>>   				PERROR("ftruncate");
>> -				exit(EXIT_FAILURE);
>> +				_exit(EXIT_FAILURE);
>>   			}
>> -			exit(EXIT_SUCCESS);
>> +			_exit(EXIT_SUCCESS);
>>   		}
>>   		/*
>>   		 * For local shm, we need to have rw access to accept
> Yes, it works.
> Just a reminder, here arefour callings of exit in child's path in my git  
> repository.

Indeed! Thanks for the reminder!

Here is the fix:

commit 5d3bc5ed74a4c9f557a75d7de82ed7056adb812e
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Tue Sep 18 00:52:10 2012 -0400

    Fix: get_wait_shm() ust mutex deadlock (add 2 missing exit calls)
    
    Reported-by: changz <zheng.chang@emc.com>
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

backported to stable-2.0.

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
