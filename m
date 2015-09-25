From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RELEASE] LTTng modules 2.7.0 (Linux kernel tracer)
Date: Fri, 25 Sep 2015 17:12:56 +0000 (UTC)
Message-ID: <2042070857.4573.1443201176320.JavaMail.zimbra__43761.4610106268$1443201256$gmane$org@efficios.com>
References: <376912304.4227.1443129182973.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1ZfWYZ-00063F-Lk
 for lttng-dev@lists.lttng.org; Fri, 25 Sep 2015 13:13:13 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 167FD3403E7
 for <lttng-dev@lists.lttng.org>; Fri, 25 Sep 2015 17:13:06 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id xZuQAwtEL41e for <lttng-dev@lists.lttng.org>;
 Fri, 25 Sep 2015 17:12:56 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id A38C03404A3
 for <lttng-dev@lists.lttng.org>; Fri, 25 Sep 2015 17:12:56 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id lHCKxl5XoQcJ for <lttng-dev@lists.lttng.org>;
 Fri, 25 Sep 2015 17:12:56 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
 by mail.efficios.com (Postfix) with ESMTP id 7F6D03403E7
 for <lttng-dev@lists.lttng.org>; Fri, 25 Sep 2015 17:12:56 +0000 (UTC)
In-Reply-To: <376912304.4227.1443129182973.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

----- On Sep 24, 2015, at 5:13 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> Hi,
> 
> I am proud to announce the 2.7.0 release of LTTng modules! LTTng
> modules provide Linux kernel tracing capability to the LTTng 2.x
> tracer toolset. I would like to remind everyone that *no* patching
> of the Linux kernel is required whatsoever to use LTTng modules.
> It has been like this since 2010, but for some reason we still
> get this question.
> 
> Here is what is new and noteworthy in LTTng modules 2.7:
> 
> * Supports Linux kernels up to and including 4.3-rc2,
> 
> * New PID tracker: specify which process IDs you want to trace,
>  (also available with the lttng-ust user-space tracer)
> 
> The new "track" and "untrack" commands allows the tracking of events associated
> with specific PIDs, both in user space and kernel space.
> 
> For example, the following commands may be used to track all kernel events
> of PID "1234":
> 
> $ lttng create my_session
> $ lttng track --kernel --pid 1234
> $ lttng enable-event --kernel --all
> $ lttng start
> 
> 
> * Filtering is now implemented for kernel tracing. It can be used
>  through the same UI and API as with lttng-ust.
> 
> While LTTng-UST has provided support for event filtering for a long time,
> it was not possible to perform kernel-side event filtering until now. As
> of this version, kernel space filters can be used in the same way as user
> space filters.
> 
> For instance, to trace only read() syscalls requesting more than 100 bytes:
> 
> $ lttng create my_session
> $ lttng enable-event --kernel --syscall read --filter "count > 100"
> $ lttng start
> 
> 
> * Added $ctx.cpu_id context for filtering (note: also available in
>  lttng-ust now),
> 
> How to use:
> 
> $ lttng create my_session
> $ lttng enable-event --kernel --all --filter '$ctx.cpu_id<2'
> $ lttng start
> 
> 
> * New clock source plugin support. User-provide clock source
>  override can be provided as a kernel module,
> 
> In the interest of keeping LTTng as unintrusive as possible, LTTng 2.7
> introduces support for platform-specific plug-ins providing custom
> clock sources.
> 
> Clock override plugins, which may be implemented as kernel modules may
> prove useful in cases where direct hardware access to architecture-specific
> clocks is available, and when it should be used in place of the Linux
> kernel Monotonic clock.

I just noticed that the lttng-modules clock plugin feature, developed in
October 2014, was still sitting in my development branch on github, and did
not make it into the 2.7 release. I just merged it into master for 2.8.

Sorry about the confusion,

Thanks,

Mathieu

> 
> 
> * Wildcard support now available: can now specify e.g. 'sched_*'
>  to enable all scheduler events. Similar UI/API as lttng-ust.
> 
> Support for wildcards in event names is another feature that has been brought
> from the user space tracer to the kernel tracer. This means that groups of
> kernel space events can be enabled at once using the wildcard notation.
> Moreover, it makes it possible to enable events belonging to loadable modules
> before said modules are loaded.
> 
> The tracing of all block device or scheduling events can be enabled using a
> single command:
> 
> $ lttng enable-event --kernel 'block_*'
> or
> $ lttng enable-event --kernel 'sched_*'
> 
> Changelog since 2.7.0-rc2:
> 
> 2015-09-24 LTTng modules 2.7.0
>        * Fix: writeback instrumentation update for 4.3 Linux kernel
>        * Fix: update sched wakeup instrumentation for 4.3 kernel
>        * Fix: lttng-test build failure for kernels < 3.0
> 
> Project website: http://lttng.org
> Documentation: http://lttng.org/docs
> Download link: http://lttng.org/download
> 
> Enjoy this release!
> 
> Feedback is welcome,
> 
> Thanks,
> 
> Mathieu
> 
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
