From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [diamon-discuss] My experience on perf,
 CTF and TraceCompass, and some suggection.
Date: Sat, 7 Feb 2015 13:22:46 +0000 (UTC)
Message-ID: <19588692.89521.1423315366336.JavaMail.zimbra__21085.2598924705$1423315405$gmane$org@efficios.com>
References: <54C215D6.1030804@huawei.com> <54C2770F.4080305@voxpopuli.im>
 <54CC80CA.2020603@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1YK5LS-0001Y5-Al
 for lttng-dev@lists.lttng.org; Sat, 07 Feb 2015 08:22:49 -0500
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
Cc: Xinwei Hu <huxinwei@huawei.com>, diamon-discuss@lists.linuxfoundation.org, lttng-dev@lists.lttng.org, tracecompass developer discussions <tracecompass-dev@eclipse.org>
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Wang Nan" <wangnan0@huawei.com>
> To: "Alexandre Montplaisir" <alexmonthy@voxpopuli.im>
> Cc: "Xinwei Hu" <huxinwei@huawei.com>, diamon-discuss@lists.linuxfoundation.org, lttng-dev@lists.lttng.org,
> "tracecompass developer discussions" <tracecompass-dev@eclipse.org>
> Sent: Saturday, January 31, 2015 2:14:18 AM
> Subject: Re: [diamon-discuss] My experience on perf, CTF and TraceCompass, and some suggection.
> 
> 
> > This is a gap in the definition of the analysis it seems. I don't remember
> > implementing two types of "syscall" events in the perf analysis, so it
> > should just be a matter of getting the exact event name and adding it to
> > the list. I will take a look and keep you posted!
> > 
> >> Finally I found the syscall which cause idle. However I need to write a
> >> script to do statistics. TraceCompass itself is lack a mean to count
> >> different events in my way.
> > 
> > Could you elaborate on this please? I agree the "Statistics" view in TC is
> > severely lacking, we could be gathering and displaying much more
> > information. The only question is what information would actually be
> > useful.
> 
> I'd like to describe some cases of ad-hoc statisics, which I have to write
> python
> scripts to do.
> 
> *First case: matching sys_enter and sys_exit*
> 
> The first case is to find the reason why most of CPUs are idle. From
> TraceCompass
> resource view, I find some gray gaps for about 300us. During these gaps,
> there is only
> 1 running CPU, all other CPUs are idle. I can find the reason why a
> particular CPU
> is idle using TraceCompass with following steps:
> 
>   1. In TraceCompass resource view, click the idle gap of that CPU, find next
>   event
>      with the 'Select Next Event' button, continous select next event until
>      find
>      a 'raw_syscalls:sys_exit' event, then by checking 'id' field I can find
>      what syscall
>      cause the CPU idle. (I have mentioned before, that in my case, each time
>      when I click
>      that button, I have to wait for 8 to 10 seconds for the trace table
>      update so I can kown
>      which event it is. This is painful for me...)

For this use-case, I think the kind of analysis you need is a "critical path
analysis", which can identify what made each task you care about block during
your time range. See work published by Francis Giraldeau on this topic.

CPU being idle is a side-effect of the tasks being blocked. If you would have
a lesser priority task running in the background, that task would run instead
of the CPU idle loop. Therefore, the idle CPU is really just a side-effect, not
a cause.

Thanks!

Mathieu

> 
>   2. Then I need to find corresponding "raw_syscalls:sys_enter" event to see
>   when the syscall
>      is issued. I switch to control flow view then use 'Select Previous
>      Event' to find it, then
>      back to resource view I can understand how long this syscall takes,
>      whether the CPU
>      does some work or simply idle after the syscall is issued, and whether
>      the task is scheduled
>      across CPUs.
> 
>   3. For each CPU do step 1 and step 2.
> 
> In some high-end servers the number of cores may exceeds 100. Even in my case
> the number of traced
> CPUs is 32. Doing such searching is time consuming. I have to write a python
> script to do that.
> My result is: half of cores are waiting on different futexs, half of then are
> waiting on
> pselect() (caused by sleep()).
> 
> *Second case: matching futex WAKE and WAIT*
> 
> Therefore the next case I'd like to share is to maching futex wait, futex
> wakeup and futex waken
> events. This time TraceCompass can't help much. However, the python script is
> also not very easy
> to design. I have to track CPU and process state transition by myself, match
> all futex sys_enter
> and sys_exit events, consider different cases including FUTEX_WAKE before
> FUTEX_WAIT, failures,
> timeout and compare retval of futex wake and the number of threads waken by
> it. This
> disposable python script has 115 lines of code (I have to admit that I'm not
> a very good python
> programmer), I create and debug it for serval hours.
> 
> My final result is: threads wakeup each other in a tree-like manner. The
> first futex WAKE command is
> issued by the only running CPU, wakeup only one thread. It wakeups others,
> other wakeup more, finally
> nearly all CPUs are wakenup. There are some threads get executed after a
> relative long time
> after the corresponding futex WAKE command, even if there are idle CPUs at
> that time. Therefore we
> should look into scheduler. However, the gap itself should be a normal
> phenomenon.
> 
> *Third case: device utilization*
> 
> We have a high-speed storage device, but writing to filesystems on it is not
> as fast as we expected.
> I deploy serval tracepoints at device driver to track device activities.
> However, I have to create
> some tools to draw cumulative curve and speed curve to find whether there is
> irregular idle. I use
> gnuplot for ploting, but have to write another python script to extrace data.
> I think languages like
> R should be useful in this case but I'm not familiary with it.
> 
> *Conclusion*
> 
> In this email I list 3 use cases related to Ad-Hoc statistics I mentioned
> earlier. Case 1 and 2 are
> in fact not a statistics problem. They should be considered as query
> problems. I suspect case
> 1 and 2 can be expressed using SQL. If TraceCompass can provide a query
> language like SQL, we can quickly
> find the information we need to know so will have more time for tuning. I
> expressed my SQL-like query
> idea on one of my early email:
> 
> http://lists.linuxfoundation.org/pipermail/diamon-discuss/2014-November/000003.html
> 
> However I was not very sure the query problem we would meet.
> 
> Case 3 requires a plotting tool like gnuplot or R. I don't know whether
> TraceCompass designers want to
> integrate such function, but at lease TraceCompass should export data for
> those tools.
> 
> In case 1 and 2, I spent a lot of time to analyze a phenomenon which is
> finally shown to be normal.
> I think this should be common in real performance analysis and tuning tasks.
> Many ideas may
> appear after the first trace is collected. I think tools like TraceCompass
> should consider a
> way to reduce the cost of trials and error.
> 
> Thank you for reading this!
> 
> 
> _______________________________________________
> diamon-discuss mailing list
> diamon-discuss@lists.linuxfoundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/diamon-discuss
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
