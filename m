From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: [diamon-discuss] My experience on perf,
 CTF and TraceCompass, and some suggection.
Date: Wed, 04 Feb 2015 15:24:43 -0500
Message-ID: <54D2800B.3050808__20551.7790899195$1423081506$gmane$org@voxpopuli.im>
References: <54C215D6.1030804@huawei.com> <54C2770F.4080305@voxpopuli.im>
 <54CC80CA.2020603@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <alexmonthy@voxpopuli.im>) id 1YJ6Um-0007Ey-HY
 for lttng-dev@lists.lttng.org; Wed, 04 Feb 2015 15:24:22 -0500
In-Reply-To: <54CC80CA.2020603@huawei.com>
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

Hi Wang,

Once again, thanks a lot for this *very* valuable feedback! A good tool 
should be able to help in real-world use cases, like the ones you described.

Right now, Trace Compass is focused on showing information on the time 
scale. Views like the Control Flow and Resource Views are useful when 
you want to look at a particular location of a trace, and want to know 
exactly what the system is doing. However, when you are looking at a 
large trace completely zoomed-out, it's not extremely useful. It should 
be able to point out the "points of interest" in this trace, where the 
user can then zoom in and make use of the time-scale views.

We've been having many discussions internally about adding views on a 
frequency scale, rather than a time scale. For example, a view that 
could aggregate the latency of system calls (or IRQ handlers, or IO 
operations, etc.), and show them either as a histogram or as a point 
cloud, so that it becomes easy to see the "outliers" of the 
distribution. The user could then click on these outliers to be brought 
to the location in the trace where they happened.

These frequency views could provide the missing step of identifying 
points of interest in a trace, after which the user could switch to the 
time-based views to examine the highlighted locations in more details.

I think such an approach could help in all 3 use cases you have 
presented. What do you think?

Also, for known domains like the Linux kernel, we can provide pre-made 
frequency statistics, like system call latencies per syscall type and so 
on. However it would be important to keep it customizable, since we can 
never predict all the use cases that the users will need. That would 
probably be added a bit later though.

We don't have a defined roadmap for the "frequency analysis" right now, 
but we will definitely try to have some working prototypes for our 1.0 
release in June. I will keep you (and these mailing lists) posted!


Some more comments below.


On 01/31/2015 02:14 AM, Wang Nan wrote:
>> This is a gap in the definition of the analysis it seems. I don't remember implementing two types of "syscall" events in the perf analysis, so it should just be a matter of getting the exact event name and adding it to the list. I will take a look and keep you posted!
>>
>>> Finally I found the syscall which cause idle. However I need to write a
>>> script to do statistics. TraceCompass itself is lack a mean to count
>>> different events in my way.
>> Could you elaborate on this please? I agree the "Statistics" view in TC is severely lacking, we could be gathering and displaying much more information. The only question is what information would actually be useful.
> I'd like to describe some cases of ad-hoc statisics, which I have to write python
> scripts to do.
>
> *First case: matching sys_enter and sys_exit*
>
> The first case is to find the reason why most of CPUs are idle. From TraceCompass
> resource view, I find some gray gaps for about 300us. During these gaps, there is only
> 1 running CPU, all other CPUs are idle. I can find the reason why a particular CPU
> is idle using TraceCompass with following steps:
>
>    1. In TraceCompass resource view, click the idle gap of that CPU, find next event
>       with the 'Select Next Event' button, continous select next event until find
>       a 'raw_syscalls:sys_exit' event, then by checking 'id' field I can find what syscall
>       cause the CPU idle. (I have mentioned before, that in my case, each time when I click
>       that button, I have to wait for 8 to 10 seconds for the trace table update so I can kown
>       which event it is. This is painful for me...)

Yes, this was because the perf-CTF traces put all their content in one 
big packet. I think this is being worked on, right?

As for the missing system call names, we have 
https://bugs.eclipse.org/bugs/show_bug.cgi?id=453361 opened about it. It 
should be possible to give knowledge of the id's to the analysis so that 
it makes it easier to identify the system call type.

>
>    2. Then I need to find corresponding "raw_syscalls:sys_enter" event to see when the syscall
>       is issued. I switch to control flow view then use 'Select Previous Event' to find it, then
>       back to resource view I can understand how long this syscall takes, whether the CPU
>       does some work or simply idle after the syscall is issued, and whether the task is scheduled
>       across CPUs.
>
>    3. For each CPU do step 1 and step 2.
>
> In some high-end servers the number of cores may exceeds 100. Even in my case the number of traced
> CPUs is 32. Doing such searching is time consuming. I have to write a python script to do that.
> My result is: half of cores are waiting on different futexs, half of then are waiting on
> pselect() (caused by sleep()).
>
> *Second case: matching futex WAKE and WAIT*
>
> Therefore the next case I'd like to share is to maching futex wait, futex wakeup and futex waken
> events. This time TraceCompass can't help much. However, the python script is also not very easy
> to design. I have to track CPU and process state transition by myself, match all futex sys_enter
> and sys_exit events, consider different cases including FUTEX_WAKE before FUTEX_WAIT, failures,
> timeout and compare retval of futex wake and the number of threads waken by it. This
> disposable python script has 115 lines of code (I have to admit that I'm not a very good python
> programmer), I create and debug it for serval hours.
>
> My final result is: threads wakeup each other in a tree-like manner. The first futex WAKE command is
> issued by the only running CPU, wakeup only one thread. It wakeups others, other wakeup more, finally
> nearly all CPUs are wakenup. There are some threads get executed after a relative long time
> after the corresponding futex WAKE command, even if there are idle CPUs at that time. Therefore we
> should look into scheduler. However, the gap itself should be a normal phenomenon.
>
> *Third case: device utilization*
>
> We have a high-speed storage device, but writing to filesystems on it is not as fast as we expected.
> I deploy serval tracepoints at device driver to track device activities. However, I have to create
> some tools to draw cumulative curve and speed curve to find whether there is irregular idle. I use
> gnuplot for ploting, but have to write another python script to extrace data. I think languages like
> R should be useful in this case but I'm not familiary with it.
>
> *Conclusion*
>
> In this email I list 3 use cases related to Ad-Hoc statistics I mentioned earlier. Case 1 and 2 are
> in fact not a statistics problem. They should be considered as query problems. I suspect case
> 1 and 2 can be expressed using SQL. If TraceCompass can provide a query language like SQL, we can quickly
> find the information we need to know so will have more time for tuning. I expressed my SQL-like query
> idea on one of my early email:
>
> http://lists.linuxfoundation.org/pipermail/diamon-discuss/2014-November/000003.html
>
> However I was not very sure the query problem we would meet.
>
> Case 3 requires a plotting tool like gnuplot or R. I don't know whether TraceCompass designers want to
> integrate such function, but at lease TraceCompass should export data for those tools.

Right now we use the SWTChart library (http://swtchart.org/) for 
outputting graphs like the CPU Usage graph, the UST memory usage view, a 
prototype of the Histogram, and a couple others. We had also thought 
that we should provide an easy way to export the graphs, like 
right-click -> export to PNG/SVG, etc.

But internally, what we provide to SWTChart is basically an array of 
double's. So it should be easy to have an internal abstraction layer 
that can export either to an SWTChart view, or to a text file to be read 
by R or Gnuplot and so on, if such a feature is deemed useful.


Cheers,
Alexandre

>
> In case 1 and 2, I spent a lot of time to analyze a phenomenon which is finally shown to be normal.
> I think this should be common in real performance analysis and tuning tasks. Many ideas may
> appear after the first trace is collected. I think tools like TraceCompass should consider a
> way to reduce the cost of trials and error.
>
> Thank you for reading this!
>
>
