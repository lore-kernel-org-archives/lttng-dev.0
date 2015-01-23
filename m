From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: [diamon-discuss] My experience on perf,
 CTF and TraceCompass, and some suggection.
Date: Fri, 23 Jan 2015 15:12:27 -0500
Message-ID: <54C2AB2B.6000105__34524.2772521034$1422043994$gmane$org@voxpopuli.im>
References: <54C215D6.1030804@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <alexmonthy@voxpopuli.im>) id 1YEkaO-0000yy-T2
 for lttng-dev@lists.lttng.org; Fri, 23 Jan 2015 15:12:09 -0500
In-Reply-To: <54C215D6.1030804@huawei.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Wang Nan <wangnan0@huawei.com>
Cc: "diamon-discuss@lists.linuxfoundation.org" <diamon-discuss@lists.linuxfoundation.org>, lttng-dev@lists.lttng.org, tracecompass developer discussions <tracecompass-dev@eclipse.org>
List-Id: lttng-dev@lists.lttng.org


On 01/23/2015 04:35 AM, Wang Nan wrote:
> [...] I prefer to use:
>
>   # perf record -a -e sched:* -e syscalls:* sleep 1
>
> However there are some bugs and I have to make some patches. They are
> posted and being disscussed currently, those bugs are still exist
> upstream.

Hmm, I can confirm this problem, when trying to convert a trace taken 
with these events enabled, I get the following error:

Failed to add field 'nr
Failed to add event 'syscalls:sys_enter_io_submit'.

Good to know it's being looked at!


But when you say:

> TraceCompass doesn't recognize syscall:* tracepoints as CPU status
> changing point. I have to also catch raw_syscall:*, and which doubles
> the number of samples.

I assume this was that with your patches applied, so that you could take 
a trace of the syscall:* tracepoints?

Do you have a link to those patches somewhere? Or just let us know when 
it gets integrated upstream. I was trying to update the analysis in 
Trace Compass to handle syscall:* too, but we can't really do it without 
knowing how it will look like in CTF format ;)


Cheers,
Alexandre
