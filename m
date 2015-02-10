From: Wang Nan <wangnan0@huawei.com>
Subject: Re: [diamon-discuss] My experience on perf,
 CTF and TraceCompass, and some suggection.
Date: Tue, 10 Feb 2015 12:55:22 +0800
Message-ID: <54D98F3A.8020202__24630.3762113259$1423544666$gmane$org@huawei.com>
References: <54C215D6.1030804@huawei.com> <54C2770F.4080305@voxpopuli.im>
 <54CC80CA.2020603@huawei.com> <54D2800B.3050808@voxpopuli.im>
 <54D582E9.4010709@huawei.com> <54D59F4B.4060608@voxpopuli.im>
 <54D5BDCD.5040407@huawei.com> <54D914D0.6000206@voxpopuli.im>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from szxga02-in.huawei.com ([119.145.14.65])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <wangnan0@huawei.com>) id 1YL2z6-0003Qk-0b
 for lttng-dev@lists.lttng.org; Tue, 10 Feb 2015 00:03:48 -0500
In-Reply-To: <54D914D0.6000206@voxpopuli.im>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Cc: Xinwei Hu <huxinwei@huawei.com>, "diamon-discuss@lists.linuxfoundation.org" <diamon-discuss@lists.linuxfoundation.org>, lttng-dev@lists.lttng.org, tracecompass developer discussions <tracecompass-dev@eclipse.org>
List-Id: lttng-dev@lists.lttng.org

On 2015/2/10 4:13, Alexandre Montplaisir wrote:
> 
> On 02/07/2015 02:25 AM, Wang Nan wrote:
>> On 2015/2/7 13:14, Alexandre Montplaisir wrote:
>>> On 2015-02-06 10:13 PM, Wang Nan wrote:
>>>>> I think such an approach could help in all 3 use cases you have presented. What do you think?
>>>> Good to see you are looking at this problem.
>>>>
>>>> "Frequency analysis" you mentioned is a good viewpoint for finding outliner. However, it should not be the only one we consider. Could you please explain how "frequency analysis" can solve my first problem "finding the reason why most of CPUs are idle by matching syscalls events?"
>>>>
>>>> Thank you!
>>>>
>>> I was thinking of the automatic event matching, for example matching syscall_entry_* events with their corresponding syscall_exit_*. This is a pre-requisite of doing frequency analysis, but could be useful on its own. (Re-reading myself now I notice I didn't mention event matching at all, my bad!)
>>>
>>> If I understand your first problem correctly, it boils down to wanting to identify the system call that is ongoing when a CPU is idle. And this is not straightforward, because the Select Next/Previous Event buttons in the time graph views will stop at every state transition, like CPU idle or IRQs, which are "in the way" of the system call entry event. Correct?
>>>
>>>
>>> Now, what if we had a view that simply lists all the system calls in the trace? Each row would contain the complete information of a system call, so its start time (timestamp of the sys_entry event), end time (timestamp of the sys_exit event), duration, name/id, arguments, return value, etc.
>>>
>>> And this view could be synchronized with the other ones, where clicking on a row would bring you to the corresponding syscall_entry event. And inversely, clicking on any timestamp would bring this view to the row corresponding to the system call that was active at that time, if there is one. I believe this could speed up your problem of identifying the running system call for any arbitrary point in the trace.
>>>
>>> Also, that view could be re-used for other types of intervals, like IRQs, IO operations, and so on. And if the user sorts by the Duration column, bam, they have a sorted list of the worst offenders for longer system calls, IRQs, etc.
>>>
>>>
>>> Would this be helpful?
>>>
>> Correct, it should be helpful. If I understand your description correctly, you are thinking another time
>> chart view like resource view and control flow view, this time each row is a syscall, like this:
> 
> In fact, for the "event matching" what I had in mind was a simple text table, where every line represents one (entire) system call, so you would have columns like:
> 
> start | end | duration | name/id |     arguments       | return
> 
> ------|-----|----------|---------|---------------------|-------
> 10    | 15  |    5     | open    | path=abc, flags=... |   4
> 20    | 23  |    3     | close   | fd=4                |   0
> ....
> 
> 
> It would then be easy to synchronize this view with the others, so that it would point to the ongoing system call(s) whenever the user selects a timestamp in another view. And vice versa, clicking on an entry in this table would move to the corresponding syscall_entry event.
> 
> The view could also be generalized for other things (IRQs?), either in different views, or the same view with a drop-down showing which type of information to display.
> 
> 
> And for the so-called frequency analysis, you use the data from the "duration" column to populate a histogram (or point cloud?) showing how the distribution of latency of every system call (Y axis represents the absolute number of occurrences):
> 
> 
> |
> 
> |           ___
> 
> |           ___
> 
> |     ___   ___         ___
> 
> |__   ___   ___   ___   ___
> 
> +-----------------------------
> 
>  0-5  5-10  10-15 15-20 20+
>    duration of syscall (ms)
> 
> 
> So in this example we could see right away that the average duration is around 10-15 ms, but we have some outliers that took more than 20 ms, so it would be interesting to zoom in there to get more details. And eventually clicking on one particular occurrence could bring you to the exact point in the trace where it happened (or create bookmarks for the outlier entries, etc.)
> 

Looks good. It should be better if users are able to define their own matching rules.

In addition, do you think about chaining more than 2 events together? Some procedures, such as IO and network, can be traced at different layers, and we are able to chain events caused by same sources together with some cules. Please refer to:

http://comments.gmane.org/gmane.linux.kernel/1883569

Which we are working on.

> 
>> [...]
>>
>>
>> However, when I working on the first problem, what I think about is a SQL query like:
>>
>> select * from events
>> inner join
>>    ( select max(timestamp) as lasttime from events groupby cpu sortby timestamp where
>>      events.timestamp < xxxxxxx and
>>      events.type == "raw_syscalls:sys_exit"
>>      group by cpu ) X
>> on
>> events.timestamp = X.lasttime and
>> events.cpu = X.cpu and
>> events.type = "raw_syscalls:sys_exit"
>>
>> (I'm not sure whether it works or need some debugging, but I think my idea is expressed.)
> 
> Interesting, and what would the output of such a query look like? Would it be a list of events, but with the "groupby" that would be more like a tree? Like this:
> 
> CPU0
>   |__event 1
>   |__event 2
>   |__...
> CPU1
>   |__event 4
>   |__event 5
>   |__...
> ...
> 
> ?
> 

Correct. Even a flat table with sort and filters enable should be helpful.

> We already have the Event table, on which we can apply filters of this type (timestamp == something && cpu == otherthing...). But we only show the results in the same flat list. I'm not sure what would be best here. Showing results in a separate view, or supporting sub-trees in the base Event table?
> 
> 
> Cheers,
> Alexandre
