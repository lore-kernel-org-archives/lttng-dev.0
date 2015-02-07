From: Wang Nan <wangnan0@huawei.com>
Subject: Re: [diamon-discuss] My experience on perf,
 CTF and TraceCompass, and some suggection.
Date: Sat, 7 Feb 2015 15:25:01 +0800
Message-ID: <54D5BDCD.5040407__4874.64281400225$1423294069$gmane$org@huawei.com>
References: <54C215D6.1030804@huawei.com> <54C2770F.4080305@voxpopuli.im>
 <54CC80CA.2020603@huawei.com> <54D2800B.3050808@voxpopuli.im>
 <54D582E9.4010709@huawei.com> <54D59F4B.4060608@voxpopuli.im>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from szxga02-in.huawei.com ([119.145.14.65])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <wangnan0@huawei.com>) id 1YJznF-00080g-Q0
 for lttng-dev@lists.lttng.org; Sat, 07 Feb 2015 02:27:09 -0500
In-Reply-To: <54D59F4B.4060608@voxpopuli.im>
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

On 2015/2/7 13:14, Alexandre Montplaisir wrote:
> On 2015-02-06 10:13 PM, Wang Nan wrote:
>>> I think such an approach could help in all 3 use cases you have presented. What do you think?
>>> >
>> Good to see you are looking at this problem.
>>
>> "Frequency analysis" you mentioned is a good viewpoint for finding outliner. However, it should not be the only one we consider. Could you please explain how "frequency analysis" can solve my first problem "finding the reason why most of CPUs are idle by matching syscalls events?"
>>
>> Thank you!
>>
> 
> I was thinking of the automatic event matching, for example matching syscall_entry_* events with their corresponding syscall_exit_*. This is a pre-requisite of doing frequency analysis, but could be useful on its own. (Re-reading myself now I notice I didn't mention event matching at all, my bad!)
> 
> If I understand your first problem correctly, it boils down to wanting to identify the system call that is ongoing when a CPU is idle. And this is not straightforward, because the Select Next/Previous Event buttons in the time graph views will stop at every state transition, like CPU idle or IRQs, which are "in the way" of the system call entry event. Correct?
> 
> 
> Now, what if we had a view that simply lists all the system calls in the trace? Each row would contain the complete information of a system call, so its start time (timestamp of the sys_entry event), end time (timestamp of the sys_exit event), duration, name/id, arguments, return value, etc.
> 
> And this view could be synchronized with the other ones, where clicking on a row would bring you to the corresponding syscall_entry event. And inversely, clicking on any timestamp would bring this view to the row corresponding to the system call that was active at that time, if there is one. I believe this could speed up your problem of identifying the running system call for any arbitrary point in the trace.
> 
> Also, that view could be re-used for other types of intervals, like IRQs, IO operations, and so on. And if the user sorts by the Duration column, bam, they have a sorted list of the worst offenders for longer system calls, IRQs, etc.
> 
> 
> Would this be helpful?
> 

Correct, it should be helpful. If I understand your description correctly, you are thinking another time
chart view like resource view and control flow view, this time each row is a syscall, like this:

         <-------- time -------->
          /-------------------
sys_write |      ***
          +-------------------
sys_read  |   ***        ****
          +-------------------
sys_poll  |  **************
          +-------------------
.................

And it will be synchronized with other ones. So if I click on the idle area on resource view, then switch
to this new view, I can realize which syscall is ongoing at that time.

However, unlike CPUs, types of syscalls are not stateful entities. If we are going to draw such diagram, it should looks like:

                    <-------- time -------->
                     /-------------------
sys_write(pid: 1234) |      ***
                     +-------------------
sys_write(pid: 5678) |
                     +-------------------
sys_read(pid: 5678)  |              ****
                     +-------------------
sys_read(pid: 4321)  |    ****
                     +------------------
sys_poll(pid: 1212)  |      *******
                     +-------------------
sys_poll(pid: 1213)  |  **************
                     +-------------------
sys_poll(pid: 1214)  |   *****
                     +-------------------
.................

We must draw one raw for each syscall (there are hundreds of then) issued by each pid (also hundreds of).
This view will be extremely large and sparse and we should have a mean to sort them for finding meanful
rows at a specific time. But correct, it is still useful.

We can also aggregate same syscalls, use different color to express how many procedures are ongoing at that
time, like this:

         <-------- time -------->
          /-------------------
sys_write |      ~~~
          +-------------------
sys_read  |    ~~~~      ~~~~
          +------------------
sys_poll  |  ~~~~==!!====~~~
          +-------------------
.................

Is your "frequency analysis" something like that?



However, when I working on the first problem, what I think about is a SQL query like:

select * from events
inner join
  ( select max(timestamp) as lasttime from events groupby cpu sortby timestamp where
    events.timestamp < xxxxxxx and
    events.type == "raw_syscalls:sys_exit"
    group by cpu ) X
on
events.timestamp = X.lasttime and
events.cpu = X.cpu and
events.type = "raw_syscalls:sys_exit"

(I'm not sure whether it works or need some debugging, but I think my idea is expressed.)

I think query like that should be more expressive than timechart (but yes, SQL is not suitable
for query events). Think about my 'matching futex WAIT and WAKE' then, I must first define my
futex model use XML, then pass it to TraceCompass, reprocess the trace then I can open the new
view.

> Cheers,
> Alexandre
