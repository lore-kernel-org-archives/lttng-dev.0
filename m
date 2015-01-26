From: Wang Nan <wangnan0@huawei.com>
Subject: Re: [diamon-discuss] My experience on perf,
 CTF and TraceCompass, and some suggection.
Date: Mon, 26 Jan 2015 12:08:30 +0800
Message-ID: <54C5BDBE.30000__42682.1192763329$1422245411$gmane$org@huawei.com>
References: <54C215D6.1030804@huawei.com> <54C2AB2B.6000105@voxpopuli.im>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from szxga03-in.huawei.com ([119.145.14.66])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <wangnan0@huawei.com>) id 1YFazS-0001QB-CR
 for lttng-dev@lists.lttng.org; Sun, 25 Jan 2015 23:09:36 -0500
In-Reply-To: <54C2AB2B.6000105@voxpopuli.im>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Cc: "diamon-discuss@lists.linuxfoundation.org" <diamon-discuss@lists.linuxfoundation.org>, lttng-dev@lists.lttng.org, tracecompass developer discussions <tracecompass-dev@eclipse.org>
List-Id: lttng-dev@lists.lttng.org

On 2015/1/24 4:12, Alexandre Montplaisir wrote:
> 
> On 01/23/2015 04:35 AM, Wang Nan wrote:
>> [...] I prefer to use:
>>
>>   # perf record -a -e sched:* -e syscalls:* sleep 1
>>
>> However there are some bugs and I have to make some patches. They are
>> posted and being disscussed currently, those bugs are still exist
>> upstream.
> 
> Hmm, I can confirm this problem, when trying to convert a trace taken with these events enabled, I get the following error:
> 
> Failed to add field 'nr
> Failed to add event 'syscalls:sys_enter_io_submit'.
> 
> Good to know it's being looked at!
> 
> 
> But when you say:
> 
>> TraceCompass doesn't recognize syscall:* tracepoints as CPU status
>> changing point. I have to also catch raw_syscall:*, and which doubles
>> the number of samples.
> 
> I assume this was that with your patches applied, so that you could take a trace of the syscall:* tracepoints?
> 
> Do you have a link to those patches somewhere? Or just let us know when it gets integrated upstream. I was trying to update the analysis in Trace Compass to handle syscall:* too, but we can't really do it without knowing how it will look like in CTF format ;)
> 
> 

Hi,

You can follow this thread in LKML:

https://lkml.org/lkml/2015/1/20/330

In https://lkml.org/lkml/2015/1/22/24 , I posted 2 RFC patches can solve the problem.
However I'm still waiting response from Steven Rostedt whether he allow us to improve
traceevent.


> Cheers,
> Alexandre
> 
