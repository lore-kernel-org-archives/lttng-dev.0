From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: [diamon-discuss] My experience on perf,
 CTF and TraceCompass, and some suggection.
Date: Sat, 07 Feb 2015 00:14:51 -0500
Message-ID: <54D59F4B.4060608__49490.7334832989$1423286152$gmane$org@voxpopuli.im>
References: <54C215D6.1030804@huawei.com> <54C2770F.4080305@voxpopuli.im>
 <54CC80CA.2020603@huawei.com> <54D2800B.3050808@voxpopuli.im>
 <54D582E9.4010709@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <alexmonthy@voxpopuli.im>) id 1YJxjN-0007C5-CX
 for lttng-dev@lists.lttng.org; Sat, 07 Feb 2015 00:15:03 -0500
In-Reply-To: <54D582E9.4010709@huawei.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Wang Nan <wangnan0@huawei.com>
Cc: Xinwei Hu <huxinwei@huawei.com>, "diamon-discuss@lists.linuxfoundation.org" <diamon-discuss@lists.linuxfoundation.org>, lttng-dev@lists.lttng.org, tracecompass developer discussions <tracecompass-dev@eclipse.org>
List-Id: lttng-dev@lists.lttng.org

On 2015-02-06 10:13 PM, Wang Nan wrote:
>> I think such an approach could help in all 3 use cases you have presented. What do you think?
>> >
> Good to see you are looking at this problem.
>
> "Frequency analysis" you mentioned is a good viewpoint for finding outliner. However, it should not be the only one we consider. Could you please explain how "frequency analysis" can solve my first problem "finding the reason why most of CPUs are idle by matching syscalls events?"
>
> Thank you!
>

I was thinking of the automatic event matching, for example matching 
syscall_entry_* events with their corresponding syscall_exit_*. This is 
a pre-requisite of doing frequency analysis, but could be useful on its 
own. (Re-reading myself now I notice I didn't mention event matching at 
all, my bad!)

If I understand your first problem correctly, it boils down to wanting 
to identify the system call that is ongoing when a CPU is idle. And this 
is not straightforward, because the Select Next/Previous Event buttons 
in the time graph views will stop at every state transition, like CPU 
idle or IRQs, which are "in the way" of the system call entry event. 
Correct?


Now, what if we had a view that simply lists all the system calls in the 
trace? Each row would contain the complete information of a system call, 
so its start time (timestamp of the sys_entry event), end time 
(timestamp of the sys_exit event), duration, name/id, arguments, return 
value, etc.

And this view could be synchronized with the other ones, where clicking 
on a row would bring you to the corresponding syscall_entry event. And 
inversely, clicking on any timestamp would bring this view to the row 
corresponding to the system call that was active at that time, if there 
is one. I believe this could speed up your problem of identifying the 
running system call for any arbitrary point in the trace.

Also, that view could be re-used for other types of intervals, like 
IRQs, IO operations, and so on. And if the user sorts by the Duration 
column, bam, they have a sorted list of the worst offenders for longer 
system calls, IRQs, etc.


Would this be helpful?

Cheers,
Alexandre
